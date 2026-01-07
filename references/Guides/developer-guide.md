# Vendure Overview


Read this page to gain a high-level understanding of Vendure and concepts you will need to know to build your application.

## Architecture​


[​](#architecture)Vendure is a headless e-commerce platform. By "headless" we mean that it exposes all of its functionality via APIs. Specifically, Vendure features two GraphQL APIs: one for storefronts (Shop API) and the other for administrative functions (Admin API).

These are the major parts of a Vendure application:

- Server: The Vendure server is the part that handles requests coming in to the GraphQL APIs. It serves both the Shop API and Admin API, and can send jobs to the Job Queue to be processed by the Worker.
- Worker: The Worker runs in the background and deals with tasks such as updating the search index, sending emails, and other tasks which may be long-running, resource-intensive or require retries.
- Dashboard: The Dashboard is how shop administrators manage orders, customers, products, settings and so on. The Dashboard can be further extended to support custom functionality, as detailed in the Extending the Dashboard section
- Storefront: With headless commerce, you are free to implement your storefront exactly as you see fit, unconstrained by the back-end, using any technologies that you like. To make this process easier, we have created a number of storefront starter kits, as well as guides on building a storefront.

[Shop API](/reference/graphql-api/shop/queries)[Admin API](/reference/graphql-api/admin/queries)[Extending the Dashboard](/guides/extending-the-dashboard/extending-overview/)[storefront starter kits](/guides/storefront/storefront-starters/)[guides on building a storefront](/guides/storefront/connect-api/)
## Technology stack​


[​](#technology-stack)Vendure is built on the following open-source technologies:

- SQL Database: Vendure requires an SQL database compatible with TypeORM. Officially we support PostgreSQL, MySQL/MariaDB and SQLite but Vendure can also be used with API-compatible variants such Amazon Aurora, CockroachDB, or PlanetScale.
- TypeScript & Node.js: Vendure is written in TypeScript and runs on Node.js.
- NestJS: The underlying framework is NestJS, which is a full-featured application development framework for Node.js. Building on NestJS means that Vendure benefits from the well-defined structure and rich feature-set and ecosystem that NestJS provides.
- GraphQL: The Shop and Admin APIs use GraphQL, which is a modern API technology which allows you to specify the exact data that your client application needs in a convenient and type-safe way. Internally we use Apollo Server to power our GraphQL APIs.
- React: The Dashboard is built with React, as well as other popular front-end technologies such as TailwindCSS.

[TypeORM](https://typeorm.io/)[Amazon Aurora](https://aws.amazon.com/rds/aurora/)[CockroachDB](https://www.cockroachlabs.com/)[PlanetScale](https://planetscale.com/)[TypeScript](https://www.typescriptlang.org/)[Node.js](https://nodejs.org)[NestJS](https://nestjs.com/)[GraphQL](https://graphql.org/)[Apollo Server](https://www.apollographql.com/docs/apollo-server/)[React](https://react.dev/)
## Design principles​


[​](#design-principles)Vendure is designed to be:

- Flexible: Vendure is designed to be flexible enough to support a wide range of e-commerce use-cases, while taking care of the common functionality for you. It is not a "one-size-fits-all" solution, but rather a framework which you can extend and customize to suit your needs.
- Extensible: A typical e-commerce application needs to integrate with many external systems for payments, shipping, inventory management, email sending, and so on. Vendure makes heavy use of the strategy pattern - a software design pattern which allows you to replace default behaviors with your own custom implementations as needed.
- Modular: Vendure is built with a modular architecture, where each unit of functionality of your application is encapsulated in a plugin. This makes it easy to add or remove functionality as needed, and to share plugins with the community.
- Type-safe: Vendure is written in TypeScript, which means that you get the benefits of static type-checking and code completion in your IDE. Our use of GraphQL for our APIs brings static typing to the API layer, enabling rapid development with type-safety across the entire stack.


---

# The API Layer


Vendure is a headless platform, which means that all functionality is exposed via GraphQL APIs. The API can be thought of
as a number of layers through which a request will pass, each of which is responsible for a different aspect of the
request/response lifecycle.

## The journey of an API call​


[​](#the-journey-of-an-api-call)Let's take a basic API call and trace its journey from the client to the server and back again.

- Request
- Response

```
query {    product(id: "1") {        id        name        description    }}
```

This query is asking for the id, name and description of a Product with the id of 1.

```
{  "data": {    "product": {      "id": "1",      "name": "Laptop",      "description": "Now equipped with seventh-generation Intel Core processors, Laptop is snappier than ever. From daily tasks like launching apps and opening files to more advanced computing, you can power through your day thanks to faster SSDs and Turbo Boost processing up to 3.6GHz."    }  }}
```

GraphQL returns only the specific fields you ask for in your query.

If you have your local development server running, you can try this out by opening the GraphQL Playground in your browser:

http://localhost:3000/shop-api

[http://localhost:3000/shop-api](http://localhost:3000/shop-api)
## Middleware​


[​](#middleware)"Middleware" is a term for a function which is executed before or after the main logic of a request. In Vendure, middleware
is used to perform tasks such as authentication, logging, and error handling. There are several types of middleware:

### Express middleware​


[​](#express-middleware)At the lowest level, Vendure makes use of the popular Express server library. Express middleware
can be added to the sever via the apiOptions.middleware config property. There are hundreds of tried-and-tested Express
middleware packages available, and they can be used to add functionality such as CORS, compression, rate-limiting, etc.

[Express middleware](https://expressjs.com/en/guide/using-middleware.html)[apiOptions.middleware](/reference/typescript-api/configuration/api-options#middleware)Here's a simple example demonstrating Express middleware which will log a message whenever a request is received to the
Admin API:

```
import { VendureConfig } from '@vendure/core';import { RequestHandler } from 'express';/*** This is a custom middleware function that logs a message whenever a request is received.*/const myMiddleware: RequestHandler = (req, res, next) => {    console.log('Request received!');    next();};export const config: VendureConfig = {    // ...    apiOptions: {        middleware: [            {                // We will execute our custom handler only for requests to the Admin API                route: 'admin-api',                handler: myMiddleware,            }        ],    },};
```

### NestJS middleware​


[​](#nestjs-middleware)You can also define NestJS middleware which works like Express middleware but also
has access to the NestJS dependency injection system.

[NestJS middleware](https://docs.nestjs.com/middleware)
```
import { VendureConfig, ConfigService } from '@vendure/core';import { Injectable, NestMiddleware } from '@nestjs/common';import { Request, Response, NextFunction } from 'express';@Injectable()class MyNestMiddleware implements NestMiddleware {    // Dependencies can be injected via the constructor    constructor(private configService: ConfigService) {}    use(req: Request, res: Response, next: NextFunction) {        console.log(`NestJS middleware: current port is ${this.configService.apiOptions.port}`);        next();    }}export const config: VendureConfig = {    // ...    apiOptions: {        middleware: [            {                route: 'admin-api',                handler: MyNestMiddleware,            }        ],    },};
```

NestJS allows you to define specific types of middleware including Guards,
Interceptors, Pipes and Filters.

[Guards](https://docs.nestjs.com/guards)[Interceptors](https://docs.nestjs.com/interceptors)[Pipes](https://docs.nestjs.com/pipes)[Filters](https://docs.nestjs.com/exception-filters)Vendure uses a number of these mechanisms internally to handle authentication, transaction management, error handling and
data transformation.

### Global NestJS middleware​


[​](#global-nestjs-middleware)Guards, interceptors, pipes and filters can be added to your own custom resolvers and controllers
using the NestJS decorators as given in the NestJS docs. However, a common pattern is to register them globally via a
Vendure plugin:

[Vendure plugin](/guides/developer-guide/plugins/)
```
import { VendurePlugin } from '@vendure/core';import { APP_GUARD, APP_FILTER, APP_INTERCEPTOR  } from '@nestjs/core';// Some custom NestJS middleware classes which we want to apply globallyimport { MyCustomGuard, MyCustomInterceptor, MyCustomExceptionFilter } from './my-custom-middleware';@VendurePlugin({    // ...    providers: [        // This is the syntax needed to apply your guards,        // interceptors and filters globally        {            provide: APP_GUARD,            useClass: MyCustomGuard,        },        {            provide: APP_INTERCEPTOR,            useClass: MyCustomInterceptor,        },        {            // Note: registering a global "catch all" exception filter            // must be used with caution as it will override the built-in            // Vendure exception filter. See https://github.com/nestjs/nest/issues/3252            // To implement custom error handling, it is recommended to use            // a custom ErrorHandlerStrategy instead.            provide: APP_FILTER,            useClass: MyCustomExceptionFilter,        },    ],})export class MyPlugin {}
```

Adding this plugin to your Vendure config plugins array will now apply these middleware classes to all requests.

```
import { VendureConfig } from '@vendure/core';import { MyPlugin } from './plugins/my-plugin/my-plugin';export const config: VendureConfig = {    // ...    plugins: [        MyPlugin,    ],};
```

### Apollo Server plugins​


[​](#apollo-server-plugins)Apollo Server (the underlying GraphQL server library used by Vendure) allows you to define
plugins which can be used to hook into various
stages of the GraphQL request lifecycle and perform tasks such as data transformation. These are defined via the
apiOptions.apolloServerPlugins config property.

[plugins](https://www.apollographql.com/docs/apollo-server/integrations/plugins/)[apiOptions.apolloServerPlugins](/reference/typescript-api/configuration/api-options#apolloserverplugins)
## Resolvers​


[​](#resolvers)A "resolver" is a GraphQL concept, and refers to a function which is responsible for returning the data for a particular
field. In Vendure, a resolver can also refer to a class which contains multiple resolver functions. For every query or
mutation, there is a corresponding resolver function which is responsible for returning the requested data (and performing
side-effect such as updating data in the case of mutations).

Here's a simplified example of a resolver function for the product query:

```
import { Query, Resolver, Args } from '@nestjs/graphql';import { Ctx, RequestContext, ProductService } from '@vendure/core';@Resolver()export class ShopProductsResolver {     constructor(private productService: ProductService) {}     @Query()     product(@Ctx() ctx: RequestContext, @Args() args: { id: string }) {         return this.productService.findOne(ctx, args.id);     }}
```

- The @Resolver() decorator marks this class as a resolver.
- The @Query() decorator marks the product() method as a resolver function.
- The @Ctx() decorator injects the RequestContext object, which contains information about the
current request, such as the current user, the active channel, the active language, etc. The RequestContext is a key part
of the Vendure architecture, and is used throughout the application to provide context to the various services and plugins. In general, your
resolver functions should always accept a RequestContext as the first argument, and pass it through to the services.
- The @Args() decorator injects the arguments passed to the query, in this case the id that we provided in our query.

[RequestContext object](/reference/typescript-api/request/request-context/)As you can see, the resolver function is very simple, and simply delegates the work to the ProductService which is
responsible for fetching the data from the database.

In general, resolver functions should be kept as simple as possible,
and the bulk of the business logic should be delegated to the service layer.

## API Decorators​


[​](#api-decorators)Following the pattern of NestJS, Vendure makes use of decorators to control various aspects of the API. Here are the
important decorators to be aware of:

### @Resolver()​


[​](#resolver)This is exported by the @nestjs/graphql package. It marks a class as a resolver, meaning that its methods can be used
to resolve the fields of a GraphQL query or mutation.

```
import { Resolver } from '@nestjs/graphql';@Resolver()export class WishlistResolver {    // ...}
```

### @Query()​


[​](#query)This is exported by the @nestjs/graphql package. It marks a method as a resolver function for a query. The method name
should match the name of the query in the GraphQL schema, or if the method name is different, a name can be provided as
an argument to the decorator.

```
import { Query, Resolver } from '@nestjs/graphql';@Resolver()export class WishlistResolver {    @Query()    wishlist() {        // ...    }}
```

### @Mutation()​


[​](#mutation)This is exported by the @nestjs/graphql package. It marks a method as a resolver function for a mutation. The method name
should match the name of the mutation in the GraphQL schema, or if the method name is different, a name can be provided as
an argument to the decorator.

```
import { Mutation, Resolver } from '@nestjs/graphql';@Resolver()export class WishlistResolver {    @Mutation()    addItemToWishlist() {        // ...    }}
```

### @Allow()​


[​](#allow)The Allow decorator is exported by the @vendure/core package. It is used to control access to queries and mutations. It takes a list
of Permissions and if the current user does not have at least one of the
permissions, then the query or mutation will return an error.

[Allow decorator](/reference/typescript-api/request/allow-decorator)[Permissions](/reference/typescript-api/common/permission/)
```
import { Mutation, Resolver } from '@nestjs/graphql';import { Allow, Permission } from '@vendure/core';@Resolver()export class WishlistResolver {    @Mutation()    @Allow(Permission.UpdateCustomer)    updateCustomerWishlist() {        // ...    }}
```

### @Transaction()​


[​](#transaction)The Transaction decorator is exported by the @vendure/core package. It is used to wrap a resolver function in a database transaction. It is
normally used with mutations, since queries typically do not modify data.

[Transaction decorator](/reference/typescript-api/request/transaction-decorator/)
```
import { Mutation, Resolver } from '@nestjs/graphql';import { Transaction } from '@vendure/core';@Resolver()export class WishlistResolver {    @Transaction()    @Mutation()    addItemToWishlist() {        // if an error is thrown here, the        // entire transaction will be rolled back    }}
```

The @Transaction() decorator only works when used with a RequestContext object (see the @Ctx() decorator below).

This is because the Transaction decorator stores the transaction context on the RequestContext object, and by passing
this object to the service layer, the services and thus database calls can access the transaction context.

### @Ctx()​


[​](#ctx)The Ctx decorator is exported by the @vendure/core package. It is used to inject the
RequestContext object into a resolver function. The RequestContext contains information about the
current request, such as the current user, the active channel, the active language, etc. The RequestContext is a key part
of the Vendure architecture, and is used throughout the application to provide context to the various services and plugins.

[Ctx decorator](/reference/typescript-api/request/ctx-decorator/)[RequestContext object](/reference/typescript-api/request/request-context/)
```
import { Mutation, Resolver } from '@nestjs/graphql';import { Ctx, RequestContext } from '@vendure/core';@Resolver()export class WishlistResolver {    @Mutation()    addItemToWishlist(@Ctx() ctx: RequestContext) {        // ...    }}
```

As a general rule, always use the @Ctx() decorator to inject the RequestContext into your resolver functions.

### @Args()​


[​](#args)This is exported by the @nestjs/graphql package. It is used to inject the arguments passed to a query or mutation.

Given a schema definition like this:

```
extend type Mutation {    addItemToWishlist(variantId: ID!): Wishlist}
```

The resolver function would look like this:

```
import { Mutation, Resolver, Args } from '@nestjs/graphql';import { Ctx, RequestContext, ID } from '@vendure/core';@Resolver()export class WishlistResolver {    @Mutation()    addItemToWishlist(        @Ctx() ctx: RequestContext,        @Args() args: { variantId: ID }    ) {        // ...    }}
```

As you can see, the @Args() decorator injects the arguments passed to the query, in this case the variantId that we provided in our query.

## Field resolvers​


[​](#field-resolvers)So far, we've seen examples of resolvers for queries and mutations. However, there is another type of resolver which is
used to resolve the fields of a type. For example, given the following schema definition:

```
type WishlistItem {    id: ID!    product: Product!}
```

The product field is a relation to the Product type. The product field resolver
would look like this:

```
import { Parent, ResolveField, Resolver } from '@nestjs/graphql';import { Ctx, RequestContext } from '@vendure/core';import { WishlistItem } from '../entities/wishlist-item.entity';@Resolver('WishlistItem')export class WishlistItemResolver {    @ResolveField()    product(        @Ctx() ctx: RequestContext,        @Parent() wishlistItem: WishlistItem    ) {        // ...    }}
```

Note that in this example, the @Resolver() decorator has an argument of 'WishlistItem'. This tells NestJS that
this resolver is for the WishlistItem type, and that when we use the @ResolveField() decorator, we are defining
a resolver for a field of that type.

In this example we're defining a resolver for the product field of the WishlistItem type. The
@ResolveField() decorator is used to mark a method as a field resolver. The method name should match the name of the
field in the GraphQL schema, or if the method name is different, a name can be provided as an argument to the decorator.

## REST endpoints​


[​](#rest-endpoints)Although Vendure is primarily a GraphQL-based API, it is possible to add REST endpoints to the API. This is useful if
you need to integrate with a third-party service or client application which only supports REST, for example.

Creating a REST endpoint is covered in detail in the Add a REST endpoint
guide.

[Add a REST endpoint
guide](/guides/developer-guide/rest-endpoint/)


---

# The Service Layer


The service layer is the core of the application. This is where the business logic is implemented, and where
the application interacts with the database. When a request comes in to the API, it gets routed to a resolver
which then calls a service method to perform the required operation.

Services are classes which, in NestJS terms, are providers. They
follow all the rules of NestJS providers, including dependency injection, scoping, etc.

[providers](https://docs.nestjs.com/providers#services)Services are generally scoped to a specific domain or entity. For instance, in the Vendure core, there is a Product entity,
and a corresponding ProductService which contains all the methods for interacting with products.

[Product entity](/reference/typescript-api/entities/product)[ProductService](/reference/typescript-api/services/product-service)Here's a simplified example of a ProductService, including an implementation of the findOne() method that was
used in the example in the previous section:

[previous section](/guides/developer-guide/the-api-layer/#resolvers)
```
import { Injectable } from '@nestjs/common';import { IsNull } from 'typeorm';import { ID, Product, RequestContext, TransactionalConnection, TranslatorService } from '@vendure/core';@Injectable()export class ProductService {    constructor(private connection: TransactionalConnection,                private translator: TranslatorService){}    /**     * @description     * Returns a Product with the given id, or undefined if not found.     */    async findOne(ctx: RequestContext, productId: ID): Promise<Product | undefined> {        const product = await this.connection.findOneInChannel(ctx, Product, productId, ctx.channelId, {            where: {                deletedAt: IsNull(),            },        });        if (!product) {            return;        }        return this.translator.translate(product, ctx);    }    // ... other methods    findMany() {}    create() {}    update() {}}
```

- The @Injectable() decorator is a NestJS decorator which allows the service
to be injected into other services or resolvers.
- The constructor() method is where the dependencies of the service are injected. In this case, the TransactionalConnection
is used to access the database, and the TranslatorService is used to translate the Product entity into the current
language.

[NestJS](https://docs.nestjs.com/providers#services)
## Using core services​


[​](#using-core-services)All the internal Vendure services can be used in your own plugins and scripts. They are listed in the Services API reference and
can be imported from the @vendure/core package.

[Services API reference](/reference/typescript-api/services/)To make use of a core service in your own plugin, you need to ensure your plugin is importing the PluginCommonModule and
then inject the desired service into your own service's constructor:

```
import { PluginCommonModule, VendurePlugin } from '@vendure/core';import { MyService } from './services/my.service';@VendurePlugin({    imports: [PluginCommonModule],    providers: [MyService],})export class MyPlugin {}
```

```
import { Injectable } from '@nestjs/common';import { ProductService } from '@vendure/core';@Injectable()export class MyService {    constructor(private productService: ProductService) {}    // you can now use the productService methods}
```

## Accessing the database​


[​](#accessing-the-database)One of the main responsibilities of the service layer is to interact with the database. For this, you will be using
the TransactionalConnection class, which is a wrapper
around the TypeORM DataSource object. The primary purpose of the TransactionalConnection
is to ensure that database operations can be performed within a transaction (which is essential for ensuring data integrity), even
across multiple services. Furthermore, it exposes some helper methods which make it easier to perform common operations.

[TransactionalConnection class](/reference/typescript-api/data-access/transactional-connection/)[TypeORM DataSource object](https://typeorm.io/data-source-api)Always pass the RequestContext (ctx) to the TransactionalConnection methods. This ensures the operation occurs within
any active transaction.

There are two primary APIs for accessing data provided by TypeORM: the Find API and the QueryBuilder API.

### The Find API​


[​](#the-find-api)This API is the most convenient and type-safe way to query the database. It provides a powerful type-safe way to query
including support for eager relations, pagination, sorting, filtering and more.

Here are some examples of using the Find API:

```
import { Injectable } from '@nestjs/common';import { ID, RequestContext, TransactionalConnection } from '@vendure/core';import { IsNull } from 'typeorm';import { Item } from '../entities/item.entity';@Injectable()export class ItemService {    constructor(private connection: TransactionalConnection) {}    findById(ctx: RequestContext, itemId: ID): Promise<Item | null> {        return this.connection.getRepository(ctx, Item).findOne({            where: { id: itemId },        });    }    findByName(ctx: RequestContext, name: string): Promise<Item | null> {        return this.connection.getRepository(ctx, Item).findOne({            where: {                // Multiple where clauses can be specified,                // which are joined with AND                name,                deletedAt: IsNull(),            },        });    }    findWithRelations() {        return this.connection.getRepository(ctx, Item).findOne({            where: { name },            relations: {                // Join the `item.customer` relation                customer: true,                product: {                    // Here we are joining a nested relation `item.product.featuredAsset`                    featuredAsset: true,                },            },        });    }    findMany(ctx: RequestContext): Promise<Item[]> {        return this.connection.getRepository(ctx, Item).find({            // Pagination            skip: 0,            take: 10,            // Sorting            order: {                name: 'ASC',            },        });    }}
```

Further examples can be found in the TypeORM Find Options documentation.

[TypeORM Find Options documentation](https://typeorm.io/find-options)
### The QueryBuilder API​


[​](#the-querybuilder-api)When the Find API is not sufficient, the QueryBuilder API can be used to construct more complex queries. For instance,
if you want to have a more complex WHERE clause than what can be achieved with the Find API, or if you want to perform
sub-queries, then the QueryBuilder API is the way to go.

Here are some examples of using the QueryBuilder API:

```
import { Injectable } from '@nestjs/common';import { ID, RequestContext, TransactionalConnection } from '@vendure/core';import { Brackets, IsNull } from 'typeorm';import { Item } from '../entities/item.entity';@Injectable()export class ItemService {    constructor(private connection: TransactionalConnection) {}    findById(ctx: RequestContext, itemId: ID): Promise<Item | null> {        // This is simple enough that you should prefer the Find API,        // but here is how it would be done with the QueryBuilder API:        return this.connection.getRepository(ctx, Item).createQueryBuilder('item')            .where('item.id = :id', { id: itemId })            .getOne();    }    findManyWithSubquery(ctx: RequestContext, name: string) {        // Here's a more complex query that would not be possible using the Find API:        return this.connection.getRepository(ctx, Item).createQueryBuilder('item')            .where('item.name = :name', { name })            .andWhere(                new Brackets(qb1 => {                    qb1.where('item.state = :state1', { state1: 'PENDING' })                       .orWhere('item.state = :state2', { state2: 'RETRYING' });                }),            )            .orderBy('item.createdAt', 'ASC')            .getMany();    }}
```

Further examples can be found in the TypeORM QueryBuilder documentation.

[TypeORM QueryBuilder documentation](https://typeorm.io/select-query-builder)
### Working with relations​


[​](#working-with-relations)One limitation of TypeORM's typings is that we have no way of knowing at build-time whether a particular relation will be
joined at runtime. For instance, the following code will build without issues, but will result in a runtime error:

```
const product = await this.connection.getRepository(ctx, Product).findOne({    where: { id: productId },});if (product) {    console.log(product.featuredAsset.preview);    // ^ Error: Cannot read property 'preview' of undefined}
```

This is because the featuredAsset relation is not joined by default. The simple fix for the above example is to use
the relations option:

```
const product = await this.connection.getRepository(ctx, Product).findOne({    where: { id: productId },    relations: { featuredAsset: true },});
```

or in the case of the QueryBuilder API, we can use the leftJoinAndSelect() method:

```
const product = await this.connection.getRepository(ctx, Product).createQueryBuilder('product')    .leftJoinAndSelect('product.featuredAsset', 'featuredAsset')    .where('product.id = :id', { id: productId })    .getOne();
```

### Using the EntityHydrator​


[​](#using-the-entityhydrator)But what about when we do not control the code which fetches the entity from the database? For instance, we might be implementing
a function which gets an entity passed to it by Vendure. In this case, we can use the EntityHydrator
to ensure that a given relation is "hydrated" (i.e. joined) before we use it:

[EntityHydrator](/reference/typescript-api/data-access/entity-hydrator/)
```
import { EntityHydrator, ShippingCalculator } from '@vendure/core';let entityHydrator: EntityHydrator;const myShippingCalculator = new ShippingCalculator({    // ... rest of config omitted for brevity    init(injector) {        entityHydrator = injector.get(EntityHydrator);    },    calculate: (ctx, order, args) => {      // ensure that the customer and customer.groups relations are joined      await entityHydrator.hydrate(ctx, order, { relations: ['customer.groups' ]});      if (order.customer?.groups?.some(g => g.name === 'VIP')) {        // ... do something special for VIP customers      } else {        // ... do something else      }    },});
```

### Joining relations in built-in service methods​


[​](#joining-relations-in-built-in-service-methods)Many of the core services allow an optional relations argument in their findOne() and findMany() and related methods.
This allows you to specify which relations should be joined when the query is executed. For instance, in the ProductService
there is a findOne() method which allows you to specify which relations should be joined:

[ProductService](/reference/typescript-api/services/product-service)
```
const productWithAssets = await this.productService    .findOne(ctx, productId, ['featuredAsset', 'assets']);
```


---

# CLI


The Vendure CLI is a command-line tool for boosting your productivity as a developer by automating common tasks
such as creating new plugins, entities, API extensions and more.

It is much more than just a scaffolding tool - it is able to analyze your project and intelligently modify your existing
codebase to integrate new functionality.

## Installation​


[​](#installation)The Vendure CLI comes installed with a new Vendure project by default from v2.2.0+

To manually install the CLI, run:

- npm
- yarn

```
npm install -D @vendure/cli
```

```
yarn add -D @vendure/cli
```

## Interactive vs Non-Interactive Mode​


[​](#interactive-vs-non-interactive-mode)The Vendure CLI supports both interactive and non-interactive modes:

- Interactive mode: Provides guided prompts and menus for easy use during development
- Non-interactive mode: Allows direct command execution with arguments and options, perfect for automation, CI/CD, and AI agents

## The Add Command​


[​](#the-add-command)The add command is used to add new entities, resolvers, services, plugins, and more to your Vendure project.

### Interactive Mode​


[​](#interactive-mode)From your project's root directory, run:

- npm
- yarn

```
npx vendure add
```

```
yarn vendure add
```

The CLI will guide you through the process of adding new functionality to your project.

The add command is much more than a simple file generator. It is able to
analyze your project source code to deeply understand and correctly update your project files.

### Non-Interactive Mode​


[​](#non-interactive-mode)For automation or when you know exactly what you need to add, you can use the non-interactive mode with specific arguments and options:

- npm
- yarn

```
# Create a new pluginnpx vendure add -p MyPlugin# Add an entity to a pluginnpx vendure add -e MyEntity --selected-plugin MyPlugin# Add an entity with featuresnpx vendure add -e MyEntity --selected-plugin MyPlugin --custom-fields --translatable# Add a service to a pluginnpx vendure add -s MyService --selected-plugin MyPlugin# Add a service with specific typenpx vendure add -s MyService --selected-plugin MyPlugin --type entity# Add job queue support to a pluginnpx vendure add -j MyPlugin --name my-job --selected-service MyService# Add GraphQL codegen to a pluginnpx vendure add -c MyPlugin# Add API extension to a pluginnpx vendure add -a MyPlugin --queryName getCustomData --mutationName updateCustomData# Add UI extensions to a pluginnpx vendure add -u MyPlugin# Use custom config filenpx vendure add -p MyPlugin --config ./custom-vendure.config.ts

```

```
# Create a new pluginyarn vendure add -p MyPlugin# Add an entity to a pluginyarn vendure add -e MyEntity --selected-plugin MyPlugin# Add an entity with featuresyarn vendure add -e MyEntity --selected-plugin MyPlugin --custom-fields --translatable# Add a service to a pluginyarn vendure add -s MyService --selected-plugin MyPlugin# Add a service with specific typeyarn vendure add -s MyService --selected-plugin MyPlugin --type entity# Add job queue support to a pluginyarn vendure add -j MyPlugin --name my-job --selected-service MyService# Add GraphQL codegen to a pluginyarn vendure add -c MyPlugin# Add API extension to a pluginyarn vendure add -a MyPlugin --queryName getCustomData --mutationName updateCustomData# Add UI extensions to a pluginyarn vendure add -u MyPlugin# Use custom config fileyarn vendure add -p MyPlugin --config ./custom-vendure.config.ts

```

#### Add Command Options​


[​](#add-command-options)
#### Sub-options for specific commands​


[​](#sub-options-for-specific-commands)Entity (-e) additional options:

- --selected-plugin <n>: Name of the plugin to add the entity to (required)
- --custom-fields: Add custom fields support to the entity
- --translatable: Make the entity translatable

Service (-s) additional options:

- --selected-plugin <n>: Name of the plugin to add the service to (required)
- --type <type>: Type of service: basic or entity (default: basic)

Job Queue (-j) additional options:

- --name <name>: Name for the job queue (required)
- --selected-service <name>: Service to add the job queue to (required)

API Extension (-a) additional options: (requires either)

- --queryName <n>: Name for the GraphQL query
- --mutationName <n>: Name for the GraphQL mutation

Validation: Entity and service commands validate that the specified plugin exists in your project. If the plugin is not found, the command will list all available plugins in the error message. Both commands require the --selected-plugin parameter when running in non-interactive mode.

## The Migrate Command​


[​](#the-migrate-command)The migrate command is used to generate and manage database migrations for your Vendure project.

[database migrations](/guides/developer-guide/migrations)
### Interactive Mode​


[​](#interactive-mode-1)From your project's root directory, run:

- npm
- yarn

```
npx vendure migrate
```

```
yarn vendure migrate
```

### Non-Interactive Mode​


[​](#non-interactive-mode-1)For migration operations, use specific arguments and options:

- npm
- yarn

```
# Generate a new migrationnpx vendure migrate -g my-migration-name# Run pending migrationsnpx vendure migrate -r# Revert the last migrationnpx vendure migrate --revert# Generate migration with custom output directorynpx vendure migrate -g my-migration -o ./custom/migrations

```

```
# Generate a new migrationyarn vendure migrate -g my-migration-name# Run pending migrationsyarn vendure migrate -r# Revert the last migrationyarn vendure migrate --revert# Generate migration with custom output directoryyarn vendure migrate -g my-migration -o ./custom/migrations

```

#### Migrate Command Options​


[​](#migrate-command-options)
## The Schema Command​


[​](#the-schema-command)The schema command was added in Vendure v3.5

The schema command allows you to generate a schema file for your Admin or Shop APIs, in either the GraphQL schema definition language (SDL)
or as JSON.

This is useful when integrating with GraphQL tooling such as your IDE's GraphQL plugin.

[IDE's GraphQL plugin](/guides/getting-started/graphql-intro/#ide-plugins)
### Interactive Mode​


[​](#interactive-mode-2)From your project's root directory, run:

- npm
- yarn

```
npx vendure schema
```

```
yarn vendure schema
```

### Non-Interactive Mode​


[​](#non-interactive-mode-2)To automate or quickly generate a schema in one command

- npm
- yarn

```
# Create a schema file in SDL format for the Admin APInpx vendure schema --api admin# Create a JSON format schema of the Shop APInpx vendure migrate --api shop --format json

```

```
# Create a schema file in SDL format for the Admin APIyarn vendure schema --api admin# Create a JSON format schema of the Shop APIyarn vendure migrate --api shop --format json

```

#### Migrate Command Options​


[​](#migrate-command-options-1)
## Getting Help​


[​](#getting-help)To see all available commands and options:

```
npx vendure --helpnpx vendure add --helpnpx vendure migrate --helpnpx vendure schema --help
```


---

# Configuration


Every aspect of the Vendure server is configured via a single, central VendureConfig object. This object is passed into the bootstrap and bootstrapWorker functions to start up the Vendure server and worker respectively.

[VendureConfig](/reference/typescript-api/configuration/vendure-config/)[bootstrap](/reference/typescript-api/common/bootstrap/)[bootstrapWorker](/reference/typescript-api/worker/bootstrap-worker/)The VendureConfig object is organised into sections, grouping related settings together. For example, VendureConfig.apiOptions contains all the config for the GraphQL APIs, whereas VendureConfig.authOptions deals with authentication.

[VendureConfig.apiOptions](/reference/typescript-api/configuration/api-options/)[VendureConfig.authOptions](/reference/typescript-api/auth/auth-options/)
## Important Configuration Settings​


[​](#important-configuration-settings)In this guide, we will take a look at those configuration options needed for getting the server up and running.

A description of every available configuration option can be found in the VendureConfig reference docs.

[VendureConfig reference docs](/reference/typescript-api/configuration/vendure-config/)
### Specifying API hostname & port etc​


[​](#specifying-api-hostname--port-etc)The VendureConfig.apiOptions object is used to set the hostname, port, as well as other API-related concerns. Express middleware and Apollo Server plugins may also be specified here.

[VendureConfig.apiOptions](/reference/typescript-api/configuration/api-options/)Example:

```
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {  apiOptions: {    hostname: 'localhost',    port: 3000,    adminApiPath: '/admin',    shopApiPath: '/shop',    middleware: [{      // add some Express middleware to the Shop API route      handler: timeout('5s'),      route: 'shop',    }]  },  // ...}
```

### Connecting to the database​


[​](#connecting-to-the-database)The database connection is configured with the VendureConfig.dbConnectionOptions object. This object is actually the TypeORM DataSourceOptions object and is passed directly to TypeORM.

[TypeORM DataSourceOptions object](https://typeorm.io/data-source-options)Example:

```
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {  dbConnectionOptions: {    type: 'postgres',    host: process.env.DB_HOST,    port: process.env.DB_PORT,    synchronize: false,    username: process.env.DB_USERNAME,    password: process.env.DB_PASSWORD,    database: 'vendure',    migrations: [path.join(__dirname, 'migrations/*.ts')],  },  // ...}
```

### Configuring authentication​


[​](#configuring-authentication)Authentication settings are configured with VendureConfig.authOptions. The most important setting here is whether the storefront client will use cookies or bearer tokens to manage user sessions. For more detail on this topic, see the Managing Sessions guide.

[VendureConfig.authOptions](/reference/typescript-api/auth/auth-options/)[the Managing Sessions guide](/guides/storefront/connect-api/#managing-sessions)The username and default password of the superadmin user can also be specified here. In production, it is advisable to use environment variables for these settings (see the following section on usage of environment variables).

Example:

```
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {  authOptions: {    tokenMethod: 'cookie',    requireVerification: true,    cookieOptions: {      secret: process.env.COOKIE_SESSION_SECRET,    },    superadminCredentials: {      identifier: process.env.SUPERADMIN_USERNAME,      password: process.env.SUPERADMIN_PASSWORD,    },  },  // ...}
```

## Working with the VendureConfig object​


[​](#working-with-the-vendureconfig-object)Since the VendureConfig is just a JavaScript object, it can be managed and manipulated according to your needs. For example:

### Using environment variables​


[​](#using-environment-variables)Environment variables can be used when you don't want to hard-code certain values which may change, e.g. depending on whether running locally, in staging or in production:

```
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {  apiOptions: {    hostname: process.env.HOSTNAME,    port: process.env.PORT,  }  // ...};
```

They are also useful so that sensitive credentials do not need to be hard-coded and committed to source control:

```
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {  dbConnectionOptions: {    type: 'postgres',    username: process.env.DB_USERNAME,    password: process.env.DB_PASSWORD,    database: 'vendure',  },  // ...}
```

When you create a Vendure project with @vendure/create, it comes with the dotenv package installed, which allows you to store environment variables in a .env file in the root of your project.

[dotenv](https://www.npmjs.com/package/dotenv)To define new environment variables, you can add them to the .env file. For instance, if you are using a plugin that requires
an API key, you can

```
APP_ENV=devCOOKIE_SECRET=toh8soqdljSUPERADMIN_USERNAME=superadminSUPERADMIN_PASSWORD=superadminMY_API_KEY=12345
```

In order to tell TypeScript about the existence of this new variable, you can add it to the src/environment.d.ts file:

```
export {};// Here we declare the members of the process.env object, so that we// can use them in our application code in a type-safe manner.declare global {    namespace NodeJS {        interface ProcessEnv {            APP_ENV: string;            COOKIE_SECRET: string;            SUPERADMIN_USERNAME: string;            SUPERADMIN_PASSWORD: string;            MY_API_KEY: string;        }    }}
```

You can then use the environment variable in your config file:

```
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {  plugins: [    MyPlugin.init({      apiKey: process.env.MY_API_KEY,    }),  ],  // ...}
```

In production, the way you manage environment variables will depend on your hosting provider. Read more about this in our Production Configuration guide.

[Production Configuration guide](/guides/deployment/production-configuration/)
### Splitting config across files​


[​](#splitting-config-across-files)If the config object grows too large, you can split it across several files. For example, the plugins array in a real-world project can easily grow quite big:

```
import { AssetServerPlugin, DefaultJobQueuePlugin, VendureConfig } from '@vendure/core';import { ElasticsearchPlugin } from '@vendure/elasticsearch-plugin';import { EmailPlugin } from '@vendure/email-plugin';import { CustomPlugin } from './plugins/custom-plugin';export const plugins: VendureConfig['plugins'] = [  CustomPlugin,  AssetServerPlugin.init({      route: 'assets',      assetUploadDir: path.join(__dirname, 'assets'),      port: 5002,  }),  DefaultJobQueuePlugin,  ElasticsearchPlugin.init({      host: 'localhost',      port: 9200,  }),  EmailPlugin.init({    // ...lots of lines of config  }),];
```

```
import { VendureConfig } from '@vendure/core';import { plugins } from './vendure-config-plugins';export const config: VendureConfig = {  plugins,  // ...}
```


---

# Custom Fields


Custom fields allow you to add your own custom data properties to almost every Vendure entity. The entities which may have custom fields defined are listed in the CustomFields interface documentation.

[CustomFields interface documentation](/reference/typescript-api/custom-fields/)Some use-cases for custom fields include:

- Storing the weight, dimensions or other product-specific data on the ProductVariant entity.
- Storing additional product codes on the ProductVariant entity such as ISBN or GTIN.
- Adding a downloadable flag to the Product entity to indicate whether the product is a digital download.
- Storing an external identifier (e.g. from a payment provider) on the Customer entity.
- Adding a longitude and latitude to the StockLocation for use in selecting the closest location to a customer.

Custom fields are not solely restricted to Vendure's native entities though, it's also possible to add support for custom fields to your own custom entities. See: Supporting custom fields

[Supporting custom fields](/guides/developer-guide/database-entity/#supporting-custom-fields)
## Defining custom fields​


[​](#defining-custom-fields)Custom fields are specified in the VendureConfig:

```
const config = {    // ...    customFields: {        Product: [            { name: 'infoUrl', type: 'string' },            { name: 'downloadable', type: 'boolean' },            { name: 'shortName', type: 'localeString' },        ],        User: [            { name: 'socialLoginToken', type: 'string', unique: true },        ],    },};
```

With the example config above, the following will occur:

- The database schema will be altered, and a column will be added for each custom field. Note: changes to custom fields require a database migration. See the Migrations guide.
- The GraphQL APIs will be modified to add the custom fields to the Product and User types respectively.
- If you are using the AdminUiPlugin, the Admin UI detail pages will now contain form inputs to allow the custom field data to be added or edited, and the list view data tables will allow custom field columns to be added, sorted and filtered.

[Migrations guide](/guides/developer-guide/migrations/)[AdminUiPlugin](/reference/core-plugins/admin-ui-plugin/)The values of the custom fields can then be set and queried via the GraphQL APIs:

- Request
- Response

```
mutation {    updateProduct(input: {        id: 1        customFields: {        infoUrl: "https://some-url.com",        downloadable: true,        }        translations: [        { languageCode: en, customFields: { shortName: "foo" } }        ]        }) {        id        name        customFields {            infoUrl            downloadable            shortName        }    }}
```

```
{    "data": {        "product": {            "id": "1",            "name": "Laptop",            "customFields": {                "infoUrl": "https://some-url.com",                "downloadable": true,                "shortName": "foo"            }        }    }}
```

The custom fields will also extend the filter and sort options available to the products list query:

```
query {    products(options: {    filter: {        infoUrl: { contains: "new" },        downloadable: { eq: true }        },        sort: {            infoUrl: ASC        }        }) {        items {            id            name            customFields {                infoUrl                downloadable                shortName            }        }    }}
```

## Available custom field types​


[​](#available-custom-field-types)The following types are available for custom fields:

To see the underlying DB data type and GraphQL type used for each, see the CustomFieldType doc.

[CustomFieldType doc](/reference/typescript-api/custom-fields/custom-field-type)
#### Relations​


[​](#relations)It is possible to set up custom fields that hold references to other entities using the 'relation' type:

```
const config = {    // ...    customFields: {        Customer: [            {                name: 'avatar',                type: 'relation',                entity: Asset,            },        ],    },};
```

In this example, we set up a many-to-one relationship from Customer to Asset, allowing us to specify an avatar image for each Customer. Relation custom fields are unique in that the input and output names are not the same - the input will expect an ID and will be named '<field name>Id' or '<field name>Ids' for list types.

```
mutation {    updateCustomer(input: {        id: 1        customFields: {            avatarId: 42,        }    }) {        id        customFields {            avatar {                id                name                preview            }        }    }}
```

## Accessing custom fields in TypeScript​


[​](#accessing-custom-fields-in-typescript)As well as exposing custom fields via the GraphQL APIs, you can also access them directly in your TypeScript code. This is useful for plugins which need to access custom field data.

Given the following custom field configuration:

```
import { VendureConfig } from '@vendure/core';const config: VendureConfig = {    // ...    customFields: {        Customer: [            { name: 'externalId', type: 'string' },            { name: 'avatar', type: 'relation', entity: Asset },        ],    },};
```

the externalId will be available whenever you access a Customer entity:

```
const customer = await this.connection.getRepository(ctx, Customer).findOne({    where: { id: 1 },});console.log(customer.externalId);
```

The avatar relation will require an explicit join to be performed in order to access the data, since it is not
eagerly loaded by default:

```
const customer = await this.connection.getRepository(ctx, Customer).findOne({    where: { id: 1 },    relations: {        customFields: {            avatar: true,        }    }});console.log(customer.avatar);
```

or if using the QueryBuilder API:

```
const customer = await this.connection.getRepository(ctx, Customer).createQueryBuilder('customer')    .leftJoinAndSelect('customer.customFields.avatar', 'avatar')    .where('customer.id = :id', { id: 1 })    .getOne();console.log(customer.avatar);
```

or using the EntityHydrator:

```
const customer = await this.customerService.findOne(ctx, 1);await this.entityHydrator.hydrate(ctx, customer, { relations: ['customFields.avatar'] });console.log(customer.avatar);
```

## Custom field config properties​


[​](#custom-field-config-properties)
### Common properties​


[​](#common-properties)All custom fields share some common properties:

- name
- type
- list
- label
- description
- public
- readonly
- internal
- defaultValue
- nullable
- unique
- validate
- requiresPermission
- deprecated

[name](#name)[type](#type)[list](#list)[label](#label)[description](#description)[public](#public)[readonly](#readonly)[internal](#internal)[defaultValue](#defaultvalue)[nullable](#nullable)[unique](#unique)[validate](#validate)[requiresPermission](#requirespermission)[deprecated](#deprecated)
#### name​


[​](#name)The name of the field. This is used as the column name in the database, and as the GraphQL field name. The name should not contain spaces and by convention should be camelCased.

```
const config = {    // ...    customFields: {        Product: [            {                name: 'infoUrl',                type: 'string'            },        ]    }};
```

#### type​


[​](#type)[CustomFieldType](/reference/typescript-api/custom-fields/custom-field-type)The type of data that will be stored in the field.

#### list​


[​](#list)If set to true, then the field will be an array of the specified type. Defaults to false.

```
const config = {    // ...    customFields: {        Product: [            {                name: 'infoUrls',                type: 'string',                list: true,            },        ]    }};
```

Setting a custom field to be a list has the following effects:

- The GraphQL type will be an array of the specified type.
- The Dashboard will display a list of inputs for the field.
- For lists of primitive types (anything except relation), the database type will be set to simple-json which serializes the data into a JSON string. For lists of relation types, a separate many-to-many table will be created.

#### label​


[​](#label)[LocalizedStringArray](/reference/typescript-api/configurable-operation-def/localized-string-array)An array of localized labels for the field. These are used in the Dashboard to label the field.

```
import { LanguageCode } from '@vendure/core';const config = {    // ...    customFields: {        Product: [            {                name: 'infoUrl',                type: 'string',                label: [                    { languageCode: LanguageCode.en, value: 'Info URL' },                    { languageCode: LanguageCode.de, value: 'Info-URL' },                    { languageCode: LanguageCode.es, value: 'URL de información' },                ],            },        ]    }};
```

#### description​


[​](#description)[LocalizedStringArray](/reference/typescript-api/configurable-operation-def/localized-string-array)An array of localized descriptions for the field. These are used in the Dashboard to describe the field.

```
import { LanguageCode } from '@vendure/core';const config = {    // ...    customFields: {        Product: [            {                name: 'infoUrl',                type: 'string',                description: [                    { languageCode: LanguageCode.en, value: 'A URL to more information about the product' },                    { languageCode: LanguageCode.de, value: 'Eine URL zu weiteren Informationen über das Produkt' },                    { languageCode: LanguageCode.es, value: 'Una URL con más información sobre el producto' },                ],            },        ]    }};
```

#### public​


[​](#public)Whether the custom field is available via the Shop API. Defaults to true.

```
const config = {    // ...    customFields: {        Product: [            {                name: 'profitMargin',                type: 'int',                public: false,            },        ]    }};
```

#### readonly​


[​](#readonly)Whether the custom field can be updated via the GraphQL APIs. Defaults to false. If set to true, then the field
can only be updated via direct manipulation via TypeScript code in a plugin.

```
const config = {    // ...    customFields: {        Product: [            {                name: 'profitMargin',                type: 'int',                readonly: true,            },        ]    }};
```

#### internal​


[​](#internal)Whether the custom field is exposed at all via the GraphQL APIs. Defaults to false. If set to true, then the field will not be available
via the GraphQL API, but can still be used in TypeScript code in a plugin. Internal fields are useful for storing data which is not intended
to be exposed to the outside world, but which can be used in plugin logic.

```
const config = {    // ...    customFields: {        OrderLine: [            {                name: 'referralId',                type: 'string',                internal: true,            },        ]    }};
```

#### defaultValue​


[​](#defaultvalue)The default value when an Entity is created with this field. If not provided, then the default value will be null. Note that if you set nullable: false, then
you should also provide a defaultValue to avoid database errors when creating new entities.

```
const config = {    // ...    customFields: {        Product: [            {                name: 'reviewRating',                type: 'float',                defaultValue: 0,            },        ]    }};
```

#### nullable​


[​](#nullable)Whether the field is nullable in the database. If set to false, then a defaultValue should be provided.

```
const config = {    // ...    customFields: {        Product: [            {                name: 'reviewRating',                type: 'float',                nullable: false,                defaultValue: 0,            },        ]    }};
```

#### unique​


[​](#unique)Whether the value of the field should be unique. When set to true, a UNIQUE constraint is added to the column. Defaults
to false.

```
const config = {    // ...    customFields: {        Customer: [            {                name: 'externalId',                type: 'string',                unique: true,            },        ]    }};
```

#### validate​


[​](#validate)A custom validation function. If the value is valid, then the function should not return a value. If a string or LocalizedString array is returned, this is interpreted as an error message.

Note that string, number and date fields also have some built-in validation options such as min, max, pattern which you can read about in the following sections.

```
import { LanguageCode } from '@vendure/core';const config = {    // ...    customFields: {        Product: [            {                name: 'infoUrl',                type: 'string',                validate: (value: any) => {                    if (!value.startsWith('http')) {                        // If a localized error message is not required, a simple string can be returned.                        // return 'The URL must start with "http"';                        // If a localized error message is required, return an array of LocalizedString objects.                        return [                            { languageCode: LanguageCode.en, value: 'The URL must start with "http"' },                            { languageCode: LanguageCode.de, value: 'Die URL muss mit "http" beginnen' },                            { languageCode: LanguageCode.es, value: 'La URL debe comenzar con "http"' },                        ];                    }                },            },        ]    }};
```

This function can even be asynchronous and may use the Injector to access providers.

[Injector](/reference/typescript-api/common/injector/)
```
const config = {    // ...    customFields: {        ProductVariant: [            {                name: 'partCode',                type: 'string',                validate: async (value, injector, ctx) => {                    const partCodeService = injector.get(PartCodeService);                    const isValid = await partCodeService.validateCode(value);                    if (!isValid) {                        return `Part code ${value} is not valid`;                    }                },            },        ]    }};
```

#### requiresPermission​


[​](#requirespermission)Since v2.2.0, you can restrict access to custom field data by specifying a permission or permissions which are required to read and update the field.
For instance, you might want to add a particular custom field to the Product entity, but you do not want all administrators to be able
to view or update the field.

In the Dashboard, the custom field will not be displayed if the current administrator lacks the required permission.

In the GraphQL API, if the current user does not have the required permission, then the field will always return null.
Attempting to set the value of a field for which the user does not have the required permission will cause the mutation to fail
with an error.

```
import { Permission } from '@vendure/core';const config = {    // ...    customFields: {        Product: [            {                name: 'internalNotes',                type: 'text',                requiresPermission: Permission.SuperAdmin,            },            {                name: 'shippingType',                type: 'string',                // You can also use an array of permissions,                 // and the user must have at least one of the permissions                // to access the field.                requiresPermission: [                    Permission.SuperAdmin,                    Permission.ReadShippingMethod,                ],            },        ]    }};
```

The requiresPermission property only affects the Admin API. Access to a custom field via the Shop API is controlled by the public property.

If you need special logic to control access to a custom field in the Shop API, you can set public: false and then implement
a custom field resolver which contains the necessary logic, and returns
the entity's custom field value if the current customer meets the requirements.

[field resolver](/guides/developer-guide/extend-graphql-api/#add-fields-to-existing-types)
#### deprecated​


[​](#deprecated)Marks the custom field as deprecated in the GraphQL schema. When set to true, the field will be marked with the @deprecated directive. When set to a string, that string will be used as the deprecation reason.

This is useful for API evolution - you can mark fields as deprecated to signal to API consumers that they should migrate to newer alternatives, while still maintaining backward compatibility.

```
const config = {    // ...    customFields: {        Product: [            {                name: 'oldField',                type: 'string',                deprecated: true,            },            {                name: 'legacyUrl',                type: 'string',                deprecated: 'Use the new infoUrl field instead',            },        ]    }};
```

When querying the GraphQL schema, deprecated fields will be marked accordingly:

```
type ProductCustomFields {    oldField: String @deprecated    legacyUrl: String @deprecated(reason: "Use the new infoUrl field instead")    infoUrl: String}
```

### Properties for string fields​


[​](#properties-for-string-fields)In addition to the common properties, the string custom fields have some type-specific properties:

- pattern
- options
- length

[pattern](#pattern)[options](#options)[length](#length)
#### pattern​


[​](#pattern)A regex pattern which the field value must match. If the value does not match the pattern, then the validation will fail.

```
const config = {    // ...    customFields: {        ProductVariant: [            {                name: 'gtin',                type: 'string',                pattern: '^\d{8}(?:\d{4,6})?$',            },        ]    }};
```

#### options​


[​](#options)An array of pre-defined options for the field. This is useful for fields which should only have a limited set of values. The value property is the value which will be stored in the database, and the label property is an optional array of localized strings which will be displayed in the Dashboard.

```
import { LanguageCode } from '@vendure/core';const config = {    // ...    customFields: {        ProductVariant: [            {                name: 'condition',                type: 'string',                options: [                    { value: 'new', label: [{ languageCode: LanguageCode.en, value: 'New' }] },                    { value: 'used', label: [{ languageCode: LanguageCode.en, value: 'Used' }] },                ],            },        ]    }};
```

Attempting to set the value of the field to a value which is not in the options array will cause the validation to fail.

#### length​


[​](#length)The max length of the varchar created in the database. Defaults to 255. Maximum is 65,535.

```
const config = {    // ...    customFields: {        ProductVariant: [            {                name: 'partCode',                type: 'string',                length: 20,            },        ]    }};
```

### Properties for localeString fields​


[​](#properties-for-localestring-fields)In addition to the common properties, the localeString custom fields have some type-specific properties:

- pattern
- length

[pattern](#pattern-1)[length](#length-1)
#### pattern​


[​](#pattern-1)Same as the pattern property for string fields.

#### length​


[​](#length-1)Same as the length property for string fields.

### Properties for int & float fields​


[​](#properties-for-int--float-fields)In addition to the common properties, the int & float custom fields have some type-specific properties:

- min
- max
- step

[min](#min)[max](#max)[step](#step)
#### min​


[​](#min)The minimum permitted value. If the value is less than this, then the validation will fail.

```
const config = {    // ...    customFields: {        ProductVariant: [            {                name: 'reviewRating',                type: 'int',                min: 0,            },        ]    }};
```

#### max​


[​](#max)The maximum permitted value. If the value is greater than this, then the validation will fail.

```
const config = {    // ...    customFields: {        ProductVariant: [            {                name: 'reviewRating',                type: 'int',                max: 5,            },        ]    }};
```

#### step​


[​](#step)The step value. This is used in the Dashboard to determine the increment/decrement value of the input field.

```
const config = {    // ...    customFields: {        ProductVariant: [            {                name: 'reviewRating',                type: 'int',                step: 0.5,            },        ]    }};
```

### Properties for datetime fields​


[​](#properties-for-datetime-fields)In addition to the common properties, the datetime custom fields have some type-specific properties.
The min, max & step properties for datetime fields are intended to be used as described in
the MDN datetime-local docs

[the MDN datetime-local docs](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/datetime-local#Additional_attributes)- min
- max
- step

[min](#min-1)[max](#max-1)[step](#step-1)
#### min​


[​](#min-1)The earliest permitted date. If the value is earlier than this, then the validation will fail.

```
const config = {    // ...    customFields: {        ProductVariant: [            {                name: 'releaseDate',                type: 'datetime',                min: '2019-01-01T00:00:00.000Z',            },        ]    }};
```

#### max​


[​](#max-1)The latest permitted date. If the value is later than this, then the validation will fail.

```
const config = {    // ...    customFields: {        ProductVariant: [            {                name: 'releaseDate',                type: 'datetime',                max: '2019-12-31T23:59:59.999Z',            },        ]    }};
```

#### step​


[​](#step-1)The step value. See the MDN datetime-local docs to understand how this is used.

[the MDN datetime-local docs](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/datetime-local#step)
### Properties for struct fields​


[​](#properties-for-struct-fields)The struct custom field type is available from Vendure v3.1.0.

In addition to the common properties, the struct custom fields have some type-specific properties:

- fields

[fields](#fields)
#### fields​


[​](#fields)[StructFieldConfig[]](/reference/typescript-api/custom-fields/struct-field-config)A struct is a data structure comprising a set of named fields, each with its own type. The fields property is an array of StructFieldConfig objects, each of which defines a field within the struct.

```
const config = {    // ...    customFields: {        Product: [            {                name: 'dimensions',                type: 'struct',                fields: [                    { name: 'length', type: 'int' },                    { name: 'width', type: 'int' },                    { name: 'height', type: 'int' },                ],            },        ]    }};
```

When querying the Product entity, the dimensions field will be an object with the fields length, width and height:

```
query {    product(id: 1) {        customFields {            dimensions {                length                width                height            }        }    }}
```

Struct fields support many of the same properties as other custom fields, such as list, label, description, validate, ui and
type-specific properties such as options and pattern for string types.

The following properties are not supported for struct fields: public, readonly, internal, defaultValue, nullable, unique, requiresPermission.

```
import { LanguageCode } from '@vendure/core';const config = {    // ...    customFields: {        OrderLine: [            {                name: 'customizationOptions',                type: 'struct',                fields: [                    {                        name: 'color',                        type: 'string',                        options: [                            { value: 'red', label: [{ languageCode: LanguageCode.en, value: 'Red' }] },                            { value: 'blue', label: [{ languageCode: LanguageCode.en, value: 'Blue' }] },                        ],                    },                    {                        name: 'engraving',                        type: 'string',                        validate: (value: any) => {                            if (value.length > 20) {                                return 'Engraving text must be 20 characters or fewer';                            }                        },                    },                    {                        name: 'notifyEmailAddresses',                        type: 'string',                        list: true,                    }                ],            },        ]    }};
```

### Properties for relation fields​


[​](#properties-for-relation-fields)In addition to the common properties, the relation custom fields have some type-specific properties:

- entity
- eager
- graphQLType
- inverseSide

[entity](#entity)[eager](#eager)[graphQLType](#graphqltype)[inverseSide](#inverseside)
#### entity​


[​](#entity)[VendureEntity](/reference/typescript-api/entities/vendure-entity)The entity which this custom field is referencing. This can be one of the built-in entities, or a custom entity. If the entity is a custom entity, it must extend the VendureEntity class.

```
import { Product } from '\@vendure/core';const config = {    // ...    customFields: {        Product: [            {                name: 'relatedProducts',                list: true,                type: 'relation',                entity: Product,            },        ]    }};
```

#### eager​


[​](#eager)Whether to eagerly load the relation. Defaults to false. Note that eager loading has performance implications, so should only be used when necessary.

[eagerly load](https://typeorm.io/#/eager-and-lazy-relations)
```
import { Product } from '\@vendure/core';const config = {    // ...    customFields: {        Product: [            {                name: 'relatedProducts',                list: true,                type: 'relation',                entity: Product,                eager: true,            },        ]    }};
```

#### graphQLType​


[​](#graphqltype)The name of the GraphQL type that corresponds to the entity. Can be omitted if the GraphQL type name is the same as the entity name, which is the case for all of the built-in entities.

```
import { CmsArticle } from './entities/cms-article.entity';const config = {    // ...    customFields: {        Product: [            {                name: 'blogPosts',                list: true,                type: 'relation',                entity: CmsArticle,                graphQLType: 'BlogPost',            },        ]    }};
```

In the above example, the CmsArticle entity is being used as a related entity. However, the GraphQL type name is BlogPost, so we must specify this in the graphQLType property, otherwise Vendure will try to extend the GraphQL schema with reference to a non-existent "CmsArticle" type.

#### inverseSide​


[​](#inverseside)Allows you to specify the inverse side of the relation. Let's say you are adding a relation from Product
to a custom entity which refers back to the product. You can specify this inverse relation like so:

[inverse side of the relation](https://typeorm.io/#inverse-side-of-the-relationship)
```
import { Product } from '\@vendure/core';import { ProductReview } from './entities/product-review.entity';const config = {    // ...    customFields: {        Product: [            {                name: 'reviews',                list: true,                type: 'relation',                entity: ProductReview,                inverseSide: (review: ProductReview) => review.product,            },        ]    }};
```

This then allows you to query the ProductReview entity and include the product relation:

```
const { productReviews } = await this.connection.getRepository(ProductReview).findOne({    where: { id: 1 },    relations: ['product'],});
```

## Custom Field UI​


[​](#custom-field-ui)In the Dashboard, an appropriate default form input component is used for each custom field type. The Dashboard comes with a set of ready-made form input components, but it is also possible to create custom form input components. The ready-made components are:

- text-form-input: A single-line text input
- password-form-input: A single-line password input
- select-form-input: A select input
- textarea-form-input: A multi-line textarea input
- rich-text-form-input: A rich text editor input that saves the content as HTML
- json-editor-form-input: A simple JSON editor input
- html-editor-form-input: A simple HTML text editor input
- number-form-input: A number input
- currency-form-input: A number input with currency formatting
- boolean-form-input: A checkbox input
- date-form-input: A date input
- relation-form-input: A generic entity relation input which allows an ID to be manually specified
- customer-group-form-input: A select input for selecting a CustomerGroup
- facet-value-form-input: A select input for selecting a FacetValue
- product-selector-form-input: A select input for selecting a Product from an autocomplete list
- product-multi-form-input: A modal dialog for selecting multiple Products or ProductVariants

#### Default form inputs​


[​](#default-form-inputs)This table shows the default form input component used for each custom field type:

UI for relation type

The Dashboard app has built-in selection components for "relation" custom fields that reference certain common entity types, such as Asset, Product, ProductVariant and Customer. If you are relating to an entity not covered by the built-in selection components, you will see a generic relation component which allows you to manually enter the ID of the entity you wish to select.

If the generic selector is not suitable, or is you wish to replace one of the built-in selector components, you can create a UI extension that defines a custom field control for that custom field. You can read more about this in the custom form input guide

[custom form input guide](/guides/extending-the-admin-ui/custom-form-inputs/)
### Specifying the input component​


[​](#specifying-the-input-component)The defaults listed above can be overridden by using the ui property of the custom field config object. For example, if we want a number to be displayed as a currency input:

```
const config = {    // ...    customFields: {        ProductVariant: [            {                name: 'rrp',                type: 'int',                ui: { component: 'currency-form-input' },            },        ]    }}
```

Here's an example config demonstrating several ways to customize the UI controls for custom fields:

```
import { LanguageCode, VendureConfig } from '@vendure/core';const config: VendureConfig = {    // ...    customFields: {        Product: [            // Rich text editor            { name: 'additionalInfo', type: 'text', ui: { component: 'rich-text-form-input' } },            // JSON editor            { name: 'specs', type: 'text', ui: { component: 'json-editor-form-input' } },            // Numeric with suffix            {                name: 'weight',                type: 'int',                ui: { component: 'number-form-input', suffix: 'g' },            },            // Currency input            {                name: 'RRP',                type: 'int',                ui: { component: 'currency-form-input' },            },            // Select with options            {                name: 'pageType',                type: 'string',                ui: {                    component: 'select-form-input',                    options: [                        { value: 'static', label: [{ languageCode: LanguageCode.en, value: 'Static' }] },                        { value: 'dynamic', label: [{ languageCode: LanguageCode.en, value: 'Dynamic' }] },                    ],                },            },            // Text with prefix            {                name: 'link',                type: 'string',                ui: {                    component: 'text-form-input',                    prefix: 'https://',                },            },        ],    },};
```

and the resulting UI:

The various configuration options for each of the built-in form input  (e.g. suffix) is documented in the DefaultFormConfigHash object.

[DefaultFormConfigHash object](/reference/typescript-api/configurable-operation-def/default-form-config-hash/)
### Custom form input components​


[​](#custom-form-input-components)If none of the built-in form input components are suitable, you can create your own. This is a more advanced topic which is covered in detail in the Custom Form Input Components guide.

[Custom Form Input Components](/guides/extending-the-admin-ui/custom-form-inputs/)
## Tabbed custom fields​


[​](#tabbed-custom-fields)With a large, complex project, it's common for lots of custom fields to be required. This can get visually noisy in the UI, so Vendure supports tabbed custom fields. Just specify the tab name in the ui object, and those fields with the same tab name will be grouped in the UI! The tab name can also be a translation token if you need to support multiple languages.

Tabs will only be displayed if there is more than one tab name used in the custom fields. A lack of a tab property is counted as a tab (the "general" tab).

```
const config = {    // ...    customFields: {        Product: [            { name: 'additionalInfo', type: 'text', ui: { component: 'rich-text-form-input' } },            { name: 'specs', type: 'text', ui: { component: 'json-editor-form-input' } },            { name: 'width', type: 'int', ui: { tab: 'Shipping' } },            { name: 'height', type: 'int', ui: { tab: 'Shipping' } },            { name: 'depth', type: 'int', ui: { tab: 'Shipping' } },            { name: 'weight', type: 'int', ui: { tab: 'Shipping' } },        ],    },}
```

## TypeScript Typings​


[​](#typescript-typings)Because custom fields are generated at run-time, TypeScript has no way of knowing about them based on your
VendureConfig. Consider the example above - let's say we have a plugin which needs to
access the custom field values on a Product entity.

[plugin](/guides/developer-guide/plugins/)Attempting to access the custom field will result in a TS compiler error:

```
import { RequestContext, TransactionalConnection, ID, Product } from '@vendure/core';export class MyService {    constructor(private connection: TransactionalConnection) {    }    async getInfoUrl(ctx: RequestContext, productId: ID) {        const product = await this.connection            .getRepository(ctx, Product)            .findOne(productId);        return product.customFields.infoUrl;    }                           // ^ TS2339: Property 'infoUrl'}                             // does not exist on type 'CustomProductFields'.
```

The "easy" way to solve this is to assert the customFields object as any:

```
return (product.customFields as any).infoUrl;
```

However, this sacrifices type safety. To make our custom fields type-safe we can take advantage of a couple of more advanced TypeScript features - declaration merging and ambient modules. This allows us to extend the built-in CustomProductFields interface to add our custom fields to it:

[declaration merging](https://www.typescriptlang.org/docs/handbook/declaration-merging.html#merging-interfaces)[ambient modules](https://www.typescriptlang.org/docs/handbook/modules.html#ambient-modules)
```
// types.ts// Note: we are using a deep import here, rather than importing from `@vendure/core` due to// a possible bug in TypeScript (https://github.com/microsoft/TypeScript/issues/46617) which// causes issues when multiple plugins extend the same custom fields interface.import { CustomProductFields } from '@vendure/core/dist/entity/custom-entity-fields';declare module '@vendure/core/dist/entity/custom-entity-fields' {    interface CustomProductFields {        infoUrl: string;        downloadable: boolean;        shortName: string;    }}
```

When this file is then imported into our service file (either directly or indirectly), TypeScript will know about our custom fields, and we do not need to do any type assertions.

```
return product.customFields.infoUrl;// no error, plus TS autocomplete works.
```

Note that for the typings to work correctly, order of imports matters.

One way to ensure that your custom field typings always get imported first is to include them as the first item in the tsconfig "include" array.

For a working example of this setup, see the real-world-vendure repo

[real-world-vendure repo](https://github.com/vendure-ecommerce/real-world-vendure/blob/master/src/plugins/reviews/types.ts)
## Special cases​


[​](#special-cases)Beyond adding custom fields to the corresponding GraphQL types, and updating paginated list sort & filter options, there are a few special cases where adding custom fields to certain entities will result in further API changes.

### OrderLine custom fields​


[​](#orderline-custom-fields)When you define custom fields on the OrderLine entity, the following API changes are also automatically provided by Vendure:

- Shop API: addItemToOrder will have a 3rd input argument, customFields, which allows custom field values to be set when adding an item to the order.
- Shop API: adjustOrderLine will have a 3rd input argument, customFields, which allows custom field values to be updated.
- Admin API: the equivalent mutations for manipulating draft orders and for modifying and order will also have inputs to allow custom field values to be set.

[addItemToOrder](/reference/graphql-api/shop/mutations#additemtoorder)[adjustOrderLine](/reference/graphql-api/shop/mutations#additemtoorder)To see an example of this in practice, see the Configurable Product guide

[Configurable Product guide](/guides/how-to/configurable-products/)
### Order custom fields​


[​](#order-custom-fields)When you define custom fields on the Order entity, the following API changes are also automatically provided by Vendure:

- Admin API: modifyOrder will have a customFields field on the input object.

[modifyOrder](/reference/graphql-api/admin/mutations#modifyorder)
### ShippingMethod custom fields​


[​](#shippingmethod-custom-fields)When you define custom fields on the ShippingMethod entity, the following API changes are also automatically provided by Vendure:

- Shop API: eligibleShippingMethods will have public custom fields available on the result.

[eligibleShippingMethods](/reference/graphql-api/shop/queries#eligibleshippingmethods)
### PaymentMethod custom fields​


[​](#paymentmethod-custom-fields)When you define custom fields on the PaymentMethod entity, the following API changes are also automatically provided by Vendure:

- Shop API: eligiblePaymentMethods will have public custom fields available on the result.

[eligiblePaymentMethods](/reference/graphql-api/shop/queries#eligiblepaymentmethods)
### Customer custom fields​


[​](#customer-custom-fields)When you define custom fields on the Customer entity, the following API changes are also automatically provided by Vendure:

- Shop API: registerCustomerAccount will have have a customFields field on the input
object.

[registerCustomerAccount](/reference/graphql-api/shop/mutations#registercustomeraccount)


---

# Error Handling


Errors in Vendure can be divided into two categories:

- Unexpected errors
- Expected errors

These two types have different meanings and are handled differently from one another.

## Unexpected Errors​


[​](#unexpected-errors)This type of error occurs when something goes unexpectedly wrong during the processing of a request. Examples include internal server errors, database connectivity issues, lacking permissions for a resource, etc. In short, these are errors that are not supposed to happen.

Internally, these situations are handled by throwing an Error:

```
const customer = await this.findOneByUserId(ctx, user.id);// in this case, the customer *should always* be found, and if// not then something unknown has gone wrong...if (!customer) {    throw new InternalServerError('error.cannot-locate-customer-for-user');}
```

In the GraphQL APIs, these errors are returned in the standard errors array:

```
{  "errors": [    {      "message": "You are not currently authorized to perform this action",      "locations": [        {          "line": 2,          "column": 2        }      ],      "path": [        "me"      ],      "extensions": {        "code": "FORBIDDEN"      }    }  ],  "data": {    "me": null  }}
```

So your client applications need a generic way of detecting and handling this kind of error. For example, many http client libraries support "response interceptors" which can be used to intercept all API responses and check the errors array.

GraphQL will return a 200 status even if there are errors in the errors array. This is because in GraphQL it is still possible to return good data alongside any errors.

Here's how it might look in a simple Fetch-based client:

```
export function query(document: string, variables: Record<string, any> = {}) {    return fetch(endpoint, {        method: 'POST',        headers,        credentials: 'include',        body: JSON.stringify({            query: document,            variables,        }),    })        .then(async (res) => {            if (!res.ok) {                const body = await res.json();                throw new Error(body);            }            const newAuthToken = res.headers.get('vendure-auth-token');            if (newAuthToken) {                localStorage.setItem(AUTH_TOKEN_KEY, newAuthToken);            }            return res.json();        })        .catch((err) => {            // This catches non-200 responses, such as malformed queries or            // network errors. Handle this with your own error handling logic.            // For this demo we just show an alert.            window.alert(err.message);        })        .then((result) => {            // We check for any GraphQL errors which would be in the            // `errors` array of the response body:            if (Array.isArray(result.errors)) {                // It looks like we have an unexpected error.                // At this point you could take actions like:                // - logging the error to a remote service                // - displaying an error popup to the user                // - inspecting the `error.extensions.code` to determine the                //   type of error and take appropriate action. E.g. a                //   in response to a FORBIDDEN_ERROR you can redirect the                //   user to a login page.                // In this example we just display an alert:                const errorMessage = result.errors.map((e) => e.message).join('\n');                window.alert(`Unexpected error caught:\n\n${errorMessage}`);            }            return result;        });}
```

## Expected errors (ErrorResults)​


[​](#expected-errors-errorresults)This type of error represents a well-defined result of (typically) a GraphQL mutation which is not considered "successful". For example, when using the applyCouponCode mutation, the code may be invalid, or it may have expired. These are examples of "expected" errors and are named in Vendure "ErrorResults". These ErrorResults are encoded into the GraphQL schema itself.

ErrorResults all implement the ErrorResult interface:

```
interface ErrorResult {  errorCode: ErrorCode!  message: String!}
```

Some ErrorResults add other relevant fields to the type:

```
"Returned if there is an error in transitioning the Order state"type OrderStateTransitionError implements ErrorResult {  errorCode: ErrorCode!  message: String!  transitionError: String!  fromState: String!  toState: String!}
```

Operations that may return ErrorResults use a GraphQL union as their return type:

```
type Mutation {  "Applies the given coupon code to the active Order"  applyCouponCode(couponCode: String!): ApplyCouponCodeResult!}union ApplyCouponCodeResult = Order  | CouponCodeExpiredError  | CouponCodeInvalidError  | CouponCodeLimitError
```

### Querying an ErrorResult union​


[​](#querying-an-errorresult-union)When performing an operation of a query or mutation which returns a union, you will need to use the GraphQL conditional fragment to select the desired fields:

[GraphQL conditional fragment](https://graphql.org/learn/schema/#union-types)
```
mutation ApplyCoupon($code: String!) {  applyCouponCode(couponCode: $code) {    __typename    ...on Order {      id      couponCodes      totalWithTax    }    # querying the ErrorResult fields    # "catches" all possible errors    ...on ErrorResult {      errorCode      message    }    # you can also specify particular fields    # if your client app needs that specific data    # as part of handling the error.    ...on CouponCodeLimitError {      limit    }  }}

```

The __typename field is added by GraphQL to all object types, so we can include it no matter whether the result will end up being
an Order object or an ErrorResult object. We can then use the __typename value to determine what kind of object we have received.

Some clients such as Apollo Client will automatically add the __typename field to all queries and mutations. If you are using a client which does not do this, you will need to add it manually.

Here's how a response would look in both the success and error result cases:

- Success case
- Error case

```
{  "data": {    "applyCouponCode": {      "__typename": "Order",      "id": "123",      "couponCodes": ["VALID-CODE"],      "totalWithTax": 12599,    }  }}
```

```
{  "data": {    "applyCouponCode": {      "__typename": "CouponCodeLimitError",      "errorCode": "COUPON_CODE_LIMIT_ERROR",      "message": "Coupon code cannot be used more than once per customer",      "limit": 1    }  }}
```

### Handling ErrorResults in plugin code​


[​](#handling-errorresults-in-plugin-code)If you are writing a plugin which deals with internal Vendure service methods that may return ErrorResults,
then you can use the isGraphQlErrorResult() function to check whether the result is an ErrorResult:

```
import { Injectable} from '@nestjs/common';import { isGraphQlErrorResult, Order, OrderService, OrderState, RequestContext } from '@vendure/core';@Injectable()export class MyService {    constructor(private orderService: OrderService) {}    async myMethod(ctx: RequestContext, order: Order, newState: OrderState) {        const transitionResult = await this.orderService.transitionToState(ctx, order.id, newState);        if (isGraphQlErrorResult(transitionResult)) {            // The transition failed with an ErrorResult            throw transitionResult;        } else {            // TypeScript will correctly infer the type of `transitionResult` to be `Order`            return transitionResult;        }    }}
```

### Handling ErrorResults in client code​


[​](#handling-errorresults-in-client-code)Because we know all possible ErrorResult that may occur for a given mutation, we can handle them in an exhaustive manner. In other
words, we can ensure our storefront has some sensible response to all possible errors. Typically this will be done with
a switch statement:

```
const result = await query(APPLY_COUPON_CODE, { code: 'INVALID-CODE' });switch (result.applyCouponCode.__typename) {    case 'Order':        // handle success        break;    case 'CouponCodeExpiredError':        // handle expired code        break;    case 'CouponCodeInvalidError':        // handle invalid code        break;    case 'CouponCodeLimitError':        // handle limit error        break;    default:        // any other ErrorResult can be handled with a generic error message}
```

If we combine this approach with GraphQL code generation, then TypeScript will even be able to
help us ensure that we have handled all possible ErrorResults:

[GraphQL code generation](/guides/storefront/codegen/)
```
// Here we are assuming that the APPLY_COUPON_CODE query has been generated// by the codegen tool, and therefore has the// type `TypedDocumentNode<ApplyCouponCode, ApplyCouponCodeVariables>`.const result = await query(APPLY_COUPON_CODE, { code: 'INVALID-CODE' });switch (result.applyCouponCode.__typename) {    case 'Order':        // handle success        break;    case 'CouponCodeExpiredError':        // handle expired code        break;    case 'CouponCodeInvalidError':        // handle invalid code        break;    case 'CouponCodeLimitError':        // handle limit error        break;    default:        // this line will cause a TypeScript error if there are any        // ErrorResults which we have not handled in the switch cases        // above.        const _exhaustiveCheck: never = result.applyCouponCode;}
```

## Live example​


[​](#live-example)Here is a live example which the handling of unexpected errors as well as ErrorResults:


---

# Events


Vendure emits events which can be subscribed to by plugins. These events are published by the EventBus and
likewise the EventBus is used to subscribe to events.

[EventBus](/reference/typescript-api/events/event-bus/)An event exists for virtually all significant actions which occur in the system, such as:

- When entities (e.g. Product, Order, Customer) are created, updated or deleted
- When a user registers an account
- When a user logs in or out
- When the state of an Order, Payment, Fulfillment or Refund changes

A full list of the available events follows.

## Event types​


[​](#event-types)- AccountRegistrationEvent
- AccountVerifiedEvent
- AdministratorEvent
- AssetChannelEvent
- AssetEvent
- AttemptedLoginEvent
- ChangeChannelEvent
- ChannelEvent
- CollectionEvent
- CollectionModificationEvent
- CountryEvent
- CouponCodeEvent
- CustomerAddressEvent
- CustomerEvent
- CustomerGroupChangeEvent
- CustomerGroupEvent
- FacetEvent
- FacetValueEvent
- FulfillmentEvent
- FulfillmentStateTransitionEvent
- GlobalSettingsEvent
- HistoryEntryEvent
- IdentifierChangeEvent
- IdentifierChangeRequestEvent
- InitializerEvent
- LoginEvent
- LogoutEvent
- OrderEvent

[AccountRegistrationEvent](/reference/typescript-api/events/event-types#accountregistrationevent)[AccountVerifiedEvent](/reference/typescript-api/events/event-types#accountverifiedevent)[AdministratorEvent](/reference/typescript-api/events/event-types#administratorevent)[AssetChannelEvent](/reference/typescript-api/events/event-types#assetchannelevent)[AssetEvent](/reference/typescript-api/events/event-types#assetevent)[AttemptedLoginEvent](/reference/typescript-api/events/event-types#attemptedloginevent)[ChangeChannelEvent](/reference/typescript-api/events/event-types#changechannelevent)[ChannelEvent](/reference/typescript-api/events/event-types#channelevent)[CollectionEvent](/reference/typescript-api/events/event-types#collectionevent)[CollectionModificationEvent](/reference/typescript-api/events/event-types#collectionmodificationevent)[CountryEvent](/reference/typescript-api/events/event-types#countryevent)[CouponCodeEvent](/reference/typescript-api/events/event-types#couponcodeevent)[CustomerAddressEvent](/reference/typescript-api/events/event-types#customeraddressevent)[CustomerEvent](/reference/typescript-api/events/event-types#customerevent)[CustomerGroupChangeEvent](/reference/typescript-api/events/event-types#customergroupchangeevent)[CustomerGroupEvent](/reference/typescript-api/events/event-types#customergroupevent)[FacetEvent](/reference/typescript-api/events/event-types#facetevent)[FacetValueEvent](/reference/typescript-api/events/event-types#facetvalueevent)[FulfillmentEvent](/reference/typescript-api/events/event-types#fulfillmentevent)[FulfillmentStateTransitionEvent](/reference/typescript-api/events/event-types#fulfillmentstatetransitionevent)[GlobalSettingsEvent](/reference/typescript-api/events/event-types#globalsettingsevent)[HistoryEntryEvent](/reference/typescript-api/events/event-types#historyentryevent)[IdentifierChangeEvent](/reference/typescript-api/events/event-types#identifierchangeevent)[IdentifierChangeRequestEvent](/reference/typescript-api/events/event-types#identifierchangerequestevent)[InitializerEvent](/reference/typescript-api/events/event-types#initializerevent)[LoginEvent](/reference/typescript-api/events/event-types#loginevent)[LogoutEvent](/reference/typescript-api/events/event-types#logoutevent)[OrderEvent](/reference/typescript-api/events/event-types#orderevent)- OrderLineEvent
- OrderPlacedEvent
- OrderStateTransitionEvent
- PasswordResetEvent
- PasswordResetVerifiedEvent
- PaymentMethodEvent
- PaymentStateTransitionEvent
- ProductChannelEvent
- ProductEvent
- ProductOptionEvent
- ProductOptionGroupChangeEvent
- ProductOptionGroupEvent
- ProductVariantChannelEvent
- ProductVariantEvent
- PromotionEvent
- ProvinceEvent
- RefundStateTransitionEvent
- RoleChangeEvent
- RoleEvent
- SearchEvent
- SellerEvent
- ShippingMethodEvent
- StockMovementEvent
- TaxCategoryEvent
- TaxRateEvent
- TaxRateModificationEvent
- ZoneEvent
- ZoneMembersEvent

[OrderLineEvent](/reference/typescript-api/events/event-types#orderlineevent)[OrderPlacedEvent](/reference/typescript-api/events/event-types#orderplacedevent)[OrderStateTransitionEvent](/reference/typescript-api/events/event-types#orderstatetransitionevent)[PasswordResetEvent](/reference/typescript-api/events/event-types#passwordresetevent)[PasswordResetVerifiedEvent](/reference/typescript-api/events/event-types#passwordresetverifiedevent)[PaymentMethodEvent](/reference/typescript-api/events/event-types#paymentmethodevent)[PaymentStateTransitionEvent](/reference/typescript-api/events/event-types#paymentstatetransitionevent)[ProductChannelEvent](/reference/typescript-api/events/event-types#productchannelevent)[ProductEvent](/reference/typescript-api/events/event-types#productevent)[ProductOptionEvent](/reference/typescript-api/events/event-types#productoptionevent)[ProductOptionGroupChangeEvent](/reference/typescript-api/events/event-types#productoptiongroupchangeevent)[ProductOptionGroupEvent](/reference/typescript-api/events/event-types#productoptiongroupevent)[ProductVariantChannelEvent](/reference/typescript-api/events/event-types#productvariantchannelevent)[ProductVariantEvent](/reference/typescript-api/events/event-types#productvariantevent)[PromotionEvent](/reference/typescript-api/events/event-types#promotionevent)[ProvinceEvent](/reference/typescript-api/events/event-types#provinceevent)[RefundStateTransitionEvent](/reference/typescript-api/events/event-types#refundstatetransitionevent)[RoleChangeEvent](/reference/typescript-api/events/event-types#rolechangeevent)[RoleEvent](/reference/typescript-api/events/event-types#roleevent)[SearchEvent](/reference/typescript-api/events/event-types#searchevent)[SellerEvent](/reference/typescript-api/events/event-types#sellerevent)[ShippingMethodEvent](/reference/typescript-api/events/event-types#shippingmethodevent)[StockMovementEvent](/reference/typescript-api/events/event-types#stockmovementevent)[TaxCategoryEvent](/reference/typescript-api/events/event-types#taxcategoryevent)[TaxRateEvent](/reference/typescript-api/events/event-types#taxrateevent)[TaxRateModificationEvent](/reference/typescript-api/events/event-types#taxratemodificationevent)[ZoneEvent](/reference/typescript-api/events/event-types#zoneevent)[ZoneMembersEvent](/reference/typescript-api/events/event-types#zonemembersevent)
## Subscribing to events​


[​](#subscribing-to-events)To subscribe to an event, use the EventBus's .ofType() method. It is typical to set up subscriptions in the onModuleInit() or onApplicationBootstrap()
lifecycle hooks of a plugin or service (see NestJS Lifecycle events).

[NestJS Lifecycle events](https://docs.nestjs.com/fundamentals/lifecycle-events)Here's an example where we subscribe to the ProductEvent and use it to trigger a rebuild of a static storefront:

```
import { OnModuleInit } from '@nestjs/common';import { EventBus, ProductEvent, PluginCommonModule, VendurePlugin } from '@vendure/core';import { StorefrontBuildService } from './services/storefront-build.service';@VendurePlugin({    imports: [PluginCommonModule],})export class StorefrontBuildPlugin implements OnModuleInit {    constructor(        private eventBus: EventBus,        private storefrontBuildService: StorefrontBuildService,    ) {}    onModuleInit() {        this.eventBus.ofType(ProductEvent).subscribe(event => {            this.storefrontBuildService.triggerBuild();        });    }}
```

The EventBus.ofType() and related EventBus.filter() methods return an RxJS Observable.
This means that you can use any of the RxJS operators to transform the stream of events.

[RxJS operators](https://rxjs-dev.firebaseapp.com/guide/operators)For example, to debounce the stream of events, you could do this:

```
import { debounceTime } from 'rxjs/operators';// ...this.eventBus    .ofType(ProductEvent)    .pipe(debounceTime(1000))    .subscribe(event => {        this.storefrontBuildService.triggerBuild();    });
```

### Subscribing to multiple event types​


[​](#subscribing-to-multiple-event-types)Using the .ofType() method allows us to subscribe to a single event type. If we want to subscribe to multiple event types, we can use the .filter() method instead:

```
import { Injectable, OnModuleInit } from '@nestjs/common';import {    EventBus,    PluginCommonModule,    VendurePlugin,    ProductEvent,    ProductVariantEvent,} from '@vendure/core';@VendurePlugin({    imports: [PluginCommonModule],})export class MyPluginPlugin implements OnModuleInit {    constructor(private eventBus: EventBus) {}    onModuleInit() {        this.eventBus            .filter(event => event instanceof ProductEvent || event instanceof ProductVariantEvent)            .subscribe(event => {                // the event will be a ProductEvent or ProductVariantEvent            });    }}
```

## Publishing events​


[​](#publishing-events)You can publish events using the EventBus.publish() method. This is useful if you want to trigger an event from within a plugin or service.

For example, to publish a ProductEvent:

```
import { Injectable } from '@nestjs/common';import { EventBus, ProductEvent, RequestContext, Product } from '@vendure/core';@Injectable()export class MyPluginService {    constructor(private eventBus: EventBus) {}    async doSomethingWithProduct(ctx: RequestContext, product: Product) {        // ... do something        await this.eventBus.publish(new ProductEvent(ctx, product, 'updated'));    }}
```

## Creating custom events​


[​](#creating-custom-events)You can create your own custom events by extending the VendureEvent class. For example, to create a custom event which is triggered when a customer submits a review, you could do this:

[VendureEvent](/reference/typescript-api/events/vendure-event)
```
import { ID, RequestContext, VendureEvent } from '@vendure/core';import { ProductReviewInput } from '../types';/** * @description * This event is fired whenever a ProductReview is submitted. */export class ReviewSubmittedEvent extends VendureEvent {    constructor(        public ctx: RequestContext,        public input: ProductReviewInput,    ) {        super();    }}
```

The event would then be published from your plugin's ProductReviewService:

```
import { Injectable } from '@nestjs/common';import { EventBus, ProductReviewService, RequestContext } from '@vendure/core';import { ReviewSubmittedEvent } from '../events/review-submitted.event';import { ProductReviewInput } from '../types';@Injectable()export class ProductReviewService {    constructor(        private eventBus: EventBus,        private productReviewService: ProductReviewService,    ) {}    async submitReview(ctx: RequestContext, input: ProductReviewInput) {        this.eventBus.publish(new ReviewSubmittedEvent(ctx, input));        // handle creation of the new review        // ...    }}
```

### Entity events​


[​](#entity-events)There is a special event class VendureEntityEvent for events relating to the creation, update or deletion of entities. Let's say you have a custom entity (see defining a database entity) BlogPost and you want to trigger an event whenever a new BlogPost is created, updated or deleted:

[VendureEntityEvent](/reference/typescript-api/events/vendure-entity-event)[defining a database entity](/guides/developer-guide/database-entity)
```
import { ID, RequestContext, VendureEntityEvent } from '@vendure/core';import { BlogPost } from '../entities/blog-post.entity';import { CreateBlogPostInput, UpdateBlogPostInput } from '../types';type BlogPostInputTypes = CreateBlogPostInput | UpdateBlogPostInput | ID | ID[];/** * This event is fired whenever a BlogPost is added, updated * or deleted. */export class BlogPostEvent extends VendureEntityEvent<BlogPost, BlogPostInputTypes> {    constructor(        ctx: RequestContext,        entity: BlogPost,        type: 'created' | 'updated' | 'deleted',        input?: BlogPostInputTypes,    ) {        super(entity, type, ctx, input);    }}
```

Using this event, you can subscribe to all BlogPost events, and for instance filter for only the created events:

```
import { Injectable, OnModuleInit } from '@nestjs/common';import { EventBus, PluginCommonModule, VendurePlugin } from '@vendure/core';import { filter } from 'rxjs/operators';import { BlogPostEvent } from './events/blog-post-event';@VendurePlugin({    imports: [PluginCommonModule],    // ...})export class BlogPlugin implements OnModuleInit {    constructor(private eventBus: EventBus) {}    onModuleInit() {        this.eventBus            .ofType(BlogPostEvent)            .pipe(filter(event => event.type === 'created'))            .subscribe(event => {                const blogPost = event.entity;                // do something with the newly created BlogPost            });    }}
```

## Blocking event handlers​


[​](#blocking-event-handlers)The following section is an advanced topic.

The API described in this section was added in Vendure v2.2.0.

When using the .ofType().subscribe() pattern, the event handler is non-blocking. This means that the code that publishes
the event (the "publishing code") will have no knowledge of any subscribers, and in fact any subscribers will be executed after the code that
published the event has completed (technically, any ongoing database transactions are completed before the event gets
emitted to the subscribers). This follows the typical Observer pattern and is a good fit for most use-cases.

[Observer pattern](https://en.wikipedia.org/wiki/Observer_pattern)However, there may be certain situations in which you want the event handler to cause the publishing code to block
until the event handler has completed. This is done by using a "blocking event handler", which does not follow the
Observer pattern, but rather it behaves more like a synchronous function call occurring within the publishing code.

You may want to use a blocking event handler in the following situations:

- The event handler is so critical that you need to ensure that it has completed before the publishing code continues. For
example, if the event handler must manipulate some financial records.
- Errors in the event handler code should cause the publishing code to fail (and any database transaction to be rolled back).
- You want to guard against the edge case that a server instance gets shut down (due to e.g. a fatal error or an auto-scaling event)
before event subscribers have been invoked.

In these cases, you can use the EventBus.registerBlockingEventHandler() method:

```
import { Injectable, OnModuleInit } from '@nestjs/common';import { EventBus, PluginCommonModule, VendurePlugin, CustomerEvent } from '@vendure/core';import { CustomerSyncService } from './services/customer-sync.service';@VendurePlugin({    imports: [PluginCommonModule],})export class MyPluginPlugin implements OnModuleInit {    constructor(        private eventBus: EventBus,        private customerSyncService: CustomerSyncService,    ) {}    onModuleInit() {        this.eventBus.registerBlockingEventHandler({            event: CustomerEvent,            id: 'sync-customer-details-handler',            handler: async event => {                // This hypothetical service method would do nothing                // more than adding a new job to the job queue. This gives us                // the guarantee that the job is added before the publishing                // code is able to continue, while minimizing the time spent                // in the event handler.                await this.customerSyncService.triggerCustomerSyncJob(event);            },        });    }}
```

Key differences between event subscribers and blocking event handlers:

### Performance considerations​


[​](#performance-considerations)Since blocking event handlers execute within the same transaction as the publishing code, it is important to ensure that they are fast.
If a single handler takes longer than 100ms to execute, a warning will be logged. Ideally they should be much faster than that - you can
set your Logger's logLevel to LogLevel.DEBUG to see the execution time of each handler.

If multiple handlers are registered for a single event, they will be executed sequentially, so the publishing code will be blocked until
all handlers have completed.

### Order of execution​


[​](#order-of-execution)If you register multiple handlers for the same event, they will be executed in the order in which they were registered.
If you need more control over this order, i.e. to guarantee that a particular handler will execute before another, you can use
the before or after options:

```
// In one part of your code basethis.eventBus.registerBlockingEventHandler({    type: CustomerEvent,    id: 'sync-customer-details-handler',    handler: async event => {        // ...    },});// In another part of your code basethis.eventBus.registerBlockingEventHandler({    type: CustomerEvent,    id: 'check-customer-details-handler',    handler: async event => {        // ...    },    before: 'sync-customer-details-handler',});
```


---

# Migrations


Database migrations are needed whenever the database schema changes. This can be caused by:

- changes to the custom fields configuration
- new database entities defined by plugins
- occasional changes to the core Vendure database schema when updating to newer versions

[custom fields](/guides/developer-guide/custom-fields/)[database entities defined by plugins](/guides/developer-guide/database-entity/)
## Synchronize vs migrate​


[​](#synchronize-vs-migrate)TypeORM (which Vendure uses to interact with the database) has a synchronize option which, when set to true, will automatically update your database schema to reflect the current Vendure configuration. This is equivalent to automatically generating and running a migration every time the server starts up.

This is convenient while developing, but should not be used in production, since a misconfiguration could potentially delete production data. In this case, migrations should be used.

```
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    dbConnectionOptions: {        // ...        synchronize: false,    }};
```

## Migration workflow​


[​](#migration-workflow)This section assumes a standard Vendure installation based on @vendure/create.

Let's assume you have defined a new "keywords" custom field on the Product entity. The next time you start your server you'll see a message like this:

```
[server] Your database schema does not match your current configuration. Generate a new migration for the following changes:[server]  - ALTER TABLE "product" ADD "customFieldsKeywords" character varying(255)
```

Since we have synchronize set to false, we need to generate a migration to apply these changes to the database. The workflow for this is as follows:

### 1. Generate a migration​


[​](#1-generate-a-migration)Run npx vendure migrate and select "Generate a new migration"

[Vendure CLI](/guides/developer-guide/cli/)
### 2. Check the migration file​


[​](#2-check-the-migration-file)This will have created a new migration file in the src/migrations directory. Open this file and check that it looks correct. It should look something like this:

```
import {MigrationInterface, QueryRunner} from "typeorm";export class addKeywordsField1690558104092 implements MigrationInterface {   public async up(queryRunner: QueryRunner): Promise<any> {        await queryRunner.query(`ALTER TABLE "product" ADD "customFieldsKeywords" character varying(255)`, undefined);   }   public async down(queryRunner: QueryRunner): Promise<any> {        await queryRunner.query(`ALTER TABLE "product" DROP COLUMN "customFieldsKeywords"`, undefined);   }}
```

The up() function is what will be executed when the migration is run. The down() function is what will be executed if the migration is reverted. In this case, the up() function is adding a new column to the product table, and the down() function is removing it.

The exact query will depend on the database you are using. The above example is for PostgreSQL.

### 3. Run the migration​


[​](#3-run-the-migration)Assuming the migration file looks correct, the next time you start the server, the migration will
be run automatically. This is because the runMigrations function is called in the src/index.ts file:

```
import { bootstrap, runMigrations } from '@vendure/core';import { config } from './vendure-config';runMigrations(config)    .then(() => bootstrap(config))    .catch(err => {        console.log(err);    });
```

It is also possible to run the migration manually without starting the server:

Run npx vendure migrate and select "Run pending migrations"

[Vendure CLI](/guides/developer-guide/cli/)TypeORM will attempt to run each migration inside a transaction. This means that if one of the migration commands fails, then the entire transaction will be rolled back to its original state.

However this is not supported by MySQL / MariaDB. This means that when using MySQL or MariaDB, errors in your migration script could leave your database in a broken or inconsistent state. Therefore it is critical that you first create a backup of your database before running a migration.

You can read more about this issue in typeorm/issues/7054

[typeorm/issues/7054](https://github.com/typeorm/typeorm/issues/7054)
## Migrations in-depth​


[​](#migrations-in-depth)Now we'll dive into what's going on under the hood.

Vendure exposes a some helper function which wrap around the underlying TypeORM migration functionality. The
reason for using these helper functions rather than using the TypeORM CLI directly is that Vendure generates additional
schema information based on custom fields and plugin configurations which are not available to the TypeORM CLI.

[TypeORM migration functionality](https://typeorm.io/migrations)In a standard Vendure installation prior to v2.2.0, you'll see the following migration script in your project root directory.
Running the vendure migrate command also uses a very similar script internally.

```
import { generateMigration, revertLastMigration, runMigrations } from '@vendure/core';import { Command } from 'commander';import { config } from './src/vendure-config';const program = new Command();program    .command('generate <name>')    .description('Generate a new migration file with the given name')    .action(name => {        return generateMigration(config, { name, outputDir: './src/migrations' });    });program    .command('run')    .description('Run all pending migrations')    .action(() => {        return runMigrations(config);    });program    .command('revert')    .description('Revert the last applied migration')    .action(() => {        return revertLastMigration(config);    });program.parse(process.argv);
```

and a set of scripts in your package.json file:

```
{  // ...  "scripts": {    "migration:generate": "ts-node migration.ts generate",    "migration:run": "ts-node migration.ts run",    "migration:revert": "ts-node migration.ts revert"  }}
```

When running and reverting migrations, Vendure is looking for migration files in the directory specified by the dbConnectionOptions.migrations option is set in your VendureConfig:

```
import { VendureConfig } from '@vendure/core';import path from 'path';export const config: VendureConfig = {    // ...    dbConnectionOptions: {        // ...        migrations: [path.join(__dirname, './migrations/*.+(js|ts)')],    }};
```

TypeORM keeps track of which migrations have been run by creating a new migrations table in your database, and each time a migration is successfully run
it adds a row to this table with the name of the migration class and a timestamp. This prevents the same migration from being run twice, and also allows
TypeORM to know which migration to revert when the revertLastMigration function is called.

These are the underlying function exposed by Vendure which are used to generate, run and revert migrations:

- generateMigration function
- runMigrations function
- revertLastMigration function

[generateMigration function](/reference/typescript-api/migration/generate-migration/)[runMigrations function](/reference/typescript-api/migration/run-migrations/)[revertLastMigration function](/reference/typescript-api/migration/revert-last-migration/)
### Reverting a migration​


[​](#reverting-a-migration)The revertLastMigration function will revert the last applied migration by applying the down() method. If run again it will then revert the one before that, and so on.
In doing so, it will also remove the corresponding row from the migrations table.


---

# Plugins


The heart of Vendure is its plugin system. Plugins not only allow you to instantly add new functionality to your
Vendure server via third-part npm packages, they are also the means by which you build out the custom business
logic of your application.

Plugins in Vendure allow one to:

- Modify the VendureConfig object, such as defining custom fields on existing entities.
- Extend the GraphQL APIs, including modifying existing types and adding completely new queries and mutations.
- Define new database entities and interact directly with the database.
- Interact with external systems that you need to integrate with.
- Respond to events such as new orders being placed.
- Trigger background tasks to run on the worker process.

… and more!

In a typical Vendure application, custom logic and functionality is implemented as a set of plugins
which are usually independent of one another. For example, there could be a plugin for each of the following:
wishlists, product reviews, loyalty points, gift cards, etc.
This allows for a clean separation of concerns and makes it easy to add or remove functionality as needed.

## Core Plugins​


[​](#core-plugins)Vendure provides a set of core plugins covering common functionality such as assets handling,
email sending, and search. For documentation on these, see the Core Plugins reference.

[Core Plugins reference](/reference/core-plugins/)
## Plugin basics​


[​](#plugin-basics)Here's a bare-minimum example of a plugin:

```
import { LanguageCode, PluginCommonModule, VendurePlugin } from '@vendure/core';@VendurePlugin({    imports: [PluginCommonModule],    configuration: config => {        config.customFields.Customer.push({            type: 'string',            name: 'avatarUrl',            label: [{ languageCode: LanguageCode.en, value: 'Avatar URL' }],            list: true,        });        return config;    },})export class AvatarPlugin {}
```

This plugin does one thing only: it adds a new custom field to the Customer entity.

The plugin is then imported into the VendureConfig:

```
import { VendureConfig } from '@vendure/core';import { AvatarPlugin } from './plugins/avatar-plugin/avatar.plugin';export const config: VendureConfig = {    // ...    plugins: [AvatarPlugin],};
```

The key feature is the @VendurePlugin() decorator, which marks the class as a Vendure plugin and accepts a configuration
object on the type VendurePluginMetadata.

[VendurePluginMetadata](/reference/typescript-api/plugin/vendure-plugin-metadata/)A VendurePlugin is actually an enhanced version of a NestJS Module, and supports
all the metadata properties that NestJS modules support:

[NestJS Module](https://docs.nestjs.com/modules)- imports: Allows importing other NestJS modules in order to make use of their exported providers.
- providers: The providers (services) that will be instantiated by the Nest injector and that may
be shared across this plugin.
- controllers: Controllers allow the plugin to define REST-style endpoints.
- exports: The providers which will be exported from this plugin and made available to other plugins.

Additionally, the VendurePlugin decorator adds the following Vendure-specific properties:

- configuration: A function which can modify the VendureConfig object before the server bootstraps.
- shopApiExtensions: Allows the plugin to extend the GraphQL Shop API with new queries, mutations, resolvers & scalars.
- adminApiExtensions: Allows the plugin to extend the GraphQL Admin API with new queries, mutations, resolvers & scalars.
- entities: Allows the plugin to define new database entities.
- compatibility: Allows the plugin to declare which versions of Vendure it is compatible with.

Since a Vendure plugin is a superset of a NestJS module, this means that many NestJS modules are actually
valid Vendure plugins!

## Plugin lifecycle​


[​](#plugin-lifecycle)Since a VendurePlugin is built on top of the NestJS module system, any plugin (as well as any providers it defines)
can make use of any of the NestJS lifecycle hooks:

[NestJS lifecycle hooks](https://docs.nestjs.com/fundamentals/lifecycle-events)- onModuleInit
- onApplicationBootstrap
- onModuleDestroy
- beforeApplicationShutdown
- onApplicationShutdown

Note that lifecycle hooks are run in both the server and worker contexts.
If you have code that should only run either in the server context or worker context,
you can inject the ProcessContext provider.

[ProcessContext provider](/reference/typescript-api/common/process-context/)
### Configure​


[​](#configure)Another hook that is not strictly a lifecycle hook, but which can be useful to know is the configure method which is
used by NestJS to apply middleware. This method is called only for the server and not for the worker, since middleware relates
to the network stack, and the worker has no network part.

[configure method](https://docs.nestjs.com/middleware#applying-middleware)
```
import { MiddlewareConsumer, NestModule } from '@nestjs/common';import { EventBus, PluginCommonModule, VendurePlugin } from '@vendure/core';import { MyMiddleware } from './api/my-middleware';@VendurePlugin({    imports: [PluginCommonModule]})export class MyPlugin implements NestModule {  configure(consumer: MiddlewareConsumer) {    consumer      .apply(MyMiddleware)      .forRoutes('my-custom-route');  }}
```

## Create a Plugin via CLI​


[​](#create-a-plugin-via-cli)Run the npx vendure add command, and select "Create a new Vendure plugin".

This will guide you through the creation of a new plugin and automate all aspects of the process.

This is the recommended way of creating a new plugin.

[Vendure CLI](/guides/developer-guide/cli/)
## Writing a plugin from scratch​


[​](#writing-a-plugin-from-scratch)Although the Vendure CLI is the recommended way to create a new plugin, it can be useful to understand the process of creating
a plugin manually.

[Vendure CLI](/guides/developer-guide/cli/)Vendure plugins are used to extend the core functionality of the server. Plugins can be pre-made functionality that you can install via npm, or they can be custom plugins that you write yourself.

For any unit of functionality that you need to add to your project, you'll be creating a Vendure plugin. By convention, plugins are stored in the plugins directory of your project. However, this is not a requirement, and you are free to arrange your plugin files in any way you like.

```
├──src    ├── index.ts    ├── vendure-config.ts    ├── plugins        ├── reviews-plugin        ├── cms-plugin        ├── wishlist-plugin        ├── stock-sync-plugin
```

For a complete working example of a Vendure plugin, see the real-world-vendure Reviews plugin

[real-world-vendure Reviews plugin](https://github.com/vendure-ecommerce/real-world-vendure/tree/master/src/plugins/reviews)You can also use the Vendure CLI to quickly scaffold a new plugin.

[Vendure CLI](/guides/developer-guide/cli)In this guide, we will implement a simple but fully-functional wishlist plugin step-by-step. The goal of this plugin is to allow signed-in customers to add products to a wishlist, and to view and manage their wishlist.

### Step 1: Create the plugin file​


[​](#step-1-create-the-plugin-file)We'll start by creating a new directory to house our plugin, add create the main plugin file:

```
├──src    ├── index.ts    ├── vendure-config.ts    ├── plugins        ├── wishlist-plugin            ├── wishlist.plugin.ts
```

```
import { PluginCommonModule, VendurePlugin } from '@vendure/core';@VendurePlugin({    imports: [PluginCommonModule],})export class WishlistPlugin {}
```

The PluginCommonModule will be required in all plugins that you create. It contains the common services that are exposed by Vendure Core, allowing you to inject them into your plugin's services and resolvers.

### Step 2: Define an entity​


[​](#step-2-define-an-entity)Next we will define a new database entity to store the wishlist items. Vendure uses TypeORM to manage the database schema, and an Entity corresponds to a database table.

[TypeORM](https://typeorm.io/)First let's create the file to house the entity:

```
├── wishlist-plugin    ├── wishlist.plugin.ts    ├── entities        ├── wishlist-item.entity.ts
```

By convention, we'll store the entity definitions in the entities directory of the plugin. Again, this is not a requirement, but it is a good way to keep your plugin organized.

```
import { DeepPartial, ID, ProductVariant, VendureEntity, EntityId } from '@vendure/core';import { Entity, ManyToOne } from 'typeorm';@Entity()export class WishlistItem extends VendureEntity {    constructor(input?: DeepPartial<WishlistItem>) {        super(input);    }    @ManyToOne(type => ProductVariant)    productVariant: ProductVariant;    @EntityId()    productVariantId: ID;}
```

Let's break down what's happening here:

- The WishlistItem entity extends the VendureEntity class. This is a base class which provides the id, createdAt and updatedAt fields, and all custom entities should extend it.
- The @Entity() decorator marks this class as a TypeORM entity.
- The @ManyToOne() decorator defines a many-to-one relationship with the ProductVariant entity. This means that each WishlistItem will be associated with a single ProductVariant.
- The productVariantId column is not strictly necessary, but it allows us to always have access to the ID of the related ProductVariant without having to load the entire ProductVariant entity from the database.
- The constructor() is used to create a new instance of the entity. This is not strictly necessary, but it is a good practice to define a constructor which takes a DeepPartial of the entity as an argument. This allows us to create new instances of the entity using the new keyword, passing in a plain object with the desired properties.

[VendureEntity class](/reference/typescript-api/entities/vendure-entity/)Next we need to register this entity with our plugin:

```
import { PluginCommonModule, VendurePlugin } from '@vendure/core';import { WishlistItem } from './entities/wishlist-item.entity';@VendurePlugin({    imports: [PluginCommonModule],    entities: [WishlistItem],})export class WishlistPlugin {}
```

### Step 3: Add a custom field to the Customer entity​


[​](#step-3-add-a-custom-field-to-the-customer-entity)We'll now define a new custom field on the Customer entity which will store a list of WishlistItems. This will allow us to easily query for all wishlist items associated with a particular customer.

Custom fields are defined in the VendureConfig object, and in a plugin we use the configuration function to modify the config object:

```
import { PluginCommonModule, VendurePlugin } from '@vendure/core';import { WishlistItem } from './entities/wishlist-item.entity';@VendurePlugin({    imports: [PluginCommonModule],    entities: [WishlistItem],    configuration: config => {        config.customFields.Customer.push({            name: 'wishlistItems',            type: 'relation',            list: true,            entity: WishlistItem,            internal: true,        });        return config;    },})export class WishlistPlugin {}
```

In this snippet we are pushing a new custom field definition onto the Customer entity's customFields array, and defining this new field as a list (array) of WishlistItem entities. Internally, this will tell TypeORM to update the database schema to store this new field. We set internal: true to indicate that this field should not be directly exposed to the GraphQL API as Customer.customFields.wishlistItems, but instead should be accessed via a custom resolver we will define later.

In order to make use of this custom field in a type-safe way, we can tell TypeScript about this field in a new file:

```
├── wishlist-plugin    ├── wishlist.plugin.ts    ├── types.ts
```

```
import { WishlistItem } from './entities/wishlist-item.entity';declare module '@vendure/core/dist/entity/custom-entity-fields' {  interface CustomCustomerFields {    wishlistItems: WishlistItem[];  }}
```

We can then import this types file in our plugin's main file:

```
import './types';
```

Custom fields are not solely restricted to Vendure's native entities though, it's also possible to add support for custom fields to your own custom entities. This way other plugins would be able to extend our example WishlistItem. See: Supporting custom fields

[Supporting custom fields](/guides/developer-guide/database-entity/#supporting-custom-fields)
### Step 4: Create a service​


[​](#step-4-create-a-service)A "service" is a class which houses the bulk of the business logic of any plugin. A plugin can define multiple services if needed, but each service should be responsible for a single unit of functionality, such as dealing with a particular entity, or performing a particular task.

Let's create a service to handle the wishlist functionality:

```
├── wishlist-plugin    ├── wishlist.plugin.ts    ├── services        ├── wishlist.service.ts
```

```
import { Injectable } from '@nestjs/common';import {    Customer,    ForbiddenError,    ID,    InternalServerError,    ProductVariantService,    RequestContext,    TransactionalConnection,    UserInputError,} from '@vendure/core';import { WishlistItem } from '../entities/wishlist-item.entity';@Injectable()export class WishlistService {    constructor(        private connection: TransactionalConnection,        private productVariantService: ProductVariantService,    ) {}    async getWishlistItems(ctx: RequestContext): Promise<WishlistItem[]> {        try {            const customer = await this.getCustomerWithWishlistItems(ctx);            return customer.customFields.wishlistItems;        } catch (err: any) {            return [];        }    }    /**     * Adds a new item to the active Customer's wishlist.     */    async addItem(ctx: RequestContext, variantId: ID): Promise<WishlistItem[]> {        const customer = await this.getCustomerWithWishlistItems(ctx);        const variant = await this.productVariantService.findOne(ctx, variantId);        if (!variant) {            throw new UserInputError(`No ProductVariant with the id ${variantId} could be found`);        }        const existingItem = customer.customFields.wishlistItems.find(i => i.productVariantId === variantId);        if (existingItem) {            // Item already exists in wishlist, do not            // add it again            return customer.customFields.wishlistItems;        }        const wishlistItem = await this.connection            .getRepository(ctx, WishlistItem)            .save(new WishlistItem({ productVariantId: variantId }));        customer.customFields.wishlistItems.push(wishlistItem);        await this.connection.getRepository(ctx, Customer).save(customer, { reload: false });        return this.getWishlistItems(ctx);    }    /**     * Removes an item from the active Customer's wishlist.     */    async removeItem(ctx: RequestContext, itemId: ID): Promise<WishlistItem[]> {        const customer = await this.getCustomerWithWishlistItems(ctx);        const itemToRemove = customer.customFields.wishlistItems.find(i => i.id === itemId);        if (itemToRemove) {            await this.connection.getRepository(ctx, WishlistItem).remove(itemToRemove);            customer.customFields.wishlistItems = customer.customFields.wishlistItems.filter(                i => i.id !== itemId,            );        }        await this.connection.getRepository(ctx, Customer).save(customer);        return this.getWishlistItems(ctx);    }    /**     * Gets the active Customer from the context and loads the wishlist items.     */    private async getCustomerWithWishlistItems(ctx: RequestContext): Promise<Customer> {        if (!ctx.activeUserId) {            throw new ForbiddenError();        }        const customer = await this.connection.getRepository(ctx, Customer).findOne({            where: { user: { id: ctx.activeUserId } },            relations: {                customFields: {                    wishlistItems: {                        productVariant: true,                    },                },            },        });        if (!customer) {            throw new InternalServerError(`Customer was not found`);        }        return customer;    }}
```

Let's break down what's happening here:

- The WishlistService class is decorated with the @Injectable() decorator. This is a standard NestJS decorator which tells the NestJS dependency injection (DI) system that this class can be injected into other classes. All your services should be decorated with this decorator.
- The arguments passed to the constructor will be injected by the NestJS DI system. The connection argument is a TransactionalConnection instance, which is used to access and manipulate data in the database. The ProductVariantService argument is a built-in Vendure service which contains methods relating to ProductVariants.
- The RequestContext object is usually the first argument to any service method, and contains information and context about the current request as well as any open database transactions. It should always be passed to the methods of the TransactionalConnection.

[TransactionalConnection](/reference/typescript-api/data-access/transactional-connection/)[ProductVariantService](/reference/typescript-api/services/product-variant-service/)[RequestContext](/reference/typescript-api/request/request-context/)The service is then registered with the plugin metadata as a provider:

```
import { PluginCommonModule, VendurePlugin } from '@vendure/core';import { WishlistService } from './services/wishlist.service';@VendurePlugin({    imports: [PluginCommonModule],    providers: [WishlistService],    entities: [WishlistItem],    configuration: config => {        // ...    },})export class WishlistPlugin {}
```

### Step 5: Extend the GraphQL API​


[​](#step-5-extend-the-graphql-api)This plugin will need to extend the Shop API, adding new mutations and queries to enable the customer to view and manage their wishlist.

First we will create a new file to hold the GraphQL schema extensions:

```
├── wishlist-plugin    ├── wishlist.plugin.ts    ├── api        ├── api-extensions.ts
```

```
import gql from 'graphql-tag';export const shopApiExtensions = gql`    type WishlistItem implements Node {        id: ID!        createdAt: DateTime!        updatedAt: DateTime!        productVariant: ProductVariant!        productVariantId: ID!    }    extend type Query {        activeCustomerWishlist: [WishlistItem!]!    }    extend type Mutation {        addToWishlist(productVariantId: ID!): [WishlistItem!]!        removeFromWishlist(itemId: ID!): [WishlistItem!]!    }`;
```

The graphql-tag package is a dependency of the Vendure core package. Depending on the package manager you are using, you may need to install it separately with yarn add graphql-tag or npm install graphql-tag.

The api-extensions.ts file is where we define the extensions we will be making to the Shop API GraphQL schema. We are defining a new WishlistItem type; a new query: activeCustomerWishlist; and two new mutations: addToWishlist and removeFromWishlist. This definition is written in schema definition language (SDL), a convenient syntax for defining GraphQL schemas.

[schema definition language](https://graphql.org/learn/schema/)Next we need to pass these extensions to our plugin's metadata:

```
import { PluginCommonModule, VendurePlugin } from '@vendure/core';import { shopApiExtensions } from './api/api-extensions';@VendurePlugin({    imports: [PluginCommonModule],    shopApiExtensions: {        schema: shopApiExtensions,        resolvers: [],    },})export class WishlistPlugin {}
```

### Step 6: Create a resolver​


[​](#step-6-create-a-resolver)Now that we have defined the GraphQL schema extensions, we need to create a resolver to handle the new queries and mutations. A resolver in GraphQL is a function which actually implements the query or mutation defined in the schema. This is done by creating a new file in the api directory:

```
├── wishlist-plugin    ├── wishlist.plugin.ts    ├── api        ├── api-extensions.ts        ├── wishlist.resolver.ts
```

```
import { Args, Mutation, Query, Resolver } from '@nestjs/graphql';import { Allow, Ctx, Permission, RequestContext, Transaction } from '@vendure/core';import { WishlistService } from '../services/wishlist.service';@Resolver()export class WishlistShopResolver {    constructor(private wishlistService: WishlistService) {}    @Query()    @Allow(Permission.Owner)    async activeCustomerWishlist(@Ctx() ctx: RequestContext) {        return this.wishlistService.getWishlistItems(ctx);    }    @Mutation()    @Transaction()    @Allow(Permission.Owner)    async addToWishlist(        @Ctx() ctx: RequestContext,        @Args() { productVariantId }: { productVariantId: string },    ) {        return this.wishlistService.addItem(ctx, productVariantId);    }    @Mutation()    @Transaction()    @Allow(Permission.Owner)    async removeFromWishlist(@Ctx() ctx: RequestContext, @Args() { itemId }: { itemId: string }) {        return this.wishlistService.removeItem(ctx, itemId);    }}
```

Resolvers are usually "thin" functions that delegate the actual work to a service. Vendure, like NestJS itself, makes heavy use of decorators at the API layer to define various aspects of the resolver. Let's break down what's happening here:

- The @Resolver() decorator tells the NestJS DI system that this class is a resolver. Since a Resolver is part of the NestJS DI system, we can also inject dependencies into its constructor. In this case we are injecting the WishlistService which we created in the previous step.
- The @Mutation() decorator tells Vendure that this is a mutation resolver. Similarly, @Query() decorator defines a query resolver. The name of the method is the name of the query or mutation in the schema.
- The @Transaction() decorator tells Vendure that this resolver method should be wrapped in a database transaction. This is important because we are performing multiple database operations in this method, and we want them to be atomic.
- The @Allow() decorator tells Vendure that this mutation is only allowed for users with the Owner permission. The Owner permission is a special permission which indicates that the active user should be the owner of this operation.
- The @Ctx() decorator tells Vendure that this method requires access to the RequestContext object. Every resolver should have this as the first argument, as it is required throughout the Vendure request lifecycle.

This resolver is then registered with the plugin metadata:

```
import { PluginCommonModule, VendurePlugin } from '@vendure/core';import { shopApiExtensions } from './api/api-extensions';import { WishlistShopResolver } from './api/wishlist.resolver';@VendurePlugin({    imports: [PluginCommonModule],    shopApiExtensions: {        schema: shopApiExtensions,        resolvers: [WishlistShopResolver],    },    configuration: config => {        // ...    },})export class WishlistPlugin {}
```

More information about resolvers can be found in the NestJS docs.

[NestJS docs](https://docs.nestjs.com/graphql/resolvers)
### Step 7: Specify compatibility​


[​](#step-7-specify-compatibility)Since Vendure v2.0.0, it is possible for a plugin to specify which versions of Vendure core it is compatible with. This is especially important if the plugin is intended to be made publicly available via npm or another package registry.

The compatibility is specified via the compatibility property in the plugin metadata:

```
@VendurePlugin({    // ...    compatibility: '^2.0.0',})export class WishlistPlugin {}
```

The value of this property is a semver range which specifies the range of compatible versions. In this case, we are saying that this plugin is compatible with any version of Vendure core which is >= 2.0.0 < 3.0.0.

[semver range](https://docs.npmjs.com/about-semantic-versioning)
### Step 8: Add the plugin to the VendureConfig​


[​](#step-8-add-the-plugin-to-the-vendureconfig)The final step is to add the plugin to the VendureConfig object. This is done in the vendure-config.ts file:

```
import { VendureConfig } from '@vendure/core';import { WishlistPlugin } from './plugins/wishlist-plugin/wishlist.plugin';export const config: VendureConfig = {    // ...    plugins: [        // ...        WishlistPlugin,    ],};
```

### Test the Plugin​


[​](#test-the-plugin)Now that the plugin is installed, we can test it out. Since we have defined a custom field, we'll need to generate and run a migration to add the new column to the database.

- Generate the Migration File
Run the following command to generate a migration file for the wishlist-plugin:
npx vendure migrate wishlist-plugin

Generate the Migration File

Run the following command to generate a migration file for the wishlist-plugin:

```
npx vendure migrate wishlist-plugin
```

When prompted, select the "Generate a new migration" option. This will create a new migration file in the src/migrations folder.

- Run the Migration

After generating the migration file, apply the changes to the database by running the same command again:

```
npx vendure migrate wishlist-plugin
```

Then start the server:

```
npm run dev
```

Once the server is running, we should be able to log in as an existing Customer, and then add a product to the wishlist:

- Login mutation
- Response

```
mutation Login {    login(username: "alec.breitenberg@gmail.com", password: "test") {        ... on CurrentUser {            id            identifier        }        ... on ErrorResult {            errorCode            message        }    }}
```

```
{  "data": {    "login": {      "id": "9",      "identifier": "alec.breitenberg@gmail.com"    }  }}
```

- AddToWishlist mutation
- Response

```
mutation AddToWishlist {    addToWishlist(productVariantId: "7") {        id        productVariant {            id            name        }    }}
```

```
{  "data": {    "addToWishlist": [      {        "id": "4",        "productVariant": {          "id": "7",          "name": "Wireless Optical Mouse"        }      }    ]  }}
```

We can then query the wishlist items:

- GetWishlist query
- Response

```
query GetWishlist {    activeCustomerWishlist {        id        productVariant {            id            name        }    }}
```

```
{  "data": {    "activeCustomerWishlist": [      {        "id": "4",        "productVariant": {          "id": "7",          "name": "Wireless Optical Mouse"        }      }    ]  }}
```

And finally, we can test removing an item from the wishlist:

- RemoveFromWishlist mutation
- Response

```
mutation RemoveFromWishlist {    removeFromWishlist(itemId: "4") {        id        productVariant {            id            name        }    }}
```

```
{  "data": {    "removeFromWishlist": []  }}
```

## Publishing plugins​


[​](#publishing-plugins)If you have created a plugin that you would like to share with the community, you can publish it to npm, and even
have it listed on the Vendure Hub.

[Vendure Hub](https://vendure.io/hub)For a full guide to publishing plugins, see the Publishing a Plugin how-to guide.

[Publishing a Plugin how-to guide](/guides/how-to/publish-plugin/)


---

# Security


Security of your Vendure application includes considering how to prevent and protect against common security threats such as:

- Data breaches
- Unauthorized access
- Attacks aimed at disrupting the service

Vendure itself is designed with security in mind, but you must also consider the security of your own application code, the server environment, and the network architecture.

## Basics​


[​](#basics)Here are some basic measures you should use to secure your Vendure application. These are not exhaustive, but they are a good starting point.

### Change the default credentials​


[​](#change-the-default-credentials)Do not deploy any public Vendure instance with the default superadmin credentials (superadmin:superadmin). Use your hosting platform's environment variables to set a strong password for the Superadmin account.

```
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {  authOptions: {    tokenMethod: ['bearer', 'cookie'],    superadminCredentials: {      identifier: process.env.SUPERADMIN_USERNAME,      password: process.env.SUPERADMIN_PASSWORD,    },  },  // ...};
```

### Use the HardenPlugin​


[​](#use-the-hardenplugin)It is recommended that you install and configure the HardenPlugin for all production deployments. This plugin locks down your schema
(disabling introspection and field suggestions) and protects your Shop API against malicious queries that could otherwise overwhelm your server.

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
### Harden the AssetServerPlugin​


[​](#harden-the-assetserverplugin)If you are using the AssetServerPlugin, it is possible by default to use the dynamic
image transform feature to overload the server with requests for new image sizes & formats. To prevent this, you can
configure the plugin to only allow transformations for the preset sizes, and limited quality levels and formats.
Since v3.1 we ship the PresetOnlyStrategy for this purpose, and
you can also create your own strategies.

[AssetServerPlugin](/reference/core-plugins/asset-server-plugin/)[PresetOnlyStrategy](/reference/core-plugins/asset-server-plugin/preset-only-strategy/)
```
import { VendureConfig } from '@vendure/core';import { AssetServerPlugin, PresetOnlyStrategy } from '@vendure/asset-server-plugin';export const config: VendureConfig = {  // ...  plugins: [    AssetServerPlugin.init({      // ...      imageTransformStrategy: new PresetOnlyStrategy({        defaultPreset: 'large',        permittedQuality: [0, 50, 75, 85, 95],        permittedFormats: ['jpg', 'webp', 'avif'],        allowFocalPoint: false,      }),    }),  ]};
```

## OWASP Top Ten Security Assessment​


[​](#owasp-top-ten-security-assessment)The Open Worldwide Application Security Project (OWASP) is a nonprofit foundation that works to improve the security of software.

It publishes a top 10 list of common web application vulnerabilities: https://owasp.org/Top10

[https://owasp.org/Top10](https://owasp.org/Top10)This section assesses Vendure against this list, stating what is covered out of the box (built in to the framework or easily configurable) and what needs to be additionally considered.

### 1. Broken Access Control​


[​](#1-broken-access-control)Reference: https://owasp.org/Top10/A01_2021-Broken_Access_Control/

[https://owasp.org/Top10/A01_2021-Broken_Access_Control/](https://owasp.org/Top10/A01_2021-Broken_Access_Control/)Out of the box:

- Vendure uses role-based access control
- We deny by default for non-public API requests
- Built-in CORS controls for session cookies
- Directory listing is not possible via default configuration (e.g. exposing web root dir contents)
- Stateful session identifiers should be invalidated on the server after logout. On logout we delete all session records from the DB & session cache.

To consider:

- Rate limit API and controller access to minimize the harm from automated attack tooling.

### 2. Cryptographic Failures​


[​](#2-cryptographic-failures)Reference: https://owasp.org/Top10/A02_2021-Cryptographic_Failures/

[https://owasp.org/Top10/A02_2021-Cryptographic_Failures/](https://owasp.org/Top10/A02_2021-Cryptographic_Failures/)Out of the box:

- Vendure defaults to bcrypt with 12 salt rounds for storing passwords. This strategy is configurable if security requirements mandate alternative algorithms.
- No deprecated hash functions (SHA1, MD5) are used in security-related contexts (only for things like creating cache keys).
- Payment information is not stored in Vendure by default. Payment integrations rely on the payment provider to store all sensitive data.

To consider:

- The Vendure server will not use TLS be default. The usual configuration is to handle this at the gateway level on your production platform.
- If a network caching layer is used (e.g. Stellate), ensure it is configured to not cache user-related data (customer details, active order etc)

### 3. Injection​


[​](#3-injection)Reference: https://owasp.org/Top10/A03_2021-Injection/

[https://owasp.org/Top10/A03_2021-Injection/](https://owasp.org/Top10/A03_2021-Injection/)Out of the box:

- GraphQL has built-in validation of incoming data
- All database operations are parameterized - no string concatenation using user-supplied data.
- List queries apply default limits to prevent mass disclosure of records.

To consider:

- If using custom fields, you should consider defining a validation function to prevent bad data from getting into the database.

### 4. Insecure Design​


[​](#4-insecure-design)Reference: https://owasp.org/Top10/A04_2021-Insecure_Design/

[https://owasp.org/Top10/A04_2021-Insecure_Design/](https://owasp.org/Top10/A04_2021-Insecure_Design/)Out of the box:

- Use of established libraries for the critical underlying components: NestJS, TypeORM, Angular.
- End-to-end tests of security-related flows such as authentication, verification, and RBAC permissions controls.
- Harden plugin provides pre-configured protections against common attack vectors targeting GraphQL APIs.

To consider:

- Tiered exposure such as an API gateway which prevents exposure of the Admin API to the public internet.
- Limit resource usage of Vendure server & worker instances via containerization.
- Rate limiting & other network-level protections (such as Cloudflare) should be considered.

### 5. Security Misconfiguration​


[​](#5-security-misconfiguration)Reference: https://owasp.org/Top10/A05_2021-Security_Misconfiguration/

[https://owasp.org/Top10/A05_2021-Security_Misconfiguration/](https://owasp.org/Top10/A05_2021-Security_Misconfiguration/)Out of the box:

- Single point of configuration for the entire application, reducing the chance of misconfiguration.
- A default setup only requires a database, which means there are few components to configure and harden.
- Stack traces are not leaked in API errors

To consider:

- Ensure the default superadmin credentials are not used in production
- Use environment variables to turn off development features such as the GraphQL playground
- Use the HardenPlugin in production to automatically turn of development features and restrict system information leaking via API.
- Use fine-grained permissions and roles for your administrator accounts to reduce the attack surface if an account is compromised.

### 6. Vulnerable and Outdated Components​


[​](#6-vulnerable-and-outdated-components)Reference: https://owasp.org/Top10/A06_2021-Vulnerable_and_Outdated_Components/

[https://owasp.org/Top10/A06_2021-Vulnerable_and_Outdated_Components/](https://owasp.org/Top10/A06_2021-Vulnerable_and_Outdated_Components/)Out of the box:

- All dependencies are updated to current versions with each minor release
- Modular design limits the number of dependencies for core packages.
- Automated code & dependency scanning is used in the Vendure repo

To consider:

- Run your own audits on your code base.
- Use version override mechanisms if needed to patch and critical Vendure dependencies that did not yet get updated.

### 7. Identification and Authentication Failures​


[​](#7-identification-and-authentication-failures)Reference: https://owasp.org/Top10/A07_2021-Identification_and_Authentication_Failures/

[https://owasp.org/Top10/A07_2021-Identification_and_Authentication_Failures/](https://owasp.org/Top10/A07_2021-Identification_and_Authentication_Failures/)Out of the box:

- Valid usernames are not leaked via mechanisms such as account reset
- Does not permit "knowlege-based" account recovery
- Uses strong password hashing (bcrypt with 12 salt rounds)
- Session identifiers are not exposed in API urls (instead we use headers/cookies)
- New session tokens always regenerated after successful login
- Sessions deleted during logout
- Cryptographically-strong, high-entropy session tokens are used (crypto.randomBytes API)

To consider:

- Implementing a multi-factor authentication flow
- Do not use default superadmin credentials in production
- Implementing a custom PasswordValidationStrategy to disallow weak/common passwords
- Subscribe to AttemptedLoginEvent to implement detection of brute-force attacks

### 8. Software and Data Integrity Failures​


[​](#8-software-and-data-integrity-failures)Reference: https://owasp.org/Top10/A08_2021-Software_and_Data_Integrity_Failures/

[https://owasp.org/Top10/A08_2021-Software_and_Data_Integrity_Failures/](https://owasp.org/Top10/A08_2021-Software_and_Data_Integrity_Failures/)To consider:

- Exercise caution when introducing new dependencies to your project.
- Do not use untrusted Vendure plugins. Where possible review the code prior to use.
- Exercise caution if using auto-updating mechanisms for dependencies.
- If storing serialized data in custom fields, implement validation to prevent untrusted data getting into the database.
- Evaluate your CI/CD pipeline against the OWASP recommendations for this point

### 9. Security Logging and Monitoring Failures​


[​](#9-security-logging-and-monitoring-failures)Reference: https://owasp.org/Top10/A09_2021-Security_Logging_and_Monitoring_Failures/

[https://owasp.org/Top10/A09_2021-Security_Logging_and_Monitoring_Failures/](https://owasp.org/Top10/A09_2021-Security_Logging_and_Monitoring_Failures/)Out of the box:

- APIs for integrating logging & monitoring tools & services, e.g. configurable Logger interface & ErrorHandlerStrategy
- Official Sentry integration for application performance monitoring

To consider:

- Integrate with dedicated logging tools for improved log management
- Integrate with monitoring tools such as Sentry
- Use the EventBus to monitor events such as repeated failed login attempts and high-value orders

### 10. Server-Side Request Forgery (SSRF)​


[​](#10-server-side-request-forgery-ssrf)Reference: https://owasp.org/Top10/A10_2021-Server-Side_Request_Forgery_(SSRF)/

[https://owasp.org/Top10/A10_2021-Server-Side_Request_Forgery_(SSRF)/](https://owasp.org/Top10/A10_2021-Server-Side_Request_Forgery_%28SSRF%29/)Out of the box:

- By default Vendure does not rely on requests to remote servers for core functionality

To consider:

- Review the OWASP recommendations against your network architecture


---

# Strategies & Configurable Operations


Vendure is built to be highly configurable and extensible. Two methods of providing this extensibility are strategies and configurable operations.

## Strategies​


[​](#strategies)A strategy is named after the Strategy Pattern, and is a way of providing
a pluggable implementation of a particular feature. Vendure makes heavy use of this pattern to delegate the implementation
of key points of extensibility to the developer.

[Strategy Pattern](https://en.wikipedia.org/wiki/Strategy_pattern)Examples of strategies include:

- OrderCodeStrategy - determines how order codes are generated
- StockLocationStrategy - determines which stock locations are used to fulfill an order
- ActiveOrderStrategy - determines how the active order in the Shop API is selected
- AssetStorageStrategy - determines where uploaded assets are stored
- GuestCheckoutStrategy - defines rules relating to guest checkouts
- OrderItemPriceCalculationStrategy - determines how items are priced when added to the order
- TaxLineCalculationStrategy - determines how tax is calculated for an order line

[OrderCodeStrategy](/reference/typescript-api/orders/order-code-strategy/)[StockLocationStrategy](/reference/typescript-api/products-stock/stock-location-strategy/)[ActiveOrderStrategy](/reference/typescript-api/orders/active-order-strategy/)[AssetStorageStrategy](/reference/typescript-api/assets/asset-storage-strategy/)[GuestCheckoutStrategy](/reference/typescript-api/orders/guest-checkout-strategy/)[OrderItemPriceCalculationStrategy](/reference/typescript-api/orders/order-item-price-calculation-strategy/)[TaxLineCalculationStrategy](/reference/typescript-api/tax/tax-line-calculation-strategy/)As an example, let's take the OrderCodeStrategy. This strategy
determines how codes are generated when new orders are created. By default, Vendure will use the built-in DefaultOrderCodeStrategy
which generates a random 16-character string.

[OrderCodeStrategy](/reference/typescript-api/orders/order-code-strategy/)What if you need to change this behavior? For instance, you might have an existing back-office system that is responsible
for generating order codes, which you need to integrate with. Here's how you would do this:

```
import { OrderCodeStrategy, RequestContext } from '@vendure/core';import { OrderCodeService } from '../services/order-code.service';export class MyOrderCodeStrategy implements OrderCodeStrategy {    private orderCodeService: OrderCodeService;    init(injector) {        this.orderCodeService = injector.get(OrderCodeService);    }    async generate(ctx: RequestContext): string {        return this.orderCodeService.getNewOrderCode();    }}
```

All strategies can make use of existing services by using the init() method. This is because all strategies
extend the underlying InjectableStrategy interface. In
this example we are assuming that we already created an OrderCodeService which contains all the specific logic for
connecting to our backend service which generates the order codes.

[InjectableStrategy interface](/reference/typescript-api/common/injectable-strategy)We then need to pass this custom strategy to our config:

```
import { VendureConfig } from '@vendure/core';import { MyOrderCodeStrategy } from '../config/my-order-code-strategy';export const config: VendureConfig = {    // ...    orderOptions: {        orderCodeStrategy: new MyOrderCodeStrategy(),    },}
```

### Strategy lifecycle​


[​](#strategy-lifecycle)Strategies can use two optional lifecycle methods:

- init(injector: Injector) - called during the bootstrap phase when the server or worker is starting up.
This is where you can inject any services which you need to use in the strategy. You can also perform any other setup logic
needed, such as instantiating a connection to an external service.
- destroy() - called during the shutdown of the server or worker. This is where you can perform any cleanup logic, such as
closing connections to external services.

### Passing options to a strategy​


[​](#passing-options-to-a-strategy)Sometimes you might want to pass some configuration options to a strategy.
For example, imagine you want to create a custom StockLocationStrategy which
selects a location within a given proximity to the customer's address. You might want to pass the maximum distance to the strategy
in your config:

[StockLocationStrategy](/reference/typescript-api/products-stock/stock-location-strategy/)
```
import { VendureConfig } from '@vendure/core';import { MyStockLocationStrategy } from '../config/my-stock-location-strategy';export const config: VendureConfig = {    // ...    catalogOptions: {        stockLocationStrategy: new MyStockLocationStrategy({ maxDistance: 100 }),    },}
```

This config will be passed to the strategy's constructor:

```
import  { ID, ProductVariant, RequestContext, StockLevel, StockLocationStrategy } from '@vendure/core';export class MyStockLocationStrategy implements StockLocationStrategy {    constructor(private options: { maxDistance: number }) {}    getAvailableStock(        ctx: RequestContext,        productVariantId: ID,        stockLevels: StockLevel[]    ): ProductVariant[] {        const maxDistance = this.options.maxDistance;        // ... implementation omitted    }}
```

## Configurable Operations​


[​](#configurable-operations)Configurable operations are similar to strategies in that they allow certain aspects of the system to be customized. However,
the main difference is that they can also be configured via the Dashboard. This allows the store owner to make changes to the
behavior of the system without having to restart the server.

So they are typically used to supply some custom logic that needs to accept configurable arguments which can change
at runtime.

Vendure uses the following configurable operations:

- CollectionFilter - determines which products are included in a collection
- PaymentMethodHandler - determines how payments are processed
- PromotionCondition - determines whether a promotion is applicable
- PromotionAction - determines what happens when a promotion is applied
- ShippingEligibilityChecker - determines whether a shipping method is available
- ShippingCalculator - determines how shipping costs are calculated

[CollectionFilter](/reference/typescript-api/configuration/collection-filter/)[PaymentMethodHandler](/reference/typescript-api/payment/payment-method-handler/)[PromotionCondition](/reference/typescript-api/promotions/promotion-condition/)[PromotionAction](/reference/typescript-api/promotions/promotion-action/)[ShippingEligibilityChecker](/reference/typescript-api/shipping/shipping-eligibility-checker/)[ShippingCalculator](/reference/typescript-api/shipping/shipping-calculator/)Whereas strategies are typically used to provide a single implementation of a particular feature, configurable operations
are used to provide a set of implementations which can be selected from at runtime.

For example, Vendure ships with a set of default CollectionFilters:

```
export const defaultCollectionFilters = [    facetValueCollectionFilter,    variantNameCollectionFilter,    variantIdCollectionFilter,    productIdCollectionFilter,];
```

When setting up a Collection, you can choose from these available default filters:

When one is selected, the UI will allow you to configure the arguments for that filter:

Let's take a look at a simplified implementation of the variantNameCollectionFilter:

```
import { CollectionFilter, LanguageCode } from '@vendure/core';export const variantNameCollectionFilter = new CollectionFilter({    args: {        operator: {            type: 'string',            ui: {                component: 'select-form-input',                options: [                    { value: 'startsWith' },                    { value: 'endsWith' },                    { value: 'contains' },                    { value: 'doesNotContain' },                ],            },        },        term: { type: 'string' },    },    code: 'variant-name-filter',    description: [{ languageCode: LanguageCode.en, value: 'Filter by product variant name' }],    apply: (qb, args) => {        // ... implementation omitted    },});
```

Here are the important parts:

- Configurable operations are instances of a pre-defined class, and are instantiated before being passed to your config.
- They must have a code property which is a unique string identifier.
- They must have a description property which is a localizable, human-readable description of the operation.
- They must have an args property which defines the arguments which can be configured via the Dashboard. If the operation has no arguments,
then this would be an empty object.
- They will have one or more methods that need to be implemented, depending on the type of operation. In this case, the apply() method
is used to apply the filter to the query builder.

### Configurable operation args​


[​](#configurable-operation-args)The args property is an object which defines the arguments which can be configured via the Dashboard. Each property of the args
object is a key-value pair, where the key is the name of the argument, and the value is an object which defines the type of the argument
and any additional configuration.

As an example let's look at the dummyPaymentMethodHandler, a test payment method which we ship with Vendure core:

```
import { PaymentMethodHandler, LanguageCode } from '@vendure/core';export const dummyPaymentHandler = new PaymentMethodHandler({    code: 'dummy-payment-handler',    description: [/* omitted for brevity */],    args: {        automaticSettle: {            type: 'boolean',            label: [                {                    languageCode: LanguageCode.en,                    value: 'Authorize and settle in 1 step',                },            ],            description: [                {                    languageCode: LanguageCode.en,                    value: 'If enabled, Payments will be created in the "Settled" state.',                },            ],            required: true,            defaultValue: false,        },    },    createPayment: async (ctx, order, amount, args, metadata, method) => {        // Inside this method, the `args` argument is type-safe and will be        // an object with the following shape:        // {        //   automaticSettle: boolean        // }        // ... implementation omitted    },})
```

The following properties are used to configure the argument:

#### type​


[​](#type)ConfigArgType

[ConfigArgType](/reference/typescript-api/configurable-operation-def/config-arg-type)The following types are available: string, int, float, boolean, datetime, ID.

#### label​


[​](#label)LocalizedStringArray

[LocalizedStringArray](/reference/typescript-api/configurable-operation-def/localized-string-array/)A human-readable label for the argument. This is used in the Dashboard.

#### description​


[​](#description)LocalizedStringArray

[LocalizedStringArray](/reference/typescript-api/configurable-operation-def/localized-string-array/)A human-readable description for the argument. This is used in the Dashboard as a tooltip.

#### required​


[​](#required)boolean

Whether the argument is required. If true, then the Dashboard will not allow the user to save the configuration
unless a value has been provided for this argument.

#### defaultValue​


[​](#defaultvalue)any (depends on the type)

The default value for the argument. If not provided, then the argument will be undefined by default.

#### list​


[​](#list)boolean

Whether the argument is a list of values. If true, then the Dashboard will allow the user to add multiple values
for this argument. Defaults to false.

#### ui​


[​](#ui)Allows you to specify the UI component that will be used to render the argument in the Dashboard, by specifying
a component property, and optional properties to configure that component.

```
{    args: {        operator: {            type: 'string',            ui: {                component: 'select-form-input',                options: [                    { value: 'startsWith' },                    { value: 'endsWith' },                    { value: 'contains' },                    { value: 'doesNotContain' },                ],            },        },    }}
```

A full description of the available UI components can be found in the Custom Fields guide.

[Custom Fields guide](/guides/developer-guide/custom-fields/#custom-field-ui)
### Injecting dependencies​


[​](#injecting-dependencies)Configurable operations are instantiated before being passed to your config, so the mechanism for injecting dependencies
is similar to that of strategies: namely you use an optional init() method to inject dependencies into the operation instance.

The main difference is that the injected dependency cannot then be stored as a class property, since you are not defining
a class when you define a configurable operation. Instead, you can store the dependency as a closure variable.

Here’s an example of a ShippingCalculator that injects a service which has been defined in a plugin:

```
import { Injector, ShippingCalculator } from '@vendure/core';import { ShippingRatesService } from './shipping-rates.service';// We keep reference to our injected service by keeping it// in the top-level scope of the file.let shippingRatesService: ShippingRatesService;export const customShippingCalculator = new ShippingCalculator({    code: 'custom-shipping-calculator',    description: [],    args: {},    init(injector: Injector) {        // The init function is called during bootstrap, and allows        // us to inject any providers we need.        shippingRatesService = injector.get(ShippingRatesService);    },    calculate: async (order, args) => {        // We can now use the injected provider in the business logic.        const { price, priceWithTax } = await shippingRatesService.getRate({            destination: order.shippingAddress,            contents: order.lines,        });        return {            price,            priceWithTax,        };    },});
```


---

# Testing


Vendure plugins allow you to extend all aspects of the standard Vendure server. When a plugin gets somewhat complex (defining new entities, extending the GraphQL schema, implementing custom resolvers), you may wish to create automated tests to ensure your plugin is correct.

The @vendure/testing package gives you some simple but powerful tooling for creating end-to-end tests for your custom Vendure code.

By "end-to-end" we mean we are testing the entire server stack - from API, to services, to database - by making a real API request, and then making assertions about the response. This is a very effective way to ensure that all parts of your plugin are working correctly together.

For a working example of a Vendure plugin with e2e testing, see the real-world-vendure Reviews plugin

[real-world-vendure Reviews plugin](https://github.com/vendure-ecommerce/real-world-vendure/tree/master/src/plugins/reviews)
## Usage​


[​](#usage)
### Install dependencies​


[​](#install-dependencies)- @vendure/testing
- vitest You'll need to install a testing framework. In this example, we will use Vitest as it has very good support for the modern JavaScript features that Vendure uses, and is very fast.
- graphql-tag This is not strictly required but makes it much easier to create the DocumentNodes needed to query your server.
- We also need to install some packages to allow us to compile TypeScript code that uses decorators:

@swc/core
unplugin-swc
- @swc/core
- unplugin-swc

[@vendure/testing](https://www.npmjs.com/package/@vendure/testing)[vitest](https://vitest.dev/)[Vitest](https://vitest.dev/)[graphql-tag](https://www.npmjs.com/package/graphql-tag)- @swc/core
- unplugin-swc

```
npm install --save-dev @vendure/testing vitest graphql-tag @swc/core unplugin-swc
```

### Configure Vitest​


[​](#configure-vitest)Create a vitest.config.mts file in the root of your project:

```
import path from 'path';import swc from 'unplugin-swc';import { defineConfig } from 'vitest/config';export default defineConfig({    test: {        include: ['**/*.e2e-spec.ts'],        typecheck: {            tsconfig: path.join(__dirname, 'tsconfig.e2e.json'),        },    },    plugins: [        // SWC required to support decorators used in test plugins        // See https://github.com/vitest-dev/vitest/issues/708#issuecomment-1118628479        // Vite plugin        swc.vite({            jsc: {                transform: {                    // See https://github.com/vendure-ecommerce/vendure/issues/2099                    useDefineForClassFields: false,                },            },        }),    ],});
```

and a tsconfig.e2e.json tsconfig file for the tests:

```
{  "extends": "./tsconfig.json",  "compilerOptions": {    "types": ["node"],    "lib": ["es2015"],    "useDefineForClassFields": false,    "skipLibCheck": true,    "inlineSourceMap": false,    "sourceMap": true,    "allowSyntheticDefaultImports": true,    "experimentalDecorators": true,    "emitDecoratorMetadata": true,    "esModuleInterop": true  }}
```

### Register database-specific initializers​


[​](#register-database-specific-initializers)The @vendure/testing package uses "initializers" to create the test databases and populate them with initial data. We ship with initializers for sqljs, postgres and mysql. Custom initializers can be created to support running e2e tests against other databases supported by TypeORM. See the TestDbInitializer docs for more details.

[TestDbInitializer docs](/reference/typescript-api/testing/test-db-initializer/)
```
import {    MysqlInitializer,    PostgresInitializer,    SqljsInitializer,    registerInitializer,} from '@vendure/testing';const sqliteDataDir = path.join(__dirname, '__data__');registerInitializer('sqljs', new SqljsInitializer(sqliteDataDir));registerInitializer('postgres', new PostgresInitializer());registerInitializer('mysql', new MysqlInitializer());
```

Note re. the sqliteDataDir: The first time this test suite is run with the SqljsInitializer, the populated data will be saved into an SQLite file, stored in the directory specified by this constructor arg. On subsequent runs of the test suite, the data-population step will be skipped and the initial data directly loaded from the SQLite file. This method of caching significantly speeds up the e2e test runs. All the .sqlite files created in the sqliteDataDir can safely be deleted at any time.

### Create a test environment​


[​](#create-a-test-environment)The @vendure/testing package exports a createTestEnvironment function which is used to set up a Vendure server and GraphQL clients to interact with both the Shop and Admin APIs:

[createTestEnvironment function](/reference/typescript-api/testing/create-test-environment/)
```
import { createTestEnvironment, testConfig } from '@vendure/testing';import { describe } from 'vitest';import { MyPlugin } from '../my-plugin.ts';describe('my plugin', () => {    const {server, adminClient, shopClient} = createTestEnvironment({        ...testConfig,        plugins: [MyPlugin],    });});
```

Notice that we pass a VendureConfig object into the createTestEnvironment function. The testing package provides a special testConfig which is pre-configured for e2e tests, but any aspect can be overridden for your tests. Here we are configuring the server to load the plugin under test, MyPlugin.

[VendureConfig](/reference/typescript-api/configuration/vendure-config/)[testConfig](/reference/typescript-api/testing/test-config/)Note: If you need to deeply merge in some custom configuration, use the mergeConfig function which is provided by @vendure/core.

[mergeConfig function](/reference/typescript-api/configuration/merge-config/)
### Initialize the server​


[​](#initialize-the-server)The TestServer needs to be initialized before it can be used. The TestServer.init() method takes an options object which defines how to populate the server:

[TestServer](/reference/typescript-api/testing/test-server/)
```
import { beforeAll, afterAll } from 'vitest';import { myInitialData } from './fixtures/my-initial-data.ts';// ...beforeAll(async () => {    await server.init({        productsCsvPath: path.join(__dirname, 'fixtures/e2e-products.csv'),        initialData: myInitialData,        customerCount: 2,    });    await adminClient.asSuperAdmin();}, 60000);afterAll(async () => {    await server.destroy();});
```

An explanation of the options:

- productsCsvPath This is a path to an optional CSV file containing product data. See Product Import Format. You can see an example used in the Vendure e2e tests to get an idea of how it works. To start with you can just copy this file directly and use it as-is.
- initialData This is an object which defines how other non-product data (Collections, ShippingMethods, Countries etc.) is populated. See Initial Data Format. You can copy this example from the Vendure e2e tests
- customerCount Specifies the number of fake Customers to create. Defaults to 10 if not specified.

[Product Import Format](/guides/developer-guide/importing-data/#product-import-format)[an example used in the Vendure e2e tests](https://github.com/vendure-ecommerce/vendure/blob/master/packages/core/e2e/fixtures/e2e-products-full.csv)[Initial Data Format](/guides/developer-guide/importing-data/#initial-data)[copy this example from the Vendure e2e tests](https://github.com/vendure-ecommerce/vendure/blob/master/e2e-common/e2e-initial-data.ts)
### Write your tests​


[​](#write-your-tests)Now we are all set up to create a test. Let's test one of the GraphQL queries used by our fictional plugin:

```
import gql from 'graphql-tag';import { it, expect, beforeAll, afterAll } from 'vitest';import { myInitialData } from './fixtures/my-initial-data.ts';it('myNewQuery returns the expected result', async () => {    adminClient.asSuperAdmin(); // log in as the SuperAdmin user    const query = gql`    query MyNewQuery($id: ID!) {      myNewQuery(id: $id) {        field1        field2      }    }  `;    const result = await adminClient.query(query, {id: 123});    expect(result.myNewQuery).toEqual({ /* ... */})});
```

Running the test will then assert that your new query works as expected.

### Run your tests​


[​](#run-your-tests)All that's left is to run your tests to find out whether your code behaves as expected!

Note: When using Vitest with multiple test suites (multiple .e2e-spec.ts files), it will attempt to run them in parallel. If all the test servers are running
on the same port (the default in the testConfig is 3050), then this will cause a port conflict. To avoid this, you can manually set a unique port for each test suite. Be aware that mergeConfig is used here:

```
import { createTestEnvironment, testConfig } from '@vendure/testing';import { mergeConfig } from "@vendure/core";import { describe } from 'vitest';import { MyPlugin } from '../my-plugin.ts';describe('my plugin', () => {    const {server, adminClient, shopClient} = createTestEnvironment(mergeConfig(testConfig, {        apiOptions: {            port: 3051,        },        plugins: [MyPlugin],    }));});
```

## Accessing internal services​


[​](#accessing-internal-services)It is possible to access any internal service of the Vendure server via the server.app object, which is an instance of the NestJS INestApplication.

For example, to access the ProductService:

```
import { createTestEnvironment, testConfig } from '@vendure/testing';import { describe, beforeAll } from 'vitest';import { MyPlugin } from '../my-plugin.ts';describe('my plugin', () => {        const { server, adminClient, shopClient } = createTestEnvironment({        ...testConfig,        plugins: [MyPlugin],    });        let productService: ProductService;        beforeAll(async () => {        await server.init({            productsCsvPath: path.join(__dirname, 'fixtures/e2e-products.csv'),            initialData: myInitialData,            customerCount: 2,        });        await adminClient.asSuperAdmin();        productService = server.app.get(ProductService);    }, 60000);});
```


---

# Updating Vendure


This guide provides guidance for updating the Vendure core framework to a newer version.

## How to update​


[​](#how-to-update)First, check the changelog for an overview of the changes and any breaking changes in the next version.

[changelog](https://github.com/vendure-ecommerce/vendure/blob/master/CHANGELOG.md)In your project's package.json file, find all the @vendure/... packages and change the version
to the latest. All the Vendure packages have the same version, and are all released together.

```
{  // ...  "dependencies": {-    "@vendure/common": "1.1.5",+    "@vendure/common": "1.2.0",-    "@vendure/core": "1.1.5",+    "@vendure/core": "1.2.0",     // etc.  }}
```

Then run npm install or yarn install depending on which package manager you prefer.

## Versioning Policy & Breaking changes​


[​](#versioning-policy--breaking-changes)Vendure generally follows the SemVer convention for version numbering. This means that breaking API changes will only be introduced with changes to the major version (the first of the 3 digits in the version).

[SemVer convention](https://semver.org/)However, there are some exceptions to this rule:

- In minor versions, (e.g. v2.0 to v2.1) we may update underlying dependencies to new major versions, which may in turn introduce breaking changes. These will be clearly noted in the changelog.
- In minor versions we may also occasionally introduce non-destructive changes to the database schema. For instance, we may add a new column which would then require a database migration. We will not introduce database schema changes that could potentially result in data loss in a minor version.

Any instances of these exceptions will be clearly indicated in the Changelog. The reasoning for these exceptions is discussed in the Versioning policy RFC.

[Changelog](https://github.com/vendure-ecommerce/vendure/blob/master/CHANGELOG.md)[Versioning policy RFC](https://github.com/vendure-ecommerce/vendure/issues/1846)
### What kinds of breaking changes can be expected?​


[​](#what-kinds-of-breaking-changes-can-be-expected)Major version upgrades (e.g. v1.x to v2.x) can include:

- Changes to the database schema
- Changes to the GraphQL schema
- Updates of major underlying libraries, such as upgrading NestJS to a new major version

Every release will be accompanied by an entry in the changelog, listing the changes in that release. And breaking changes are clearly listed under a BREAKING CHANGE heading.

[changelog](https://github.com/vendure-ecommerce/vendure/blob/master/CHANGELOG.md)
### Database migrations​


[​](#database-migrations)Database changes are one of the most common causes for breaking changes. In most cases, the changes are minor (such as the addition of a new column) and non-destructive (i.e. performing the migration has no risk of data loss).

However, some more fundamental changes occasionally require a careful approach to database migration in order to preserve existing data.

The key rule is never run your production instance with the synchronize option set to true. Doing so can cause inadvertent data loss in rare cases.

For any database schema changes, it is advised to:

- Read the changelog breaking changes entries to see what changes to expect
- Important: Make a backup of your database!
- Create a new database migration as described in the Migrations guide
- Manually check the migration script. In some cases manual action is needed to customize the script in order to correctly migrate your existing data.
- Test the migration script against non-production data.
- Only when you have verified that the migration works as expected, run it against your production database.

[Migrations guide](/guides/developer-guide/migrations/)
### GraphQL schema changes​


[​](#graphql-schema-changes)If you are using a code-generation tool (such as graphql-code-generator) for your custom plugins or storefront, it is a good idea to re-generate after upgrading, which will catch any errors caused by changes to the GraphQL schema.

[graphql-code-generator](https://graphql-code-generator.com/)
### TypeScript API changes​


[​](#typescript-api-changes)If you are using Vendure providers (services, JobQueue, EventBus etc.) in your custom plugins, you should look out for breakages caused by changes to those services. Major changes will be listed in the changelog, but occasionally internal changes may also impact your code.

The best way to check whether this is the case is to build your entire project after upgrading, to see if any new TypeScript compiler errors emerge.

---

# Worker & Job Queue


The Vendure Worker is a Node.js process responsible for running computationally intensive
or otherwise long-running tasks in the background. For example, updating a
search index or sending emails. Running such tasks in the background allows
the server to stay responsive, since a response can be returned immediately
without waiting for the slower tasks to complete.

Put another way, the Worker executes jobs which have been placed in the job queue.

## The worker​


[​](#the-worker)The worker is started by calling the bootstrapWorker() function with the same
configuration as is passed to the main server bootstrap(). In a standard Vendure installation, this is found
in the index-worker.ts file:

[bootstrapWorker()](/reference/typescript-api/worker/bootstrap-worker/)
```
import { bootstrapWorker } from '@vendure/core';import { config } from './vendure-config';bootstrapWorker(config)    .then(worker => worker.startJobQueue())    .catch(err => {        console.log(err);    });
```

### Underlying architecture​


[​](#underlying-architecture)The Worker is a NestJS standalone application. This means it is almost identical to the main server app,
but does not have any network layer listening for requests. The server communicates with the worker
via a “job queue” architecture. The exact implementation of the job queue is dependent on the
configured JobQueueStrategy, but by default
the worker polls the database for new jobs.

[JobQueueStrategy](/reference/typescript-api/job-queue/job-queue-strategy/)
### Multiple workers​


[​](#multiple-workers)It is possible to run multiple workers in parallel to better handle heavy loads. Using the
JobQueueOptions.activeQueues configuration, it is even possible to have particular workers dedicated
to one or more specific types of jobs. For example, if your application does video transcoding,
you might want to set up a dedicated worker just for that task:

[JobQueueOptions.activeQueues](/reference/typescript-api/job-queue/job-queue-options#activequeues)
```
import { bootstrapWorker, mergeConfig } from '@vendure/core';import { config } from './vendure-config';const transcoderConfig = mergeConfig(config, {    jobQueueOptions: {      activeQueues: ['transcode-video'],    }});bootstrapWorker(transcoderConfig)  .then(worker => worker.startJobQueue())  .catch(err => {    console.log(err);  });
```

### Running jobs on the main process​


[​](#running-jobs-on-the-main-process)It is possible to run jobs from the Job Queue on the main server. This is mainly used for testing
and automated tasks, and is not advised for production use, since it negates the benefits of
running long tasks off of the main process. To do so, you need to manually start the JobQueueService:

```
import { bootstrap, JobQueueService } from '@vendure/core';import { config } from './vendure-config';bootstrap(config)    .then(app => app.get(JobQueueService).start())    .catch(err => {        console.log(err);        process.exit(1);    });
```

### ProcessContext​


[​](#processcontext)Sometimes your code may need to be aware of whether it is being run as part of a server or worker process.
In this case you can inject the ProcessContext provider and query it like this:

[ProcessContext](/reference/typescript-api/common/process-context/)
```
import { Injectable, OnApplicationBootstrap } from '@nestjs/common';import { ProcessContext } from '@vendure/core';@Injectable()export class MyService implements OnApplicationBootstrap {    constructor(private processContext: ProcessContext) {}    onApplicationBootstrap() {        if (this.processContext.isServer) {            // code which will only execute when running in            // the server process        }    }}
```

## The job queue​


[​](#the-job-queue)Vendure uses a job queue to handle the processing of certain tasks which are typically too slow to run in the
normal request-response cycle. A normal request-response looks like this:

[job queue](https://en.wikipedia.org/wiki/Job_queue)In the normal request-response, all intermediate tasks (looking up data in the database, performing business logic etc.)
occur before the response can be returned. For most operations this is fine, since those intermediate tasks are very fast.

Some operations however will need to perform much longer-running tasks. For example, updating the search index on
thousands of products could take up to a minute or more. In this case, we certainly don’t want to delay the response
until that processing has completed. That’s where a job queue comes in:

### What does Vendure use the job queue for?​


[​](#what-does-vendure-use-the-job-queue-for)By default, Vendure uses the job queue for the following tasks:

- Re-building the search index
- Updating the search index when changes are made to Products, ProductVariants, Assets etc.
- Updating the contents of Collections
- Sending transactional emails

### How does the Job Queue work?​


[​](#how-does-the-job-queue-work)This diagram illustrates the job queue mechanism:

The server adds jobs to the queue. The worker then picks up these jobs from the queue and processes them in sequence,
one by one (it is possible to increase job queue throughput by running multiple workers or by increasing the concurrency
of a single worker).

### JobQueueStrategy​


[​](#jobqueuestrategy)The actual queue part is defined by the configured JobQueueStrategy.

[JobQueueStrategy](/reference/typescript-api/job-queue/job-queue-strategy/)If no strategy is defined, Vendure uses an in-memory store
of the contents of each queue. While this has the advantage
of requiring no external dependencies, it is not suitable for production because when the server is stopped, the entire
queue will be lost and any pending jobs will never be processed. Moreover, it cannot be used when running the worker
as a separate process.

[in-memory store](/reference/typescript-api/job-queue/in-memory-job-queue-strategy/)A better alternative is to use the DefaultJobQueuePlugin
(which will be used in a standard @vendure/create installation), which configures Vendure to use the SqlJobQueueStrategy.
This strategy uses the database as a queue, and means that even if the Vendure server stops, pending jobs will be persisted and upon re-start, they will be processed.

[DefaultJobQueuePlugin](/reference/typescript-api/job-queue/default-job-queue-plugin/)[SqlJobQueueStrategy](/reference/typescript-api/job-queue/sql-job-queue-strategy)It is also possible to implement your own JobQueueStrategy to take advantage of other technologies.
Examples include RabbitMQ, Google Cloud Pub Sub & Amazon SQS. It may make sense to implement a custom strategy based on
one of these if the default database-based approach does not meet your performance requirements.

### Job Queue Performance​


[​](#job-queue-performance)It is common for larger Vendure projects to define multiple custom job queues, When using the DefaultJobQueuePlugin
with many queues, performance may be impacted. This is because the SqlJobQueueStrategy uses polling to check for
new jobs in the database. Each queue will (by default) query the database every 200ms. So if there are 10 queues,
this will result in a constant 50 queries/second.

[DefaultJobQueuePlugin](/reference/typescript-api/job-queue/default-job-queue-plugin/)In this case it is recommended to try the BullMQJobQueuePlugin,
which uses an efficient push-based strategy built on Redis.

[BullMQJobQueuePlugin](/reference/core-plugins/job-queue-plugin/bull-mqjob-queue-plugin/)
## Using Job Queues in a plugin​


[​](#using-job-queues-in-a-plugin)If your plugin involves long-running tasks, you can also make use of the job queue.

A real example of this can be seen in the EmailPlugin source

[EmailPlugin source](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/plugin.ts)Let's say you are building a plugin which allows a video URL to be specified, and then that video gets transcoded into a format suitable for streaming on the storefront. This is a long-running task which should not block the main thread, so we will use the job queue to run the task on the worker.

First we'll add a new mutation to the Admin API schema:

```
import gql from 'graphql-tag';export const adminApiExtensions = gql`  extend type Mutation {    addVideoToProduct(productId: ID! videoUrl: String!): Job!  }`;
```

The resolver looks like this:

```
import { Args, Mutation, Resolver } from '@nestjs/graphql';import { Allow, Ctx, RequestContext, Permission, RequestContext } from '@vendure/core'import { ProductVideoService } from '../services/product-video.service';@Resolver()export class ProductVideoResolver {    constructor(private productVideoService: ProductVideoService) {}    @Mutation()    @Allow(Permission.UpdateProduct)    addVideoToProduct(@Ctx() ctx: RequestContext, @Args() args: { productId: ID; videoUrl: string; }) {        return this.productVideoService.transcodeForProduct(            args.productId,            args.videoUrl,        );    }}
```

The resolver just defines how to handle the new addVideoToProduct mutation, delegating the actual work to the ProductVideoService.

### Creating a job queue​


[​](#creating-a-job-queue)Use npx vendure add to easily add a job queue to a service.

[Vendure CLI](/guides/developer-guide/cli/)The JobQueueService creates and manages job queues. The queue is created when the
application starts up (see NestJS lifecycle events), and then we can use the add() method to add jobs to the queue.

[JobQueueService](/reference/typescript-api/job-queue/job-queue-service/)[NestJS lifecycle events](https://docs.nestjs.com/fundamentals/lifecycle-events)
```
import { Injectable, OnModuleInit } from '@nestjs/common';import { JobQueue, JobQueueService, ID, Product, TransactionalConnection } from '@vendure/core';import { transcode } from 'third-party-video-sdk';@Injectable()class ProductVideoService implements OnModuleInit {    private jobQueue: JobQueue<{ productId: ID; videoUrl: string; }>;    constructor(private jobQueueService: JobQueueService,                private connection: TransactionalConnection) {    }    async onModuleInit() {        this.jobQueue = await this.jobQueueService.createQueue({            name: 'transcode-video',            process: async job => {                // Inside the `process` function we define how each job                // in the queue will be processed.                // In this case we call out to some imaginary 3rd-party video                // transcoding API, which performs the work and then                // returns a new URL of the transcoded video, which we can then                // associate with the Product via the customFields.                const result = await transcode(job.data.videoUrl);                await this.connection.getRepository(Product).save({                    id: job.data.productId,                    customFields: {                        videoUrl: result.url,                    },                });                // The value returned from the `process` function is stored as the "result"                // field of the job (for those JobQueueStrategies that support recording of results).                //                // Any error thrown from this function will cause the job to fail.                return result;            },        });    }    transcodeForProduct(productId: ID, videoUrl: string) {        // Add a new job to the queue and immediately return the        // job itself.        return this.jobQueue.add({productId, videoUrl}, {retries: 2});    }}
```

Notice the generic type parameter of the JobQueue:

```
JobQueue<{ productId: ID; videoUrl: string; }>
```

This means that when we call jobQueue.add() we must pass in an object of this type. This data will then be available in the process function as the job.data property.

The data passed to jobQueue.add() must be JSON-serializable, because it gets serialized into a string when stored in the job queue. Therefore you should
avoid passing in complex objects such as Date instances, Buffers, etc.

The ProductVideoService is in charge of setting up the JobQueue and adding jobs to that queue. Calling

```
productVideoService.transcodeForProduct(id, url);
```

will add a transcoding job to the queue.

Plugin code typically gets executed on both the server and the worker. Therefore, you sometimes need to explicitly check
what context you are in. This can be done with the ProcessContext provider.

[ProcessContext](/reference/typescript-api/common/process-context/)Finally, the ProductVideoPlugin brings it all together, extending the GraphQL API, defining the required CustomField to store the transcoded video URL, and registering our service and resolver. The PluginCommonModule is imported as it exports the JobQueueService.

[PluginCommonModule](/reference/typescript-api/plugin/plugin-common-module/)
```
import gql from 'graphql-tag';import { PluginCommonModule, VendurePlugin } from '@vendure/core';import { ProductVideoService } from './services/product-video.service';import { ProductVideoResolver } from './api/product-video.resolver';import { adminApiExtensions } from './api/api-extensions';@VendurePlugin({    imports: [PluginCommonModule],    providers: [ProductVideoService],    adminApiExtensions: {        schema: adminApiExtensions,        resolvers: [ProductVideoResolver]    },    configuration: config => {        config.customFields.Product.push({            name: 'videoUrl',            type: 'string',        });        return config;    }})export class ProductVideoPlugin {}
```

### Passing the RequestContext​


[​](#passing-the-requestcontext)Sometimes you need to pass the RequestContext object to the process function of a job, since ctx is required by many Vendure
service methods that you may be using inside your process function. However, the RequestContext object itself is not serializable,
so it cannot be passed directly to the JobQueue.add() method. Instead, you can serialize the RequestContext using the ctx.serialize() method,
and then deserialize it in the process function using the static deserialize method.

[RequestContext object](/reference/typescript-api/request/request-context)[ctx.serialize() method](/reference/typescript-api/request/request-context/#serialize)
```
import { Injectable, OnModuleInit } from '@nestjs/common';import { JobQueue, JobQueueService, Product, TransactionalConnection,    SerializedRequestContext, RequestContext } from '@vendure/core';@Injectable()class ProductExportService implements OnModuleInit {    private jobQueue: JobQueue<{ ctx: SerializedRequestContext; }>;    constructor(private jobQueueService: JobQueueService,                private connection: TransactionalConnection) {    }    async onModuleInit() {        this.jobQueue = await this.jobQueueService.createQueue({            name: 'export-products',            process: async job => {                const ctx = RequestContext.deserialize(job.data.ctx);                const allProducts = await this.connection.getRepository(ctx, Product).find();                // ... logic to export the product omitted for brevity            },        });    }    exportAllProducts(ctx: RequestContext) {        return this.jobQueue.add({ ctx: ctx.serialize() });    }}
```

Serializing the RequestContext should be done with caution, since it is a relatively large object and will significantly increase the size of the job data.

In cases where the job is created in large quantities (hundreds or thousands of jobs per day), this can lead to performance issues. Especially
when using the BullMQJobQueuePlugin, which stores the job data in Redis, the
size of the job data can lead to too much memory usage which can cause the Redis server to crash.

[BullMQJobQueuePlugin](/reference/core-plugins/job-queue-plugin/bull-mqjob-queue-plugin/)Instead of serializing the entire RequestContext, consider passing only the necessary data you need and then reconstructing the RequestContext in the process function:

```
import { Injectable, OnModuleInit } from '@nestjs/common';import { JobQueue, JobQueueService,    RequestContext, ID, LanguageCode, RequestContextService } from '@vendure/core';@Injectable()class ProductExportService implements OnModuleInit {    private jobQueue: JobQueue<{ channelToken: string; languageCode: LanguageCode; }>;    constructor(private jobQueueService: JobQueueService,                private requestContextService: RequestContextService) {    }    async onModuleInit() {        this.jobQueue = await this.jobQueueService.createQueue({            name: 'export-products',            process: async job => {                // Reconstruct the RequestContext from the passed data                const ctx = await this.requestContextService.create({                    channelOrToken: job.data.channelToken,                    languageCode: job.data.languageCode,                })                // ... logic to export the product omitted for brevity            },        });    }    exportAllProducts(ctx: RequestContext) {        // Pass only the necessary data        return this.jobQueue.add({            channelId: ctx.channel.token,            languageCode: ctx.languageCode        });    }}
```

### Handling job cancellation​


[​](#handling-job-cancellation)It is possible for an administrator to cancel a running job. Doing so will cause the configured job queue strategy to mark the job as cancelled, but
on its own this will not stop the job from running. This is because the job queue itself has no direct control over the process function once
it has been started.

It is up to the process function to check for cancellation and stop processing if the job has been cancelled. This can be done by checking the
job.state property, and if the job is cancelled, the process function can throw an error to indicate that the job was interrupted
by early cancellation:

```
import { Injectable, OnModuleInit } from '@nestjs/common';import { JobQueue, JobQueueService, Product, TransactionalConnection,    SerializedRequestContext, RequestContext } from '@vendure/core';import { JobState } from '@vendure/common/lib/generated-types';import { IsNull } from 'typeorm';@Injectable()class ProductExportService implements OnModuleInit {    private jobQueue: JobQueue<{ ctx: SerializedRequestContext; }>;    constructor(private jobQueueService: JobQueueService,                private connection: TransactionalConnection) {    }    async onModuleInit() {        this.jobQueue = await this.jobQueueService.createQueue({            name: 'export-products',            process: async job => {                const ctx = RequestContext.deserialize(job.data.ctx);                const allProducts = await this.connection.getRepository(ctx, Product).find({                    where: { deletedAt: IsNull() }                });                let successfulExportCount = 0;                for (const product of allProducts) {                    if (job.state === JobState.CANCELLED) {                        // If the job has been cancelled, stop processing                        // to prevent unnecessary work.                        throw new Error('Job was cancelled');                    }                    // ... logic to export the product omitted for brevity                    successfulExportCount++;                }                return { successfulExportCount };            },        });    }    exportAllProducts(ctx: RequestContext) {        return this.jobQueue.add({ ctx: ctx.serialize() });    }}
```

### Subscribing to job updates​


[​](#subscribing-to-job-updates)When creating a new job via JobQueue.add(), it is possible to subscribe to updates to that Job (progress and status changes). This allows you, for example, to create resolvers which are able to return the results of a given Job.

In the video transcoding example above, we could modify the transcodeForProduct() call to look like this:

```
import { Injectable, OnModuleInit } from '@nestjs/common';import { of } from 'rxjs';import { map, catchError } from 'rxjs/operators';import { ID, Product, TransactionalConnection } from '@vendure/core';@Injectable()class ProductVideoService implements OnModuleInit {    // ... omitted (see above)    transcodeForProduct(productId: ID, videoUrl: string) {        const job = await this.jobQueue.add({productId, videoUrl}, {retries: 2});        return job.updates().pipe(            map(update => {                // The returned Observable will emit a value for every update to the job                // such as when the `progress` or `status` value changes.                Logger.info(`Job ${update.id}: progress: ${update.progress}`);                if (update.state === JobState.COMPLETED) {                    Logger.info(`COMPLETED ${update.id}: ${update.result}`);                }                return update.result;            }),            catchError(err => of(err.message)),        );    }}
```

If you prefer to work with Promises rather than Rxjs Observables, you can also convert the updates to a promise:

```
const job = await this.jobQueue.add({ productId, videoUrl }, { retries: 2 });return job.updates().toPromise()  .then(/* ... */)  .catch(/* ... */);
```


---

# Settings Store


The Settings Store is a flexible system for storing configuration data with support for scoping, permissions,
and validation. It allows plugins and the core system to store and retrieve arbitrary JSON data with
fine-grained control over access and isolation.

It provides a robust, secure, and flexible system for managing configuration data in your Vendure
application. Use it to store user preferences, plugin settings, feature flags, and any other
settings data your application needs.

The APIs in this guide were introduced in Vendure v3.4

## Overview​


[​](#overview)The Settings Store provides:

- Scoped Storage: Data can be scoped globally, per-user, per-channel, or with custom scope
- Permission Control: Fields can require specific permissions to access
- Validation: Custom validation functions for field values
- GraphQL API: Admin API for reading and writing values
- Service API: Programmatic access via the SettingsStoreService
- Automatic Cleanup: Scheduled task to remove orphaned entries

[SettingsStoreService](/reference/typescript-api/services/settings-store-service)
## Settings Store vs Custom Fields​


[​](#settings-store-vs-custom-fields)Settings fields share some similarities to custom fields, but the important differences are:

- Custom fields are attached to particular Vendure entities. Settings fields are not.
- Defining a custom field adds a new column in the database, whereas settings fields do not.
- Custom fields are reflected in corresponding GraphQL APIs and in the Dashboard UI.
- Custom fields are statically typed, whereas settings fields store any kind of JSON-serializable data.

Settings fields are best suited to storing config-like values that are global in scope, or which
configure data for a particular plugin.

## Defining Settings Fields​


[​](#defining-settings-fields)Settings fields are defined in your Vendure configuration using the settingsStoreFields option:

- Basic Example
- Advanced Example

```
import { VendureConfig, SettingsStoreScopes } from '@vendure/core';export const config: VendureConfig = {  // ... other config  settingsStoreFields: {    dashboard: [        {          name: 'theme',          scope: SettingsStoreScopes.user,        },        {          name: 'companyName',          scope: SettingsStoreScopes.global,        }      ]    }  };
```

```
import { VendureConfig, SettingsStoreScopes, Permission } from '@vendure/core';export const config: VendureConfig = {  // ... other config  settingsStoreFields: {    dashboard: [      {        name: 'theme',        scope: SettingsStoreScopes.user,      },      {        name: 'tableFilters',        scope: SettingsStoreScopes.userAndChannel,      }    ],    payment: [      {        name: 'stripeApiKey',        scope: SettingsStoreScopes.global,        readonly: true, // Cannot be modified via GraphQL API        requiresPermission: Permission.SuperAdmin,        validate: (value, injector, ctx) => {          if (typeof value !== 'string' || !value.startsWith('sk_')) {            return 'Stripe API key must be a string starting with "sk_"';          }        }      }    ],    ui: [      {        name: 'welcomeMessage',        scope: SettingsStoreScopes.channel,        validate: async (value, injector, ctx) => {          if (typeof value !== 'string' || value.length > 500) {            return 'Welcome message must be a string with max 500 characters';          }        }      }    ]  }};
```

### Field Configuration Options​


[​](#field-configuration-options)Each field supports the following configuration options:

### Scoping​


[​](#scoping)The Settings Store supports four built-in scoping strategies:

```
import { SettingsStoreScopes } from '@vendure/core';// Global - single value for entire systemSettingsStoreScopes.global;// User-specific - separate values per userSettingsStoreScopes.user;// Channel-specific - separate values per channelSettingsStoreScopes.channel;// User and channel specific - separate values per user per channelSettingsStoreScopes.userAndChannel;
```

You can also create custom scope functions:

```
import { VendureConfig, SettingsStoreScopeFunction } from '@vendure/core';const customScope: SettingsStoreScopeFunction = ({ key, value, ctx }) => {    // Custom scoping logic    const env = process.env.NODE_ENV === 'production' ? 'prod' : 'dev';    return `env:${env}`;};export const config: VendureConfig = {    settingsStoreFields: {        myNamespace: [            {                name: 'customField',                // The value will be saved with the scope                // "env:prod" or "env:dev"                scope: customScope,            },        ],    },};
```

### Permissions​


[​](#permissions)You can control access to the Settings Store entry via the requiresPermission configuration property.
If not specified, basic authentication is required for Admin API access.

Can be either:

- A single permission or array of permissions (applies to both read and write)
- An object with read and write properties for granular control. For custom permissions you can use
a RwPermissionDefinition.

[RwPermissionDefinition](/reference/typescript-api/auth/permission-definition#rwpermissiondefinition)@example

```
import { Permission, VendureConfig, RwPermissionDefinition } from '@vendure/core';export const dashboardSavedViews = new RwPermissionDefinition('DashboardSavedViews');export const config: VendureConfig = {    settingsStoreFields: {        myNamespace: [            {                name: 'myField1',                // Single permission for both read and write                requiresPermission: Permission.UpdateSettings,            },            {                name: 'myField2',                // Separate read and write permissions                requiresPermission: {                  read: Permission.ReadSettings,                  write: Permission.UpdateSettings,                },            },            {                name: 'myField3',                // Using custom RwPermissionDefinition                requiresPermission: {                  read: dashboardSavedViews.Read,                  write: dashboardSavedViews.Write,                },            },        ],    },};
```

## GraphQL API​


[​](#graphql-api)The Settings Store provides GraphQL queries and mutations in the Admin API:

### Queries​


[​](#queries)
```
# Get a single valuequery GetSettingsStoreValue($key: String!) {    getSettingsStoreValue(key: $key)}# Get multiple valuesquery GetSettingsStoreValues($keys: [String!]!) {    getSettingsStoreValues(keys: $keys)}

```

### Mutations​


[​](#mutations)Any kind of JSON-serializable data can be set as the value. For example: strings, numbers,
arrays, or even deeply-nested objects and arrays.

```
# Set a single valuemutation SetSettingsStoreValue($input: SettingsStoreInput!) {    setSettingsStoreValue(input: $input) {        key        result        error    }}# Set multiple valuesmutation SetSettingsStoreValues($inputs: [SettingsStoreInput!]!) {    setSettingsStoreValues(inputs: $inputs) {        key        result        error    }}

```

By default, the Settings Store is not exposed in the Shop API.
However, you can expose this functionality via a custom mutations & queries
that internally use the SettingsStoreService (see next section).

### Usage Examples​


[​](#usage-examples)- Single Value
- Multiple Values

```
// Setting a valueconst result = await adminClient.query(gql`    mutation SetSettingsStoreValue($input: SettingsStoreInput!) {        setSettingsStoreValue(input: $input) {            key            result            error        }    }`, {    input: {        key: 'dashboard.theme',        value: 'dark'    }});// Getting a valueconst theme = await adminClient.query(gql`    query GetSettingsStoreValue($key: String!) {        getSettingsStoreValue(key: $key)    }`, {    key: 'dashboard.theme'});
```

```
// Setting multiple valuesconst results = await adminClient.query(gql`    mutation SetSettingsStoreValues($inputs: [SettingsStoreInput!]!) {        setSettingsStoreValues(inputs: $inputs) {            key            result            error        }    }`, {    inputs: [        { key: 'dashboard.theme', value: 'dark' },        { key: 'dashboard.language', value: 'en' }    ]});// Getting multiple valuesconst settings = await adminClient.query(gql`    query GetSettingsStoreValues($keys: [String!]!) {        getSettingsStoreValues(keys: $keys)    }`, {    keys: ['dashboard.theme', 'dashboard.language']});// Returns: {"dashboard.theme": "dark", "dashboard.language": "en"}
```

## Using the SettingsStoreService​


[​](#using-the-settingsstoreservice)For programmatic access within plugins or services, use the SettingsStoreService:

[SettingsStoreService](/reference/typescript-api/services/settings-store-service)- Basic Usage
- Advanced Usage

```
import { Injectable } from '@nestjs/common';import { SettingsStoreService, RequestContext } from '@vendure/core';@Injectable()export class MyService {    constructor(private settingsStoreService: SettingsStoreService) {}    async getUserTheme(ctx: RequestContext): Promise<string> {        const theme = await this.settingsStoreService.get<string>(ctx, 'dashboard.theme');        return theme || 'light'; // Default fallback    }    async setUserTheme(ctx: RequestContext, theme: string): Promise<boolean> {        const result = await this.settingsStoreService.set(ctx, 'dashboard.theme', theme);        return result.result;    }}
```

```
import { Injectable } from '@nestjs/common';import { SettingsStoreService, RequestContext } from '@vendure/core';interface DashboardSettings {    theme: 'light' | 'dark';    language: string;    notifications: boolean;}@Injectable()export class DashboardService {    constructor(private settingsStoreService: SettingsStoreService) {}    async getDashboardSettings(ctx: RequestContext): Promise<DashboardSettings> {        const settings = await this.settingsStoreService.getMany(ctx, [            'dashboard.theme',            'dashboard.language',            'dashboard.notifications'        ]);        return {            theme: settings['dashboard.theme'] || 'light',            language: settings['dashboard.language'] || 'en',            notifications: settings['dashboard.notifications'] ?? true,        };    }    async updateDashboardSettings(        ctx: RequestContext,        settings: Partial<DashboardSettings>    ): Promise<{ success: boolean; errors: string[] }> {        const updates: Record<string, any> = {};        if (settings.theme) updates['dashboard.theme'] = settings.theme;        if (settings.language) updates['dashboard.language'] = settings.language;        if (settings.notifications !== undefined) {            updates['dashboard.notifications'] = settings.notifications;        }        const results = await this.settingsStoreService.setMany(ctx, updates);        return {            success: results.every(r => r.result),            errors: results.filter(r => !r.result).map(r => r.error || 'Unknown error')        };    }}
```

### SettingsStoreService Methods​


[​](#settingsstoreservice-methods)Prior to v3.4.2, ctx was the last argument to the above methods. However, since
this is contrary to all other method usage which has ctx as the first argument, it was
changed while deprecating (but still supporting) the former signature.

## Orphaned Entries Cleanup​


[​](#orphaned-entries-cleanup)When field definitions are removed from your configuration, the corresponding
database entries become "orphaned". The Settings Store includes an automatic cleanup system to handle this.

### Manual Cleanup​


[​](#manual-cleanup)You can also perform cleanup manually via the service:

```
// Find orphaned entriesconst orphanedEntries = await settingsStoreService.findOrphanedEntries({    olderThan: '7d',    maxDeleteCount: 1000,});// Clean them upconst cleanupResult = await settingsStoreService.cleanupOrphanedEntries({    olderThan: '7d',    dryRun: false,    batchSize: 100,});
```

## Best Practices​


[​](#best-practices)- Use appropriate scoping: Choose the most restrictive scope that meets your needs
- Implement validation: Add validation for fields that accept user input
- Set permissions: UserequiresPermission for sensitive configuration data
- Mark sensitive fields readonly: Prevent GraphQL modification of critical settings
- Consider value size limits: Large values can impact performance

## Examples​


[​](#examples)
### Plugin Integration​


[​](#plugin-integration)
```
import { VendurePlugin, SettingsStoreScopes } from '@vendure/core';@VendurePlugin({    configuration: config => {        config.settingsStoreFields = {            ...config.settingsStoreFields,            myPlugin: [                {                    name: 'apiEndpoint',                    scope: SettingsStoreScopes.global,                    requiresPermission: Permission.UpdateSettings,                    validate: value => {                        if (typeof value !== 'string' || !value.startsWith('https://')) {                            return 'API endpoint must be a valid HTTPS URL';                        }                    },                },                {                    name: 'userPreferences',                    scope: SettingsStoreScopes.userAndChannel,                },            ],        };        return config;    },})export class MyPlugin {}
```

### Frontend usage​


[​](#frontend-usage)
```
import React from 'react';import { useQuery, useMutation } from '@apollo/client';import gql from 'graphql-tag';const GET_THEME = gql`    query GetTheme {        getSettingsStoreValue(key: "dashboard.theme")    }`;const SET_THEME = gql`    mutation SetTheme($theme: String!) {        setSettingsStoreValue(input: { key: "dashboard.theme", value: $theme }) {            result            error        }    }`;export function ThemeSelector() {    const { data } = useQuery(GET_THEME);    const [setTheme] = useMutation(SET_THEME, {        refetchQueries: [GET_THEME],    });    const currentTheme = data?.getSettingsStoreValue || 'light';    const handleThemeChange = (theme: string) => {        setTheme({ variables: { theme } });    };    return (        <select value={currentTheme} onChange={e => handleThemeChange(e.target.value)}>            <option value="light">Light</option>            <option value="dark">Dark</option>        </select>    );}
```


---


# Add a REST endpoint


REST-style endpoints can be defined as part of a plugin.

[plugin](/guides/developer-guide/plugins/)REST endpoints are implemented as NestJS Controllers. For comprehensive documentation, see the NestJS controllers documentation.

[NestJS controllers documentation](https://docs.nestjs.com/controllers)In this guide we will define a plugin that adds a single REST endpoint at http://localhost:3000/products which returns a list of all products.

## Create a controller​


[​](#create-a-controller)First let's define the controller:

```
// products.controller.tsimport { Controller, Get } from '@nestjs/common';import { Ctx, ProductService, RequestContext } from '@vendure/core';@Controller('products')export class ProductsController {    constructor(private productService: ProductService) {    }    @Get()    findAll(@Ctx() ctx: RequestContext) {        return this.productService.findAll(ctx);    }}
```

The key points to note here are:

- The @Controller() decorator defines the base path for all endpoints defined in this controller. In this case, all endpoints will be prefixed with /products.
- The @Get() decorator defines a GET endpoint at the base path. The method name findAll is arbitrary.
- The @Ctx() decorator injects the RequestContext which is required for all service methods.

[RequestContext](/reference/typescript-api/request/request-context/)
## Register the controller with the plugin​


[​](#register-the-controller-with-the-plugin)
```
import { PluginCommonModule, VendurePlugin } from '@vendure/core';import { ProductsController } from './api/products.controller';@VendurePlugin({  imports: [PluginCommonModule],  controllers: [ProductsController],})export class RestPlugin {}
```

Note: The PluginCommonModule should be imported to gain access to Vendure core providers - in this case it is required in order to be able to inject ProductService into our controller.

[The PluginCommonModule](/reference/typescript-api/plugin/plugin-common-module/)The plugin can then be added to the VendureConfig:

```
import { VendureConfig } from '@vendure/core';import { RestPlugin } from './plugins/rest-plugin/rest.plugin';export const config: VendureConfig = {    // ...    plugins: [        // ...        RestPlugin,    ],};
```

## Controlling access to REST endpoints​


[​](#controlling-access-to-rest-endpoints)You can use the @Allow() decorator to declare the permissions required to access a REST endpoint:

[@Allow() decorator](/reference/typescript-api/request/allow-decorator/)
```
import { Controller, Get } from '@nestjs/common';import { Allow, Permission, Ctx, ProductService, RequestContext } from '@vendure/core';@Controller('products')export class ProductsController {    constructor(private productService: ProductService) {}    @Allow(Permission.ReadProduct)    @Get()    findAll(@Ctx() ctx: RequestContext) {        return this.productService.findAll(ctx);    }}
```

The following Vendure API decorators can also be used with NestJS controllers: @Allow(), @Transaction(), @Ctx().

[API decorators](/guides/developer-guide/the-api-layer/#api-decorators)Additionally, NestJS supports a number of other REST decorators detailed in the NestJS controllers guide

[NestJS controllers guide](https://docs.nestjs.com/controllers#request-object)


---

# Define custom permissions


Vendure uses a fine-grained access control system based on roles & permissions. This is described in detail in the Auth guide. The built-in Permission enum includes a range of permissions to control create, read, update, and delete access to the built-in entities.

[Auth guide](/guides/core-concepts/auth/)[Permission enum](/reference/typescript-api/common/permission/)When building plugins, you may need to define new permissions to control access to new functionality. This guide explains how to do so.

## Defining a single permission​


[​](#defining-a-single-permission)For example, let's imagine you are creating a plugin which exposes a new mutation that can be used by remote services to sync your inventory. First of all we will define the new permission using the PermissionDefinition class:

[PermissionDefinition](/reference/typescript-api/auth/permission-definition/)
```
import { PermissionDefinition } from '@vendure/core';export const sync = new PermissionDefinition({    name: 'SyncInventory',    description: 'Allows syncing stock levels via Admin API'});
```

This permission can then be used in conjuction with the @Allow() decorator to limit access to the mutation:

[@Allow() decorator](/reference/typescript-api/request/allow-decorator/)
```
import { Mutation, Resolver } from '@nestjs/graphql';import { Allow } from '@vendure/core';import { sync } from '../constants';@Resolver()export class InventorySyncResolver {    @Allow(sync.Permission)    @Mutation()    syncInventory(/* ... */) {        // ...    }}
```

Finally, the sync PermissionDefinition must be passed into the VendureConfig so that Vendure knows about this new custom permission:

```
import gql from 'graphql-tag';import { VendurePlugin } from '@vendure/core';import { InventorySyncResolver } from './api/inventory-sync.resolver'import { sync } from './constants';@VendurePlugin({    adminApiExtensions: {        schema: gql`            input InventoryDataInput {              # omitted for brevity            }                    extend type Mutation {              syncInventory(input: InventoryDataInput!): Boolean!            }        `,        resolvers: [InventorySyncResolver]    },    configuration: config => {        config.authOptions.customPermissions.push(sync);        return config;    },})export class InventorySyncPlugin {}

```

On starting the Vendure server, this custom permission will now be visible in the Role detail view of the Dashboard, and can be assigned to Roles.

## Custom CRUD permissions​


[​](#custom-crud-permissions)Quite often your plugin will define a new entity on which you must perform create, read, update and delete (CRUD) operations. In this case, you can use the CrudPermissionDefinition which simplifies the creation of the set of 4 CRUD permissions.

[CrudPermissionDefinition](/reference/typescript-api/auth/permission-definition/#crudpermissiondefinition)For example, let's imagine we are creating a plugin which adds a new entity called ProductReview. We can define the CRUD permissions like so:

```
import { CrudPermissionDefinition } from '@vendure/core';export const productReviewPermission = new CrudPermissionDefinition('ProductReview');
```

These permissions can then be used in our resolver:

```
import { Mutation, Resolver } from '@nestjs/graphql';import { Allow, Transaction } from '@vendure/core';import { productReviewPermission } from '../constants';@Resolver()export class ProductReviewResolver {    @Allow(productReviewPermission.Read)    @Query()    productReviews(/* ... */) {        // ...    }        @Allow(productReviewPermission.Create)    @Mutation()    @Transaction()    createProductReview(/* ... */) {        // ...    }        @Allow(productReviewPermission.Update)    @Mutation()    @Transaction()    updateProductReview(/* ... */) {        // ...    }        @Allow(productReviewPermission.Delete)    @Mutation()    @Transaction()    deleteProductReview(/* ... */) {        // ...    }}
```

Finally, the productReview CrudPermissionDefinition must be passed into the VendureConfig so that Vendure knows about this new custom permission:

```
import gql from 'graphql-tag';import { VendurePlugin } from '@vendure/core';import { ProductReviewResolver } from './api/product-review.resolver'import { productReviewPermission } from './constants';@VendurePlugin({    adminApiExtensions: {        schema: gql`            # omitted for brevity        `,        resolvers: [ProductReviewResolver]    },    configuration: config => {        config.authOptions.customPermissions.push(productReviewPermission);        return config;    },})export class ProductReviewPlugin {}

```

## Custom permissions for custom fields​


[​](#custom-permissions-for-custom-fields)Since Vendure v2.2.0, it is possible to define custom permissions for custom fields. This is useful when you want to
control access to specific custom fields on an entity. For example, imagine a "product reviews" plugin which adds a
rating custom field to the Product entity.

You may want to restrict access to this custom field to only those roles which have permissions on the product review
plugin.

```
import { VendurePlugin } from '@vendure/core';import { productReviewPermission } from './constants';@VendurePlugin({    configuration: config => {        config.authOptions.customPermissions.push(productReviewPermission);                config.customFields.Product.push({            name: 'rating',            type: 'int',            requiresPermission: [                productReviewPermission.Read,                 productReviewPermission.Update,            ],        });        return config;    },})export class ProductReviewPlugin {}
```


---

# Define a database entity


Use npx vendure add to easily add a new entity to a plugin.

[Vendure CLI](/guides/developer-guide/cli/)Your plugin can define new database entities to model the data it needs to store. For instance, a product
review plugin would need a way to store reviews. This would be done by defining a new database entity.

This example shows how new TypeORM database entities can be defined by plugins.

[TypeORM database entities](https://typeorm.io/entities)
## Create the entity class​


[​](#create-the-entity-class)
```
import { DeepPartial } from '@vendure/common/lib/shared-types';import { VendureEntity, Product, EntityId, ID } from '@vendure/core';import { Column, Entity, ManyToOne } from 'typeorm';@Entity()class ProductReview extends VendureEntity {    constructor(input?: DeepPartial<ProductReview>) {        super(input);    }    @ManyToOne(type => Product)    product: Product;        @EntityId()    productId: ID;    @Column()    text: string;    @Column()    rating: number;}
```

Any custom entities must extend the VendureEntity class.

[VendureEntity](/reference/typescript-api/entities/vendure-entity/)In this example, we are making use of the following TypeORM decorators:

- @Entity() - defines the entity as a TypeORM entity. This is required for all entities. It tells TypeORM to create a new table in the database for this entity.
- @Column() - defines a column in the database table. The data type of the column is inferred from the TypeScript type of the property, but can be overridden by passing an options object to the decorator. The @Column() also supports many other options for defining the column, such as nullable, default, unique, primary, enum etc.
- @ManyToOne() - defines a many-to-one relationship between this entity and another entity. In this case, many  ProductReview entities can be associated with a given Product. There are other types of relations that can be defined - see the TypeORM relations docs.

[@Entity()](https://typeorm.io/decorator-reference#entity)[@Column()](https://typeorm.io/decorator-reference#column)[@ManyToOne()](https://typeorm.io/decorator-reference#manytoone)[TypeORM relations docs](https://typeorm.io/relations)There is an additional Vendure-specific decorator:

- @EntityId() marks a property as the ID of another entity. In this case, the productId property is the ID of the Product entity. The reason that we have a special decorator for this is that Vendure supports both numeric and string IDs, and the @EntityId() decorator will automatically set the database column to be the correct type. This productId is not necessary, but it is a useful convention to allow access to the ID of the associated entity without having to perform a database join.

[@EntityId()](/reference/typescript-api/configuration/entity-id-decorator)
## Register the entity​


[​](#register-the-entity)The new entity is then passed to the entities array of the VendurePlugin metadata:

```
import { VendurePlugin } from '@vendure/core';import { ProductReview } from './entities/product-review.entity';@VendurePlugin({    entities: [ProductReview],})export class ReviewsPlugin {}
```

Once you have added a new entity to your plugin, and the plugin has been added to your VendureConfig plugins array, you must create a database migration to create the new table in the database.

[database migration](/guides/developer-guide/migrations/)
## Using the entity​


[​](#using-the-entity)The new entity can now be used in your plugin code. For example, you might want to create a new product review when a customer submits a review via the storefront:

```
import { Injectable } from '@nestjs/common';import { RequestContext, Product, TransactionalConnection } from '@vendure/core';import { ProductReview } from '../entities/product-review.entity';@Injectable()export class ReviewService {    constructor(private connection: TransactionalConnection) {}    async createReview(ctx: RequestContext, productId: string, rating: number, text: string) {        const product = await this.connection.getEntityOrThrow(ctx, Product, productId);        const review = new ProductReview({            product,            rating,            text,        });        return this.connection.getRepository(ctx, ProductReview).save(review);    }}
```

## Available entity decorators​


[​](#available-entity-decorators)In addition to the decorators described above, there are many other decorators provided by TypeORM. Some commonly used ones are:

- @OneToOne()
- @OneToMany()
- @ManyToMany()
- @Index()
- @Unique()

[@OneToOne()](https://typeorm.io/decorator-reference#onetoone)[@OneToMany()](https://typeorm.io/decorator-reference#onetomany)[@ManyToMany()](https://typeorm.io/decorator-reference#manytomany)[@Index()](https://typeorm.io/decorator-reference#index)[@Unique()](https://typeorm.io/decorator-reference#unique)There is also another Vendure-specific decorator for representing monetary values specifically:

- @Money(): This works together with the MoneyStrategy to allow configurable control over how monetary values are stored in the database. For more information see the Money & Currency guide.

[@Money()](/reference/typescript-api/money/money-decorator)[MoneyStrategy](/reference/typescript-api/money/money-strategy)[Money & Currency guide](/guides/core-concepts/money/#the-money-decorator)The full list of TypeORM decorators can be found in the TypeORM decorator reference

[TypeORM decorator reference](https://typeorm.io/decorator-reference)
## Corresponding GraphQL type​


[​](#corresponding-graphql-type)Once you have defined a new DB entity, it is likely that you want to expose it in your GraphQL API. Here's how to define a new type in your GraphQL API.

[define a new type in your GraphQL API](/guides/developer-guide/extend-graphql-api/#defining-a-new-type)
## Supporting translations​


[​](#supporting-translations)In case you'd like to make the ProductReview entity support content in multiple languages, here's how to implement the Translatable Interface.

[implement the Translatable Interface](/guides/developer-guide/translatable)
## Supporting channels​


[​](#supporting-channels)In case you'd like to support separate ProductReview entities per Channel, here's how to implement the ChannelAware Interface.

[implement the ChannelAware Interface](/guides/developer-guide/channel-aware)
## Supporting custom fields​


[​](#supporting-custom-fields)Just like you can extend Vendures native entities like Product to support your custom needs, you may enable other developers to extend your custom entities too! Here's how to implement the HasCustomFields Interface.

[implement the HasCustomFields Interface](/guides/developer-guide/has-custom-fields)


---

# Extend the GraphQL API


Extension to the GraphQL API consists of two parts:

- Schema extensions. These define new types, fields, queries and mutations.
- Resolvers. These provide the logic that backs up the schema extensions.

The Shop API and Admin APIs can be extended independently:

```
import { PluginCommonModule, VendurePlugin } from '@vendure/core';import gql from 'graphql-tag';import { TopSellersResolver } from './api/top-products.resolver';const schemaExtension = gql`  extend type Query {    topProducts: [Product!]!  }`@VendurePlugin({    imports: [PluginCommonModule],    // We pass our schema extension and any related resolvers    // to our plugin metadata      shopApiExtensions: {        schema: schemaExtension,        resolvers: [TopProductsResolver],    },    // Likewise, if you want to extend the Admin API,    // you would use `adminApiExtensions` in exactly the    // same way.      // adminApiExtensions: {    //     schema: someSchemaExtension    //     resolvers: [SomeResolver],    // },})export class TopProductsPlugin {}
```

There are a number of ways the GraphQL APIs can be modified by a plugin.

## Adding a new Query​


[​](#adding-a-new-query)Let's take a simple example where we want to be able to display a banner in our storefront.

First let's define a new query in the schema:

```
import gql from 'graphql-tag';export const shopApiExtensions = gql`  extend type Query {    activeBanner(locationId: String!): String  }`;
```

This defines a new query called activeBanner which takes a locationId string argument and returns a string.

! = non-nullable

In GraphQL, the ! in locationId: String! indicates that the argument is required, and the lack of a ! on the return type indicates that the return value can be null.

We can now define the resolver for this query:

```
import { Args, Query, Resolver } from '@nestjs/graphql';import { Ctx, RequestContext } from '@vendure/core';import { BannerService } from '../services/banner.service.ts';@Resolver()class BannerShopResolver {    constructor(private bannerService: BannerService) {}    @Query()    activeBanner(@Ctx() ctx: RequestContext, @Args() args: { locationId: string; }) {        return this.bannerService.getBanner(ctx, args.locationId);    }}
```

The BannerService would implement the actual logic for fetching the banner text from the database.

Finally, we need to add the resolver to the plugin metadata:

```
import { PluginCommonModule, VendurePlugin } from '@vendure/core';import { BannerService } from './services/banner.service';import { BannerShopResolver } from './api/banner-shop.resolver';import { shopApiExtensions } from './api/api-extensions';@VendurePlugin({    imports: [PluginCommonModule],    shopApiExtensions: {        schema: shopApiExtensions,        resolvers: [BannerShopResolver],    },    providers: [BannerService],})export class BannerPlugin {}
```

## Adding a new Mutation​


[​](#adding-a-new-mutation)Let's continue the BannerPlugin example and now add a mutation which allows the administrator to set the banner text.

First we define the mutation in the schema:

```
import gql from 'graphql-tag';export const adminApiExtensions = gql`  extend type Mutation {    setBannerText(locationId: String!, text: String!): String!  }`;
```

Here we are defining a new mutation called setBannerText which takes two arguments, locationId and text, both of which are required strings. The return type is a non-nullable string.

Now let's define a resolver to handle that mutation:

```
import { Args, Mutation, Resolver } from '@nestjs/graphql';import { Allow, Ctx, RequestContext, Permission, Transaction } from '@vendure/core';import { BannerService } from '../services/banner.service.ts';@Resolver()class BannerAdminResolver {    constructor(private bannerService: BannerService) {}    @Allow(Permission.UpdateSettings)    @Transaction()    @Mutation()    setBannerText(@Ctx() ctx: RequestContext, @Args() args: { locationId: string; text: string; }) {        return this.bannerService.setBannerText(ctx, args.locationId, args.text);    }}
```

Note that we have used the @Allow() decorator to ensure that only users with the UpdateSettings permission can call this mutation. We have also wrapped the resolver in a transaction using @Transaction(), which is a good idea for any mutation which modifies the database.

For more information on the available decorators, see the API Layer "decorators" guide.

[API Layer "decorators" guide](/guides/developer-guide/the-api-layer/#api-decorators)Finally, we add the resolver to the plugin metadata:

```
import { PluginCommonModule, VendurePlugin } from '@vendure/core';import { BannerService } from './services/banner.service';import { BannerShopResolver } from './api/banner-shop.resolver';import { BannerAdminResolver } from './api/banner-admin.resolver';import { shopApiExtensions, adminApiExtensions } from './api/api-extensions';@VendurePlugin({    imports: [PluginCommonModule],    shopApiExtensions: {        schema: shopApiExtensions,        resolvers: [BannerShopResolver],    },    adminApiExtensions: {        schema: adminApiExtensions,        resolvers: [BannerAdminResolver],    },    providers: [BannerService],})export class BannerPlugin {}
```

## Defining a new type​


[​](#defining-a-new-type)If you have defined a new database entity, it is likely that you'll want to expose this entity in your GraphQL API. To do so, you'll need to define a corresponding GraphQL type.

Using the ProductReview entity from the Define a database entity guide, let's see how we can expose it as a new type in the API.

[Define a database entity guide](/guides/developer-guide/database-entity)As a reminder, here is the ProductReview entity:

```
import { DeepPartial } from '@vendure/common/lib/shared-types';import { VendureEntity, Product, EntityId, ID } from '@vendure/core';import { Column, Entity, ManyToOne } from 'typeorm';@Entity()class ProductReview extends VendureEntity {    constructor(input?: DeepPartial<ProductReview>) {        super(input);    }    @ManyToOne(type => Product)    product: Product;        @EntityId()    productId: ID;    @Column()    text: string;    @Column()    rating: number;}
```

Let's define a new GraphQL type which corresponds to this entity:

```
import gql from 'graphql-tag';export const apiExtensions = gql`  type ProductReview implements Node {    id: ID!    createdAt: DateTime!    updatedAt: DateTime!    product: Product!    productId: ID!    text: String!    rating: Float!  }`;
```

Assuming the entity is a standard VendureEntity, it is good practice to always include the id, createdAt and updatedAt fields in the GraphQL type.

Additionally, we implement Node which is a built-in GraphQL interface.

Now we can add this type to both the Admin and Shop APIs:

```
import gql from 'graphql-tag';import { PluginCommonModule, VendurePlugin } from '@vendure/core';import { ReviewsResolver } from './api/reviews.resolver';import { apiExtensions } from './api/api-extensions';import { ProductReview } from './entities/product-review.entity';@VendurePlugin({    imports: [PluginCommonModule],    shopApiExtensions: {        schema: apiExtensions,    },    entities: [ProductReview],})export class ReviewsPlugin {}
```

## Add fields to existing types​


[​](#add-fields-to-existing-types)Let's say you want to add a new field to the ProductVariant type to allow the storefront to display some indication of how long a particular product variant would take to deliver, based on data from some external service.

First we extend the ProductVariant GraphQL type:

```
import gql from 'graphql-tag';export const shopApiExtensions = gql`  type DeliveryEstimate {    from: Int!    to: Int!  }  extend type ProductVariant {    delivery: DeliveryEstimate!  }}`;
```

This schema extension says that the delivery field will be added to the ProductVariant type, and that it will be of type DeliveryEstimate!, i.e. a non-nullable
instance of the DeliveryEstimate type.

Next we need to define an "entity resolver" for this field. Unlike the resolvers we have seen above, this resolver will be handling fields on the ProductVariant type only. This is done by scoping the resolver class that type by passing the type name to the @Resolver() decorator:

```
import { Parent, ResolveField, Resolver } from '@nestjs/graphql';import { Ctx, RequestContext, ProductVariant } from '@vendure/core';import { DeliveryEstimateService } from '../services/delivery-estimate.service';@Resolver('ProductVariant')export class ProductVariantEntityResolver {    constructor(private deliveryEstimateService: DeliveryEstimateService) { }    @ResolveField()    delivery(@Ctx() ctx: RequestContext, @Parent() variant: ProductVariant) {        return this.deliveryEstimateService.getEstimate(ctx, variant.id);    }}
```

Finally we need to pass these schema extensions and the resolver to our plugin metadata:

```
import gql from 'graphql-tag';import { PluginCommonModule, VendurePlugin } from '@vendure/core';import { ProductVariantEntityResolver } from './api/product-variant-entity.resolver';import { shopApiExtensions } from './api/api-extensions';@VendurePlugin({    imports: [PluginCommonModule],    shopApiExtensions: {        schema: shopApiExtensions,        resolvers: [ProductVariantEntityResolver]    }})export class DeliveryTimePlugin {}
```

## Override built-in resolvers​


[​](#override-built-in-resolvers)It is also possible to override an existing built-in resolver function with one of your own. To do so, you need to define a resolver with the same name as the query or mutation you wish to override. When that query or mutation is then executed, your code, rather than the default Vendure resolver, will handle it.

```
import { Args, Query, Mutation, Resolver } from '@nestjs/graphql';import { Ctx, RequestContext } from '@vendure/core'@Resolver()class OverrideExampleResolver {    @Query()    products(@Ctx() ctx: RequestContext, @Args() args: any) {        // when the `products` query is executed, this resolver function will        // now handle it.    }    @Transaction()    @Mutation()    addItemToOrder(@Ctx() ctx: RequestContext, @Args() args: any) {        // when the `addItemToOrder` mutation is executed, this resolver function will        // now handle it.    }}
```

The same can be done for resolving fields:

```
import { Parent, ResolveField, Resolver } from '@nestjs/graphql';import { Ctx, RequestContext, Product } from '@vendure/core';@Resolver('Product')export class FieldOverrideExampleResolver {    @ResolveField()    description(@Ctx() ctx: RequestContext, @Parent() product: Product) {        return this.wrapInFormatting(ctx, product.id);    }    private wrapInFormatting(ctx: RequestContext, id: ID): string {        // implementation omitted, but wraps the description        // text in some special formatting required by the storefront    }}
```

## Resolving union results​


[​](#resolving-union-results)When dealing with operations that return a GraphQL union type, there is an extra step needed.

Union types are commonly returned from mutations in the Vendure APIs. For more detail on this see the section on ErrorResults. For example:

[ErrorResults](/guides/developer-guide/error-handling#expected-errors-errorresults)
```
type MyCustomErrorResult implements ErrorResult {  errorCode: ErrorCode!  message: String!}union MyCustomMutationResult = Order | MyCustomErrorResultextend type Mutation {  myCustomMutation(orderId: ID!): MyCustomMutationResult!}
```

In this example, the resolver which handles the myCustomMutation operation will be returning either an Order object or a MyCustomErrorResult object. The problem here is that the GraphQL server has no way of knowing which one it is at run-time. Luckily Apollo Server (on which Vendure is built) has a means to solve this:

> To fully resolve a union, Apollo Server needs to specify which of the union's types is being returned. To achieve this, you define a __resolveType function for the union in your resolver map.
The __resolveType function is responsible for determining an object's corresponding GraphQL type and returning the name of that type as a string.

To fully resolve a union, Apollo Server needs to specify which of the union's types is being returned. To achieve this, you define a __resolveType function for the union in your resolver map.

The __resolveType function is responsible for determining an object's corresponding GraphQL type and returning the name of that type as a string.

-- Source: Apollo Server docs

[Apollo Server docs](https://www.apollographql.com/docs/apollo-server/schema/unions-interfaces/#resolving-a-union)In order to implement a __resolveType function as part of your plugin, you need to create a dedicated Resolver class with a single field resolver method which will look like this:

```
import { Parent, ResolveField, Resolver } from '@nestjs/graphql';import { Ctx, RequestContext, ProductVariant } from '@vendure/core';@Resolver('MyCustomMutationResult')export class MyCustomMutationResultResolver {    @ResolveField()  __resolveType(value: any): string {    // If it has an "id" property we can assume it is an Order.      return value.hasOwnProperty('id') ? 'Order' : 'MyCustomErrorResult';  }}
```

This resolver is then passed in to your plugin metadata like any other resolver:

```
@VendurePlugin({  imports: [PluginCommonModule],  shopApiExtensions: {    schema: apiExtensions,    resolvers: [/* ... */, MyCustomMutationResultResolver]  }})export class MyPlugin {}
```

Sticking to this example of myCustomMutation, you'll also want to use the ErrorResultUnion in your MyCustomMutationResolver and corresponding service like so:

[ErrorResultUnion](/reference/typescript-api/errors/error-result-union)
```
import { Args, Mutation, Resolver } from "@nestjs/graphql";import { Ctx, ErrorResultUnion, ID, Order, RequestContext, Transaction } from "@vendure/core";@Resolver()export class MyCustomMutationResolver {  constructor(private myCustomService: MyCustomService) {}  @Mutation()  @Transaction()  async myCustomMutation(    @Ctx() ctx: RequestContext,    @Args() args: { orderId: ID }  ): Promise<ErrorResultUnion<MyCustomMutationResult, Order>> {    return this.myCustomService.doMyCustomMutation(ctx, args.orderId);  }}
```

This is because Typescript entities do not correspond 1-to-1 with their GraphQL type counterparts, which results in an error when you're returning the Order-Object because it is not assignable to MyCustomMutationResult.

## Defining custom scalars​


[​](#defining-custom-scalars)By default, Vendure bundles DateTime and a JSON custom scalars (from the graphql-scalars library). From v1.7.0, you can also define your own custom scalars for use in your schema extensions:

[graphql-scalars library](https://github.com/Urigo/graphql-scalars)
```
import { GraphQLScalarType} from 'graphql';import { GraphQLEmailAddress } from 'graphql-scalars';// Scalars can be custom-built as like this one,// or imported from a pre-made scalar library like// the GraphQLEmailAddress example.const FooScalar = new GraphQLScalarType({  name: 'Foo',  description: 'A test scalar',  serialize(value) {    // ...  },  parseValue(value) {    // ...  },});@VendurePlugin({  imports: [PluginCommonModule],  shopApiExtensions: {    schema: gql`      scalar Foo      scalar EmailAddress    `,    scalars: {       // The key must match the scalar name      // given in the schema        Foo: FooScalar,      EmailAddress: GraphQLEmailAddress,    },  },})export class CustomScalarsPlugin {}
```

---


# Custom Strategies in Plugins


When building Vendure plugins, you often need to provide extensible, pluggable implementations for specific features. The strategy pattern is the perfect tool for this, allowing plugin users to customize behavior by providing their own implementations.

This guide shows you how to implement custom strategies in your plugins, following Vendure's established patterns and best practices.

## Overview​


[​](#overview)A strategy in Vendure is a way to provide a pluggable implementation of a particular feature. Custom strategies in plugins allow users to:

- Override default behavior with their own implementations
- Inject dependencies and services through the init() lifecycle method
- Clean up resources using the destroy() lifecycle method
- Configure the strategy through the plugin's init options

## Creating a Strategy Interface​


[​](#creating-a-strategy-interface)First, define the interface that your strategy must implement. All strategy interfaces should extend InjectableStrategy to support dependency injection and lifecycle methods.

```
import { InjectableStrategy, RequestContext } from '@vendure/core';export interface MyCustomStrategy extends InjectableStrategy {    /**     * Process some data and return a result     */    processData(ctx: RequestContext, data: any): Promise<string>;    /**     * Validate the input data     */    validateInput(data: any): boolean;}
```

## Implementing a Default Strategy​


[​](#implementing-a-default-strategy)Create a default implementation that users can extend or replace:

```
import { Injector, RequestContext, Logger } from '@vendure/core';import { MyCustomStrategy } from './my-custom-strategy';import { SomeOtherService } from '../services/some-other.service';import { loggerCtx } from '../constants';export class DefaultMyCustomStrategy implements MyCustomStrategy {    private someOtherService: SomeOtherService;    async init(injector: Injector): Promise<void> {        // Inject dependencies during the init phase        this.someOtherService = injector.get(SomeOtherService);        // Perform any setup logic        Logger.info('DefaultMyCustomStrategy initialized', loggerCtx);    }    async destroy(): Promise<void> {        // Clean up resources if needed        Logger.info('DefaultMyCustomStrategy destroyed', loggerCtx);    }    async processData(ctx: RequestContext, data: any): Promise<string> {        // Validate input first        if (!this.validateInput(data)) {            throw new Error('Invalid input data');        }        // Use injected service to process data        const result = await this.someOtherService.doSomething(ctx, data);        // ... do something with the result        return result;    }    validateInput(data: any): boolean {        return data != null && typeof data === 'object';    }}
```

## Adding Strategy to Plugin Options​


[​](#adding-strategy-to-plugin-options)Define your plugin's initialization options to include the strategy:

```
import { MyCustomStrategy } from './strategies/my-custom-strategy';export interface MyPluginInitOptions {    /**     * Custom strategy for processing data     * @default DefaultMyCustomStrategy     */    processingStrategy?: MyCustomStrategy;    /**     * Other plugin options     */    someOtherOption?: string;}
```

## Configuring the Plugin​


[​](#configuring-the-plugin)In your plugin definition, provide the default strategy and allow users to override it:

```
import { PluginCommonModule, VendurePlugin, Injector } from '@vendure/core';import { OnApplicationBootstrap, OnApplicationShutdown } from '@nestjs/common';import { ModuleRef } from '@nestjs/core';import { MY_PLUGIN_OPTIONS } from './constants';import { MyPluginInitOptions } from './types';import { DefaultMyCustomStrategy } from './strategies/default-my-custom-strategy';import { MyPluginService } from './services/my-plugin.service';import { SomeOtherService } from './services/some-other.service';@VendurePlugin({    imports: [PluginCommonModule],    providers: [        MyPluginService,        SomeOtherService,        {            provide: MY_PLUGIN_OPTIONS,            useFactory: () => MyPlugin.options,        },    ],    configuration: config => {        // You can also configure core Vendure strategies here if needed        return config;    },    compatibility: '^3.0.0',})export class MyPlugin implements OnApplicationBootstrap, OnApplicationShutdown {    static options: MyPluginInitOptions;    constructor(private moduleRef: ModuleRef) {}    static init(options: MyPluginInitOptions) {        this.options = {            // Provide default strategy if none specified            processingStrategy: new DefaultMyCustomStrategy(),            ...options,        };        return MyPlugin;    }    async onApplicationBootstrap() {        await this.initStrategy();    }    async onApplicationShutdown() {        await this.destroyStrategy();    }    private async initStrategy() {        const strategy = MyPlugin.options.processingStrategy;        if (strategy && typeof strategy.init === 'function') {            const injector = new Injector(this.moduleRef);            await strategy.init(injector);        }    }    private async destroyStrategy() {        const strategy = MyPlugin.options.processingStrategy;        if (strategy && typeof strategy.destroy === 'function') {            await strategy.destroy();        }    }}
```

## Using the Strategy in Services​


[​](#using-the-strategy-in-services)Access the strategy through dependency injection in your services:

```
import { Injectable, Inject } from '@nestjs/common';import { RequestContext } from '@vendure/core';import { MY_PLUGIN_OPTIONS } from '../constants';import { MyPluginInitOptions } from '../types';@Injectable()export class MyPluginService {    constructor(@Inject(MY_PLUGIN_OPTIONS) private options: MyPluginInitOptions) {}    async processUserData(ctx: RequestContext, userData: any): Promise<string> {        // Delegate to the configured strategy        return this.options.processingStrategy.processData(ctx, userData);    }    validateUserInput(data: any): boolean {        return this.options.processingStrategy.validateInput(data);    }}
```

## User Implementation Example​


[​](#user-implementation-example)Plugin users can now provide their own strategy implementations:

```
import { Injector, RequestContext, Logger } from '@vendure/core';import { MyCustomStrategy } from '@my-org/my-plugin';import { ExternalApiService } from './external-api.service';import { loggerCtx } from '../constants';export class CustomProcessingStrategy implements MyCustomStrategy {    private externalApi: ExternalApiService;    async init(injector: Injector): Promise<void> {        this.externalApi = injector.get(ExternalApiService);        // Initialize external API connection        await this.externalApi.connect();        Logger.info('Custom processing strategy initialized', loggerCtx);    }    async destroy(): Promise<void> {        // Clean up external connections        if (this.externalApi) {            await this.externalApi.disconnect();        }        Logger.info('Custom processing strategy destroyed', loggerCtx);    }    async processData(ctx: RequestContext, data: any): Promise<string> {        if (!this.validateInput(data)) {            throw new Error('Invalid data format');        }        // Use external API for processing        const result = await this.externalApi.processData(data);        return `Processed: ${result}`;    }    validateInput(data: any): boolean {        // Custom validation logic        return data && data.type === 'custom' && data.value;    }}
```

## Plugin Configuration by Users​


[​](#plugin-configuration-by-users)Users configure the plugin with their custom strategy:

```
import { VendureConfig } from '@vendure/core';import { MyPlugin } from '@my-org/my-plugin';import { CustomProcessingStrategy } from './my-custom-implementation';export const config: VendureConfig = {    plugins: [        MyPlugin.init({            processingStrategy: new CustomProcessingStrategy(),            someOtherOption: 'custom-value',        }),    ],    // ... other config};
```

## Strategy with Options​


[​](#strategy-with-options)You can also create strategies that accept configuration options:

```
import { Injector, RequestContext } from '@vendure/core';import { MyCustomStrategy } from './my-custom-strategy';export interface ConfigurableStrategyOptions {    timeout: number;    retries: number;    apiKey: string;}export class ConfigurableStrategy implements MyCustomStrategy {    constructor(private options: ConfigurableStrategyOptions) {}    async init(injector: Injector): Promise<void> {        // Use options during initialization        console.log(`Strategy configured with timeout: ${this.options.timeout}ms`);    }    async destroy(): Promise<void> {        // Cleanup logic    }    async processData(ctx: RequestContext, data: any): Promise<string> {        // Use configuration options        const timeout = this.options.timeout;        const retries = this.options.retries;        // Implementation using these options...        return 'processed with options';    }    validateInput(data: any): boolean {        return true;    }}
```

Usage:

```
import { ConfigurableStrategy } from './strategies/configurable-strategy';// In plugin configurationMyPlugin.init({    processingStrategy: new ConfigurableStrategy({        timeout: 5000,        retries: 3,        apiKey: process.env.API_KEY,    }),});
```

## Multiple Strategies in One Plugin​


[​](#multiple-strategies-in-one-plugin)For complex plugins, you might need multiple strategies:

```
export interface ComplexPluginOptions {    dataProcessingStrategy?: DataProcessingStrategy;    validationStrategy?: ValidationStrategy;    cacheStrategy?: CacheStrategy;}
```

```
@VendurePlugin({    // ... plugin config})export class ComplexPlugin implements OnApplicationBootstrap, OnApplicationShutdown {    static options: ComplexPluginOptions;    static init(options: ComplexPluginOptions) {        this.options = {            dataProcessingStrategy: new DefaultDataProcessingStrategy(),            validationStrategy: new DefaultValidationStrategy(),            cacheStrategy: new DefaultCacheStrategy(),            ...options,        };        return ComplexPlugin;    }    async onApplicationBootstrap() {        await this.initAllStrategies();    }    async onApplicationShutdown() {        await this.destroyAllStrategies();    }    private async initAllStrategies() {        const injector = new Injector(this.moduleRef);        const strategies = [            ComplexPlugin.options.dataProcessingStrategy,            ComplexPlugin.options.validationStrategy,            ComplexPlugin.options.cacheStrategy,        ];        for (const strategy of strategies) {            if (strategy && typeof strategy.init === 'function') {                await strategy.init(injector);            }        }    }    private async destroyAllStrategies() {        const strategies = [            ComplexPlugin.options.dataProcessingStrategy,            ComplexPlugin.options.validationStrategy,            ComplexPlugin.options.cacheStrategy,        ];        for (const strategy of strategies) {            if (strategy && typeof strategy.destroy === 'function') {                await strategy.destroy();            }        }    }}
```

## Best Practices​


[​](#best-practices)
### 1. Always Extend InjectableStrategy​


[​](#1-always-extend-injectablestrategy)
```
export interface MyStrategy extends InjectableStrategy {    // ... strategy methods}
```

### 2. Provide Sensible Defaults​


[​](#2-provide-sensible-defaults)Always provide a default implementation so users can use your plugin out-of-the-box:

```
static init(options: MyPluginOptions) {    this.options = {        myStrategy: new DefaultMyStrategy(),        ...options,    };    return MyPlugin;}
```

### 3. Handle Lifecycle Properly​


[​](#3-handle-lifecycle-properly)Always implement proper init/destroy handling in your plugin:

```
async onApplicationBootstrap() {    await this.initStrategies();}async onApplicationShutdown() {    await this.destroyStrategies();}
```

### 4. Use TypeScript for Better DX​


[​](#4-use-typescript-for-better-dx)Provide strong typing for better developer experience:

```
export interface MyStrategy extends InjectableStrategy {    processData<T>(ctx: RequestContext, data: T): Promise<ProcessedResult<T>>;}
```

### 5. Document Your Strategy Interface​


[​](#5-document-your-strategy-interface)Provide comprehensive JSDoc comments:

```
export interface MyStrategy extends InjectableStrategy {    /**     * @description     * Processes the input data and returns a transformed result.     * This method is called for each data processing request.     *     * @param ctx - The current request context     * @param data - The input data to process     * @returns Promise resolving to the processed result     */    processData(ctx: RequestContext, data: any): Promise<string>;}
```

## Summary​


[​](#summary)Custom strategies in plugins provide a powerful way to make your plugins extensible and configurable. By following the patterns outlined in this guide, you can:

- Define clear strategy interfaces that extend InjectableStrategy
- Provide default implementations that work out-of-the-box
- Allow users to inject dependencies through the init() method
- Properly manage strategy lifecycle with init() and destroy() methods
- Enable users to provide their own implementations
- Support configuration options for strategies

This approach ensures your plugins are flexible, maintainable, and follow Vendure's established conventions.


---

# Implementing ChannelAware


## Defining channel-aware entities​


[​](#defining-channel-aware-entities)Making an entity channel-aware means that it can be associated with a specific Channel.
This is useful when you want to have different data or features for different channels. First you will have to create
an entity (Define a database entity) that implements the ChannelAware interface.
This interface requires the entity to provide a channels property

[Channel](/reference/typescript-api/entities/channel)[Define a database entity](/guides/developer-guide/database-entity/)
```
import { DeepPartial } from '@vendure/common/lib/shared-types';import { VendureEntity, Product, EntityId, ID, ChannelAware } from '@vendure/core';import { Column, Entity, ManyToOne } from 'typeorm';@Entity()class ProductRequest extends VendureEntity implements ChannelAware {    constructor(input?: DeepPartial<ProductRequest>) {        super(input);    }    @ManyToOne(type => Product)    product: Product;    @EntityId()    productId: ID;    @Column()    text: string;        @ManyToMany(() => Channel)    @JoinTable()    channels: Channel[];}
```

## Creating channel-aware entities​


[​](#creating-channel-aware-entities)Creating a channel-aware entity is similar to creating a regular entity. The only difference is that you need to assign the entity to the current channel.
This can be done by using the ChannelService which provides the assignToCurrentChannel helper function.

The assignToCurrentChannel function will only assign the channels property of the entity. You will still need to save the entity to the database.

```
import { ChannelService } from '@vendure/core';export class RequestService {    constructor(private channelService: ChannelService) {}    async create(ctx: RequestContext, input: CreateRequestInput): Promise<ProductRequest> {        const request = new ProductRequest(input);        // Now we need to assign the request to the current channel (+ default channel)        await this.channelService.assignToCurrentChannel(input, ctx);                return await this.connection.getRepository(ProductRequest).save(request);    }}
```

For Translatable entities, the best place to assign the channels is inside the beforeSave input of the TranslatableSaver helper class.

[Translatable entities](/guides/developer-guide/translations/)[TranslatableSaver](/reference/typescript-api/service-helpers/translatable-saver/)
## Querying channel-aware entities​


[​](#querying-channel-aware-entities)When querying channel-aware entities, you can use the ListQueryBuilder or
the TransactionalConnection to automatically filter entities based on the provided channel id.

[ListQueryBuilder](/reference/typescript-api/data-access/list-query-builder/#extendedlistqueryoptions)[TransactionalConnection](/reference/typescript-api/data-access/transactional-connection/#findoneinchannel)
```
import { ChannelService, ListQueryBuilder, TransactionalConnection } from '@vendure/core';export class RequestService {    constructor(        private connection: TransactionalConnection,        private listQueryBuilder: ListQueryBuilder,        private channelService: ChannelService) {}    findOne(ctx: RequestContext,            requestId: ID,            relations?: RelationPaths<ProductRequest>) {        return this.connection.findOneInChannel(ctx, ProductRequest, requestId, ctx.channelId, {            relations: unique(effectiveRelations)        });    }    findAll(        ctx: RequestContext,        options?: ProductRequestListOptions,        relations?: RelationPaths<ProductRequest>,    ): Promise<PaginatedList<ProductRequest>> {        return this.listQueryBuilder            .build(ProductRequest, options, {                ctx,                relations,                channelId: ctx.channelId,            })            .getManyAndCount()            .then(([items, totalItems]) => {                return {                    items,                    totalItems,                };            });    }}
```


---

# Implementing Translatable


## Defining translatable entities​


[​](#defining-translatable-entities)Making an entity translatable means that string properties of the entity can have a different values for multiple languages.
To make an entity translatable, you need to implement the Translatable interface and add a translations property to the entity.

[Translatable](/reference/typescript-api/entities/interfaces/#translatable)
```
import { DeepPartial } from '@vendure/common/lib/shared-types';import { VendureEntity, Product, EntityId, ID, Translatable } from '@vendure/core';import { Column, Entity, ManyToOne } from 'typeorm';import { ProductRequestTranslation } from './product-request-translation.entity';@Entity()class ProductRequest extends VendureEntity implements Translatable {    constructor(input?: DeepPartial<ProductRequest>) {        super(input);    }    text: LocaleString;        @ManyToOne(type => Product)    product: Product;    @EntityId()    productId: ID;    @OneToMany(() => ProductRequestTranslation, translation => translation.base, { eager: true })    translations: Array<Translation<ProductRequest>>;}
```

The translations property is a OneToMany relation to the translations. Any fields that are to be translated are of type LocaleString, and do not have a @Column() decorator.
This is because the text field here does not in fact exist in the database in the product_request table. Instead, it belongs to the product_request_translations table of the ProductRequestTranslation entity:

```
import { DeepPartial } from '@vendure/common/lib/shared-types';import { HasCustomFields, Translation, VendureEntity, LanguageCode } from '@vendure/core';import { Column, Entity, Index, ManyToOne } from 'typeorm';import { ProductRequest } from './release-note.entity';@Entity()export class ProductRequestTranslation    extends VendureEntity    implements Translation<ProductRequest>, HasCustomFields{    constructor(input?: DeepPartial<Translation<ProductRequestTranslation>>) {        super(input);    }    @Column('varchar')    languageCode: LanguageCode;    @Column('varchar')    text: string; // same name as the translatable field in the base entity    @Index()    @ManyToOne(() => ProductRequest, base => base.translations, { onDelete: 'CASCADE' })    base: ProductRequest;}
```

Thus there is a one-to-many relation between ProductRequest and ProductRequestTranslation, which allows Vendure to handle multiple translations of the same entity. The ProductRequestTranslation entity also implements the Translation interface, which requires the languageCode field and a reference to the base entity.

### Translations in the GraphQL schema​


[​](#translations-in-the-graphql-schema)Since the text field is getting hydrated with the translation it should be exposed in the GraphQL Schema. Additionally, the ProductRequestTranslation type should
be defined as well, to access other translations as well:

```
type ProductRequestTranslation {    id: ID!    createdAt: DateTime!    updatedAt: DateTime!    languageCode: LanguageCode!    text: String!}type ProductRequest implements Node {    id: ID!    createdAt: DateTime!    updatedAt: DateTime!    # Will be filled with the translation for the current language    text: String!    translations: [ProductRequestTranslation!]!}

```

## Creating translatable entities​


[​](#creating-translatable-entities)Creating a translatable entity is usually done by using the TranslatableSaver. This injectable service provides a create and update method which can be used to save or update a translatable entity.

[TranslatableSaver](/reference/typescript-api/service-helpers/translatable-saver/)
```
export class RequestService {    constructor(private translatableSaver: TranslatableSaver) {}    async create(ctx: RequestContext, input: CreateProductRequestInput): Promise<ProductRequest> {        const request = await this.translatableSaver.create({            ctx,            input,            entityType: ProductRequest,            translationType: ProductRequestTranslation,            beforeSave: async f => {                // Assign relations here            },        });        return request;    }}
```

Important for the creation of translatable entities is the input object. The input object should contain a translations array with the translations for the entity. This can be done
by defining the types like CreateRequestInput inside the GraphQL schema:

```
input ProductRequestTranslationInput {    # Only defined for update mutations    id: ID    languageCode: LanguageCode!    text: String!}input CreateProductRequestInput {    text: String!    translations: [ProductRequestTranslationInput!]!}

```

## Updating translatable entities​


[​](#updating-translatable-entities)Updating a translatable entity is done in a similar way as creating one. The TranslatableSaver provides an update method which can be used to update a translatable entity.

[TranslatableSaver](/reference/typescript-api/service-helpers/translatable-saver/)
```
export class RequestService {    constructor(private translatableSaver: TranslatableSaver) {}    async update(ctx: RequestContext, input: UpdateProductRequestInput): Promise<ProductRequest> {        const updatedEntity = await this.translatableSaver.update({            ctx,            input,            entityType: ProductRequest,            translationType: ProductRequestTranslation,            beforeSave: async f => {                // Assign relations here            },        });        return updatedEntity;    }}
```

Once again it's important to provide the translations array in the input object. This array should contain the translations for the entity.

```
input UpdateProductRequestInput {    text: String    translations: [ProductRequestTranslationInput!]}
```

## Loading translatable entities​


[​](#loading-translatable-entities)If your plugin needs to load a translatable entity, you will need to use the TranslatorService to hydrate all the LocaleString fields will the actual translated values from the correct translation.

[TranslatorService](/reference/typescript-api/service-helpers/translator-service/)
```
export class RequestService {    constructor(private translator: TranslatorService) {}    findAll(        ctx: RequestContext,        options?: ListQueryOptions<ProductRequest>,        relations?: RelationPaths<ProductRequest>,    ): Promise<PaginatedList<Translated<ProductRequest>>> {        return this.listQueryBuilder            .build(ProductRequest, options, {                relations,                ctx,            })            .getManyAndCount()            .then(([items, totalItems]) => {                return {                    items: items.map(item => this.translator.translate(item, ctx)),                    totalItems,                };            });    }        findOne(        ctx: RequestContext,        id: ID,        relations?: RelationPaths<ProductRequest>,    ): Promise<Translated<ProductRequest> | null> {        return this.connection            .getRepository(ctx, ProductRequest)            .findOne({                where: { id },                relations,            })            .then(entity => entity && this.translator.translate(entity, ctx));    }}
```


---

# Implementing HasCustomFields


From Vendure v2.2, it is possible to add support for custom fields to your custom entities. This is useful when you are defining a custom entity as part of a plugin which is intended to be used by other developers. For example, a plugin which defines a new entity for storing product reviews might want to allow the developer to add custom fields to the review entity.

[custom fields](/guides/developer-guide/custom-fields/)
## Defining entities that support custom fields​


[​](#defining-entities-that-support-custom-fields)First you need to update your entity class to implement the HasCustomFields interface, and provide an empty class
which will be used to store the custom field values:

```
import {    DeepPartial,    HasCustomFields,    Product,    VendureEntity,    ID,    EntityId,} from '@vendure/core';import { Column, Entity, ManyToOne } from 'typeorm';export class CustomProductReviewFields {}@Entity()export class ProductReview extends VendureEntity implements HasCustomFields {    constructor(input?: DeepPartial<ProductReview>) {        super(input);    }    @Column(() => CustomProductReviewFields)    customFields: CustomProductReviewFields;        @ManyToOne(() => Product)    product: Product;    @EntityId()    productId: ID;    @Column()    text: string;    @Column()    rating: number;}
```

### Type generation​


[​](#type-generation)Given the above entity your API extension might look like this:

[API extension](/guides/developer-guide/extend-graphql-api/)
```
type ProductReview implements Node {  id: ID!  createdAt: DateTime!  updatedAt: DateTime!  product: Product!  productId: ID!  text: String!  rating: Int!}input CreateProductReviewInput {  productId: ID!  text: String!  rating: Int!}input UpdateProductReviewInput {  id: ID!  productId: ID  text: String  rating: Int}
```

Notice the lack of manually defining customFields on the types, this is because Vendure extends the types automatically once your entity implements HasCustomFields.

In order for Vendure to find the correct input types to extend to, they must conform to the naming convention of:

- Create<EntityName>Input
- Update<EntityName>Input

And if your entity is supporting translations:

[supporting translations](/guides/developer-guide/translatable)- <EntityName>Translation
- <EntityName>TranslationInput
- Create<EntityName>TranslationInput
- Update<EntityName>TranslationInput

Following this caveat, codegen will now produce correct types including customFields-fields like so:

```
export type ProductReview = Node & {  customFields?: Maybe<Scalars['JSON']['output']>;  // Note: Other fields omitted for brevity}export type CreateProductReviewInput = {  customFields?: InputMaybe<Scalars['JSON']['input']>;  // Note: Other fields omitted for brevity}export type UpdateProductReviewInput = {  customFields?: InputMaybe<Scalars['JSON']['input']>;  // Note: Other fields omitted for brevity}
```

## Supporting custom fields in your services​


[​](#supporting-custom-fields-in-your-services)Creating and updating your entity works now by setting the fields like usual, with one important addition being, you mustn't forget to update relations via the CustomFieldRelationService. This is needed because a consumer of your plugin may extend the entity with custom fields of type relation which need to get saved separately.

[relation](/guides/developer-guide/custom-fields/#properties-for-relation-fields)
```
import { Injectable } from '@nestjs/common';import { RequestContext, Product, TransactionalConnection, CustomFieldRelationService } from '@vendure/core';import { ProductReview } from '../entities/product-review.entity';@Injectable()export class ReviewService {    constructor(      private connection: TransactionalConnection,      private customFieldRelationService: CustomFieldRelationService,    ) {}    async create(ctx: RequestContext, input: CreateProductReviewInput) {        const product = await this.connection.getEntityOrThrow(ctx, Product, input.productId);        // You'll probably want to do more validation/logic here in a real world scenario                const review = new ProductReview({ ...input, product });        const savedEntity = await this.connection.getRepository(ctx, ProductReview).save(review);        await this.customFieldRelationService.updateRelations(ctx, ProductReview, input, savedEntity);        return savedEntity;    }}
```

## Updating config​


[​](#updating-config)Now you'll be able to add custom fields to the ProductReview entity via the VendureConfig:

```
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    customFields: {        ProductReview: [            { name: 'reviewerName', type: 'string' },            { name: 'reviewerLocation', type: 'string' },        ],    },};
```

## Migrations​


[​](#migrations)Extending entities will alter the database schema requiring a migration. See the migrations guide for further details.

[migrations guide](/guides/developer-guide/migrations/)


---

# Cache


Caching is a technique to improve performance of a system by saving the results of expensive
operations and reusing them when the same operation is requested again.

Vendure uses caching in a number of places to improve performance, and the same caching
mechanism is available for use in custom plugins.

## Setting up the cache​


[​](#setting-up-the-cache)In order to take advantage of Vendure distributed caching, you need to enable a cache plugin.

If no cache plugin is specified, Vendure uses an in-memory cache which is not shared between instances.
This is suitable for development, but not recommended for production use.

### DefaultCachePlugin​


[​](#defaultcacheplugin)The DefaultCachePlugin uses the database to store the cache data.
This is a simple and effective cache strategy which has the advantage of not requiring any additional
infrastructure.

[DefaultCachePlugin](/reference/typescript-api/cache/default-cache-plugin)
```
import { DefaultCachePlugin, VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    plugins: [        DefaultCachePlugin.init({            // optional maximum number of items to            // store in the cache. Defaults to 10,000            cacheSize: 20_000,        }),    ],};
```

After enabling the DefaultCachePlugin, you will need to generate a migration to add the necessary
tables to the database.

[generate a migration](/guides/developer-guide/migrations/)
### RedisCachePlugin​


[​](#rediscacheplugin)Vendure also provides a RedisCachePlugin which uses a Redis
server to store the cache data and can have better performance characteristics.

[RedisCachePlugin](/reference/typescript-api/cache/redis-cache-plugin)
```
import { RedisCachePlugin, VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    plugins: [        RedisCachePlugin.init({            redisOptions: {                host: 'localhost',                port: 6379,            },        }),    ],};
```

## CacheService​


[​](#cacheservice)The CacheService is the general-purpose API for interacting with the cache.
It provides methods for setting, getting and deleting cache entries.

[CacheService](/reference/typescript-api/cache/cache-service)Internally, the CacheService uses a CacheStrategy to store the data. The cache strategy is responsible for
the actual storage and retrieval of the data. The CacheService provides a consistent API which can be used
regardless of the underlying cache strategy.

[CacheStrategy](/reference/typescript-api/cache/cache-strategy)From Vendure v3.1, new projects are created with the DefaultCachePlugin enabled by default. This plugin
uses the database to store the cache data. This is a simple and effective cache strategy which is suitable
for most use-cases.

[DefaultCachePlugin](/reference/typescript-api/cache/default-cache-plugin)For more advanced use-cases, you can use the RedisCachePlugin which uses a Redis
server to store the cache data and can have better performance characteristics.

[RedisCachePlugin](/reference/typescript-api/cache/redis-cache-plugin)
### Multi-instance use​


[​](#multi-instance-use)It is common to run Vendure in a multi-instance setup, where multiple instances of the server and worker are
running in parallel.

The CacheService is designed to work in this environment. Both the DefaultCachePlugin
and the RedisCachePlugin use a single shared cache across all
instances.

[DefaultCachePlugin](/reference/typescript-api/cache/default-cache-plugin)[RedisCachePlugin](/reference/typescript-api/cache/redis-cache-plugin)This means that if one instance sets a cache entry, it will be available to all other instances. Likewise,
if one instance deletes a cache entry, it will be deleted for all other instances.

### Usage​


[​](#usage)The CacheService can be injected into any service, resolver, strategy or configurable operation.

```
import { Injectable } from '@nestjs/common';import { CacheService } from '@vendure/core';@Injectable()export class MyService {    constructor(private cacheService: CacheService) {}    async myMethod() {        const cacheKey = 'MyService.myMethod';        const cachedValue = await this.cacheService.get(cacheKey);        if (cachedValue) {            return cachedValue;        }        const newValue = await this.expensiveOperation();        // Cache the result for 1 minute (60 * 1000 milliseconds)        await this.cacheService.set(cacheKey, newValue, { ttl: 60 * 1000 });        return newValue;    }    private async expensiveOperation() {        // Do something expensive    }}
```

The data stored in the cache must be serializable. This means you cannot store instances of classes,
functions, or other non-serializable data types.

### Cache key naming​


[​](#cache-key-naming)When setting a cache entry, it is important to choose a unique key which will not conflict
with other cache entries. The key should be namespaced to avoid conflicts. For example,
you can use the name of the class & method as part of the key. If there is an identifier
which is unique to the operation, that can be used as well.

```
getVariantIds(productId: ID): Promise<ID[]> {    const cacheKey = `ProductService.getVariantIds:${productId}`;    const cachedValue = await this.cacheService.get(cacheKey);    if (cachedValue) {        return cachedValue;    }    const newValue = await this.expensiveOperation(productId);    await this.cacheService.set(cacheKey, newValue, { ttl: 60 * 1000 });    return newValue;}
```

### Cache eviction​


[​](#cache-eviction)The cache is not infinite, and entries will be evicted after a certain time. The time-to-live (TTL)
of a cache entry can be set when calling set(). If no TTL is set, the cache entry will remain
in the cache indefinitely.

Cache entries can also be manually deleted using the delete() method:

```
await this.cacheService.delete(cacheKey);
```

### Cache tags​


[​](#cache-tags)When setting a cache entry, you can also specify a list of tags. This allows you to invalidate
all cache entries which share a tag. For example, if you have a cache entry which is related to
a Product, you can tag it with the Product's ID. When the Product is updated, you can invalidate
all cache entries which are tagged with that Product ID.

```
const cacheKey = `ProductService.getVariantIds:${productId}`;await this.cacheService.set(cacheKey, newValue, {    tags: [`Product:${productId}`]});// laterawait this.cacheService.invalidateTags([`Product:${productId}`]);
```

### createCache Helper​


[​](#createcache-helper)The createCache helper function can be used to create a Cache instance
which is a convenience wrapper around the CacheService APIs:

[Cache](/reference/typescript-api/cache)
```
import { Injectable } from '@nestjs/common';import { CacheService, ID, EventBus, ProductEvent,RequestContext } from '@vendure/core';@Injectable()export class FacetValueChecker {    // Create a Cache instance with a 1-day TTL    private facetValueCache = this.cacheService.createCache({        getKey: (productId: ID) => `FacetValueChecker.${productId}`,        options: { ttl: 1000 * 60 * 60 * 24 },    });    constructor(private cacheService: CacheService, private eventBus: EventBus) {        this.eventBus.ofType(ProductEvent).subscribe(event => {            if (event.type !== 'created') {                // Invalidate the cache entry when a Product is updated or deleted                this.facetValueCache.delete(event.entity.id);            }        });    }    async getFacetValueIdsForProduct(ctx: RequestContext, productId: ID): Promise<ID[]> {        return this.facetValueCache.get(productId, () =>            // This function will only be called if the cache entry does not exist            // or has expired. It will set the result in the cache automatically.            this.calculateFacetValueIdsForProduct(ctx, productId));    }    async calculateFacetValueIdsForProduct(ctx: RequestContext, productId: ID): Promise<ID[]> {        // Do something expensive    }}
```

## RequestContextCache​


[​](#requestcontextcache)The RequestContextCacheService is a specialized
cache service which is scoped to the current request. This is useful when you want to cache data
for the duration of a single request, but not across multiple requests.

[RequestContextCacheService](/reference/typescript-api/cache/request-context-cache-service)This can be especially useful in resolvers, where you may want to cache the result of a specific resolved
field which may be requested multiple times within the same request.

For example, in Vendure core, when dealing with product lists, there's a particular very hot
code path that is used to calculate the correct prices to return for each product. As part of this
calculation, we need to know the active tax zone, which can be expensive to calculate newly
for each product. We use the RequestContextCacheService to cache the active tax zone for the
duration of the request.

```
const activeTaxZone = await this.requestContextCache.get(    ctx,    'activeTaxZone',    () => taxZoneStrategy        .determineTaxZone(ctx, zones, ctx.channel, order),);
```

Internally, the RequestContextCacheService makes used of the WeakMap data structure which means the cached
data will be automatically garbage-collected when the request is finished. It is also able to store
any kind of data, not just serializable data.

## Session Cache​


[​](#session-cache)There is an additional cache which is specifically used to cache session data, since this data is commonly
accessed on almost all requests. Since v3.1, the default is to use the DefaultSessionCacheStrategy
which internally just uses whatever the current CacheStrategy is to store the data.

[DefaultSessionCacheStrategy](/reference/typescript-api/auth/default-session-cache-strategy)This means that in most cases you don't need to worry about the session cache, but if you have specific
requirements, you can create a custom session cache strategy and set it via the authOptions.sessionCacheStrategy
config property.

## SelfRefreshingCache​


[​](#selfrefreshingcache)The SelfRefreshingCache is a specialized in-memory cache which automatically
refreshes itself if the value is found to be stale. This is useful to cache a single frequently-accessed value, that don't change often.

[SelfRefreshingCache](/reference/typescript-api/cache/self-refreshing-cache)It is created using the createSelfRefreshingCache function, which takes a configuration object that specifies the
name of the cache, the time-to-live (TTL) for the cache entries, and a refresh function that will be called to update the value when it is stale.

[createSelfRefreshingCache](/reference/typescript-api/cache/self-refreshing-cache#createselfrefreshingcache)
```
import {  Channel,  createSelfRefreshingCache,  EventBus,  InitializerEvent,  InternalServerError,  Logger,  RequestContext  SelfRefreshingCache,  TransactionalConnection,} from '@vendure/core';@Injectable()export class PublicChannelService {  private publicChannel: SelfRefreshingCache<Channel, [RequestContext]>;  private readonly logCtx = 'PublicChannelService';  constructor(    private connection: TransactionalConnection,    private eventBus: EventBus,  ) {    this.eventBus.ofType(InitializerEvent).subscribe(async () => {      this.publicChannel = await createSelfRefreshingCache({        name: 'PublicChannelService.publicChannel',        ttl: 1000 * 60 * 5, // 5min        refresh: { fn: ctx => this.findPublicChannel(ctx), defaultArgs: [RequestContext.empty()] },      });    });  }  async getPublicChannel(): Promise<Channel> {    const publicChannel = await this.publicChannel.value();    if (!publicChannel) {      throw new InternalServerError(`error.public-channel-not-found`);    }    return publicChannel;  }  private async findPublicChannel(ctx: RequestContext): Promise<Channel> {    const publicChannel = await this.connection.getRepository(ctx, Channel).findOne({      where: { code: DEFAULT_PUBLIC_CHANNEL_CODE },      relations: ['defaultShippingZone', 'defaultTaxZone'],    });    if (!publicChannel) {      Logger.error('Could not find public channel!', this.logCtx);      throw new InternalServerError(`error.public-channel-not-found`);    }    return publicChannel;  }}
```


---

# GraphQL Dataloaders


Dataloaders are used in GraphQL to solve the so called N+1 problem. This is an advanced performance optimization technique you may
want to use in your application if you find certain custom queries are slow or inefficient.

[Dataloaders](https://github.com/graphql/dataloader)
## N+1 problem​


[​](#n1-problem)Imagine a cart with 20 items. Your implementation requires you to perform an async calculation isSubscription for each cart item which executes one or more queries each time it is called, and it takes pretty long on each execution. It works fine for a cart with 1 or 2 items. But with more than 15 items, suddenly the cart takes a lot longer to load. Especially when the site is busy.

The reason: the N+1 problem. Your cart is firing of 20 or more queries almost at the same time, adding significantly to the GraphQL request. It's like going to the McDonald's drive-in to get 10 hamburgers and getting in line 10 times to get 1 hamburger at a time. It's not efficient.

## The solution: dataloaders​


[​](#the-solution-dataloaders)Dataloaders allow you to say: instead of loading each field in the grapqhl tree one at a time, aggregate all the ids you want to execute the async calculation for, and then execute this for all the ids in one efficient request.

Dataloaders are generally used on fieldResolvers. Often, you will need a specific dataloader for each field resolver.

A Dataloader can return anything: boolean, ProductVariant, string, etc.

## Performance implications​


[​](#performance-implications)Dataloaders can have a huge impact on performance. If your fieldResolver executes queries, and you log these queries, you should see a cascade of queries before the implementation of the dataloader, change to a single query using multiple ids after you implement it.

## Do I need this for CustomField relations?​


[​](#do-i-need-this-for-customfield-relations)No, not normally. CustomField relations are automatically added to the root query for the entity that they are part of. So, they are loaded as part of the query that loads that entity.

## Example​


[​](#example)We will provide a complete example here for you to use as a starting point. The skeleton created can handle multiple dataloaders across multiple channels. We will implement a fieldResolver called isSubscription for an OrderLine that will return a true/false for each incoming orderLine, to indicate whether the orderLine represents a subscription.

```
import gql from 'graphql-tag';export const shopApiExtensions = gql`    extend type OrderLine {        isSubscription: Boolean!    }`
```

This next part import the dataloader package, which you can install with

```
npm install dataloader
```

Dataloader skeleton

```
import DataLoader from 'dataloader'const LoggerCtx = 'SubscriptionDataloaderService'@Injectable({ scope: Scope.REQUEST }) // Important! Dataloaders live at the request levelexport class DataloaderService {  /**   * first level is channel identifier, second level is dataloader key   */  private loaders = new Map<string, Map<string, DataLoader<ID, any>>>()  constructor(private service: SubscriptionExtensionService) {}  getLoader(ctx: RequestContext, dataloaderKey: string) {    const token = ctx.channel?.code ?? `${ctx.channelId}`        Logger.debug(`Dataloader retrieval: ${token}, ${dataloaderKey}`, LoggerCtx)    if (!this.loaders.has(token)) {      this.loaders.set(token, new Map<string, DataLoader<ID, any>>())    }    const channelLoaders = this.loaders.get(token)!    if (!channelLoaders.get(dataloaderKey)) {      let loader: DataLoader<ID, any>      switch (dataloaderKey) {        case 'is-subscription':          loader = new DataLoader<ID, any>((ids) =>            this.batchLoadIsSubscription(ctx, ids as ID[]),          )          break        // Implement cases for your other dataloaders here        default:          throw new Error(`Unknown dataloader key ${dataloaderKey}`)      }      channelLoaders.set(dataloaderKey, loader)    }    return channelLoaders.get(dataloaderKey)!  }  private async batchLoadIsSubscription(    ctx: RequestContext,    ids: ID[],  ): Promise<Boolean[]> {    // Returns an array of ids that represent those input ids that are subscriptions    // Remember: this array can be smaller than the input array    const subscriptionIds = await this.service.whichSubscriptions(ctx, ids)    Logger.debug(`Dataloader is-subscription: ${ids}: ${subscriptionIds}`, LoggerCtx)    return ids.map((id) => subscriptionIds.includes(id)) // Important! preserve order and size of input ids array  }}
```

```
@Resolver(() => OrderLine)export class MyPluginOrderLineEntityResolver {  constructor(    private dataloaderService: DataloaderService,  ) {}  @ResolveField()  isSubscription(@Ctx() ctx: RequestContext, @Parent() parent: OrderLine) {    const loader = this.dataloaderService.getLoader(ctx, 'is-subscription')    return loader.load(parent.id)  }}
```

To make it all work, ensure that the DataLoaderService is loaded in your plugin as a provider.

Dataloaders map the result in the same order as the ids you send to the dataloader.
Dataloaders expect the same order and array size in the return result.

In other words: ensure that the order of your returned result is the same as the incoming ids and don't omit values!


---

# Defining database subscribers


TypeORM allows us to define subscribers. With a subscriber, we can listen to specific entity events and take actions based on inserts, updates, deletions and more.

[subscribers](https://typeorm.io/listeners-and-subscribers#what-is-a-subscriber)If you need lower-level access to database changes that you get with the Vendure EventBus system, TypeORM subscribers can be useful.

[Vendure EventBus system](/reference/typescript-api/events/event-bus/)
## Simple subscribers​


[​](#simple-subscribers)The simplest way to register a subscriber is to pass it to the dbConnectionOptions.subscribers array:

```
import { Product, VendureConfig } from '@vendure/core';import { EntitySubscriberInterface, EventSubscriber, UpdateEvent } from 'typeorm';@EventSubscriber()export class ProductSubscriber implements EntitySubscriberInterface<Product> {  listenTo() {    return Product;  }    beforeUpdate(event: UpdateEvent<Product>) {    console.log(`BEFORE PRODUCT UPDATED: `, event.entity);  }}
```

```
import { VendureConfig } from '@vendure/core';import { ProductSubscriber } from './plugins/my-plugin/product-subscriber';// ...export const config: VendureConfig = {  dbConnectionOptions: {    // ...    subscribers: [ProductSubscriber],  }}
```

The limitation of this method is that the ProductSubscriber class cannot make use of dependency injection, since it is not known to the underlying NestJS application and is instead instantiated by TypeORM directly.

If you need to make use of providers in your subscriber class, you'll need to use the following pattern.

## Injectable subscribers​


[​](#injectable-subscribers)By defining the subscriber as an injectable provider, and passing it to a Vendure plugin, you can take advantage of Nest's dependency injection inside the subscriber methods.

```
import {  PluginCommonModule,  Product,  TransactionalConnection,  VendureConfig,  VendurePlugin,} from '@vendure/core';import { Injectable } from '@nestjs/common';import { EntitySubscriberInterface, EventSubscriber, UpdateEvent } from 'typeorm';import { MyService } from './services/my.service';@Injectable()@EventSubscriber()export class ProductSubscriber implements EntitySubscriberInterface<Product> {    constructor(private connection: TransactionalConnection,                private myService: MyService) {        // This is how we can dynamically register the subscriber        // with TypeORM        connection.rawConnection.subscribers.push(this);    }    listenTo() {        return Product;    }    async beforeUpdate(event: UpdateEvent<Product>) {        console.log(`BEFORE PRODUCT UPDATED: `, event.entity);        // Now we can make use of our injected provider        await this.myService.handleProductUpdate(event);    }}
```

```
@VendurePlugin({    imports: [PluginCommonModule],    providers: [ProductSubscriber, MyService],})class MyPlugin {}
```

```
// ...export const config: VendureConfig = {    dbConnectionOptions: {        // We no longer need to pass the subscriber here        // subscribers: [ProductSubscriber],    },    plugins: [        MyPlugin,    ],}
```

## Troubleshooting subscribers​


[​](#troubleshooting-subscribers)An important factor when working with TypeORM subscribers is that they are very low-level and require some understanding of the Vendure schema.

For example consider the ProductSubscriber above. If an admin changes a product's name in the Dashboard, this subscriber will not fire. The reason is that the name property is actually stored on the ProductTranslation entity, rather than on the Product entity.

So if your subscribers do not seem to work as expected, check your database schema and make sure you are really targeting the correct entity which has the property that you are interested in.


---

# Importing Data


If you have hundreds, thousands or more products, inputting all the data by hand via the Dashboard can be too inefficient. To solve this, Vendure supports bulk-importing product and other data.

Data import is also useful for setting up test or demo environments, and is also used by the @vendure/testing package for end-to-end tests.

## Product Import Format​


[​](#product-import-format)Vendure uses a flat .csv format for importing product data. The format encodes data about:

- products
- product variants
- product & variant assets
- product & variant facets
- product & variant custom fields

Here's an example which defines 2 products, "Laptop" and "Clacky Keyboard". The laptop has 4 variants, and the keyboard only a single variant.

```
name            , slug            , description               , assets                      , facets                              , optionGroups    , optionValues , sku         , price   , taxCategory , stockOnHand , trackInventory , variantAssets , variantFacetsLaptop          , laptop          , "Description of laptop"   , laptop_01.jpg|laptop_02.jpg , category:electronics|brand:Apple    , screen size|RAM , 13 inch|8GB  , L2201308    , 1299.00 , standard    , 100         , false          ,               ,                 ,                 ,                           ,                             ,                                     ,                 , 15 inch|8GB  , L2201508    , 1399.00 , standard    , 100         , false          ,               ,                 ,                 ,                           ,                             ,                                     ,                 , 13 inch|16GB , L2201316    , 2199.00 , standard    , 100         , false          ,               ,                 ,                 ,                           ,                             ,                                     ,                 , 15 inch|16GB , L2201516    , 2299.00 , standard    , 100         , false          ,               , Clacky Keyboard , clacky-keyboard , "Description of keyboard" , keyboard_01.jpg             , category:electronics|brand:Logitech ,                 ,              , A4TKLA45535 , 74.89   , standard    , 100         , false          ,               ,
```

Here's an explanation of each column:

- name: The name of the product. Rows with an empty "name" are interpreted as variants of the preceeding product row.
- slug: The product's slug. Can be omitted, in which case will be generated from the name.
- description: The product description.
- assets: One or more asset file names separated by the pipe (|) character. The files can be located on the local file system, in which case the path is interpreted as being relative to the importAssetsDir as defined in the VendureConfig. Files can also be urls which will be fetched from a remote http/https url. If you need more control over how assets are imported, you can implement a custom AssetImportStrategy. The first asset will be set as the featuredAsset.
- facets: One or more facets to apply to the product separated by the pipe (|) character. A facet has the format <facet-name>:<facet-value>.
- optionGroups: OptionGroups define what variants make up the product. Applies only to products with more than one variant.
- optionValues: For each optionGroup defined, a corresponding value must be specified for each variant. Applies only to products with more than one variant.
- sku: The Stock Keeping Unit (unique product code) for this product variant.
- price: The price can be either with or without taxes, depending on your channel settings (can be set later).
- taxCategory: The name of an existing tax category. Tax categories can be also be imported using the InitialData object.
- stockOnHand: The number of units in stock.
- trackInventory: Whether this variant should have its stock level tracked, i.e. the stock level is automatically decreased for each unit ordered.
- variantAssets: Same as assets but applied to the product variant.
- variantFacets: Same as facets but applied to the product variant.

[importAssetsDir](/reference/typescript-api/import-export/import-export-options/#importassetsdir)[AssetImportStrategy](/reference/typescript-api/import-export/asset-import-strategy#assetimportstrategy)
### Importing Custom Field Data​


[​](#importing-custom-field-data)If you have CustomFields defined on your Product or ProductVariant entities, this data can also be encoded in the import csv:

[CustomFields](/guides/developer-guide/custom-fields/)- product:<customFieldName>: The value of this column will populate Product.customFields[customFieldName].
- variant:<customFieldName>: The value of this column will populate ProductVariant.customFields[customFieldName].

For a real example, see the products.csv file used to populate the Vendure demo data

[products.csv file used to populate the Vendure demo data](https://github.com/vendure-ecommerce/vendure/blob/master/packages/core/mock-data/data-sources/products.csv)
#### Importing relation custom fields​


[​](#importing-relation-custom-fields)To import custom fields with the type relation, the value in the CSV must be a stringified object with an id property:

```
... ,product:featuredReview... ,"{ ""id"": 123 }"
```

#### Importing list custom fields​


[​](#importing-list-custom-fields)To import custom fields with list set to true, the data should be separated with a pipe (|) character:

```
... ,product:keywords... ,tablet|pad|android
```

#### Importing data in multiple languages​


[​](#importing-data-in-multiple-languages)If a field is translatable (i.e. of localeString type), you can use column names with an appended language code (e.g. name:en, name:de, product:keywords:en, product:keywords:de) to specify its value in multiple languages.

Use of language codes has to be consistent throughout the file. You don't have to translate every translatable field. If there are no translated columns for a field, the generic column's value will be used for all languages. But when you do translate columns, the set of languages for each of them needs to be the same. As an example, you cannot use name:en and name:de, but only provide slug:en (it's okay to use only a slug column though, in which case this slug will be used for both the English and the German version).

## Initial Data​


[​](#initial-data)As well as product data, other initialization data can be populated using the InitialData object. This format is intentionally limited; more advanced requirements (e.g. setting up ShippingMethods that use custom checkers & calculators) should be carried out via custom populate scripts.

[InitialData object](/reference/typescript-api/import-export/initial-data/)[custom populate scripts](#populating-the-server)
```
import { InitialData, LanguageCode } from '@vendure/core';export const initialData: InitialData = {    paymentMethods: [        {            name: 'Standard Payment',            handler: {                code: 'dummy-payment-handler',                arguments: [{ name: 'automaticSettle', value: 'false' }],            },        },    ],    roles: [        {            code: 'administrator',            description: 'Administrator',            permissions: [                Permission.CreateCatalog,                Permission.ReadCatalog,                Permission.UpdateCatalog,                Permission.DeleteCatalog,                Permission.CreateSettings,                Permission.ReadSettings,                Permission.UpdateSettings,                Permission.DeleteSettings,                Permission.CreateCustomer,                Permission.ReadCustomer,                Permission.UpdateCustomer,                Permission.DeleteCustomer,                Permission.CreateCustomerGroup,                Permission.ReadCustomerGroup,                Permission.UpdateCustomerGroup,                Permission.DeleteCustomerGroup,                Permission.CreateOrder,                Permission.ReadOrder,                Permission.UpdateOrder,                Permission.DeleteOrder,                Permission.CreateSystem,                Permission.ReadSystem,                Permission.UpdateSystem,                Permission.DeleteSystem,            ],        },    ],    defaultLanguage: LanguageCode.en,    countries: [        { name: 'Austria', code: 'AT', zone: 'Europe' },        { name: 'Malaysia', code: 'MY', zone: 'Asia' },        { name: 'United Kingdom', code: 'GB', zone: 'Europe' },    ],    defaultZone: 'Europe',    taxRates: [        { name: 'Standard Tax', percentage: 20 },        { name: 'Reduced Tax', percentage: 10 },        { name: 'Zero Tax', percentage: 0 },    ],    shippingMethods: [{ name: 'Standard Shipping', price: 500 }, { name: 'Express Shipping', price: 1000 }],    collections: [        {            name: 'Electronics',            filters: [                {                    code: 'facet-value-filter',                    args: { facetValueNames: ['Electronics'], containsAny: false },                },            ],            assetPaths: ['jakob-owens-274337-unsplash.jpg'],        },    ],};
```

- paymentMethods: Defines which payment methods are available.

name: Name of the payment method.
handler: Payment plugin handler information.
- name: Name of the payment method.
- handler: Payment plugin handler information.
- roles: Defines which user roles are available.

code: Role code name.
description: Role description.
permissions: List of permissions to apply to the role.
- code: Role code name.
- description: Role description.
- permissions: List of permissions to apply to the role.
- defaultLanguage: Sets the language that will be used for all translatable entities created by the initial data e.g. Products, ProductVariants, Collections etc. Should correspond to the language used in your product csv file.
- countries: Defines which countries are available.

name: The name of the country in the language specified by defaultLanguage
code: A standardized code for the country, e.g. ISO 3166-1
zone: A Zone to which this country belongs.
- name: The name of the country in the language specified by defaultLanguage
- code: A standardized code for the country, e.g. ISO 3166-1
- zone: A Zone to which this country belongs.
- defaultZone: Sets the default shipping & tax zone for the default Channel. The zone must correspond to a value of zone set in the countries array.
- taxRates: For each item, a new TaxCategory is created, and then a TaxRate is created for each unique zone defined in the countries array.
- shippingMethods: Allows simple flat-rate ShippingMethods to be defined.
- collections: Allows Collections to be created. Currently, only collections based on facet values can be created (code: 'facet-value-filter'). The assetPaths and facetValueNames values must correspond to a value specified in the products csv file. The name should match the value specified in the product csv file (or can be a normalized - lower-case & hyphenated - version thereof). If there are FacetValues in multiple Facets with the same name, the facet may be specified with a colon delimiter, e.g. brand:apple, flavour: apple.

- name: Name of the payment method.
- handler: Payment plugin handler information.

- code: Role code name.
- description: Role description.
- permissions: List of permissions to apply to the role.

- name: The name of the country in the language specified by defaultLanguage
- code: A standardized code for the country, e.g. ISO 3166-1
- zone: A Zone to which this country belongs.

[ISO 3166-1](https://en.wikipedia.org/wiki/List_of_ISO_3166_country_codes)[Zone](/reference/typescript-api/entities/zone)[TaxCategory](/reference/typescript-api/entities/tax-category/)[TaxRate](/reference/typescript-api/entities/tax-rate)[ShippingMethods](/reference/typescript-api/entities/shipping-method)
## Populating The Server​


[​](#populating-the-server)
### The populate() function​


[​](#the-populate-function)The @vendure/core package exposes a populate() function which can be used along with the data formats described above to populate your Vendure server:

[populate() function](/reference/typescript-api/import-export/populate/)
```
import { bootstrap, DefaultJobQueuePlugin } from '@vendure/core';import { populate } from '@vendure/core/cli';import path from "path";import { config } from './vendure-config';import { initialData } from './my-initial-data';const productsCsvFile = path.join(__dirname, 'path/to/products.csv')const populateConfig = {    ...config,    plugins: (config.plugins || []).filter(        // Remove your JobQueuePlugin during populating to avoid        // generating lots of unnecessary jobs as the Collections get created.        plugin => plugin !== DefaultJobQueuePlugin,    ),}populate(    () => bootstrap(populateConfig),    initialData,    productsCsvFile,    'my-channel-token' // optional - used to assign imported )                      // entities to the specified Channel    .then(app => {        return app.close();    })    .then(        () => process.exit(0),        err => {            console.log(err);            process.exit(1);        },    );
```

When removing the DefaultJobQueuePlugin from the plugins list as in the code snippet above, one should manually rebuild the search index in order for the newly added products to appear.
In the Dashboard, this can be done by navigating to the product list view and clicking the button in the top right:

### Populating test data​


[​](#populating-test-data)When installing with @vendure/create, you have the option of populating test data (products, payment methods, countries, zones, tax rates etc).

This guide illustrates how to populate that test data again on an existing Vendure installation, without needing to re-install from scratch.

- npm install --save-dev @vendure/create. This installs the "create" package, which contains the test data we will need.
- drop all tables from your database, but leave the actual database there.
- create a script that looks like this:

```
import { populate } from '@vendure/core/cli';import { bootstrap, VendureConfig } from '@vendure/core';import { config } from './vendure-config';populate(    () => bootstrap({        ...config,        importExportOptions: {            importAssetsDir: path.join(                require.resolve('@vendure/create/assets/products.csv'),                '../images'            ),        },        dbConnectionOptions: {...config.dbConnectionOptions, synchronize: true}    }),    require('@vendure/create/assets/initial-data.json'),    require.resolve('@vendure/create/assets/products.csv'))    .then(app => app.close())    .catch(err => {        console.log(err);        process.exit(1);    });
```

Running this script will populate the database with the test data like when you first installed Vendure.

### Custom populate scripts​


[​](#custom-populate-scripts)If you require more control over how your data is being imported - for example if you also need to import data into custom entities, or import customer or order information - you can create your own CLI script to do this: see Stand-Alone CLI Scripts.

[Stand-Alone CLI Scripts](/guides/developer-guide/stand-alone-scripts/)In addition to all the services available in the Service Layer, the following specialized import services are available:

[Service Layer](/guides/developer-guide/the-service-layer/)- ImportParser: Used to parse the CSV file into an array of objects.
- FastImporterService: Used to create new products & variants in bulk, optimized for speed.
- Populator: Used to populate the initial data.
- AssetImporter: Creates new Assets in bulk, using the configured AssetImportStrategy.
- Importer: Uses all of the above services in combination - this is the basis of the populate() function described above.

[ImportParser](/reference/typescript-api/import-export/import-parser)[FastImporterService](/reference/typescript-api/import-export/fast-importer-service)[Populator](/reference/typescript-api/import-export/populator)[AssetImporter](/reference/typescript-api/import-export/asset-importer)[AssetImportStrategy](/reference/typescript-api/import-export/asset-import-strategy)[Importer](/reference/typescript-api/import-export/importer/)Using these specialized import services is preferable to using the normal service-layer services (ProductService, ProductVariantService etc.) for bulk imports. This is because these import services are optimized for bulk imports (they omit unnecessary checks, use optimized SQL queries) and also do not publish events when creating new entities.

However, it is still possible to use the normal service-layer services if you prefer. For example, the following code snippet shows how to create a new ProductVariant using the ProductVariantService:

```
import { INestApplicationContext } from '@nestjs/common';import {    ProductVariantService,    TransactionalConnection,    LanguageCode,    RequestContext,    RequestContextService,    bootstrapWorker,    ConfigService,    ID,    User,    SearchService,} from '@vendure/core';import { config } from './vendure-config';async function createNewVariantService() {    // We use the bootstrapWorker() function instead of bootstrap() because we don't    // need to start the server, we just need access to the services.    const { app } = await bootstrapWorker(config);    // Most service methods require a RequestContext, so we'll create one here.    const ctx = await getSuperadminContext(app);    // Get the ProductVariantService instance from the application    const productVariantService = app.get(ProductVariantService);    // To reindex after importing products    const searchService = app.get(SearchService);    // Example: Creating a new ProductVariant for an existing product with ID 1    const productId = '1' as ID;    // Create input data for the new variant    const variantInput = {        productId,        translations: [            {                languageCode: LanguageCode.en,                name: 'New Variant 1',            },        ],        sku: 'NEW-VARIANT-001',        // Specify additional variant properties...    };    // Create the variant    const newVariants = await productVariantService.create(ctx, [variantInput]);    console.log('Created new product variants:', newVariants);    // Rebuild search index to include the new variant    await searchService.reindex(ctx);    await app.close();}/** * Creates a RequestContext configured for the default Channel with the activeUser set * as the superadmin user. */export async function getSuperadminContext(app: INestApplicationContext): Promise<RequestContext> {    const {superadminCredentials} = app.get(ConfigService).authOptions;    const superAdminUser = await app.get(TransactionalConnection)        .getRepository(User)        .findOneOrFail({where: {identifier: superadminCredentials.identifier}});    return app.get(RequestContextService).create({        apiType: 'admin',        user: superAdminUser,    });}
```

## Importing from other platforms​


[​](#importing-from-other-platforms)If you are migrating from another platform, you can create a custom import script to import your data into Vendure.

Your existing platform may provide an API which you can use to fetch the data, or it may provide a mechanism for exporting
the data to a file.

Therefore, you have a couple of options:

- Export the data to a file, and then transform this into the Vendure CSV format for import as above.
- Write a script which import the data via the other platform's API, and then import this data into Vendure using the services described above, or any other of the Vendure core services.

The first option is the simplest, but may not be possible if the other platform does not provide a suitable export format.

The second option is more complex, but allows for more flexibility and can be used to import data from any source, as well as allowing the import of other data such as customer and order information.

As an illustrative example, let's imagine we are migrating away from an imaginary commerce platform, "OldCommerce", and we want to import our data into Vendure.

Luckily, OldCommerce provides a client package which allows us to easily interact with their API.

This is a much-simplified example, but it should serve to illustrate the general approach.

```
import { INestApplicationContext } from '@nestjs/common';import {    bootstrapWorker,    ConfigService,    Importer,    LanguageCode,    ParsedProductWithVariants,    RequestContext, RequestContextService,    TransactionalConnection, User,    SearchService,} from '@vendure/core';import { createClient, OldCommerceProduct } from '@old-commerce/client';import { config } from './vendure-config';if (require.main === module) {    importData().then(        () => process.exit(0),        err => {            console.log(err);            process.exit(1);        },    );}async function importData() {    // We use the bootstrapWorker() function instead of bootstrap() because we don't     // need to start the server, we just need access to the services.    const {app} = await bootstrapWorker(config);    // Create an instace of the client we'll be using to interact with the    // OldCommerce API    const client = createClient({        // OldCommerce client config    });    // Let's grab a reference to each of the Vendure services we'll need.    const importer = app.get(Importer);    // Most service methods require a RequestContext, so we'll create one here.    const ctx = await getSuperadminContext(app);    // To reindex after importing products    const searchService = app.get(SearchService);    // Fetch all the products to import from the OldCommerce API    const productsToImport: OldCommerceProduct[] = await client.getAllProducts();    // Transform the OldCommerce products into the format expected by the Importer    const importRows: ParsedProductWithVariants[] = productsToImport.map(product => ({        product: {            translations: [                {                    languageCode: LanguageCode.en,                    name: product.name,                    slug: product.slug,                    description: product.description,                    customFields: {},                },            ],            assetPaths: product.images.map(image => image.sourceUrl),            facets: [],            optionGroups: product.options.map(option => ({                translations: [                    {                        languageCode: LanguageCode.en,                        name: option.name,                        values: option.values.map(value => value.name),                    },                ],            })),        },        variants: product.variations.map(variation => {            const optionValues = variation.options.map(option => option.value);            return {                sku: variation.productCode,                price: variation.price,                stockOnHand: variation.stock,                translations: [{languageCode: LanguageCode.en, optionValues}],            };        }),    }));    // Import the products    await importer.importProducts(ctx, importRows, progress => {        console.log(`Imported ${progress.imported} of ${importRows.length} products`);    });    // Rebuild search index     await searchService.reindex(ctx);    // Close the app    await app.close();}/** * Creates a RequestContext configured for the default Channel with the activeUser set * as the superadmin user. */export async function getSuperadminContext(app: INestApplicationContext): Promise<RequestContext> {    const {superadminCredentials} = app.get(ConfigService).authOptions;    const superAdminUser = await app.get(TransactionalConnection)        .getRepository(User)        .findOneOrFail({where: {identifier: superadminCredentials.identifier}});    return app.get(RequestContextService).create({        apiType: 'admin',        user: superAdminUser,    });}
```


---

# Logging


Logging allows you to see what is happening inside the Vendure server. It is useful for debugging and for monitoring the health of the server in production.

In Vendure, logging is configured using the logger property of the VendureConfig object. The logger must implement the VendureLogger interface.

[VendureConfig](/reference/typescript-api/configuration/vendure-config/#logger)[VendureLogger](/reference/typescript-api/logger/vendure-logger)To implement a custom logger, see the Implementing a custom logger guide.

[Implementing a custom logger](/reference/typescript-api/logger/#implementing-a-custom-logger)
## Log levels​


[​](#log-levels)Vendure uses 5 log levels, in order of increasing severity:

## DefaultLogger​


[​](#defaultlogger)Vendure ships with a DefaultLogger which logs to the console (process.stdout). It can be configured with the desired log level:

[DefaultLogger](/reference/typescript-api/logger/default-logger)
```
import { DefaultLogger, VendureConfig } from '@vendure/core';const config: VendureConfig = {    // ...    logger: new DefaultLogger({ level: LogLevel.Debug }),};
```

## Logging database queries​


[​](#logging-database-queries)To log database queries, set the logging property of the dbConnectionOptions as well as setting the logger to Debug level.

```
import { DefaultLogger, LogLevel, VendureConfig } from '@vendure/core';const config: VendureConfig = {    // ...    logger: new DefaultLogger({ level: LogLevel.Debug }),    dbConnectionOptions: {        // ... etc        logging: true,                // You can also specify which types of DB events to log:        // logging: ['error', 'warn', 'schema', 'query', 'info', 'log'],    },};
```

More information about the logging option can be found in the TypeORM logging documentation.

[TypeORM logging documentation](https://typeorm.io/logging)
## Logging in your own plugins​


[​](#logging-in-your-own-plugins)When you extend Vendure by creating your own plugins, it's a good idea to log useful information about what your plugin is doing. To do this, you need to import the Logger class from @vendure/core and use it in your plugin:

[Logger](/reference/typescript-api/logger/)
```
import { Logger } from '@vendure/core';// It is customary to define a logger context for your plugin// so that the log messages can be easily identified.const loggerCtx = 'MyPlugin';// somewhere in your codeLogger.info(`My plugin is doing something!`, loggerCtx);
```


---

# Scheduled Tasks


Scheduled tasks are a way of executing some code at pre-defined intervals. There are many examples of work that can be done using scheduled tasks,
such as:

- Generating a sitemap
- Synchronizing data between different systems
- Sending abandoned cart emails
- Cleaning up old data

Since Vendure v3.3, there is a built-in mechanism which allows you to define scheduled tasks in a convenient and powerful way.

All the information on page applies to Vendure v3.3+

For older versions, there is no built-in support for scheduled tasks, but you can
instead use a stand-alone script triggered by a cron job.

[stand-alone script](/guides/developer-guide/stand-alone-scripts/)
## Setting up the DefaultSchedulerPlugin​


[​](#setting-up-the-defaultschedulerplugin)In your Vendure config, import and add the DefaultSchedulerPlugin to your
plugins array. If you created your project with a version newer than v3.3, this should already be configured.

[DefaultSchedulerPlugin](/reference/typescript-api/scheduled-tasks/default-scheduler-plugin)
```
import { DefaultSchedulerPlugin, VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    plugins: [DefaultSchedulerPlugin.init()],};
```

When you first add this plugin to your config, you'll need to generate a migration because the
plugin will make use of a new database table in order to guarantee only-once execution of tasks.

[generate a migration](/guides/developer-guide/migrations/)You can then start adding tasks. Vendure ships with a task that will clean up old sessions from the database.

The cleanSessionsTask task is actually configured by default from v3.3+, so normally you won't have to specify this
manually unless you wish to change any of the default configuration using the .configure() method.

```
import { cleanSessionsTask, DefaultSchedulerPlugin, VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    schedulerOptions: {        tasks: [            // Use the task as is            cleanSessionsTask,            // or further configure the task            cleanSessionsTask.configure({                // Run the task every day at 3:00am                // The default schedule is every day at 00:00am                schedule: cron => cron.everyDayAt(3, 0),                params: {                    // How many sessions to process in each batch                    // Default: 10_000                    batchSize: 5_000,                },            }),        ],    },    plugins: [DefaultSchedulerPlugin.init()],};
```

## Creating a Scheduled Task​


[​](#creating-a-scheduled-task)Let's imagine that you have created a SitemapPlugin that exposes a SitemapService which generates a sitemap for your store. You want to run this
task every night at midnight.

Inside the plugin, you would first define a new ScheduledTask instance:

[ScheduledTask](/reference/typescript-api/scheduled-tasks/scheduled-task)
```
import { ScheduledTask, RequestContextService } from '@vendure/core';import { SitemapService } from '../services/sitemap.service';export const generateSitemapTask = new ScheduledTask({    // Give your task a unique ID    id: 'generate-sitemap',    // A human-readable description of the task    description: 'Generates a sitemap file',    // Params can be used to further configure aspects of the    // task. They get passed in to the `execute` function as the    // second argument.    // They can be later modified using the `.configure()` method on the instance    params: {        shopBaseUrl: 'https://www.myshop.com',    },    // Define a default schedule. This can be modified using the    // `.configure()` method on the instance later.    schedule: cron => cron.everyDayAt(0, 0),    // This is the function that will be executed per the schedule.    async execute({injector, params}) {        // Using `injector.get()` we can grab an instance of _any_ provider defined in the        // Vendure core as well as by our plugins.        const sitemapService = injector.get(SitemapService);        // For most service methods, we'll need to pass a RequestContext object.        // We can use the RequestContextService to create one.        const ctx = await injector.get(RequestContextService).create({            apiType: 'admin',        });        // Here's the actual work we want to perform.        const result = await sitemapService.generateSitemap(ctx);        // The return value from the `execute` function will be available        // as the `lastResult` property when viewing tasks.        return { result };    },});
```

## Using a task​


[​](#using-a-task)Now that the task has been defined, we need to tell Vendure to use it.

To do so we need to add it to the schedulerOptions.tasks array.

[schedulerOptions.tasks](/reference/typescript-api/scheduled-tasks/scheduler-options#tasks)
### Adding directly in Vendure config​


[​](#adding-directly-in-vendure-config)This can be done directly in your Vendure config file:

```
import { cleanSessionsTask, DefaultSchedulerPlugin, VendureConfig } from '@vendure/core';import { SitemapPlugin, generateSitemapTask } from './plugins/sitemap';export const config: VendureConfig = {    // ...    schedulerOptions: {        tasks: [            cleanSessionsTask,            // Here's an example of overriding the            // default params using the `configure()` method.            generateSitemapTask.configure({                params: {                    shopBaseUrl: 'https://www.shoes.com'                }            }),        ],    },    plugins: [        SitemapPlugin,        DefaultSchedulerPlugin.init()    ],};
```

### Adding in plugin configuration function​


[​](#adding-in-plugin-configuration-function)An alternative is that a plugin can automatically add the task to the config using the
plugin's configuration function, which allows plugins to alter the Vendure config.

[configuration function](/reference/typescript-api/plugin/vendure-plugin-metadata#configuration)This allows a plugin to encapsulate any scheduled tasks so that the plugin consumer only needs to add the plugin, and not worry about
separately adding the task to the tasks array.

```
import { VendurePlugin, PluginCommonModule, Type, ScheduledTask, VendureConfig } from '@vendure/core';import { PLUGIN_OPTIONS } from './constants';import { SitemapPluginOptions } from './types';import { SitemapService } from './services/sitemap.service';import { generateSitemapTask } from './config/generate-sitemap-task';@VendurePlugin({    imports: [PluginCommonModule],    providers: [SitemapService],    configuration: (config: VendureConfig) => {        // Add the task to the schedulerOptions.tasks array        config.schedulerOptions.tasks.push(            generateSitemapTask.configure({                params: {                    shopBaseUrl: SitemapPlugin.options.shopBaseUrl,                }            })        );        return config;    },})export class SitemapPlugin {    static options: SitemapPluginOptions;    static init(options?: SitemapPluginOptions) {        this.options = {            shopBaseUrl: '',            ...(options ?? {}),        }    }}
```

This plugin can now be consumed like this:

```
import { DefaultSchedulerPlugin, VendureConfig } from '@vendure/core';import { SitemapPlugin } from './plugins/sitemap';export const config: VendureConfig = {    // ...    plugins: [        SitemapPlugin.init({            shopBaseUrl: 'https://www.shoes.com'        }),        DefaultSchedulerPlugin.init()    ],};
```

## How scheduled tasks work​


[​](#how-scheduled-tasks-work)The key problems solved by Vendure's task scheduler are:

- Ensuring that a task is only run a single time per scheduled execution, even when you have multiple instances of servers and workers running.
- Keeping scheduled task work away from the server instances, so that it does not affect API responsiveness.

The first problem is handled by the SchedulerStrategy, which implements a locking
mechanism to ensure that the task is executed only once.

[SchedulerStrategy](/reference/typescript-api/scheduled-tasks/scheduler-strategy)The second problem is handled by having tasks only executed on worker processes.

## Scheduled tasks vs job queue​


[​](#scheduled-tasks-vs-job-queue)There is some overlap between the use of a scheduled task and a job queue job. They both perform some
task on the worker, independent of requests coming in to the server.

[job queue job](/guides/developer-guide/worker-job-queue/)The first difference is that jobs must be triggered explicitly, whereas scheduled tasks are triggered automatically according to the schedule.

Secondly, jobs are put in a queue and executed once any prior pending jobs have been processed. On the other hand, scheduled tasks are executed
as soon as the schedule dictates.

It is possible to combine the two: namely, you can define a scheduled task which adds a job to the job queue. This is, for instance, how the
built-in cleanSessionsTask works. This pattern is something you should
consider if the scheduled task may take a significant amount of time or resources and you want to let the job queue manage that.

[cleanSessionsTask](/reference/typescript-api/scheduled-tasks/clean-sessions-task)It also has the advantage of giving you a record of results for that work that has been put on the job queue, whereas scheduled tasks
only record that result of the last execution.

## A note on @nestjs/schedule​


[​](#a-note-on-nestjsschedule)NestJS provides a dedicated package for scheduling tasks, called @nestjs/schedule.

[dedicated package for scheduling tasks](https://docs.nestjs.com/techniques/task-scheduling)You can also use this approach to schedule tasks, but you need to aware of a very important caveat:

When using @nestjs/schedule, any method decorated with the @Cron() decorator will run
on all instances of the application. This means it will run on the server and on the
worker. If you are running multiple instances, then it will run on all instances.

This is the specific issue solved by the built-in ScheduledTask system described above.
Therefore it is not recommended to use the @nestjs/schedule package under normal
circumstances.

You can, for instance, inject the ProcessContext into the service and check if the current instance is the worker or the server.

[ProcessContext](/reference/typescript-api/common/process-context)
```
import { Injectable } from '@nestjs/common';import { Cron } from '@nestjs/schedule';@Injectable()export class SitemapService {    constructor(private processContext: ProcessContext) {}    @Cron('0 0 * * *')    async generateSitemap() {        if (this.processContext.isWorker) {            // Only run on the worker            await this.triggerGenerate();        }    }}
```

The above code will run the generateSitemap() method every night at midnight, but only on the worker instance.

Again, if you have multiple worker instances running, it would run on all instances.


---

# Stand-alone CLI Scripts


It is possible to create stand-alone scripts that can be run from the command-line by using the bootstrapWorker function. This can be useful for a variety of use-cases such as running cron jobs or importing data.

[bootstrapWorker function](/reference/typescript-api/worker/bootstrap-worker/)
## Minimal example​


[​](#minimal-example)Here's a minimal example of a script which will bootstrap the Vendure Worker and then log the number of products in the database:

```
import { bootstrapWorker, Logger, ProductService, RequestContextService } from '@vendure/core';import { config } from './vendure-config';if (require.main === module) {    getProductCount()        .then(() => process.exit(0))        .catch(err => {            Logger.error(err);            process.exit(1);        });}async function getProductCount() {    // This will bootstrap an instance of the Vendure Worker, providing    // us access to all of the services defined in the Vendure core.    // (but without the unnecessary overhead of the API layer).    const { app } = await bootstrapWorker(config);    // Using `app.get()` we can grab an instance of _any_ provider defined in the    // Vendure core as well as by our plugins.    const productService = app.get(ProductService);    // For most service methods, we'll need to pass a RequestContext object.    // We can use the RequestContextService to create one.    const ctx = await app.get(RequestContextService).create({        apiType: 'admin',    });    // We use the `findAll()` method to get the total count. Since we aren't    // interested in the actual product objects, we can set the `take` option to 0.    const { totalItems } = await productService.findAll(ctx, {take: 0});    Logger.info(        [            '\n-----------------------------',            `There are ${totalItems} products`,            '------------------------------',        ].join('\n'),    )}
```

This script can then be run from the command-line:

```
npx ts-node src/get-product-count.ts# oryarn ts-node src/get-product-count.ts

```

resulting in the following output:

```
info 01/08/23, 11:50 - [Vendure Worker] Bootstrapping Vendure Worker (pid: 4428)...info 01/08/23, 11:50 - [Vendure Worker] Vendure Worker is readyinfo 01/08/23, 11:50 - [Vendure Worker]-----------------------------------------There are 56 products in the database-----------------------------------------
```

## The app object​


[​](#the-app-object)The app object returned by the bootstrapWorker() function is an instance of the NestJS Application Context. It has full access to the NestJS dependency injection container, which means that you can use the app.get() method to retrieve any of the services defined in the Vendure core or by any plugins.

[NestJS Application Context](https://docs.nestjs.com/standalone-applications)
```
import { bootstrapWorker, CustomerService } from '@vendure/core';import { config } from './vendure-config';// ...async function importCustomerData() {    const { app } = await bootstrapWorker(config);        const customerService = app.get(CustomerService);}
```

## Creating a RequestContext​


[​](#creating-a-requestcontext)Almost all the methods exposed by Vendure's core services take a RequestContext object as the first argument. Usually, this object is created in the API Layer by the @Ctx() decorator, and contains information related to the current API request.

[API Layer](/guides/developer-guide/the-api-layer/#resolvers)When running a stand-alone script, we aren't making any API requests, so we need to create a RequestContext object manually. This can be done using the RequestContextService:

[RequestContextService](/reference/typescript-api/request/request-context-service/)
```
// ...import { RequestContextService } from '@vendure/core';async function getProductCount() {    const { app } = await bootstrapWorker(config);    const productService = app.get(ProductService);        const ctx = await app.get(RequestContextService).create({        apiType: 'admin',    });        const { totalItems } = await productService.findAll(ctx, {take: 0});}
```


---

# Translations


The following items in Vendure can be translated:

- Entities which implement the Translatable interface.
- Admin UI text labels and messages
- Server error message

[Translatable](/reference/typescript-api/entities/interfaces/#translatable)
## Translatable entities​


[​](#translatable-entities)The following entities implement the Translatable interface:

- Collection
- Country
- Facet
- FacetValue
- PaymentMethod
- Product
- ProductOption
- ProductOptionGroup
- ProductVariant
- Promotion
- Province
- Region
- ShippingMethod

[Collection](/reference/typescript-api/entities/collection/)[Country](/reference/typescript-api/entities/country/)[Facet](/reference/typescript-api/entities/facet/)[FacetValue](/reference/typescript-api/entities/facet-value/)[PaymentMethod](/reference/typescript-api/entities/payment-method/)[Product](/reference/typescript-api/entities/product/)[ProductOption](/reference/typescript-api/entities/product-option/)[ProductOptionGroup](/reference/typescript-api/entities/product-option-group/)[ProductVariant](/reference/typescript-api/entities/product-variant/)[Promotion](/reference/typescript-api/entities/promotion/)[Province](/reference/typescript-api/entities/province/)[Region](/reference/typescript-api/entities/region/)[ShippingMethod](/reference/typescript-api/entities/shipping-method/)To understand how translatable entities are implemented, let's take a look at a simplified version of the Facet entity:

```
@Entity()export class Facet extends VendureEntity implements Translatable {        name: LocaleString;    @Column({ unique: true })    code: string;    @OneToMany(type => FacetTranslation, translation => translation.base, { eager: true })    translations: Array<Translation<Facet>>;}
```

All translatable entities have a translations field which is a relation to the translations. Any fields that are to be translated are of type LocaleString, and do note have a @Column() decorator. This is because the name field here does not in fact exist in the database in the facet table. Instead, it belongs to the facet_translations table, which brings us to the FacetTranslation entity (again simplified for clarity):

```
@Entity()export class FacetTranslation extends VendureEntity implements Translation<Facet> {    @Column('varchar') languageCode: LanguageCode;    @Column() name: string;    @Index()    @ManyToOne(type => Facet, base => base.translations, { onDelete: 'CASCADE' })    base: Facet;}
```

Thus there is a one-to-many relation between Facet and FacetTranslation, which allows Vendure to handle multiple translations of the same entity. The FacetTranslation entity also implements the Translation interface, which requires the languageCode field and a reference to the base entity.

### Loading translatable entities​


[​](#loading-translatable-entities)If your plugin needs to load a translatable entity, you will need to use the TranslatorService to hydrate all the LocaleString fields will the actual translated values from the correct translation.

[TranslatorService](/reference/typescript-api/service-helpers/translator-service/)For example, if you are loading a Facet entity, you would do the following:

```
import { Facet } from '@vendure/core';import { LanguageCode, RequestContext, TranslatorService, TransactionalConnection } from '@vendure/core';@Injectable()export class MyService {        constructor(private connection: TransactionalConnection, private translator: TranslatorService) {}    async getFacet(ctx: RequestContext, id: ID): Promise<Facet | undefined> {        const facet = await this.connection.getRepository(ctx, Facet).findOne(id);        if (facet) {            return this.translatorService.translate(facet, ctx);        }    }        async getFacets(ctx: RequestContext): Promise<Facet[]> {        const facets = await this.connection.getRepository(ctx, Facet).find();        return Promise.all(facets.map(facet => this.translatorService.translate(facet, ctx)));    }}
```

## Admin UI translations​


[​](#admin-ui-translations)See the Adding Admin UI Translations guide.

[Adding Admin UI Translations guide](/guides/extending-the-admin-ui/adding-ui-translations/)
## Server message translations​


[​](#server-message-translations)Let's say you've implemented some custom server-side functionality as part of a plugin. You may be returning custom errors or other messages. Here's how you can
provide these messages in multiple languages.

Using addTranslation inside the onApplicationBootstrap (Nestjs lifecycle hooks) of a Plugin is the easiest way to add new translations.
While Vendure is only using error, errorResult and message resource keys you are free to use your own.

[addTranslation](/reference/typescript-api/common/i18n-service/#addtranslation)[Nestjs lifecycle hooks](https://docs.nestjs.com/fundamentals/lifecycle-events)
### Translatable Error​


[​](#translatable-error)This example shows how to create a custom translatable error

```
/** * Custom error class */class CustomError extends ErrorResult {    readonly __typename = 'CustomError';    readonly errorCode = 'CUSTOM_ERROR';    readonly message = 'CUSTOM_ERROR'; //< looks up errorResult.CUSTOM_ERROR}@VendurePlugin({    imports: [PluginCommonModule],    providers: [I18nService],    // ...})export class TranslationTestPlugin implements OnApplicationBootstrap {    constructor(private i18nService: I18nService) {    }    onApplicationBootstrap(): any {        this.i18nService.addTranslation('en', {            errorResult: {                CUSTOM_ERROR: 'A custom error message',            },            anything: {                foo: 'bar'            }        });        this.i18nService.addTranslation('de', {            errorResult: {                CUSTOM_ERROR: 'Eine eigene Fehlermeldung',            },            anything: {                foo: 'bar'            }        });    }}
```

To receive an error in a specific language you need to use the languageCode query parameter
query(QUERY_WITH_ERROR_RESULT, { variables }, { languageCode: LanguageCode.de });

### Use translations​


[​](#use-translations)Vendure uses the internationalization-framework i18next.

[i18next](https://www.i18next.com/)Therefore you are free to use the i18next translate function to access keys 
i18next.t('error.any-message');

[access keys](https://www.i18next.com/translation-function/essentials#accessing-keys)


---

# Uploading Files


Vendure handles file uploads with the GraphQL multipart request specification. Internally, we use the graphql-upload package. Once uploaded, a file is known as an Asset. Assets are typically used for images, but can represent any kind of binary data such as PDF files or videos.

[GraphQL multipart request specification](https://github.com/jaydenseric/graphql-multipart-request-spec)[graphql-upload package](https://github.com/jaydenseric/graphql-upload)[Asset](/guides/core-concepts/images-assets/)
## Upload clients​


[​](#upload-clients)Here is a list of client implementations that will allow you to upload files using the spec. If you are using Apollo Client, then you should install the apollo-upload-client npm package.

[list of client implementations](https://github.com/jaydenseric/graphql-multipart-request-spec#client)[apollo-upload-client](https://github.com/jaydenseric/apollo-upload-client)For testing, it is even possible to use a plain curl request.

[plain curl request](https://github.com/jaydenseric/graphql-multipart-request-spec#single-file)
## The createAssets mutation​


[​](#the-createassets-mutation)The createAssets mutation in the Admin API is the only means of uploading files by default.

[createAssets mutation](/reference/graphql-api/admin/mutations/#createassets)Here's an example of how a file upload would look using the apollo-upload-client package:

```
import { gql, useMutation } from "@apollo/client";const MUTATION = gql`  mutation CreateAssets($input: [CreateAssetInput!]!) {    createAssets(input: $input) {      ... on Asset {        id        name        fileSize      }      ... on ErrorResult {        message      }    }  }`;function UploadFile() {    const [mutate] = useMutation(MUTATION);    function onChange(event) {        const {target} = event;        if (target.validity.valid) {            mutate({                variables: {                    input: Array.from(target.files).map((file) => ({file}));                }            });        }    }    return <input type="file" required onChange={onChange}/>;}
```

## Custom upload mutations​


[​](#custom-upload-mutations)How about if you want to implement a custom mutation for file uploads? Let's take an example where we want to allow customers to set an avatar image. To do this, we'll add a custom field to the Customer entity and then define a new mutation in the Shop API.

[custom field](/guides/developer-guide/custom-fields/)
### Configuration​


[​](#configuration)Let's define a custom field to associate the avatar Asset with the Customer entity. To keep everything encapsulated, we'll do all of this in a plugin

[plugin](/guides/developer-guide/plugins/)
```
import { Asset, LanguageCode, PluginCommonModule, VendurePlugin } from '@vendure/core';@VendurePlugin({    imports: [PluginCommonModule],    configure: config => {        config.customFields.Customer.push({            name: 'avatar',            type: 'relation',            label: [{languageCode: LanguageCode.en, value: 'Customer avatar'}],            entity: Asset,            nullable: true,        });        return config;    },})export class CustomerAvatarPlugin {}
```

### Schema definition​


[​](#schema-definition)Next, we will define the schema for the mutation:

```
import gql from 'graphql-tag';export const shopApiExtensions = gql`extend type Mutation {  setCustomerAvatar(file: Upload!): Asset}`
```

### Resolver​


[​](#resolver)The resolver will make use of the built-in AssetService to handle the processing of the uploaded file into an Asset.

[AssetService](/reference/typescript-api/services/asset-service)
```
import { Args, Mutation, Resolver } from '@nestjs/graphql';import { Asset } from '@vendure/common/lib/generated-types';import {    Allow, AssetService, Ctx, CustomerService, isGraphQlErrorResult,    Permission, RequestContext, Transaction} from '@vendure/core';@Resolver()export class CustomerAvatarResolver {    constructor(private assetService: AssetService, private customerService: CustomerService) {}    @Transaction()    @Mutation()    @Allow(Permission.Authenticated)    async setCustomerAvatar(        @Ctx() ctx: RequestContext,        @Args() args: { file: any },    ): Promise<Asset | undefined> {        const userId = ctx.activeUserId;        if (!userId) {            return;        }        const customer = await this.customerService.findOneByUserId(ctx, userId);        if (!customer) {            return;        }        // Create an Asset from the uploaded file        const asset = await this.assetService.create(ctx, {            file: args.file,            tags: ['avatar'],        });        // Check to make sure there was no error when        // creating the Asset        if (isGraphQlErrorResult(asset)) {            // MimeTypeError            throw asset;        }        // Asset created correctly, so assign it as the        // avatar of the current Customer        await this.customerService.update(ctx, {            id: customer.id,            customFields: {                avatarId: asset.id,            },        });        return asset;    }}
```

### Complete Customer Avatar Plugin​


[​](#complete-customer-avatar-plugin)Let's put all these parts together into the plugin:

```
import { Asset, PluginCommonModule, VendurePlugin } from '@vendure/core';import { shopApiExtensions } from './api/api-extensions';import { CustomerAvatarResolver } from './api/customer-avatar.resolver';@VendurePlugin({    imports: [PluginCommonModule],    shopApiExtensions: {        schema: shopApiExtensions,        resolvers: [CustomerAvatarResolver],    },    configuration: config => {        config.customFields.Customer.push({            name: 'avatar',            type: 'relation',            label: [{languageCode: LanguageCode.en, value: 'Customer avatar'}],            entity: Asset,            nullable: true,        });        return config;    },})export class CustomerAvatarPlugin {}
```

### Uploading a Customer Avatar​


[​](#uploading-a-customer-avatar)In our storefront, we would then upload a Customer's avatar like this:

```
import { gql, useMutation } from "@apollo/client";const MUTATION = gql`  mutation SetCustomerAvatar($file: Upload!) {    setCustomerAvatar(file: $file) {      id      name      fileSize    }  }`;function UploadAvatar() {  const [mutate] = useMutation(MUTATION);  function onChange(event) {    const { target } = event;      if (target.validity.valid && target.files.length === 1) {      mutate({         variables: {          file: target.files[0],        }        });    }  }  return <input type="file" required onChange={onChange} />;}
```


---

# Nest Devtools


The NestJS core team have built a powerful set of dev tools which can be used to inspect, analyze and debug NestJS applications.
Since a Vendure server is a NestJS application, these tools can be used to debug your Vendure application.

[powerful set of dev tools](https://docs.nestjs.com/devtools/overview)Nest Devtools is a paid service. You can sign up for a free trial.

[sign up for a free trial](https://devtools.nestjs.com/)
## Installation​


[​](#installation)First you'll need to install the @nestjs/devtools-integration package:

```
npm i @nestjs/devtools-integration
```

## Configuration​


[​](#configuration)Next you need to create a plugin which imports the DevToolsModule and adds it to the imports array:

```
import { VendurePlugin } from '@vendure/core';import { DevtoolsModule } from '@nestjs/devtools-integration';@VendurePlugin({    imports: [        DevtoolsModule.register({            // The reason we are checking the NODE_ENV environment             // variable here is that you should never use this module in production!            http: process.env.NODE_ENV !== 'production',        }),    ],})class DevtoolsPlugin {}
```

Now we need to add this plugin to the plugins array in the VendureConfig. We need to make sure we are
only adding it to the server config, and not the worker, otherwise we will get a port config when
running the server and worker at the same time.

Lastly we must set the snapshot option when bootstrapping the server. Note: this is only possible
with Vendure v2.2 or later.

```
import { bootstrap } from '@vendure/core';import { config } from './vendure-config';const configWithDevtools = {    ...config,    plugins: [        ...config.plugins,        DevtoolsPlugin,    ],};bootstrap(configWithDevtools, {    nestApplicationOptions: { snapshot: true } })    .catch(err => {        console.log(err);        process.exit(1);    });
```

## Usage​


[​](#usage)Now you can start the server, and navigate to devtools.nestjs.com to start view your
Vendure server in the Nest Devtools dashboard.

[devtools.nestjs.com](https://devtools.nestjs.com/)