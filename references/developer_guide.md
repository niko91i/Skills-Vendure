# Vendure - Developer Guide

**Pages:** 48

---

## CLI

**URL:** https://docs.vendure.io/guides/developer-guide/cli/

**Contents:**
- CLI
- Installation​
- Interactive vs Non-Interactive Mode​
- The Add Command​
  - Interactive Mode​
  - Non-Interactive Mode​
    - Add Command Options​
    - Sub-options for specific commands​
- The Migrate Command​
  - Interactive Mode​

The Vendure CLI is a command-line tool for boosting your productivity as a developer by automating common tasks such as creating new plugins, entities, API extensions and more.

It is much more than just a scaffolding tool - it is able to analyze your project and intelligently modify your existing codebase to integrate new functionality.

The Vendure CLI comes installed with a new Vendure project by default from v2.2.0+

To manually install the CLI, run:

The Vendure CLI supports both interactive and non-interactive modes:

The add command is used to add new entities, resolvers, services, plugins, and more to your Vendure project.

From your project's root directory, run:

The CLI will guide you through the process of adding new functionality to your project.

The add command is much more than a simple file generator. It is able to analyze your project source code to deeply understand and correctly update your project files.

For automation or when you know exactly what you need to add, you can use the non-interactive mode with specific arguments and options:

Entity (-e) additional options:

Service (-s) additional options:

Job Queue (-j) additional options:

API Extension (-a) additional options: (requires either)

Validation: Entity and service commands validate that the specified plugin exists in your project. If the plugin is not found, the command will list all available plugins in the error message. Both commands require the --selected-plugin parameter when running in non-interactive mode.

The migrate command is used to generate and manage database migrations for your Vendure project.

From your project's root directory, run:

For migration operations, use specific arguments and options:

The schema command was added in Vendure v3.5

The schema command allows you to generate a schema file for your Admin or Shop APIs, in either the GraphQL schema definition language (SDL) or as JSON.

This is useful when integrating with GraphQL tooling such as your IDE's GraphQL plugin.

From your project's root directory, run:

To automate or quickly generate a schema in one command

To see all available commands and options:

**Examples:**

Example 1 (bash):
```bash
npm install -D @vendure/cli
```

Example 2 (bash):
```bash
yarn add -D @vendure/cli
```

Example 3 (bash):
```bash
npx vendure add
```

Example 4 (bash):
```bash
yarn vendure add
```

---

## Security

**URL:** https://docs.vendure.io/guides/developer-guide/security

**Contents:**
- Security
- Basics​
  - Change the default credentials​
  - Use the HardenPlugin​
  - Harden the AssetServerPlugin​
- OWASP Top Ten Security Assessment​
  - 1. Broken Access Control​
  - 2. Cryptographic Failures​
  - 3. Injection​
  - 4. Insecure Design​

Security of your Vendure application includes considering how to prevent and protect against common security threats such as:

Vendure itself is designed with security in mind, but you must also consider the security of your own application code, the server environment, and the network architecture.

Here are some basic measures you should use to secure your Vendure application. These are not exhaustive, but they are a good starting point.

Do not deploy any public Vendure instance with the default superadmin credentials (superadmin:superadmin). Use your hosting platform's environment variables to set a strong password for the Superadmin account.

It is recommended that you install and configure the HardenPlugin for all production deployments. This plugin locks down your schema (disabling introspection and field suggestions) and protects your Shop API against malicious queries that could otherwise overwhelm your server.

Then add it to your VendureConfig:

For a detailed explanation of how to best configure this plugin, see the HardenPlugin docs.

If you are using the AssetServerPlugin, it is possible by default to use the dynamic image transform feature to overload the server with requests for new image sizes & formats. To prevent this, you can configure the plugin to only allow transformations for the preset sizes, and limited quality levels and formats. Since v3.1 we ship the PresetOnlyStrategy for this purpose, and you can also create your own strategies.

The Open Worldwide Application Security Project (OWASP) is a nonprofit foundation that works to improve the security of software.

It publishes a top 10 list of common web application vulnerabilities: https://owasp.org/Top10

This section assesses Vendure against this list, stating what is covered out of the box (built in to the framework or easily configurable) and what needs to be additionally considered.

Reference: https://owasp.org/Top10/A01_2021-Broken_Access_Control/

Reference: https://owasp.org/Top10/A02_2021-Cryptographic_Failures/

Reference: https://owasp.org/Top10/A03_2021-Injection/

Reference: https://owasp.org/Top10/A04_2021-Insecure_Design/

Reference: https://owasp.org/Top10/A05_2021-Security_Misconfiguration/

Reference: https://owasp.org/Top10/A06_2021-Vulnerable_and_Outdated_Components/

Reference: https://owasp.org/Top10/A07_2021-Identification_and_Authentication_Failures/

Reference: https://owasp.org/Top10/A08_2021-Software_and_Data_Integrity_Failures/

Reference: https://owasp.org/Top10/A09_2021-Security_Logging_and_Monitoring_Failures/

Reference: https://owasp.org/Top10/A10_2021-Server-Side_Request_Forgery_(SSRF)/

The security page provides a comprehensive assessment mapping Vendure's built-in protections against all 10 OWASP vulnerabilities, including cryptographic defaults (bcrypt with 12 salt rounds), parameterized database queries, role-based access control, and GraphQL validation safeguards.

**Examples:**

Example 1 (ts):
```ts
import { VendureConfig } from '@vendure/core';

export const config: VendureConfig = {
  authOptions: {
    tokenMethod: ['bearer', 'cookie'],
    superadminCredentials: {
      identifier: process.env.SUPERADMIN_USERNAME,
      password: process.env.SUPERADMIN_PASSWORD,
    },
  },
  // ...
};
```

Example 2 (sh):
```sh
npm install @vendure/harden-plugin
# or
yarn add @vendure/harden-plugin
```

Example 3 (ts):
```ts
import { VendureConfig } from '@vendure/core';import { HardenPlugin } from '@vendure/harden-plugin';const IS_DEV = process.env.APP_ENV === 'dev';export const config: VendureConfig = {  // ...  plugins: [    HardenPlugin.init({      maxQueryComplexity: 500,      apiMode: IS_DEV ? 'dev' : 'prod',    }),    // ...  ]};
```

Example 4 (ts):
```ts
import { VendureConfig } from '@vendure/core';import { AssetServerPlugin, PresetOnlyStrategy } from '@vendure/asset-server-plugin';export const config: VendureConfig = {  // ...  plugins: [    AssetServerPlugin.init({      // ...      imageTransformStrategy: new PresetOnlyStrategy({        defaultPreset: 'large',        permittedQuality: [0, 50, 75, 85, 95],        permittedFormats: ['jpg', 'webp', 'avif'],        allowFocalPoint: false,      }),    }),  ]};
```

---

## Uploading Files

**URL:** https://docs.vendure.io/guides/developer-guide/uploading-files

**Contents:**
- Uploading Files
- Upload clients​
- The createAssets mutation​
- Custom upload mutations​
  - Configuration​
  - Schema definition​
  - Resolver​
  - Complete Customer Avatar Plugin​
  - Uploading a Customer Avatar​

Vendure handles file uploads with the GraphQL multipart request specification. Internally, we use the graphql-upload package. Once uploaded, a file is known as an Asset. Assets are typically used for images, but can represent any kind of binary data such as PDF files or videos.

Here is a list of client implementations that will allow you to upload files using the spec. If you are using Apollo Client, then you should install the apollo-upload-client npm package.

For testing, it is even possible to use a plain curl request.

The createAssets mutation in the Admin API is the only means of uploading files by default.

Here's an example of how a file upload would look using the apollo-upload-client package:

How about if you want to implement a custom mutation for file uploads? Let's take an example where we want to allow customers to set an avatar image. To do this, we'll add a custom field to the Customer entity and then define a new mutation in the Shop API.

Let's define a custom field to associate the avatar Asset with the Customer entity. To keep everything encapsulated, we'll do all of this in a plugin

Next, we will define the schema for the mutation:

The resolver will make use of the built-in AssetService to handle the processing of the uploaded file into an Asset.

Let's put all these parts together into the plugin:

In our storefront, we would then upload a Customer's avatar like this:

**Examples:**

Example 1 (tsx):
```tsx
import { gql, useMutation } from "@apollo/client";const MUTATION = gql`  mutation CreateAssets($input: [CreateAssetInput!]!) {    createAssets(input: $input) {      ... on Asset {        id        name        fileSize      }      ... on ErrorResult {        message      }    }  }`;function UploadFile() {    const [mutate] = useMutation(MUTATION);    function onChange(event) {        const {target} = event;        if (target.validity.valid) {            mutate({                variables: {                    input: Array.from(target.files).map((file) => ({file}));                }            })
...
```

Example 2 (ts):
```ts
import { Asset, LanguageCode, PluginCommonModule, VendurePlugin } from '@vendure/core';@VendurePlugin({    imports: [PluginCommonModule],    configure: config => {        config.customFields.Customer.push({            name: 'avatar',            type: 'relation',            label: [{languageCode: LanguageCode.en, value: 'Customer avatar'}],            entity: Asset,            nullable: true,        });        return config;    },})export class CustomerAvatarPlugin {}
```

Example 3 (ts):
```ts
import gql from 'graphql-tag';export const shopApiExtensions = gql`extend type Mutation {  setCustomerAvatar(file: Upload!): Asset}`
```

Example 4 (ts):
```ts
import { Args, Mutation, Resolver } from '@nestjs/graphql';import { Asset } from '@vendure/common/lib/generated-types';import {    Allow, AssetService, Ctx, CustomerService, isGraphQlErrorResult,    Permission, RequestContext, Transaction} from '@vendure/core';@Resolver()export class CustomerAvatarResolver {    constructor(private assetService: AssetService, private customerService: CustomerService) {}    @Transaction()    @Mutation()    @Allow(Permission.Authenticated)    async setCustomerAvatar(        @Ctx() ctx: RequestContext,        @Args() args: { file: any },    ): Promise<Asset | unde
...
```

---

## Custom Strategies in Plugins

**URL:** https://docs.vendure.io/guides/developer-guide/custom-strategies-in-plugins/

**Contents:**
- Custom Strategies in Plugins
- Overview​
- Creating a Strategy Interface​
- Implementing a Default Strategy​
- Adding Strategy to Plugin Options​
- Configuring the Plugin​
- Using the Strategy in Services​
- User Implementation Example​
- Plugin Configuration by Users​
- Strategy with Options​

When building Vendure plugins, you often need to provide extensible, pluggable implementations for specific features. The strategy pattern is the perfect tool for this, allowing plugin users to customize behavior by providing their own implementations.

This guide shows you how to implement custom strategies in your plugins, following Vendure's established patterns and best practices.

A strategy in Vendure is a way to provide a pluggable implementation of a particular feature. Custom strategies in plugins allow users to:

First, define the interface that your strategy must implement. All strategy interfaces should extend InjectableStrategy to support dependency injection and lifecycle methods.

Create a default implementation that users can extend or replace:

Define your plugin's initialization options to include the strategy:

In your plugin definition, provide the default strategy and allow users to override it:

Access the strategy through dependency injection in your services:

Plugin users can now provide their own strategy implementations:

Users configure the plugin with their custom strategy:

You can also create strategies that accept configuration options:

For complex plugins, you might need multiple strategies:

Always provide a default implementation so users can use your plugin out-of-the-box:

Always implement proper init/destroy handling in your plugin:

Provide strong typing for better developer experience:

Provide comprehensive JSDoc comments:

Custom strategies in plugins provide a powerful way to make your plugins extensible and configurable. By following the patterns outlined in this guide, you can:

This approach ensures your plugins are flexible, maintainable, and follow Vendure's established conventions.

**Examples:**

Example 1 (ts):
```ts
import { InjectableStrategy, RequestContext } from '@vendure/core';export interface MyCustomStrategy extends InjectableStrategy {    /**     * Process some data and return a result     */    processData(ctx: RequestContext, data: any): Promise<string>;    /**     * Validate the input data     */    validateInput(data: any): boolean;}
```

Example 2 (ts):
```ts
import { Injector, RequestContext, Logger } from '@vendure/core';import { MyCustomStrategy } from './my-custom-strategy';import { SomeOtherService } from '../services/some-other.service';import { loggerCtx } from '../constants';export class DefaultMyCustomStrategy implements MyCustomStrategy {    private someOtherService: SomeOtherService;    async init(injector: Injector): Promise<void> {        // Inject dependencies during the init phase        this.someOtherService = injector.get(SomeOtherService);        // Perform any setup logic        Logger.info('DefaultMyCustomStrategy initialized', 
...
```

Example 3 (ts):
```ts
import { MyCustomStrategy } from './strategies/my-custom-strategy';export interface MyPluginInitOptions {    /**     * Custom strategy for processing data     * @default DefaultMyCustomStrategy     */    processingStrategy?: MyCustomStrategy;    /**     * Other plugin options     */    someOtherOption?: string;}
```

Example 4 (ts):
```ts
import { PluginCommonModule, VendurePlugin, Injector } from '@vendure/core';import { OnApplicationBootstrap, OnApplicationShutdown } from '@nestjs/common';import { ModuleRef } from '@nestjs/core';import { MY_PLUGIN_OPTIONS } from './constants';import { MyPluginInitOptions } from './types';import { DefaultMyCustomStrategy } from './strategies/default-my-custom-strategy';import { MyPluginService } from './services/my-plugin.service';import { SomeOtherService } from './services/some-other.service';@VendurePlugin({    imports: [PluginCommonModule],    providers: [        MyPluginService,        So
...
```

---

## Migrating from Vendure 1 to 2

**URL:** https://docs.vendure.io/guides/developer-guide/migrating-from-v1/

**Contents:**
- Migrating from Vendure 1 to 2
- Migration steps​

This section contains guides for migrating from Vendure v1 to v2.

There are a number of breaking changes between the two versions, which are due to a few major factors:

Migration will consist of these main steps:

**Examples:**

Example 1 (diff):
```diff
{  // ...  "dependencies": {-    "@vendure/common": "1.9.7",-    "@vendure/core": "1.9.7",+    "@vendure/common": "2.0.0",+    "@vendure/core": "2.0.0",     // etc.  },  "devDependencies": {-    "typescript": "4.3.5",+    "typescript": "4.9.5",     // etc.  }}
```

---

## The Service Layer

**URL:** https://docs.vendure.io/guides/developer-guide/the-service-layer/

**Contents:**
- The Service Layer
- Using core services​
- Accessing the database​
  - The Find API​
  - The QueryBuilder API​
  - Working with relations​
  - Using the EntityHydrator​
  - Joining relations in built-in service methods​

The service layer is the core of the application. This is where the business logic is implemented, and where the application interacts with the database. When a request comes in to the API, it gets routed to a resolver which then calls a service method to perform the required operation.

Services are classes which, in NestJS terms, are providers. They follow all the rules of NestJS providers, including dependency injection, scoping, etc.

Services are generally scoped to a specific domain or entity. For instance, in the Vendure core, there is a Product entity, and a corresponding ProductService which contains all the methods for interacting with products.

Here's a simplified example of a ProductService, including an implementation of the findOne() method that was used in the example in the previous section:

All the internal Vendure services can be used in your own plugins and scripts. They are listed in the Services API reference and can be imported from the @vendure/core package.

To make use of a core service in your own plugin, you need to ensure your plugin is importing the PluginCommonModule and then inject the desired service into your own service's constructor:

One of the main responsibilities of the service layer is to interact with the database. For this, you will be using the TransactionalConnection class, which is a wrapper around the TypeORM DataSource object. The primary purpose of the TransactionalConnection is to ensure that database operations can be performed within a transaction (which is essential for ensuring data integrity), even across multiple services. Furthermore, it exposes some helper methods which make it easier to perform common operations.

Always pass the RequestContext (ctx) to the TransactionalConnection methods. This ensures the operation occurs within any active transaction.

There are two primary APIs for accessing data provided by TypeORM: the Find API and the QueryBuilder API.

This API is the most convenient and type-safe way to query the database. It provides a powerful type-safe way to query including support for eager relations, pagination, sorting, filtering and more.

Here are some examples of using the Find API:

Further examples can be found in the TypeORM Find Options documentation.

When the Find API is not sufficient, the QueryBuilder API can be used to construct more complex queries. For instance, if you want to have a more complex WHERE clause than what can be achieved with the Find API, or if you want to use sub-queries or other advanced SQL features.

**QueryBuilder API Usage:**

The QueryBuilder provides more granular control over database queries but requires explicit relation joins:

```typescript
const products = await this.connection.getRepository(ctx, Product)
  .createQueryBuilder('product')
  .leftJoinAndSelect('product.variants', 'variant')
  .leftJoinAndSelect('variant.prices', 'price')
  .where('product.deletedAt IS NULL')
  .andWhere('variant.enabled = :enabled', { enabled: true })
  .getMany();
```

**Critical Pattern for Relations:**

A significant challenge arises when relations aren't explicitly joined—code compiles successfully but fails at runtime. Always explicitly specify relations through the `relations` option in the Find API or using `leftJoinAndSelect()` in QueryBuilder queries.

**Entity Hydration Solution:**

The `EntityHydrator` class addresses scenarios where you receive entities from Vendure without controlling the initial database fetch. It ensures specific relations are loaded before use:

```typescript
import { EntityHydrator } from '@vendure/core';

@Injectable()
export class MyService {
  constructor(private entityHydrator: EntityHydrator) {}

  async processProduct(ctx: RequestContext, product: Product) {
    // Ensure the variants relation is loaded
    await this.entityHydrator.hydrate(ctx, product, {
      relations: ['variants', 'variants.prices'],
    });

    // Now we can safely access product.variants
    const variantCount = product.variants.length;
  }
}
```

**Examples:**

Example 1 (ts):
```ts
import { Injectable } from '@nestjs/common';import { IsNull } from 'typeorm';import { ID, Product, RequestContext, TransactionalConnection, TranslatorService } from '@vendure/core';@Injectable()export class ProductService {    constructor(private connection: TransactionalConnection,                private translator: TranslatorService){}    /**     * @description     * Returns a Product with the given id, or undefined if not found.     */    async findOne(ctx: RequestContext, productId: ID): Promise<Product | undefined> {        const product = await this.connection.findOneInChannel(ctx, Produ
...
```

Example 2 (ts):
```ts
import { PluginCommonModule, VendurePlugin } from '@vendure/core';import { MyService } from './services/my.service';@VendurePlugin({    imports: [PluginCommonModule],    providers: [MyService],})export class MyPlugin {}
```

Example 3 (ts):
```ts
import { Injectable } from '@nestjs/common';import { ProductService } from '@vendure/core';@Injectable()export class MyService {    constructor(private productService: ProductService) {}    // you can now use the productService methods}
```

Example 4 (ts):
```ts
import { Injectable } from '@nestjs/common';import { ID, RequestContext, TransactionalConnection } from '@vendure/core';import { IsNull } from 'typeorm';import { Item } from '../entities/item.entity';@Injectable()export class ItemService {    constructor(private connection: TransactionalConnection) {}    findById(ctx: RequestContext, itemId: ID): Promise<Item | null> {        return this.connection.getRepository(ctx, Item).findOne({            where: { id: itemId },        });    }    findByName(ctx: RequestContext, name: string): Promise<Item | null> {        return this.connection.getReposit
...
```

---

## Error Handling

**URL:** https://docs.vendure.io/guides/developer-guide/error-handling

**Contents:**
- Error Handling
- Unexpected Errors​
- Expected errors (ErrorResults)​
  - Querying an ErrorResult union​
  - Handling ErrorResults in plugin code​
  - Handling ErrorResults in client code​
- Live example​

Errors in Vendure can be divided into two categories:

These two types have different meanings and are handled differently from one another.

This type of error occurs when something goes unexpectedly wrong during the processing of a request. Examples include internal server errors, database connectivity issues, lacking permissions for a resource, etc. In short, these are errors that are not supposed to happen.

Internally, these situations are handled by throwing an Error:

In the GraphQL APIs, these errors are returned in the standard errors array:

So your client applications need a generic way of detecting and handling this kind of error. For example, many http client libraries support "response interceptors" which can be used to intercept all API responses and check the errors array.

GraphQL will return a 200 status even if there are errors in the errors array. This is because in GraphQL it is still possible to return good data alongside any errors.

Here's how it might look in a simple Fetch-based client:

This type of error represents a well-defined result of (typically) a GraphQL mutation which is not considered "successful". For example, when using the applyCouponCode mutation, the code may be invalid, or it may have expired. These are examples of "expected" errors and are named in Vendure "ErrorResults". These ErrorResults are encoded into the GraphQL schema itself.

ErrorResults all implement the ErrorResult interface:

Some ErrorResults add other relevant fields to the type:

Operations that may return ErrorResults use a GraphQL union as their return type:

When performing an operation of a query or mutation which returns a union, you will need to use the GraphQL conditional fragment to select the desired fields:

The __typename field is added by GraphQL to all object types, so we can include it no matter whether the result will end up being an Order object or an ErrorResult object. We can then use the __typename value to determine what kind of object we have received.

Some clients such as Apollo Client will automatically add the __typename field to all queries and mutations. If you are using a client which does not do this, you will need to add it manually.

Here's how a response would look in both the success and error result cases:

If you are writing a plugin which deals with internal Vendure service methods that may return ErrorResults, then you can use the isGraphQlErrorResult() function to check whether the result is an ErrorResult:

```typescript
import { Injectable } from '@nestjs/common';
import { isGraphQlErrorResult, Order, OrderService, RequestContext } from '@vendure/core';

@Injectable()
export class MyService {
  constructor(private orderService: OrderService) {}

  async myMethod(ctx: RequestContext, order: Order, newState: OrderState) {
    const transitionResult = await this.orderService.transitionToState(
      ctx,
      order.id,
      newState
    );

    if (isGraphQlErrorResult(transitionResult)) {
      // Handle the error
      throw transitionResult;
    }

    // Success - transitionResult is now typed as Order
    return transitionResult;
  }
}
```

**Best Practices:**

1. **Client-Side**: Use exhaustive switch statements with `__typename` to handle all possible result types
2. **Plugin Code**: Use `isGraphQlErrorResult()` to differentiate ErrorResults from successful responses
3. **Type Safety**: Leverage TypeScript's type narrowing after error checks
4. **Error Propagation**: Throw ErrorResults in plugin code to propagate them up to GraphQL responses

**Examples:**

Example 1 (ts):
```ts
const customer = await this.findOneByUserId(ctx, user.id);// in this case, the customer *should always* be found, and if// not then something unknown has gone wrong...if (!customer) {    throw new InternalServerError('error.cannot-locate-customer-for-user');}
```

Example 2 (json):
```json
{  "errors": [    {      "message": "You are not currently authorized to perform this action",      "locations": [        {          "line": 2,          "column": 2        }      ],      "path": [        "me"      ],      "extensions": {        "code": "FORBIDDEN"      }    }  ],  "data": {    "me": null  }}
```

Example 3 (ts):
```ts
export function query(document: string, variables: Record<string, any> = {}) {    return fetch(endpoint, {        method: 'POST',        headers,        credentials: 'include',        body: JSON.stringify({            query: document,            variables,        }),    })        .then(async (res) => {            if (!res.ok) {                const body = await res.json();                throw new Error(body);            }            const newAuthToken = res.headers.get('vendure-auth-token');            if (newAuthToken) {                localStorage.setItem(AUTH_TOKEN_KEY, newAuthToken);     
...
```

Example 4 (graphql):
```graphql
interface ErrorResult {  errorCode: ErrorCode!  message: String!}
```

---

## Defining database subscribers

**URL:** https://docs.vendure.io/guides/developer-guide/db-subscribers/

**Contents:**
- Defining database subscribers
- Simple subscribers​
- Injectable subscribers​
- Troubleshooting subscribers​

TypeORM allows us to define subscribers. With a subscriber, we can listen to specific entity events and take actions based on inserts, updates, deletions and more.

If you need lower-level access to database changes that you get with the Vendure EventBus system, TypeORM subscribers can be useful.

The simplest way to register a subscriber is to pass it to the dbConnectionOptions.subscribers array:

The limitation of this method is that the ProductSubscriber class cannot make use of dependency injection, since it is not known to the underlying NestJS application and is instead instantiated by TypeORM directly.

If you need to make use of providers in your subscriber class, you'll need to use the following pattern.

By defining the subscriber as an injectable provider, and passing it to a Vendure plugin, you can take advantage of Nest's dependency injection inside the subscriber methods.

An important factor when working with TypeORM subscribers is that they are very low-level and require some understanding of the Vendure schema.

For example consider the ProductSubscriber above. If an admin changes a product's name in the Dashboard, this subscriber will not fire. The reason is that the name property is actually stored on the ProductTranslation entity, rather than on the Product entity.

So if your subscribers do not seem to work as expected, check your database schema and make sure you are really targeting the correct entity which has the property that you are interested in.

**Examples:**

Example 1 (ts):
```ts
import { Product, VendureConfig } from '@vendure/core';import { EntitySubscriberInterface, EventSubscriber, UpdateEvent } from 'typeorm';@EventSubscriber()export class ProductSubscriber implements EntitySubscriberInterface<Product> {  listenTo() {    return Product;  }    beforeUpdate(event: UpdateEvent<Product>) {    console.log(`BEFORE PRODUCT UPDATED: `, event.entity);  }}
```

Example 2 (ts):
```ts
import { VendureConfig } from '@vendure/core';import { ProductSubscriber } from './plugins/my-plugin/product-subscriber';// ...export const config: VendureConfig = {  dbConnectionOptions: {    // ...    subscribers: [ProductSubscriber],  }}
```

Example 3 (ts):
```ts
import {  PluginCommonModule,  Product,  TransactionalConnection,  VendureConfig,  VendurePlugin,} from '@vendure/core';import { Injectable } from '@nestjs/common';import { EntitySubscriberInterface, EventSubscriber, UpdateEvent } from 'typeorm';import { MyService } from './services/my.service';@Injectable()@EventSubscriber()export class ProductSubscriber implements EntitySubscriberInterface<Product> {    constructor(private connection: TransactionalConnection,                private myService: MyService) {        // This is how we can dynamically register the subscriber        // with TypeORM
...
```

Example 4 (ts):
```ts
@VendurePlugin({    imports: [PluginCommonModule],    providers: [ProductSubscriber, MyService],})class MyPlugin {}
```

---

## GraphQL Dataloaders

**URL:** https://docs.vendure.io/guides/developer-guide/dataloaders/

**Contents:**
- GraphQL Dataloaders
- N+1 problem​
- The solution: dataloaders​
- Performance implications​
- Do I need this for CustomField relations?​
- Example​

Dataloaders are used in GraphQL to solve the so called N+1 problem. This is an advanced performance optimization technique you may want to use in your application if you find certain custom queries are slow or inefficient.

Imagine a cart with 20 items. Your implementation requires you to perform an async calculation isSubscription for each cart item which executes one or more queries each time it is called, and it takes pretty long on each execution. It works fine for a cart with 1 or 2 items. But with more than 15 items, suddenly the cart takes a lot longer to load. Especially when the site is busy.

The reason: the N+1 problem. Your cart is firing of 20 or more queries almost at the same time, adding significantly to the GraphQL request. It's like going to the McDonald's drive-in to get 10 hamburgers and getting in line 10 times to get 1 hamburger at a time. It's not efficient.

Dataloaders allow you to say: instead of loading each field in the grapqhl tree one at a time, aggregate all the ids you want to execute the async calculation for, and then execute this for all the ids in one efficient request.

Dataloaders are generally used on fieldResolvers. Often, you will need a specific dataloader for each field resolver.

A Dataloader can return anything: boolean, ProductVariant, string, etc.

Dataloaders can have a huge impact on performance. If your fieldResolver executes queries, and you log these queries, you should see a cascade of queries before the implementation of the dataloader, change to a single query using multiple ids after you implement it.

No, not normally. CustomField relations are automatically added to the root query for the entity that they are part of. So, they are loaded as part of the query that loads that entity.

We will provide a complete example here for you to use as a starting point. The skeleton created can handle multiple dataloaders across multiple channels. We will implement a fieldResolver called isSubscription for an OrderLine that will return a true/false for each incoming orderLine, to indicate whether the orderLine represents a subscription.

This next part import the dataloader package, which you can install with

To make it all work, ensure that the DataLoaderService is loaded in your plugin as a provider.

Dataloaders map the result in the same order as the ids you send to the dataloader. Dataloaders expect the same order and array size in the return result.

In other words: ensure that the order of your returned results matches the input IDs exactly, and include all values without omission. This is critical for correct dataloader operation.

**Performance Impact:**

When properly implemented, dataloaders transform observable query patterns. Before optimization, you'll see cascading queries for each item; after implementation, you'll observe a single query using multiple IDs. This batching approach provides substantial performance improvements, particularly under high system load with larger datasets.

**Key Implementation Points:**

1. **Request-Scoped**: DataLoaderService operates at the GraphQL request scope level
2. **Channel-Specific**: Dataloaders are organized by channel for multi-tenant support
3. **No CustomField Relations Needed**: CustomField relations are automatically included in root entity queries
4. **Service Registration**: The DataloaderService must be registered as a provider in your plugin configuration

**Examples:**

Example 1 (ts):
```ts
import gql from 'graphql-tag';export const shopApiExtensions = gql`    extend type OrderLine {        isSubscription: Boolean!    }`
```

Example 2 (sh):
```sh
npm install dataloader
```

Example 3 (ts):
```ts
import DataLoader from 'dataloader'const LoggerCtx = 'SubscriptionDataloaderService'@Injectable({ scope: Scope.REQUEST }) // Important! Dataloaders live at the request levelexport class DataloaderService {  /**   * first level is channel identifier, second level is dataloader key   */  private loaders = new Map<string, Map<string, DataLoader<ID, any>>>()  constructor(private service: SubscriptionExtensionService) {}  getLoader(ctx: RequestContext, dataloaderKey: string) {    const token = ctx.channel?.code ?? `${ctx.channelId}`        Logger.debug(`Dataloader retrieval: ${token}, ${dataloaderK
...
```

Example 4 (ts):
```ts
@Resolver(() => OrderLine)export class MyPluginOrderLineEntityResolver {  constructor(    private dataloaderService: DataloaderService,  ) {}  @ResolveField()  isSubscription(@Ctx() ctx: RequestContext, @Parent() parent: OrderLine) {    const loader = this.dataloaderService.getLoader(ctx, 'is-subscription')    return loader.load(parent.id)  }}
```

---

## Implementing Translatable

**URL:** https://docs.vendure.io/guides/developer-guide/translatable

**Contents:**
- Implementing Translatable
- Defining translatable entities​
  - Translations in the GraphQL schema​
- Creating translatable entities​
- Updating translatable entities​
- Loading translatable entities​

Making an entity translatable means that string properties of the entity can have a different values for multiple languages. To make an entity translatable, you need to implement the Translatable interface and add a translations property to the entity.

The translations property is a OneToMany relation to the translations. Any fields that are to be translated are of type LocaleString, and do not have a @Column() decorator. This is because the text field here does not in fact exist in the database in the product_request table. Instead, it belongs to the product_request_translations table of the ProductRequestTranslation entity:

Thus there is a one-to-many relation between ProductRequest and ProductRequestTranslation, which allows Vendure to handle multiple translations of the same entity. The ProductRequestTranslation entity also implements the Translation interface, which requires the languageCode field and a reference to the base entity.

Since the text field is getting hydrated with the translation it should be exposed in the GraphQL Schema. Additionally, the ProductRequestTranslation type should be defined as well, to access other translations as well:

Creating a translatable entity is usually done by using the TranslatableSaver. This injectable service provides a create and update method which can be used to save or update a translatable entity.

Important for the creation of translatable entities is the input object. The input object should contain a translations array with the translations for the entity. This can be done by defining the types like CreateRequestInput inside the GraphQL schema:

Updating a translatable entity is done in a similar way as creating one. The TranslatableSaver provides an update method which can be used to update a translatable entity.

Once again it's important to provide the translations array in the input object. This array should contain the translations for the entity.

If your plugin needs to load a translatable entity, you will need to use the TranslatorService to hydrate all the LocaleString fields will the actual translated values from the correct translation.

**Examples:**

Example 1 (ts):
```ts
import { DeepPartial } from '@vendure/common/lib/shared-types';import { VendureEntity, Product, EntityId, ID, Translatable } from '@vendure/core';import { Column, Entity, ManyToOne } from 'typeorm';import { ProductRequestTranslation } from './product-request-translation.entity';@Entity()class ProductRequest extends VendureEntity implements Translatable {    constructor(input?: DeepPartial<ProductRequest>) {        super(input);    }    text: LocaleString;        @ManyToOne(type => Product)    product: Product;    @EntityId()    productId: ID;    @OneToMany(() => ProductRequestTranslation, tran
...
```

Example 2 (ts):
```ts
import { DeepPartial } from '@vendure/common/lib/shared-types';import { HasCustomFields, Translation, VendureEntity, LanguageCode } from '@vendure/core';import { Column, Entity, Index, ManyToOne } from 'typeorm';import { ProductRequest } from './release-note.entity';@Entity()export class ProductRequestTranslation    extends VendureEntity    implements Translation<ProductRequest>, HasCustomFields{    constructor(input?: DeepPartial<Translation<ProductRequestTranslation>>) {        super(input);    }    @Column('varchar')    languageCode: LanguageCode;    @Column('varchar')    text: string; // s
...
```

Example 3 (graphql):
```graphql
type ProductRequestTranslation {    id: ID!    createdAt: DateTime!    updatedAt: DateTime!    languageCode: LanguageCode!    text: String!}type ProductRequest implements Node {    id: ID!    createdAt: DateTime!    updatedAt: DateTime!    # Will be filled with the translation for the current language    text: String!    translations: [ProductRequestTranslation!]!}
```

Example 4 (ts):
```ts
export class RequestService {    constructor(private translatableSaver: TranslatableSaver) {}    async create(ctx: RequestContext, input: CreateProductRequestInput): Promise<ProductRequest> {        const request = await this.translatableSaver.create({            ctx,            input,            entityType: ProductRequest,            translationType: ProductRequestTranslation,            beforeSave: async f => {                // Assign relations here            },        });        return request;    }}
```

---

## Migrations

**URL:** https://docs.vendure.io/guides/developer-guide/migrations

**Contents:**
- Migrations
- Synchronize vs migrate​
- Migration workflow​
  - 1. Generate a migration​
  - 2. Check the migration file​
  - 3. Run the migration​
- Migrations in-depth​
  - Reverting a migration​

Database migrations are needed whenever the database schema changes. This can be caused by:

TypeORM (which Vendure uses to interact with the database) has a synchronize option which, when set to true, will automatically update your database schema to reflect the current Vendure configuration. This is equivalent to automatically generating and running a migration every time the server starts up.

This is convenient while developing, but should not be used in production, since a misconfiguration could potentially delete production data. In this case, migrations should be used.

This section assumes a standard Vendure installation based on @vendure/create.

Let's assume you have defined a new "keywords" custom field on the Product entity. The next time you start your server you'll see a message like this:

Since we have synchronize set to false, we need to generate a migration to apply these changes to the database. The workflow for this is as follows:

Run npx vendure migrate and select "Generate a new migration"

This will have created a new migration file in the src/migrations directory. Open this file and check that it looks correct. It should look something like this:

The up() function is what will be executed when the migration is run. The down() function is what will be executed if the migration is reverted. In this case, the up() function is adding a new column to the product table, and the down() function is removing it.

The exact query will depend on the database you are using. The above example is for PostgreSQL.

Assuming the migration file looks correct, the next time you start the server, the migration will be run automatically. This is because the runMigrations function is called in the src/index.ts file:

It is also possible to run the migration manually without starting the server:

Run npx vendure migrate and select "Run pending migrations"

TypeORM will attempt to run each migration inside a transaction. This means that if one of the migration commands fails, then the entire transaction will be rolled back to its original state.

However this is not supported by MySQL / MariaDB. This means that when using MySQL or MariaDB, errors in your migration script could leave your database in a broken or inconsistent state. Therefore it is critical that you first create a backup of your database before running a migration.

You can read more about this issue in typeorm/issues/7054

Now we'll dive into what's going on under the hood.

Vendure exposes three primary migration functions:

- **`generateMigration()`** - Creates new migration files based on schema differences
- **`runMigrations()`** - Executes pending migrations
- **`revertLastMigration()`** - Rolls back the last applied migration

TypeORM tracks applied migrations in a database `migrations` table to prevent duplicate execution.

**Key Best Practices:**

1. **Disable synchronize in production**: Set `synchronize: false` in `dbConnectionOptions` to prevent automatic schema updates
2. **Always backup before migrating**: Especially critical for MySQL/MariaDB due to lack of transaction support
3. **Review generated migrations**: Verify the SQL commands before running them
4. **Test migrations on staging**: Always test migration scripts on a staging environment first

**Examples:**

Example 1 (ts):
```ts
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    dbConnectionOptions: {        // ...        synchronize: false,    }};
```

Example 2 (bash):
```bash
[server] Your database schema does not match your current configuration. Generate a new migration for the following changes:[server]  - ALTER TABLE "product" ADD "customFieldsKeywords" character varying(255)
```

Example 3 (ts):
```ts
import {MigrationInterface, QueryRunner} from "typeorm";export class addKeywordsField1690558104092 implements MigrationInterface {   public async up(queryRunner: QueryRunner): Promise<any> {        await queryRunner.query(`ALTER TABLE "product" ADD "customFieldsKeywords" character varying(255)`, undefined);   }   public async down(queryRunner: QueryRunner): Promise<any> {        await queryRunner.query(`ALTER TABLE "product" DROP COLUMN "customFieldsKeywords"`, undefined);   }}
```

Example 4 (ts):
```ts
import { bootstrap, runMigrations } from '@vendure/core';import { config } from './vendure-config';runMigrations(config)    .then(() => bootstrap(config))    .catch(err => {        console.log(err);    });
```

---

## The API Layer

**URL:** https://docs.vendure.io/guides/developer-guide/the-api-layer/

**Contents:**
- The API Layer
- The journey of an API call​
- Middleware​
  - Express middleware​
  - NestJS middleware​
  - Global NestJS middleware​
  - Apollo Server plugins​
- Resolvers​
- API Decorators​
  - @Resolver()​

Vendure is a headless platform, which means that all functionality is exposed via GraphQL APIs. The API can be thought of as a number of layers through which a request will pass, each of which is responsible for a different aspect of the request/response lifecycle.

Let's take a basic API call and trace its journey from the client to the server and back again.

This query is asking for the id, name and description of a Product with the id of 1.

GraphQL returns only the specific fields you ask for in your query.

If you have your local development server running, you can try this out by opening the GraphQL Playground in your browser:

http://localhost:3000/shop-api

"Middleware" is a term for a function which is executed before or after the main logic of a request. In Vendure, middleware is used to perform tasks such as authentication, logging, and error handling. There are several types of middleware:

At the lowest level, Vendure makes use of the popular Express server library. Express middleware can be added to the sever via the apiOptions.middleware config property. There are hundreds of tried-and-tested Express middleware packages available, and they can be used to add functionality such as CORS, compression, rate-limiting, etc.

Here's a simple example demonstrating Express middleware which will log a message whenever a request is received to the Admin API:

You can also define NestJS middleware which works like Express middleware but also has access to the NestJS dependency injection system.

NestJS allows you to define specific types of middleware including Guards, Interceptors, Pipes and Filters.

Vendure uses a number of these mechanisms internally to handle authentication, transaction management, error handling and data transformation.

Guards, interceptors, pipes and filters can be added to your own custom resolvers and controllers using the NestJS decorators as given in the NestJS docs. However, a common pattern is to register them globally via a Vendure plugin:

Adding this plugin to your Vendure config plugins array will now apply these middleware classes to all requests.

Apollo Server (the underlying GraphQL server library used by Vendure) allows you to define plugins which can be used to hook into various stages of the GraphQL request lifecycle and perform tasks such as data transformation. These are defined via the apiOptions.apolloServerPlugins config property.

A "resolver" is a GraphQL concept, and refers to a function which is responsible for returning the data for a particular field. In Vendure's implementation, resolvers can be individual functions or classes containing multiple resolver functions.

**How Resolvers Work:**

For every GraphQL query or mutation, there's a corresponding resolver function that handles data retrieval or updates:

```typescript
import { Query, Resolver, Args } from '@nestjs/graphql';
import { Ctx, RequestContext, ProductService } from '@vendure/core';

@Resolver()
export class ShopProductsResolver {
  constructor(private productService: ProductService) {}

  @Query()
  product(@Ctx() ctx: RequestContext, @Args() args: { id: string }) {
    return this.productService.findOne(ctx, args.id);
  }
}
```

**Key Decorators:**

- `@Resolver()` - Marks a class as handling GraphQL operations
- `@Query()` - Designates methods that resolve query operations
- `@Mutation()` - Designates methods that resolve mutation operations
- `@Ctx()` - Injects the RequestContext object
- `@Args()` - Injects query/mutation arguments
- `@ResolveField()` - Handles relationships between types
- `@Parent()` - Accesses the parent object being resolved

**Best Practice:**

Resolver functions should be kept as simple as possible, and the bulk of the business logic should be delegated to the service layer. This separation of concerns keeps the API layer lightweight and maintainable.

**Examples:**

Example 1 (graphql):
```graphql
query {
  product(id: "1") {
    id
    name
    description
  }
}
```

Example 2 (json):
```json
{  "data": {    "product": {      "id": "1",      "name": "Laptop",      "description": "Now equipped with seventh-generation Intel Core processors, Laptop is snappier than ever. From daily tasks like launching apps and opening files to more advanced computing, you can power through your day thanks to faster SSDs and Turbo Boost processing up to 3.6GHz."    }  }}
```

Example 3 (ts):
```ts
import { VendureConfig } from '@vendure/core';import { RequestHandler } from 'express';/*** This is a custom middleware function that logs a message whenever a request is received.*/const myMiddleware: RequestHandler = (req, res, next) => {    console.log('Request received!');    next();};export const config: VendureConfig = {    // ...    apiOptions: {        middleware: [            {                // We will execute our custom handler only for requests to the Admin API                route: 'admin-api',                handler: myMiddleware,            }        ],    },};
```

Example 4 (ts):
```ts
import { VendureConfig, ConfigService } from '@vendure/core';import { Injectable, NestMiddleware } from '@nestjs/common';import { Request, Response, NextFunction } from 'express';@Injectable()class MyNestMiddleware implements NestMiddleware {    // Dependencies can be injected via the constructor    constructor(private configService: ConfigService) {}    use(req: Request, res: Response, next: NextFunction) {        console.log(`NestJS middleware: current port is ${this.configService.apiOptions.port}`);        next();    }}export const config: VendureConfig = {    // ...    apiOptions: {       
...
```

---

## Breaking API Changes

**URL:** https://docs.vendure.io/guides/developer-guide/migrating-from-v1/breaking-api-changes

**Contents:**
- Breaking API Changes
- Breaks from updated dependencies​
  - TypeScript​
  - Apollo Server & GraphQL​
  - TypeORM​
- Vendure TypeScript API Changes​
  - Custom Order / Fulfillment / Payment processes​
  - OrderItem no longer exists​
  - ProductVariant stock changes​
  - New return type for Channel, TaxCategory & Zone lists​

If you have any custom ApolloServerPlugins, the plugin methods must now return a Promise. Example:

With the update to GraphQL v16, you might run into issues with other packages in the GraphQL ecosystem that also depend on the graphql package, such as graphql-code-generator. In this case these packages will also need to be updated.

For instance, if you are using the "typescript-compatibility" plugin to generate namespaced types, you'll need to drop this, as it is no longer maintained.

TypeORM 0.3.x introduced a large number of breaking changes. For a complete guide, see the TypeORM v0.3.0 release notes.

Here are the main API changes you'll likely need to make:

In v2, the hard-coded states & transition logic for the Order, Fulfillment and Payment state machines has been extracted from the core services and instead reside in a default OrderProcess, FulfillmentProcess and PaymentProcess object. This allows you to fully customize these flows without having to work around the assumptions & logic implemented by the default processes.

What this means is that if you are defining a custom process, you'll now need to explicitly add the default process to the array.

Also note that shippingOptions.customFulfillmentProcess and paymentOptions.customPaymentProcess are both now renamed to process. The old names are still usable but are deprecated.

As a result of #1981, the OrderItem entity no longer exists. The function and data of OrderItem is now transferred to OrderLine. As a result, the following APIs which previously used OrderItem arguments have now changed:

If you have implemented any of these APIs, you'll need to check each one, remove the OrderItem argument from any methods that are using it, and update any logic as necessary.

You may also be joining the OrderItem relation in your own TypeORM queries, so you'll need to check for code like this:

With #1545 we have changed the way we model stock levels in order to support multiple stock locations. This means that the ProductVariant.stockOnHand and ProductVariant.stockAllocated properties no longer exist on the ProductVariant entity in TypeScript.

Instead, this information is now located at ProductVariant.stockLevels, which is an array of StockLevel entities.

If you are using the @vendure/ui-devkit package to generate custom ui extensions, here are the breaking changes to be aware of:

**Examples:**

Example 1 (diff):
```diff
export class TranslateErrorsPlugin implements ApolloServerPlugin {   constructor(private i18nService: I18nService) {}-  requestDidStart(): GraphQLRequestListener {+  async requestDidStart(): Promise<GraphQLRequestListener> {     return {-      willSendResponse: requestContext => {+      willSendResponse: async requestContext => {         const { errors, context } = requestContext;         if (errors) {           (requestContext.response as any).errors = errors.map(err => {             return this.i18nService.translateError(context.req, err as GraphQLError) as any;           });         }      
...
```

Example 2 (diff):
```diff
+ import { IsNull } from 'typeorm';- .find({ where: { deletedAt: null } })+ .find({ where: { deletedAt: IsNull() } })
```

Example 3 (diff):
```diff
- .findOne(variantId)+ .findOne({ where: { id: variantId } })
```

Example 4 (diff):
```diff
- .find({ where: { user } })+ .find({ where: { user: { id: user.id } } })
```

---

## Logging

**URL:** https://docs.vendure.io/guides/developer-guide/logging/

**Contents:**
- Logging
- Log levels​
- DefaultLogger​
- Logging database queries​
- Logging in your own plugins​

Logging allows you to see what is happening inside the Vendure server. It is useful for debugging and for monitoring the health of the server in production.

In Vendure, logging is configured using the logger property of the VendureConfig object. The logger must implement the VendureLogger interface.

To implement a custom logger, see the Implementing a custom logger guide.

Vendure uses 5 log levels, in order of increasing severity:

Vendure ships with a DefaultLogger which logs to the console (process.stdout). It can be configured with the desired log level:

To log database queries, set the logging property of the dbConnectionOptions as well as setting the logger to Debug level.

More information about the logging option can be found in the TypeORM logging documentation.

When you extend Vendure by creating your own plugins, it's a good idea to log useful information about what your plugin is doing. To do this, you need to import the Logger class from @vendure/core and use it in your plugin:

**Examples:**

Example 1 (ts):
```ts
import { DefaultLogger, VendureConfig } from '@vendure/core';const config: VendureConfig = {    // ...    logger: new DefaultLogger({ level: LogLevel.Debug }),};
```

Example 2 (ts):
```ts
import { DefaultLogger, LogLevel, VendureConfig } from '@vendure/core';const config: VendureConfig = {    // ...    logger: new DefaultLogger({ level: LogLevel.Debug }),    dbConnectionOptions: {        // ... etc        logging: true,                // You can also specify which types of DB events to log:        // logging: ['error', 'warn', 'schema', 'query', 'info', 'log'],    },};
```

Example 3 (ts):
```ts
import { Logger } from '@vendure/core';// It is customary to define a logger context for your plugin// so that the log messages can be easily identified.const loggerCtx = 'MyPlugin';// somewhere in your codeLogger.info(`My plugin is doing something!`, loggerCtx);
```

---

## Define custom permissions

**URL:** https://docs.vendure.io/guides/developer-guide/custom-permissions/

**Contents:**
- Define custom permissions
- Defining a single permission​
- Custom CRUD permissions​
- Custom permissions for custom fields​

Vendure uses a fine-grained access control system based on roles & permissions. This is described in detail in the Auth guide. The built-in Permission enum includes a range of permissions to control create, read, update, and delete access to the built-in entities.

When building plugins, you may need to define new permissions to control access to new functionality. This guide explains how to do so.

For example, let's imagine you are creating a plugin which exposes a new mutation that can be used by remote services to sync your inventory. First of all we will define the new permission using the PermissionDefinition class:

This permission can then be used in conjuction with the @Allow() decorator to limit access to the mutation:

Finally, the sync PermissionDefinition must be passed into the VendureConfig so that Vendure knows about this new custom permission:

On starting the Vendure server, this custom permission will now be visible in the Role detail view of the Dashboard, and can be assigned to Roles.

Quite often your plugin will define a new entity on which you must perform create, read, update and delete (CRUD) operations. In this case, you can use the CrudPermissionDefinition which simplifies the creation of the set of 4 CRUD permissions.

For example, let's imagine we are creating a plugin which adds a new entity called ProductReview. We can define the CRUD permissions like so:

These permissions can then be used in our resolver:

Finally, the productReview CrudPermissionDefinition must be passed into the VendureConfig so that Vendure knows about this new custom permission:

Since Vendure v2.2.0, it is possible to define custom permissions for custom fields. This is useful when you want to control access to specific custom fields on an entity. For example, imagine a "product reviews" plugin which adds a rating custom field to the Product entity.

You may want to restrict access to this custom field to only those roles which have permissions on the product review plugin.

**Examples:**

Example 1 (ts):
```ts
import { PermissionDefinition } from '@vendure/core';export const sync = new PermissionDefinition({    name: 'SyncInventory',    description: 'Allows syncing stock levels via Admin API'});
```

Example 2 (ts):
```ts
import { Mutation, Resolver } from '@nestjs/graphql';import { Allow } from '@vendure/core';import { sync } from '../constants';@Resolver()export class InventorySyncResolver {    @Allow(sync.Permission)    @Mutation()    syncInventory(/* ... */) {        // ...    }}
```

Example 3 (ts):
```ts
import gql from 'graphql-tag';import { VendurePlugin } from '@vendure/core';import { InventorySyncResolver } from './api/inventory-sync.resolver'import { sync } from './constants';@VendurePlugin({    adminApiExtensions: {        schema: gql`            input InventoryDataInput {              # omitted for brevity            }                    extend type Mutation {              syncInventory(input: InventoryDataInput!): Boolean!            }        `,        resolvers: [InventorySyncResolver]    },    configuration: config => {        config.authOptions.customPermissions.push(sync);        r
...
```

Example 4 (ts):
```ts
import { CrudPermissionDefinition } from '@vendure/core';export const productReviewPermission = new CrudPermissionDefinition('ProductReview');
```

---

## Define a database entity

**URL:** https://docs.vendure.io/guides/developer-guide/database-entity/

**Contents:**
- Define a database entity
- Create the entity class​
- Register the entity​
- Using the entity​
- Available entity decorators​
- Corresponding GraphQL type​
- Supporting translations​
- Supporting channels​
- Supporting custom fields​

Use npx vendure add to easily add a new entity to a plugin.

Your plugin can define new database entities to model the data it needs to store. For instance, a product review plugin would need a way to store reviews. This would be done by defining a new database entity.

This example shows how new TypeORM database entities can be defined by plugins.

Any custom entities must extend the VendureEntity class.

In this example, we are making use of the following TypeORM decorators:

There is an additional Vendure-specific decorator:

The new entity is then passed to the entities array of the VendurePlugin metadata:

Once you have added a new entity to your plugin, and the plugin has been added to your VendureConfig plugins array, you must create a database migration to create the new table in the database.

The new entity can now be used in your plugin code. For example, you might want to create a new product review when a customer submits a review via the storefront:

In addition to the decorators described above, there are many other decorators provided by TypeORM. Some commonly used ones are:

There is also another Vendure-specific decorator for representing monetary values specifically:

The full list of TypeORM decorators can be found in the TypeORM decorator reference

Once you have defined a new DB entity, it is likely that you want to expose it in your GraphQL API. Here's how to define a new type in your GraphQL API.

In case you'd like to make the ProductReview entity support content in multiple languages, here's how to implement the Translatable Interface.

In case you'd like to support separate ProductReview entities per Channel, here's how to implement the ChannelAware Interface.

Just like you can extend Vendures native entities like Product to support your custom needs, you may enable other developers to extend your custom entities too! Here's how to implement the HasCustomFields Interface.

**Examples:**

Example 1 (ts):
```ts
import { DeepPartial } from '@vendure/common/lib/shared-types';import { VendureEntity, Product, EntityId, ID } from '@vendure/core';import { Column, Entity, ManyToOne } from 'typeorm';@Entity()class ProductReview extends VendureEntity {    constructor(input?: DeepPartial<ProductReview>) {        super(input);    }    @ManyToOne(type => Product)    product: Product;        @EntityId()    productId: ID;    @Column()    text: string;    @Column()    rating: number;}
```

Example 2 (ts):
```ts
import { VendurePlugin } from '@vendure/core';import { ProductReview } from './entities/product-review.entity';@VendurePlugin({    entities: [ProductReview],})export class ReviewsPlugin {}
```

Example 3 (ts):
```ts
import { Injectable } from '@nestjs/common';import { RequestContext, Product, TransactionalConnection } from '@vendure/core';import { ProductReview } from '../entities/product-review.entity';@Injectable()export class ReviewService {    constructor(private connection: TransactionalConnection) {}    async createReview(ctx: RequestContext, productId: string, rating: number, text: string) {        const product = await this.connection.getEntityOrThrow(ctx, Product, productId);        const review = new ProductReview({            product,            rating,            text,        });        return
...
```

---

## Extend the GraphQL API

**URL:** https://docs.vendure.io/guides/developer-guide/extend-graphql-api/

**Contents:**
- Extend the GraphQL API
- Adding a new Query​
- Adding a new Mutation​
- Defining a new type​
- Add fields to existing types​
- Override built-in resolvers​
- Resolving union results​
- Defining custom scalars​

Extension to the GraphQL API consists of two parts:

The Shop API and Admin APIs can be extended independently:

There are a number of ways the GraphQL APIs can be modified by a plugin.

Let's take a simple example where we want to be able to display a banner in our storefront.

First let's define a new query in the schema:

This defines a new query called activeBanner which takes a locationId string argument and returns a string.

In GraphQL, the ! in locationId: String! indicates that the argument is required, and the lack of a ! on the return type indicates that the return value can be null.

We can now define the resolver for this query:

The BannerService would implement the actual logic for fetching the banner text from the database.

Finally, we need to add the resolver to the plugin metadata:

Let's continue the BannerPlugin example and now add a mutation which allows the administrator to set the banner text.

First we define the mutation in the schema:

Here we are defining a new mutation called setBannerText which takes two arguments, locationId and text, both of which are required strings. The return type is a non-nullable string.

Now let's define a resolver to handle that mutation:

Note that we have used the @Allow() decorator to ensure that only users with the UpdateSettings permission can call this mutation. We have also wrapped the resolver in a transaction using @Transaction(), which is a good idea for any mutation which modifies the database.

For more information on the available decorators, see the API Layer "decorators" guide.

Finally, we add the resolver to the plugin metadata:

If you have defined a new database entity, it is likely that you'll want to expose this entity in your GraphQL API. To do so, you'll need to define a corresponding GraphQL type.

Using the ProductReview entity from the Define a database entity guide, let's see how we can expose it as a new type in the API.

As a reminder, here is the ProductReview entity:

Let's define a new GraphQL type which corresponds to this entity:

Assuming the entity is a standard VendureEntity, it is good practice to always include the id, createdAt and updatedAt fields in the GraphQL type.

Additionally, we implement Node which is a built-in GraphQL interface.

Now we can add this type to both the Admin and Shop APIs:

Let's say you want to add a new field to the ProductVariant type to allow the storefront to display some indication of how long a particular product variant would take to deliver.

**Extending ProductVariant with Custom Fields:**

We can add a non-nullable 'delivery' field of type 'DeliveryEstimate' to the ProductVariant GraphQL type:

```typescript
import gql from 'graphql-tag';

export const shopApiExtensions = gql`
  type DeliveryEstimate {
    from: Int!
    to: Int!
  }

  extend type ProductVariant {
    delivery: DeliveryEstimate!
  }
`;
```

**Implementing the Field Resolver:**

Define an entity resolver for the 'delivery' field on the ProductVariant type:

```typescript
import { Parent, ResolveField, Resolver } from '@nestjs/graphql';
import { Ctx, RequestContext, ProductVariant } from '@vendure/core';
import { DeliveryEstimateService } from '../services/delivery-estimate.service';

@Resolver('ProductVariant')
export class ProductVariantEntityResolver {
    constructor(private deliveryEstimateService: DeliveryEstimateService) {}

    @ResolveField()
    delivery(@Ctx() ctx: RequestContext, @Parent() variant: ProductVariant) {
        return this.deliveryEstimateService.getEstimate(ctx, variant.id);
    }
}
```

**Key Points:**
- The `@Resolver()` decorator has an argument matching the type name, telling NestJS which type this resolver targets
- The `@ResolveField()` decorator marks methods as field resolvers
- Method names match schema field names
- Always use the `@Ctx()` decorator to inject the `RequestContext` into resolver functions

**Examples:**

Example 1 (ts):
```ts
import { PluginCommonModule, VendurePlugin } from '@vendure/core';import gql from 'graphql-tag';import { TopSellersResolver } from './api/top-products.resolver';const schemaExtension = gql`  extend type Query {    topProducts: [Product!]!  }`@VendurePlugin({    imports: [PluginCommonModule],    // We pass our schema extension and any related resolvers    // to our plugin metadata      shopApiExtensions: {        schema: schemaExtension,        resolvers: [TopProductsResolver],    },    // Likewise, if you want to extend the Admin API,    // you would use `adminApiExtensions` in exactly the    
...
```

Example 2 (ts):
```ts
import gql from 'graphql-tag';export const shopApiExtensions = gql`  extend type Query {    activeBanner(locationId: String!): String  }`;
```

Example 3 (ts):
```ts
import { Args, Query, Resolver } from '@nestjs/graphql';import { Ctx, RequestContext } from '@vendure/core';import { BannerService } from '../services/banner.service.ts';@Resolver()class BannerShopResolver {    constructor(private bannerService: BannerService) {}    @Query()    activeBanner(@Ctx() ctx: RequestContext, @Args() args: { locationId: string; }) {        return this.bannerService.getBanner(ctx, args.locationId);    }}
```

Example 4 (ts):
```ts
import { PluginCommonModule, VendurePlugin } from '@vendure/core';import { BannerService } from './services/banner.service';import { BannerShopResolver } from './api/banner-shop.resolver';import { shopApiExtensions } from './api/api-extensions';@VendurePlugin({    imports: [PluginCommonModule],    shopApiExtensions: {        schema: shopApiExtensions,        resolvers: [BannerShopResolver],    },    providers: [BannerService],})export class BannerPlugin {}
```

---

## Stand-alone CLI Scripts

**URL:** https://docs.vendure.io/guides/developer-guide/stand-alone-scripts/

**Contents:**
- Stand-alone CLI Scripts
- Minimal example​
- The app object​
- Creating a RequestContext​

It is possible to create stand-alone scripts that can be run from the command-line by using the bootstrapWorker function. This can be useful for a variety of use-cases such as running cron jobs or importing data.

Here's a minimal example of a script which will bootstrap the Vendure Worker and then log the number of products in the database:

This script can then be run from the command-line:

resulting in the following output:

The app object returned by the bootstrapWorker() function is an instance of the NestJS Application Context. It has full access to the NestJS dependency injection container, which means that you can use the app.get() method to retrieve any of the services defined in the Vendure core or by any plugins.

Almost all the methods exposed by Vendure's core services take a RequestContext object as the first argument. Usually, this object is created in the API Layer by the @Ctx() decorator, and contains information related to the current API request.

When running a stand-alone script, we aren't making any API requests, so we need to create a RequestContext object manually. This can be done using the RequestContextService:

**Examples:**

Example 1 (ts):
```ts
import { bootstrapWorker, Logger, ProductService, RequestContextService } from '@vendure/core';import { config } from './vendure-config';if (require.main === module) {    getProductCount()        .then(() => process.exit(0))        .catch(err => {            Logger.error(err);            process.exit(1);        });}async function getProductCount() {    // This will bootstrap an instance of the Vendure Worker, providing    // us access to all of the services defined in the Vendure core.    // (but without the unnecessary overhead of the API layer).    const { app } = await bootstrapWorker(confi
...
```

Example 2 (shell):
```shell
npx ts-node src/get-product-count.ts# oryarn ts-node src/get-product-count.ts
```

Example 3 (shell):
```shell
info 01/08/23, 11:50 - [Vendure Worker] Bootstrapping Vendure Worker (pid: 4428)...info 01/08/23, 11:50 - [Vendure Worker] Vendure Worker is readyinfo 01/08/23, 11:50 - [Vendure Worker]-----------------------------------------There are 56 products in the database-----------------------------------------
```

Example 4 (ts):
```ts
import { bootstrapWorker, CustomerService } from '@vendure/core';import { config } from './vendure-config';// ...async function importCustomerData() {    const { app } = await bootstrapWorker(config);        const customerService = app.get(CustomerService);}
```

---

## Storefront migration

**URL:** https://docs.vendure.io/guides/developer-guide/migrating-from-v1/storefront-migration

**Contents:**
- Storefront migration

There are relatively few breaking changes that will affect the storefront.

**Examples:**

Example 1 (diff):
```diff
-mutation setOrderShippingMethod($shippingMethodId: ID!) {+mutation setOrderShippingMethod($shippingMethodId: [ID!]!) {  setOrderShippingMethod(shippingMethodId: $shippingMethodId) {    # ... etc  }}
```

Example 2 (diff):
```diff
documents:  - "app/**/*.{ts,tsx}"  - "!app/generated/*"+config:+  scalars:+    Money: numbergenerates:  # ... etc
```

---

## Worker & Job Queue

**URL:** https://docs.vendure.io/guides/developer-guide/worker-job-queue/

**Contents:**
- Worker & Job Queue
- The worker​
  - Underlying architecture​
  - Multiple workers​
  - Running jobs on the main process​
  - ProcessContext​
- The job queue​
  - What does Vendure use the job queue for?​
  - How does the Job Queue work?​
  - JobQueueStrategy​

The Vendure Worker is a Node.js process responsible for running computationally intensive or otherwise long-running tasks in the background. For example, updating a search index or sending emails. Running such tasks in the background allows the server to stay responsive, since a response can be returned immediately without waiting for the slower tasks to complete.

Put another way, the Worker executes jobs which have been placed in the job queue.

The worker is started by calling the bootstrapWorker() function with the same configuration as is passed to the main server bootstrap(). In a standard Vendure installation, this is found in the index-worker.ts file:

The Worker is a NestJS standalone application. This means it is almost identical to the main server app, but does not have any network layer listening for requests. The server communicates with the worker via a “job queue” architecture. The exact implementation of the job queue is dependent on the configured JobQueueStrategy, but by default the worker polls the database for new jobs.

It is possible to run multiple workers in parallel to better handle heavy loads. Using the JobQueueOptions.activeQueues configuration, it is even possible to have particular workers dedicated to one or more specific types of jobs. For example, if your application does video transcoding, you might want to set up a dedicated worker just for that task:

It is possible to run jobs from the Job Queue on the main server. This is mainly used for testing and automated tasks, and is not advised for production use, since it negates the benefits of running long tasks off of the main process. To do so, you need to manually start the JobQueueService:

Sometimes your code may need to be aware of whether it is being run as part of a server or worker process. In this case you can inject the ProcessContext provider and query it like this:

Vendure uses a job queue to handle the processing of certain tasks which are typically too slow to run in the normal request-response cycle. A normal request-response looks like this:

In the normal request-response, all intermediate tasks (looking up data in the database, performing business logic etc.) occur before the response can be returned. For most operations this is fine, since those intermediate tasks are very fast.

Some operations however will need to perform much longer-running tasks. For example, updating the search index on thousands of products could take up to a minute or more. In this case, we don't want to block the response while this task completes.

**The Job Queue System:**

Vendure uses a job queue to handle the processing of tasks which are too slow to run in the normal request-response cycle. Jobs are processed by a separate **Worker process**, which can be scaled independently of the main server.

**Setting Up a Worker Process:**

Create a dedicated worker entry file and use `bootstrapWorker()` to start processing jobs:

```typescript
import { bootstrapWorker } from '@vendure/core';
import { config } from './vendure-config';

bootstrapWorker(config)
    .then(worker => worker.startJobQueue())
    .catch(err => {
        console.log(err);
    });
```

**Dedicated Workers for Specific Queues:**

Configure workers to process only specific job queues:

```typescript
import { bootstrapWorker, mergeConfig } from '@vendure/core';
import { config } from './vendure-config';

const transcoderConfig = mergeConfig(config, {
    jobQueueOptions: {
      activeQueues: ['transcode-video'],
    }
});

bootstrapWorker(transcoderConfig)
  .then(worker => worker.startJobQueue())
  .catch(err => {
    console.log(err);
  });
```

**Process Context Detection:**

Use the `ProcessContext` provider to execute code conditionally based on whether it's running in the server or worker:

```typescript
import { Injectable, OnApplicationBootstrap } from '@nestjs/common';
import { ProcessContext } from '@vendure/core';

@Injectable()
export class MyService implements OnApplicationBootstrap {
    constructor(private processContext: ProcessContext) {}

    onApplicationBootstrap() {
        if (this.processContext.isServer) {
            // code which will only execute when running in
            // the server process
        }
    }
}
```

**Examples:**

Example 1 (ts):
```ts
import { bootstrapWorker } from '@vendure/core';import { config } from './vendure-config';bootstrapWorker(config)    .then(worker => worker.startJobQueue())    .catch(err => {        console.log(err);    });
```

Example 2 (ts):
```ts
import { bootstrapWorker, mergeConfig } from '@vendure/core';import { config } from './vendure-config';const transcoderConfig = mergeConfig(config, {    jobQueueOptions: {      activeQueues: ['transcode-video'],    }});bootstrapWorker(transcoderConfig)  .then(worker => worker.startJobQueue())  .catch(err => {    console.log(err);  });
```

Example 3 (ts):
```ts
import { bootstrap, JobQueueService } from '@vendure/core';import { config } from './vendure-config';bootstrap(config)    .then(app => app.get(JobQueueService).start())    .catch(err => {        console.log(err);        process.exit(1);    });
```

Example 4 (ts):
```ts
import { Injectable, OnApplicationBootstrap } from '@nestjs/common';import { ProcessContext } from '@vendure/core';@Injectable()export class MyService implements OnApplicationBootstrap {    constructor(private processContext: ProcessContext) {}    onApplicationBootstrap() {        if (this.processContext.isServer) {            // code which will only execute when running in            // the server process        }    }}
```

---

## Define a database entity

**URL:** https://docs.vendure.io/guides/developer-guide/database-entity

**Contents:**
- Define a database entity
- Create the entity class​
- Register the entity​
- Using the entity​
- Available entity decorators​
- Corresponding GraphQL type​
- Supporting translations​
- Supporting channels​
- Supporting custom fields​

Use npx vendure add to easily add a new entity to a plugin.

Your plugin can define new database entities to model the data it needs to store. For instance, a product review plugin would need a way to store reviews. This would be done by defining a new database entity.

This example shows how new TypeORM database entities can be defined by plugins.

Any custom entities must extend the VendureEntity class.

In this example, we are making use of the following TypeORM decorators:

There is an additional Vendure-specific decorator:

The new entity is then passed to the entities array of the VendurePlugin metadata:

Once you have added a new entity to your plugin, and the plugin has been added to your VendureConfig plugins array, you must create a database migration to create the new table in the database.

The new entity can now be used in your plugin code. For example, you might want to create a new product review when a customer submits a review via the storefront:

In addition to the decorators described above, there are many other decorators provided by TypeORM. Some commonly used ones are:

There is also another Vendure-specific decorator for representing monetary values specifically:

The full list of TypeORM decorators can be found in the TypeORM decorator reference

Once you have defined a new DB entity, it is likely that you want to expose it in your GraphQL API. Here's how to define a new type in your GraphQL API.

In case you'd like to make the ProductReview entity support content in multiple languages, here's how to implement the Translatable Interface.

In case you'd like to support separate ProductReview entities per Channel, here's how to implement the ChannelAware Interface.

Just like you can extend Vendures native entities like Product to support your custom needs, you may enable other developers to extend your custom entities too! Here's how to implement the HasCustomFields Interface.

**Examples:**

Example 1 (ts):
```ts
import { DeepPartial } from '@vendure/common/lib/shared-types';import { VendureEntity, Product, EntityId, ID } from '@vendure/core';import { Column, Entity, ManyToOne } from 'typeorm';@Entity()class ProductReview extends VendureEntity {    constructor(input?: DeepPartial<ProductReview>) {        super(input);    }    @ManyToOne(type => Product)    product: Product;        @EntityId()    productId: ID;    @Column()    text: string;    @Column()    rating: number;}
```

Example 2 (ts):
```ts
import { VendurePlugin } from '@vendure/core';import { ProductReview } from './entities/product-review.entity';@VendurePlugin({    entities: [ProductReview],})export class ReviewsPlugin {}
```

Example 3 (ts):
```ts
import { Injectable } from '@nestjs/common';import { RequestContext, Product, TransactionalConnection } from '@vendure/core';import { ProductReview } from '../entities/product-review.entity';@Injectable()export class ReviewService {    constructor(private connection: TransactionalConnection) {}    async createReview(ctx: RequestContext, productId: string, rating: number, text: string) {        const product = await this.connection.getEntityOrThrow(ctx, Product, productId);        const review = new ProductReview({            product,            rating,            text,        });        return
...
```

---

## Security

**URL:** https://docs.vendure.io/guides/developer-guide/security/

**Contents:**
- Security
- Basics​
  - Change the default credentials​
  - Use the HardenPlugin​
  - Harden the AssetServerPlugin​
- OWASP Top Ten Security Assessment​
  - 1. Broken Access Control​
  - 2. Cryptographic Failures​
  - 3. Injection​
  - 4. Insecure Design​

Security of your Vendure application includes considering how to prevent and protect against common security threats such as:

Vendure itself is designed with security in mind, but you must also consider the security of your own application code, the server environment, and the network architecture.

Here are some basic measures you should use to secure your Vendure application. These are not exhaustive, but they are a good starting point.

Do not deploy any public Vendure instance with the default superadmin credentials (superadmin:superadmin). Use your hosting platform's environment variables to set a strong password for the Superadmin account.

It is recommended that you install and configure the HardenPlugin for all production deployments. This plugin locks down your schema (disabling introspection and field suggestions) and protects your Shop API against malicious queries that could otherwise overwhelm your server.

Then add it to your VendureConfig:

For a detailed explanation of how to best configure this plugin, see the HardenPlugin docs.

If you are using the AssetServerPlugin, it is possible by default to use the dynamic image transform feature to overload the server with requests for new image sizes & formats. To prevent this, you can configure the plugin to only allow transformations for the preset sizes, and limited quality levels and formats. Since v3.1 we ship the PresetOnlyStrategy for this purpose, and you can also create your own strategies.

The Open Worldwide Application Security Project (OWASP) is a nonprofit foundation that works to improve the security of software.

It publishes a top 10 list of common web application vulnerabilities: https://owasp.org/Top10

This section assesses Vendure against this list, stating what is covered out of the box (built in to the framework or easily configurable) and what needs to be additionally considered.

Reference: https://owasp.org/Top10/A01_2021-Broken_Access_Control/

Reference: https://owasp.org/Top10/A02_2021-Cryptographic_Failures/

Reference: https://owasp.org/Top10/A03_2021-Injection/

Reference: https://owasp.org/Top10/A04_2021-Insecure_Design/

Reference: https://owasp.org/Top10/A05_2021-Security_Misconfiguration/

Reference: https://owasp.org/Top10/A06_2021-Vulnerable_and_Outdated_Components/

Reference: https://owasp.org/Top10/A07_2021-Identification_and_Authentication_Failures/

Reference: https://owasp.org/Top10/A08_2021-Software_and_Data_Integrity_Failures/

Reference: https://owasp.org/Top10/A09_2021-Security_Logging_and_Monitoring_Failures/

Reference: https://owasp.org/Top10/A10_2021-Server-Side_Request_Forgery_(SSRF)/

The security page provides a comprehensive assessment mapping Vendure's built-in protections against all 10 OWASP vulnerabilities, including cryptographic defaults (bcrypt with 12 salt rounds), parameterized database queries, role-based access control, and GraphQL validation safeguards.

**Examples:**

Example 1 (ts):
```ts
import { VendureConfig } from '@vendure/core';

export const config: VendureConfig = {
  authOptions: {
    tokenMethod: ['bearer', 'cookie'],
    superadminCredentials: {
      identifier: process.env.SUPERADMIN_USERNAME,
      password: process.env.SUPERADMIN_PASSWORD,
    },
  },
  // ...
};
```

Example 2 (sh):
```sh
npm install @vendure/harden-plugin
# or
yarn add @vendure/harden-plugin
```

Example 3 (ts):
```ts
import { VendureConfig } from '@vendure/core';import { HardenPlugin } from '@vendure/harden-plugin';const IS_DEV = process.env.APP_ENV === 'dev';export const config: VendureConfig = {  // ...  plugins: [    HardenPlugin.init({      maxQueryComplexity: 500,      apiMode: IS_DEV ? 'dev' : 'prod',    }),    // ...  ]};
```

Example 4 (ts):
```ts
import { VendureConfig } from '@vendure/core';import { AssetServerPlugin, PresetOnlyStrategy } from '@vendure/asset-server-plugin';export const config: VendureConfig = {  // ...  plugins: [    AssetServerPlugin.init({      // ...      imageTransformStrategy: new PresetOnlyStrategy({        defaultPreset: 'large',        permittedQuality: [0, 50, 75, 85, 95],        permittedFormats: ['jpg', 'webp', 'avif'],        allowFocalPoint: false,      }),    }),  ]};
```

---

## Migrations

**URL:** https://docs.vendure.io/guides/developer-guide/migrations/

**Contents:**
- Migrations
- Synchronize vs migrate​
- Migration workflow​
  - 1. Generate a migration​
  - 2. Check the migration file​
  - 3. Run the migration​
- Migrations in-depth​
  - Reverting a migration​

Database migrations are needed whenever the database schema changes. This can be caused by:

TypeORM (which Vendure uses to interact with the database) has a synchronize option which, when set to true, will automatically update your database schema to reflect the current Vendure configuration. This is equivalent to automatically generating and running a migration every time the server starts up.

This is convenient while developing, but should not be used in production, since a misconfiguration could potentially delete production data. In this case, migrations should be used.

This section assumes a standard Vendure installation based on @vendure/create.

Let's assume you have defined a new "keywords" custom field on the Product entity. The next time you start your server you'll see a message like this:

Since we have synchronize set to false, we need to generate a migration to apply these changes to the database. The workflow for this is as follows:

Run npx vendure migrate and select "Generate a new migration"

This will have created a new migration file in the src/migrations directory. Open this file and check that it looks correct. It should look something like this:

The up() function is what will be executed when the migration is run. The down() function is what will be executed if the migration is reverted. In this case, the up() function is adding a new column to the product table, and the down() function is removing it.

The exact query will depend on the database you are using. The above example is for PostgreSQL.

Assuming the migration file looks correct, the next time you start the server, the migration will be run automatically. This is because the runMigrations function is called in the src/index.ts file:

It is also possible to run the migration manually without starting the server:

Run npx vendure migrate and select "Run pending migrations"

TypeORM will attempt to run each migration inside a transaction. This means that if one of the migration commands fails, then the entire transaction will be rolled back to its original state.

However this is not supported by MySQL / MariaDB. This means that when using MySQL or MariaDB, errors in your migration script could leave your database in a broken or inconsistent state. Therefore it is critical that you first create a backup of your database before running a migration.

You can read more about this issue in typeorm/issues/7054

Now we'll dive into what's going on under the hood.

Vendure exposes three primary migration functions:

- **`generateMigration()`** - Creates new migration files based on schema differences
- **`runMigrations()`** - Executes pending migrations
- **`revertLastMigration()`** - Rolls back the last applied migration

TypeORM tracks applied migrations in a database `migrations` table to prevent duplicate execution.

**Key Best Practices:**

1. **Disable synchronize in production**: Set `synchronize: false` in `dbConnectionOptions` to prevent automatic schema updates
2. **Always backup before migrating**: Especially critical for MySQL/MariaDB due to lack of transaction support
3. **Review generated migrations**: Verify the SQL commands before running them
4. **Test migrations on staging**: Always test migration scripts on a staging environment first

**Examples:**

Example 1 (ts):
```ts
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    dbConnectionOptions: {        // ...        synchronize: false,    }};
```

Example 2 (bash):
```bash
[server] Your database schema does not match your current configuration. Generate a new migration for the following changes:[server]  - ALTER TABLE "product" ADD "customFieldsKeywords" character varying(255)
```

Example 3 (ts):
```ts
import {MigrationInterface, QueryRunner} from "typeorm";export class addKeywordsField1690558104092 implements MigrationInterface {   public async up(queryRunner: QueryRunner): Promise<any> {        await queryRunner.query(`ALTER TABLE "product" ADD "customFieldsKeywords" character varying(255)`, undefined);   }   public async down(queryRunner: QueryRunner): Promise<any> {        await queryRunner.query(`ALTER TABLE "product" DROP COLUMN "customFieldsKeywords"`, undefined);   }}
```

Example 4 (ts):
```ts
import { bootstrap, runMigrations } from '@vendure/core';import { config } from './vendure-config';runMigrations(config)    .then(() => bootstrap(config))    .catch(err => {        console.log(err);    });
```

---

## Plugins

**URL:** https://docs.vendure.io/guides/developer-guide/plugins/

**Contents:**
- Plugins
- Core Plugins​
- Plugin basics​
- Plugin lifecycle​
  - Configure​
- Create a Plugin via CLI​
- Writing a plugin from scratch​
  - Step 1: Create the plugin file​
  - Step 2: Define an entity​
  - Step 3: Add a custom field to the Customer entity​

The heart of Vendure is its plugin system. Plugins not only allow you to instantly add new functionality to your Vendure server via third-part npm packages, they are also the means by which you build out the custom business logic of your application.

Plugins in Vendure allow one to:

In a typical Vendure application, custom logic and functionality is implemented as a set of plugins which are usually independent of one another. For example, there could be a plugin for each of the following: wishlists, product reviews, loyalty points, gift cards, etc. This allows for a clean separation of concerns and makes it easy to add or remove functionality as needed.

Vendure provides a set of core plugins covering common functionality such as assets handling, email sending, and search. For documentation on these, see the Core Plugins reference.

Here's a bare-minimum example of a plugin:

This plugin does one thing only: it adds a new custom field to the Customer entity.

The plugin is then imported into the VendureConfig:

The key feature is the @VendurePlugin() decorator, which marks the class as a Vendure plugin and accepts a configuration object on the type VendurePluginMetadata.

A VendurePlugin is actually an enhanced version of a NestJS Module, and supports all the metadata properties that NestJS modules support:

Additionally, the VendurePlugin decorator adds the following Vendure-specific properties:

Since a Vendure plugin is a superset of a NestJS module, this means that many NestJS modules are actually valid Vendure plugins!

Since a VendurePlugin is built on top of the NestJS module system, any plugin (as well as any providers it defines) can make use of any of the NestJS lifecycle hooks:

Note that lifecycle hooks are run in both the server and worker contexts. If you have code that should only run either in the server context or worker context, you can inject the ProcessContext provider.

Another hook that is not strictly a lifecycle hook, but which can be useful to know is the configure method which is used by NestJS to apply middleware. This method is called only for the server and not for the worker, since middleware relates to the network stack, and the worker has no network part.

Run the npx vendure add command, and select "Create a new Vendure plugin".

This will guide you through the creation of a new plugin and automate all aspects of the process.

This is the recommended way of creating a new plugin.

Although the Vendure CLI is the recommended way to create a new plugin, it can be useful to understand the process of creating a plugin manually.

**Plugin Fundamentals:**

All plugins require the `@VendurePlugin()` decorator and typically import `PluginCommonModule`:

```typescript
import { PluginCommonModule, VendurePlugin } from '@vendure/core';

@VendurePlugin({
    imports: [PluginCommonModule],
})
export class CustomPlugin {}
```

**Core Metadata Properties:**
- **imports**: NestJS module dependencies
- **providers**: Injectable services
- **controllers**: REST endpoints
- **exports**: Providers available to other plugins
- **configuration**: Modifies VendureConfig pre-bootstrap
- **shopApiExtensions**: Extends Shop GraphQL API
- **adminApiExtensions**: Extends Admin GraphQL API
- **entities**: Defines new database entities
- **compatibility**: Declares version compatibility via semver range

**Lifecycle Management:**

Plugins inherit NestJS lifecycle hooks executed in both server and worker contexts:
- `onModuleInit`
- `onApplicationBootstrap`
- `onModuleDestroy`
- `beforeApplicationShutdown`
- `onApplicationShutdown`

The `configure()` method applies middleware exclusively in the server context, not the worker.

**Examples:**

Example 1 (ts):
```ts
import { LanguageCode, PluginCommonModule, VendurePlugin } from '@vendure/core';@VendurePlugin({    imports: [PluginCommonModule],    configuration: config => {        config.customFields.Customer.push({            type: 'string',            name: 'avatarUrl',            label: [{ languageCode: LanguageCode.en, value: 'Avatar URL' }],            list: true,        });        return config;    },})export class AvatarPlugin {}
```

Example 2 (ts):
```ts
import { VendureConfig } from '@vendure/core';import { AvatarPlugin } from './plugins/avatar-plugin/avatar.plugin';export const config: VendureConfig = {    // ...    plugins: [AvatarPlugin],};
```

Example 3 (ts):
```ts
import { MiddlewareConsumer, NestModule } from '@nestjs/common';import { EventBus, PluginCommonModule, VendurePlugin } from '@vendure/core';import { MyMiddleware } from './api/my-middleware';@VendurePlugin({    imports: [PluginCommonModule]})export class MyPlugin implements NestModule {  configure(consumer: MiddlewareConsumer) {    consumer      .apply(MyMiddleware)      .forRoutes('my-custom-route');  }}
```

Example 4 (txt):
```txt
├──src    ├── index.ts    ├── vendure-config.ts    ├── plugins        ├── reviews-plugin        ├── cms-plugin        ├── wishlist-plugin        ├── stock-sync-plugin
```

---

## Uploading Files

**URL:** https://docs.vendure.io/guides/developer-guide/uploading-files/

**Contents:**
- Uploading Files
- Upload clients​
- The createAssets mutation​
- Custom upload mutations​
  - Configuration​
  - Schema definition​
  - Resolver​
  - Complete Customer Avatar Plugin​
  - Uploading a Customer Avatar​

Vendure handles file uploads with the GraphQL multipart request specification. Internally, we use the graphql-upload package. Once uploaded, a file is known as an Asset. Assets are typically used for images, but can represent any kind of binary data such as PDF files or videos.

Here is a list of client implementations that will allow you to upload files using the spec. If you are using Apollo Client, then you should install the apollo-upload-client npm package.

For testing, it is even possible to use a plain curl request.

The createAssets mutation in the Admin API is the only means of uploading files by default.

Here's an example of how a file upload would look using the apollo-upload-client package:

How about if you want to implement a custom mutation for file uploads? Let's take an example where we want to allow customers to set an avatar image. To do this, we'll add a custom field to the Customer entity and then define a new mutation in the Shop API.

Let's define a custom field to associate the avatar Asset with the Customer entity. To keep everything encapsulated, we'll do all of this in a plugin

Next, we will define the schema for the mutation:

The resolver will make use of the built-in AssetService to handle the processing of the uploaded file into an Asset.

Let's put all these parts together into the plugin:

In our storefront, we would then upload a Customer's avatar like this:

**Examples:**

Example 1 (tsx):
```tsx
import { gql, useMutation } from "@apollo/client";const MUTATION = gql`  mutation CreateAssets($input: [CreateAssetInput!]!) {    createAssets(input: $input) {      ... on Asset {        id        name        fileSize      }      ... on ErrorResult {        message      }    }  }`;function UploadFile() {    const [mutate] = useMutation(MUTATION);    function onChange(event) {        const {target} = event;        if (target.validity.valid) {            mutate({                variables: {                    input: Array.from(target.files).map((file) => ({file}));                }            })
...
```

Example 2 (ts):
```ts
import { Asset, LanguageCode, PluginCommonModule, VendurePlugin } from '@vendure/core';@VendurePlugin({    imports: [PluginCommonModule],    configure: config => {        config.customFields.Customer.push({            name: 'avatar',            type: 'relation',            label: [{languageCode: LanguageCode.en, value: 'Customer avatar'}],            entity: Asset,            nullable: true,        });        return config;    },})export class CustomerAvatarPlugin {}
```

Example 3 (ts):
```ts
import gql from 'graphql-tag';export const shopApiExtensions = gql`extend type Mutation {  setCustomerAvatar(file: Upload!): Asset}`
```

Example 4 (ts):
```ts
import { Args, Mutation, Resolver } from '@nestjs/graphql';import { Asset } from '@vendure/common/lib/generated-types';import {    Allow, AssetService, Ctx, CustomerService, isGraphQlErrorResult,    Permission, RequestContext, Transaction} from '@vendure/core';@Resolver()export class CustomerAvatarResolver {    constructor(private assetService: AssetService, private customerService: CustomerService) {}    @Transaction()    @Mutation()    @Allow(Permission.Authenticated)    async setCustomerAvatar(        @Ctx() ctx: RequestContext,        @Args() args: { file: any },    ): Promise<Asset | unde
...
```

---

## Translations

**URL:** https://docs.vendure.io/guides/developer-guide/translations/

**Contents:**
- Translations
- Translatable entities​
  - Loading translatable entities​
- Admin UI translations​
- Server message translations​
  - Translatable Error​
  - Use translations​

The following items in Vendure can be translated:

The following entities implement the Translatable interface:

To understand how translatable entities are implemented, let's take a look at a simplified version of the Facet entity:

All translatable entities have a translations field which is a relation to the translations. Any fields that are to be translated are of type LocaleString, and do note have a @Column() decorator. This is because the name field here does not in fact exist in the database in the facet table. Instead, it belongs to the facet_translations table, which brings us to the FacetTranslation entity (again simplified for clarity):

Thus there is a one-to-many relation between Facet and FacetTranslation, which allows Vendure to handle multiple translations of the same entity. The FacetTranslation entity also implements the Translation interface, which requires the languageCode field and a reference to the base entity.

If your plugin needs to load a translatable entity, you will need to use the TranslatorService to hydrate all the LocaleString fields will the actual translated values from the correct translation.

For example, if you are loading a Facet entity, you would do the following:

See the Adding Admin UI Translations guide.

Let's say you've implemented some custom server-side functionality as part of a plugin. You may be returning custom errors or other messages. Here's how you can provide these messages in multiple languages.

Using addTranslation inside the onApplicationBootstrap (Nestjs lifecycle hooks) of a Plugin is the easiest way to add new translations. While Vendure is only using error, errorResult and message resource keys you are free to use your own.

This example shows how to create a custom translatable error

To receive an error in a specific language you need to use the languageCode query parameter query(QUERY_WITH_ERROR_RESULT, { variables }, { languageCode: LanguageCode.de });

Vendure uses the internationalization-framework i18next.

Therefore you are free to use the i18next translate function to access keys i18next.t('error.any-message');

**Examples:**

Example 1 (ts):
```ts
@Entity()export class Facet extends VendureEntity implements Translatable {        name: LocaleString;    @Column({ unique: true })    code: string;    @OneToMany(type => FacetTranslation, translation => translation.base, { eager: true })    translations: Array<Translation<Facet>>;}
```

Example 2 (ts):
```ts
@Entity()export class FacetTranslation extends VendureEntity implements Translation<Facet> {    @Column('varchar') languageCode: LanguageCode;    @Column() name: string;    @Index()    @ManyToOne(type => Facet, base => base.translations, { onDelete: 'CASCADE' })    base: Facet;}
```

Example 3 (ts):
```ts
import { Facet } from '@vendure/core';import { LanguageCode, RequestContext, TranslatorService, TransactionalConnection } from '@vendure/core';@Injectable()export class MyService {        constructor(private connection: TransactionalConnection, private translator: TranslatorService) {}    async getFacet(ctx: RequestContext, id: ID): Promise<Facet | undefined> {        const facet = await this.connection.getRepository(ctx, Facet).findOne(id);        if (facet) {            return this.translatorService.translate(facet, ctx);        }    }        async getFacets(ctx: RequestContext): Promise<Fac
...
```

Example 4 (ts):
```ts
/** * Custom error class */class CustomError extends ErrorResult {    readonly __typename = 'CustomError';    readonly errorCode = 'CUSTOM_ERROR';    readonly message = 'CUSTOM_ERROR'; //< looks up errorResult.CUSTOM_ERROR}@VendurePlugin({    imports: [PluginCommonModule],    providers: [I18nService],    // ...})export class TranslationTestPlugin implements OnApplicationBootstrap {    constructor(private i18nService: I18nService) {    }    onApplicationBootstrap(): any {        this.i18nService.addTranslation('en', {            errorResult: {                CUSTOM_ERROR: 'A custom error messag
...
```

---

## Scheduled Tasks

**URL:** https://docs.vendure.io/guides/developer-guide/scheduled-tasks/

**Contents:**
- Scheduled Tasks
- Setting up the DefaultSchedulerPlugin​
- Creating a Scheduled Task​
- Using a task​
  - Adding directly in Vendure config​
  - Adding in plugin configuration function​
- How scheduled tasks work​
- Scheduled tasks vs job queue​
- A note on @nestjs/schedule​

Scheduled tasks are a way of executing some code at pre-defined intervals. There are many examples of work that can be done using scheduled tasks, such as:

Since Vendure v3.3, there is a built-in mechanism which allows you to define scheduled tasks in a convenient and powerful way.

All the information on page applies to Vendure v3.3+

For older versions, there is no built-in support for scheduled tasks, but you can instead use a stand-alone script triggered by a cron job.

In your Vendure config, import and add the DefaultSchedulerPlugin to your plugins array. If you created your project with a version newer than v3.3, this should already be configured.

When you first add this plugin to your config, you'll need to generate a migration because the plugin will make use of a new database table in order to guarantee only-once execution of tasks.

You can then start adding tasks. Vendure ships with a task that will clean up old sessions from the database.

The cleanSessionsTask task is actually configured by default from v3.3+, so normally you won't have to specify this manually unless you wish to change any of the default configuration using the .configure() method.

Let's imagine that you have created a SitemapPlugin that exposes a SitemapService which generates a sitemap for your store. You want to run this task every night at midnight.

Inside the plugin, you would first define a new ScheduledTask instance:

Now that the task has been defined, we need to tell Vendure to use it.

To do so we need to add it to the schedulerOptions.tasks array.

This can be done directly in your Vendure config file:

An alternative is that a plugin can automatically add the task to the config using the plugin's configuration function, which allows plugins to alter the Vendure config.

This allows a plugin to encapsulate any scheduled tasks so that the plugin consumer only needs to add the plugin, and not worry about separately adding the task to the tasks array.

This plugin can now be consumed like this:

The key problems solved by Vendure's task scheduler are:

The first problem is handled by the SchedulerStrategy, which implements a locking mechanism to ensure that the task is executed only once.

The second problem is handled by having tasks only executed on worker processes.

There is some overlap between the use of a scheduled task and a job queue job. They both perform some task on the worker, independent of requests coming in to the server.

**Key Differences:**

| Aspect | Scheduled Tasks | Job Queue |
|--------|-----------------|-----------|
| **Triggering** | Automatic per schedule | Manually triggered |
| **Execution Order** | Immediate when scheduled | Queued; respects prior jobs |
| **Multi-Instance Safety** | Built-in locking mechanism | Inherent queue ordering |
| **Recording** | Last result only | Full history of executions |
| **Use Case** | "According to schedule, exactly once" | "Process eventually, track results" |

**When to Use Each:**

**Choose scheduled tasks for:**
- Regular maintenance (session cleanup, cache refresh)
- Time-based operations (daily reports, midnight syncs)
- Work that must run exactly once across distributed systems

**Choose job queues for:**
- Long-running processes (resource-intensive operations)
- Work requiring historical audit trails
- Operations triggered by specific events
- Tasks where queuing delays are acceptable

**Combining Both Approaches:**

A scheduled task can add jobs to the queue, combining benefits:

```typescript
// Schedule kicks off a job for better resource management
async execute({injector}) {
    const jobQueue = injector.get(JobQueueService);
    await jobQueue.add({
        queueName: 'sitemap-generation',
        data: {}
    });
}
```

This pattern leverages the scheduler's guarantee of single execution while delegating actual work to the job queue's managed processing.

**Examples:**

Example 1 (ts):
```ts
import { DefaultSchedulerPlugin, VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    plugins: [DefaultSchedulerPlugin.init()],};
```

Example 2 (ts):
```ts
import { cleanSessionsTask, DefaultSchedulerPlugin, VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    schedulerOptions: {        tasks: [            // Use the task as is            cleanSessionsTask,            // or further configure the task            cleanSessionsTask.configure({                // Run the task every day at 3:00am                // The default schedule is every day at 00:00am                schedule: cron => cron.everyDayAt(3, 0),                params: {                    // How many sessions to process in each batch                
...
```

Example 3 (ts):
```ts
import { ScheduledTask, RequestContextService } from '@vendure/core';import { SitemapService } from '../services/sitemap.service';export const generateSitemapTask = new ScheduledTask({    // Give your task a unique ID    id: 'generate-sitemap',    // A human-readable description of the task    description: 'Generates a sitemap file',    // Params can be used to further configure aspects of the    // task. They get passed in to the `execute` function as the    // second argument.    // They can be later modified using the `.configure()` method on the instance    params: {        shopBaseUrl: 'h
...
```

Example 4 (ts):
```ts
import { cleanSessionsTask, DefaultSchedulerPlugin, VendureConfig } from '@vendure/core';import { SitemapPlugin, generateSitemapTask } from './plugins/sitemap';export const config: VendureConfig = {    // ...    schedulerOptions: {        tasks: [            cleanSessionsTask,            // Here's an example of overriding the            // default params using the `configure()` method.            generateSitemapTask.configure({                params: {                    shopBaseUrl: 'https://www.shoes.com'                }            }),        ],    },    plugins: [        SitemapPlugin,    
...
```

---

## Settings Store

**URL:** https://docs.vendure.io/guides/developer-guide/settings-store/

**Contents:**
- Settings Store
- Overview​
- Settings Store vs Custom Fields​
- Defining Settings Fields​
  - Field Configuration Options​
  - Scoping​
  - Permissions​
- GraphQL API​
  - Queries​
  - Mutations​

The Settings Store is a flexible system for storing configuration data with support for scoping, permissions, and validation. It allows plugins and the core system to store and retrieve arbitrary JSON data with fine-grained control over access and isolation.

It provides a robust, secure, and flexible system for managing configuration data in your Vendure application. Use it to store user preferences, plugin settings, feature flags, and any other settings data your application needs.

The APIs in this guide were introduced in Vendure v3.4

The Settings Store provides:

Settings fields share some similarities to custom fields, but the important differences are:

Settings fields are best suited to storing config-like values that are global in scope, or which configure data for a particular plugin.

Settings fields are defined in your Vendure configuration using the settingsStoreFields option:

Each field supports the following configuration options:

The Settings Store supports four built-in scoping strategies:

You can also create custom scope functions:

You can control access to the Settings Store entry via the requiresPermission configuration property. If not specified, basic authentication is required for Admin API access.

The Settings Store provides GraphQL queries and mutations in the Admin API:

Any kind of JSON-serializable data can be set as the value. For example: strings, numbers, arrays, or even deeply-nested objects and arrays.

By default, the Settings Store is not exposed in the Shop API. However, you can expose this functionality via a custom mutations & queries that internally use the SettingsStoreService (see next section).

For programmatic access within plugins or services, use the SettingsStoreService:

Prior to v3.4.2, ctx was the last argument to the above methods. However, since this is contrary to all other method usage which has ctx as the first argument, it was changed while deprecating (but still supporting) the former signature.

When field definitions are removed from your configuration, the corresponding database entries become "orphaned". The Settings Store includes an automatic cleanup system to handle this.

You can also perform cleanup manually via the service:

**Examples:**

Example 1 (ts):
```ts
import { VendureConfig, SettingsStoreScopes } from '@vendure/core';export const config: VendureConfig = {  // ... other config  settingsStoreFields: {    dashboard: [        {          name: 'theme',          scope: SettingsStoreScopes.user,        },        {          name: 'companyName',          scope: SettingsStoreScopes.global,        }      ]    }  };
```

Example 2 (ts):
```ts
import { VendureConfig, SettingsStoreScopes, Permission } from '@vendure/core';export const config: VendureConfig = {  // ... other config  settingsStoreFields: {    dashboard: [      {        name: 'theme',        scope: SettingsStoreScopes.user,      },      {        name: 'tableFilters',        scope: SettingsStoreScopes.userAndChannel,      }    ],    payment: [      {        name: 'stripeApiKey',        scope: SettingsStoreScopes.global,        readonly: true, // Cannot be modified via GraphQL API        requiresPermission: Permission.SuperAdmin,        validate: (value, injector, ctx) =>
...
```

Example 3 (ts):
```ts
import { SettingsStoreScopes } from '@vendure/core';// Global - single value for entire systemSettingsStoreScopes.global;// User-specific - separate values per userSettingsStoreScopes.user;// Channel-specific - separate values per channelSettingsStoreScopes.channel;// User and channel specific - separate values per user per channelSettingsStoreScopes.userAndChannel;
```

Example 4 (ts):
```ts
import { VendureConfig, SettingsStoreScopeFunction } from '@vendure/core';const customScope: SettingsStoreScopeFunction = ({ key, value, ctx }) => {    // Custom scoping logic    const env = process.env.NODE_ENV === 'production' ? 'prod' : 'dev';    return `env:${env}`;};export const config: VendureConfig = {    settingsStoreFields: {        myNamespace: [            {                name: 'customField',                // The value will be saved with the scope                // "env:prod" or "env:dev"                scope: customScope,            },        ],    },};
```

---

## Strategies & Configurable Operations

**URL:** https://docs.vendure.io/guides/developer-guide/strategies-configurable-operations/

**Contents:**
- Strategies & Configurable Operations
- Strategies​
  - Strategy lifecycle​
  - Passing options to a strategy​
- Configurable Operations​
  - Configurable operation args​
    - type​
    - label​
    - description​
    - required​

Vendure is built to be highly configurable and extensible. Two methods of providing this extensibility are strategies and configurable operations.

A strategy is named after the Strategy Pattern, and is a way of providing a pluggable implementation of a particular feature. Vendure makes heavy use of this pattern to delegate the implementation of key points of extensibility to the developer.

Examples of strategies include:

As an example, let's take the OrderCodeStrategy. This strategy determines how codes are generated when new orders are created. By default, Vendure will use the built-in DefaultOrderCodeStrategy which generates a random 16-character string.

What if you need to change this behavior? For instance, you might have an existing back-office system that is responsible for generating order codes, which you need to integrate with. Here's how you would do this:

All strategies can make use of existing services by using the init() method. This is because all strategies extend the underlying InjectableStrategy interface. In this example we are assuming that we already created an OrderCodeService which contains all the specific logic for connecting to our backend service which generates the order codes.

We then need to pass this custom strategy to our config:

Strategies can use two optional lifecycle methods:

Sometimes you might want to pass some configuration options to a strategy. For example, imagine you want to create a custom StockLocationStrategy which selects a location within a given proximity to the customer's address. You might want to pass the maximum distance to the strategy in your config:

This config will be passed to the strategy's constructor:

Configurable operations are similar to strategies in that they allow certain aspects of the system to be customized. However, the main difference is that they can also be configured via the Dashboard. This allows the store owner to make changes to the behavior of the system without having to restart the server.

So they are typically used to supply some custom logic that needs to accept configurable arguments which can change at runtime.

Vendure uses the following configurable operations:

Whereas strategies are typically used to provide a single implementation of a particular feature, configurable operations are used to provide a set of implementations which can be selected from at runtime.

For example, Vendure ships with a set of default CollectionFilters:

```typescript
export const defaultCollectionFilters = [
    facetValueCollectionFilter,
    variantNameCollectionFilter,
    variantIdCollectionFilter,
    productIdCollectionFilter,
];
```

When setting up a Collection, you can select and configure these filters through the Vendure Dashboard to determine which products are included.

**Creating Custom Collection Filters:**

You can create custom filters to match products based on specific criteria. Here's an example that filters by SKU:

```typescript
import { CollectionFilter, LanguageCode } from '@vendure/core';

export const skuCollectionFilter = new CollectionFilter({
    args: {
        sku: {
            type: 'string',
            label: [{ languageCode: LanguageCode.en, value: 'SKU' }],
            description: [
                {
                    languageCode: LanguageCode.en,
                    value: 'Matches any product variants with an SKU containing this value',
                },
            ],
        },
    },
    code: 'variant-sku-filter',
    description: [{ languageCode: LanguageCode.en, value: 'Filter by matching SKU' }],

    apply: (qb, args) => {
        const LIKE = qb.connection.options.type === 'postgres' ? 'ILIKE' : 'LIKE';
        return qb.andWhere(`productVariant.sku ${LIKE} :sku`, {
            sku: `%${args.sku}%`
        });
    },
});
```

**Registering Custom Filters:**

Add your custom filter to the Vendure configuration:

```typescript
import { defaultCollectionFilters, VendureConfig } from '@vendure/core';
import { skuCollectionFilter } from './config/sku-collection-filter';

export const config: VendureConfig = {
    catalogOptions: {
        collectionFilters: [
            ...defaultCollectionFilters,
            skuCollectionFilter
        ],
    },
};
```

**Examples:**

Example 1 (ts):
```ts
import { OrderCodeStrategy, RequestContext } from '@vendure/core';import { OrderCodeService } from '../services/order-code.service';export class MyOrderCodeStrategy implements OrderCodeStrategy {    private orderCodeService: OrderCodeService;    init(injector) {        this.orderCodeService = injector.get(OrderCodeService);    }    async generate(ctx: RequestContext): string {        return this.orderCodeService.getNewOrderCode();    }}
```

Example 2 (ts):
```ts
import { VendureConfig } from '@vendure/core';import { MyOrderCodeStrategy } from '../config/my-order-code-strategy';export const config: VendureConfig = {    // ...    orderOptions: {        orderCodeStrategy: new MyOrderCodeStrategy(),    },}
```

Example 3 (ts):
```ts
import { VendureConfig } from '@vendure/core';import { MyStockLocationStrategy } from '../config/my-stock-location-strategy';export const config: VendureConfig = {    // ...    catalogOptions: {        stockLocationStrategy: new MyStockLocationStrategy({ maxDistance: 100 }),    },}
```

Example 4 (ts):
```ts
import  { ID, ProductVariant, RequestContext, StockLevel, StockLocationStrategy } from '@vendure/core';export class MyStockLocationStrategy implements StockLocationStrategy {    constructor(private options: { maxDistance: number }) {}    getAvailableStock(        ctx: RequestContext,        productVariantId: ID,        stockLevels: StockLevel[]    ): ProductVariant[] {        const maxDistance = this.options.maxDistance;        // ... implementation omitted    }}
```

---

## Testing

**URL:** https://docs.vendure.io/guides/developer-guide/testing

**Contents:**
- Testing
- Usage​
  - Install dependencies​
  - Configure Vitest​
  - Register database-specific initializers​
  - Create a test environment​
  - Initialize the server​
  - Write your tests​
  - Run your tests​
- Accessing internal services​

Vendure plugins allow you to extend all aspects of the standard Vendure server. When a plugin gets somewhat complex (defining new entities, extending the GraphQL schema, implementing custom resolvers), you may wish to create automated tests to ensure your plugin is correct.

The @vendure/testing package gives you some simple but powerful tooling for creating end-to-end tests for your custom Vendure code.

By "end-to-end" we mean we are testing the entire server stack - from API, to services, to database - by making a real API request, and then making assertions about the response. This is a very effective way to ensure that all parts of your plugin are working correctly together.

For a working example of a Vendure plugin with e2e testing, see the real-world-vendure Reviews plugin

Create a vitest.config.mts file in the root of your project:

and a tsconfig.e2e.json tsconfig file for the tests:

The @vendure/testing package uses "initializers" to create the test databases and populate them with initial data. We ship with initializers for sqljs, postgres and mysql. Custom initializers can be created to support running e2e tests against other databases supported by TypeORM. See the TestDbInitializer docs for more details.

Note re. the sqliteDataDir: The first time this test suite is run with the SqljsInitializer, the populated data will be saved into an SQLite file, stored in the directory specified by this constructor arg. On subsequent runs of the test suite, the data-population step will be skipped and the initial data directly loaded from the SQLite file. This method of caching significantly speeds up the e2e test runs. All the .sqlite files created in the sqliteDataDir can safely be deleted at any time.

The @vendure/testing package exports a createTestEnvironment function which is used to set up a Vendure server and GraphQL clients to interact with both the Shop and Admin APIs:

Notice that we pass a VendureConfig object into the createTestEnvironment function. The testing package provides a special testConfig which is pre-configured for e2e tests, but any aspect can be overridden for your tests. Here we are configuring the server to load the plugin under test, MyPlugin.

Note: If you need to deeply merge in some custom configuration, use the mergeConfig function which is provided by @vendure/core.

The TestServer needs to be initialized before it can be used. The TestServer.init() method takes an options object which defines how to populate the server with data:

- **`productsCsvPath`**: Path to CSV file with product data (optional)
- **`initialData`**: Object defining non-product data like Collections and ShippingMethods
- **`customerCount`**: Number of fake customers to generate (defaults to 10)

**Test Environment Creation:**

```typescript
import { createTestEnvironment, testConfig } from '@vendure/testing';
import { describe, beforeAll, afterAll } from 'vitest';
import { MyPlugin } from '../my-plugin.ts';

describe('my plugin', () => {
    const { server, adminClient, shopClient } = createTestEnvironment({
        ...testConfig,
        plugins: [MyPlugin],
    });

    beforeAll(async () => {
        await server.init({
            productsCsvPath: path.join(__dirname, 'fixtures/e2e-products.csv'),
            initialData: myInitialData,
            customerCount: 2,
        });
        await adminClient.asSuperAdmin();
    }, 60000);

    afterAll(async () => {
        await server.destroy();
    });
});
```

**Writing Tests:**

```typescript
import gql from 'graphql-tag';
import { it, expect } from 'vitest';

it('myNewQuery returns the expected result', async () => {
    adminClient.asSuperAdmin();
    const query = gql`
        query MyNewQuery($id: ID!) {
            myNewQuery(id: $id) {
                field1
                field2
            }
        }
    `;
    const result = await adminClient.query(query, { id: 123 });
    expect(result.myNewQuery).toEqual({ /* ... */ });
});
```

**Examples:**

Example 1 (sh):
```sh
npm install --save-dev @vendure/testing vitest graphql-tag @swc/core unplugin-swc
```

Example 2 (ts):
```ts
import path from 'path';import swc from 'unplugin-swc';import { defineConfig } from 'vitest/config';export default defineConfig({    test: {        include: ['**/*.e2e-spec.ts'],        typecheck: {            tsconfig: path.join(__dirname, 'tsconfig.e2e.json'),        },    },    plugins: [        // SWC required to support decorators used in test plugins        // See https://github.com/vitest-dev/vitest/issues/708#issuecomment-1118628479        // Vite plugin        swc.vite({            jsc: {                transform: {                    // See https://github.com/vendure-ecommerce/vendur
...
```

Example 3 (json):
```json
{  "extends": "./tsconfig.json",  "compilerOptions": {    "types": ["node"],    "lib": ["es2015"],    "useDefineForClassFields": false,    "skipLibCheck": true,    "inlineSourceMap": false,    "sourceMap": true,    "allowSyntheticDefaultImports": true,    "experimentalDecorators": true,    "emitDecoratorMetadata": true,    "esModuleInterop": true  }}
```

Example 4 (ts):
```ts
import {    MysqlInitializer,    PostgresInitializer,    SqljsInitializer,    registerInitializer,} from '@vendure/testing';const sqliteDataDir = path.join(__dirname, '__data__');registerInitializer('sqljs', new SqljsInitializer(sqliteDataDir));registerInitializer('postgres', new PostgresInitializer());registerInitializer('mysql', new MysqlInitializer());
```

---

## Nest Devtools

**URL:** https://docs.vendure.io/guides/developer-guide/nest-devtools/

**Contents:**
- Nest Devtools
- Installation​
- Configuration​
- Usage​

The NestJS core team have built a powerful set of dev tools which can be used to inspect, analyze and debug NestJS applications. Since a Vendure server is a NestJS application, these tools can be used to debug your Vendure application.

Nest Devtools is a paid service. You can sign up for a free trial.

First you'll need to install the @nestjs/devtools-integration package:

Next you need to create a plugin which imports the DevToolsModule and adds it to the imports array:

Now we need to add this plugin to the plugins array in the VendureConfig. We need to make sure we are only adding it to the server config, and not the worker, otherwise we will get a port config when running the server and worker at the same time.

Lastly we must set the snapshot option when bootstrapping the server. Note: this is only possible with Vendure v2.2 or later.

Now you can start the server, and navigate to devtools.nestjs.com to start view your Vendure server in the Nest Devtools dashboard.

**Examples:**

Example 1 (bash):
```bash
npm i @nestjs/devtools-integration
```

Example 2 (ts):
```ts
import { VendurePlugin } from '@vendure/core';import { DevtoolsModule } from '@nestjs/devtools-integration';@VendurePlugin({    imports: [        DevtoolsModule.register({            // The reason we are checking the NODE_ENV environment             // variable here is that you should never use this module in production!            http: process.env.NODE_ENV !== 'production',        }),    ],})class DevtoolsPlugin {}
```

Example 3 (ts):
```ts
import { bootstrap } from '@vendure/core';import { config } from './vendure-config';const configWithDevtools = {    ...config,    plugins: [        ...config.plugins,        DevtoolsPlugin,    ],};bootstrap(configWithDevtools, {    nestApplicationOptions: { snapshot: true } })    .catch(err => {        console.log(err);        process.exit(1);    });
```

---

## CLI

**URL:** https://docs.vendure.io/guides/developer-guide/cli

**Contents:**
- CLI
- Installation​
- Interactive vs Non-Interactive Mode​
- The Add Command​
  - Interactive Mode​
  - Non-Interactive Mode​
    - Add Command Options​
    - Sub-options for specific commands​
- The Migrate Command​
  - Interactive Mode​

The Vendure CLI is a command-line tool for boosting your productivity as a developer by automating common tasks such as creating new plugins, entities, API extensions and more.

It is much more than just a scaffolding tool - it is able to analyze your project and intelligently modify your existing codebase to integrate new functionality.

The Vendure CLI comes installed with a new Vendure project by default from v2.2.0+

To manually install the CLI, run:

The Vendure CLI supports both interactive and non-interactive modes:

The add command is used to add new entities, resolvers, services, plugins, and more to your Vendure project.

From your project's root directory, run:

The CLI will guide you through the process of adding new functionality to your project.

The add command is much more than a simple file generator. It is able to analyze your project source code to deeply understand and correctly update your project files.

For automation or when you know exactly what you need to add, you can use the non-interactive mode with specific arguments and options:

Entity (-e) additional options:

Service (-s) additional options:

Job Queue (-j) additional options:

API Extension (-a) additional options: (requires either)

Validation: Entity and service commands validate that the specified plugin exists in your project. If the plugin is not found, the command will list all available plugins in the error message. Both commands require the --selected-plugin parameter when running in non-interactive mode.

The migrate command is used to generate and manage database migrations for your Vendure project.

From your project's root directory, run:

For migration operations, use specific arguments and options:

The schema command was added in Vendure v3.5

The schema command allows you to generate a schema file for your Admin or Shop APIs, in either the GraphQL schema definition language (SDL) or as JSON.

This is useful when integrating with GraphQL tooling such as your IDE's GraphQL plugin.

From your project's root directory, run:

To automate or quickly generate a schema in one command

To see all available commands and options:

**Examples:**

Example 1 (bash):
```bash
npm install -D @vendure/cli
```

Example 2 (bash):
```bash
yarn add -D @vendure/cli
```

Example 3 (bash):
```bash
npx vendure add
```

Example 4 (bash):
```bash
yarn vendure add
```

---

## v2 Database Migration

**URL:** https://docs.vendure.io/guides/developer-guide/migrating-from-v1/database-migration

**Contents:**
- v2 Database Migration

Vendure v2 introduces a number of breaking changes to the database schema, some of which require quite complex migrations in order to preserve existing data. To make this process as smooth as possible, we have created a migration tool which will handle the hard parts for you!

Important! It is critical that you back up your production data prior to attempting this migration.

Note for MySQL/MariaDB users: transactions for migrations are not supported by these databases. This means that if the migration fails for some reason, the statements that have executed will not get rolled back, and your DB schema can be left in an inconsistent state from which is it can be hard to recover. Therefore, it is doubly critical that you have a good backup that you can easily restore prior to attempting this migration.

Make sure all your Vendure packages to the latest v2 versions.

Use your package manager to install the v2 migration tool: npm install @vendure/migrate-v2

Add the MigrationV2Plugin to your plugins array:

The sole function of this plugin is to temporarily remove some "NOT NULL" constraints from certain columns, which allows us to run the next part of the migration.

Generate a new migration file, npm run migration:generate v2

Edit the newly-created migration file by following the comments in these examples:

In your migrations files, you'll import the vendureV2Migrations from @vendure/migrate-v2.

Run the migration with npm run migration:run.

Upon successful migration, remove the MigrationV2Plugin from your plugins array, and generate another migration. This one will add back the missing "NOT NULL" constraints now that all your data has been successfully migrated.

**Examples:**

Example 1 (ts):
```ts
import { MigrationV2Plugin } from '@vendure/migrate-v2';//...const config: VendureConfig = {  //..  plugins: [    MigrationV2Plugin,  ]}
```

---

## Cache

**URL:** https://docs.vendure.io/guides/developer-guide/cache/

**Contents:**
- Cache
- Setting up the cache​
  - DefaultCachePlugin​
  - RedisCachePlugin​
- CacheService​
  - Multi-instance use​
  - Usage​
  - Cache key naming​
  - Cache eviction​
  - Cache tags​

Caching is a technique to improve performance of a system by saving the results of expensive operations and reusing them when the same operation is requested again.

Vendure uses caching in a number of places to improve performance, and the same caching mechanism is available for use in custom plugins.

In order to take advantage of Vendure distributed caching, you need to enable a cache plugin.

If no cache plugin is specified, Vendure uses an in-memory cache which is not shared between instances. This is suitable for development, but not recommended for production use.

The DefaultCachePlugin uses the database to store the cache data. This is a simple and effective cache strategy which has the advantage of not requiring any additional infrastructure.

After enabling the DefaultCachePlugin, you will need to generate a migration to add the necessary tables to the database.

Vendure also provides a RedisCachePlugin which uses a Redis server to store the cache data and can have better performance characteristics.

The CacheService is the general-purpose API for interacting with the cache. It provides methods for setting, getting and deleting cache entries.

Internally, the CacheService uses a CacheStrategy to store the data. The cache strategy is responsible for the actual storage and retrieval of the data. The CacheService provides a consistent API which can be used regardless of the underlying cache strategy.

From Vendure v3.1, new projects are created with the DefaultCachePlugin enabled by default. This plugin uses the database to store the cache data. This is a simple and effective cache strategy which is suitable for most use-cases.

For more advanced use-cases, you can use the RedisCachePlugin which uses a Redis server to store the cache data and can have better performance characteristics.

It is common to run Vendure in a multi-instance setup, where multiple instances of the server and worker are running in parallel.

The CacheService is designed to work in this environment. Both the DefaultCachePlugin and the RedisCachePlugin use a single shared cache across all instances.

This means that if one instance sets a cache entry, it will be available to all other instances. Likewise, if one instance deletes a cache entry, it will be deleted for all other instances.

The CacheService can be injected into any service, resolver, strategy or configurable operation.

The data stored in the cache must be serializable. This means you cannot store instances of classes, functions, or other non-serializable data types.

This restriction means you're limited to storing basic JavaScript types like strings, numbers, booleans, arrays, and plain objects. Complex class instances and function references cannot be persisted in the cache.

**Cache Key Naming Conventions:**

Proper key naming prevents conflicts across your application. The recommended approach combines class and method names as a namespace prefix with unique identifiers specific to the cached data.

Example pattern:
```typescript
getVariantIds(productId: ID): Promise<ID[]> {
    const cacheKey = `ProductService.getVariantIds:${productId}`;
    // ... cache operations
}
```

**Cache Eviction Strategies:**

Two primary eviction mechanisms exist:

**Time-to-Live (TTL)**: Set when storing entries, determining how long they persist before automatic removal.

```typescript
await this.cacheService.set(cacheKey, newValue, { ttl: 60 * 1000 }); // 1 minute
```

**Manual Deletion**: Remove entries programmatically when needed.

```typescript
await this.cacheService.delete(cacheKey);
```

**Cache Tags Usage:**

Tags enable batch invalidation of related entries without knowing individual keys:

```typescript
const cacheKey = `ProductService.getVariantIds:${productId}`;
await this.cacheService.set(cacheKey, newValue, {
    tags: [`Product:${productId}`]
});

// Later, invalidate all Product-related entries
await this.cacheService.invalidateTags([`Product:${productId}`]);
```

**Examples:**

Example 1 (ts):
```ts
import { DefaultCachePlugin, VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    plugins: [        DefaultCachePlugin.init({            // optional maximum number of items to            // store in the cache. Defaults to 10,000            cacheSize: 20_000,        }),    ],};
```

Example 2 (ts):
```ts
import { RedisCachePlugin, VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    plugins: [        RedisCachePlugin.init({            redisOptions: {                host: 'localhost',                port: 6379,            },        }),    ],};
```

Example 3 (ts):
```ts
import { Injectable } from '@nestjs/common';import { CacheService } from '@vendure/core';@Injectable()export class MyService {    constructor(private cacheService: CacheService) {}    async myMethod() {        const cacheKey = 'MyService.myMethod';        const cachedValue = await this.cacheService.get(cacheKey);        if (cachedValue) {            return cachedValue;        }        const newValue = await this.expensiveOperation();        // Cache the result for 1 minute (60 * 1000 milliseconds)        await this.cacheService.set(cacheKey, newValue, { ttl: 60 * 1000 });        return newValu
...
```

Example 4 (ts):
```ts
getVariantIds(productId: ID): Promise<ID[]> {    const cacheKey = `ProductService.getVariantIds:${productId}`;    const cachedValue = await this.cacheService.get(cacheKey);    if (cachedValue) {        return cachedValue;    }    const newValue = await this.expensiveOperation(productId);    await this.cacheService.set(cacheKey, newValue, { ttl: 60 * 1000 });    return newValue;}
```

---

## Updating Vendure

**URL:** https://docs.vendure.io/guides/developer-guide/updating/

**Contents:**
- Updating Vendure
- How to update​
- Versioning Policy & Breaking changes​
  - What kinds of breaking changes can be expected?​
  - Database migrations​
  - GraphQL schema changes​
  - TypeScript API changes​

This guide provides guidance for updating the Vendure core framework to a newer version.

First, check the changelog for an overview of the changes and any breaking changes in the next version.

In your project's package.json file, find all the @vendure/... packages and change the version to the latest. All the Vendure packages have the same version, and are all released together.

Then run npm install or yarn install depending on which package manager you prefer.

Vendure generally follows the SemVer convention for version numbering. This means that breaking API changes will only be introduced with changes to the major version (the first of the 3 digits in the version).

However, there are some exceptions to this rule:

Any instances of these exceptions will be clearly indicated in the Changelog. The reasoning for these exceptions is discussed in the Versioning policy RFC.

Major version upgrades (e.g. v1.x to v2.x) can include:

Every release will be accompanied by an entry in the changelog, listing the changes in that release. And breaking changes are clearly listed under a BREAKING CHANGE heading.

Database changes are one of the most common causes for breaking changes. In most cases, the changes are minor (such as the addition of a new column) and non-destructive (i.e. performing the migration has no risk of data loss).

However, some more fundamental changes occasionally require a careful approach to database migration in order to preserve existing data.

The key rule is never run your production instance with the synchronize option set to true. Doing so can cause inadvertent data loss in rare cases.

For any database schema changes, it is advised to:

If you are using a code-generation tool (such as graphql-code-generator) for your custom plugins or storefront, it is a good idea to re-generate after upgrading, which will catch any errors caused by changes to the GraphQL schema.

If you are using Vendure providers (services, JobQueue, EventBus etc.) in your custom plugins, you should look out for breakages caused by changes to those services. Major changes will be listed in the changelog, but occasionally internal changes may also impact your code.

The best way to check whether this is the case is to build your entire project after upgrading, to see if any new TypeScript compiler errors emerge.

**Examples:**

Example 1 (diff):
```diff
{  // ...  "dependencies": {-    "@vendure/common": "1.1.5",+    "@vendure/common": "1.2.0",-    "@vendure/core": "1.1.5",+    "@vendure/core": "1.2.0",     // etc.  }}
```

---

## Implementing ChannelAware

**URL:** https://docs.vendure.io/guides/developer-guide/channel-aware/

**Contents:**
- Implementing ChannelAware
- Defining channel-aware entities​
- Creating channel-aware entities​
- Querying channel-aware entities​

Making an entity channel-aware means that it can be associated with a specific Channel. This is useful when you want to have different data or features for different channels. First you will have to create an entity (Define a database entity) that implements the ChannelAware interface. This interface requires the entity to provide a channels property

Creating a channel-aware entity is similar to creating a regular entity. The only difference is that you need to assign the entity to the current channel. This can be done by using the ChannelService which provides the assignToCurrentChannel helper function.

The assignToCurrentChannel function will only assign the channels property of the entity. You will still need to save the entity to the database.

For Translatable entities, the best place to assign the channels is inside the beforeSave input of the TranslatableSaver helper class.

When querying channel-aware entities, you can use the ListQueryBuilder or the TransactionalConnection to automatically filter entities based on the provided channel id.

**Examples:**

Example 1 (ts):
```ts
import { DeepPartial } from '@vendure/common/lib/shared-types';import { VendureEntity, Product, EntityId, ID, ChannelAware } from '@vendure/core';import { Column, Entity, ManyToOne } from 'typeorm';@Entity()class ProductRequest extends VendureEntity implements ChannelAware {    constructor(input?: DeepPartial<ProductRequest>) {        super(input);    }    @ManyToOne(type => Product)    product: Product;    @EntityId()    productId: ID;    @Column()    text: string;        @ManyToMany(() => Channel)    @JoinTable()    channels: Channel[];}
```

Example 2 (ts):
```ts
import { ChannelService } from '@vendure/core';export class RequestService {    constructor(private channelService: ChannelService) {}    async create(ctx: RequestContext, input: CreateRequestInput): Promise<ProductRequest> {        const request = new ProductRequest(input);        // Now we need to assign the request to the current channel (+ default channel)        await this.channelService.assignToCurrentChannel(input, ctx);                return await this.connection.getRepository(ProductRequest).save(request);    }}
```

Example 3 (ts):
```ts
import { ChannelService, ListQueryBuilder, TransactionalConnection } from '@vendure/core';export class RequestService {    constructor(        private connection: TransactionalConnection,        private listQueryBuilder: ListQueryBuilder,        private channelService: ChannelService) {}    findOne(ctx: RequestContext,            requestId: ID,            relations?: RelationPaths<ProductRequest>) {        return this.connection.findOneInChannel(ctx, ProductRequest, requestId, ctx.channelId, {            relations: unique(effectiveRelations)        });    }    findAll(        ctx: RequestConte
...
```

---

## Add a REST endpoint

**URL:** https://docs.vendure.io/guides/developer-guide/rest-endpoint/

**Contents:**
- Add a REST endpoint
- Create a controller​
- Register the controller with the plugin​
- Controlling access to REST endpoints​

REST-style endpoints can be defined as part of a plugin.

REST endpoints are implemented as NestJS Controllers. For comprehensive documentation, see the NestJS controllers documentation.

In this guide we will define a plugin that adds a single REST endpoint at http://localhost:3000/products which returns a list of all products.

First let's define the controller:

The key points to note here are:

Note: The PluginCommonModule should be imported to gain access to Vendure core providers - in this case it is required in order to be able to inject ProductService into our controller.

The plugin can then be added to the VendureConfig:

You can use the @Allow() decorator to declare the permissions required to access a REST endpoint:

The following Vendure API decorators can also be used with NestJS controllers: @Allow(), @Transaction(), @Ctx().

Additionally, NestJS supports a number of other REST decorators detailed in the NestJS controllers guide

**Examples:**

Example 1 (ts):
```ts
// products.controller.tsimport { Controller, Get } from '@nestjs/common';import { Ctx, ProductService, RequestContext } from '@vendure/core';@Controller('products')export class ProductsController {    constructor(private productService: ProductService) {    }    @Get()    findAll(@Ctx() ctx: RequestContext) {        return this.productService.findAll(ctx);    }}
```

Example 2 (ts):
```ts
import { PluginCommonModule, VendurePlugin } from '@vendure/core';import { ProductsController } from './api/products.controller';@VendurePlugin({  imports: [PluginCommonModule],  controllers: [ProductsController],})export class RestPlugin {}
```

Example 3 (ts):
```ts
import { VendureConfig } from '@vendure/core';import { RestPlugin } from './plugins/rest-plugin/rest.plugin';export const config: VendureConfig = {    // ...    plugins: [        // ...        RestPlugin,    ],};
```

Example 4 (ts):
```ts
import { Controller, Get } from '@nestjs/common';import { Allow, Permission, Ctx, ProductService, RequestContext } from '@vendure/core';@Controller('products')export class ProductsController {    constructor(private productService: ProductService) {}    @Allow(Permission.ReadProduct)    @Get()    findAll(@Ctx() ctx: RequestContext) {        return this.productService.findAll(ctx);    }}
```

---

## Custom Fields

**URL:** https://docs.vendure.io/guides/developer-guide/custom-fields/

**Contents:**
- Custom Fields
- Defining custom fields​
- Available custom field types​
    - Relations​
- Accessing custom fields in TypeScript​
- Custom field config properties​
  - Common properties​
    - name​
    - type​
    - list​

Custom fields allow you to add your own custom data properties to almost every Vendure entity. The entities which may have custom fields defined are listed in the CustomFields interface documentation.

Some use-cases for custom fields include:

Custom fields are not solely restricted to Vendure's native entities though, it's also possible to add support for custom fields to your own custom entities. See: Supporting custom fields

Custom fields are specified in the VendureConfig:

With the example config above, the following will occur:

The values of the custom fields can then be set and queried via the GraphQL APIs:

The custom fields will also extend the filter and sort options available to the products list query:

The following types are available for custom fields:

To see the underlying DB data type and GraphQL type used for each, see the CustomFieldType doc.

It is possible to set up custom fields that hold references to other entities using the 'relation' type:

In this example, we set up a many-to-one relationship from Customer to Asset, allowing us to specify an avatar image for each Customer. Relation custom fields are unique in that the input and output names are not the same - the input will expect an ID and will be named '<field name>Id' or '<field name>Ids' for list types.

As well as exposing custom fields via the GraphQL APIs, you can also access them directly in your TypeScript code. This is useful for plugins which need to access custom field data.

Given the following custom field configuration:

the externalId will be available whenever you access a Customer entity:

The avatar relation will require an explicit join to be performed in order to access the data, since it is not eagerly loaded by default:

or if using the QueryBuilder API:

or using the EntityHydrator:

All custom fields share some common properties:

The name of the field. This is used as the column name in the database, and as the GraphQL field name. The name should not contain spaces and by convention should be camelCased.

The type of data that will be stored in the field.

If set to true, then the field will be an array of the specified type. Defaults to false.

Setting a custom field to be a list has the following effects:

An array of localized labels for the field. These are used in the Dashboard to label the field.

An array of localized descriptions for the field. These are used in the Dashboard to describe the field.

Whether the custom field is available via the GraphQL APIs or only accessible internally within TypeScript plugins.

**Available via GraphQL APIs:**
- Set to `false` to make the field `internal: true`
- Internal fields are inaccessible via GraphQL but usable in TypeScript code
- Defaults to `false` (field is accessible via GraphQL)

**Common Custom Field Properties:**

**`name`**: The name of the field. Used as the column name in the database and as the GraphQL field name. Should not contain spaces and by convention should be camelCased.

**`type`**: The type of data that will be stored in the field. Available types include: `string`, `localeString`, `int`, `float`, `boolean`, `datetime`, `relation`, `text`, `localeText`, and `struct`.

**`list`**: If set to `true`, the field will be an array of the specified type. Defaults to `false`. Setting a custom field as a list affects GraphQL types, dashboard UI, and database storage (simple-json for primitives).

**`label`**: An array of localized labels for the field, used in the Dashboard to label the field.

**`description`**: An array of localized descriptions for the field, used in the Dashboard to describe the field.

**`nullable`**: Determines if a custom field can store null values in the database. If set to `false`, a `defaultValue` must be provided to prevent database errors.

**`internal`**: If set to `true`, makes the field inaccessible via GraphQL APIs but usable within TypeScript plugins. Defaults to `false`.

**`readonly`**: If set to `true`, prevents modification of the field value via the GraphQL API.

**`ui`**: Object for customizing the form input component in the Admin UI. Can specify `component`, `tab`, and other UI-related options.

**Examples:**

Example 1 (ts):
```ts
const config = {    // ...    customFields: {        Product: [            { name: 'infoUrl', type: 'string' },            { name: 'downloadable', type: 'boolean' },            { name: 'shortName', type: 'localeString' },        ],        User: [            { name: 'socialLoginToken', type: 'string', unique: true },        ],    },};
```

Example 2 (graphql):
```graphql
mutation {    updateProduct(input: {        id: 1        customFields: {        infoUrl: "https://some-url.com",        downloadable: true,        }        translations: [        { languageCode: en, customFields: { shortName: "foo" } }        ]        }) {        id        name        customFields {            infoUrl            downloadable            shortName        }    }}
```

Example 3 (json):
```json
{    "data": {        "product": {            "id": "1",            "name": "Laptop",            "customFields": {                "infoUrl": "https://some-url.com",                "downloadable": true,                "shortName": "foo"            }        }    }}
```

Example 4 (graphql):
```graphql
query {    products(options: {    filter: {        infoUrl: { contains: "new" },        downloadable: { eq: true }        },        sort: {            infoUrl: ASC        }        }) {        items {            id            name            customFields {                infoUrl                downloadable                shortName            }        }    }}
```

---

## Implementing HasCustomFields

**URL:** https://docs.vendure.io/guides/developer-guide/has-custom-fields

**Contents:**
- Implementing HasCustomFields
- Defining entities that support custom fields​
  - Type generation​
- Supporting custom fields in your services​
- Updating config​
- Migrations​

From Vendure v2.2, it is possible to add support for custom fields to your custom entities. This is useful when you are defining a custom entity as part of a plugin which is intended to be used by other developers. For example, a plugin which defines a new entity for storing product reviews might want to allow the developer to add custom fields to the review entity.

First you need to update your entity class to implement the HasCustomFields interface, and provide an empty class which will be used to store the custom field values:

Given the above entity your API extension might look like this:

Notice the lack of manually defining customFields on the types, this is because Vendure extends the types automatically once your entity implements HasCustomFields.

In order for Vendure to find the correct input types to extend to, they must conform to the naming convention of:

And if your entity is supporting translations:

Following this caveat, codegen will now produce correct types including customFields-fields like so:

Creating and updating your entity works now by setting the fields like usual, with one important addition being, you mustn't forget to update relations via the CustomFieldRelationService. This is needed because a consumer of your plugin may extend the entity with custom fields of type relation which need to get saved separately.

Now you'll be able to add custom fields to the ProductReview entity via the VendureConfig:

Extending entities will alter the database schema requiring a migration. See the migrations guide for further details.

**Examples:**

Example 1 (ts):
```ts
import {    DeepPartial,    HasCustomFields,    Product,    VendureEntity,    ID,    EntityId,} from '@vendure/core';import { Column, Entity, ManyToOne } from 'typeorm';export class CustomProductReviewFields {}@Entity()export class ProductReview extends VendureEntity implements HasCustomFields {    constructor(input?: DeepPartial<ProductReview>) {        super(input);    }    @Column(() => CustomProductReviewFields)    customFields: CustomProductReviewFields;        @ManyToOne(() => Product)    product: Product;    @EntityId()    productId: ID;    @Column()    text: string;    @Column()    rat
...
```

Example 2 (graphql):
```graphql
type ProductReview implements Node {  id: ID!  createdAt: DateTime!  updatedAt: DateTime!  product: Product!  productId: ID!  text: String!  rating: Int!}input CreateProductReviewInput {  productId: ID!  text: String!  rating: Int!}input UpdateProductReviewInput {  id: ID!  productId: ID  text: String  rating: Int}
```

Example 3 (ts):
```ts
export type ProductReview = Node & {  customFields?: Maybe<Scalars['JSON']['output']>;  // Note: Other fields omitted for brevity}export type CreateProductReviewInput = {  customFields?: InputMaybe<Scalars['JSON']['input']>;  // Note: Other fields omitted for brevity}export type UpdateProductReviewInput = {  customFields?: InputMaybe<Scalars['JSON']['input']>;  // Note: Other fields omitted for brevity}
```

Example 4 (ts):
```ts
import { Injectable } from '@nestjs/common';import { RequestContext, Product, TransactionalConnection, CustomFieldRelationService } from '@vendure/core';import { ProductReview } from '../entities/product-review.entity';@Injectable()export class ReviewService {    constructor(      private connection: TransactionalConnection,      private customFieldRelationService: CustomFieldRelationService,    ) {}    async create(ctx: RequestContext, input: CreateProductReviewInput) {        const product = await this.connection.getEntityOrThrow(ctx, Product, input.productId);        // You'll probably want
...
```

---

## Configuration

**URL:** https://docs.vendure.io/guides/developer-guide/configuration/

**Contents:**
- Configuration
- Important Configuration Settings​
  - Specifying API hostname & port etc​
  - Connecting to the database​
  - Configuring authentication​
- Working with the VendureConfig object​
  - Using environment variables​
  - Splitting config across files​

Every aspect of the Vendure server is configured via a single, central VendureConfig object. This object is passed into the bootstrap and bootstrapWorker functions to start up the Vendure server and worker respectively.

The VendureConfig object is organised into sections, grouping related settings together. For example, VendureConfig.apiOptions contains all the config for the GraphQL APIs, whereas VendureConfig.authOptions deals with authentication.

In this guide, we will take a look at those configuration options needed for getting the server up and running.

A description of every available configuration option can be found in the VendureConfig reference docs.

The VendureConfig.apiOptions object is used to set the hostname, port, as well as other API-related concerns. Express middleware and Apollo Server plugins may also be specified here.

The database connection is configured with the VendureConfig.dbConnectionOptions object. This object is actually the TypeORM DataSourceOptions object and is passed directly to TypeORM.

Authentication settings are configured with VendureConfig.authOptions. The most important setting here is whether the storefront client will use cookies or bearer tokens to manage user sessions. For more detail on this topic, see the Managing Sessions guide.

The username and default password of the superadmin user can also be specified here. In production, it is advisable to use environment variables for these settings (see the following section on usage of environment variables).

Since the VendureConfig is just a JavaScript object, it can be managed and manipulated according to your needs. For example:

Environment variables can be used when you don't want to hard-code certain values which may change, e.g. depending on whether running locally, in staging or in production:

They are also useful so that sensitive credentials do not need to be hard-coded and committed to source control:

When you create a Vendure project with @vendure/create, it comes with the dotenv package installed, which allows you to store environment variables in a .env file in the root of your project.

To define new environment variables, you can add them to the .env file. For instance, if you are using a plugin that requires an API key, you can

In order to tell TypeScript about the existence of this new variable, you can add it to the src/environment.d.ts file:

You can then use the environment variable in your config file:

In production, the way you manage environment variables depends on your hosting provider. Consult the Production Configuration guide for specific deployment strategies.

**Declaring Environment Variables in TypeScript:**

Define variables in `src/environment.d.ts` for TypeScript support:

```typescript
export {};

declare global {
    namespace NodeJS {
        interface ProcessEnv {
            APP_ENV: string;
            COOKIE_SECRET: string;
            SUPERADMIN_USERNAME: string;
            SUPERADMIN_PASSWORD: string;
            MY_API_KEY: string;
        }
    }
}
```

Then reference them safely in your config:

```typescript
export const config: VendureConfig = {
  plugins: [
    MyPlugin.init({
      apiKey: process.env.MY_API_KEY,
    }),
  ],
  // ...
}
```

**Splitting Config Across Files:**

For large configurations, especially with multiple plugins, separate concerns into dedicated files:

```typescript
// src/vendure-config-plugins.ts
import { AssetServerPlugin, DefaultJobQueuePlugin, VendureConfig } from '@vendure/core';
import { ElasticsearchPlugin } from '@vendure/elasticsearch-plugin';
import { EmailPlugin } from '@vendure/email-plugin';
import { CustomPlugin } from './plugins/custom-plugin';

export const plugins: VendureConfig['plugins'] = [
  CustomPlugin,
  AssetServerPlugin.init({
      route: 'assets',
      assetUploadDir: path.join(__dirname, 'assets'),
      port: 5002,
  }),
  DefaultJobQueuePlugin,
  ElasticsearchPlugin.init({
      host: 'localhost',
      port: 9200,
  }),
  EmailPlugin.init({
    // ...lots of lines of config
  }),
];
```

Import and compose in your main config:

```typescript
// src/vendure-config.ts
import { VendureConfig } from '@vendure/core';
import { plugins } from './vendure-config-plugins';

export const config: VendureConfig = {
  plugins,
  // ...
}
```

This modular approach keeps configuration maintainable as your system grows.

**Examples:**

Example 1 (ts):
```ts
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {  apiOptions: {    hostname: 'localhost',    port: 3000,    adminApiPath: '/admin',    shopApiPath: '/shop',    middleware: [{      // add some Express middleware to the Shop API route      handler: timeout('5s'),      route: 'shop',    }]  },  // ...}
```

Example 2 (ts):
```ts
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {  dbConnectionOptions: {    type: 'postgres',    host: process.env.DB_HOST,    port: process.env.DB_PORT,    synchronize: false,    username: process.env.DB_USERNAME,    password: process.env.DB_PASSWORD,    database: 'vendure',    migrations: [path.join(__dirname, 'migrations/*.ts')],  },  // ...}
```

Example 3 (ts):
```ts
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {  authOptions: {    tokenMethod: 'cookie',    requireVerification: true,    cookieOptions: {      secret: process.env.COOKIE_SESSION_SECRET,    },    superadminCredentials: {      identifier: process.env.SUPERADMIN_USERNAME,      password: process.env.SUPERADMIN_PASSWORD,    },  },  // ...}
```

Example 4 (ts):
```ts
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {  apiOptions: {    hostname: process.env.HOSTNAME,    port: process.env.PORT,  }  // ...};
```

---

## Implementing ChannelAware

**URL:** https://docs.vendure.io/guides/developer-guide/channel-aware

**Contents:**
- Implementing ChannelAware
- Defining channel-aware entities​
- Creating channel-aware entities​
- Querying channel-aware entities​

Making an entity channel-aware means that it can be associated with a specific Channel. This is useful when you want to have different data or features for different channels. First you will have to create an entity (Define a database entity) that implements the ChannelAware interface. This interface requires the entity to provide a channels property

Creating a channel-aware entity is similar to creating a regular entity. The only difference is that you need to assign the entity to the current channel. This can be done by using the ChannelService which provides the assignToCurrentChannel helper function.

The assignToCurrentChannel function will only assign the channels property of the entity. You will still need to save the entity to the database.

For Translatable entities, the best place to assign the channels is inside the beforeSave input of the TranslatableSaver helper class.

When querying channel-aware entities, you can use the ListQueryBuilder or the TransactionalConnection to automatically filter entities based on the provided channel id.

**Examples:**

Example 1 (ts):
```ts
import { DeepPartial } from '@vendure/common/lib/shared-types';import { VendureEntity, Product, EntityId, ID, ChannelAware } from '@vendure/core';import { Column, Entity, ManyToOne } from 'typeorm';@Entity()class ProductRequest extends VendureEntity implements ChannelAware {    constructor(input?: DeepPartial<ProductRequest>) {        super(input);    }    @ManyToOne(type => Product)    product: Product;    @EntityId()    productId: ID;    @Column()    text: string;        @ManyToMany(() => Channel)    @JoinTable()    channels: Channel[];}
```

Example 2 (ts):
```ts
import { ChannelService } from '@vendure/core';export class RequestService {    constructor(private channelService: ChannelService) {}    async create(ctx: RequestContext, input: CreateRequestInput): Promise<ProductRequest> {        const request = new ProductRequest(input);        // Now we need to assign the request to the current channel (+ default channel)        await this.channelService.assignToCurrentChannel(input, ctx);                return await this.connection.getRepository(ProductRequest).save(request);    }}
```

Example 3 (ts):
```ts
import { ChannelService, ListQueryBuilder, TransactionalConnection } from '@vendure/core';export class RequestService {    constructor(        private connection: TransactionalConnection,        private listQueryBuilder: ListQueryBuilder,        private channelService: ChannelService) {}    findOne(ctx: RequestContext,            requestId: ID,            relations?: RelationPaths<ProductRequest>) {        return this.connection.findOneInChannel(ctx, ProductRequest, requestId, ctx.channelId, {            relations: unique(effectiveRelations)        });    }    findAll(        ctx: RequestConte
...
```

---

## Error Handling

**URL:** https://docs.vendure.io/guides/developer-guide/error-handling/

**Contents:**
- Error Handling
- Unexpected Errors​
- Expected errors (ErrorResults)​
  - Querying an ErrorResult union​
  - Handling ErrorResults in plugin code​
  - Handling ErrorResults in client code​
- Live example​

Errors in Vendure can be divided into two categories:

These two types have different meanings and are handled differently from one another.

This type of error occurs when something goes unexpectedly wrong during the processing of a request. Examples include internal server errors, database connectivity issues, lacking permissions for a resource, etc. In short, these are errors that are not supposed to happen.

Internally, these situations are handled by throwing an Error:

In the GraphQL APIs, these errors are returned in the standard errors array:

So your client applications need a generic way of detecting and handling this kind of error. For example, many http client libraries support "response interceptors" which can be used to intercept all API responses and check the errors array.

GraphQL will return a 200 status even if there are errors in the errors array. This is because in GraphQL it is still possible to return good data alongside any errors.

Here's how it might look in a simple Fetch-based client:

This type of error represents a well-defined result of (typically) a GraphQL mutation which is not considered "successful". For example, when using the applyCouponCode mutation, the code may be invalid, or it may have expired. These are examples of "expected" errors and are named in Vendure "ErrorResults". These ErrorResults are encoded into the GraphQL schema itself.

ErrorResults all implement the ErrorResult interface:

Some ErrorResults add other relevant fields to the type:

Operations that may return ErrorResults use a GraphQL union as their return type:

When performing an operation of a query or mutation which returns a union, you will need to use the GraphQL conditional fragment to select the desired fields:

The __typename field is added by GraphQL to all object types, so we can include it no matter whether the result will end up being an Order object or an ErrorResult object. We can then use the __typename value to determine what kind of object we have received.

Some clients such as Apollo Client will automatically add the __typename field to all queries and mutations. If you are using a client which does not do this, you will need to add it manually.

Here's how a response would look in both the success and error result cases:

If you are writing a plugin which deals with internal Vendure service methods that may return ErrorResults, then you can use the isGraphQlErrorResult() function to check whether the result is an ErrorResult:

```typescript
import { Injectable } from '@nestjs/common';
import { isGraphQlErrorResult, Order, OrderService, RequestContext } from '@vendure/core';

@Injectable()
export class MyService {
  constructor(private orderService: OrderService) {}

  async myMethod(ctx: RequestContext, order: Order, newState: OrderState) {
    const transitionResult = await this.orderService.transitionToState(
      ctx,
      order.id,
      newState
    );

    if (isGraphQlErrorResult(transitionResult)) {
      // Handle the error
      throw transitionResult;
    }

    // Success - transitionResult is now typed as Order
    return transitionResult;
  }
}
```

**Best Practices:**

1. **Client-Side**: Use exhaustive switch statements with `__typename` to handle all possible result types
2. **Plugin Code**: Use `isGraphQlErrorResult()` to differentiate ErrorResults from successful responses
3. **Type Safety**: Leverage TypeScript's type narrowing after error checks
4. **Error Propagation**: Throw ErrorResults in plugin code to propagate them up to GraphQL responses

**Examples:**

Example 1 (ts):
```ts
const customer = await this.findOneByUserId(ctx, user.id);// in this case, the customer *should always* be found, and if// not then something unknown has gone wrong...if (!customer) {    throw new InternalServerError('error.cannot-locate-customer-for-user');}
```

Example 2 (json):
```json
{  "errors": [    {      "message": "You are not currently authorized to perform this action",      "locations": [        {          "line": 2,          "column": 2        }      ],      "path": [        "me"      ],      "extensions": {        "code": "FORBIDDEN"      }    }  ],  "data": {    "me": null  }}
```

Example 3 (ts):
```ts
export function query(document: string, variables: Record<string, any> = {}) {    return fetch(endpoint, {        method: 'POST',        headers,        credentials: 'include',        body: JSON.stringify({            query: document,            variables,        }),    })        .then(async (res) => {            if (!res.ok) {                const body = await res.json();                throw new Error(body);            }            const newAuthToken = res.headers.get('vendure-auth-token');            if (newAuthToken) {                localStorage.setItem(AUTH_TOKEN_KEY, newAuthToken);     
...
```

Example 4 (graphql):
```graphql
interface ErrorResult {  errorCode: ErrorCode!  message: String!}
```

---

## Vendure Overview

**URL:** https://docs.vendure.io/guides/developer-guide/overview/

**Contents:**
- Vendure Overview
- Architecture​
- Technology stack​
- Design principles​

Read this page to gain a high-level understanding of Vendure and concepts you will need to know to build your application.

Vendure is a headless e-commerce platform. By "headless" we mean that it exposes all of its functionality via APIs. Specifically, Vendure features two GraphQL APIs: one for storefronts (Shop API) and the other for administrative functions (Admin API).

These are the major parts of a Vendure application:

Vendure is built on the following open-source technologies:

Vendure is designed to be:

---

## Implementing Translatable

**URL:** https://docs.vendure.io/guides/developer-guide/translatable/

**Contents:**
- Implementing Translatable
- Defining translatable entities​
  - Translations in the GraphQL schema​
- Creating translatable entities​
- Updating translatable entities​
- Loading translatable entities​

Making an entity translatable means that string properties of the entity can have a different values for multiple languages. To make an entity translatable, you need to implement the Translatable interface and add a translations property to the entity.

The translations property is a OneToMany relation to the translations. Any fields that are to be translated are of type LocaleString, and do not have a @Column() decorator. This is because the text field here does not in fact exist in the database in the product_request table. Instead, it belongs to the product_request_translations table of the ProductRequestTranslation entity:

Thus there is a one-to-many relation between ProductRequest and ProductRequestTranslation, which allows Vendure to handle multiple translations of the same entity. The ProductRequestTranslation entity also implements the Translation interface, which requires the languageCode field and a reference to the base entity.

Since the text field is getting hydrated with the translation it should be exposed in the GraphQL Schema. Additionally, the ProductRequestTranslation type should be defined as well, to access other translations as well:

Creating a translatable entity is usually done by using the TranslatableSaver. This injectable service provides a create and update method which can be used to save or update a translatable entity.

Important for the creation of translatable entities is the input object. The input object should contain a translations array with the translations for the entity. This can be done by defining the types like CreateRequestInput inside the GraphQL schema:

Updating a translatable entity is done in a similar way as creating one. The TranslatableSaver provides an update method which can be used to update a translatable entity.

Once again it's important to provide the translations array in the input object. This array should contain the translations for the entity.

If your plugin needs to load a translatable entity, you will need to use the TranslatorService to hydrate all the LocaleString fields will the actual translated values from the correct translation.

**Examples:**

Example 1 (ts):
```ts
import { DeepPartial } from '@vendure/common/lib/shared-types';import { VendureEntity, Product, EntityId, ID, Translatable } from '@vendure/core';import { Column, Entity, ManyToOne } from 'typeorm';import { ProductRequestTranslation } from './product-request-translation.entity';@Entity()class ProductRequest extends VendureEntity implements Translatable {    constructor(input?: DeepPartial<ProductRequest>) {        super(input);    }    text: LocaleString;        @ManyToOne(type => Product)    product: Product;    @EntityId()    productId: ID;    @OneToMany(() => ProductRequestTranslation, tran
...
```

Example 2 (ts):
```ts
import { DeepPartial } from '@vendure/common/lib/shared-types';import { HasCustomFields, Translation, VendureEntity, LanguageCode } from '@vendure/core';import { Column, Entity, Index, ManyToOne } from 'typeorm';import { ProductRequest } from './release-note.entity';@Entity()export class ProductRequestTranslation    extends VendureEntity    implements Translation<ProductRequest>, HasCustomFields{    constructor(input?: DeepPartial<Translation<ProductRequestTranslation>>) {        super(input);    }    @Column('varchar')    languageCode: LanguageCode;    @Column('varchar')    text: string; // s
...
```

Example 3 (graphql):
```graphql
type ProductRequestTranslation {    id: ID!    createdAt: DateTime!    updatedAt: DateTime!    languageCode: LanguageCode!    text: String!}type ProductRequest implements Node {    id: ID!    createdAt: DateTime!    updatedAt: DateTime!    # Will be filled with the translation for the current language    text: String!    translations: [ProductRequestTranslation!]!}
```

Example 4 (ts):
```ts
export class RequestService {    constructor(private translatableSaver: TranslatableSaver) {}    async create(ctx: RequestContext, input: CreateProductRequestInput): Promise<ProductRequest> {        const request = await this.translatableSaver.create({            ctx,            input,            entityType: ProductRequest,            translationType: ProductRequestTranslation,            beforeSave: async f => {                // Assign relations here            },        });        return request;    }}
```

---

## Testing

**URL:** https://docs.vendure.io/guides/developer-guide/testing/

**Contents:**
- Testing
- Usage​
  - Install dependencies​
  - Configure Vitest​
  - Register database-specific initializers​
  - Create a test environment​
  - Initialize the server​
  - Write your tests​
  - Run your tests​
- Accessing internal services​

Vendure plugins allow you to extend all aspects of the standard Vendure server. When a plugin gets somewhat complex (defining new entities, extending the GraphQL schema, implementing custom resolvers), you may wish to create automated tests to ensure your plugin is correct.

The @vendure/testing package gives you some simple but powerful tooling for creating end-to-end tests for your custom Vendure code.

By "end-to-end" we mean we are testing the entire server stack - from API, to services, to database - by making a real API request, and then making assertions about the response. This is a very effective way to ensure that all parts of your plugin are working correctly together.

For a working example of a Vendure plugin with e2e testing, see the real-world-vendure Reviews plugin

Create a vitest.config.mts file in the root of your project:

and a tsconfig.e2e.json tsconfig file for the tests:

The @vendure/testing package uses "initializers" to create the test databases and populate them with initial data. We ship with initializers for sqljs, postgres and mysql. Custom initializers can be created to support running e2e tests against other databases supported by TypeORM. See the TestDbInitializer docs for more details.

Note re. the sqliteDataDir: The first time this test suite is run with the SqljsInitializer, the populated data will be saved into an SQLite file, stored in the directory specified by this constructor arg. On subsequent runs of the test suite, the data-population step will be skipped and the initial data directly loaded from the SQLite file. This method of caching significantly speeds up the e2e test runs. All the .sqlite files created in the sqliteDataDir can safely be deleted at any time.

The @vendure/testing package exports a createTestEnvironment function which is used to set up a Vendure server and GraphQL clients to interact with both the Shop and Admin APIs:

Notice that we pass a VendureConfig object into the createTestEnvironment function. The testing package provides a special testConfig which is pre-configured for e2e tests, but any aspect can be overridden for your tests. Here we are configuring the server to load the plugin under test, MyPlugin.

Note: If you need to deeply merge in some custom configuration, use the mergeConfig function which is provided by @vendure/core.

The TestServer needs to be initialized before it can be used. The TestServer.init() method takes an options object which defines how to populate the server with data:

- **`productsCsvPath`**: Path to CSV file with product data (optional)
- **`initialData`**: Object defining non-product data like Collections and ShippingMethods
- **`customerCount`**: Number of fake customers to generate (defaults to 10)

**Test Environment Creation:**

```typescript
import { createTestEnvironment, testConfig } from '@vendure/testing';
import { describe, beforeAll, afterAll } from 'vitest';
import { MyPlugin } from '../my-plugin.ts';

describe('my plugin', () => {
    const { server, adminClient, shopClient } = createTestEnvironment({
        ...testConfig,
        plugins: [MyPlugin],
    });

    beforeAll(async () => {
        await server.init({
            productsCsvPath: path.join(__dirname, 'fixtures/e2e-products.csv'),
            initialData: myInitialData,
            customerCount: 2,
        });
        await adminClient.asSuperAdmin();
    }, 60000);

    afterAll(async () => {
        await server.destroy();
    });
});
```

**Writing Tests:**

```typescript
import gql from 'graphql-tag';
import { it, expect } from 'vitest';

it('myNewQuery returns the expected result', async () => {
    adminClient.asSuperAdmin();
    const query = gql`
        query MyNewQuery($id: ID!) {
            myNewQuery(id: $id) {
                field1
                field2
            }
        }
    `;
    const result = await adminClient.query(query, { id: 123 });
    expect(result.myNewQuery).toEqual({ /* ... */ });
});
```

**Examples:**

Example 1 (sh):
```sh
npm install --save-dev @vendure/testing vitest graphql-tag @swc/core unplugin-swc
```

Example 2 (ts):
```ts
import path from 'path';import swc from 'unplugin-swc';import { defineConfig } from 'vitest/config';export default defineConfig({    test: {        include: ['**/*.e2e-spec.ts'],        typecheck: {            tsconfig: path.join(__dirname, 'tsconfig.e2e.json'),        },    },    plugins: [        // SWC required to support decorators used in test plugins        // See https://github.com/vitest-dev/vitest/issues/708#issuecomment-1118628479        // Vite plugin        swc.vite({            jsc: {                transform: {                    // See https://github.com/vendure-ecommerce/vendur
...
```

Example 3 (json):
```json
{  "extends": "./tsconfig.json",  "compilerOptions": {    "types": ["node"],    "lib": ["es2015"],    "useDefineForClassFields": false,    "skipLibCheck": true,    "inlineSourceMap": false,    "sourceMap": true,    "allowSyntheticDefaultImports": true,    "experimentalDecorators": true,    "emitDecoratorMetadata": true,    "esModuleInterop": true  }}
```

Example 4 (ts):
```ts
import {    MysqlInitializer,    PostgresInitializer,    SqljsInitializer,    registerInitializer,} from '@vendure/testing';const sqliteDataDir = path.join(__dirname, '__data__');registerInitializer('sqljs', new SqljsInitializer(sqliteDataDir));registerInitializer('postgres', new PostgresInitializer());registerInitializer('mysql', new MysqlInitializer());
```

---

## Implementing HasCustomFields

**URL:** https://docs.vendure.io/guides/developer-guide/has-custom-fields/

**Contents:**
- Implementing HasCustomFields
- Defining entities that support custom fields​
  - Type generation​
- Supporting custom fields in your services​
- Updating config​
- Migrations​

From Vendure v2.2, it is possible to add support for custom fields to your custom entities. This is useful when you are defining a custom entity as part of a plugin which is intended to be used by other developers. For example, a plugin which defines a new entity for storing product reviews might want to allow the developer to add custom fields to the review entity.

First you need to update your entity class to implement the HasCustomFields interface, and provide an empty class which will be used to store the custom field values:

Given the above entity your API extension might look like this:

Notice the lack of manually defining customFields on the types, this is because Vendure extends the types automatically once your entity implements HasCustomFields.

In order for Vendure to find the correct input types to extend to, they must conform to the naming convention of:

And if your entity is supporting translations:

Following this caveat, codegen will now produce correct types including customFields-fields like so:

Creating and updating your entity works now by setting the fields like usual, with one important addition being, you mustn't forget to update relations via the CustomFieldRelationService. This is needed because a consumer of your plugin may extend the entity with custom fields of type relation which need to get saved separately.

Now you'll be able to add custom fields to the ProductReview entity via the VendureConfig:

Extending entities will alter the database schema requiring a migration. See the migrations guide for further details.

**Examples:**

Example 1 (ts):
```ts
import {    DeepPartial,    HasCustomFields,    Product,    VendureEntity,    ID,    EntityId,} from '@vendure/core';import { Column, Entity, ManyToOne } from 'typeorm';export class CustomProductReviewFields {}@Entity()export class ProductReview extends VendureEntity implements HasCustomFields {    constructor(input?: DeepPartial<ProductReview>) {        super(input);    }    @Column(() => CustomProductReviewFields)    customFields: CustomProductReviewFields;        @ManyToOne(() => Product)    product: Product;    @EntityId()    productId: ID;    @Column()    text: string;    @Column()    rat
...
```

Example 2 (graphql):
```graphql
type ProductReview implements Node {  id: ID!  createdAt: DateTime!  updatedAt: DateTime!  product: Product!  productId: ID!  text: String!  rating: Int!}input CreateProductReviewInput {  productId: ID!  text: String!  rating: Int!}input UpdateProductReviewInput {  id: ID!  productId: ID  text: String  rating: Int}
```

Example 3 (ts):
```ts
export type ProductReview = Node & {  customFields?: Maybe<Scalars['JSON']['output']>;  // Note: Other fields omitted for brevity}export type CreateProductReviewInput = {  customFields?: InputMaybe<Scalars['JSON']['input']>;  // Note: Other fields omitted for brevity}export type UpdateProductReviewInput = {  customFields?: InputMaybe<Scalars['JSON']['input']>;  // Note: Other fields omitted for brevity}
```

Example 4 (ts):
```ts
import { Injectable } from '@nestjs/common';import { RequestContext, Product, TransactionalConnection, CustomFieldRelationService } from '@vendure/core';import { ProductReview } from '../entities/product-review.entity';@Injectable()export class ReviewService {    constructor(      private connection: TransactionalConnection,      private customFieldRelationService: CustomFieldRelationService,    ) {}    async create(ctx: RequestContext, input: CreateProductReviewInput) {        const product = await this.connection.getEntityOrThrow(ctx, Product, input.productId);        // You'll probably want
...
```

---

## Importing Data

**URL:** https://docs.vendure.io/guides/developer-guide/importing-data/

**Contents:**
- Importing Data
- Product Import Format​
  - Importing Custom Field Data​
    - Importing relation custom fields​
    - Importing list custom fields​
    - Importing data in multiple languages​
- Initial Data​
- Populating The Server​
  - The populate() function​
  - Populating test data​

If you have hundreds, thousands or more products, inputting all the data by hand via the Dashboard can be too inefficient. To solve this, Vendure supports bulk-importing product and other data.

Data import is also useful for setting up test or demo environments, and is also used by the @vendure/testing package for end-to-end tests.

Vendure uses a flat .csv format for importing product data. The format encodes data about:

Here's an example which defines 2 products, "Laptop" and "Clacky Keyboard". The laptop has 4 variants, and the keyboard only a single variant.

Here's an explanation of each column:

If you have CustomFields defined on your Product or ProductVariant entities, this data can also be encoded in the import csv:

For a real example, see the products.csv file used to populate the Vendure demo data

To import custom fields with the type relation, the value in the CSV must be a stringified object with an id property:

To import custom fields with list set to true, the data should be separated with a pipe (|) character:

If a field is translatable (i.e. of localeString type), you can use column names with an appended language code (e.g. name:en, name:de, product:keywords:en, product:keywords:de) to specify its value in multiple languages.

Use of language codes has to be consistent throughout the file. You don't have to translate every translatable field. If there are no translated columns for a field, the generic column's value will be used for all languages. But when you do translate columns, the set of languages for each of them needs to be the same. As an example, you cannot use name:en and name:de, but only provide slug:en (it's okay to use only a slug column though, in which case this slug will be used for both the English and the German version).

As well as product data, other initialization data can be populated using the InitialData object. This format is intentionally limited; more advanced requirements (e.g. setting up ShippingMethods that use custom checkers & calculators) should be carried out via custom populate scripts.

The @vendure/core package exposes a populate() function which can be used along with the data formats described above to populate your Vendure server:

When removing the DefaultJobQueuePlugin from the plugins list as in the code snippet above, one should manually rebuild the search index in order for the newly added products to appear. In the Dashboard, this can be done by navigating to the product list view and clicking the button in the top right.

The interface provides a dedicated button in the top-right corner of the product list page for triggering a reindex operation.

**Programmatic Search Index Rebuild:**

For scripts, use the `SearchService`:

```typescript
const searchService = app.get(SearchService);
await searchService.reindex(ctx);
```

**Key Import Considerations:**

- **Remove JobQueuePlugin** during population to avoid generating unnecessary jobs
- **Use specialized import services** (`FastImporterService`, `Importer`) rather than standard service-layer services for bulk imports, as they are optimized for speed and omit unnecessary checks
- **Rebuild search index** after import completion to ensure newly added products appear in search results

**Examples:**

Example 1 (csv):
```csv
name            , slug            , description               , assets                      , facets                              , optionGroups    , optionValues , sku         , price   , taxCategory , stockOnHand , trackInventory , variantAssets , variantFacetsLaptop          , laptop          , "Description of laptop"   , laptop_01.jpg|laptop_02.jpg , category:electronics|brand:Apple    , screen size|RAM , 13 inch|8GB  , L2201308    , 1299.00 , standard    , 100         , false          ,               ,                 ,                 ,                           ,                        
...
```

Example 2 (csv):
```csv
... ,product:featuredReview... ,"{ ""id"": 123 }"
```

Example 3 (csv):
```csv
... ,product:keywords... ,tablet|pad|android
```

Example 4 (ts):
```ts
import { InitialData, LanguageCode } from '@vendure/core';export const initialData: InitialData = {    paymentMethods: [        {            name: 'Standard Payment',            handler: {                code: 'dummy-payment-handler',                arguments: [{ name: 'automaticSettle', value: 'false' }],            },        },    ],    roles: [        {            code: 'administrator',            description: 'Administrator',            permissions: [                Permission.CreateCatalog,                Permission.ReadCatalog,                Permission.UpdateCatalog,                Perm
...
```

---

## Events

**URL:** https://docs.vendure.io/guides/developer-guide/events/

**Contents:**
- Events
- Event types​
- Subscribing to events​
  - Subscribing to multiple event types​
- Publishing events​
- Creating custom events​
  - Entity events​
- Blocking event handlers​
  - Performance considerations​
  - Order of execution​

Vendure emits events which can be subscribed to by plugins. These events are published by the EventBus and likewise the EventBus is used to subscribe to events.

An event exists for virtually all significant actions which occur in the system, such as:

A full list of the available events follows.

To subscribe to an event, use the EventBus's .ofType() method. It is typical to set up subscriptions in the onModuleInit() or onApplicationBootstrap() lifecycle hooks of a plugin or service (see NestJS Lifecycle events).

Here's an example where we subscribe to the ProductEvent and use it to trigger a rebuild of a static storefront:

The EventBus.ofType() and related EventBus.filter() methods return an RxJS Observable. This means that you can use any of the RxJS operators to transform the stream of events.

For example, to debounce the stream of events, you could do this:

Using the .ofType() method allows us to subscribe to a single event type. If we want to subscribe to multiple event types, we can use the .filter() method instead:

You can publish events using the EventBus.publish() method. This is useful if you want to trigger an event from within a plugin or service.

For example, to publish a ProductEvent:

You can create your own custom events by extending the VendureEvent class. For example, to create a custom event which is triggered when a customer submits a review, you could do this:

The event would then be published from your plugin's ProductReviewService:

There is a special event class VendureEntityEvent for events relating to the creation, update or deletion of entities. Let's say you have a custom entity (see defining a database entity) BlogPost and you want to trigger an event whenever a new BlogPost is created, updated or deleted:

Using this event, you can subscribe to all BlogPost events, and for instance filter for only the created events:

The following section is an advanced topic.

The API described in this section was added in Vendure v2.2.0.

When using the .ofType().subscribe() pattern, the event handler is non-blocking. This means that the code that publishes the event (the "publishing code") will have no knowledge of any subscribers, and in fact any subscribers will be executed after the code that published the event has completed (technically, any ongoing database transactions are completed before the event gets emitted to the subscribers). This follows the typical Observer pattern and is a good fit for most use-cases.

However, there are some scenarios where you may want the event handler to execute **during** the publishing code, rather than after it has completed. This is where **blocking event handlers** come in.

Blocking event handlers differ from regular event subscribers in several critical ways:

| Aspect | Event Subscribers | Blocking Handlers |
|--------|-------------------|-------------------|
| **Execution** | Executed _after_ publishing code completes | Execute _during_ the publishing code |
| **Error Handling** | Errors do not affect publishing code | Errors propagated to publishing code |
| **Transactions** | Guaranteed to execute only after the publishing code transaction has completed | Executed within the transaction of the publishing code |
| **Performance Impact** | Non-blocking; subscriber performance irrelevant | Blocking; handler speed directly affects publishing code |

**When to use blocking handlers:**

1. Critical operations requiring completion before publishing code continues
2. Financial record manipulation where handler errors must rollback transactions
3. Protection against server shutdowns before event subscribers execute

**Implementation Example:**

```typescript
import { Injectable, OnModuleInit } from '@nestjs/common';
import {
  EventBus,
  PluginCommonModule,
  VendurePlugin,
  CustomerEvent
} from '@vendure/core';
import { CustomerSyncService } from './services/customer-sync.service';

@VendurePlugin({
    imports: [PluginCommonModule],
})
export class MyPluginPlugin implements OnModuleInit {
    constructor(
        private eventBus: EventBus,
        private customerSyncService: CustomerSyncService,
    ) {}

    onModuleInit() {
        this.eventBus.registerBlockingEventHandler({
            event: CustomerEvent,
            id: 'sync-customer-details-handler',
            handler: async event => {
                await this.customerSyncService.triggerCustomerSyncJob(event);
            },
        });
    }
}
```

**Performance Considerations:**

Blocking handlers must execute quickly. The system logs warnings for handlers exceeding 100ms execution time. Optimize by keeping operations minimal—ideally just queuing jobs rather than processing data directly.

**Order of Execution:**

When multiple handlers are registered, execution follows registration order. Use `before` or `after` options to enforce specific sequences:

```typescript
this.eventBus.registerBlockingEventHandler({
    type: CustomerEvent,
    id: 'check-customer-details-handler',
    handler: async event => {
        // Implementation
    },
    before: 'sync-customer-details-handler',
});
```

This ensures the checking handler executes before the sync handler.

**Examples:**

Example 1 (ts):
```ts
import { OnModuleInit } from '@nestjs/common';import { EventBus, ProductEvent, PluginCommonModule, VendurePlugin } from '@vendure/core';import { StorefrontBuildService } from './services/storefront-build.service';@VendurePlugin({    imports: [PluginCommonModule],})export class StorefrontBuildPlugin implements OnModuleInit {    constructor(        private eventBus: EventBus,        private storefrontBuildService: StorefrontBuildService,    ) {}    onModuleInit() {        this.eventBus.ofType(ProductEvent).subscribe(event => {            this.storefrontBuildService.triggerBuild();        });    
...
```

Example 2 (ts):
```ts
import { debounceTime } from 'rxjs/operators';// ...this.eventBus    .ofType(ProductEvent)    .pipe(debounceTime(1000))    .subscribe(event => {        this.storefrontBuildService.triggerBuild();    });
```

Example 3 (ts):
```ts
import { Injectable, OnModuleInit } from '@nestjs/common';import {    EventBus,    PluginCommonModule,    VendurePlugin,    ProductEvent,    ProductVariantEvent,} from '@vendure/core';@VendurePlugin({    imports: [PluginCommonModule],})export class MyPluginPlugin implements OnModuleInit {    constructor(private eventBus: EventBus) {}    onModuleInit() {        this.eventBus            .filter(event => event instanceof ProductEvent || event instanceof ProductVariantEvent)            .subscribe(event => {                // the event will be a ProductEvent or ProductVariantEvent            });   
...
```

Example 4 (ts):
```ts
import { Injectable } from '@nestjs/common';import { EventBus, ProductEvent, RequestContext, Product } from '@vendure/core';@Injectable()export class MyPluginService {    constructor(private eventBus: EventBus) {}    async doSomethingWithProduct(ctx: RequestContext, product: Product) {        // ... do something        await this.eventBus.publish(new ProductEvent(ctx, product, 'updated'));    }}
```

---
