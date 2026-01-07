# Production configuration


This is a guide to the recommended configuration for a production Vendure application.

## Environment variables​


[​](#environment-variables)Keep sensitive information or context-dependent settings in environment variables. In local development you can store the values in a .env file. For production, you should use the mechanism provided by your hosting platform to set the values for production.

The default @vendure/create project scaffold makes use of environment variables already. For example:

```
const IS_DEV = process.env.APP_ENV === 'dev';
```

The APP_ENV environment variable can then be set using the admin dashboard of your hosting provider:

If you are using Docker or Kubernetes, they include their own methods of setting environment variables.

[Docker or Kubernetes](/guides/deployment/using-docker)
## Superadmin credentials​


[​](#superadmin-credentials)Ensure you set the superadmin credentials to something other than the default of superadmin:superadmin. Use your hosting platform's environment variables to set a strong password for the Superadmin account.

```
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {  authOptions: {    tokenMethod: ['bearer', 'cookie'],    superadminCredentials: {      identifier: process.env.SUPERADMIN_USERNAME,      password: process.env.SUPERADMIN_PASSWORD,    },  },  // ...};
```

## API hardening​


[​](#api-hardening)It is recommended that you install and configure the HardenPlugin for all production deployments. This plugin locks down your schema (disabling introspection and field suggestions) and protects your Shop API against malicious queries that could otherwise overwhelm your server.

[HardenPlugin](/reference/core-plugins/harden-plugin/)Install the plugin:

```
npm install @vendure/harden-plugin# oryarn add @vendure/harden-plugin

```

Then add it to your VendureConfig:

```
import { VendureConfig } from '@vendure/core';import { HardenPlugin } from '@vendure/harden-plugin';const IS_DEV = process.env.APP_ENV === 'dev';export const config: VendureConfig = {  // ...  plugins: [    HardenPlugin.init({      maxQueryComplexity: 500,      apiMode: IS_DEV ? 'dev' : 'prod',    }),    // ...  ]};
```

For a detailed explanation of how to best configure this plugin, see the HardenPlugin docs.

[HardenPlugin docs](/reference/core-plugins/harden-plugin/)
## ID Strategy​


[​](#id-strategy)By default, Vendure uses auto-increment integer IDs as entity primary keys. While easier to work with in development, sequential primary keys can leak information such as the number of orders or customers in the system.

For this reason you should consider using the UuidIdStrategy for production.

```
import { UuidIdStrategy, VendureConfig } from '@vendure/core';export const config: VendureConfig = {    entityOptions: {        entityIdStrategy: new UuidIdStrategy(),    },    // ...}
```

Another option, if you wish to stick with integer IDs, is to create a custom EntityIdStrategy which uses the encodeId() and decodeId() methods to obfuscate the sequential nature of the ID.

[EntityIdStrategy](/reference/typescript-api/configuration/entity-id-strategy/)
## Database Timezone​


[​](#database-timezone)Vendure internally treats all dates & times as UTC. However, you may sometimes run into issues where dates are offset by some fixed amount of hours. E.g. you place an order at 17:00, but it shows up in the Dashboard as being placed at 19:00. Typically, this is caused by the timezone of your database not being set to UTC.

You can check the timezone in MySQL/MariaDB by executing:

```
SELECT TIMEDIFF(NOW(), UTC_TIMESTAMP);
```

and you should expect to see 00:00:00.

In Postgres, you can execute:

```
show timezone;
```

and you should expect to see UTC or Etc/UTC.

## Trust proxy​


[​](#trust-proxy)When deploying your Vendure application behind a reverse proxy (usually the case with most hosting services), consider configuring Express's trust proxy setting. This allows you to retrieve the original IP address from the X-Forwarded-For header, which proxies use to forward the client's IP address.

You can set the trustProxy option in your VendureConfig:

```
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    apiOptions: {        trustProxy: 1, // Trust the first proxy in front of your app    },};
```

For more details on configuring trust proxy, refer to the Express documentation.

[Express documentation](https://expressjs.com/en/guide/behind-proxies.html)
## Security Considerations​


[​](#security-considerations)Please read over the Security section of the Developer Guide for more information on how to secure your Vendure application.

[Security](/guides/developer-guide/security)

---

# Using Docker


Docker is a technology which allows you to run your Vendure application inside a container.
The default installation with @vendure/create includes a sample Dockerfile:

[Docker](https://docs.docker.com/)[container](https://docs.docker.com/get-started/#what-is-a-container)
```
FROM node:22WORKDIR /usr/src/appCOPY package.json ./COPY package-lock.json ./ RUN npm install --productionCOPY . .RUN npm run build
```

This Dockerfile can then be built into an "image" using:

```
docker build -t vendure .
```

This same image can be used to run both the Vendure server and the worker:

```
# Run the serverdocker run -dp 3000:3000 --name vendure-server vendure npm run start:server# Run the workerdocker run -dp 3000:3000 --name vendure-worker vendure npm run start:worker

```

Here is a breakdown of the command used above:

- docker run - run the image we created with docker build
- -dp 3000:3000 - the -d flag means to run in "detached" mode, so it runs in the background and does not take control of your terminal. -p 3000:3000 means to expose port 3000 of the container (which is what Vendure listens on by default) as port 3000 on your host machine.
- --name vendure-server - we give the container a human-readable name.
- vendure - we are referencing the tag we set up during the build.
- npm run start:server - this last part is the actual command that should be run inside the container.

## Docker Compose​


[​](#docker-compose)Managing multiple docker containers can be made easier using Docker Compose. In the below example, we use
the same Dockerfile defined above, and we also define a Postgres database to connect to:

[Docker Compose](https://docs.docker.com/compose/)
```
version: "3"services:  server:    build:      context: .      dockerfile: Dockerfile    ports:      - 3000:3000    command: ["npm", "run", "start:server"]    volumes:      - /usr/src/app    environment:      DB_HOST: database      DB_PORT: 5432      DB_NAME: vendure      DB_USERNAME: postgres      DB_PASSWORD: password  worker:    build:      context: .      dockerfile: Dockerfile    command: ["npm", "run", "start:worker"]    volumes:      - /usr/src/app    environment:      DB_HOST: database      DB_PORT: 5432      DB_NAME: vendure      DB_USERNAME: postgres      DB_PASSWORD: password  database:    image: postgres    volumes:      - /var/lib/postgresql/data    ports:      - 5432:5432    environment:      POSTGRES_PASSWORD: password      POSTGRES_DB: vendure
```

## Kubernetes​


[​](#kubernetes)Kubernetes is used to manage multiple containerized applications.
This deployment starts the shop container we created above as both worker and server.

[Kubernetes](https://kubernetes.io/)
```
apiVersion: apps/v1kind: Deploymentmetadata:  name: vendure-shopspec:  selector:    matchLabels:      app: vendure-shop  replicas: 1  template:    metadata:      labels:        app: vendure-shop    spec:      containers:        - name: server          image: vendure-shop:latest          command:            - node          args:            - "dist/index.js"          env:          # your env config here          ports:            - containerPort: 3000        - name: worker          image: vendure-shop:latest          imagePullPolicy: Always          command:            - node          args:            - "dist/index-worker.js"          env:          # your env config here          ports:            - containerPort: 3000

```

## Health/Readiness Checks​


[​](#healthreadiness-checks)If you wish to deploy with Kubernetes or some similar system, you can make use of the health check endpoints.

### Server​


[​](#server)This is a regular REST route (note: not GraphQL), available at /health.

```
REQUEST: GET http://localhost:3000/health
```

```
{  "status": "ok",  "info": {    "database": {      "status": "up"    }  },  "error": {},  "details": {    "database": {      "status": "up"    }  }}
```

Health checks are built on the Nestjs Terminus module. You can also add your own health checks by creating plugins that make use of the HealthCheckRegistryService.

[Nestjs Terminus module](https://docs.nestjs.com/recipes/terminus)[HealthCheckRegistryService](/reference/typescript-api/health-check/health-check-registry-service/)
### Worker​


[​](#worker)Although the worker is not designed as an HTTP server, it contains a minimal HTTP server specifically to support HTTP health checks. To enable this, you need to call the startHealthCheckServer() method after bootstrapping the worker:

```
bootstrapWorker(config)    .then(worker => worker.startJobQueue())    .then(worker => worker.startHealthCheckServer({ port: 3020 }))    .catch(err => {        console.log(err);    });
```

This will make the /health endpoint available. When the worker instance is running, it will return the following:

```
REQUEST: GET http://localhost:3020/health
```

```
{  "status": "ok"}
```


---

# Horizontal scaling


"Horizontal scaling" refers to increasing the performance capacity of your application by running multiple instances.

This type of scaling has two main advantages:

- It can enable increased throughput (requests/second) by distributing the incoming requests between multiple instances.
- It can increase resilience because if a single instance fails, the other instances will still be able to service requests.

As discussed in the Server resource requirements guide, horizontal scaling can be the most cost-effective way of deploying your Vendure server due to the single-threaded nature of Node.js.

[Server resource requirements guide](/guides/deployment/server-resource-requirements)In Vendure, both the server and the worker can be scaled horizontally. Scaling the server will increase the throughput of the GraphQL APIs, whereas scaling the worker can increase the speed with which the job queue is processed by allowing more jobs to be run in parallel.

## Multi-instance configuration​


[​](#multi-instance-configuration)In order to run Vendure in a multi-instance configuration, there are some important configuration changes you'll need to make. The key consideration in configuring Vendure for this scenario is to ensure that any persistent state is managed externally from the Node process, and is shared by all instances. Namely:

- The JobQueue should be stored externally using the DefaultJobQueuePlugin (which stores jobs in the database) or the BullMQJobQueuePlugin (which stores jobs in Redis), or some other custom JobQueueStrategy. Note: the BullMQJobQueuePlugin is much more efficient than the DefaultJobQueuePlugin, and is recommended for production applications.
- An appropriate CacheStrategy must be used which stores the cache externally. Both the DefaultCachePlugin and the RedisCachePlugin are suitable
for multi-instance setups. The DefaultCachePlugin uses the database to store the cache data, which is simple and effective, while the RedisCachePlugin uses a Redis server to store the cache data and can have better performance characteristics.
- If you are on a version prior to v3.1, a custom SessionCacheStrategy must be used which stores the session cache externally (such as in the database or Redis), since the default strategy stores the cache in-memory and will cause inconsistencies in multi-instance setups. Example Redis-based SessionCacheStrategy.
From v3.1 the session cache is handled by the underlying cache strategy, so you normally don't need to define a custom SessionCacheStrategy.
- When using cookies to manage sessions, make sure all instances are using the same cookie secret:
src/vendure-config.tsconst config: VendureConfig = {  authOptions: {    cookieOptions: {      secret: 'some-secret'    }  }}
- Channel and Zone data gets cached in-memory as this data is used in virtually every request. The cache time-to-live defaults to 30 seconds, which is probably fine for most cases, but it can be configured in the EntityOptions.

[DefaultJobQueuePlugin](/reference/typescript-api/job-queue/default-job-queue-plugin/)[BullMQJobQueuePlugin](/reference/core-plugins/job-queue-plugin/bull-mqjob-queue-plugin)[CacheStrategy](/reference/typescript-api/cache/cache-strategy/)[DefaultCachePlugin](/reference/typescript-api/cache/default-cache-plugin/)[RedisCachePlugin](/reference/typescript-api/cache/redis-cache-plugin/)[SessionCacheStrategy](/reference/typescript-api/auth/session-cache-strategy/)[Example Redis-based SessionCacheStrategy](/reference/typescript-api/auth/session-cache-strategy/)
```
const config: VendureConfig = {  authOptions: {    cookieOptions: {      secret: 'some-secret'    }  }}
```

[EntityOptions](/reference/typescript-api/configuration/entity-options/#channelcachettl)
## Using Docker or Kubernetes​


[​](#using-docker-or-kubernetes)One way of implementing horizontal scaling is to use Docker to wrap your Vendure server & worker in a container, which can then be run as multiple instances.

Some hosting providers allow you to provide a Docker image and will then run multiple instances of that image. Kubernetes can also be used to manage multiple instances
of a Docker image.

For a more complete guide, see the Using Docker guide.

[Using Docker guide](/guides/deployment/using-docker)
## Using PM2​


[​](#using-pm2)PM2 is a process manager which will spawn multiple instances of your server or worker, as well as re-starting any instances that crash. PM2 can be used on VPS hosts to manage multiple instances of Vendure without needing Docker or Kubernetes.

[PM2](https://pm2.keymetrics.io/)PM2 must be installed on your server:

```
npm install pm2@latest -g
```

Your processes can then be run in cluster mode with the following command:

[cluster mode](https://pm2.keymetrics.io/docs/usage/cluster-mode/)
```
pm2 start ./dist/index.js -i 4
```

The above command will start a cluster of 4 instances. You can also instruct PM2 to use the maximum number of available CPUs with -i max.

Note that if you are using pm2 inside a Docker container, you should use the pm2-runtime command:

```
# ... your existing Dockerfile configRUN npm install pm2 -gCMD ["pm2-runtime", "app.js", "-i", "max"]

```


---

# Getting data into production


Once you have set up your production deployment, you'll need some way to get your products and other data into the system.

The main tasks will be:

- Creation of the database schema
- Importing initial data like roles, tax rates, countries etc.
- Importing catalog data like products, variants, options, facets
- Importing other data used by your application

## Creating the database schema​


[​](#creating-the-database-schema)The first item - creation of the schema - can be automatically handled by TypeORM's synchronize feature. Switching it on for the initial
run will automatically create the schema. This can be done by using an environment variable:

```
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    dbConnectionOptions: {        type: 'postgres',        synchronize: process.env.DB_SYNCHRONIZE,        host: process.env.DB_HOST,        port: process.env.DB_PORT,        username: process.env.DB_USER,        password: process.env.DB_PASSWORD,        database: process.env.DB_DATABASE,    },    // ...};
```

Set the DB_SYNCHRONIZE variable to true on first start, and then after the schema is created, set it to false.

## Importing initial & catalog data​


[​](#importing-initial--catalog-data)Importing initial and catalog data can be handled by Vendure populate() helper function - see the Importing Product Data guide.

[Importing Product Data guide](/guides/developer-guide/importing-data/)
## Importing other data​


[​](#importing-other-data)Any kinds of data not covered by the populate() function can be imported using a custom script, which can use any Vendure service or service defined by your custom plugins to populate data in any way you like. See the Stand-alone scripts guide.

[Stand-alone scripts guide](/guides/developer-guide/stand-alone-scripts/)


---

# Server resource requirements


## Server resource requirements​


[​](#server-resource-requirements)
### RAM​


[​](#ram)The Vendure server and worker process each use around 200-300MB of RAM when idle. This figure will increase under load.

The total RAM required by a single instance of the server depends on your project size (the number of products, variants, customers, orders etc.) as well as expected load (the number of concurrent users you expect). As a rule, 512MB per process would be a practical minimum for a smaller project with low expected load.

### CPU​


[​](#cpu)CPU resources are generally measured in "cores" or "vCPUs" (virtual CPUs) depending on the type of hosting. The exact relationship between vCPUs and physical CPU cores is out of the scope of this guide, but for our purposes we will use "CPU" to refer to both physical and virtual CPU resources.

Because Node.js is single-threaded, a single instance of the Vendure server or worker will not be able to take advantage of multiple CPUs. For example, if you set up a server instance running with 4 CPUs, the server will only use 1 of those CPUs and the other 3 will be wasted.

Therefore, when looking to optimize performance (for example, the number of requests that can be serviced per second), it makes sense to scale horizontally by running multiple instances of the Vendure server. See the Horizontal Scaling guide.

[Horizontal Scaling guide](/guides/deployment/horizontal-scaling)
## Load testing​


[​](#load-testing)It is important to test whether your current server configuration will be able to handle the loads you expect when you go into production. There are numerous tools out there to help you load test your application, such as:

- k6
- Artillery
- jMeter

[k6](https://k6.io/)[Artillery](https://www.artillery.io/)[jMeter](https://jmeter.apache.org/)


---

# Deploying the Admin UI


## Compiling the Admin UI​


[​](#compiling-the-admin-ui)If you have customized the Admin UI with extensions, you should compile your custom Admin UI app ahead of time
before deploying it. This will bundle the app into a set of static files which are then served by the AdminUiPlugin.

- Guide: Compiling the Admin UI as a deployment step.

[Guide: Compiling the Admin UI as a deployment step](/guides/extending-the-admin-ui/getting-started/#compiling-as-a-deployment-step)It is not recommended to compile the Admin UI on the server at runtime, as this can be slow and resource-intensive.
Instead, compile the Admin UI ahead of time and deploy the compiled assets, as covered in the guide linked above.

## Setting the API host & port​


[​](#setting-the-api-host--port)When running in development mode, the Admin UI app will "guess" the API host and port based on the current URL in the browser. Typically, this will
be http://localhost:3000. For production deployments where the Admin UI app is served from a different host or port than the Vendure server, you'll need to
configure the Admin UI app to point to the correct API host and port.

```
import { VendureConfig } from '@vendure/core';import { AdminUiPlugin } from '@vendure/admin-ui-plugin';const config: VendureConfig = {    // ...    plugins: [        AdminUiPlugin.init({            port: 3001,            route: 'admin',            adminUiConfig: {                apiHost: 'https://api.example.com',                apiPort: 443,            },        }),    ],};
```

## Deploying a stand-alone Admin UI​


[​](#deploying-a-stand-alone-admin-ui)Usually, the Admin UI is served from the Vendure server via the AdminUiPlugin. However, you may wish to deploy the Admin UI app elsewhere. Since it is just a static Angular app, it can be deployed to any static hosting service such as Vercel or Netlify.

#### Metrics​


[​](#metrics)The AdminUiPlugin not only serves the Admin UI app, but also provides a metricSummary query which is used to display the order metrics on the dashboard. If you wish to deploy the Admin UI app stand-alone (not served by the AdminUiPlugin), but still want to display the metrics on the dashboard, you'll need to include the AdminUiPlugin in your server's plugins array, but do not call init():

```
import { AdminUiPlugin } from '@vendure/admin-ui-plugin';const config: VendureConfig = {    plugins: [        AdminUiPlugin, // <== include the plugin, but don't call init()    ],    // ...};
```

#### Example Script​


[​](#example-script)Here's an example script that can be run as part of your host's build command, which will generate a stand-alone app bundle and configure it to point to your remote server API.

This example is for Vercel, and assumes:

- A BASE_HREF environment variable to be set to /
- A public (output) directory set to build/dist
- A build command set to npm run build or yarn build
- A package.json like this:
package.json{  "name": "standalone-admin-ui",  "version": "0.1.0",  "private": true,  "scripts": {    "build": "ts-node compile.ts"  },  "devDependencies": {    "@vendure/ui-devkit": "^1.4.5",    "ts-node": "^10.2.1",    "typescript": "~4.3.5"  }}

```
{  "name": "standalone-admin-ui",  "version": "0.1.0",  "private": true,  "scripts": {    "build": "ts-node compile.ts"  },  "devDependencies": {    "@vendure/ui-devkit": "^1.4.5",    "ts-node": "^10.2.1",    "typescript": "~4.3.5"  }}
```

```
import { compileUiExtensions } from '@vendure/ui-devkit/compiler';import { DEFAULT_BASE_HREF } from '@vendure/ui-devkit/compiler/constants';import path from 'path';import { promises as fs } from 'fs';/** * Compiles the Admin UI. If the BASE_HREF is defined, use that. * Otherwise, go back to the default admin route. */compileUiExtensions({    outputPath: path.join(__dirname, 'build'),    baseHref: process.env.BASE_HREF ?? DEFAULT_BASE_HREF,    extensions: [        /* any UI extensions would go here, or leave empty */    ],})    .compile?.()    .then(() => {        // If building for Vercel deployment, replace the config to make         // api calls to api.example.com instead of localhost.        if (process.env.VERCEL) {            console.log('Overwriting the vendure-ui-config.json for Vercel deployment.');            return fs.writeFile(                path.join(__dirname, 'build', 'dist', 'vendure-ui-config.json'),                JSON.stringify({                    apiHost: 'https://api.example.com',                    apiPort: '443',                    adminApiPath: 'admin-api',                    tokenMethod: 'cookie',                    defaultLanguage: 'en',                    availableLanguages: ['en', 'de'],                    hideVendureBranding: false,                    hideVersion: false,                }),            );        }    })    .then(() => {        process.exit(0);    });
```


---

# Deploying to Northflank


Northflank is a comprehensive developer platform to build and scale your apps. It has an outstanding developer experience and has a free tier for small projects, and is well-suited for deploying and scaling Vendure applications.

[Northflank](https://northflank.com)This guide will walk you through the steps to deploy a sample Vendure application to Northflank.

[a sample Vendure application](https://github.com/vendure-ecommerce/one-click-deploy)
## Set up a Northflank account​


[​](#set-up-a-northflank-account)Go to the Northflank sign up page to create a new account. As part of the sign-up you'll be asked for credit card details, but you won't be charged unless you upgrade to a paid plan.

[sign up page](https://app.northflank.com/signup)
## Create a custom template​


[​](#create-a-custom-template)A template defines the infrastructure that is needed to run your Vendure server. Namely, a server, a worker,
MinIO object storage for assets and a Postgres database.

Click the templates menu item in the navbar and click the "Create template" button.

Now paste the following configuration into the editor in the "code" tab:

- Full Template
- Lite Template

This template configures a production-like setup for Vendure, with the server and worker running in separate processes
and a separate MinIO instance for asset storage.

The resources configured here will cost around $20 per month.

If you want to use the free plan, use the "Lite Template".

```
{  "apiVersion": "v1.2",  "spec": {    "kind": "Workflow",    "spec": {      "type": "sequential",      "steps": [        {          "kind": "Project",          "ref": "project",          "spec": {            "name": "Vendure",            "region": "europe-west",            "description": "Vendure is a modern, open-source composable commerce platform",            "color": "#17b9ff"          }        },        {          "kind": "Workflow",          "spec": {            "type": "parallel",            "context": {              "projectId": "${refs.project.id}"            },            "steps": [              {                "kind": "Addon",                "ref": "database",                "spec": {                  "name": "database",                  "type": "postgres",                  "version": "14-latest",                  "billing": {                    "deploymentPlan": "nf-compute-20",                    "storageClass": "ssd",                    "storage": 4096,                    "replicas": 1                  },                  "tlsEnabled": false,                  "externalAccessEnabled": false,                  "ipPolicies": [],                  "pitrEnabled": false                }              },              {                "kind": "Addon",                "ref": "storage",                "spec": {                  "name": "minio",                  "type": "minio",                  "version": "latest",                  "billing": {                    "deploymentPlan": "nf-compute-20",                    "storageClass": "ssd",                    "storage": 4096,                    "replicas": 1                  },                  "tlsEnabled": true,                  "externalAccessEnabled": false,                  "ipPolicies": [],                  "pitrEnabled": false,                  "typeSpecificSettings": {},                  "backupSchedules": []                }              }            ]          }        },        {          "kind": "SecretGroup",          "spec": {            "projectId": "${refs.project.id}",            "secretType": "environment-arguments",            "priority": 10,            "name": "secrets",            "secrets": {              "variables": {                "APP_ENV": "production",                "COOKIE_SECRET": "${fn.randomSecret(32)}",                "SUPERADMIN_USERNAME": "superadmin",                "SUPERADMIN_PASSWORD": "${fn.randomSecret(16)}",                "DB_SCHEMA": "public"              },              "files": {}            },            "addonDependencies": [              {                "addonId": "${refs.database.id}",                "keys": [                  {                    "keyName": "HOST",                    "aliases": [                      "DB_HOST"                    ]                  },                  {                    "keyName": "PORT",                    "aliases": [                      "DB_PORT"                    ]                  },                  {                    "keyName": "DATABASE",                    "aliases": [                      "DB_NAME"                    ]                  },                  {                    "keyName": "USERNAME",                    "aliases": [                      "DB_USERNAME"                    ]                  },                  {                    "keyName": "PASSWORD",                    "aliases": [                      "DB_PASSWORD"                    ]                  }                ]              },              {                "addonId": "${refs.storage.id}",                "keys": [                  {                    "keyName": "MINIO_ENDPOINT",                    "aliases": [                      "MINIO_ENDPOINT"                    ]                  },                  {                    "keyName": "ACCESS_KEY",                    "aliases": [                      "MINIO_ACCESS_KEY"                    ]                  },                  {                    "keyName": "SECRET_KEY",                    "aliases": [                      "MINIO_SECRET_KEY"                    ]                  }                ]              }            ],            "restrictions": {              "restricted": false,              "nfObjects": [],              "tags": []            }          }        },        {          "kind": "BuildService",          "ref": "builder",          "spec": {            "name": "builder",            "projectId": "${refs.project.id}",            "billing": {              "deploymentPlan": "nf-compute-20"            },            "vcsData": {              "projectUrl": "https://github.com/vendure-ecommerce/one-click-deploy",              "projectType": "github"            },            "buildSettings": {              "dockerfile": {                "buildEngine": "kaniko",                "dockerFilePath": "/Dockerfile",                "dockerWorkDir": "/",                "useCache": false              }            },            "disabledCI": false,            "buildArguments": {}          }        },        {          "kind": "Build",          "spec": {            "id": "${refs.builder.id}",            "projectId": "${refs.project.id}",            "type": "service",            "branch": "master",            "buildOverrides": {              "buildArguments": {}            },            "reuseExistingBuilds": true          },          "condition": "success",          "ref": "build"        },        {          "kind": "Workflow",          "spec": {            "type": "parallel",            "context": {              "projectId": "${refs.project.id}"            },            "steps": [              {                "kind": "DeploymentService",                "spec": {                  "deployment": {                    "instances": 1,                    "storage": {                      "ephemeralStorage": {                        "storageSize": 1024                      },                      "shmSize": 64                    },                    "docker": {                      "configType": "customCommand",                      "customCommand": "node ./dist/index.js"                    },                    "internal": {                      "id": "${refs.builder.id}",                      "branch": "master",                      "buildSHA": "latest"                    }                  },                  "name": "server",                  "billing": {                    "deploymentPlan": "nf-compute-20"                  },                  "ports": [                    {                      "name": "app",                      "internalPort": 3000,                      "public": true,                      "protocol": "HTTP",                      "security": {                        "credentials": [],                        "policies": []                      },                      "domains": [],                      "disableNfDomain": false                    }                  ],                  "runtimeEnvironment": {},                  "runtimeFiles": {}                },                "ref": "server"              },              {                "kind": "DeploymentService",                "spec": {                  "deployment": {                    "instances": 1,                    "storage": {                      "ephemeralStorage": {                        "storageSize": 1024                      },                      "shmSize": 64                    },                    "docker": {                      "configType": "customCommand",                      "customCommand": "node ./dist/index-worker.js"                    },                    "internal": {                      "id": "${refs.builder.id}",                      "branch": "master",                      "buildSHA": "latest"                    }                  },                  "name": "worker",                  "billing": {                    "deploymentPlan": "nf-compute-10"                  },                  "ports": [],                  "runtimeEnvironment": {},                  "runtimeFiles": {}                },                "ref": "worker"              }            ]          }        }      ]    }  }}
```

This template runs the Vendure server & worker in a single process, and as such will fit within the
resource limits of the Northflank free plan. Local disk storage is used for assets, which means that
horizontal scaling is not possible.

This setup is suitable for testing purposes, but is not recommended for production use.

```
{  "apiVersion": "v1.2",  "spec": {    "kind": "Workflow",    "spec": {      "type": "sequential",      "steps": [        {          "kind": "Project",          "ref": "project",           "spec": {            "name": "Vendure Lite",            "region": "europe-west",            "description": "Vendure is a modern, open-source composable commerce platform",            "color": "#17b9ff"          }        },        {          "kind": "Addon",          "spec": {            "name": "database",            "type": "postgres",            "version": "14-latest",            "billing": {              "deploymentPlan": "nf-compute-20",              "storageClass": "ssd",              "storage": 4096,              "replicas": 1            },            "tlsEnabled": false,            "externalAccessEnabled": false,            "ipPolicies": [],            "pitrEnabled": false          }        },        {          "kind": "SecretGroup",          "spec": {            "projectId": "${refs.project.id}",            "name": "secrets",            "secretType": "environment-arguments",            "priority": 10,            "secrets": {              "variables": {                "APP_ENV": "production",                "COOKIE_SECRET": "${fn.randomSecret(32)}",                "SUPERADMIN_USERNAME": "superadmin",                "SUPERADMIN_PASSWORD": "${fn.randomSecret(16)}",                "DB_SCHEMA": "public",                "ASSET_UPLOAD_DIR": "/data",                "RUN_JOB_QUEUE_FROM_SERVER": "true"              }            },            "addonDependencies": [              {                "addonId": "database",                "keys": [                  {                    "keyName": "HOST",                    "aliases": [                      "DB_HOST"                    ]                  },                  {                    "keyName": "PORT",                    "aliases": [                      "DB_PORT"                    ]                  },                  {                    "keyName": "DATABASE",                    "aliases": [                      "DB_NAME"                    ]                  },                  {                    "keyName": "USERNAME",                    "aliases": [                      "DB_USERNAME"                    ]                  },                  {                    "keyName": "PASSWORD",                    "aliases": [                      "DB_PASSWORD"                    ]                  }                ]              }            ],            "restrictions": {              "restricted": false,              "nfObjects": [],              "tags": []            }          }        },        {          "kind": "BuildService",          "spec": {            "name": "builder",            "projectId": "${refs.project.id}",            "billing": {              "deploymentPlan": "nf-compute-10"            },            "vcsData": {              "projectUrl": "https://github.com/vendure-ecommerce/one-click-deploy",              "projectType": "github"            },            "buildSettings": {              "dockerfile": {                "buildEngine": "kaniko",                "dockerFilePath": "/Dockerfile",                "dockerWorkDir": "/",                "useCache": false              }            },            "disabledCI": false,            "buildArguments": {}          }        },        {          "kind": "Build",          "ref": "build",          "spec": {            "id": "${refs.builder.id}",            "projectId": "${refs.project.id}",            "type": "service",            "branch": "master",            "reuseExistingBuilds": true          },          "condition": "success"        },        {          "kind": "DeploymentService",          "ref": "server",          "spec": {            "name": "server",            "billing": {              "deploymentPlan": "nf-compute-20"            },            "deployment": {              "instances": 1,              "storage": {                "ephemeralStorage": {                  "storageSize": 1024                },                "shmSize": 64              },              "docker": {                "configType": "customCommand",                "customCommand": "yarn start:server"              },              "internal": {                "id": "${refs.builder.id}",                "branch": "master",                "buildSHA": "latest"              }            },            "ports": [              {                "name": "app",                "internalPort": 3000,                "public": true,                "protocol": "HTTP",                "security": {                  "credentials": [],                  "policies": []                },                "domains": []              }            ],            "runtimeEnvironment": {}          }        },        {          "kind": "Volume",          "spec": {            "spec": {              "storageSize": 5120,              "accessMode": "ReadWriteOnce",              "storageClassName": "ssd"            },            "name": "storage",            "mounts": [              {                "containerMountPath": "/data",                "volumeMountPath": ""              }            ],            "attachedObjects": [              {                "id": "${refs.server.id}",                "type": "service"              }            ]          }        }      ]    }  }}
```

Then click the "Create template" button.

## Run the template​


[​](#run-the-template)Next, click the "run template" button to start the deployment process.

Once the template run has completed, you should be able to see the newly-created project in the project selector.

## Find the public URL​


[​](#find-the-public-url)Click the "Services" menu item in the left sidebar and then click the "Server" service.

In the top right corner you'll see the public URL of your new Vendure server!

Note that it may take a few minutes for the server to start up and populate all the test data because the free tier has limited CPU and memory resources.

Once it is ready, you can navigate to the public URL and append /admin to the end of the URL to access the admin panel.

The superadmin password was generated for you by the template, and can be found in the "Secrets" section from the project nav bar
as SUPERADMIN_PASSWORD.

Congratulations on deploying your Vendure server!

## Next steps​


[​](#next-steps)Now that you have a basic Vendure server up and running, you can explore some of the other features offered by Northflank
that you might need for a full production setup:

- Configure health checks to ensure any container crashes are rapidly detected and restarted. Also see the
Vendure health check docs.
- Set up a Redis instance so that you can take advantage of our highly performant BullMQJobQueuePlugin and set up Redis-based session caching to handle multi-instance deployments.
- With the above in place, you can safely start to scale your server instances to handle more traffic.
- Add a custom domain using Northflank's powerful DNS management system.
- Set up infrastructure alerts to be notified when any of your containers crash or experience load spikes.

[health checks](https://northflank.com/docs/v1/application/observe/configure-health-checks)[Vendure health check docs](/guides/deployment/using-docker#healthreadiness-checks)[Set up a Redis instance](https://northflank.com/docs/v1/application/databases-and-persistence/deploy-databases-on-northflank/deploy-redis-on-northflank)[BullMQJobQueuePlugin](/reference/core-plugins/job-queue-plugin/bull-mqjob-queue-plugin)[Redis-based session caching](/reference/typescript-api/auth/session-cache-strategy/)[scale your server instances](https://northflank.com/docs/v1/application/scale/scaling-replicas)[Add a custom domain](https://northflank.com/docs/v1/application/domains/add-a-domain-to-your-account)[infrastructure alerts](https://northflank.com/docs/v1/application/observe/set-infrastructure-alerts)


---

# Deploying to Digital Ocean


App Platform is a fully managed platform which allows you to deploy and scale your Vendure server and infrastructure with ease.

[App Platform](https://www.digitalocean.com/products/app-platform)The configuration in this guide will cost around $22 per month to run.

## Prerequisites​


[​](#prerequisites)First of all you'll need to create a new Digital Ocean account if you
don't already have one.

[create a new Digital Ocean account](https://cloud.digitalocean.com/registrations/new)For this guide you'll need to have your Vendure project in a git repo on either GitHub or GitLab. App Platform also supports
deploying from docker registries, but that is out of the scope of this guide.

If you'd like to quickly get started with a ready-made Vendure project which includes sample data, you can clone our
Vendure one-click-deploy repo.

[Vendure one-click-deploy repo](https://github.com/vendure-ecommerce/one-click-deploy)
## Configuration​


[​](#configuration)
### Database connection​


[​](#database-connection)The following is already pre-configured if you are using the one-click-deploy repo.

Make sure your DB connection options uses the following environment variables:

```
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    dbConnectionOptions: {        // ...        type: 'postgres',        database: process.env.DB_NAME,        host: process.env.DB_HOST,        port: +process.env.DB_PORT,        username: process.env.DB_USERNAME,        password: process.env.DB_PASSWORD,        ssl: process.env.DB_CA_CERT ? {            ca: process.env.DB_CA_CERT,        } : undefined,    },};
```

### Asset storage​


[​](#asset-storage)The following is already pre-configured if you are using the one-click-deploy repo.

Since App Platform services do not include any persistent storage, we need to configure Vendure to use Digital Ocean's
Spaces service, which is an S3-compatible object storage service. This means you'll need to make sure to have the
following packages installed:

```
npm install @aws-sdk/client-s3 @aws-sdk/lib-storage
```

and set up your AssetServerPlugin like this:

```
import { VendureConfig } from '@vendure/core';import { AssetServerPlugin, configureS3AssetStorage } from '@vendure/asset-server-plugin';export const config: VendureConfig = {    // ...    plugins: [        AssetServerPlugin.init({            route: 'assets',            assetUploadDir: process.env.ASSET_UPLOAD_DIR || path.join(__dirname, '../static/assets'),            // If the MINIO_ENDPOINT environment variable is set, we'll use            // Minio as the asset storage provider. Otherwise, we'll use the            // default local provider.            storageStrategyFactory: process.env.MINIO_ENDPOINT ?  configureS3AssetStorage({                bucket: 'vendure-assets',                credentials: {                    accessKeyId: process.env.MINIO_ACCESS_KEY,                    secretAccessKey: process.env.MINIO_SECRET_KEY,                },                nativeS3Configuration: {                    endpoint: process.env.MINIO_ENDPOINT,                    forcePathStyle: true,                    signatureVersion: 'v4',                    // The `region` is required by the AWS SDK even when using MinIO,                    // so we just use a dummy value here.                    region: 'eu-west-1',                },            }) : undefined,        }),    ],    // ...};
```

## Create Spaces Object Storage​


[​](#create-spaces-object-storage)First we'll create a Spaces bucket to store our assets. Click the "Spaces Object Storage" nav item and
create a new space and call it "vendure-assets".

Next we need to create an access key and secret. Click the "API" nav item and generate a new key.

Name the key something meaningful like "vendure-assets-key" and then make sure to copy the secret as it will only be
shown once. Store the access key and secret key in a safe place for later - we'll be using it when we set up our
app's environment variables.

If you forget to copy the secret key, you'll need to delete the key and create a new one.

## Create the server resource​


[​](#create-the-server-resource)Now we're ready to create our app infrastructure! Click the "Create" button in the top bar and select "Apps".

Now connect to your git repo, and select the repo of your Vendure project.

Depending on your repo, App Platform may suggest more than one app: in this screenshot we are using the one-click-deploy
repo which contains a Dockerfile, so App Platform is suggesting two different ways to deploy the app. We'll select the
Dockerfile option, but either option should work fine. Delete the unused resource.

We need to edit the details of the server app. Click the "Edit" button and set the following:

- Resource Name: "vendure-server"
- Resource Type: Web Service
- Run Command: node ./dist/index.js
- HTTP Port: 3000

At this point you can also click the "Edit Plan" button to select the resource allocation for the server, which will
determine performance and price. For testing purposes the smallest Basic server (512MB, 1vCPU) is fine. This can also be changed later.

### Add a database​


[​](#add-a-database)Next click "Add Resource", select Database and click "Add", and then accept the default Postgres database. Click the
"Create and Attach" to create the database and attach it to the server app.

Your config should now look like this:

## Set up environment variables​


[​](#set-up-environment-variables)Next we need to set up the environment variables. Since these will be shared by both the server and worker apps, we'll create
them at the Global level.

You can use the "bulk editor" to paste in the following variables (making sure to replace the values in <angle brackets> with
your own values):

```
DB_NAME=${db.DATABASE}DB_USERNAME=${db.USERNAME}DB_PASSWORD=${db.PASSWORD}DB_HOST=${db.HOSTNAME}DB_PORT=${db.PORT}DB_CA_CERT=${db.CA_CERT}COOKIE_SECRET=<add some random characters>SUPERADMIN_USERNAME=superadminSUPERADMIN_PASSWORD=<create some strong password>MINIO_ACCESS_KEY=<use the key generated earlier>MINIO_SECRET_KEY=<use the secret generated earlier>MINIO_ENDPOINT=<use the endpoint of your spaces bucket>
```

The values starting with ${db...} are automatically populated by App Platform and should not be changed, unless you chose
to name your database something other than db.

When using the App Platform with a Dev Database, DigitalOcean only provides a self-signed SSL certificate. This may prevent the Vendure app from starting. As a workaround, you can add the environment variable NODE_TLS_REJECT_UNAUTHORIZED and set it to 0.

After saving your environment variables you can click through the confirmation screens to create the app.

## Create the worker resource​


[​](#create-the-worker-resource)Now we need to set up the Vendure worker which will handle background tasks. From the dashboard of your newly-created
app, click the "Create" button and then select "Create Resources From Source Code".

[Vendure worker](/guides/developer-guide/worker-job-queue/)You will be prompted to select the repo again, and then you'll need to set up a new single resource with the following
settings:

- Resource Name: "vendure-worker"
- Resource Type: Worker
- Run Command: node ./dist/index-worker.js

Again you can edit the plan, and the smallest Basic plan is fine for testing purposes.

No new environment variables are needed since we'll be sharing the Global variables with the worker.

## Enable access to the required routes​


[​](#enable-access-to-the-required-routes)To be able to access the UI and other routes, we need to declare them first.

- In the app dashboard, click on the Settings tab.
- Click on the vendure-server component.
- Scroll down to HTTP Request Routes.
- Click on Edit.
- Click on + Add new route and fill in the form like this:
- Make sure to check the Preserve Path Prefix option.

In the app dashboard, click on the Settings tab.

Click on the vendure-server component.

Scroll down to HTTP Request Routes.

Click on Edit.

Click on + Add new route and fill in the form like this:

Make sure to check the Preserve Path Prefix option.

You need to do this for the following routes:

- /admin
- /assets
- /health
- /admin-api
- /shop-api

- Click on Save.

## Test your Vendure server​


[​](#test-your-vendure-server)Once everything has finished deploying, you can click the app URL to open your Vendure server in a new tab.

Append /admin to the URL to access the admin UI, and log in with the superadmin credentials you set in the environment variables.


---

# Deploying to Railway


Railway is a managed hosting platform which allows you to deploy and scale your Vendure server and infrastructure with ease.

[Railway](https://railway.app/)This guide should be runnable on the Railway free trial plan, which means you can deploy it for free and thereafter
pay only for the resources you use, which should be around $5 per month.

## Prerequisites​


[​](#prerequisites)First of all you'll need to create a new Railway account (click "login" on the website and enter your email address) if you
don't already have one.

You'll also need a GitHub account and you'll need to have your Vendure project hosted there.

In order to use the Railway trial plan, you'll need to connect your GitHub account to Railway via the Railway dashboard.

If you'd like to quickly get started with a ready-made Vendure project which includes sample data, you can clone our
Vendure one-click-deploy repo.

[Vendure one-click-deploy repo](https://github.com/vendure-ecommerce/one-click-deploy)
## Configuration​


[​](#configuration)
### Port​


[​](#port)Railway defines the port via the PORT environment variable, so make sure your Vendure Config uses this variable:

```
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    apiOptions: {        port: +(process.env.PORT || 3000),        // ...    },    // ...};
```

### Database connection​


[​](#database-connection)The following is already pre-configured if you are using the one-click-deploy repo.

Make sure your DB connection options uses the following environment variables:

```
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    dbConnectionOptions: {        // ...        database: process.env.DB_NAME,        host: process.env.DB_HOST,        port: +process.env.DB_PORT,        username: process.env.DB_USERNAME,        password: process.env.DB_PASSWORD,    },};
```

### Asset storage​


[​](#asset-storage)The following is already pre-configured if you are using the one-click-deploy repo.

In this guide we will use the AssetServerPlugin's default local disk storage strategy. Make sure you use the
ASSET_UPLOAD_DIR environment variable to set the path to the directory where the uploaded assets will be stored.

```
import { VendureConfig } from '@vendure/core';import { AssetServerPlugin } from '@vendure/asset-server-plugin';export const config: VendureConfig = {    // ...    plugins: [        AssetServerPlugin.init({            route: 'assets',            assetUploadDir: process.env.ASSET_UPLOAD_DIR || path.join(__dirname, '../static/assets'),        }),    ],    // ...};
```

## Create a new Railway project​


[​](#create-a-new-railway-project)From the Railway dashboard, click "New Project" and select "Empty Project". You'll be taken to a screen where you can
add the first service to your project.

## Create the database​


[​](#create-the-database)Click the "Add a Service" button and select "database". Choose a database that matches the one you are using in your
Vendure project. If you are following along using the one-click-deploy repo, then choose "Postgres".

## Create the Vendure server​


[​](#create-the-vendure-server)Click the "new" button to create a new service, and select "GitHub repo". Select the repository which contains your
Vendure project. You may need to configure access to this repo if you haven't already done so.

### Configure the server service​


[​](#configure-the-server-service)You should then see a card representing this service in the main area of the dashboard. Click the card and go to the
"settings" tab.

- Scroll to the "Service" section and rename the service to "vendure-server".
- Check the "Build" section and make sure the build settings make sense for your repo. If you are using
the one-click-deploy repo, then it should detect the Dockerfile.
- In the "Deploy" section, set the "Custom start command" to node ./dist/index.js.
- Finally, scroll up to the "Networking" section and click "Generate domain" to set up a temporary domain for your
Vendure server.

### Create a Volume​


[​](#create-a-volume)In order to persist the uploaded product images, we need to create a volume. Click the "new" button and select "Volume".
Attach it to the "vendure-server" service and set the mount path to /vendure-assets.

### Configure server env vars​


[​](#configure-server-env-vars)Click on the "vendure-server" service and go to the "Variables" tab. This is where we will set up the environment
variables which are used in our Vendure Config. You can use the raw editor to add the following variables, making
sure to replace the highlighted values with your own:

```
DB_NAME=${{Postgres.PGDATABASE}}DB_USERNAME=${{Postgres.PGUSER}}DB_PASSWORD=${{Postgres.PGPASSWORD}}DB_HOST=${{Postgres.PGHOST}}DB_PORT=${{Postgres.PGPORT}}ASSET_UPLOAD_DIR=/vendure-assetsCOOKIE_SECRET=<add some random characters>SUPERADMIN_USERNAME=superadminSUPERADMIN_PASSWORD=<create some strong password>
```

The variables starting with ${{Postgres...}} assume that your database service is called "Postgres". If you have
named it differently, then you'll need to change these variables accordingly.

## Create the Vendure worker​


[​](#create-the-vendure-worker)Finally, we need to define the worker process which will run the background tasks. Click the "new" button and select
"GitHub repo". Select again the repository which contains your Vendure project.

### Configure the worker service​


[​](#configure-the-worker-service)You should then see a card representing this service in the main area of the dashboard. Click the card and go to the
"settings" tab.

- Scroll to the "Service" section and rename the service to "vendure-worker".
- Check the "Build" section and make sure the build settings make sense for your repo. If you are using
the one-click-deploy repo, then it should detect the Dockerfile.
- In the "Deploy" section, set the "Custom start command" to node ./dist/index-worker.js.

### Configure worker env vars​


[​](#configure-worker-env-vars)The worker will need to know how to connect to the database, so add the following variables to the "Variables" tab:

```
DB_NAME=${{Postgres.PGDATABASE}}DB_USERNAME=${{Postgres.PGUSER}}DB_PASSWORD=${{Postgres.PGPASSWORD}}DB_HOST=${{Postgres.PGHOST}}DB_PORT=${{Postgres.PGPORT}}
```

## Test your Vendure server​


[​](#test-your-vendure-server)To test that everything is working, click the "vendure-server" card and then the link to the temporary domain.

## Next Steps​


[​](#next-steps)This setup gives you a basic Vendure server to get started with. When moving to a more production-ready setup, you'll
want to consider the following:

- Use MinIO for asset storage. This is a more robust and scalable solution than the local disk storage used here.

MinIO template for Railway,
Configuring the AssetServerPlugin for MinIO
- MinIO template for Railway,
- Configuring the AssetServerPlugin for MinIO
- Use Redis to power the job queue and session cache. This is not only more performant, but will enable horizontal scaling of your
server and worker instances.

Railway Redis docs
Vendure horizontal scaling docs
- Railway Redis docs
- Vendure horizontal scaling docs

- MinIO template for Railway,
- Configuring the AssetServerPlugin for MinIO

[MinIO template for Railway](https://railway.app/template/SMKOEA)[Configuring the AssetServerPlugin for MinIO](/reference/core-plugins/asset-server-plugin/s3asset-storage-strategy/#usage-with-minio)- Railway Redis docs
- Vendure horizontal scaling docs

[Railway Redis docs](https://docs.railway.app/guides/redis)[Vendure horizontal scaling docs](/guides/deployment/horizontal-scaling)


---

# Deploying to Render


Render is a managed hosting platform which allows you to deploy and scale your Vendure server and infrastructure with ease.

[Render](https://render.com/)The configuration in this guide will cost from around $12 per month to run.

## Prerequisites​


[​](#prerequisites)First of all you'll need to create a new Render account if you
don't already have one.

[create a new Render account](https://dashboard.render.com/register)For this guide you'll need to have your Vendure project in a git repo on either GitHub or GitLab.

If you'd like to quickly get started with a ready-made Vendure project which includes sample data, you can use our
Vendure one-click-deploy repo, which means you won't have
to set up your own git repo.

[Vendure one-click-deploy repo](https://github.com/vendure-ecommerce/one-click-deploy)
## Configuration​


[​](#configuration)
### Port​


[​](#port)Render defines the port via the PORT environment variable and defaults to 10000, so make sure your Vendure Config uses this variable:

[defaults to 10000](https://docs.render.com/web-services#host-and-port-configuration)
```
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    apiOptions: {        port: +(process.env.PORT || 3000),        // ...    },    // ...};
```

### Database connection​


[​](#database-connection)The following is already pre-configured if you are using the one-click-deploy repo.

Make sure your DB connection options uses the following environment variables:

```
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    dbConnectionOptions: {        // ...        database: process.env.DB_NAME,        host: process.env.DB_HOST,        port: +process.env.DB_PORT,        username: process.env.DB_USERNAME,        password: process.env.DB_PASSWORD,    },};
```

### Asset storage​


[​](#asset-storage)The following is already pre-configured if you are using the one-click-deploy repo.

In this guide we will use the AssetServerPlugin's default local disk storage strategy. Make sure you use the
ASSET_UPLOAD_DIR environment variable to set the path to the directory where the uploaded assets will be stored.

```
import { VendureConfig } from '@vendure/core';import { AssetServerPlugin } from '@vendure/asset-server-plugin';export const config: VendureConfig = {    // ...    plugins: [        AssetServerPlugin.init({            route: 'assets',            assetUploadDir: process.env.ASSET_UPLOAD_DIR || path.join(__dirname, '../static/assets'),        }),    ],    // ...};
```

## Create a database​


[​](#create-a-database)From the Render dashboard, click the "New" button and select "PostgreSQL" from the list of services:

Give the database a name (e.g. "postgres"), select a region close to you, select an appropriate plan
and click "Create Database".

## Create the Vendure server​


[​](#create-the-vendure-server)Click the "New" button again and select "Web Service" from the list of services. Choose the "Build and deploy from a Git repository" option.

In the next step you will be prompted to connect to either GitHub or GitLab. Select the appropriate option and follow the instructions
to connect your account and grant access to the repository containing your Vendure project.

If you are using the one-click-deploy repo, you should instead use the "Public Git repository" option and enter the URL of the repo:

```
https://github.com/vendure-ecommerce/one-click-deploy
```

### Configure the server service​


[​](#configure-the-server-service)In the next step you will configure the server:

- Name: "vendure-server"
- Region: Select a region close to you
- Branch: Select the branch you want to deploy, usually "main" or "master"
- Runtime: If you have a Dockerfile then it should be auto-detected. If not you should select "Node" and enter the appropriate build and start commands. For a
typical Vendure project these would be:

Build Command: yarn; yarn build or npm install; npm run build
Start Command: node ./dist/index.js
- Build Command: yarn; yarn build or npm install; npm run build
- Start Command: node ./dist/index.js
- Instance Type: Select the appropriate instance type. Since we want to use a persistent volume to store our assets, we need to
use at least the "Starter" instance type or higher.

- Build Command: yarn; yarn build or npm install; npm run build
- Start Command: node ./dist/index.js

Click the "Advanced" button to expand the advanced options:

- Click "Add Disk" to set up a persistent volume for the assets and use the following settings:

Name: "vendure-assets"
Mount Path: /vendure-assets
Size: As appropriate. For testing purposes you can use the smallest size (1GB)
- Name: "vendure-assets"
- Mount Path: /vendure-assets
- Size: As appropriate. For testing purposes you can use the smallest size (1GB)
- Health Check Path: /health
- Docker Command: node ./dist/index.js (if you are not using a Dockerfile this option will not be available)

- Name: "vendure-assets"
- Mount Path: /vendure-assets
- Size: As appropriate. For testing purposes you can use the smallest size (1GB)

Click "Create Web Service" to create the service.

If you have not already set up payment, you will be prompted to enter credit card details at this point.

## Configure environment variables​


[​](#configure-environment-variables)Next we need to set up the environment variables which will be used by both the server and worker. Click the "Env Groups" tab
and then click the "New Environment Group" button.

Name the group "vendure configuration" and add the following variables. The database variables can be found by navigating
to the database service, clicking the "Info" tab and scrolling to the "Connections" section:

```
DB_NAME=<database "Database">DB_USERNAME=<database "Username">DB_PASSWORD=<database "Password">DB_HOST=<database "Hostname">DB_PORT=<database "Port">ASSET_UPLOAD_DIR=/vendure-assetsCOOKIE_SECRET=<add some random characters>SUPERADMIN_USERNAME=superadminSUPERADMIN_PASSWORD=<create some strong password>
```

Once the correct values have been entered, click "Create Environment Group".

Next, click the "vendure-server" service and go to the "Environment" tab to link the environment group to the service:

## Create the Vendure worker​


[​](#create-the-vendure-worker)Finally, we need to define the worker process which will run the background tasks. Click the "New" button and select
"Background Worker".

Select the same git repo as before, and in the next step configure the worker:

- Name: "vendure-worker"
- Region: Same as the server
- Branch: Select the branch you want to deploy, usually "main" or "master"
- Runtime: If you have a Dockerfile then it should be auto-detected. If not you should select "Node" and enter the appropriate build and start commands. For a
typical Vendure project these would be:

Build Command: yarn; yarn build or npm install; npm run build
Start Command: node ./dist/index-worker.js
- Build Command: yarn; yarn build or npm install; npm run build
- Start Command: node ./dist/index-worker.js
- Instance Type: Select the appropriate instance type. The Starter size is fine to get started.

- Build Command: yarn; yarn build or npm install; npm run build
- Start Command: node ./dist/index-worker.js

Click the "Advanced" button to expand the advanced options:

- Docker Command: node ./dist/index-worker.js (if you are not using a Dockerfile this option will not be available)

Click "Create Background Worker" to create the worker.

Finally, click the "Environment" tab and link the "vendure configuration" environment group to the worker.

## Test your Vendure server​


[​](#test-your-vendure-server)Navigate back to the dashboard, click the "vendure-server" service, and you should see a link to the temporary domain:

Click the link and append /admin to the URL to open the Admin UI. Log in with the username and password you set in the
environment variables.

## Next Steps​


[​](#next-steps)This setup gives you a basic Vendure server to get started with. When moving to a more production-ready setup, you'll
want to consider the following:

- Use MinIO for asset storage. This is a more robust and scalable solution than the local disk storage used here.

Deploying MinIO to Render,
Configuring the AssetServerPlugin for MinIO
- Deploying MinIO to Render,
- Configuring the AssetServerPlugin for MinIO
- Use Redis to power the job queue and session cache. This is not only more performant, but will enable horizontal scaling of your
server and worker instances.

Render Redis docs
Vendure horizontal scaling docs
- Render Redis docs
- Vendure horizontal scaling docs

- Deploying MinIO to Render,
- Configuring the AssetServerPlugin for MinIO

[Deploying MinIO to Render](https://docs.render.com/deploy-minio)[Configuring the AssetServerPlugin for MinIO](/reference/core-plugins/asset-server-plugin/s3asset-storage-strategy/#usage-with-minio)- Render Redis docs
- Vendure horizontal scaling docs

[Render Redis docs](https://docs.render.com/redis#creating-a-redis-instance)[Vendure horizontal scaling docs](/guides/deployment/horizontal-scaling)


---

# Deploying to Google Cloud Run


Google Cloud Run is a fully managed platform which allows you to run containerized apps and only pay while your app code is actually running.

[Google Cloud Run](https://cloud.google.com/run)This guide was written by Martijn from Pinelab, who have been successfully running multiple Vendure projects on Google Cloud Run. The step by step commands can be found here on GitHub:

[Pinelab](https://pinelab.studio/)- https://github.com/Pinelab-studio/vendure-google-cloud-run-starter/blob/main/README.md.

[https://github.com/Pinelab-studio/vendure-google-cloud-run-starter/blob/main/README.md](https://github.com/Pinelab-studio/vendure-google-cloud-run-starter/blob/main/README.md)
## Prerequisites​


[​](#prerequisites)This guide assumes you have:

- Google cloud's gcloud cli installed locally
- Created a Google Cloud project and enabled the API's we need: https://github.com/Pinelab-studio/vendure-google-cloud-run-starter/blob/main/README.md#create-a-google-cloud-project

[https://github.com/Pinelab-studio/vendure-google-cloud-run-starter/blob/main/README.md#create-a-google-cloud-project](https://github.com/Pinelab-studio/vendure-google-cloud-run-starter/blob/main/README.md#create-a-google-cloud-project)
## Setting up a MySQL database with Google Cloud SQL​


[​](#setting-up-a-mysql-database-with-google-cloud-sql)Google Cloud SQL is a fully-managed relational database service that makes it easy to set up, maintain, and manage databases in the cloud.
Vendure requires an SQL database to store its data, and Google Cloud SQL is a great option for this because it provides a reliable, scalable, and secure way to host our database.

You can find the gcloud commands to create a MySQL database here: https://github.com/Pinelab-studio/vendure-google-cloud-run-starter/blob/main/README.md#create-a-mysql-database

[https://github.com/Pinelab-studio/vendure-google-cloud-run-starter/blob/main/README.md#create-a-mysql-database](https://github.com/Pinelab-studio/vendure-google-cloud-run-starter/blob/main/README.md#create-a-mysql-database)
## Google Cloud Storage for assets​


[​](#google-cloud-storage-for-assets)Vendure stores assets such as product images on file system by default. However, Google Cloud Run does not have internal file storage, so we need to use an external storage service.
Google Cloud Storage is a great option for this because it provides a scalable and reliable way to store our assets in the cloud.

Use these gcloud commands to create a storage bucket for our assets.

[commands](https://github.com/Pinelab-studio/vendure-google-cloud-run-starter/blob/main/README.md#asset-storage)
## Google Cloud Tasks for Vendure's worker​


[​](#google-cloud-tasks-for-vendures-worker)Vendure uses a worker process to perform asynchronous tasks such as sending emails. To communicate between the main application and the worker process, we need a message queue. Google Cloud Tasks is a great option for this because it provides a fully-managed, scalable, and reliable way to send and receive messages between applications.

You don't need to do anything to enable Cloud Tasks: this plugin automatically creates task queues for you.

[this plugin](https://github.com/Pinelab-studio/vendure-google-cloud-run-starter/blob/8fd342c15fa7b38e3662311f176901a5d38cde3d/src/vendure-config.ts#L88)
## Running locally​


[​](#running-locally)Let's test out our application locally before deploying to Cloud Run. Copy this .env.example to .env and fill in your variables. You can skip the WORKER_HOST variable, because we don't have it yet.

[this](https://github.com/Pinelab-studio/vendure-google-cloud-run-starter/blob/main/.env.example)
## Dockerize Vendure​


[​](#dockerize-vendure)Google Cloud Run allows us to deploy containerized applications without worrying about the underlying infrastructure. To deploy Vendure to Google Cloud Run, we need to Dockerize it. Dockerizing Vendure means packaging the application and its dependencies into a container that can be easily deployed to Google Cloud Run.

The setup for containerizing Vendure is already done: This file and this file will build your container.

[This file](https://github.com/Pinelab-studio/vendure-google-cloud-run-starter/blob/main/Dockerfile)[this file](https://github.com/Pinelab-studio/vendure-google-cloud-run-starter/blob/main/build-docker.sh)
## Deployment​


[​](#deployment)The example repository contains GitHub action definitions to automatically deploy your app to Cloud Run when you push to the main branch.

Follow these steps to create a service account and set your variables as repository secret in GitHub.

[these steps](https://github.com/Pinelab-studio/vendure-google-cloud-run-starter/blob/main/build-docker.sh)
## Keep alive​


[​](#keep-alive)As final improvement, you can use Google Cloud Scheduler to poll your Cloud Run instance to prevent cold starts with this command.

[this command](https://github.com/Pinelab-studio/vendure-google-cloud-run-starter/blob/main/build-docker.sh)That's it! Feel free to reach out for any questions, or create a Pull Request in the repository if you have any improvements.

[Pull Request in the repository](https://github.com/Pinelab-studio/vendure-google-cloud-run-starter/pulls)