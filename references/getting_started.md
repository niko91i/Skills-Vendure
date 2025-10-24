# Vendure - Getting Started

**Pages:** 6

---

## Installation

**URL:** https://docs.vendure.io/guides/getting-started/installation/

**Contents:**
- Installation
- Requirements​
  - Optional​
- @vendure/create​
  - Quick Start​
  - Manual Configuration​
    - 1. Select a database​
    - 2. Populate with data​
    - 3. Complete setup​
  - Start the server​

The recommended way to get started with Vendure is by using the @vendure/create tool. This is a command-line tool which will scaffold and configure your new Vendure project and install all dependencies.

First, run the following command in your terminal, replacing my-shop with the name of your project:

Next, choose the "Quick Start" option. This is the fastest way to get a Vendure server up and running and will handle all the configuration for you. If you have Docker Desktop installed, it will create and configure a Postgres database for you. If not, it will use SQLite.

And that's it! After a minute or two, you'll have a fully-functional Vendure server installed locally.

Once the installation is done, your terminal will output a message indicating a successful installation with:

Proceed to the Start the server section below to run your Vendure server.

If you'd rather have more control over the configuration, you can choose the "Manual Configuration" option. This will prompt you to select a database and whether to populate the database with sample data.

Vendure supports a number of different databases. The @vendure/create tool will prompt you to select one.

To quickly test out Vendure, we recommend using SQLite, which requires no external dependencies. You can always switch to a different database later by changing your configuration file.

If you select MySQL, MariaDB, or Postgres, you need to make sure you:

Have the database server running: You can either install the database locally on your machine, use a cloud provider, or run it via Docker. For local development with Docker, you can use the provided docker-compose.yml file in your project.

Have created a database: Use your database client to create an empty database (e.g., CREATE DATABASE vendure; in most SQL databases).

Have database credentials: You need the username and password for a database user that has full permissions (CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT) on the database you created.

For detailed database configuration examples, see the Configuration guide.

The final prompt will ask whether to populate your new Vendure server with some sample product data.

We recommend you do so, as it will give you a good starting point for exploring the APIs, which we will cover in the Try the API section, as well as providing some data to use when building your own storefront.

Next, a project scaffold will be created and dependencies installed. This may take a few minutes.

Once the installation is complete, navigate to your project directory and start the development server:

```bash
cd my-shop
npm run dev
```

In a separate terminal, start the Vite dev server:

```bash
npx vite
```

This will make the following available:
- **Admin GraphQL API**: http://localhost:3000/admin-api
- **Shop GraphQL API**: http://localhost:3000/shop-api
- **Dashboard**: http://localhost:5173/dashboard/

The default superadmin credentials are:
- **Username**: `superadmin`
- **Password**: `superadmin`

**Examples:**

Example 1 (bash):
```bash
npx @vendure/create my-shop
```

Example 2 (text):
```text
┌  Let's create a Vendure App ✨
│
│◆  How should we proceed?
│  ● Quick Start (Get up and running in a single step)
│  ○ Manual Configuration
│
└
```

Example 3 (bash):
```bash
cd my-shop
npm run dev
```

Example 4 (sh):
```sh
npx @vendure/create my-shop --log-level verbose
```

---

## Introducing GraphQL

**URL:** https://docs.vendure.io/guides/getting-started/graphql-intro/

**Contents:**
- Introducing GraphQL
- What is GraphQL?​
- GraphQL vs REST​
- Why GraphQL?​
- GraphQL Terminology​
  - Types & Fields​
  - Query & Mutation types​
  - Input types​
  - Schema​
  - Operations​

Vendure uses GraphQL as its API layer.

This is an introduction to GraphQL for those who are new to it. If you are already familiar with GraphQL, you may choose to skip this section.

GraphQL is a query language for APIs and a runtime for fulfilling those queries with your existing data. GraphQL provides a complete and understandable description of the data in your API, gives clients the power to ask for exactly what they need and nothing more, makes it easier to evolve APIs over time, and enables powerful developer tools.

To put it simply: GraphQL allows you to fetch data from an API via queries, and to update data via mutations.

Here's a GraphQL query which fetches the product with the slug "football":

If you are familiar with REST-style APIs, you may be wondering how GraphQL differs. Here are the key ways in which GraphQL differs from REST:

Both GraphQL and REST are valid approaches to building an API. These are some of the reasons we chose GraphQL when building Vendure:

Let's clear up some of the terminology used in GraphQL.

GraphQL has a type system which works in a similar way to other statically typed languages like TypeScript.

Here is an example of a GraphQL type:

The Customer is an object type, and it has three fields: id, name, and email. Each field has a type (e.g. ID! or String!), which can refer to either a scalar type (a "primitive" type which does not have any fields, but represents a single value) or another object type.

GraphQL has a number of built-in scalar types, including ID, String, Int, Float, Boolean. Vendure further defines a few custom scalar types: DateTime, JSON, Upload & Money. It is also possible to define your own custom scalar types if required.

The ! symbol after the type name indicates that the field is required (it cannot be null). If a field does not have the ! symbol, it is optional (it can be null).

Here's another example of a couple of types:

Here the Order type has a field called customer which is of type Customer. The Order type also has a field called lines which is a list (an array) of OrderLine objects.

In GraphQL, lists are denoted by square brackets ([]). The ! symbol inside the square brackets indicates that the list cannot contain null values.

The types given here are not the actual types used in the Vendure GraphQL schema, but are used here for illustrative purposes.

There are two special types in GraphQL: Query and Mutation. These are the entry points into the API.

The Query type is used for fetching data. For example:

```graphql
type Query {
  customers: [Customer!]!
}
```

This defines a `customers` field that returns a list of Customer objects.

The Mutation type is used for modifying data. For example:

```graphql
type Mutation {
  updateCustomerEmail(customerId: ID!, email: String!): Customer!
}
```

This field accepts two arguments and returns a Customer object.

**Input Types** allow passing complex data to queries or mutations. They resemble object types but use the `input` keyword:

```graphql
input UpdateCustomerEmailInput {
  customerId: ID!
  email: String!
}
```

The **Schema** represents the complete definition of the GraphQL API. It specifies available types, fields, queries, and mutations—essentially everything possible with that API.

A minimal schema example includes:

```graphql
schema {
  query: Query
  mutation: Mutation
}
```

An **Operation** is the general name for a GraphQL query or mutation. Operations can include names and variables for dynamic values.

**Examples:**

Example 1 (graphql):
```graphql
type Customer {
  id: ID!
  name: String!
  email: String!
}
```

Example 2 (graphql):
```graphql
type Order {
  id: ID!
  orderPlacedAt: DateTime
  isActive: Boolean!
  customer: Customer!
  lines: [OrderLine!]!
}

type OrderLine {
  id: ID!
  productId: ID!
  quantity: Int!
}
```

Example 3 (graphql):
```graphql
type Query {
  customers: [Customer!]!
}
```

Example 4 (graphql):
```graphql
type Mutation {
  updateCustomerEmail(customerId: ID!, email: String!): Customer!
}
```

---

## Getting Started

**URL:** https://docs.vendure.io/guides/extending-the-dashboard/getting-started/

**Contents:**
- Getting Started
- Installation & Setup​
  - Monorepo Setup​
- The DashboardPlugin​
- Running the Dashboard​

From Vendure v3.5.0, the @vendure/dashboard package and configuration comes as standard with new projects that are started with the npx @vendure/create command.

This guide serves mainly for those adding the Dashboard to existing project set up prior to v3.5.0.

This guide assumes an existing project based on the @vendure/create folder structure. If you have a different setup (e.g. an Nx monorepo), you may need to adapt the instructions accordingly.

First install the @vendure/dashboard package:

Then create a vite.config.mts file in the root of your project (on the same level as your package.json) with the following content:

You should also add the following to your existing tsconfig.json file to exclude the dashboard extensions and Vite config from your build, and reference a new tsconfig.dashboard.json that will have compiler settings for the Dashboard code.

Now create a new tsconfig.dashboard.json to allow your IDE to correctly resolve imports of GraphQL types & interpret JSX in your dashboard extensions:

If your project uses a monorepo structure, such as with Nx or Turborepo, then you'll need to make some adjustments to the paths given above:

If each Vendure plugin is its own "package", outside the main Vendure server app, then it would need its own tsconfig for each plugin package. You might run into errors like:

In this case, you'll need to configure a PathAdapter.

You should also put your vite.config.mts file into the Vendure app directory rather than the root.

In your vendure-config.ts file, you should also import and configure the DashboardPlugin.

The DashboardPlugin adds the following features that enhance the use of the Dashboard:

Once the above is set up, you can run npm run dev to start your Vendure server, and then visit

which will display a developer placeholder until you start the Vite dev server using

To stop the running dashboard, type q and hit enter.

If you still need to run the legacy Angular-based Admin UI in parallel with the Dashboard, this is totally possible.

You just need to make sure to set the compatibilityMode setting in the AdminUiPlugin's init options.

**Examples:**

Example 1 (bash):
```bash
npm install @vendure/dashboard
```

Example 2 (ts):
```ts
import { vendureDashboardPlugin } from '@vendure/dashboard/vite';import { join, resolve } from 'path';import { pathToFileURL } from 'url';import { defineConfig } from 'vite';export default defineConfig({    base: '/dashboard',    build: {        outDir: join(__dirname, 'dist/dashboard'),    },    plugins: [        vendureDashboardPlugin({            // The vendureDashboardPlugin will scan your configuration in order            // to find any plugins which have dashboard extensions, as well as            // to introspect the GraphQL schema based on any API extensions            // and custom fi
...
```

Example 3 (json):
```json
{    // ... existing options    "exclude": [        "node_modules",        "migration.ts",        "src/plugins/**/ui/*",        "admin-ui",        "src/plugins/**/dashboard/*",        "src/gql/*",        "vite.*.*ts"    ],    "references": [        {            "path": "./tsconfig.dashboard.json"        }    ]}
```

Example 4 (json):
```json
{    "compilerOptions": {        "composite": true,        "module": "ESNext",        "moduleResolution": "bundler",        "jsx": "react-jsx",        "paths": {            // Import alias for the GraphQL types            // Please adjust to the location that you have set in your `vite.config.mts`            "@/gql": [                "./src/gql/graphql.ts"            ],            // This line allows TypeScript to properly resolve internal            // Vendure Dashboard imports, which is necessary for            // type safety in your dashboard extensions.            // This path assumes a ro
...
```

---

## Try the API

**URL:** https://docs.vendure.io/guides/getting-started/try-the-api/

**Contents:**
- Try the API
- GraphiQL Interface​
- Shop API​
  - Fetch a list of products​
  - Add a product to an order​
- Admin API​
  - Logging in​
  - Fetch a product​

Once you have successfully installed Vendure locally following the installation guide, it's time to try out the API!

This guide assumes you chose to populate sample data when installing Vendure.

You can also follow along with these example using the public demo playground at demo.vendure.io/graphiql/shop

Vendure comes with GraphiQL - a powerful UI for exploring and testing GraphQL APIs. It allows you to run queries and mutations against both the Shop and Admin APIs, making it easy to explore the API and understand how it works.

In this guide, we'll be using GraphiQL to run queries and mutations. At each step, you paste the query or mutation into the editor pane, and then click the "Play" button to run it. You'll then see the response in the right-hand pane.

The Shop API is the public-facing API which is used by the storefront application.

Open the GraphiQL Shop API interface at http://localhost:3000/graphiql/shop.

Let's start with a query. Queries are used to fetch data. We will make a query to get a list of products.

Note that the response only includes the properties we asked for in our query (id and name). This is one of the key benefits of GraphQL - the client can specify exactly which data it needs, and the server will only return that data!

Let's add a few more properties to the query:

You should see that the response now includes the slug, description and featuredAsset properties. Note that the featuredAsset property is itself an object, and we can specify which properties of that object we want to include in the response. This is another benefit of GraphQL - you can "drill down" into the data and specify exactly which properties you want to include.

Now let's add some arguments to the query. Some queries (and most mutations) can accept argument, which you put in parentheses after the query name. For example, let's fetch the first 5 products:

On running this query, you should see just the first 5 results being returned.

Let's add a more complex argument: this time we'll filter for only those products which contain the string "shoe" in the name:

Next, let's look at a mutation. Mutations are used to modify data on the server.

Here's a mutation which adds a product to an order:

This mutation adds a product variant with ID 42 to the order. The response will either be an Order object, or an ErrorResult. We use a special syntax called a **fragment** to specify which properties we want to include in the response. In this case, we are saying that if the response is an Order object, include properties like `id`, `code`, `totalQuantity`, and `totalWithTax`. If it's an ErrorResult, include `errorCode` and `message`.

The **Admin API** requires authentication before accessing protected operations. To log in, use the superadmin credentials:

```graphql
mutation Login {
  login(username: "superadmin", password: "superadmin") {
    ... on CurrentUser {
      id
      identifier
    }
    ... on ErrorResult {
      errorCode
      message
    }
  }
}
```

Once authenticated, you can access extended product information including enabled status, variant details, pricing by currency, and stock levels across locations—data unavailable through the Shop API:

```graphql
query GetProduct {
  product(id: 42) {
    enabled
    name
    variants {
      id
      name
      enabled
      prices {
        currencyCode
        price
      }
      stockLevels {
        stockLocationId
        stockOnHand
        stockAllocated
      }
    }
  }
}
```

**Examples:**

Example 1 (graphql):
```graphql
mutation Login {
  login(username: "superadmin", password: "superadmin") {
    ... on CurrentUser {
      id
      identifier
    }
    ... on ErrorResult {
      errorCode
      message
    }
  }
}
```

Example 2 (graphql):
```graphql
query GetProduct {
  product(id: 42) {
    enabled
    name
    variants {
      id
      name
      enabled
      prices {
        currencyCode
        price
      }
      stockLevels {
        stockLocationId
        stockOnHand
        stockAllocated
      }
    }
  }
}
```

---

## Installation

**URL:** https://docs.vendure.io/guides/getting-started/installation

**Contents:**
- Installation
- Requirements​
  - Optional​
- @vendure/create​
  - Quick Start​
  - Manual Configuration​
    - 1. Select a database​
    - 2. Populate with data​
    - 3. Complete setup​
  - Start the server​

The recommended way to get started with Vendure is by using the @vendure/create tool. This is a command-line tool which will scaffold and configure your new Vendure project and install all dependencies.

First, run the following command in your terminal, replacing my-shop with the name of your project:

Next, choose the "Quick Start" option. This is the fastest way to get a Vendure server up and running and will handle all the configuration for you. If you have Docker Desktop installed, it will create and configure a Postgres database for you. If not, it will use SQLite.

And that's it! After a minute or two, you'll have a fully-functional Vendure server installed locally.

Once the installation is done, your terminal will output a message indicating a successful installation with:

Proceed to the Start the server section below to run your Vendure server.

If you'd rather have more control over the configuration, you can choose the "Manual Configuration" option. This will prompt you to select a database and whether to populate the database with sample data.

Vendure supports a number of different databases. The @vendure/create tool will prompt you to select one.

To quickly test out Vendure, we recommend using SQLite, which requires no external dependencies. You can always switch to a different database later by changing your configuration file.

If you select MySQL, MariaDB, or Postgres, you need to make sure you:

Have the database server running: You can either install the database locally on your machine, use a cloud provider, or run it via Docker. For local development with Docker, you can use the provided docker-compose.yml file in your project.

Have created a database: Use your database client to create an empty database (e.g., CREATE DATABASE vendure; in most SQL databases).

Have database credentials: You need the username and password for a database user that has full permissions (CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT) on the database you created.

For detailed database configuration examples, see the Configuration guide.

The final prompt will ask whether to populate your new Vendure server with some sample product data.

We recommend you do so, as it will give you a good starting point for exploring the APIs, which we will cover in the Try the API section, as well as providing some data to use when building your own storefront.

Next, a project scaffold will be created and dependencies installed. This may take a few minutes.

Once the installation is complete, navigate to your project directory and start the development server:

```bash
cd my-shop
npm run dev
```

In a separate terminal, start the Vite dev server:

```bash
npx vite
```

This will make the following available:
- **Admin GraphQL API**: http://localhost:3000/admin-api
- **Shop GraphQL API**: http://localhost:3000/shop-api
- **Dashboard**: http://localhost:5173/dashboard/

The default superadmin credentials are:
- **Username**: `superadmin`
- **Password**: `superadmin`

**Examples:**

Example 1 (bash):
```bash
npx @vendure/create my-shop
```

Example 2 (text):
```text
┌  Let's create a Vendure App ✨
│
│◆  How should we proceed?
│  ● Quick Start (Get up and running in a single step)
│  ○ Manual Configuration
│
└
```

Example 3 (bash):
```bash
cd my-shop
npm run dev
```

Example 4 (sh):
```sh
npx @vendure/create my-shop --log-level verbose
```

---

## Getting Started

**URL:** https://docs.vendure.io/guides/extending-the-admin-ui/getting-started/

**Contents:**
- Getting Started
- Setup​
- Providers​
  - Providers format​
  - Specifying providers​
- Routes​
- Dev vs Prod mode​
- Compiling as a deployment step​
- Using other frameworks​
- IDE Support​

The Angular-based Admin UI has been replaced by the new React Admin Dashboard. The Angular Admin UI will not be maintained after July 2026. Until then, we will continue patching critical bugs and security issues. Community contributions will always be merged and released.

For new projects, use the React Admin Dashboard instead.

If you want to use the Admin UI and the Dashboard together please change the compatibilityMode to true.

When creating a plugin, you may wish to extend the Admin UI in order to expose a graphical interface to the plugin's functionality, or to add new functionality to the Admin UI itself. The UI can be extended with custom components written in Angular or React.

The APIs described in this section were introduced in Vendure v2.1.0. For the legacy APIs, see the Legacy API section.

UI extensions fall into two categories:

First, install the @vendure/ui-devkit package as a dev dependency:

If you plan to use React components in your UI extensions, you should also install the @types/react package:

You can then create the following folder structure to hold your UI extensions:

Let's add a simple UI extension that adds a new button to the "order list" page. We'll leave the routes file empty for now.

Now we can configure the paths to your UI extension files. By convention, we will add this config object as a static property on your plugin class:

You can then use the compileUiExtensions function to compile your UI extensions and add them to the Admin UI app bundle.

Now when you start the server, the following will happen:

Note: the TypeScript source files of your UI extensions must not be compiled by your regular TypeScript build task. This is because they will instead be compiled by the Angular compiler when you run compileUiExtensions().

You can exclude them in your main tsconfig.json by adding a line to the "exclude" array (this is already defined on a default Vendure project):

How It Works: The Admin UI is an Angular application, and to generate a custom UI including your extensions, it is internally using the powerful Angular CLI to compile the app into an optimized bundle, including code-splitting and lazy-loading any routes which you define.

Your providers.ts file exports an array of objects known as "providers" in Angular terminology. These providers are passed to the application on startup to configure new functionality.

With providers you can:
- Add buttons to action bars
- Add menu items
- Add bulk actions
- Register custom components
- Create dashboard widgets
- Add custom form inputs
- Add history timeline entries

A providers file should have a **default export** which is an array of provider objects.

**Basic Providers Example:**

```typescript
import { addActionBarItem } from '@vendure/admin-ui/core';

export default [
    addActionBarItem({
        id: 'test-button',
        label: 'Test Button',
        locationId: 'order-list',
    }),
];
```

**Specifying Providers in Configuration:**

When defining UI extensions, specify provider file paths relative to the `extensionPath` directory:

```typescript
import { compileUiExtensions } from '@vendure/ui-devkit/compiler';
import * as path from 'path';

compileUiExtensions({
    outputPath: path.join(__dirname, '../admin-ui'),
    extensions: [
        {
            id: 'test-extension',
            extensionPath: path.join(__dirname, 'plugins/my-plugin/ui'),
            providers: ['providers.ts'],
        },
    ],
    devMode: true,
});
```

**Routes Configuration:**

Routes enable custom views within the Admin UI. Define routes in a `routes.ts` file and reference them in your plugin configuration:

```typescript
static ui: AdminUiExtension = {
    id: 'my-plugin-ui',
    extensionPath: path.join(__dirname, 'ui'),
    routes: [{ route: 'my-plugin', filePath: 'routes.ts' }],
    providers: ['providers.ts'],
};
```

**Development vs Production Mode:**

For **development**, enable hot-reloading with automatic browser refresh:

```typescript
compileUiExtensions({
    outputPath: path.join(__dirname, '../admin-ui'),
    extensions: [/* ... */],
    devMode: true,
})
```

For **production**, compile as a standalone deployment step:

```typescript
import { compileUiExtensions } from '@vendure/ui-devkit/compiler';
import * as path from 'path';

compileUiExtensions({
    outputPath: path.join(__dirname, '../admin-ui'),
    extensions: [/* ... */],
})
    .compile?.()
    .then(() => process.exit(0));
```

Run via command line:

```bash
npx ts-node src/compile-admin-ui.ts
```

Reference the compiled output in production:

```typescript
AdminUiPlugin.init({
    port: 3002,
    app: {
        path: path.join(__dirname, '../admin-ui/dist/browser'),
    },
})
```

**Examples:**

Example 1 (bash):
```bash
npm install --save-dev @vendure/ui-devkit
```

Example 2 (bash):
```bash
yarn add --dev @vendure/ui-devkit
```

Example 3 (bash):
```bash
npm install --save-dev @types/react
```

Example 4 (bash):
```bash
yarn add --dev @types/react
```

---
