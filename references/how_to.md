# Vendure - How To

**Pages:** 12

---

## Digital Products

**URL:** https://docs.vendure.io/guides/how-to/digital-products/

**Contents:**
- Digital Products
- Creating the plugin​
  - Define custom fields​
  - Create a custom FulfillmentHandler​
  - Create a custom ShippingEligibilityChecker​
  - Create a custom ShippingLineAssignmentStrategy​
  - Define a custom OrderProcess​
  - Complete plugin & add to config​
- Create the ShippingMethod​
- Mark digital products​

Digital products include things like ebooks, online courses, and software. They are products that are delivered to the customer electronically, and do not require physical shipping.

This guide will show you how you can add support for digital products to Vendure.

The complete source of the following example plugin can be found here: example-plugins/digital-products

If some products are digital and some are physical, we can distinguish between them by adding a customField to the ProductVariant entity.

You will need to create a migration after adding this custom field. See the Migrations guide for more information.

We will also define a custom field on the ShippingMethod entity to indicate that this shipping method is only available for digital products:

Lastly we will define a custom field on the Fulfillment entity where we can store download links for the digital products. If your own implementation you may wish to handle this part differently, e.g. storing download links on the Order entity or in a custom entity.

The FulfillmentHandler is responsible for creating the Fulfillment entities when an Order is fulfilled. We will create a custom handler which is responsible for performing the logic related to generating the digital download links.

In your own implementation, this may look significantly different depending on your requirements.

This fulfillment handler should then be added to the fulfillmentHandlers array the config ShippingOptions:

We want to ensure that the digital shipping method is only applicable to orders containing at least one digital product. We do this with a custom ShippingEligibilityChecker:

When adding shipping methods to the order, we want to ensure that digital products are correctly assigned to the digital shipping method, and physical products are not.

In order to automatically fulfill any digital products as soon as the order completes, we can define a custom OrderProcess:

The complete plugin can be found here: example-plugins/digital-products

We can now add the plugin to the VendureConfig:

Once these parts have been defined and bundled up in a Vendure plugin, we can create a new ShippingMethod via the Dashboard, and make sure to check the "isDigital" custom field, and select the custom fulfillment handler and eligibility checker:

We can now also set any digital product variants by checking the custom field:

In the storefront, when the customer is checking out, we can use the eligibleShippingMethods query to det

*[Content truncated]*

**Examples:**

Example 1 (ts):
```ts
import { LanguageCode, PluginCommonModule, VendurePlugin } from '@vendure/core';@VendurePlugin({    imports: [PluginCommonModule],    configuration: config => {        config.customFields.ProductVariant.push({            type: 'boolean',            name: 'isDigital',            defaultValue: false,            label: [{ languageCode: LanguageCode.en, value: 'This product is digital' }],            public: true,        });        return config;    },})export class DigitalProductsPlugin {}
```

Example 2 (ts):
```ts
import { LanguageCode, PluginCommonModule, VendurePlugin } from '@vendure/core';@VendurePlugin({    imports: [PluginCommonModule],    configuration: config => {        // config.customFields.ProductVariant.push({ ... omitted        config.customFields.ShippingMethod.push({            type: 'boolean',            name: 'digitalFulfilmentOnly',            defaultValue: false,            label: [{ languageCode: LanguageCode.en, value: 'Digital fulfilment only' }],            public: true,        });        return config;    },})
```

Example 3 (ts):
```ts
import { LanguageCode, PluginCommonModule, VendurePlugin } from '@vendure/core';@VendurePlugin({    imports: [PluginCommonModule],    configuration: config => {        // config.customFields.ProductVariant.push({ ... omitted        // config.customFields.ShippingMethod.push({ ... omitted        config.customFields.Fulfillment.push({            type: 'string',            name: 'downloadUrls',            nullable: true,            list: true,            label: [{ languageCode: LanguageCode.en, value: 'Urls of any digital purchases' }],            public: true,        });        return config;   
...
```

Example 4 (ts):
```ts
import { FulfillmentHandler, LanguageCode, OrderLine, TransactionalConnection } from '@vendure/core';import { In } from 'typeorm';let connection: TransactionalConnection;/** * @description * This is a fulfillment handler for digital products which generates a download url * for each digital product in the order. */export const digitalFulfillmentHandler = new FulfillmentHandler({    code: 'digital-fulfillment',    description: [        {            languageCode: LanguageCode.en,            value: 'Generates product keys for the digital download',        },    ],    args: {},    init: injector =
...
```

---

## GitHub OAuth Authentication

**URL:** https://docs.vendure.io/guides/how-to/github-oauth-authentication/

**Contents:**
- GitHub OAuth Authentication
- Creating the Plugin​
- Creating the Authentication Strategy​
- Registering the Strategy​
- Adding to Vendure Config​
- Setting up GitHub OAuth App​
- Frontend Integration​
  - Creating the Sign-in URL​
  - Handling the Callback​
- Using the GraphQL API​

The complete source of the following example plugin can be found here: example-plugins/github-auth-plugin

GitHub OAuth authentication allows customers to sign in using their GitHub accounts, eliminating the need for password-based registration.

This is particularly valuable for developer-focused stores or B2B marketplaces.

This guide shows you how to add GitHub OAuth support to your Vendure store using a custom AuthenticationStrategy.

First, use the Vendure CLI to create a new plugin for GitHub authentication:

This creates a basic plugin structure with the necessary files.

Now create the GitHub authentication strategy. This handles the OAuth flow and creates customer accounts using GitHub profile data:

The strategy uses Vendure's ExternalAuthenticationService to handle customer creation.

It generates a unique email address for each GitHub user to avoid conflicts, and stores the GitHub username as the external identifier for future logins.

Now update the generated plugin file to register your authentication strategy:

Add the plugin to your Vendure configuration:

Before you can test the integration, you need to create a GitHub OAuth App:

The localhost URLs shown here are for local development only. In production, replace localhost:3001 with your actual domain (e.g., https://mystore.com).

Add these credentials to your environment:

In your storefront, create a function to generate the GitHub authorization URL:

Create a callback handler to process the GitHub response and authenticate with Vendure:

The OAuth flow follows these steps:

Once your plugin is running, the GitHub authentication will be available in your shop API:

GitHub-authenticated customers are managed like any other Vendure Customer:

This means GitHub users work seamlessly with Vendure's order management, promotions, and customer workflows.

To test your GitHub OAuth integration:

**Examples:**

Example 1 (bash):
```bash
npx vendure add -p GitHubAuthPlugin
```

Example 2 (ts):
```ts
import { AuthenticationStrategy, ExternalAuthenticationService, Injector, RequestContext, User } from '@vendure/core';import { DocumentNode } from 'graphql';import gql from 'graphql-tag';export interface GitHubAuthData {  code: string;  state: string;}export interface GitHubAuthOptions {  clientId: string;  clientSecret: string;}export class GitHubAuthenticationStrategy implements AuthenticationStrategy<GitHubAuthData> {  readonly name = 'github';  private externalAuthenticationService: ExternalAuthenticationService;  constructor(private options: GitHubAuthOptions) {}  init(injector: Injector)
...
```

Example 3 (ts):
```ts
import { PluginCommonModule, VendurePlugin } from '@vendure/core';import { GitHubAuthenticationStrategy, GitHubAuthOptions } from './github-auth-strategy';@VendurePlugin({  imports: [PluginCommonModule],  configuration: config => {    config.authOptions.shopAuthenticationStrategy.push(new GitHubAuthenticationStrategy(GitHubAuthPlugin.options));    return config;  },})export class GitHubAuthPlugin {  static options: GitHubAuthOptions;  static init(options: GitHubAuthOptions) {    this.options = options;    return GitHubAuthPlugin;  }}
```

Example 4 (ts):
```ts
import { VendureConfig } from '@vendure/core';import { GitHubAuthPlugin } from './plugins/github-auth-plugin/github-auth-plugin.plugin';export const config: VendureConfig = {  // ... other config  plugins: [    // ... other plugins    GitHubAuthPlugin.init({      clientId: process.env.GITHUB_CLIENT_ID!,      clientSecret: process.env.GITHUB_CLIENT_SECRET!,    }),  ],  // ... rest of config};
```

---

## Multi-vendor Marketplaces

**URL:** https://docs.vendure.io/guides/how-to/multi-vendor-marketplaces/

**Contents:**
- Multi-vendor Marketplaces
- Multi-vendor plugin​
- Sellers, Channels & Roles​
  - Keeping prices synchronized​
- Assigning OrderLines to the correct Seller​
- Shipping​
- Splitting orders & payment​
- Custom OrderProcess​

Vendure v2.0 introduced a number of changes and new APIs to enable developers to build multi-vendor marketplace apps.

This is a type of application in which multiple sellers are able to list products, and then customers can create orders containing products from one or more of these sellers. Well-known examples include Amazon, Ebay, Etsy and Airbnb.

This guide introduces the major concepts & APIs you will need to understand in order to implement your own multi-vendor marketplace application.

All the concepts presented here have been implemented in our example multi-vendor plugin. The guides here will refer to specific parts of this plugin which you should consult to get a full understanding of how an implementation would look.

Note: the example multi-vendor plugin is for educational purposes only, and for the sake of clarity leaves out several parts that would be required in a production-ready solution, such as email verification and setup of a real payment solution.

The core of Vendure's multi-vendor support is Channels. Read the Channels guide to get a more detailed understanding of how they work.

Each Channel is assigned to a Seller, which is another term for the vendor who is selling things in our marketplace.

So the first thing to do is to implement a way to create a new Channel and Seller.

In the multi-vendor plugin, we have defined a new mutation in the Shop API which allows a new seller to register on our marketplace:

Executing the registerNewSeller mutation does the following:

Bob can now log in to the Dashboard using the provided credentials and begin creating products to sell!

In some marketplaces, the same product may be sold by multiple sellers. When this is the case, the product and its variants will be assigned not only to the default channel, but to multiple other channels as well - see the Channels, Currencies & Prices section for a visual explanation of how this works.

This means that there will be multiple ProductVariantPrice entities per variant, one for each channel.

In order to keep prices synchronized across all channels, the example multi-vendor plugin sets the syncPricesAcrossChannels property of the DefaultProductVariantPriceUpdateStrategy to true. Your own multi-vendor implementation may require more sophisticated price synchronization logic, in which case you can implement your own custom ProductVariantPriceUpdateStrategy.

In order to correctly split the Order later, we need to assign each added OrderLine to the co

*[Content truncated]*

**Examples:**

Example 1 (graphql):
```graphql
mutation RegisterSeller {  registerNewSeller(input: {    shopName: "Bob's Parts",    seller: {      firstName: "Bob"      lastName: "Dobalina"      emailAddress: "bob@bobs-parts.com"      password: "test",    }  }) {    id    code    token  }}
```

Example 2 (ts):
```ts
export class MultivendorSellerStrategy implements OrderSellerStrategy {  // other properties omitted for brevity         async setOrderLineSellerChannel(ctx: RequestContext, orderLine: OrderLine) {    await this.entityHydrator.hydrate(ctx, orderLine.productVariant, { relations: ['channels'] });    const defaultChannel = await this.channelService.getDefaultChannel();      // If a ProductVariant is assigned to exactly 2 Channels, then one is the default Channel    // and the other is the seller's Channel.    if (orderLine.productVariant.channels.length === 2) {      const sellerChannel = orderLi
...
```

Example 3 (ts):
```ts
export const multivendorShippingEligibilityChecker = new ShippingEligibilityChecker({  // other properties omitted for brevity         check: async (ctx, order, args, method) => {    await entityHydrator.hydrate(ctx, method, { relations: ['channels'] });    await entityHydrator.hydrate(ctx, order, { relations: ['lines.sellerChannel'] });    const sellerChannel = method.channels.find(c => c.code !== DEFAULT_CHANNEL_CODE);    if (!sellerChannel) {      return false;    }    for (const line of order.lines) {      if (idsAreEqual(line.sellerChannelId, sellerChannel.id)) {        return true;      
...
```

Example 4 (graphql):
```graphql
mutation SetShippingMethod($ids: [ID!]!) {  setOrderShippingMethod(shippingMethodId: $ids) {    ... on Order {      id      state      # ...etc    }    ... on ErrorResult {      errorCode      message    }  }}
```

---

## Integrating S3-Compatible Asset Storage

**URL:** https://docs.vendure.io/guides/how-to/s3-asset-storage/

**Contents:**
- Integrating S3-Compatible Asset Storage
- Working Example Repository​
- Prerequisites​
- S3-Compatible Storage Provider Setup​
  - Setting up AWS S3​
  - Setting up Supabase S3 Storage​
  - Setting up DigitalOcean Spaces​
  - Setting up CloudFlare R2​
  - Setting up Hetzner Object Storage​
  - Setting up MinIO (Self-Hosted)​

This guide demonstrates how to integrate S3-compatible asset storage into your Vendure application using multiple cloud storage platforms. You'll learn to configure a single, platform-agnostic storage solution that works seamlessly with AWS S3, DigitalOcean Spaces, MinIO, CloudFlare R2, and Supabase Storage.

This guide is based on the s3-file-storage example. Refer to the complete working code for full implementation details.

Configure your chosen storage provider by following the setup instructions for your preferred platform:

Create IAM User with S3 Permissions

Environment Variables

Create Supabase Project

Generate Service Role Key

Environment Variables

Replace your-project-ref with your actual Supabase project reference ID found in your project settings.

Create a DigitalOcean Account

Generate Spaces Access Keys

Configure CORS Policy (Optional) For browser-based uploads, configure CORS in your Space settings:

Environment Variables

Use the regional endpoint (e.g., https://fra1.digitaloceanspaces.com) not the CDN endpoint. The AWS SDK constructs URLs automatically.

Create CloudFlare Account

Enable R2 Object Storage

Environment Variables

Replace your-account-id with your actual CloudFlare account ID. If using a custom domain, update S3_FILE_URL to point to your custom domain with https://.

Create Hetzner Cloud Account

Access Object Storage Service

Create Storage Bucket

Generate S3 API Credentials

Environment Variables

Replace fsn1 with your chosen location (e.g., nbg1 for Nuremberg). The endpoint URL will match your bucket's location. Ensure the region and endpoint location match.

Option A: Using Docker (Recommended)

Option B: Direct Installation

The MinIO web console in development setups typically only shows bucket management. For access key creation, use the MinIO CLI:

Install MinIO Client (if not already installed):

Configure and create access keys:

⚠️ Important: Save both keys immediately as the Secret Key won't be shown again

Create Storage Bucket

Alternative using CLI:

Configure Public Access Policy

For public asset access, set the bucket policy using the MinIO CLI (console UI may not have policy editor):

Alternative simple approach:

Environment Variables

Configure your Vendure application to use S3-compatible asset storage by modifying your vendure-config.ts:

IMPORTANT: The configuration uses a conditional approach - when S3_BUCKET is set, it activates S3 storage; otherwise, it falls back to local file storage. T

*[Content truncated]*

**Examples:**

Example 1 (bash):
```bash
# AWS S3 ConfigurationS3_BUCKET=my-vendure-assetsS3_ACCESS_KEY_ID=AKIA...S3_SECRET_ACCESS_KEY=wJalrXUtn...S3_REGION=us-east-1# Leave S3_ENDPOINT empty for AWS S3# Leave S3_FORCE_PATH_STYLE empty for AWS S3
```

Example 2 (bash):
```bash
# Supabase Storage ConfigurationS3_BUCKET=assetsS3_ACCESS_KEY_ID=your-supabase-access-key-idS3_SECRET_ACCESS_KEY=your-service-role-keyS3_REGION=us-east-1S3_ENDPOINT=https://your-project-ref.supabase.co/storage/v1/s3S3_FORCE_PATH_STYLE=true
```

Example 3 (json):
```json
[  {    "allowed_origins": ["https://yourdomain.com"],    "allowed_methods": ["GET", "POST", "PUT"],    "allowed_headers": ["*"],    "max_age": 3000  }]
```

Example 4 (bash):
```bash
# DigitalOcean Spaces ConfigurationS3_BUCKET=my-vendure-assetsS3_ACCESS_KEY_ID=DO00...S3_SECRET_ACCESS_KEY=wJalrXUtn...S3_REGION=fra1S3_ENDPOINT=https://fra1.digitaloceanspaces.comS3_FORCE_PATH_STYLE=false
```

---

## Paginated lists

**URL:** https://docs.vendure.io/guides/how-to/paginated-list/

**Contents:**
- Paginated lists
- API definition​
- Resolver​
- Service​
- Usage​
- Advanced filtering​
- Filtering by custom properties​

Vendure's list queries follow a set pattern which allows for pagination, filtering & sorting. This guide will demonstrate how to implement your own paginated list queries.

Let's start with defining the GraphQL schema for our query. In this example, we'll image that we have defined a custom entity to represent a ProductReview. We want to be able to query a list of reviews in the Admin API. Here's how the schema definition would look:

Note that we need to follow these conventions:

Given this schema, at runtime Vendure will automatically generate the ProductReviewListOptions input type, including all the filtering & sorting fields. This means that we don't need to define the input type ourselves.

Next, we need to define the resolver for the query.

Finally, we need to implement the findAll() method on the ProductReviewService. Here we will use the ListQueryBuilder to build the list query. The ListQueryBuilder will take care of

Given the above parts of the plugin, we can now query the list of reviews in the Admin API:

In the above example, we are querying the first 10 reviews, sorted by createdAt in descending order, and filtered to only include reviews with a rating between 3 and 5.

Vendure v2.2.0 introduced the ability to construct complex nested filters on any PaginatedList query. For example, we could filter the above query to only include reviews for products with a name starting with "Smartphone":

In the example above, we are filtering for reviews of products with the word "phone" and a rating of 4 or more, or a rating of 0. The _and and _or operators can be nested to any depth, allowing for arbitrarily complex filters.

By default, the ListQueryBuilder will only allow filtering by properties which are defined on the entity itself. So in the case of the ProductReview, we can filter by rating and text etc., but not by product.name.

However, it is possible to extend your GraphQL type to allow filtering by custom properties. Let's implement filtering but the product.name property. First, we need to manually add the productName field to the ProductReviewFilterParameter type:

Next we need to update our ProductReviewService to be able to handle filtering on this new field using the customPropertyMap option:

Upon restarting your server, you should now be able to filter by productName:

**Examples:**

Example 1 (ts):
```ts
import gql from 'graphql-tag';export const adminApiExtensions = gql`type ProductReview implements Node {  id: ID!  createdAt: DateTime!  updatedAt: DateTime!  product: Product!  productId: ID!  text: String!  rating: Float!}type ProductReviewList implements PaginatedList {  items: [ProductReview!]!  totalItems: Int!}# Generated at run-time by Vendureinput ProductReviewListOptionsextend type Query {   productReviews(options: ProductReviewListOptions): ProductReviewList!}`;
```

Example 2 (ts):
```ts
import { Args, Query, Resolver } from '@nestjs/graphql';import { Ctx, PaginatedList, RequestContext } from '@vendure/core';import { ProductReview } from '../entities/product-review.entity';import { ProductReviewService } from '../services/product-review.service';@Resolver()export class ProductReviewAdminResolver {    constructor(private productReviewService: ProductReviewService) {}    @Query()    async productReviews(        @Ctx() ctx: RequestContext,        @Args() args: any,    ): Promise<PaginatedList<ProductReview>> {        return this.productReviewService.findAll(ctx, args.options || u
...
```

Example 3 (ts):
```ts
import { Injectable } from '@nestjs/common';import { InjectConnection } from '@nestjs/typeorm';import { ListQueryBuilder, ListQueryOptions, PaginatedList, RequestContext } from '@vendure/core';import { ProductReview } from '../entities/product-review.entity';@Injectable()export class ProductReviewService {    constructor(        private listQueryBuilder: ListQueryBuilder,    ) {}    findAll(ctx: RequestContext, options?: ListQueryOptions<ProductReview>): Promise<PaginatedList<ProductReview>> {        return this.listQueryBuilder            .build(ProductReview, options, { relations: ['product'
...
```

Example 4 (graphql):
```graphql
query {  productReviews(    options: {      skip: 0      take: 10      sort: {        createdAt: DESC      }      filter: {        rating: {          between: { start: 3, end: 5 }        }      }    }) {    totalItems    items {      id      createdAt      product {        name      }      text      rating    }  }}
```

---

## Open Telemetry

**URL:** https://docs.vendure.io/guides/how-to/telemetry/

**Contents:**
- Open Telemetry
- Setup​
  - Set up Jaeger, Loki & Grafana​
  - Install the Telemetry Plugin​
  - Set environment variables​
  - Create a preload script​
- Viewing Logs​
- Viewing Traces​
- Instrumenting Your Plugins​

Open Telemetry is a set of APIs, libraries, agents, and instrumentation to provide observability for applications. It provides a standard way to collect and export telemetry data such as traces, metrics, and logs from applications.

From Vendure v3.3, Vendure has built-in support for Open Telemetry, via the @vendure/telemetry-plugin package. This package provides a set of decorators and utilities to instrument Vendure services and entities with Open Telemetry.

In this guide we will set up a local Vendure server with Open Telemetry, collecting traces and logs using the following parts:

There are many other tools and services that can be used with Open Telemetry, such as Prometheus, Zipkin, Sentry, Dynatrace and others.

In this guide we have chosen some widely-used and open-source tools to demonstrate the capabilities of Open Telemetry.

We will be using Docker to run Jaeger, Loki, and Grafana locally. Create a file called docker-compose.yml in the root of your project (standard Vendure installations already have one) and add the following contents:

You can start the services using the following command:

Once the images have downloaded and the containers are running, you can access:

Add the plugin to your Vendure config:

In order to send telemetry data to the Jaeger and Loki services, you need to set some environment variables. In a standard Vendure installation, there is an .env file in the root of the project. We will add the following:

The Open Telemetry libraries for Node.js instrument underlying libraries such as NestJS, GraphQL, Redis, database drivers, etc. to collect telemetry data. In order to do this, they need to be preloaded before any of the Vendure application code. This is done by means of a preload script.

Create a file called preload.ts in the src dir of your project with the following contents:

There are many, many configuration options available for Open Telemetry. The above is an example that works with the services used in this guide. The important things is to make sure the use the getSdkConfiguration function from the @vendure/telemetry-plugin/preload package, as this will ensure that the Vendure core is instrumented correctly.

To run the preload script, you need to set the --require flag when starting the Vendure server. We will also set an environment variable to distinguish the server from the worker process.

You can do this by adding the following script to your package.json:

Once you have started up your server with t

*[Content truncated]*

**Examples:**

Example 1 (yaml):
```yaml
services:    jaeger:        image: jaegertracing/all-in-one:latest        ports:            - '4318:4318' # OTLP HTTP receiver            - '16686:16686' # Web UI        environment:            - COLLECTOR_OTLP_ENABLED=true        volumes:            - jaeger_data:/badger        networks:            - jaeger    loki:        image: grafana/loki:3.4        ports:            - '3100:3100'        networks:            - loki    grafana:        environment:            - GF_PATHS_PROVISIONING=/etc/grafana/provisioning            - GF_AUTH_ANONYMOUS_ENABLED=true            - GF_AUTH_ANONYMOUS_ORG_ROLE
...
```

Example 2 (bash):
```bash
docker-compose up -d jaeger loki grafana
```

Example 3 (bash):
```bash
npm install @vendure/telemetry-plugin
```

Example 4 (ts):
```ts
import { VendureConfig, LogLevel } from '@vendure/core';import { TelemetryPlugin } from '@vendure/telemetry-plugin';export const config: VendureConfig = {    // ... other config options    plugins: [        TelemetryPlugin.init({            loggerOptions: {                // Optional: log to the console as well as                // sending to the telemetry server. Can be                // useful for debugging.                logToConsole: LogLevel.Verbose,            },        }),    ],};
```

---

## Configurable Products

**URL:** https://docs.vendure.io/guides/how-to/configurable-products/

**Contents:**
- Configurable Products
- Defining custom fields​
- Setting the custom field value​
- Modifying the price​

A "configurable product" is one where aspects can be configured by the customer, and are unrelated to the product's variants. Examples include:

In Vendure this is done by defining one or more custom fields on the OrderLine entity.

Let's take the example of an engraving service. Some products can be engraved, others cannot. We will record this information in a custom field on the ProductVariant entity:

For those variants that are engravable, we need to be able to record the text to be engraved. This is done by defining a custom field on the OrderLine entity:

Once the custom fields are defined, the addItemToOrder mutation will have a third argument available, which accepts values for the custom field defined above:

Your storefront application will need to provide a <textarea> for the customer to enter the engraving text, which would be displayed conditionally depending on the value of the engravable custom field on the ProductVariant.

The values of these OrderLine custom fields can even be used to modify the price. This is done by defining a custom OrderItemPriceCalculationStrategy.

Let's say that our engraving service costs and extra $10 on top of the regular price of the product variant. Here's a strategy to implement this:

This is then added to the config:

**Examples:**

Example 1 (ts):
```ts
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    customFields: {        ProductVariant: [            {                name: 'engravable',                type: 'boolean',                defaultValue: false,                label: [                    { languageCode: LanguageCode.en, value: 'Engravable' },                ],            },        ],    },};
```

Example 2 (ts):
```ts
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    customFields: {        OrderLine: [            {                name: 'engravingText',                type: 'string',                validate: value => {                    if (value.length > 100) {                        return 'Engraving text must be less than 100 characters';                    }                },                label: [                    { languageCode: LanguageCode.en, value: 'Engraving text' },                ],            },        ]    },};
```

Example 3 (graphql):
```graphql
mutation {    addItemToOrder(        productVariantId: "42"        quantity: 1        customFields: {            engravingText: "Thanks for all the fish!"        }    ) {        ...on Order {            id            lines {                id                quantity                customFields {                    engravingText                }            }        }    }}
```

Example 4 (ts):
```ts
import {    RequestContext, PriceCalculationResult,    ProductVariant, OrderItemPriceCalculationStrategy} from '@vendure/core';export class EngravingPriceStrategy implements OrderItemPriceCalculationStrategy {    calculateUnitPrice(        ctx: RequestContext,        productVariant: ProductVariant,        customFields: { engravingText?: string },    ) {        let price = productVariant.listPrice;        if (customFields.engravingText) {            // Add $10 for engraving            price += 1000;        }        return {            price,            priceIncludesTax: productVariant.listPrice
...
```

---

## Google OAuth Authentication

**URL:** https://docs.vendure.io/guides/how-to/google-oauth-authentication/

**Contents:**
- Google OAuth Authentication
- Creating the Plugin​
- Installing Dependencies​
- Creating the Authentication Strategy​
- Registering the Strategy​
- Adding to Vendure Config​
- Setting up Google OAuth App​
- Frontend Integration​
  - Creating the Sign-in Component​
  - Creating the Authentication Function​

The complete source of the following example plugin can be found here: example-plugins/google-auth-plugin

Google OAuth authentication allows customers to sign in using their Google accounts, providing a seamless experience that eliminates the need for password-based registration.

This is particularly valuable for consumer-facing stores where users prefer the convenience and security of Google's authentication system, or for B2B platforms where organizations use Google Workspace.

This guide shows you how to add Google OAuth support to your Vendure store using a custom AuthenticationStrategy and Google Identity Services.

An AuthenticationStrategy in Vendure defines how users can log in to your store. Learn more about authentication in Vendure.

First, use the Vendure CLI to create a new plugin for Google authentication:

This creates a basic plugin structure with the necessary files.

Google authentication requires the Google Auth Library for token verification:

This library handles ID token verification securely on the server side, ensuring the tokens received from Google are authentic.

Now create the Google authentication strategy. Unlike traditional OAuth flows that use authorization codes, Google Identity Services provides ID tokens directly, which we verify server-side:

The strategy uses Google's OAuth2Client to verify ID tokens and Vendure's ExternalAuthenticationService to handle customer creation.

Key differences from other OAuth flows:

Now update the generated plugin file to register your authentication strategy:

Add the plugin to your Vendure configuration:

Before you can test the integration, you need to create a Google OAuth 2.0 Client:

The localhost URLs shown here are for local development only. In production, replace localhost:3001 with your actual domain (e.g., https://mystore.com).

Add the client ID to your environment:

For the frontend, we'll use Google's official Identity Services library, which provides a secure and user-friendly sign-in experience:

Create a server action to handle the Google authentication:

Add your Google Client ID to the frontend environment:

The Google Identity Services flow works as follows:

Once your plugin is running, Google authentication will be available in your shop API:

Google-authenticated customers are managed like any other Vendure Customer:

This means Google users work seamlessly with Vendure's order management, promotions, and all customer workflows.

To test your Google OAuth integrat

*[Content truncated]*

**Examples:**

Example 1 (bash):
```bash
npx vendure add -p GoogleAuthPlugin
```

Example 2 (bash):
```bash
npm install google-auth-library
```

Example 3 (ts):
```ts
import {  AuthenticationStrategy,  ExternalAuthenticationService,  Injector,  Logger,  RequestContext,  User,} from '@vendure/core';import { OAuth2Client } from 'google-auth-library';import { DocumentNode } from 'graphql';import { gql } from 'graphql-tag';export type GoogleAuthData = {  token: string;}export interface GoogleAuthOptions {  googleClientId: string;  onUserCreated?: (ctx: RequestContext, injector: Injector, user: User) => void;  onUserFound?: (ctx: RequestContext, injector: Injector, user: User) => void;}export class GoogleAuthStrategy implements AuthenticationStrategy<GoogleAuthD
...
```

Example 4 (ts):
```ts
import { PluginCommonModule, VendurePlugin } from '@vendure/core';import { GoogleAuthStrategy } from './google-auth-strategy';export interface GoogleAuthPluginOptions {  googleClientId: string;}@VendurePlugin({  imports: [PluginCommonModule],  configuration: (config) => {    const options = GoogleAuthPlugin.options;    if (options?.googleClientId) {      config.authOptions.shopAuthenticationStrategy.push(        new GoogleAuthStrategy({ googleClientId: options.googleClientId })      );    }    return config;  },})export class GoogleAuthPlugin {  static options: GoogleAuthPluginOptions;  static
...
```

---

## Building a CMS Integration Plugin

**URL:** https://docs.vendure.io/guides/how-to/cms-integration-plugin/

**Contents:**
- Building a CMS Integration Plugin
- Working Example Repository​
- Prerequisites​
- Core Concepts​
- How It Works​
- Plugin Structure and Types​
  - Plugin Definition​
  - Configuration Types​
- Event-Driven Synchronization​
  - Creating Job Queues and Subscribing to Events​

A CMS integration plugin allows you to automatically synchronize your Vendure product catalog with an external Content Management System.

This is done in a way that establishes Vendure as the source of truth for the ecommerce's data.

This guide demonstrates how to build a production-ready CMS integration plugin. The principles covered here are designed to be CMS-agnostic, however we do have working examples for various platforms.

Platfroms covered in the guide:

This guide provides a high-level overview of building a CMS integration plugin. For complete implementations, refer to working examples repository

The code examples in this guide are simplified for educational purposes. The actual implementations contain additional features like error handling, retry logic, and performance optimizations.

This plugin leverages several key Vendure concepts:

The CMS integration follows a simple event-driven flow:

This ensures reliable, asynchronous synchronization with built-in retry capabilities.

First, let's use the Vendure CLI to scaffold the basic plugin structure:

This command will create the basic plugin structure. Next, we'll generate the required services:

Now we start by defining the main plugin class, its services, and the configuration types.

The CmsPlugin class registers the necessary services (CmsSyncService, CmsSpecificService) and sets up any Admin API extensions.

The plugin's configuration options are defined in a types.ts file.

Create this file in your plugin directory to define the interfaces. These options will be passed to the plugin from your vendure-config.ts.

This would be created for you automatically when you run the CLI command npx vendure add

The plugin uses Vendure's EventBus to capture changes in real-time.

In the onModuleInit lifecycle hook, we create job queues and subscribe to entity events.

You can also scaffold job queue handlers using the CLI:

This creates a productSyncQueue in the CmsSyncService. The service will be responsible for setting up the queues and processing the jobs. It will expose public methods to trigger new jobs.

Next, in the CmsPlugin, we subscribe to the EventBus and call the new service method to add a job to the queue whenever a relevant event occurs.

The sync logic is split into two services: a generic service to fetch data, and a specific service to communicate with the CMS.

CmsSyncService orchestrates the synchronization logic. It acts as the bridge between Vendure's internal systems and yo

*[Content truncated]*

**Examples:**

Example 1 (bash):
```bash
npx vendure add -p CmsPlugin
```

Example 2 (bash):
```bash
# Generate the main sync servicenpx vendure add -s CmsSyncService --selected-plugin CmsPlugin# Generate the CMS-specific service (replace with your CMS)npx vendure add -s CmsSpecificService --selected-plugin CmsPlugin# Explained later in the Event-Driven Synchronization Section
```

Example 3 (ts):
```ts
import { VendurePlugin, PluginCommonModule, Type, OnModuleInit } from '@vendure/core';import { CmsSyncService } from './services/cms-sync.service';import { CmsSpecificService } from './services/cms-specific.service';import { PluginInitOptions, CMS_PLUGIN_OPTIONS } from './types';// ...@VendurePlugin({    imports: [PluginCommonModule],    providers: [        { provide: CMS_PLUGIN_OPTIONS, useFactory: () => CmsPlugin.options },        CmsSyncService,        CmsSpecificService, // The service for the specific CMS platform    ],    // ...})export class CmsPlugin {    static options: PluginInitOpti
...
```

Example 4 (ts):
```ts
import { ID, InjectionToken } from '@vendure/core';export interface PluginInitOptions {    cmsApiKey?: string;    CmsSpecificOptions?: any;    retryAttempts?: number;    retryDelay?: number;}export interface SyncJobData {    entityType: 'Product' | 'ProductVariant' | 'Collection';    entityId: ID;    operationType: 'create' | 'update' | 'delete';    timestamp: string;    retryCount: number;}export interface SyncResponse {    success: boolean;    message?: string;    error?: string;}
```

---

## Form Component Examples

**URL:** https://docs.vendure.io/guides/extending-the-dashboard/custom-form-components/form-component-examples

**Contents:**
- Form Component Examples
- Email Input with Validation​
- Multi-Currency Price Input​
- Tags Input Component​
- Auto-generating Slug Input​
- Related Guides​

This example uses the react-hook-form validation state in order to display an icon indicating the validity of the email address, as defined by the custom field "pattern" option:

This example demonstrates a component with its own state (using useState) and more complex internal logic.

This component brings better UX to a simple comma-separated tags custom field.

This example demonstrates a component that automatically generates a slug from the product name. It uses the react-hook-form watch method to get the value of another field in the form and react to changes in that field.

Input components completely replace the default input for the targeted field. Make sure your component handles all the data types and scenarios that the original input would have handled.

**Examples:**

Example 1 (tsx):
```tsx
import {AffixedInput, DashboardFormComponent} from '@vendure/dashboard';import {Mail, Check, X} from 'lucide-react';import {useFormContext} from 'react-hook-form';export const EmailInputComponent: DashboardFormComponent = ({name, value, onChange, disabled}) => {    const {getFieldState} = useFormContext();    const isValid = getFieldState(name).invalid === false;    return (        <AffixedInput            prefix={<Mail className="h-4 w-4 text-muted-foreground" />}            suffix={                value &&                (isValid ? (                    <Check className="h-4 w-4 text-green-50
...
```

Example 2 (tsx):
```tsx
import { defineDashboardExtension } from '@vendure/dashboard';import { EmailInputComponent } from './components/email-input';defineDashboardExtension({    customFormComponents: {        customFields: [            {                id: 'custom-email',                component: EmailInputComponent,            },        ],    }});
```

Example 3 (ts):
```ts
@VendureConfig({    configuration: config => {        config.customFields.Seller.push({            name: 'supplierEmail',            type: 'string',            label: [{ languageCode: LanguageCode.en, value: 'Supplier Email' }],            pattern: '^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$',            ui: { component: 'custom-email' },        });        return config;    }})export class MyPlugin {}
```

Example 4 (tsx):
```tsx
import {    AffixedInput,    DashboardFormComponent,    Select,    SelectContent,    SelectItem,    SelectTrigger,    SelectValue,    useLocalFormat,} from '@vendure/dashboard';import { useState } from 'react';export const MultiCurrencyInputComponent: DashboardFormComponent = ({ value, onChange, disabled, name }) => {    const [currency, setCurrency] = useState('USD');    const { formatCurrencyName } = useLocalFormat();    const currencies = [        { code: 'USD', symbol: '$', rate: 1 },        { code: 'EUR', symbol: '€', rate: 0.85 },        { code: 'GBP', symbol: '£', rate: 0.73 },        {
...
```

---

## Publishing a Plugin

**URL:** https://docs.vendure.io/guides/how-to/publish-plugin/

**Contents:**
- Publishing a Plugin
- Project setup​
  - Repo structure​
  - Plugin naming​
  - Dependencies​
  - License​
- Publishing to npm​
- Requirements for Vendure Hub​
  - Changelog​
  - Documentation​

Vendure's plugin-based architecture means you'll be writing a lot of plugins. Some of those plugins may be useful to others, and you may want to share them with the community.

We have created Vendure Hub as a central listing for high-quality Vendure plugins.

This guide will walk you through the process of publishing a plugin to npm and submitting it to Vendure Hub.

There are a couple of ways you can structure your plugin project:

We recommend that you use a "monorepo" structure to develop your plugins. This means that you have a single repository which contains all your plugins, each in its own subdirectory. This makes it easy to manage dependencies between plugins, and to share common code such as utility functions & dev tooling.

Even if you only have a single plugin at the moment, it's a good idea to set up your project in this way from the start.

To that end, we provide a monorepo plugin starter template which you can use as a starting point for your plugin development.

This starter template includes support for:

We recommend that you use scoped packages for your plugins, which means they will be named like @<scope>/<plugin-name>. For example, if your company is called acme, and you are publishing a plugin that implements a loyalty points system, you could name it @acme/vendure-plugin-loyalty-points.

Your plugin should not include Vendure packages as dependencies in the package.json file. You may declare them as a peer dependencies, but this is not a must. The same goes for any of the transitive dependencies of Vendure core such as @nestjs/graphql, @nestjs/common, typeorm etc. You can assume that these dependencies will be available in the Vendure project that uses your plugin.

As for version compatibility, you should use the compatibility property in your plugin definition to ensure that the Vendure project is using a compatible version of Vendure.

You are free to license your plugin as you wish. Although Vendure itself is licensed under the GPLv3, there is a special exception for plugins which allows you to distribute them under a different license. See the plugin exception for more details.

Once your plugin is ready, you can publish it to npm. This is covered in the npm documentation on publishing packages.

Vendure Hub is a curated list of high-quality plugins. To be accepted into Vendure Hub, we require some additional requirements be satisfied.

Your plugin package must include a CHANGELOG.md file which looks like this:

The exact form

*[Content truncated]*

**Examples:**

Example 1 (md):
```md
# Changelog## 1.6.1 (2024-06-07)- Fix a bug where the `foo` was not correctly bar (Fixes [#123](https://github.com/myorg/my-repo/issues/31))## 1.6.0 (2024-03-11)- Add a new feature to the `bar` service- Update the `baz` service to use the new `qux` method... etc
```

Example 2 (json):
```json
{ "files": [    "dist",    "README.md",    "CHANGELOG.md"  ]}
```

Example 3 (md):
```md
# Acme Loyalty Points PluginThis plugin adds a loyalty points system to your Vendure store.## Installation```bashnpm install @acme/vendure-plugin-loyalty-points```Add the plugin to your Vendure config:```ts// vendure-config.tsimport { LoyaltyPointsPlugin } from '@acme/vendure-plugin-loyalty-points';export const config = {    //...    plugins: [        LoyaltyPointsPlugin.init({            enablePartialRedemption: true,        }),    ],};```[If your plugin includes UI extensions]If not already installed, install the `@vendure/ui-devkit` package:```bashnpm install @vendure/ui-devkit```Then set u
...
```

Example 4 (ts):
```ts
/** * Advanced search and search analytics for Vendure. * * @category Plugin */@VendurePlugin({    imports: [PluginCommonModule],    // ...})export class LoyaltyPointsPlugin implements OnApplicationBootstrap {    /** @internal */    static options: LoyaltyPointsPluginInitOptions;    /**     * The static `init()` method is called with the options to     * configure the plugin.     *     * @example     * ```ts     * LoyaltyPointsPlugin.init({     *     enablePartialRedemption: true     * }),     * ```     */    static init(options: LoyaltyPointsPluginInitOptions) {        this.options = options;
...
```

---

## GraphQL Code Generation

**URL:** https://docs.vendure.io/guides/how-to/codegen/

**Contents:**
- GraphQL Code Generation
- Installation​
- Configuration​
- Running codegen​
- Using generated types in resolvers & services​
- Codegen for Admin UI extensions​
  - Use the graphql() function​
- Codegen watch mode​

Code generation means the automatic generation of TypeScript types based on your GraphQL schema and your GraphQL operations. This is a very powerful feature that allows you to write your code in a type-safe manner, without you needing to manually write any types for your API calls.

To do this, we will use Graphql Code Generator.

Use npx vendure add and select "Set up GraphQL code generation" to quickly set up code generation.

You can then run npx vendure schema to generate a schema.graphql file in your root directory.

This guide is for adding codegen to your Vendure plugins. For a guide on adding codegen to your storefront, see the Storefront Codegen guide.

It is recommended to use the vendure add CLI command as detailed above to set up codegen. If you prefer to set it up manually, follow the steps below.

First, install the required dependencies:

Add a codegen.ts file to your project root with the following contents:

This assumes that we have an "organization" plugin which adds support for grouping customers into organizations, e.g. for B2B use-cases.

You can now add a script to your package.json to run codegen:

Ensure your server is running, then run the codegen script:

This will generate a file at src/plugins/organization/gql/generated.ts which contains all the GraphQL types corresponding to your schema.

You would then use these types in your resolvers and service methods, for example:

In your service methods you can directly use any input types defined in your schema:

This section refers to the deprecated Angular-based Admin UI. The new React-based Dashboard has built-in graphql type safety and does not require additional setup.

When you create Admin UI extensions, very often those UI components will be making API calls to the Admin API. In this case, you can use codegen to generate the types for those API calls.

To do this, we will use the "client preset" plugin. Assuming you have already completed the setup above, you'll need to install the following additional dependency:

Then add the following to your codegen.ts file:

For the client preset plugin, we need to specify a directory (.../ui/gql/) because a number of files will get generated.

In your Admin UI components, you can now use the graphql() function exported from the generated file to define your GraphQL operations. For example:

Whenever you write a new GraphQL operation, or change an existing one, you will need to re-run the codegen script to generate the types for that oper

*[Content truncated]*

**Examples:**

Example 1 (bash):
```bash
npm install -D @graphql-codegen/cli @graphql-codegen/typescript
```

Example 2 (ts):
```ts
import type {CodegenConfig} from '@graphql-codegen/cli';const config: CodegenConfig = {    overwrite: true,    // To generate this schema file, run `npx vendure schema`    // whenever your schema changes, e.g. after adding custom fields    // or API extensions    schema: 'schema.graphql',    config: {        // This tells codegen that the `Money` scalar is a number        scalars: { Money: 'number' },        // This ensures generated enums do not conflict with the built-in types.        namingConvention: { enumValues: 'keep' },    },    generates: {        // The path to the generated type fil
...
```

Example 3 (json):
```json
{  "scripts": {    "codegen": "graphql-codegen --config codegen.ts"  }}
```

Example 4 (bash):
```bash
npm run codegen
```

---
