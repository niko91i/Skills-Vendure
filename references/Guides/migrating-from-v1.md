# Migrating from Vendure 1 to 2


This section contains guides for migrating from Vendure v1 to v2.

There are a number of breaking changes between the two versions, which are due to a few major factors:

- To support new features such as multi-vendor marketplace APIs and multiple stock locations, we had to make some changes to the database schema and some of the internal APIs.
- We have updated all of our major dependencies to their latest versions. Some of these updates involve breaking changes in the dependencies themselves, and in those cases where you are using those dependencies directly (most notably TypeORM), you will need to make the corresponding changes to your code.
- We have removed some old APIs which were previously marked as "deprecated".

## Migration steps​


[​](#migration-steps)Migration will consist of these main steps:

- Update your Vendure dependencies to the latest versions
{  // ...  "dependencies": {-    "@vendure/common": "1.9.7",-    "@vendure/core": "1.9.7",+    "@vendure/common": "2.0.0",+    "@vendure/core": "2.0.0",     // etc.  },  "devDependencies": {-    "typescript": "4.3.5",+    "typescript": "4.9.5",     // etc.  }}
- Migrate your database. This is covered in detail in the database migration section.
- Update your custom code (configuration, plugins, admin ui extensions) to handle the breaking changes. Details of these changes are covered in the breaking API changes section.
- Update your storefront to handle some small breaking changes in the Shop GraphQL API. See the storefront migration section for details.

```
{  // ...  "dependencies": {-    "@vendure/common": "1.9.7",-    "@vendure/core": "1.9.7",+    "@vendure/common": "2.0.0",+    "@vendure/core": "2.0.0",     // etc.  },  "devDependencies": {-    "typescript": "4.3.5",+    "typescript": "4.9.5",     // etc.  }}
```

[database migration section](/guides/developer-guide/migrating-from-v1/database-migration)[breaking API changes section](/guides/developer-guide/migrating-from-v1/breaking-api-changes)[storefront migration section](/guides/developer-guide/migrating-from-v1/storefront-migration)


---

# v2 Database Migration


Vendure v2 introduces a number of breaking changes to the database schema, some of which require quite complex migrations in order to preserve existing data. To make this process as smooth as possible, we have created a migration tool which will handle the hard parts for you!

Important! It is critical that you back up your production data prior to attempting this migration.

Note for MySQL/MariaDB users: transactions for migrations are not supported by these databases. This means that if the migration fails for some reason, the statements that have executed will not get rolled back, and your DB schema can be left in an inconsistent state from which is it can be hard to recover. Therefore, it is doubly critical that you have a good backup that you can easily restore prior to attempting this migration.

[not supported by these databases](https://dev.mysql.com/doc/refman/5.7/en/cannot-roll-back.html)- Make sure all your Vendure packages to the latest v2 versions.
- Use your package manager to install the v2 migration tool: npm install @vendure/migrate-v2

Note, if you run into the error "Cannot find module '@ardatan/aggregate-error'", delete node_modules and the lockfile and reinstall.
- Note, if you run into the error "Cannot find module '@ardatan/aggregate-error'", delete node_modules and the lockfile and reinstall.
- Add the MigrationV2Plugin to your plugins array:
import { MigrationV2Plugin } from '@vendure/migrate-v2';//...const config: VendureConfig = {  //..  plugins: [    MigrationV2Plugin,  ]}
The sole function of this plugin is to temporarily remove some "NOT NULL" constraints from certain columns, which allows us to run the next part of the migration.
- Generate a new migration file, npm run migration:generate v2
- Edit the newly-created migration file by following the comments in these examples:

postgres
mysql

In your migrations files, you'll import the vendureV2Migrations from @vendure/migrate-v2.
- postgres
- mysql
- Run the migration with npm run migration:run.
- Upon successful migration, remove the MigrationV2Plugin from your plugins array, and generate another migration. This one will add back the missing "NOT NULL" constraints now that all your data has been successfully migrated.

Make sure all your Vendure packages to the latest v2 versions.

Use your package manager to install the v2 migration tool: npm install @vendure/migrate-v2

[v2 migration tool](https://github.com/vendure-ecommerce/v2-migration-tool)- Note, if you run into the error "Cannot find module '@ardatan/aggregate-error'", delete node_modules and the lockfile and reinstall.

Add the MigrationV2Plugin to your plugins array:

```
import { MigrationV2Plugin } from '@vendure/migrate-v2';//...const config: VendureConfig = {  //..  plugins: [    MigrationV2Plugin,  ]}
```

The sole function of this plugin is to temporarily remove some "NOT NULL" constraints from certain columns, which allows us to run the next part of the migration.

Generate a new migration file, npm run migration:generate v2

Edit the newly-created migration file by following the comments in these examples:

- postgres
- mysql

[postgres](https://github.com/vendure-ecommerce/v2-migration-tool/blob/master/src/migrations/1686649098749-v201-postgres.ts)[mysql](https://github.com/vendure-ecommerce/v2-migration-tool/blob/master/src/migrations/1686655918823-v201-mysql.ts)In your migrations files, you'll import the vendureV2Migrations from @vendure/migrate-v2.

Run the migration with npm run migration:run.

Upon successful migration, remove the MigrationV2Plugin from your plugins array, and generate another migration. This one will add back the missing "NOT NULL" constraints now that all your data has been successfully migrated.


---

# Breaking API Changes


## Breaks from updated dependencies​


[​](#breaks-from-updated-dependencies)
### TypeScript​


[​](#typescript)- v2 is built on TypeScript v4.9.5. You should update your TypeScript version to match this. Doing so is quite likely to reveal new compiler errors (as is usual with TypeScript minor release updates).
- If you are using ts-node, update it to the latest version
- If you are targeting ES2022 or ESNEXT in your tsconfig.json, you'll need to set "useDefineForClassFields": false. See this issue for more context.

[this issue](https://github.com/vendure-ecommerce/vendure/issues/2099)
### Apollo Server & GraphQL​


[​](#apollo-server--graphql)If you have any custom ApolloServerPlugins, the plugin methods must now return a Promise. Example:

```
export class TranslateErrorsPlugin implements ApolloServerPlugin {   constructor(private i18nService: I18nService) {}-  requestDidStart(): GraphQLRequestListener {+  async requestDidStart(): Promise<GraphQLRequestListener> {     return {-      willSendResponse: requestContext => {+      willSendResponse: async requestContext => {         const { errors, context } = requestContext;         if (errors) {           (requestContext.response as any).errors = errors.map(err => {             return this.i18nService.translateError(context.req, err as GraphQLError) as any;           });         }       },     };   }}
```

With the update to GraphQL v16, you might run into issues with other packages in the GraphQL ecosystem that also depend on the graphql package, such as graphql-code-generator. In this case these packages will also need to be updated.

For instance, if you are using the "typescript-compatibility" plugin to generate namespaced types, you'll need to drop this, as it is no longer maintained.

[no longer maintained](https://the-guild.dev/blog/whats-new-in-graphql-codegen-v2#typescript-compatibility)
### TypeORM​


[​](#typeorm)TypeORM 0.3.x introduced a large number of breaking changes. For a complete guide, see the TypeORM v0.3.0 release notes.

[TypeORM v0.3.0 release notes](https://github.com/typeorm/typeorm/releases/tag/0.3.0)Here are the main API changes you'll likely need to make:

- You can no longer compare to null, you need to use the new IsNull() helper:
+ import { IsNull } from 'typeorm';- .find({ where: { deletedAt: null } })+ .find({ where: { deletedAt: IsNull() } })
- The findOne() method returns null rather than undefined if a record is not found.
- The findOne() method no longer accepts an id argument. Lookup based on id must be done with a where clause:
- .findOne(variantId)+ .findOne({ where: { id: variantId } })
- Where clauses must use an entity id rather than passing an entity itself:
- .find({ where: { user } })+ .find({ where: { user: { id: user.id } } })
- The findByIds() method has been deprecated. Use the new In helper instead:
+ import { In } from 'typeorm';- .findByIds(ids)+ .find({ where: { id: In(ids) } })

```
+ import { IsNull } from 'typeorm';- .find({ where: { deletedAt: null } })+ .find({ where: { deletedAt: IsNull() } })
```

```
- .findOne(variantId)+ .findOne({ where: { id: variantId } })
```

```
- .find({ where: { user } })+ .find({ where: { user: { id: user.id } } })
```

```
+ import { In } from 'typeorm';- .findByIds(ids)+ .find({ where: { id: In(ids) } })
```

## Vendure TypeScript API Changes​


[​](#vendure-typescript-api-changes)
### Custom Order / Fulfillment / Payment processes​


[​](#custom-order--fulfillment--payment-processes)In v2, the hard-coded states & transition logic for the Order, Fulfillment and Payment state machines has been extracted from the core services and instead reside in a default OrderProcess, FulfillmentProcess and PaymentProcess object. This allows you to fully customize these flows without having to work around the assumptions & logic implemented by the default processes.

What this means is that if you are defining a custom process, you'll now need to explicitly add the default process to the array.

```
+ import { defaultOrderProcess } from '@vendure/core';orderOptions: {-  process: [myCustomOrderProcess],+  process: [defaultOrderProcess, myCustomOrderProcess],}
```

Also note that shippingOptions.customFulfillmentProcess and paymentOptions.customPaymentProcess are both now renamed to process. The old names are still usable but are deprecated.

### OrderItem no longer exists​


[​](#orderitem-no-longer-exists)As a result of #1981, the OrderItem entity no longer exists. The function and data of OrderItem is now transferred to OrderLine. As a result, the following APIs which previously used OrderItem arguments have now changed:

[#1981](https://github.com/vendure-ecommerce/vendure/issues/1981)- FulfillmentHandler
- ChangedPriceHandlingStrategy
- PromotionItemAction
- TaxLineCalculationStrategy

If you have implemented any of these APIs, you'll need to check each one, remove the OrderItem argument from any methods that are using it,
and update any logic as necessary.

You may also be joining the OrderItem relation in your own TypeORM queries, so you'll need to check for code like this:

```
const order = await this.connection  .getRepository(Order)  .createQueryBuilder('order')  .leftJoinAndSelect('order.lines', 'line')- .leftJoinAndSelect('line.items', 'items')
```

or

```
const order = await this.connection  .getRepository(Order)  .findOne(ctx, orderId, {-    relations: ['lines', 'lines.items'],+    relations: ['lines'],  });
```

### ProductVariant stock changes​


[​](#productvariant-stock-changes)With #1545 we have changed the way we model stock levels in order to support multiple stock locations. This means that the ProductVariant.stockOnHand and ProductVariant.stockAllocated properties no longer exist on the ProductVariant entity in TypeScript.

[#1545](https://github.com/vendure-ecommerce/vendure/issues/1545)Instead, this information is now located at ProductVariant.stockLevels, which is an array of StockLevel entities.

[StockLevel](/reference/typescript-api/entities/stock-level)
### New return type for Channel, TaxCategory & Zone lists​


[​](#new-return-type-for-channel-taxcategory--zone-lists)- The ChannelService.findAll() method now returns a PaginatedList<Channel> instead of Channel[].
- The channels GraphQL query now returns a PaginatedList rather than a simple array of Channels.
- The TaxCategoryService.findAll() method now returns a PaginatedList<TaxCategory> instead of TaxCategory[].
- The taxCategories GraphQL query now returns a PaginatedList rather than a simple array of TaxCategories.
- The ZoneService.findAll() method now returns a PaginatedList<Zone> instead of Zone[]. The old behaviour of ZoneService.findAll() (all Zones, cached for rapid access) can now be found under the new ZoneService.getAllWithMembers() method.
- The zones GraphQL query now returns a PaginatedList rather than a simple array of Zones.

### Admin UI changes​


[​](#admin-ui-changes)If you are using the @vendure/ui-devkit package to generate custom ui extensions, here are the breaking changes to be aware of:

- As part of the major refresh to the Admin UI app, certain layout elements had be changed which can cause your custom routes to look bad. Wrapping all your custom pages in <vdr-page-block> (or <div class="page-block"> if not built with Angular components) will improve things. There will soon be a comprehensive guide published on how to create seamless ui extensions that look just like the built-in screens.
- If you use any of the scoped method of the Admin UI DataService, you might find that some no longer exist. They are now deprecated and will eventually be removed. Use the dataService.query() and dataService.mutation() methods only, passing your own GraphQL documents:
 // Old waythis.dataService.product.getProducts().single$.subscribe(...);
 // New wayconst GET_PRODUCTS = gql`  query GetProducts {    products {      items {        id        name        # ... etc      }    }  }`;this.dataService.query(GET_PRODUCTS).single$.subscribe(...);

- The Admin UI component vdr-product-selector has been renamed to vdr-product-variant-selector to more accurately represent what it does. If you are using vdr-product-selector if any ui extensions code, update it to use the new selector.

```
 // Old waythis.dataService.product.getProducts().single$.subscribe(...);
```

```
 // New wayconst GET_PRODUCTS = gql`  query GetProducts {    products {      items {        id        name        # ... etc      }    }  }`;this.dataService.query(GET_PRODUCTS).single$.subscribe(...);

```

### Other breaking API changes​


[​](#other-breaking-api-changes)- End-to-end tests using Jest will likely run into issues due to our move towards using some dependencies that make use of ES modules. We have found the best solution to be to migrate tests over to Vitest, which can handle this and is also significantly faster than Jest. See the updated Testing guide for instructions on getting started with Vitest.
- Internal ErrorResult classes now take a single object argument rather than multiple args.
- All monetary values are now represented in the GraphQL APIs with a new Money scalar type. If you use graphql-code-generator, you'll want to tell it to treat this scalar as a number:
import { CodegenConfig } from '@graphql-codegen/cli'const config: CodegenConfig = {  schema: 'http://localhost:3000/shop-api',  documents: ['src/**/*graphql.ts'],  config: {    scalars: {      Money: 'number',    },  },  generates: {    // ..   }};
- A new Region entity has been introduced, which is a base class for Country and the new Province entity. The Zone.members property is now an array of Region rather than Country, since Zones may now be composed of both countries and provinces. If you have defined any custom fields on Country, you'll need to change it to Region in your custom fields config.
- If you are using the s3 storage strategy of the AssetServerPlugin, it has been updated to use v3 of the AWS SDKs. This update introduces an improved modular architecture to the AWS sdk, resulting in smaller bundle sizes. You need to install the @aws-sdk/client-s3 & @aws-sdk/lib-storage packages, and can remove the aws-sdk package. If you are using it in combination with MinIO, you'll also need to rename a config property and provide a region:
nativeS3Configuration: {   endpoint: 'http://localhost:9000',-  s3ForcePathStyle: true,+  forcePathStyle: true,   signatureVersion: 'v4',+  region: 'eu-west-1',}
- The Stripe plugin has been made channel aware. This means your api key and webhook secret are now stored in the database, per channel, instead of environment variables.
To migrate to v2 of the Stripe plugin from @vendure/payments you need to:

Remove the apiKey and webhookSigningSecret from the plugin initialization in vendure-config.ts:
StripePlugin.init({-  apiKey: process.env.YOUR_STRIPE_SECRET_KEY,-  webhookSigningSecret: process.env.YOUR_STRIPE_WEBHOOK_SIGNING_SECRET,   storeCustomersInStripe: true,}),

Start the server and login as administrator. For each channel that you'd like to use Stripe payments, you need to create a payment method with payment handler Stripe payment and the apiKey and webhookSigningSecret belonging to that channel's Stripe account.
- Remove the apiKey and webhookSigningSecret from the plugin initialization in vendure-config.ts:
StripePlugin.init({-  apiKey: process.env.YOUR_STRIPE_SECRET_KEY,-  webhookSigningSecret: process.env.YOUR_STRIPE_WEBHOOK_SIGNING_SECRET,   storeCustomersInStripe: true,}),
- Start the server and login as administrator. For each channel that you'd like to use Stripe payments, you need to create a payment method with payment handler Stripe payment and the apiKey and webhookSigningSecret belonging to that channel's Stripe account.
- If you are using the BullMQJobQueuePlugin, the minimum Redis recommended version is 6.2.0.
- The WorkerHealthIndicator which was deprecated in v1.3.0 has been removed, as well as the jobQueueOptions.enableWorkerHealthCheck config option.
- The CustomerGroupEntityEvent (fired on creation, update or deletion of a CustomerGroup) has been renamed to CustomerGroupEvent, and the former CustomerGroupEvent (fired when Customers are added to or removed from a group) has been renamed to CustomerGroupChangeEvent.
- We introduced the plugin compatibility API to allow plugins to indicate what version of Vendure they are compatible with. To avoid bootstrap messages you should add this property to your plugins.

[Vitest](https://vitest.dev)[Testing guide](/guides/developer-guide/testing)[graphql-code-generator](https://the-guild.dev/graphql/codegen)
```
import { CodegenConfig } from '@graphql-codegen/cli'const config: CodegenConfig = {  schema: 'http://localhost:3000/shop-api',  documents: ['src/**/*graphql.ts'],  config: {    scalars: {      Money: 'number',    },  },  generates: {    // ..   }};
```

[improved modular architecture to the AWS sdk](https://aws.amazon.com/blogs/developer/modular-packages-in-aws-sdk-for-javascript/)
```
nativeS3Configuration: {   endpoint: 'http://localhost:9000',-  s3ForcePathStyle: true,+  forcePathStyle: true,   signatureVersion: 'v4',+  region: 'eu-west-1',}
```

- Remove the apiKey and webhookSigningSecret from the plugin initialization in vendure-config.ts:
StripePlugin.init({-  apiKey: process.env.YOUR_STRIPE_SECRET_KEY,-  webhookSigningSecret: process.env.YOUR_STRIPE_WEBHOOK_SIGNING_SECRET,   storeCustomersInStripe: true,}),
- Start the server and login as administrator. For each channel that you'd like to use Stripe payments, you need to create a payment method with payment handler Stripe payment and the apiKey and webhookSigningSecret belonging to that channel's Stripe account.

```
StripePlugin.init({-  apiKey: process.env.YOUR_STRIPE_SECRET_KEY,-  webhookSigningSecret: process.env.YOUR_STRIPE_WEBHOOK_SIGNING_SECRET,   storeCustomersInStripe: true,}),
```

[plugin compatibility API](/guides/developer-guide/plugins/#step-7-specify-compatibility)


---

# Storefront migration


There are relatively few breaking changes that will affect the storefront.

- The setOrderShippingMethod mutation now takes an array of shipping method IDs rather than just a single one. This is so we can support multiple shipping methods per Order.
-mutation setOrderShippingMethod($shippingMethodId: ID!) {+mutation setOrderShippingMethod($shippingMethodId: [ID!]!) {  setOrderShippingMethod(shippingMethodId: $shippingMethodId) {    # ... etc  }}

- The OrderLine.fulfillments field has been changed to OrderLine.fulfillmentLines. Your storefront may be using this when displaying the details of an Order.
- If you are using the graphql-code-generator package to generate types for your storefront, all monetary values such as Order.totalWithTax or ProductVariant.priceWithTax are now represented by the new Money scalar rather than by an Int. You'll need to tell your codegen about this scalar and configure it to be interpreted as a number type:
documents:  - "app/**/*.{ts,tsx}"  - "!app/generated/*"+config:+  scalars:+    Money: numbergenerates:  # ... etc


```
-mutation setOrderShippingMethod($shippingMethodId: ID!) {+mutation setOrderShippingMethod($shippingMethodId: [ID!]!) {  setOrderShippingMethod(shippingMethodId: $shippingMethodId) {    # ... etc  }} 

```

```
documents:  - "app/**/*.{ts,tsx}"  - "!app/generated/*"+config:+  scalars:+    Money: numbergenerates:  # ... etc

```