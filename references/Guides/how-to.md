# Building a CMS Integration Plugin


A CMS integration plugin allows you to automatically synchronize your Vendure product catalog with an external Content Management System.

This is done in a way that establishes Vendure as the source of truth for the ecommerce's data.

This guide demonstrates how to build a production-ready CMS integration plugin. The principles covered here are designed to be CMS-agnostic, however we do have working examples for various platforms.

[working examples](/guides/how-to/cms-integration-plugin/#platform-specific-setup)Platfroms covered in the guide:

[guide](/guides/how-to/cms-integration-plugin/#platform-specific-setup)- Payload
- Sanity
- Storyblok
- Strapi
- Contentful

[Payload](https://payloadcms.com/)[Sanity](https://www.sanity.io/)[Storyblok](https://www.storyblok.com/)[Strapi](https://strapi.io/)[Contentful](https://www.contentful.com/)
## Working Example Repository​


[​](#working-example-repository)This guide provides a high-level overview of building a CMS integration plugin. For complete implementations, refer to working examples repository

[working examples repository](https://github.com/vendure-ecommerce/examples/tree/master/examples/cms-integration-plugin)The code examples in this guide are simplified for educational purposes. The actual implementations contain additional features like error handling, retry logic, and performance optimizations.

## Prerequisites​


[​](#prerequisites)- Node.js 20+ with npm package manager
- An existing Vendure project created with the Vendure create command
- An access key to a CMS platform that provides an API

[Vendure create command](/guides/getting-started/installation/)
## Core Concepts​


[​](#core-concepts)This plugin leverages several key Vendure concepts:

[plugin](/guides/developer-guide/plugins/)- EventBus: Provides real-time notifications when entities are created, updated, or deleted.
- Job Queues: Ensures that synchronization tasks are performed reliably and asynchronously, with retries on failure.
- Plugin API: The foundation for extending Vendure with custom capabilities.

[EventBus](/guides/developer-guide/events/)[Job Queues](/guides/developer-guide/worker-job-queue/)[Plugin API](/guides/developer-guide/plugins/)
## How It Works​


[​](#how-it-works)The CMS integration follows a simple event-driven flow:

This ensures reliable, asynchronous synchronization with built-in retry capabilities.

## Plugin Structure and Types​


[​](#plugin-structure-and-types)First, let's use the Vendure CLI to scaffold the basic plugin structure:

```
npx vendure add -p CmsPlugin
```

This command will create the basic plugin structure. Next, we'll generate the required services:

```
# Generate the main sync servicenpx vendure add -s CmsSyncService --selected-plugin CmsPlugin# Generate the CMS-specific service (replace with your CMS)npx vendure add -s CmsSpecificService --selected-plugin CmsPlugin# Explained later in the Event-Driven Synchronization Section

```

Now we start by defining the main plugin class, its services, and the configuration types.

[plugin](/guides/developer-guide/plugins/)[services](/guides/developer-guide/the-service-layer/)
### Plugin Definition​


[​](#plugin-definition)The CmsPlugin class registers the necessary services (CmsSyncService, CmsSpecificService) and sets up any Admin API extensions.

[services](/guides/developer-guide/the-service-layer/)
```
import { VendurePlugin, PluginCommonModule, Type, OnModuleInit } from '@vendure/core';import { CmsSyncService } from './services/cms-sync.service';import { CmsSpecificService } from './services/cms-specific.service';import { PluginInitOptions, CMS_PLUGIN_OPTIONS } from './types';// ...@VendurePlugin({    imports: [PluginCommonModule],    providers: [        { provide: CMS_PLUGIN_OPTIONS, useFactory: () => CmsPlugin.options },        CmsSyncService,        CmsSpecificService, // The service for the specific CMS platform    ],    // ...})export class CmsPlugin {    static options: PluginInitOptions;    static init(options: PluginInitOptions): Type<CmsPlugin> {        this.options = options;        return CmsPlugin;    }}
```

### Configuration Types​


[​](#configuration-types)The plugin's configuration options are defined in a types.ts file.

Create this file in your plugin directory to define the interfaces. These options will be passed to the plugin from your vendure-config.ts.

This would be created for you automatically when you run the CLI command npx vendure add

```
import { ID, InjectionToken } from '@vendure/core';export interface PluginInitOptions {    cmsApiKey?: string;    CmsSpecificOptions?: any;    retryAttempts?: number;    retryDelay?: number;}export interface SyncJobData {    entityType: 'Product' | 'ProductVariant' | 'Collection';    entityId: ID;    operationType: 'create' | 'update' | 'delete';    timestamp: string;    retryCount: number;}export interface SyncResponse {    success: boolean;    message?: string;    error?: string;}
```

## Event-Driven Synchronization​


[​](#event-driven-synchronization)The plugin uses Vendure's EventBus to capture changes in real-time.

[EventBus](/guides/developer-guide/events/)In the onModuleInit lifecycle hook, we create job queues and subscribe to entity events.

[onModuleInit](/guides/developer-guide/events/#subscribing-to-events)
### Creating Job Queues and Subscribing to Events​


[​](#creating-job-queues-and-subscribing-to-events)You can also scaffold job queue handlers using the CLI:

```
npx vendure add -j CmsProductSync --name productSyncQueue --selected-service CmsSyncService
```

This creates a productSyncQueue  in the CmsSyncService. The service will be responsible for setting up the queues and processing the jobs. It will expose public methods to trigger new jobs.

```
import { Injectable, OnModuleInit } from '@nestjs/common';import { JobQueue, JobQueueService /* ... other imports */ } from '@vendure/core';import { SyncJobData } from '../types';@Injectable()export class CmsSyncService implements OnModuleInit {    private productSyncQueue: JobQueue<SyncJobData>;    private variantSyncQueue: JobQueue<SyncJobData>;    private collectionSyncQueue: JobQueue<SyncJobData>;    constructor(        private jobQueueService: JobQueueService,        // ... other dependencies    ) {}    async onModuleInit() {        this.productSyncQueue = await this.jobQueueService.createQueue({            name: 'cms-product-sync',            process: async job => {                return this.syncProductToCms(job.data);            },        });        this.variantSyncQueue = await this.jobQueueService.createQueue({            name: 'cms-variant-sync',            process: async job => {                return this.syncVariantToCms(job.data);            },        });        this.collectionSyncQueue = await this.jobQueueService.createQueue({            name: 'cms-collection-sync',            process: async job => {                return this.syncCollectionToCms(job.data);            },        });    }    triggerProductSync(data: SyncJobData) {        return this.productSyncQueue.add(data);    }    triggerVariantSync(data: SyncJobData) {        return this.variantSyncQueue.add(data);    }    triggerCollectionSync(data: SyncJobData) {        return this.collectionSyncQueue.add(data);    }    // ... other methods for the actual sync logic (e.g. syncProductToCms)}
```

Next, in the CmsPlugin, we subscribe to the EventBus and call the new service method to add a job to the queue whenever a relevant event occurs.

```
import { OnModuleInit, EventBus, ProductEvent, VendurePlugin } from '@vendure/core';import { CmsSyncService } from './services/cms-sync.service';@VendurePlugin({    // ...    providers: [CmsSyncService /* ... */],})export class CmsPlugin implements OnModuleInit {    constructor(        private eventBus: EventBus,        private cmsSyncService: CmsSyncService,    ) {}    async onModuleInit() {        // Listen for Product events        this.eventBus.ofType(ProductEvent).subscribe(event => {            const syncData = this.extractSyncData(event);            this.cmsSyncService.triggerProductSync(syncData);        });        // Similar listeners for ProductVariantEvent and CollectionEvent...    }    // ...}
```

## Implementing the Sync Logic​


[​](#implementing-the-sync-logic)The sync logic is split into two services: a generic service to fetch data, and a specific service to communicate with the CMS.

CmsSyncService orchestrates the synchronization logic. It acts as the bridge between Vendure's internal systems and your CMS platform, handling data fetching, relationship resolution, and error management.

Separating orchestration logic from CMS-specific API calls allows for better testability and maintainability. The sync service handles Vendure-specific operations while CMS services focus on API communication.

#### Core Responsibilities​


[​](#core-responsibilities)The sync service handles several critical functions:

- Entity Data Fetching: Retrieves complete entity data with necessary relations
- Translation Management: Handles Vendure's multi-language support
- Relationship Resolution: Manages complex entity relationships
- Error Handling: Provides consistent error handling and logging

### Service Structure and Dependencies​


[​](#service-structure-and-dependencies)The service follows Vendure's dependency injection pattern and requires several core Vendure services:

[dependency injection pattern](/guides/developer-guide/the-service-layer/)
```
@Injectable()export class CmsSyncService implements OnApplicationBootstrap {    constructor(        @Inject(CMS_PLUGIN_OPTIONS) private options: PluginInitOptions,        private readonly connection: TransactionalConnection,        private readonly channelService: ChannelService,        private readonly collectionService: CollectionService,        private readonly requestContextService: RequestContextService,        // Your CMS-specific service        private readonly CmsSpecificService: CmsSpecificService,        private processContext: ProcessContext,    ) {}    async onApplicationBootstrap() {        // Ensure this logic only runs on the Vendure worker, and not the server        if (this.processContext.isWorker) {            // This is where you would add any necessary setup or initialization logic            // for example, ensuring that the CMS has compatible content types.        }    }}
```

### Product Synchronization​


[​](#product-synchronization)Product sync demonstrates the complete workflow from job processing to CMS communication:

```
async syncProductToCms(jobData: SyncJobData): Promise<SyncResponse> {  try {    // Fetch fresh product data from database with translations    const product = await this.connection.rawConnection      .getRepository(Product)      .findOne({        where: { id: jobData.entityId },        relations: { translations: true },      });    if (!product) {      throw new Error(`Product with ID ${jobData.entityId} not found`);    }    const operationType = jobData.operationType;    const defaultLanguageCode = await this.getDefaultLanguageCode();    // Get product slug using translation utilities    const productSlug = this.translationUtils.getSlugByLanguage(      product.translations,      defaultLanguageCode,    );    // Delegate to CMS-specific service    await this.CmsSpecificService.syncProduct({      product,      defaultLanguageCode,      operationType,      productSlug,    });    return {      success: true,      message: `Product ${jobData.operationType} synced successfully`,      timestamp: new Date(),    };  } catch (error) {    const errorMessage = error instanceof Error ? error.message : 'Unknown error';    Logger.error(`Product sync failed: ${errorMessage}`, error.stack);    return {      success: false,      message: `Product sync failed: ${errorMessage}`,    };  }}
```

### Relationship Handling​


[​](#relationship-handling)The service includes methods to resolve entity relationships. For example, finding collections that contain a specific variant:

```
async findCollectionsForVariant(  variantId: string | number,): Promise<Collection[]> {  try {    const variant = await this.connection.rawConnection      .getRepository(ProductVariant)      .findOne({        where: {          id: variantId,        },        relations: ["collections"],      });    return variant?.collections || [];  } catch (error) {    Logger.error(      `Failed to find collections for variant ${variantId}`,      String(error),    );    return [];  }}    return collectionsWithVariant;  } catch (error) {    // Variants can have no collecitons, therefore, sync anyways.    Logger.error(`Failed to find collections for variant ${variantId}`, String(error));    return [];  }}
```

The service can also includes syncVariantToCms() and syncCollectionToCms() methods that follow the same pattern as the product sync shown above.

These implementations are omitted from this guide for brevity, but they handle their respective entity types with similar data fetching, relationship resolution, and error handling patterns.

The complete implementations can be found in the working example repositories.

[example repositories](https://github.com/vendure-ecommerce/examples/tree/master/examples/cms-integration-plugin)This sync service provides the foundation for handling all Vendure-specific complexity while delegating CMS API communication to specialized services.

## Platform specific setup​


[​](#platform-specific-setup)- Storyblok
- Contentful
- Strapi
- Sanity
- Payload

The complete, production-ready Storyblok implementation can be found in the Storyblok integration example. Refer to it for a minimal working implementation.

[Storyblok integration example](https://github.com/vendure-ecommerce/examples/tree/master/examples/storyblok-cms-integration)Setting up Storyblok Space

#### 1. Create a Storyblok Account and Space​


[​](#1-create-a-storyblok-account-and-space)- Sign up at storyblok.com if you don't have an account
- Create a new Space (equivalent to a project in Storyblok)
- Choose a suitable plan based on your needs

[storyblok.com](https://app.storyblok.com/#!/signup)
#### 2. Get Your API Credentials​


[​](#2-get-your-api-credentials)- Navigate to Settings → Access Tokens in your Storyblok space
- Create a new Management API Token with write permissions
- Note down your Space ID (found in Settings → General)

#### 3. Configure Environment Variables​


[​](#3-configure-environment-variables)Add these variables to your .env file:

```
STORYBLOK_API_KEY=your_management_api_tokenSTORYBLOK_SPACE_ID=your_space_id
```

The Storyblok Service

StoryblokService handles all Storyblok-specific operations including API communication, content type management, and data transformation. Key features include:

- Content Type Management: Automatically creates Vendure-specific content types (components) in Storyblok
- Story Management: CRUD operations for stories representing products, variants, and collections
- Relationship Handling: Manages references between products, variants, and collections

Basic Service Structure

The service follows Vendure's standard dependency injection pattern and implements OnApplicationBootstrap to ensure Storyblok is properly configured before handling sync operations.

```
// Define component types as constants for consistency and maintainabilityconst COMPONENT_TYPE = {    product: 'vendure_product',    product_variant: 'vendure_product_variant',    collection: 'vendure_collection',};@Injectable()export class StoryblokService implements OnApplicationBootstrap {    constructor(@Inject(CMS_PLUGIN_OPTIONS) private options: PluginInitOptions) {}    async onApplicationBootstrap() {        // This is where you would add any necessary setup or initialization logic        // for example, ensuring that the CMS has compatible content types.    }    // Main entry point for product synchronization    // The operationType determines which CRUD operation to perform    async syncProduct({ product, defaultLanguageCode, operationType }) {        switch (operationType) {            case 'create':                return this.createStoryFromProduct(product, defaultLanguageCode);            case 'update':                return this.updateStoryFromProduct(product, defaultLanguageCode);            case 'delete':                return this.deleteStoryFromProduct(product, defaultLanguageCode);        }    }}
```

Making API Requests

All Storyblok API communication is centralized through a single method that handles authentication, error handling, and response parsing. This approach ensures consistent behavior across all operations.

```
private async makeStoryblokRequest({ method, endpoint, data }) {    // Construct the full API URL using the configured space ID    const url = `https://mapi.storyblok.com/v1/spaces/${this.options.storyblokSpaceId}/${endpoint}`;    const response = await fetch(url, {        method,        headers: {            Authorization: this.options.storyblokApiKey,            'Content-Type': 'application/json',        },        // Only include request body for POST/PUT operations        body: data ? JSON.stringify(data) : undefined,    });    if (!response.ok) {        // Provide clear error messages for debugging API issues        throw new Error(`Storyblok API error: ${response.status}`);    }    return response.json();}
```

Data Transformation

Transformation methods convert Vendure entities into the format expected by Storyblok's API. The content object structure must match the component schema defined in Storyblok.

```
private async transformProductData(product, defaultLanguageCode, productSlug?) {    // Extract the translation for the default language    // Vendure stores translations in an array, so we need to find the correct one    const translation = product.translations.find(        t => t.languageCode === defaultLanguageCode    );    if (!translation) {        return undefined; // Skip if no translation exists    }    // Find all variant story UUIDs for this product using relationship handling    const variantStoryIds = await this.findVariantStoriesForProductUuids(        product.id,        defaultLanguageCode,        productSlug,    );    return {        story: {            name: translation?.name, // Story name in Storyblok            slug: translation?.slug,  // URL slug for the story            content: {                component: COMPONENT_TYPE.product, // Must match the component name in Storyblok                vendureId: product.id.toString(),  // Store Vendure ID for reference                variants: variantStoryIds, // Array of story UUIDs for product variants            },        },        publish: 1, // Auto-publish the story (1 = published, 0 = draft)    };}
```

Relationship Handling

One of the most important aspects of CMS integration is maintaining relationships between entities. Products have variants, variants belong to collections, and these relationships need to be reflected in the CMS. Storyblok uses story UUIDs to create references between content pieces.

- Finding Related Entities

> First, we need methods to query the Vendure database for related entities:

First, we need methods to query the Vendure database for related entities:

```
// Find all product variants for a given product ID from the databaseprivate async findProductVariants(productId: string | number): Promise<ProductVariant[]> {    try {        return await this.connection.rawConnection            .getRepository(ProductVariant)            .find({                where: { productId: productId as any },                relations: ['translations'], // Include translations for slug generation                order: { id: 'ASC' },            });    } catch (error) {        Logger.error(`Failed to find variants for product ${productId}`, String(error));        return [];    }}
```

- Batch Story Lookups

> We can also use batch lookups to find multiple stories at once:

We can also use batch lookups to find multiple stories at once:

```
// Batch lookup method for efficient story retrievalprivate async findStoriesBySlugs(slugs: string[]): Promise<Map<string, any>> {    const storyMap = new Map<string, any>();    if (slugs.length === 0) return storyMap;    try {        // Storyblok supports comma-separated slugs for batch lookup        const slugsParam = slugs.join(',');        const response = await this.makeStoryblokRequest({            method: 'GET',            endpoint: `stories?by_slugs=${slugsParam}`,        });        if (response.stories) {            for (const story of response.stories) {                storyMap.set(story.slug, story);            }        }    } catch (error) {        Logger.error(`Failed to find stories by slugs: ${slugs.join(', ')}`, String(error));    }    return storyMap;}
```

- Building Relationships

> Finally, we combine database queries with CMS lookups to build relationships:

Finally, we combine database queries with CMS lookups to build relationships:

```
// Find variant stories using batch lookup for efficiencyprivate async findVariantStoriesForProductUuids(    productId: string | number,    defaultLanguageCode: LanguageCode,    productSlug?: string | null,): Promise<string[]> {    if (!productSlug) return [];    // Get all variants for this product from Vendure database    const variants = await this.findProductVariants(productId);    // Generate slugs for all variants (convention: product-slug-variant-id)    const variantSlugs = variants.map(        (variant) => `${productSlug}-variant-${variant.id}`,    );    if (variantSlugs.length === 0) return [];    // Batch lookup all variant stories and extract UUIDs    const storiesMap = await this.findStoriesBySlugs(variantSlugs);    const storyUuids: string[] = [];    for (const [slug, story] of storiesMap) {        if (story?.uuid) {            storyUuids.push(story.uuid.toString()); // Storyblok uses UUIDs for references        }    }    return storyUuids;}// Example: Transform variant data with relationshipsprivate async transformVariantData(    variant: ProductVariant,    defaultLanguageCode: LanguageCode,    variantSlug: string,    collections?: Collection[],) {    const translation = variant.translations.find(        t => t.languageCode === defaultLanguageCode    );    if (!translation) return undefined;    // Find parent product and collection references using the same batch lookup patterns    const parentProductStoryUuid = await this.findParentProductStoryUuid(variant, defaultLanguageCode);    const collectionStoryUuids = await this.findCollectionStoryUuids(collections, defaultLanguageCode);    return {        story: {            name: translation.name,            slug: variantSlug,            content: {                component: COMPONENT_TYPE.product_variant,                vendureId: variant.id.toString(),                parentProduct: parentProductStoryUuid ? [parentProductStoryUuid] : [],                collections: collectionStoryUuids,            },        },        publish: 1,    };}// Additional relationship methods like findParentProductStoryUuid and findCollectionStoryUuids// follow similar patterns and are available in the working example repository.
```

CRUD Operations

These methods handle the basic Create, Read, Update, and Delete operations for stories in Storyblok. They follow REST API conventions and leverage the centralized request method for consistent behavior.

```
// Create a new story in Storyblokprivate async createStoryFromProduct(product, defaultLanguageCode) {    // Transform Vendure product data into Storyblok story format    const data = this.transformProductData(product, defaultLanguageCode);    // POST to the stories endpoint to create a new story    return this.makeStoryblokRequest({        method: 'POST',        endpoint: 'stories',        data,    });}// Find an existing story by its slugprivate async findStoryBySlug(slug: string) {    // Use Storyblok's by_slugs query parameter for efficient lookup    const response = await this.makeStoryblokRequest({        method: 'GET',        endpoint: `stories?by_slugs=${slug}`,    });    // Return the matching story or undefined if not found    return response.stories.find((story: any) => story.slug === slug);}// Additional CRUD methods like updateStoryFromProduct and deleteStoryFromProduct// follow similar patterns with PUT and DELETE HTTP methods respectively.// Full implementations are available in the working example repository.
```

Final Plugin Configuration

```
CmsPlugin.init({  cmsApiKey: process.env.STORYBLOK_API_KEY,  storyblokSpaceId: process.env.STORYBLOK_SPACE_ID,}),
```

This setup provides a complete Storyblok CMS integration that automatically creates the necessary content types and syncs your Vendure catalog with structured content in Storyblok.

The complete implementations can be found in the working example repositories.

[example repositories](https://github.com/vendure-ecommerce/examples/tree/master/examples/storyblok-cms-integration)The complete, production-ready Contentful implementation can be found in the Contentful integration example. It includes advanced features like locale mapping, bulk operations, and a robust setup process.

[Contentful integration example](https://github.com/vendure-ecommerce/examples/tree/master/examples/contentful-cms-integration)Setting up Contentful Space

Create a Contentful Account and Space

- Sign up for a free account at contentful.com.
- Follow the onboarding to create a new Space. Think of a Space as a repository for all the content of a single project.

[contentful.com](https://www.contentful.com/get-started/)Get Your API Credentials

- In your Contentful space, navigate to Settings → API keys.
- Select the Content management tokens tab.
- Click Generate personal token. Give it a name (e.g., "Vendure Sync") and copy the token. This token is used to create, edit, and delete content.
- Navigate to Settings → General settings to find your Space ID.

Configure Environment Variables

Add the API credentials and Space ID to your project's .env file.

```
CONTENTFUL_API_KEY=your_content_management_tokenCONTENTFUL_SPACE_ID=your_space_id
```

The Contentful Service

The ContentfulService is the heart of the integration. It manages all communication with Contentful's Content Management API, transforms Vendure entities into Contentful Entries, and handles the relationships between them.

- Content Type Management: On startup, it automatically creates the necessary Content Types (e.g., vendureProduct, vendureCollection) in Contentful to structure your e-commerce data.
- Entry Synchronization: Provides full CRUD (Create, Read, Update, Delete) operations for products, variants, and collections.
- Relationship Handling: Correctly links related entries, such as connecting a variant to its parent product and its collections.

Basic Service Structure

The service follows Vendure's standard dependency injection pattern and implements OnApplicationBootstrap. This lifecycle hook is crucial because it ensures our custom Contentful Content Types are created before the application starts trying to sync data, preventing errors.

```
// Define content type IDs as constants for consistency and easy reference.const CONTENT_TYPE_ID = {    product: 'vendureProduct',    product_variant: 'vendureProductVariant',    collection: 'vendureCollection',};@Injectable()export class ContentfulService implements OnApplicationBootstrap {    constructor(        private connection: TransactionalConnection,        @Inject(CMS_PLUGIN_OPTIONS) private options: PluginInitOptions,    ) {}    async onApplicationBootstrap() {        // This is where you would add any necessary setup or initialization logic        // for example, ensuring that the CMS has compatible content types.    }    // Main entry point for synchronizing a product.    // The `operationType` determines whether to create, update, or delete an entry.    async syncProduct({ product, defaultLanguageCode, operationType }) {        switch (operationType) {            case 'create':                return this.createEntryFromProduct(product, defaultLanguageCode);            case 'update':                return this.updateEntryFromProduct(product, defaultLanguageCode);            case 'delete':                return this.deleteEntryFromProduct(product, defaultLanguageCode);        }    }}
```

Making API Requests

To keep our code clean and maintainable, all communication with the Contentful API is channeled through a single makeContentfulRequest method. This centralizes authentication, error handling, and URL construction.

```
private async makeContentfulRequest({ method, endpoint, data, headers = {} }) {    // Construct the full API URL using the configured space and environment ID.    const url = `https://api.contentful.com/spaces/${this.options.contentfulSpaceId}/environments/master/${endpoint}`;    const response = await fetch(url, {        method,        headers: {            // The Content Management API requires a Bearer token.            Authorization: `Bearer ${this.options.cmsApiKey}`,            'Content-Type': 'application/vnd.contentful.management.v1+json',            ...headers,        },        body: data ? JSON.stringify(data) : undefined,    });    if (!response.ok) {        const errorText = await response.text();        // Rich error messages are critical for debugging API issues.        throw new Error(`Contentful API error: ${response.status} - ${errorText}`);    }    // DELETE requests often return no body, so we handle that case.    if (response.status === 204 || method === 'DELETE') {        return {};    }    return response.json();}
```

Data Transformation

Before we can send data to Contentful, we must transform our Vendure entities into the format Contentful expects. A Contentful Entry consists of a fields object where each key corresponds to a field in the Content Type. Each field is also localized, so its value is nested within a locale key (e.g., en-US).

```
private async transformProductData(    product: Product,    defaultLanguageCode: LanguageCode,) {    // Vendure stores translations in an array; we need to find the one    // for the store's default language.    const translation = product.translations.find(        t => t.languageCode === defaultLanguageCode,    );    if (!translation) return undefined; // Cannot sync if default language is missing.    // Find all variant entries that belong to this product. This is a key    // part of relationship handling, covered in the next section.    const variantEntryIds = await this.findVariantEntriesForProductIds(        product.id,        defaultLanguageCode,        translation.slug,    );    // Contentful uses a specific locale format, e.g., 'en-US'.    const contentfulLocale = this.mapToContentfulLocale(defaultLanguageCode);    return {        fields: {            name: { [contentfulLocale]: translation.name },            slug: { [contentfulLocale]: translation.slug },            vendureId: { [contentfulLocale]: product.id.toString() },            // Variants are linked via an array of "Link" objects.            variants: {                [contentfulLocale]: variantEntryIds.map(id => ({                    sys: { type: 'Link', linkType: 'Entry', id },                })),            },        },    };}
```

Relationship Handling

One of the most important aspects of CMS integration is maintaining relationships between entities. Products have variants, and variants belong to collections. Contentful manages these relationships using Links, which are essentially pointers from one entry to another. Our goal is to find the Contentful Entry ID of a related entity and embed it as a Link.

Finding Related Vendure Entities

The first step is always to query the Vendure database to find the related entities. We use the injected TransactionalConnection to perform efficient database lookups.

```
// Finds all ProductVariant entities for a given product ID.private async findProductVariants(productId: ID): Promise<ProductVariant[]> {    try {        // Use Vendure's standard pattern for database access in a service.        return await this.connection.rawConnection            .getRepository(ProductVariant)            .find({                where: { productId: productId as any },                relations: ['translations'], // Eager load translations for slug generation.            });    } catch (error) {        Logger.error(`Failed to find variants for product ${productId}`, String(error));        return [];    }}
```

Building the Relationships

Now we combine these two patterns. We fetch the related Vendure entities, generate their unique identifiers (slugs), use a batch lookup to find their corresponding Contentful entries, and extract their IDs to build the Link objects.

```
private async findVariantEntriesForProductIds(    productId: string | number,    defaultLanguageCode: LanguageCode,    productSlug?: string | null,): Promise<string[]> {    if (!productSlug) return [];    // 1. Get all related variants from the Vendure database.    const variants = await this.findProductVariants(productId);    // 2. Generate the unique slugs for each variant.    // Convention: `product-slug-variant-id`    const variantSlugs = variants.map(        variant => `${productSlug}-variant-${variant.id}`,    );    if (variantSlugs.length === 0) return [];    // 3. Perform a single batch lookup to find all matching Contentful entries.    const entriesMap = await this.findEntriesByField(        CONTENT_TYPE_ID.product_variant,        'slug',        variantSlugs,    );    // 4. Extract the system ID from each entry to be used for linking.    const entryIds: string[] = [];    for (const entry of entriesMap.values()) {        if (entry?.sys?.id) {            entryIds.push(entry.sys.id);        }    }    return entryIds;}
```

This same pattern is used to link variants to their parent product and to their collections, as shown in the complete transformVariantData method in the example repository.

CRUD Operations

These methods perform the core Create, Read, Update, and Delete logic. They rely on our centralized makeContentfulRequest method and handle the specifics of Contentful's API, such as versioning and the publish workflow.

Contentful requires entries to be explicitly published before they are visible in the Delivery API. After creating or updating an entry, we must make a separate API call to publish it. Similarly, to delete an entry, it must first be unpublished.

```
// Creates a new entry and then publishes it.private async createEntryFromProduct(product: Product, defaultLanguageCode: LanguageCode) {    const data = await this.transformProductData(product, defaultLanguageCode);    if (!data) return;    // POST to the 'entries' endpoint with a special header specifying the content type.    const result = await this.makeContentfulRequest({        method: 'POST',        endpoint: this.entriesPath,        data,        headers: { 'X-Contentful-Content-Type': CONTENT_TYPE_ID.product },    });    // An entry is created as a draft; it must be published to be live.    if (result.sys?.id) {        await this.publishEntry(result.sys.id, result.sys.version);    }}// Updates an existing entry.private async updateEntryFromProduct(product: Product, defaultLanguageCode: LanguageCode) {    // 1. Find the existing entry in Contentful (e.g., by its slug).    const slug = getSlug(product, defaultLanguageCode);    const existingEntry = await this.findEntryByField(CONTENT_TYPE_ID.product, 'slug', slug);    if (!existingEntry) {        // If it doesn't exist, we can fall back to creating it.        return this.createEntryFromProduct(product, defaultLanguageCode);    }    // 2. Transform the data.    const data = await this.transformProductData(product, defaultLanguageCode);    if (!data) return;    // 3. PUT to the specific entry URL. This requires the current version    // for optimistic locking, preventing race conditions.    const result = await this.makeContentfulRequest({        method: 'PUT',        endpoint: `${this.entriesPath}/${existingEntry.sys.id}`,        data,        headers: { 'X-Contentful-Version': existingEntry.sys.version.toString() },    });    // 4. Publish the new version.    if (result.sys?.id) {        await this.publishEntry(result.sys.id, result.sys.version);    }}// The full implementations for delete, as well as variant and collection CRUD,// can be found in the working example repository. They follow similar patterns.
```

Final Plugin Configuration

Finally, we initialize the plugin in vendure-config.ts, providing the API credentials from our environment variables.

```
import { CmsPlugin } from './plugins/cms/cms.plugin';// ... other importsexport const config: VendureConfig = {    // ... other config    plugins: [        // ... other plugins        CmsPlugin.init({            cmsApiKey: process.env.CONTENTFUL_API_KEY,            contentfulSpaceId: process.env.CONTENTFUL_SPACE_ID,        }),    ],};
```

This configuration provides a complete Contentful CMS integration that automatically creates the necessary content models and syncs your Vendure catalog with structured content in Contentful, ready to be consumed by a headless storefront.

The complete, production-ready Strapi implementation can be found in the Strapi integration example. It includes advanced features like plugin-based content types, batch operations, and relationship management.

[Strapi integration example](https://github.com/vendure-ecommerce/examples/tree/master/examples/strapi-cms-integration)This guide provides a complete integration for Vendure with Strapi CMS, including setting up a Strapi application with a custom plugin and implementing the synchronization service.

Setting up Strapi

#### 1. Create a new Strapi project​


[​](#1-create-a-new-strapi-project)Initialize your Strapi project using the CLI:

```
npx create-strapi-app@latest strapi-integration-appcd strapi-integration-app
```

Choose the following options when prompted:

- Installation type: Custom (manual settings)
- Database client: Sqlite (or your preferred database)
- Use TypeScript: Yes

#### 2. Create a Vendure Integration Plugin​


[​](#2-create-a-vendure-integration-plugin)Generate a custom plugin to organize Vendure content types:

```
npm run strapi generate plugin# Plugin name: vendure-integration-plugin

```

#### 3. Configure Environment Variables​


[​](#3-configure-environment-variables-1)Add these variables to your .env file:

```
STRAPI_API_TOKEN=your_api_tokenSTRAPI_BASE_URL=http://localhost:1337
```

Defining Content Types

#### 1. Create Vendure-specific content types​


[​](#1-create-vendure-specific-content-types)Create the content type schemas in your plugin's server/content-types folder:

vendure-product/schema.json

```
{    "kind": "collectionType",    "collectionName": "vendure_products",    "info": {        "displayName": "Vendure Product",        "singularName": "vendure-product",        "pluralName": "vendure-products"    },    "attributes": {        "vendureId": {            "type": "integer",            "required": true,            "unique": true        },        "name": {            "type": "string",            "required": true        },        "slug": {            "type": "string",            "required": true,            "unique": true        },        "productVariants": {            "type": "relation",            "relation": "oneToMany",            "target": "api::vendure-product-variant.vendure-product-variant",            "mappedBy": "product"        }    }}
```

Additional content types for VendureProductVariant and VendureCollection
follow the same pattern with appropriate field definitions and relationships.

```
// vendure-product-variant/schema.json// vendure-collection/schema.json
```

#### 2. Enable the plugin​


[​](#2-enable-the-plugin)Update your Strapi configuration to enable the plugin:

```
export default {    'vendure-integration-plugin': {        enabled: true,        resolve: './src/plugins/vendure-integration-plugin',    },};
```

#### 3. Generate API tokens​


[​](#3-generate-api-tokens)After starting Strapi, create an API token:

- Navigate to Settings → API Tokens in the Strapi admin panel
- Create a new token with Full access or custom permissions
- Save the token for use in your Vendure plugin configuration

The Strapi Service

The StrapiService handles all Strapi-specific operations including API communication, content management, and relationship resolution. Key features include:

- Content Management: CRUD operations using Strapi's REST API
- Relationship Handling: Manages references between products, variants, and collections
- Batch Operations: Efficient bulk lookups for related entities

Basic Service Structure

The service follows Vendure's standard dependency injection pattern and implements OnApplicationBootstrap to ensure the CMS is properly configured before handling sync operations.

```
@Injectable()export class StrapiService {    private get strapiBaseUrl(): string {        return `${this.options.strapiBaseUrl || 'http://localhost:1337'}/api`;    }    constructor(@Inject(CMS_PLUGIN_OPTIONS) private options: PluginInitOptions) {}    async syncProduct({ product, defaultLanguageCode, operationType }) {        switch (operationType) {            case 'create':                return this.createDocumentFromProduct(product, defaultLanguageCode);            case 'update':                return this.updateDocumentFromProduct(product, defaultLanguageCode);            case 'delete':                return this.deleteDocumentFromProduct(product, defaultLanguageCode);        }    }}
```

Making API Requests

All Strapi API communication is centralized through a single method that handles authentication, error handling, and response parsing. This approach ensures consistent behavior across all operations.

```
private async makeStrapiRequest({ method, endpoint, data }) {  const url = `${this.strapiBaseUrl}/${endpoint}`;  const headers: Record<string, string> = {    'Content-Type': 'application/json',  };  if (this.options.strapiApiKey) {    headers.Authorization = `Bearer ${this.options.strapiApiKey}`;  }  const response = await fetch(url, {    method,    headers,    body: data ? JSON.stringify(data) : undefined,  });  if (!response.ok) {    throw new Error(`Strapi API error: ${response.status}`);  }  return response.json();}
```

Data Transformation

Transformation methods convert Vendure entities into the format expected by Strapi's API. The data object structure must match the collection schema defined in Strapi.

```
private async transformProductData(product: Product, defaultLanguageCode: LanguageCode, productSlug?: string | null) {  const t = product.translations.find(tr => tr.languageCode === defaultLanguageCode);  if (!t) return undefined;  const variantDocumentIds = await this.findVariantDocumentsForProductIds(product.id, defaultLanguageCode, productSlug);  return {    vendureId: product.id,    name: t.name,    slug: t.slug,    productVariants: variantDocumentIds,  };}
```

Relationship Handling

One of the most important aspects of CMS integration is maintaining relationships between entities. Products have variants, variants belong to collections, and these relationships need to be reflected in the CMS. Strapi uses document IDs to create references between content pieces.

```
private async findProductVariants(productId: string | number): Promise<ProductVariant[]> {  return this.connection.rawConnection.getRepository(ProductVariant).find({    where: { productId: productId as any },    relations: ['translations'],    order: { id: 'ASC' },  });}private async findDocumentsBySlugs(collectionSlug: string, slugs: string[]): Promise<Map<string, any>> {  const map = new Map<string, any>();  if (slugs.length === 0) return map;  const queryParams = slugs.map((slug, i) => `filters[slug][$in][${i}]=${encodeURIComponent(slug)}`).join('&');  const endpoint = `${collectionSlug}?${queryParams}`;  const response = await this.makeStrapiRequest({ method: 'GET', endpoint });  if (response.data) {    for (const doc of response.data) {      if (doc?.slug) map.set(doc.slug, doc);    }  }  return map;}private async findVariantDocumentsForProductIds(  productId: string | number,  defaultLanguageCode: LanguageCode,  productSlug?: string | null,): Promise<string[]> {  if (!productSlug) return [];  const variants = await this.findProductVariants(productId);  const slugs = variants.map(v => `${productSlug}-variant-${v.id}`);  if (slugs.length === 0) return [];  const docs = await this.findDocumentsBySlugs('vendure-product-variant', slugs);  const ids: string[] = [];  docs.forEach(doc => { if (doc?.id) ids.push(String(doc.id)); });  return ids;}
```

CRUD Operations

These methods handle the basic Create, Read, Update, and Delete operations for documents in Strapi. They follow REST API conventions and leverage the centralized request method for consistent behavior.

```
private async findDocumentBySlug(collectionSlug: string, slug: string) {  const endpoint = `${collectionSlug}?filters[slug][$eq]=${encodeURIComponent(slug)}&pagination[limit]=1`;  const response = await this.makeStrapiRequest({ method: 'GET', endpoint });  return response.data && response.data.length > 0 ? response.data[0] : null;}private async createDocumentFromProduct(product: Product, defaultLanguageCode: LanguageCode, productSlug?: string | null) {  const data = await this.transformProductData(product, defaultLanguageCode, productSlug);  if (!data) return;  await this.makeStrapiRequest({ method: 'POST', endpoint: 'vendure-products', data: { data } });}private async updateDocumentFromProduct(product: Product, defaultLanguageCode: LanguageCode, productSlug?: string | null) {  const slug = this.translationUtils.getSlugByLanguage(product.translations, defaultLanguageCode);  if (!slug) return;  const existing = await this.findDocumentBySlug('vendure-products', slug);  if (!existing) return this.createDocumentFromProduct(product, defaultLanguageCode, productSlug);  const data = await this.transformProductData(product, defaultLanguageCode, productSlug);  if (!data) return;  await this.makeStrapiRequest({    method: 'PUT',    endpoint: `vendure-products/${existing.id}`,    data: { data },  });}private async deleteDocumentFromProduct(product: Product, defaultLanguageCode: LanguageCode) {  const slug = this.translationUtils.getSlugByLanguage(product.translations, defaultLanguageCode);  if (!slug) return;  const existing = await this.findDocumentBySlug('vendure-products', slug);  if (!existing) return;  await this.makeStrapiRequest({ method: 'DELETE', endpoint: `vendure-products/${existing.id}` });}
```

Configuration

Update your plugin configuration to include Strapi options:

```
export interface PluginInitOptions {    // ... existing options    strapiApiKey?: string;    strapiBaseUrl?: string;}
```

Environment Variables

Add these to your .env file:

```
STRAPI_API_KEY=your_strapi_api_tokenSTRAPI_BASE_URL=http://localhost:1337
```

Final Plugin Configuration

```
CmsPlugin.init({  strapiApiKey: process.env.STRAPI_API_KEY,  strapiBaseUrl: process.env.STRAPI_BASE_URL || 'http://localhost:1337',}),
```

This setup provides a complete Strapi CMS integration that automatically creates the necessary content types and syncs your Vendure catalog with structured content in Strapi.

The complete implementations can be found in the working example repositories.

[example repositories](https://github.com/vendure-ecommerce/examples/tree/master/examples/strapi-cms-integration)The complete, production-ready Sanity implementation can be found in the Sanity integration example. It includes advanced features like content type management and bulk operations.

[Sanity integration example](https://github.com/vendure-ecommerce/examples/tree/master/examples/sanity-cms-integration)This section provides an overview of integrating Vendure with Sanity. Refer to the working example for production patterns.

Setting up Sanity Studio

#### 1. Create a new Studio with Sanity CLI​


[​](#1-create-a-new-studio-with-sanity-cli)
```
npm create sanity@latest -- --project <project-id> --dataset production --template clean --typescript --output-path studio-vendure-plugincd studio-vendure-plugin
```

#### 2. Run Sanity Studio locally​


[​](#2-run-sanity-studio-locally)
```
npm run dev
```

#### 3. Log in to the Studio​


[​](#3-log-in-to-the-studio)Open http://localhost:3333 and authenticate using the same provider you used for the CLI.

Defining Schema Types

Split content into three document types: vendureProduct, vendureProductVariant, and vendureCollection. Keep fields minimal and focused on IDs, names, slugs, and references.

```
import { defineField, defineType } from 'sanity';export const vendureProduct = defineType({    name: 'vendureProduct',    title: 'Vendure Product',    type: 'document',    fields: [        defineField({ name: 'vendureId', type: 'number', validation: r => r.required() }),        defineField({ name: 'title', type: 'string', validation: r => r.required() }),        defineField({            name: 'slug',            type: 'slug',            options: { source: 'title' },            validation: r => r.required(),        }),        defineField({            name: 'productVariants',            type: 'array',            of: [{ type: 'reference', to: [{ type: 'vendureProductVariant' }] }],        }),    ],});
```

Register these in schemaTypes/index.ts:

```
export const schemaTypes = [vendureProduct, vendureProductVariant, vendureCollection];
```

The Sanity Service

The SanityService encapsulates Sanity-specific API communication, GROQ queries, and transformations.

```
@Injectable()export class SanityService {    private get apiBase(): string {        return `https://${this.options.sanityProjectId}.api.sanity.io/v2023-10-01`;    }    constructor(@Inject(CMS_PLUGIN_OPTIONS) private options: PluginInitOptions) {}    async syncProduct({ product, defaultLanguageCode, operationType }) {        switch (operationType) {            case 'create':                return this.createDocumentFromProduct(product, defaultLanguageCode);            case 'update':                return this.updateDocumentFromProduct(product, defaultLanguageCode);            case 'delete':                return this.deleteDocumentFromProduct(product, defaultLanguageCode);        }    }    private getAuthHeaders() {        return {            Authorization: `Bearer ${this.options.sanityApiKey}`,            'Content-Type': 'application/json',        } as const;    }    private async query<T>(groq: string, params: Record<string, any> = {}): Promise<T> {        const url = `${this.apiBase}/data/query/${this.options.sanityDataset}`;        const res = await fetch(url, {            method: 'POST',            headers: this.getAuthHeaders(),            body: JSON.stringify({ query: groq, params }),        });        if (!res.ok) throw new Error(`Sanity query error: ${res.status}`);        const json = await res.json();        return json.result as T;    }    private async mutate(mutations: any[]) {        const url = `${this.apiBase}/data/mutate/${this.options.sanityDataset}?returnIds=true`;        const res = await fetch(url, {            method: 'POST',            headers: this.getAuthHeaders(),            body: JSON.stringify({ mutations }),        });        if (!res.ok) throw new Error(`Sanity mutate error: ${res.status}`);        return res.json();    }}
```

Data Transformation

Transformation methods convert Vendure entities into the format expected by Sanity's API. The document structure must match the schema defined in Sanity Studio.

```
private async transformProductData(product: Product, defaultLanguageCode: LanguageCode, productSlug?: string | null) {  const t = product.translations.find(tr => tr.languageCode === defaultLanguageCode);  if (!t) return undefined;  const variantIds = await this.findVariantDocumentsForProductIds(product.id, defaultLanguageCode, productSlug);  return {    _type: 'vendureProduct',    vendureId: parseInt(product.id.toString()),    title: t.name,    slug: { current: t.slug },    productVariants: variantIds.map(id => ({ _type: 'reference', _ref: id })),  };}
```

Relationship Handling

One of the most important aspects of CMS integration is maintaining relationships between entities. Sanity uses document IDs to create references between content pieces.

- Finding Related Entities (Vendure DB)

```
private async findProductVariants(productId: string | number): Promise<ProductVariant[]> {  try {    return await this.connection.rawConnection.getRepository(ProductVariant).find({      where: { productId: productId as any },      relations: ['translations'],      order: { id: 'ASC' },    });  } catch (e) {    Logger.error(`Failed to find variants for product ${productId}`, String(e));    return [];  }}
```

- Batch Document Lookups (GROQ)

```
private async findDocumentsBySlugs(type: 'vendureProduct' | 'vendureProductVariant' | 'vendureCollection', slugs: string[]): Promise<Map<string, any>> {  const map = new Map<string, any>();  if (slugs.length === 0) return map;  const results = await this.query<any[]>(`*[_type == $type && slug.current in $slugs]{ _id, "slug": slug.current }`, { type, slugs });  for (const doc of results ?? []) if (doc?.slug) map.set(doc.slug, doc);  return map;}
```

- Building Relationships

```
private async findVariantDocumentsForProductIds(  productId: string | number,  defaultLanguageCode: LanguageCode,  productSlug?: string | null,): Promise<string[]> {  if (!productSlug) return [];  const variants = await this.findProductVariants(productId);  const slugs = variants.map(v => `${productSlug}-variant-${v.id}`);  if (slugs.length === 0) return [];  const docs = await this.findDocumentsBySlugs('vendureProductVariant', slugs);  const ids: string[] = [];  docs.forEach(doc => { if (doc?._id) ids.push(String(doc._id)); });  return ids;}private async findParentProductDocumentId(variant: ProductVariant, defaultLanguageCode: LanguageCode): Promise<string | null> {  const product = await this.connection.rawConnection.getRepository(Product).findOne({ where: { id: variant.productId }, relations: ['translations'] });  if (!product) return null;  const t = product.translations.find(tr => tr.languageCode === defaultLanguageCode);  if (!t?.slug) return null;  const results = await this.query<any[]>(`*[_type == "vendureProduct" && slug.current == $slug][0]{ _id }`, { slug: t.slug });  return results?._id ?? null;}
```

CRUD Operations

These methods handle the basic Create, Read, Update, and Delete operations for documents in Sanity. They use GROQ queries for lookups and mutations for write operations.

```
private async findDocumentBySlug(type: 'vendureProduct' | 'vendureProductVariant' | 'vendureCollection', slug: string) {  return this.query<any>(`*[_type == $type && slug.current == $slug][0]{ _id, "slug": slug.current }`, { type, slug });}private async createDocumentFromProduct(product: Product, defaultLanguageCode: LanguageCode, productSlug?: string | null) {  const data = await this.transformProductData(product, defaultLanguageCode, productSlug);  if (!data) return;  await this.mutate([{ create: data }]);  Logger.info(`Created product ${product.id} in Sanity`);}// Additional CRUD methods like updateDocumentFromProduct and deleteDocumentFromProduct// follow similar patterns with PUT and DELETE HTTP methods respectively.// Full implementations are available in the working example repository.
```

Configuration

Add Sanity options to your plugin types and configure via vendure-config.ts.

```
export interface PluginInitOptions {    // ... existing options    sanityApiKey?: string;    sanityProjectId?: string;    sanityDataset?: string;}
```

```
CmsPlugin.init({  sanityApiKey: process.env.SANITY_API_KEY,  sanityProjectId: process.env.SANITY_PROJECT_ID,  sanityDataset: process.env.SANITY_DATASET,}),
```

Environment Variables

```
SANITY_API_KEY=your_sanity_api_keySANITY_PROJECT_ID=your_project_idSANITY_DATASET=production
```

For the complete implementation (including variants and collections, advanced error handling, and bulk operations), see:

https://github.com/vendure-ecommerce/examples/tree/master/examples/sanity-cms-integration

[https://github.com/vendure-ecommerce/examples/tree/master/examples/sanity-cms-integration](https://github.com/vendure-ecommerce/examples/tree/master/examples/sanity-cms-integration)The complete, production-ready Payload implementation can be found in the Payload integration example. It includes advanced features like local API communication, collection management, and relationship handling.

[Payload integration example](https://github.com/vendure-ecommerce/examples/tree/master/examples/payload-cms-integration)This guide provides a complete integration for Vendure with Payload CMS, including setting up a Payload application and implementing the synchronization service.

Setting up Payload CMS

#### 1. Create a new Payload project​


[​](#1-create-a-new-payload-project)Initialize your Payload project using the CLI:

```
npx create-payload-app@latest payload-integration-appcd payload-integration-app
```

Choose the following options when prompted:

- Use TypeScript? Yes
- Choose a database: SQLite (or your preferred database)
- Package manager: npm

#### 2. Configure development server​


[​](#2-configure-development-server)Update your development script to use port 3001 to avoid conflicts with Vendure:

```
{    "scripts": {        "dev": "cross-env PAYLOAD_CONFIG_PATH=src/payload.config.ts nodemon --exec tsx src/server.ts",        "dev:payload": "payload dev --port 3001"    }}
```

Defining Collection Schemas

#### 1. Create Vendure-specific collections​


[​](#1-create-vendure-specific-collections)Create the collection configurations in your collections folder:

VendureEntities.ts

```
import type { CollectionConfig } from 'payload/types';export const VendureProduct: CollectionConfig = {    slug: 'vendure-product',    // WARNING: Development-only access! This grants unrestricted CRUD access to anyone.    // For production, implement proper authentication and role-based access control.    access: {        // DEV ONLY: Public read access        read: () => true,        create: () => true,        update: () => true,        delete: () => true,    },    fields: [        {            name: 'id',            type: 'number',            required: true,            unique: true,        },        {            name: 'name',            type: 'text',            required: true,        },        {            name: 'slug',            type: 'text',            required: true,        },        {            name: 'productVariants',            type: 'relationship',            relationTo: 'vendure-product-variant',            hasMany: true,        },    ],};// Additional collection configurations for VendureProductVariant and VendureCollection// follow the same pattern with appropriate field definitions and relationships.// export const VendureProductVariant: CollectionConfig = { ... }// export const VendureCollection: CollectionConfig = { ... }
```

#### 2. Register collections in Payload config​


[​](#2-register-collections-in-payload-config)Update your payload.config.ts to include the Vendure collections:

```
import { VendureProduct, VendureProductVariant, VendureCollection } from './collections/VendureEntities';export default buildConfig({    // ... other config    collections: [        VendureProduct,        VendureProductVariant,        VendureCollection,        // ... other collections    ],});
```

#### 3. Run migrations​


[​](#3-run-migrations)After setting up your collections, create and run migrations:

```
# Create a fresh migration (drops all tables and recreates)npm payload migrate:fresh# Alternative: Create specific migration (safer for production)npm payload migrate:create add-vendure-collectionsnpm payload migrate# Generate TypeScript typesnpm payload generate:types

```

The Payload Service

The PayloadService handles all Payload-specific operations including local API communication, document management, and relationship resolution. Key features include:

- Local API Communication: Direct communication with Payload's local API
- Document Management: CRUD operations for Payload documents
- Relationship Handling: Manages references between products, variants, and collections

Basic Service Structure

The PayloadService handles all Payload-specific operations including local API communication, document management, and relationship resolution.

```
@Injectable()export class PayloadService {    private readonly payloadBaseUrl = this.options.payloadBaseUrl || 'http://localhost:3001/api';    constructor(@Inject(CMS_PLUGIN_OPTIONS) private options: PluginInitOptions) {}    async syncProduct({ product, defaultLanguageCode, operationType }) {        switch (operationType) {            case 'create':                return this.createDocumentFromProduct(product, defaultLanguageCode);            case 'update':                return this.updateDocumentFromProduct(product, defaultLanguageCode);            case 'delete':                return this.deleteDocumentFromProduct(product);        }    }}
```

Making API Requests

All Payload API communication is centralized through a single method that handles authentication, error handling, and response parsing. This approach ensures consistent behavior across all operations.

```
private getPayloadHeaders(): Record<string, string> {  const headers: Record<string, string> = { 'Content-Type': 'application/json' };  if (this.options.payloadApiKey) {    headers.Authorization = `Bearer ${this.options.payloadApiKey}`;  }  return headers;}private async makePayloadRequest({  method,  endpoint,  data,}: {  method: 'GET' | 'POST' | 'PATCH' | 'DELETE';  endpoint: string;  data?: any;}) {  const url = `${this.payloadBaseUrl}/${endpoint}`;  const res = await fetch(url, {    method,    headers: this.getPayloadHeaders(),    body: data && (method === 'POST' || method === 'PATCH') ? JSON.stringify(data) : undefined,  });  if (!res.ok) {    throw new Error(`Payload API error: ${res.status} ${res.statusText}`);  }  return method === 'DELETE' ? {} : res.json();}
```

Data Transformation

Transformation methods convert Vendure entities into the format expected by Payload's API. The document structure must match the collection schema defined in Payload.

```
private async transformProductData(  product: Product,  defaultLanguageCode: LanguageCode,  productSlug?: string | null,) {  const t = product.translations.find(tr => tr.languageCode === defaultLanguageCode);  if (!t) return undefined;  const variantDocumentIds = await this.findVariantDocumentsForProductIds(    product.id,    defaultLanguageCode,    productSlug,  );  return {    id: parseInt(product.id.toString()),    name: t.name,    slug: t.slug,    productVariants: variantDocumentIds,  };}
```

Relationship Handling

One of the most important aspects of CMS integration is maintaining relationships between entities. Payload uses document IDs to create references between content pieces.

- Finding Related Entities

> First, we need methods to query the Vendure database for related entities:

First, we need methods to query the Vendure database for related entities:

```
private async findProductVariants(productId: string | number): Promise<ProductVariant[]> {  return this.connection.rawConnection.getRepository(ProductVariant).find({    where: { productId: productId },    relations: ['translations'],    order: { id: 'ASC' },  });}
```

- Building Relationships

> Then, we combine database queries with CMS lookups to build relationships:

Then, we combine database queries with CMS lookups to build relationships:

```
private async findVariantDocumentsForProductIds(  productId: string | number,  defaultLanguageCode: LanguageCode,  productSlug?: string | null,): Promise<string[]> {  if (!productSlug) return [];  const variants = await this.findProductVariants(productId);  const slugs = variants.map(v => `${productSlug}-variant-${v.id}`);  if (slugs.length === 0) return [];  const docs = await this.findDocumentsBySlugs('vendure-product-variant', slugs);  const ids: string[] = [];  docs.forEach(doc => {    if (doc?.id) {      ids.push(String(doc.id));    }  });  return ids;}private async findParentProductDocumentId(  variant: ProductVariant,  defaultLanguageCode: LanguageCode,): Promise<string | null> {  const product = await this.connection.rawConnection.getRepository(Product).findOne({    where: { id: variant.productId },    relations: ['translations'],  });  if (!product) return null;  const t = product.translations.find(tr => tr.languageCode === defaultLanguageCode);  if (!t?.slug) return null;  const doc = await this.findDocumentBySlug('vendure-product', t.slug);  return doc?.id ? String(doc.id) : null;}
```

CRUD Operations

These methods handle the basic Create, Read, Update, and Delete operations for documents in Payload. They follow REST API conventions and leverage the centralized request method for consistent behavior.

```
private async findDocumentBySlug(collection: string, slug: string) {  const res = await this.makePayloadRequest({ method: 'GET', endpoint: `${collection}?where[slug][equals]=${encodeURIComponent(slug)}&limit=1` });  return res.docs?.[0] ?? null;}private async createDocumentFromProduct(product: Product, defaultLanguageCode: LanguageCode, productSlug?: string | null) {  const data = await this.transformProductData(product, defaultLanguageCode, productSlug);  if (!data) return;  const res = await this.makePayloadRequest({ method: 'POST', endpoint: 'vendure-product', data });  Logger.info(`Created product ${product.id} (Payload ID: ${res.doc?.id})`);}// Additional CRUD methods like updateStoryFromProduct and deleteStoryFromProduct// follow similar patterns with PUT and DELETE HTTP methods respectively.// Full implementations are available in the working example repository.
```

Configuration

Update your plugin configuration to include Payload options:

```
export interface PluginInitOptions {    // ... existing options    payloadApiKey?: string;    payloadBaseUrl?: string;}
```

Environment Variables

Add these to your .env file:

```
PAYLOAD_API_KEY=your_payload_api_keyPAYLOAD_BASE_URL=http://localhost:3001/api
```

Final Plugin Configuration

```
CmsPlugin.init({  payloadApiKey: process.env.PAYLOAD_API_KEY,  payloadBaseUrl: process.env.PAYLOAD_BASE_URL || 'http://localhost:3001/api',}),
```

This section provides a high-level overview. For a complete, production-ready implementation, see the Payload integration example:
https://github.com/vendure-ecommerce/examples/tree/master/examples/payload-cms-integration

[https://github.com/vendure-ecommerce/examples/tree/master/examples/payload-cms-integration](https://github.com/vendure-ecommerce/examples/tree/master/examples/payload-cms-integration)
## Admin API Integration​


[​](#admin-api-integration)To allow for manual synchronization through graphQL mutations, we can extend the Admin API with new mutations. Let's use the CLI to generate the API extensions:

```
# Generate API extensions for the CMS pluginnpx vendure add -a CmsSyncAdminResolver --selected-plugin CmsPlugin

```

### Extending the GraphQL API​


[​](#extending-the-graphql-api)
```
export const adminApiExtensions = gql`  extend type Mutation {    syncProductToCms(productId: ID!): SyncResponse!    syncCollectionToCms(collectionId: ID!): SyncResponse!  }  // ...`;
```

### Implementing the Resolver​


[​](#implementing-the-resolver)The resolver for these mutations re-uses the existing CmsSyncService to add a job to the queue.

```
@Resolver()export class CmsSyncAdminResolver {    constructor(private cmsSyncService: CmsSyncService) {}    @Mutation()    @Allow(Permission.UpdateCatalog)    async syncProductToCms(@Args() args: { productId: ID }): Promise<SyncResponse> {        // This creates the data payload for the job        const syncData: SyncJobData = {            entityType: 'Product',            entityId: args.productId,            operationType: 'update', // Manual syncs are usually 'update'            timestamp: new Date().toISOString(),            retryCount: 0,        };        // The service method adds the job to the queue        await this.cmsSyncService.triggerProductSync(syncData);        return {            success: true,            message: `Successfully queued sync for product ${args.productId}.`,        };    }    // ... resolver for collection sync}
```

## Final Configuration​


[​](#final-configuration)Finally, add the plugin to your vendure-config.ts file with the appropriate configuration for your chosen CMS platform.

```
import { VendureConfig } from '@vendure/core';import { CmsPlugin } from './plugins/cms/cms.plugin';export const config: VendureConfig = {    // ... other config    plugins: [        // ... other plugins        CmsPlugin.init({            // Configure based on your chosen CMS platform            // See platform-specific tabs above for exact configuration            cmsApiKey: process.env.CMS_API_KEY,            // Additional CMS-specific options...        }),    ],};
```

Refer to the platform-specific configuration examples in the tabs above for the exact environment variables and options needed for your chosen CMS.

For complete, production-ready implementations, see the working examples:

- Storyblok CMS Integration
- Strapi CMS Integration
- Sanity CMS Integration
- Payload CMS Integration

[Storyblok CMS Integration](https://github.com/vendure-ecommerce/examples/tree/master/examples/storyblok-cms-integration)[Strapi CMS Integration](https://github.com/vendure-ecommerce/examples/tree/master/examples/strapi-cms-integration)[Sanity CMS Integration](https://github.com/vendure-ecommerce/examples/tree/master/examples/sanity-cms-integration)[Payload CMS Integration](https://github.com/vendure-ecommerce/examples/tree/master/examples/payload-cms-integration)


---

# GraphQL Code Generation


Code generation means the automatic generation of TypeScript types based on your GraphQL schema and your GraphQL operations.
This is a very powerful feature that allows you to write your code in a type-safe manner, without you needing to manually
write any types for your API calls.

To do this, we will use Graphql Code Generator.

[Graphql Code Generator](https://the-guild.dev/graphql/codegen)Use npx vendure add and select "Set up GraphQL code generation" to quickly set up code generation.

You can then run npx vendure schema to generate a schema.graphql file in your root
directory.

[Vendure CLI](/guides/developer-guide/cli/)This guide is for adding codegen to your Vendure plugins. For a guide on adding codegen to your storefront, see the Storefront Codegen guide.

[Storefront Codegen](/guides/storefront/codegen/)
## Installation​


[​](#installation)It is recommended to use the vendure add CLI command as detailed above to set up codegen.
If you prefer to set it up manually, follow the steps below.

First, install the required dependencies:

```
npm install -D @graphql-codegen/cli @graphql-codegen/typescript
```

## Configuration​


[​](#configuration)Add a codegen.ts file to your project root with the following contents:

```
import type {CodegenConfig} from '@graphql-codegen/cli';const config: CodegenConfig = {    overwrite: true,    // To generate this schema file, run `npx vendure schema`    // whenever your schema changes, e.g. after adding custom fields    // or API extensions    schema: 'schema.graphql',    config: {        // This tells codegen that the `Money` scalar is a number        scalars: { Money: 'number' },        // This ensures generated enums do not conflict with the built-in types.        namingConvention: { enumValues: 'keep' },    },    generates: {        // The path to the generated type file in your        // plugin directory. Adjust accordingly.        'src/plugins/organization/gql/generated.ts': {            plugins: ['typescript'],        },    },};export default config;
```

This assumes that we have an "organization" plugin which adds support for grouping customers into organizations, e.g. for B2B use-cases.

## Running codegen​


[​](#running-codegen)You can now add a script to your package.json to run codegen:

```
{  "scripts": {    "codegen": "graphql-codegen --config codegen.ts"  }}
```

Ensure your server is running, then run the codegen script:

```
npm run codegen
```

This will generate a file at src/plugins/organization/gql/generated.ts which contains all the GraphQL types corresponding to your schema.

## Using generated types in resolvers & services​


[​](#using-generated-types-in-resolvers--services)You would then use these types in your resolvers and service methods, for example:

```
import { Args, Mutation, Query, Resolver } from '@nestjs/graphql';import { Allow, Ctx, PaginatedList, RequestContext, Transaction } from '@vendure/core';import { organizationPermission } from '../constants';import { Organization } from '../entities/organization.entity';import { OrganizationService } from '../services/organization.service';import { QueryOrganizationArgs, MutationCreateOrganizationArgs } from '../gql/generated';@Resolver()export class AdminResolver {    constructor(private organizationService: OrganizationService) {}    @Query()    @Allow(organizationPermission.Read)    organization(@Ctx() ctx: RequestContext, @Args() args: QueryOrganizationArgs): Promise<Organization> {        return this.organizationService.findOne(ctx, args.id);    }        @Transaction()    @Mutation()    @Allow(organizationPermission.Create)    createOrganization(        @Ctx() ctx: RequestContext,        @Args() args: MutationCreateOrganizationArgs,    ): Promise<Organization> {        return this.organizationService.create(ctx, args.input);    }    // ... etc}
```

In your service methods you can directly use any input types defined in your schema:

```
import { Injectable } from '@nestjs/common';import { RequestContext, TransactionalConnection } from '@vendure/core';import { Organization } from '../entities/organization.entity';import { CreateOrganizationInput, UpdateOrganizationInput } from "../gql/generated";@Injectable()export class OrganizationService {    constructor(private connection: TransactionalConnection) {}    async create(ctx: RequestContext, input: CreateOrganizationInput): Promise<Organization> {        return this.connection.getRepository(ctx, Organization).save(new Organization(input));    }    async update(ctx: RequestContext, input: UpdateOrganizationInput): Promise<Organization> {        const example = await this.connection.getEntityOrThrow(ctx, Organization, input.id);        const updated = {...example, ...input};        return this.connection.getRepository(ctx, Organization).save(updated);    }}
```

## Codegen for Admin UI extensions​


[​](#codegen-for-admin-ui-extensions)This section refers to the deprecated Angular-based Admin UI. The new React-based Dashboard has built-in graphql type safety
and does not require additional setup.

When you create Admin UI extensions, very often those UI components will be making API calls to the Admin API. In this case, you can use codegen to generate the types for those API calls.

To do this, we will use the "client preset" plugin. Assuming you have already completed the setup above, you'll need to install the following additional dependency:

["client preset" plugin](https://the-guild.dev/graphql/codegen/plugins/presets/preset-client)
```
npm install -D @graphql-codegen/client-preset
```

Then add the following to your codegen.ts file:

```
import type { CodegenConfig } from '@graphql-codegen/cli';const config: CodegenConfig = {    overwrite: true,    schema: 'http://localhost:3000/admin-api',    config: {        scalars: { Money: 'number' },        namingConvention: { enumValues: 'keep' },    },    generates: {        'apps/marketplace/src/plugins/marketplace/ui/gql/': {            preset: 'client',            documents: 'apps/marketplace/src/plugins/marketplace/ui/**/*.ts',            // This disables the "fragment masking" feature. Fragment masking            // can improve component isolation but introduces some additional            // complexity that we will avoid for now.            presetConfig: {                fragmentMasking: false,            },        },        'apps/marketplace/src/plugins/marketplace/gql/generated.ts': {            plugins: ['typescript'],        },    },};export default config;
```

For the client preset plugin, we need to specify a directory (.../ui/gql/) because a number of files will get generated.

### Use the graphql() function​


[​](#use-the-graphql-function)In your Admin UI components, you can now use the graphql() function exported from the generated file to define your
GraphQL operations. For example:

```
import { ChangeDetectionStrategy, Component } from '@angular/core';import { SharedModule, TypedBaseListComponent } from '@vendure/admin-ui/core';import { graphql } from '../../gql';const getOrganizationListDocument = graphql(`    query GetOrganizationList($options: OrganizationListOptions) {        organizations(options: $options) {            items {                id                createdAt                updatedAt                name                invoiceEmailAddresses            }            totalItems        }    }`);@Component({    selector: 'organization-list',    templateUrl: './organization-list.component.html',    styleUrls: ['./organization-list.component.scss'],    changeDetection: ChangeDetectionStrategy.OnPush,    standalone: true,    imports: [SharedModule],})export class OrganizationListComponent extends TypedBaseListComponent<    typeof getOrganizationListDocument,    'organizations'> {        // Sort & filter definitions omitted for brevity.    // For a complete ListComponent example, see the     // "Creating List Views" guide.    constructor() {        super();        super.configure({            document: getOrganizationListDocument,            getItems: (data) => data.organizations,            setVariables: (skip, take) => ({                options: {                    skip,                    take,                    filter: {                        name: {                            contains: this.searchTermControl.value,                        },                        ...this.filters.createFilterInput(),                    },                    sort: this.sorts.createSortInput(),                },            }),            refreshListOnChanges: [this.filters.valueChanges, this.sorts.valueChanges],        });    }}
```

Whenever you write a new GraphQL operation, or change an existing one, you will need to re-run the codegen script to generate the types for that operation.

## Codegen watch mode​


[​](#codegen-watch-mode)You can also set up file watching as described in the Graphql Code Generator watch mode docs.

[Graphql Code Generator watch mode docs](https://the-guild.dev/graphql/codegen/docs/getting-started/development-workflow#watch-mode)


---

# Configurable Products


A "configurable product" is one where aspects can be configured by the customer, and are unrelated to the product's variants. Examples include:

- Engraving text on an item
- A gift message inserted with the packaging
- An uploaded image to be printed on a t-shirt

In Vendure this is done by defining one or more custom fields on the OrderLine entity.

[custom fields](/guides/developer-guide/custom-fields/)[OrderLine](/reference/typescript-api/entities/order-line/)
## Defining custom fields​


[​](#defining-custom-fields)Let's take the example of an engraving service. Some products can be engraved, others cannot. We will record this information in a custom field on the ProductVariant entity:

[ProductVariant](/reference/typescript-api/entities/product-variant/)
```
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    customFields: {        ProductVariant: [            {                name: 'engravable',                type: 'boolean',                defaultValue: false,                label: [                    { languageCode: LanguageCode.en, value: 'Engravable' },                ],            },        ],    },};
```

For those variants that are engravable, we need to be able to record the text to be engraved. This is done by defining a custom field on the OrderLine entity:

[OrderLine](/reference/typescript-api/entities/order-line/)
```
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    customFields: {        OrderLine: [            {                name: 'engravingText',                type: 'string',                validate: value => {                    if (value.length > 100) {                        return 'Engraving text must be less than 100 characters';                    }                },                label: [                    { languageCode: LanguageCode.en, value: 'Engraving text' },                ],            },        ]    },};
```

## Setting the custom field value​


[​](#setting-the-custom-field-value)Once the custom fields are defined, the addItemToOrder mutation will have a third argument available, which accepts values for the custom field defined above:

[addItemToOrder mutation](/reference/graphql-api/shop/mutations/#additemtoorder)
```
mutation {    addItemToOrder(        productVariantId: "42"        quantity: 1        customFields: {            engravingText: "Thanks for all the fish!"        }    ) {        ...on Order {            id            lines {                id                quantity                customFields {                    engravingText                }            }        }    }}
```

Your storefront application will need to provide a <textarea> for the customer to enter the engraving text, which would be displayed conditionally depending on the value of the engravable custom field on the ProductVariant.

## Modifying the price​


[​](#modifying-the-price)The values of these OrderLine custom fields can even be used to modify the price. This is done by defining a custom OrderItemPriceCalculationStrategy.

[OrderItemPriceCalculationStrategy](/reference/typescript-api/orders/order-item-price-calculation-strategy/)Let's say that our engraving service costs and extra $10 on top of the regular price of the product variant. Here's a strategy to implement this:

```
import {    RequestContext, PriceCalculationResult,    ProductVariant, OrderItemPriceCalculationStrategy} from '@vendure/core';export class EngravingPriceStrategy implements OrderItemPriceCalculationStrategy {    calculateUnitPrice(        ctx: RequestContext,        productVariant: ProductVariant,        customFields: { engravingText?: string },    ) {        let price = productVariant.listPrice;        if (customFields.engravingText) {            // Add $10 for engraving            price += 1000;        }        return {            price,            priceIncludesTax: productVariant.listPriceIncludesTax,        };    }}
```

This is then added to the config:

```
import { VendureConfig } from '@vendure/core';import { EngravingPriceStrategy } from './engraving-price-calculation-strategy';export const config: VendureConfig = {    // ...    orderOptions: {        orderItemPriceCalculationStrategy: new EngravingPriceStrategy(),    },};
```


---

# Digital Products


Digital products include things like ebooks, online courses, and software. They are products that are delivered to the customer electronically, and do not require
physical shipping.

This guide will show you how you can add support for digital products to Vendure.

## Creating the plugin​


[​](#creating-the-plugin)The complete source of the following example plugin can be found here: example-plugins/digital-products

[example-plugins/digital-products](https://github.com/vendure-ecommerce/vendure/tree/master/packages/dev-server/example-plugins/digital-products)
### Define custom fields​


[​](#define-custom-fields)If some products are digital and some are physical, we can distinguish between them by adding a customField to the ProductVariant entity.

```
import { LanguageCode, PluginCommonModule, VendurePlugin } from '@vendure/core';@VendurePlugin({    imports: [PluginCommonModule],    configuration: config => {        config.customFields.ProductVariant.push({            type: 'boolean',            name: 'isDigital',            defaultValue: false,            label: [{ languageCode: LanguageCode.en, value: 'This product is digital' }],            public: true,        });        return config;    },})export class DigitalProductsPlugin {}
```

You will need to create a migration after adding this custom field.
See the Migrations guide for more information.

[Migrations](/guides/developer-guide/migrations/)We will also define a custom field on the ShippingMethod entity to indicate that this shipping method is only available for digital products:

```
import { LanguageCode, PluginCommonModule, VendurePlugin } from '@vendure/core';@VendurePlugin({    imports: [PluginCommonModule],    configuration: config => {        // config.customFields.ProductVariant.push({ ... omitted        config.customFields.ShippingMethod.push({            type: 'boolean',            name: 'digitalFulfilmentOnly',            defaultValue: false,            label: [{ languageCode: LanguageCode.en, value: 'Digital fulfilment only' }],            public: true,        });        return config;    },})
```

Lastly we will define a custom field on the Fulfillment entity where we can store download links for the digital products. If your own implementation you may
wish to handle this part differently, e.g. storing download links on the Order entity or in a custom entity.

```
import { LanguageCode, PluginCommonModule, VendurePlugin } from '@vendure/core';@VendurePlugin({    imports: [PluginCommonModule],    configuration: config => {        // config.customFields.ProductVariant.push({ ... omitted        // config.customFields.ShippingMethod.push({ ... omitted        config.customFields.Fulfillment.push({            type: 'string',            name: 'downloadUrls',            nullable: true,            list: true,            label: [{ languageCode: LanguageCode.en, value: 'Urls of any digital purchases' }],            public: true,        });        return config;    },})
```

### Create a custom FulfillmentHandler​


[​](#create-a-custom-fulfillmenthandler)The FulfillmentHandler is responsible for creating the Fulfillment entities when an Order is fulfilled. We will create a custom handler which
is responsible for performing the logic related to generating the digital download links.

In your own implementation, this may look significantly different depending on your requirements.

```
import { FulfillmentHandler, LanguageCode, OrderLine, TransactionalConnection } from '@vendure/core';import { In } from 'typeorm';let connection: TransactionalConnection;/** * @description * This is a fulfillment handler for digital products which generates a download url * for each digital product in the order. */export const digitalFulfillmentHandler = new FulfillmentHandler({    code: 'digital-fulfillment',    description: [        {            languageCode: LanguageCode.en,            value: 'Generates product keys for the digital download',        },    ],    args: {},    init: injector => {        connection = injector.get(TransactionalConnection);    },    createFulfillment: async (ctx, orders, lines) => {        const digitalDownloadUrls: string[] = [];        const orderLines = await connection.getRepository(ctx, OrderLine).find({            where: {                id: In(lines.map(l => l.orderLineId)),            },            relations: {                productVariant: true,            },        });        for (const orderLine of orderLines) {            if (orderLine.productVariant.customFields.isDigital) {                // This is a digital product, so generate a download url                const downloadUrl = await generateDownloadUrl(orderLine);                digitalDownloadUrls.push(downloadUrl);            }        }        return {            method: 'Digital Fulfillment',            trackingCode: 'DIGITAL',            customFields: {                downloadUrls: digitalDownloadUrls,            },        };    },});function generateDownloadUrl(orderLine: OrderLine) {    // This is a dummy function that would generate a download url for the given OrderLine    // by interfacing with some external system that manages access to the digital product.    // In this example, we just generate a random string.    const downloadUrl = `https://example.com/download?key=${Math.random().toString(36).substring(7)}`;    return Promise.resolve(downloadUrl);}
```

This fulfillment handler should then be added to the fulfillmentHandlers array the config ShippingOptions:

```
import { LanguageCode, PluginCommonModule, VendurePlugin } from '@vendure/core';import { digitalFulfillmentHandler } from './config/digital-fulfillment-handler';@VendurePlugin({    imports: [PluginCommonModule],    configuration: config => {        // config.customFields.ProductVariant.push({ ... omitted        // config.customFields.ShippingMethod.push({ ... omitted        // config.customFields.Fulfillment.push({ ... omitted        config.shippingOptions.fulfillmentHandlers.push(digitalFulfillmentHandler);        return config;    },})export class DigitalProductsPlugin {}
```

### Create a custom ShippingEligibilityChecker​


[​](#create-a-custom-shippingeligibilitychecker)We want to ensure that the digital shipping method is only applicable to orders containing at least one digital product.
We do this with a custom ShippingEligibilityChecker:

```
import { LanguageCode, ShippingEligibilityChecker } from '@vendure/core';export const digitalShippingEligibilityChecker = new ShippingEligibilityChecker({    code: 'digital-shipping-eligibility-checker',    description: [        {            languageCode: LanguageCode.en,            value: 'Allows only orders that contain at least 1 digital product',        },    ],    args: {},    check: (ctx, order, args) => {        const digitalOrderLines = order.lines.filter(l => l.productVariant.customFields.isDigital);        return digitalOrderLines.length > 0;    },});
```

### Create a custom ShippingLineAssignmentStrategy​


[​](#create-a-custom-shippinglineassignmentstrategy)When adding shipping methods to the order, we want to ensure that digital products are correctly assigned to the digital shipping
method, and physical products are not.

```
import {    Order,    OrderLine,    RequestContext,    ShippingLine,    ShippingLineAssignmentStrategy,} from '@vendure/core';/** * @description * This ShippingLineAssignmentStrategy ensures that digital products are assigned to a * ShippingLine which has the `isDigital` flag set to true. */export class DigitalShippingLineAssignmentStrategy implements ShippingLineAssignmentStrategy {    assignShippingLineToOrderLines(        ctx: RequestContext,        shippingLine: ShippingLine,        order: Order,    ): OrderLine[] | Promise<OrderLine[]> {        if (shippingLine.shippingMethod.customFields.isDigital) {            return order.lines.filter(l => l.productVariant.customFields.isDigital);        } else {            return order.lines.filter(l => !l.productVariant.customFields.isDigital);        }    }}
```

### Define a custom OrderProcess​


[​](#define-a-custom-orderprocess)In order to automatically fulfill any digital products as soon as the order completes, we can define a custom OrderProcess:

```
import { OrderProcess, OrderService } from '@vendure/core';import { digitalFulfillmentHandler } from './digital-fulfillment-handler';let orderService: OrderService;/** * @description * This OrderProcess ensures that when an Order transitions from ArrangingPayment to * PaymentAuthorized or PaymentSettled, then any digital products are automatically * fulfilled. */export const digitalOrderProcess: OrderProcess<string> = {    init(injector) {        orderService = injector.get(OrderService);    },    async onTransitionEnd(fromState, toState, data) {        if (            fromState === 'ArrangingPayment' &&            (toState === 'PaymentAuthorized' || toState === 'PaymentSettled')        ) {            const digitalOrderLines = data.order.lines.filter(l => l.productVariant.customFields.isDigital);            if (digitalOrderLines.length) {                await orderService.createFulfillment(data.ctx, {                    lines: digitalOrderLines.map(l => ({ orderLineId: l.id, quantity: l.quantity })),                    handler: { code: digitalFulfillmentHandler.code, arguments: [] },                });            }        }    },};
```

### Complete plugin & add to config​


[​](#complete-plugin--add-to-config)The complete plugin can be found here: example-plugins/digital-products

[example-plugins/digital-products](https://github.com/vendure-ecommerce/vendure/tree/master/packages/dev-server/example-plugins/digital-products)We can now add the plugin to the VendureConfig:

```
import { VendureConfig } from '@vendure/core';import { DigitalProductsPlugin } from './plugins/digital-products/digital-products.plugin';const config: VendureConfig = {    // ... other config omitted    plugins: [        // ... other plugins omitted        DigitalProductsPlugin,    ],};
```

## Create the ShippingMethod​


[​](#create-the-shippingmethod)Once these parts have been defined and bundled up in a Vendure plugin, we can create a new ShippingMethod via the Dashboard, and
make sure to check the "isDigital" custom field, and select the custom fulfillment handler and eligibility checker:

## Mark digital products​


[​](#mark-digital-products)We can now also set any digital product variants by checking the custom field:

## Storefront integration​


[​](#storefront-integration)In the storefront, when the customer is checking out, we can use the eligibleShippingMethods query to determine which shipping methods
are available to the customer. If the customer has any digital products in the order, the "digital-download" shipping method will be available:

- Query
- Response

```
query {  eligibleShippingMethods {    id    name    price    priceWithTax    customFields {      isDigital    }  }}
```

```
{  "data": {    "eligibleShippingMethods": [      {        "id": "3",        "name": "Digital Download",        "price": 0,        "priceWithTax": 0,        "customFields": {          "isDigital": true        }      },      {        "id": "1",        "name": "Standard Shipping",        "price": 500,        "priceWithTax": 500,        "customFields": {          "isDigital": false        }      },      {        "id": "2",        "name": "Express Shipping",        "price": 1000,        "priceWithTax": 1000,        "customFields": {          "isDigital": false        }      }    ]  }}
```

If the "digital download" shipping method is eligible, it should be set as a shipping method along with any other method
required by any physical products in the order.

- Query
- Response

```
mutation SetShippingMethod {  setOrderShippingMethod(      shippingMethodId: ["3", "1"]    ) {    ... on Order {      id      code      total      lines {        id        quantity        linePriceWithTax        productVariant {          name          sku          customFields {            isDigital          }        }      }      shippingLines {        id        shippingMethod {          name        }        priceWithTax      }    }  }}
```

```
{  "data": {    "setOrderShippingMethod": {      "id": "11",      "code": "C6H3UZ6WQ62LAPS8",      "total": 5262,      "lines": [        {          "id": "16",          "quantity": 1,          "linePriceWithTax": 1458,          "productVariant": {            "name": "Jeff Buckley Grace mp3 download",            "sku": "1231241241231",            "customFields": {              "isDigital": true            }          }        },        {          "id": "17",          "quantity": 1,          "linePriceWithTax": 4328,          "productVariant": {            "name": "Basketball",            "sku": "WTB1418XB06",            "customFields": {              "isDigital": false            }          }        }      ],      "shippingLines": [        {          "id": "13",          "shippingMethod": {            "name": "Digital Download"          },          "priceWithTax": 0        },        {          "id": "14",          "shippingMethod": {            "name": "Standard Shipping"          },          "priceWithTax": 500        }      ]    }  }}
```


---

# GitHub OAuth Authentication


The complete source of the following example plugin can be found here: example-plugins/github-auth-plugin

[example-plugins/github-auth-plugin](https://github.com/vendure-ecommerce/examples/tree/publish/examples/shop-github-auth)GitHub OAuth authentication allows customers to sign in using their GitHub accounts, eliminating the need for password-based registration.

This is particularly valuable for developer-focused stores or B2B marketplaces.

This guide shows you how to add GitHub OAuth support to your Vendure store using a custom AuthenticationStrategy.

[AuthenticationStrategy](/reference/typescript-api/auth/authentication-strategy/)
## Creating the Plugin​


[​](#creating-the-plugin)First, use the Vendure CLI to create a new plugin for GitHub authentication:

```
npx vendure add -p GitHubAuthPlugin
```

This creates a basic plugin structure with the necessary files.

## Creating the Authentication Strategy​


[​](#creating-the-authentication-strategy)Now create the GitHub authentication strategy. This handles the OAuth flow and creates customer accounts using GitHub profile data:

```
import { AuthenticationStrategy, ExternalAuthenticationService, Injector, RequestContext, User } from '@vendure/core';import { DocumentNode } from 'graphql';import gql from 'graphql-tag';export interface GitHubAuthData {  code: string;  state: string;}export interface GitHubAuthOptions {  clientId: string;  clientSecret: string;}export class GitHubAuthenticationStrategy implements AuthenticationStrategy<GitHubAuthData> {  readonly name = 'github';  private externalAuthenticationService: ExternalAuthenticationService;  constructor(private options: GitHubAuthOptions) {}  init(injector: Injector) {    // Get the service we'll use to create/find customer accounts    this.externalAuthenticationService = injector.get(ExternalAuthenticationService);  }  defineInputType(): DocumentNode {    // Define the GraphQL input type for the authenticate mutation    return gql`      input GitHubAuthInput {        code: String!        state: String!      }    `;  }  async authenticate(ctx: RequestContext, data: GitHubAuthData): Promise<User | false> {    const { code, state } = data;    // Step 1: Exchange the authorization code for an access token    const tokenResponse = await fetch('https://github.com/login/oauth/access_token', {      method: 'POST',      headers: {        'Accept': 'application/json',        'Content-Type': 'application/json',      },      body: JSON.stringify({        client_id: this.options.clientId,        client_secret: this.options.clientSecret,        code,        state,      }),    });    const tokenData = await tokenResponse.json();    if (tokenData.error) {      throw new Error(`GitHub OAuth error: ${tokenData.error_description}`);    }    // Step 2: Use the access token to get user info from GitHub    const userResponse = await fetch('https://api.github.com/user', {      headers: {        'Authorization': `Bearer ${tokenData.access_token}`,        'Accept': 'application/vnd.github.v3+json',      },    });    const user = await userResponse.json();    if (!user.login) {      throw new Error('Unable to retrieve user information from GitHub');    }    // Step 3: Check if this GitHub user already has a Vendure account    const existingCustomer = await this.externalAuthenticationService.findCustomerUser(      ctx,      this.name,      user.login, // GitHub username as external identifier    );    if (existingCustomer) {      // User exists, log them in      return existingCustomer;    }    // Step 4: Create a new customer account for first-time GitHub users    const newCustomer = await this.externalAuthenticationService.createCustomerAndUser(ctx, {      strategy: this.name,      externalIdentifier: user.login, // Store GitHub username      verified: true, // GitHub accounts are pre-verified      emailAddress: `${user.login}-github@vendure.io`, // Unique email to avoid conflicts      firstName: user.name?.split(' ')[0] || user.login,      lastName: user.name?.split(' ').slice(1).join(' ') || '',    });    return newCustomer;  }}
```

The strategy uses Vendure's ExternalAuthenticationService to handle customer creation.

[ExternalAuthenticationService](/reference/typescript-api/auth/external-authentication-service/)It generates a unique email address for each GitHub user to avoid conflicts, and stores the GitHub username as the external identifier for future logins.

## Registering the Strategy​


[​](#registering-the-strategy)Now update the generated plugin file to register your authentication strategy:

```
import { PluginCommonModule, VendurePlugin } from '@vendure/core';import { GitHubAuthenticationStrategy, GitHubAuthOptions } from './github-auth-strategy';@VendurePlugin({  imports: [PluginCommonModule],  configuration: config => {    config.authOptions.shopAuthenticationStrategy.push(new GitHubAuthenticationStrategy(GitHubAuthPlugin.options));    return config;  },})export class GitHubAuthPlugin {  static options: GitHubAuthOptions;  static init(options: GitHubAuthOptions) {    this.options = options;    return GitHubAuthPlugin;  }}
```

## Adding to Vendure Config​


[​](#adding-to-vendure-config)Add the plugin to your Vendure configuration:

```
import { VendureConfig } from '@vendure/core';import { GitHubAuthPlugin } from './plugins/github-auth-plugin/github-auth-plugin.plugin';export const config: VendureConfig = {  // ... other config  plugins: [    // ... other plugins    GitHubAuthPlugin.init({      clientId: process.env.GITHUB_CLIENT_ID!,      clientSecret: process.env.GITHUB_CLIENT_SECRET!,    }),  ],  // ... rest of config};
```

## Setting up GitHub OAuth App​


[​](#setting-up-github-oauth-app)Before you can test the integration, you need to create a GitHub OAuth App:

- Go to GitHub Settings → Developer settings → OAuth Apps
- Click "New OAuth App"
- Fill in the required fields:

Application name: Your app name (e.g., "My Vendure Store")
Homepage URL: http://localhost:3001 (your storefront URL)
Authorization callback URL: http://localhost:3001/auth/github/callback
- Application name: Your app name (e.g., "My Vendure Store")
- Homepage URL: http://localhost:3001 (your storefront URL)
- Authorization callback URL: http://localhost:3001/auth/github/callback
- Click "Register application"
- Copy the Client ID and generate a Client Secret

[GitHub Settings → Developer settings → OAuth Apps](https://github.com/settings/developers)- Application name: Your app name (e.g., "My Vendure Store")
- Homepage URL: http://localhost:3001 (your storefront URL)
- Authorization callback URL: http://localhost:3001/auth/github/callback

The localhost URLs shown here are for local development only. In production, replace localhost:3001 with your actual domain (e.g., https://mystore.com).

Add these credentials to your environment:

```
GITHUB_CLIENT_ID=your_github_client_idGITHUB_CLIENT_SECRET=your_github_client_secret
```

## Frontend Integration​


[​](#frontend-integration)
### Creating the Sign-in URL​


[​](#creating-the-sign-in-url)In your storefront, create a function to generate the GitHub authorization URL:

```
export function createGitHubSignInUrl(): string {  const clientId = process.env.NEXT_PUBLIC_GITHUB_CLIENT_ID;  const redirectUri = encodeURIComponent('http://localhost:3001/auth/github/callback');  const state = Math.random().toString(36).substring(2);  // Store state for CSRF protection  sessionStorage.setItem('github_oauth_state', state);  return `https://github.com/login/oauth/authorize?client_id=${clientId}&redirect_uri=${redirectUri}&scope=read:user&state=${state}`;}
```

### Handling the Callback​


[​](#handling-the-callback)Create a callback handler to process the GitHub response and authenticate with Vendure:

```
import { gql } from 'graphql-request';const AUTHENTICATE_MUTATION = gql`  mutation Authenticate($input: GitHubAuthInput!) {    authenticate(input: { github: $input }) {      ... on CurrentUser {        id        identifier        channels {          code          token          permissions        }      }      ... on InvalidCredentialsError {        authenticationError        errorCode        message      }    }  }`;export async function handleGitHubCallback(code: string, state: string) {  // Verify CSRF protection  const storedState = sessionStorage.getItem('github_oauth_state');  if (state !== storedState) {    throw new Error('Invalid state parameter');  }  sessionStorage.removeItem('github_oauth_state');  // Authenticate with Vendure  const result = await vendureClient.request(AUTHENTICATE_MUTATION, {    input: { code, state }  });  if (result.authenticate.__typename === 'CurrentUser') {    // Authentication successful - redirect to account page    return result.authenticate;  } else {    // Handle authentication error    throw new Error(result.authenticate.message);  }}
```

The OAuth flow follows these steps:

- User clicks "Sign in with GitHub" → redirected to GitHub
- User authorizes your app → GitHub redirects back with code and state
- Your callback exchanges the code for user data → creates Vendure session

## Using the GraphQL API​


[​](#using-the-graphql-api)Once your plugin is running, the GitHub authentication will be available in your shop API:

- Mutation
- Response

```
mutation AuthenticateWithGitHub {  authenticate(input: {    github: {      code: "authorization_code_from_github",      state: "csrf_protection_state"    }  }) {    ... on CurrentUser {      id      identifier      channels {        code        token        permissions      }    }    ... on InvalidCredentialsError {      authenticationError      errorCode      message    }  }}
```

```
{  "data": {    "authenticate": {      "id": "1",      "identifier": "github-user-github@vendure.io",      "channels": [        {          "code": "__default_channel__",          "token": "session_token_here",          "permissions": ["Authenticated"]        }      ]    }  }}
```

## Customer Data Management​


[​](#customer-data-management)GitHub-authenticated customers are managed like any other Vendure Customer:

[Customer](/reference/typescript-api/entities/customer/)- Email: Generated as {username}-github@vendure.io to avoid conflicts
- Verification: Automatically verified (GitHub handles email verification)
- External ID: GitHub username stored for future authentication
- Profile: Name extracted from GitHub profile when available

This means GitHub users work seamlessly with Vendure's order management, promotions, and customer workflows.

[order management](/guides/core-concepts/orders/)[promotions](/guides/core-concepts/promotions/)
## Testing the Integration​


[​](#testing-the-integration)To test your GitHub OAuth integration:

- Start your Vendure server with the plugin configured
- Navigate to your storefront and click the GitHub sign-in link
- Authorize your GitHub app when prompted
- Verify that a new customer is created in the Vendure Dashboard
- Check that subsequent logins find the existing customer account


---

# Google OAuth Authentication


The complete source of the following example plugin can be found here: example-plugins/google-auth-plugin

[example-plugins/google-auth-plugin](https://github.com/vendure-ecommerce/examples/tree/publish/examples/shop-google-auth)Google OAuth authentication allows customers to sign in using their Google accounts, providing a seamless experience that eliminates the need for password-based registration.

This is particularly valuable for consumer-facing stores where users prefer the convenience and security of Google's authentication system, or for B2B platforms where organizations use Google Workspace.

This guide shows you how to add Google OAuth support to your Vendure store using a custom AuthenticationStrategy and Google Identity Services.

[AuthenticationStrategy](/reference/typescript-api/auth/authentication-strategy/)An AuthenticationStrategy in Vendure defines how users can log in to your store. Learn more about authentication in Vendure.

[authentication in Vendure](/guides/core-concepts/auth/)
## Creating the Plugin​


[​](#creating-the-plugin)First, use the Vendure CLI to create a new plugin for Google authentication:

```
npx vendure add -p GoogleAuthPlugin
```

This creates a basic plugin structure with the necessary files.

[plugin](/guides/developer-guide/plugins/)
## Installing Dependencies​


[​](#installing-dependencies)Google authentication requires the Google Auth Library for token verification:

```
npm install google-auth-library
```

This library handles ID token verification securely on the server side, ensuring the tokens received from Google are authentic.

## Creating the Authentication Strategy​


[​](#creating-the-authentication-strategy)Now create the Google authentication strategy. Unlike traditional OAuth flows that use authorization codes, Google Identity Services provides ID tokens directly, which we verify server-side:

```
import {  AuthenticationStrategy,  ExternalAuthenticationService,  Injector,  Logger,  RequestContext,  User,} from '@vendure/core';import { OAuth2Client } from 'google-auth-library';import { DocumentNode } from 'graphql';import { gql } from 'graphql-tag';export type GoogleAuthData = {  token: string;}export interface GoogleAuthOptions {  googleClientId: string;  onUserCreated?: (ctx: RequestContext, injector: Injector, user: User) => void;  onUserFound?: (ctx: RequestContext, injector: Injector, user: User) => void;}export class GoogleAuthStrategy implements AuthenticationStrategy<GoogleAuthData> {  readonly name = 'google';  private client: OAuth2Client;  private externalAuthenticationService: ExternalAuthenticationService;  private logger: Logger;  private injector: Injector;  constructor(private options: GoogleAuthOptions) {    // Initialize Google OAuth2Client for token verification    this.client = new OAuth2Client(options.googleClientId);    this.logger = new Logger();  }  init(injector: Injector) {    // Get services we'll use for customer management    this.externalAuthenticationService = injector.get(ExternalAuthenticationService);    this.injector = injector;  }  defineInputType(): DocumentNode {    // Define the GraphQL input type for the authenticate mutation    return gql`      input GoogleAuthInput {        token: String!      }    `;  }  async authenticate(ctx: RequestContext, data: GoogleAuthData): Promise<User | false> {    try {      // Step 1: Verify the Google ID token      const ticket = await this.client.verifyIdToken({        idToken: data.token,        audience: this.options.googleClientId,      });      const payload = ticket.getPayload();      if (!payload || !payload.email) {        this.logger.error('Invalid Google token or missing email', 'GoogleAuthStrategy');        return false;      }      // Step 2: Check if this Google user already has a Vendure account      const existingUser = await this.externalAuthenticationService.findCustomerUser(        ctx,        this.name,        payload.sub, // Google's unique user ID      );      if (existingUser) {        // User exists, log them in        this.logger.verbose(`User found: ${existingUser.identifier}`, 'GoogleAuthStrategy');        this.options.onUserFound?.(ctx, this.injector, existingUser);        return existingUser;      }      // Step 3: Create a new customer account for first-time Google users      const createdUser = await this.externalAuthenticationService.createCustomerAndUser(ctx, {        strategy: this.name,        externalIdentifier: payload.sub, // Store Google user ID        verified: payload.email_verified || false, // Use Google's verification status        emailAddress: payload.email,        firstName: payload.given_name || 'Google',        lastName: payload.family_name || 'User',      });      this.options.onUserCreated?.(ctx, this.injector, createdUser);      return createdUser;    } catch (error) {      this.logger.error(`Google authentication failed: ${error.message}`, 'GoogleAuthStrategy');      return false;    }  }}
```

The strategy uses Google's OAuth2Client to verify ID tokens and Vendure's ExternalAuthenticationService to handle customer creation.

[OAuth2Client](https://googleapis.dev/nodejs/google-auth-library/latest/classes/OAuth2Client.html)[ExternalAuthenticationService](/reference/typescript-api/auth/external-authentication-service/)Key differences from other OAuth flows:

- ID Token Verification: Google provides signed JWT tokens that we verify directly
- No Code Exchange: Unlike GitHub OAuth, there's no authorization code to exchange
- Email Verification: We respect Google's email verification status
- Fallback Names: Provides defaults if Google profile lacks name information

## Registering the Strategy​


[​](#registering-the-strategy)Now update the generated plugin file to register your authentication strategy:

```
import { PluginCommonModule, VendurePlugin } from '@vendure/core';import { GoogleAuthStrategy } from './google-auth-strategy';export interface GoogleAuthPluginOptions {  googleClientId: string;}@VendurePlugin({  imports: [PluginCommonModule],  configuration: (config) => {    const options = GoogleAuthPlugin.options;    if (options?.googleClientId) {      config.authOptions.shopAuthenticationStrategy.push(        new GoogleAuthStrategy({ googleClientId: options.googleClientId })      );    }    return config;  },})export class GoogleAuthPlugin {  static options: GoogleAuthPluginOptions;  static init(options: GoogleAuthPluginOptions) {    this.options = options;    return GoogleAuthPlugin;  }}
```

## Adding to Vendure Config​


[​](#adding-to-vendure-config)Add the plugin to your Vendure configuration:

```
import { VendureConfig } from '@vendure/core';import { GoogleAuthPlugin } from './plugins/google-auth-plugin/google-auth-plugin.plugin';export const config: VendureConfig = {  // ... other config  plugins: [    // ... other plugins    GoogleAuthPlugin.init({      googleClientId: process.env.GOOGLE_CLIENT_ID!,    }),  ],  // ... rest of config};
```

## Setting up Google OAuth App​


[​](#setting-up-google-oauth-app)Before you can test the integration, you need to create a Google OAuth 2.0 Client:

- Go to the Google Cloud Console
- Create a new project or select an existing one
- Navigate to APIs & Services → Credentials
- Click "Create Credentials" → "OAuth 2.0 Client ID"
- Select "Web application" as the application type
- Configure the client:

Name: Your app name (e.g., "My Vendure Store")
Authorized JavaScript origins: http://localhost:3001
Authorized redirect URIs: http://localhost:3001/sign-in
- Name: Your app name (e.g., "My Vendure Store")
- Authorized JavaScript origins: http://localhost:3001
- Authorized redirect URIs: http://localhost:3001/sign-in

[Google Cloud Console](https://console.cloud.google.com/)- Name: Your app name (e.g., "My Vendure Store")
- Authorized JavaScript origins: http://localhost:3001
- Authorized redirect URIs: http://localhost:3001/sign-in

The localhost URLs shown here are for local development only. In production, replace localhost:3001 with your actual domain (e.g., https://mystore.com).

- Click "Create" and copy the Client ID

Add the client ID to your environment:

```
GOOGLE_CLIENT_ID=your_google_client_id.apps.googleusercontent.com
```

## Frontend Integration​


[​](#frontend-integration)
### Creating the Sign-in Component​


[​](#creating-the-sign-in-component)For the frontend, we'll use Google's official Identity Services library, which provides a secure and user-friendly sign-in experience:

```
'use client';import { useEffect, useState } from 'react';import { useRouter } from 'next/navigation';const GOOGLE_CLIENT_ID = process.env.NEXT_PUBLIC_GOOGLE_CLIENT_ID;declare global {  interface Window {    google: any;    handleCredentialResponse?: (response: any) => void;  }}export function GoogleSignInButton() {  const router = useRouter();  const [pending, setPending] = useState(false);  useEffect(() => {    // Define the callback function globally    window.handleCredentialResponse = async (response: any) => {      setPending(true);      try {        const result = await authenticateWithGoogle(response.credential);        if (result?.success) {          router.replace('/account');        } else {          console.error('Authentication failed:', result?.message);        }      } catch (error) {        console.error('Google authentication error:', error);      } finally {        setPending(false);      }    };    // Load Google Identity Services    if (!window.google && GOOGLE_CLIENT_ID) {      const script = document.createElement('script');      script.src = 'https://accounts.google.com/gsi/client';      script.async = true;      script.onload = () => {        window.google.accounts.id.initialize({          client_id: GOOGLE_CLIENT_ID,          callback: window.handleCredentialResponse,        });      };      document.head.appendChild(script);    }    return () => {      delete window.handleCredentialResponse;    };  }, [router]);  const handleGoogleSignIn = () => {    if (!GOOGLE_CLIENT_ID) {      console.error('Google Client ID not configured');      return;    }    if (window.google) {      window.google.accounts.id.prompt();    } else {      console.error('Google SDK not loaded');    }  };  return (    <button      onClick={handleGoogleSignIn}      disabled={pending}      className="flex items-center justify-center w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"    >      {pending ? (        'Authenticating...'      ) : (        <>          <svg className="w-5 h-5 mr-2" viewBox="0 0 24 24">            <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>            <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>            <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>            <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/>          </svg>          Continue with Google        </>      )}    </button>  );}
```

### Creating the Authentication Function​


[​](#creating-the-authentication-function)Create a server action to handle the Google authentication:

```
'use server';import { gql } from 'graphql-request';const AUTHENTICATE_MUTATION = gql`  mutation AuthenticateWithGoogle($input: AuthenticationInput!) {    authenticate(input: $input) {      ... on CurrentUser {        id        identifier        channels {          code          token          permissions        }      }      ... on InvalidCredentialsError {        authenticationError        errorCode        message      }      ... on NotVerifiedError {        errorCode        message      }    }  }`;export async function authenticateWithGoogle(token: string) {  try {    const result = await vendureClient.request(AUTHENTICATE_MUTATION, {      input: {        google: {          token        }      }    });    if (result.authenticate.__typename === 'CurrentUser') {      // Authentication successful      return { success: true, user: result.authenticate };    } else {      // Handle authentication error      return {        success: false,        message: result.authenticate.message      };    }  } catch (error) {    console.error('Google authentication error:', error);    return {      success: false,      message: 'Authentication failed'    };  }}
```

Add your Google Client ID to the frontend environment:

```
NEXT_PUBLIC_GOOGLE_CLIENT_ID=your_google_client_id.apps.googleusercontent.comVENDURE_API_ENDPOINT=http://localhost:3000/shop-api
```

The Google Identity Services flow works as follows:

- User clicks "Continue with Google" → Google popup appears
- User signs in with Google → Google returns an ID token
- Frontend sends the token to Vendure → Vendure verifies token with Google
- If valid, Vendure creates/finds customer → User is logged in

## Using the GraphQL API​


[​](#using-the-graphql-api)Once your plugin is running, Google authentication will be available in your shop API:

- Mutation
- Response

```
mutation AuthenticateWithGoogle {  authenticate(input: {    google: {      token: "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9..."    }  }) {    ... on CurrentUser {      id      identifier      channels {        code        token        permissions      }    }    ... on InvalidCredentialsError {      authenticationError      errorCode      message    }    ... on NotVerifiedError {      errorCode      message    }  }}
```

```
{  "data": {    "authenticate": {      "id": "1",      "identifier": "user@gmail.com",      "channels": [        {          "code": "__default_channel__",          "token": "session_token_here",          "permissions": ["Authenticated"]        }      ]    }  }}
```

## Customer Data Management​


[​](#customer-data-management)Google-authenticated customers are managed like any other Vendure Customer:

[Customer](/reference/typescript-api/entities/customer/)- Email: Uses the user's actual Google email address
- Verification: Inherits Google's email verification status
- External ID: Google's unique user ID (sub claim) for future authentication
- Profile: First and last names from Google profile, with fallbacks
- Security: No password stored - authentication handled entirely by Google

This means Google users work seamlessly with Vendure's order management, promotions, and all customer workflows.

[order management](/guides/core-concepts/orders/)[promotions](/guides/core-concepts/promotions/)
## Testing the Integration​


[​](#testing-the-integration)To test your Google OAuth integration:

- Start your Vendure server with the plugin configured
- Navigate to your storefront and click "Continue with Google"
- Complete the Google OAuth flow when prompted
- Verify customer creation in the Vendure Dashboard
- Test repeat logins to ensure existing customers are found correctly


---

# Multi-vendor Marketplaces


Vendure v2.0 introduced a number of changes and new APIs to enable developers to build multi-vendor marketplace apps.

This is a type of application in which multiple sellers are able to list products, and then customers can create orders containing products from one or more of these sellers. Well-known examples include Amazon, Ebay, Etsy and Airbnb.

This guide introduces the major concepts & APIs you will need to understand in order to implement your own multi-vendor marketplace application.

## Multi-vendor plugin​


[​](#multi-vendor-plugin)All the concepts presented here have been implemented in our example multi-vendor plugin. The guides here will refer to specific parts of this plugin which you should consult to get a full understanding of how an implementation would look.

[example multi-vendor plugin](https://github.com/vendure-ecommerce/vendure/tree/master/packages/dev-server/example-plugins/multivendor-plugin)Note: the example multi-vendor plugin is for educational purposes only, and for the sake of clarity leaves out several parts that would be required in a production-ready solution, such as email verification and setup of a real payment solution.

[example multi-vendor plugin](https://github.com/vendure-ecommerce/vendure/tree/master/packages/dev-server/example-plugins/multivendor-plugin)
## Sellers, Channels & Roles​


[​](#sellers-channels--roles)The core of Vendure's multi-vendor support is Channels. Read the Channels guide to get a more detailed understanding of how they work.

[Channels guide](/guides/core-concepts/channels/)Each Channel is assigned to a Seller, which is another term for the vendor who is selling things in our marketplace.

[Seller](/reference/typescript-api/entities/seller/)So the first thing to do is to implement a way to create a new Channel and Seller.

In the multi-vendor plugin, we have defined a new mutation in the Shop API which allows a new seller to register on our marketplace:

```
mutation RegisterSeller {  registerNewSeller(input: {    shopName: "Bob's Parts",    seller: {      firstName: "Bob"      lastName: "Dobalina"      emailAddress: "bob@bobs-parts.com"      password: "test",    }  }) {    id    code    token  }}
```

Executing the registerNewSeller mutation does the following:

- Create a new Seller representing the shop "Bob's Parts"
- Create a new Channel and associate it with the new Seller
- Create a Role & Administrator for Bob to access his shop admin account
- Create a ShippingMethod for Bob's shop
- Create a StockLocation for Bob's shop

[Seller](/reference/typescript-api/entities/seller/)[Channel](/reference/typescript-api/entities/channel)[Role](/reference/typescript-api/entities/role)[Administrator](/reference/typescript-api/entities/administrator)[ShippingMethod](/reference/typescript-api/entities/shipping-method)[StockLocation](/reference/typescript-api/entities/stock-location)Bob can now log in to the Dashboard using the provided credentials and begin creating products to sell!

### Keeping prices synchronized​


[​](#keeping-prices-synchronized)In some marketplaces, the same product may be sold by multiple sellers. When this is the case, the product and its variants
will be assigned not only to the default channel, but to multiple other channels as well - see the
Channels, Currencies & Prices section for a visual explanation of how this works.

[Channels, Currencies & Prices section](/guides/core-concepts/channels/#channels-currencies--prices)This means that there will be multiple ProductVariantPrice entities per variant, one for each channel.

In order
to keep prices synchronized across all channels, the example multi-vendor plugin sets the syncPricesAcrossChannels property
of the DefaultProductVariantPriceUpdateStrategy
to true. Your own multi-vendor implementation may require more sophisticated price synchronization logic, in which case
you can implement your own custom ProductVariantPriceUpdateStrategy.

[DefaultProductVariantPriceUpdateStrategy](/reference/typescript-api/configuration/product-variant-price-update-strategy#defaultproductvariantpriceupdatestrategy)[ProductVariantPriceUpdateStrategy](/reference/typescript-api/configuration/product-variant-price-update-strategy)
## Assigning OrderLines to the correct Seller​


[​](#assigning-orderlines-to-the-correct-seller)In order to correctly split the Order later, we need to assign each added OrderLine to the correct Seller. This is done with the OrderSellerStrategy API, and specifically the setOrderLineSellerChannel() method.

[OrderSellerStrategy](/reference/typescript-api/orders/order-seller-strategy/)The following logic will run any time the addItemToOrder mutation is executed from our storefront:

```
export class MultivendorSellerStrategy implements OrderSellerStrategy {  // other properties omitted for brevity         async setOrderLineSellerChannel(ctx: RequestContext, orderLine: OrderLine) {    await this.entityHydrator.hydrate(ctx, orderLine.productVariant, { relations: ['channels'] });    const defaultChannel = await this.channelService.getDefaultChannel();      // If a ProductVariant is assigned to exactly 2 Channels, then one is the default Channel    // and the other is the seller's Channel.    if (orderLine.productVariant.channels.length === 2) {      const sellerChannel = orderLine.productVariant.channels.find(        c => !idsAreEqual(c.id, defaultChannel.id),      );      if (sellerChannel) {        return sellerChannel;      }    }  }}
```

The end result is that each OrderLine in the Order will have its sellerChannelId property set to the correct Channel for the Seller.

## Shipping​


[​](#shipping)When it comes time to choose a ShippingMethod for the Order, we need to ensure that the customer can only choose from the ShippingMethods which are supported by the Seller. To do this, we need to implement a ShippingEligibilityChecker which will filter the available ShippingMethods based on the sellerChannelId properties of the OrderLines.

[ShippingEligibilityChecker](/reference/typescript-api/shipping/shipping-eligibility-checker/)Here's how we do it in the example plugin:

```
export const multivendorShippingEligibilityChecker = new ShippingEligibilityChecker({  // other properties omitted for brevity         check: async (ctx, order, args, method) => {    await entityHydrator.hydrate(ctx, method, { relations: ['channels'] });    await entityHydrator.hydrate(ctx, order, { relations: ['lines.sellerChannel'] });    const sellerChannel = method.channels.find(c => c.code !== DEFAULT_CHANNEL_CODE);    if (!sellerChannel) {      return false;    }    for (const line of order.lines) {      if (idsAreEqual(line.sellerChannelId, sellerChannel.id)) {        return true;      }    }    return false;  },});
```

In the storefront, when it comes time to assign ShippingMethods to the Order, we need to ensure that
every OrderLine is covered by a valid ShippingMethod. We pass the ids of the eligible ShippingMethods to the setOrderShippingMethod mutation:

```
mutation SetShippingMethod($ids: [ID!]!) {  setOrderShippingMethod(shippingMethodId: $ids) {    ... on Order {      id      state      # ...etc    }    ... on ErrorResult {      errorCode      message    }  }}

```

Now we need a way to assign the correct method to each line in an Order. This is done with the ShippingLineAssignmentStrategy API.

[ShippingLineAssignmentStrategy](/reference/typescript-api/shipping/shipping-line-assignment-strategy/)We will again be relying on the sellerChannelId property of the OrderLines to determine which ShippingMethod to assign to each line. Here's how we do it in the example plugin:

```
export class MultivendorShippingLineAssignmentStrategy implements ShippingLineAssignmentStrategy {  // other properties omitted for brevity         async assignShippingLineToOrderLines(ctx: RequestContext, shippingLine: ShippingLine, order: Order) {    // First we need to ensure the required relations are available    // to work with.    const defaultChannel = await this.channelService.getDefaultChannel();    await this.entityHydrator.hydrate(ctx, shippingLine, { relations: ['shippingMethod.channels'] });    const { channels } = shippingLine.shippingMethod;      // We assume that, if a ShippingMethod is assigned to exactly 2 Channels,    // then one is the default Channel and the other is the seller's Channel.    if (channels.length === 2) {      const sellerChannel = channels.find(c => !idsAreEqual(c.id, defaultChannel.id));      if (sellerChannel) {        // Once we have established the seller's Channel, we can filter the OrderLines        // that belong to that Channel. The `sellerChannelId` was previously established        // in the `OrderSellerStrategy.setOrderLineSellerChannel()` method.        return order.lines.filter(line => idsAreEqual(line.sellerChannelId, sellerChannel.id));      }    }    return order.lines;  }}
```

## Splitting orders & payment​


[​](#splitting-orders--payment)When it comes to payments, there are many different ways that a multi-vendor marketplace might want to handle this. For example, the marketplace may collect all payments and then later disburse the funds to the Sellers. Or the marketplace may allow each Seller to connect their own payment gateway and collect payments directly.

In the example plugin, we have implemented a simplified version of a service like Stripe Connect, whereby each Seller has a connectedAccountId (we auto-generate a random string for the example when registering the Seller). When configuring the plugin we also specify a "platform fee" percentage, which is the percentage of the total Order value which the marketplace will collect as a fee. The remaining amount is then split between the Sellers.

[Stripe Connect](https://stripe.com/connect)The OrderSellerStrategy API contains two methods which are used to first split the Order from a single order into one Aggregate Order and multiple Seller Orders, and then to calculate the platform fee for each of the Seller Orders:

[OrderSellerStrategy](/reference/typescript-api/orders/order-seller-strategy/)- OrderSellerStrategy.splitOrder: Splits the OrderLines and ShippingLines of the Order into multiple groups, one for each Seller.
- OrderSellerStrategy.afterSellerOrdersCreated: This method is run on every Seller Order created after the split, and we can use this to assign the platform fees to the Seller Order.

## Custom OrderProcess​


[​](#custom-orderprocess)Finally, we need a custom OrderProcess which will help keep the state of the resulting Aggregate Order and its Seller Orders in sync. For example, we want to make sure that the Aggregate Order cannot be transitioned to the Shipped state unless all of its Seller Orders are also in the Shipped state.

[OrderProcess](/reference/typescript-api/orders/order-process/)Conversely, we can automatically set the state of the Aggregate Order to Shipped once all of its Seller Orders are in the Shipped state.


---

# Paginated lists


Vendure's list queries follow a set pattern which allows for pagination, filtering & sorting. This guide will demonstrate how
to implement your own paginated list queries.

## API definition​


[​](#api-definition)Let's start with defining the GraphQL schema for our query. In this example, we'll image that we have defined a custom entity to
represent a ProductReview. We want to be able to query a list of reviews in the Admin API. Here's how the schema definition
would look:

[custom entity](/guides/developer-guide/database-entity/)
```
import gql from 'graphql-tag';export const adminApiExtensions = gql`type ProductReview implements Node {  id: ID!  createdAt: DateTime!  updatedAt: DateTime!  product: Product!  productId: ID!  text: String!  rating: Float!}type ProductReviewList implements PaginatedList {  items: [ProductReview!]!  totalItems: Int!}# Generated at run-time by Vendureinput ProductReviewListOptionsextend type Query {   productReviews(options: ProductReviewListOptions): ProductReviewList!}`;

```

Note that we need to follow these conventions:

- The type must implement the Node interface, i.e. it must have an id: ID! field.
- The list type must be named <EntityName>List and must implement the PaginatedList interface.
- The list options input type must be named <EntityName>ListOptions.

Given this schema, at runtime Vendure will automatically generate the ProductReviewListOptions input type, including all the
filtering & sorting fields. This means that we don't need to define the input type ourselves.

## Resolver​


[​](#resolver)Next, we need to define the resolver for the query.

```
import { Args, Query, Resolver } from '@nestjs/graphql';import { Ctx, PaginatedList, RequestContext } from '@vendure/core';import { ProductReview } from '../entities/product-review.entity';import { ProductReviewService } from '../services/product-review.service';@Resolver()export class ProductReviewAdminResolver {    constructor(private productReviewService: ProductReviewService) {}    @Query()    async productReviews(        @Ctx() ctx: RequestContext,        @Args() args: any,    ): Promise<PaginatedList<ProductReview>> {        return this.productReviewService.findAll(ctx, args.options || undefined);    }}
```

## Service​


[​](#service)Finally, we need to implement the findAll() method on the ProductReviewService. Here we will use the
ListQueryBuilder to build the list query. The
ListQueryBuilder will take care of

[ListQueryBuilder](/reference/typescript-api/data-access/list-query-builder/)
```
import { Injectable } from '@nestjs/common';import { InjectConnection } from '@nestjs/typeorm';import { ListQueryBuilder, ListQueryOptions, PaginatedList, RequestContext } from '@vendure/core';import { ProductReview } from '../entities/product-review.entity';@Injectable()export class ProductReviewService {    constructor(        private listQueryBuilder: ListQueryBuilder,    ) {}    findAll(ctx: RequestContext, options?: ListQueryOptions<ProductReview>): Promise<PaginatedList<ProductReview>> {        return this.listQueryBuilder            .build(ProductReview, options, { relations: ['product'], ctx })            .getManyAndCount()            .then(([items, totalItems]) => ({ items, totalItems }));    }}
```

## Usage​


[​](#usage)Given the above parts of the plugin, we can now query the list of reviews in the Admin API:

- Query
- Response

```
query {  productReviews(    options: {      skip: 0      take: 10      sort: {        createdAt: DESC      }      filter: {        rating: {          between: { start: 3, end: 5 }        }      }    }) {    totalItems    items {      id      createdAt      product {        name      }      text      rating    }  }}
```

```
{  "data": {    "productReviews": {      "totalItems": 3,      "items": [        {          "id": "12",          "createdAt": "2023-08-23T12:00:00Z",          "product": {            "name": "Smartphone X"          },          "text": "The best phone I've ever had!",          "rating": 5        },        {          "id": "42",          "createdAt": "2023-08-22T15:30:00Z",          "product": {            "name": "Laptop Y"          },          "text": "Impressive performance and build quality.",          "rating": 4        },        {          "id": "33",          "createdAt": "2023-08-21T09:45:00Z",          "product": {            "name": "Headphones Z"          },          "text": "Decent sound quality but uncomfortable.",          "rating": 3        }      ]    }  }}
```

In the above example, we are querying the first 10 reviews, sorted by createdAt in descending order, and filtered to only
include reviews with a rating between 3 and 5.

## Advanced filtering​


[​](#advanced-filtering)Vendure v2.2.0 introduced the ability to construct complex nested filters on any PaginatedList query. For example, we could
filter the above query to only include reviews for products with a name starting with "Smartphone":

- Query
- Response

```
query {  productReviews(    options: {    skip: 0    take: 10    filter: {      _and: [        { text: { startsWith: "phone" } },        {          _or: [            { rating: { gte: 4 } },            { rating: { eq: 0 } }          ]        }      ]    }    }) {    totalItems    items {      id      createdAt      product {        name      }      text      rating    }  }}
```

```
{  "data": {    "productReviews": {      "totalItems": 3,      "items": [        {          "id": "12",          "createdAt": "2023-08-23T12:00:00Z",          "product": {            "name": "Smartphone X"          },          "text": "The best phone I've ever had!",          "rating": 5        },        {          "id": "42",          "createdAt": "2023-08-22T15:30:00Z",          "product": {            "name": "Smartphone Y"          },          "text": "Not a very good phone at all.",          "rating": 0        }      ]    }  }}
```

In the example above, we are filtering for reviews of products with the word "phone" and a rating of 4 or more,
or a rating of 0. The _and and _or operators can be nested to any depth, allowing for arbitrarily complex filters.

## Filtering by custom properties​


[​](#filtering-by-custom-properties)By default, the ListQueryBuilder will only allow filtering by properties which are defined on the entity itself.
So in the case of the ProductReview, we can filter by rating and text etc., but not by product.name.

However, it is possible to extend your GraphQL type to allow filtering by custom properties. Let's implement filtering
but the product.name property. First, we need to manually add the productName field to
the ProductReviewFilterParameter type:

```
import gql from 'graphql-tag';export const adminApiExtensions = gql`# ... existing definitions from earlier example omittedinput ProductReviewFilterParameter {  productName: StringOperators}`;

```

Next we need to update our ProductReviewService to be able to handle filtering on this new field using the
customPropertyMap option:

[customPropertyMap](/reference/typescript-api/data-access/list-query-builder/#custompropertymap)
```
import { Injectable } from '@nestjs/common';import { InjectConnection } from '@nestjs/typeorm';import { ListQueryBuilder, ListQueryOptions, PaginatedList, RequestContext } from '@vendure/core';import { ProductReview } from '../entities/product-review.entity';@Injectable()export class ProductReviewService {    constructor(        private listQueryBuilder: ListQueryBuilder,    ) {}    findAll(ctx: RequestContext, options?: ListQueryOptions<ProductReview>): Promise<PaginatedList<ProductReview>> {        return this.listQueryBuilder            .build(ProductReview, options, {                relations: ['product'],                ctx,                customPropertyMap: {                    productName: 'product.name',                }            })            .getManyAndCount()            .then(([items, totalItems]) => ({ items, totalItems }));    }}
```

Upon restarting your server, you should now be able to filter by productName:

```
query {  productReviews(    options: {      skip: 0      take: 10      filter: {        productName: {          contains: "phone"        }      }  }) {    totalItems    items {      id      createdAt      product {        name      }      text      rating    }  }}
```


---

# Publishing a Plugin


Vendure's plugin-based architecture means you'll be writing a lot of plugins.
Some of those plugins may be useful to others, and you may want to share them with the community.

[plugin-based architecture](/guides/developer-guide/plugins/)We have created Vendure Hub as a central listing for high-quality Vendure plugins.

[Vendure Hub](https://vendure.io/hub)This guide will walk you through the process of publishing a plugin to npm and submitting it to Vendure Hub.

## Project setup​


[​](#project-setup)There are a couple of ways you can structure your plugin project:

### Repo structure​


[​](#repo-structure)We recommend that you use a "monorepo" structure to develop your plugins. This means that you have a single repository
which contains all your plugins, each in its own subdirectory. This makes it easy to manage dependencies between plugins,
and to share common code such as utility functions & dev tooling.

Even if you only have a single plugin at the moment, it's a good idea to set up your project in this way from the start.

To that end, we provide a monorepo plugin starter template
which you can use as a starting point for your plugin development.

[monorepo plugin starter template](https://github.com/vendure-ecommerce/plugin-template)This starter template includes support for:

- Development & build scripts already set up
- Admin UI extensions already configured
- End-to-end testing infrastructure fully configured
- Code generation for your schema extensions

### Plugin naming​


[​](#plugin-naming)We recommend that you use scoped packages for your plugins, which means
they will be named like @<scope>/<plugin-name>. For example, if your company is called acme, and you are publishing a plugin that
implements a loyalty points system, you could name it @acme/vendure-plugin-loyalty-points.

[scoped packages](https://docs.npmjs.com/cli/v10/using-npm/scope#publishing-scoped-packages)
### Dependencies​


[​](#dependencies)Your plugin should not include Vendure packages as dependencies in the package.json file. You may declare them as a peer dependencies, but this is not
a must. The same goes for any of the transitive dependencies of Vendure core such as @nestjs/graphql, @nestjs/common, typeorm etc. You can assume
that these dependencies will be available in the Vendure project that uses your plugin.

As for version compatibility, you should use the
compatibility property in your plugin definition to ensure that the Vendure project
is using a compatible version of Vendure.

[compatibility property](/guides/developer-guide/plugins/#step-7-specify-compatibility)
### License​


[​](#license)You are free to license your plugin as you wish. Although Vendure itself is licensed under the GPLv3, there is
a special exception for plugins which allows you to distribute them under a different license. See the
plugin exception for more details.

[plugin exception](https://github.com/vendure-ecommerce/vendure/blob/master/license/plugin-exception.txt)
## Publishing to npm​


[​](#publishing-to-npm)Once your plugin is ready, you can publish it to npm. This is covered in the npm documentation on publishing packages.

[npm documentation on publishing packages](https://docs.npmjs.com/creating-and-publishing-scoped-public-packages)
## Requirements for Vendure Hub​


[​](#requirements-for-vendure-hub)Vendure Hub is a curated list of high-quality plugins. To be accepted into Vendure Hub, we require some additional
requirements be satisfied.

[Vendure Hub](https://vendure.io/hub)
### Changelog​


[​](#changelog)Your plugin package must include a CHANGELOG.md file which looks like this:

```
# Changelog## 1.6.1 (2024-06-07)- Fix a bug where the `foo` was not correctly bar (Fixes [#123](https://github.com/myorg/my-repo/issues/31))## 1.6.0 (2024-03-11)- Add a new feature to the `bar` service- Update the `baz` service to use the new `qux` method... etc

```

The exact format of the entries is up to you - you can e.g. use Keep a Changelog format, grouping by type of change, using tooling
to help generate the entries, etc. The important thing is that the CHANGELOG.md file is present and up-to-date, and published as part of your
package by specifying it in the files field of your package.json file.

[Keep a Changelog](https://keepachangelog.com/)
```
{ "files": [    "dist",    "README.md",    "CHANGELOG.md"  ]}
```

Vendure Hub will read the contents of your changelog to display the latest changes in your plugin listing.

### Documentation​


[​](#documentation)Good documentation is a key criteria for acceptance into Vendure Hub.

#### README.md​


[​](#readmemd)Your plugin package must include a README.md file which contains full instructions on how to install and use your plugin. Here's a template you can use:

```
# Acme Loyalty Points PluginThis plugin adds a loyalty points system to your Vendure store.## Installation```bashnpm install @acme/vendure-plugin-loyalty-points```Add the plugin to your Vendure config:```ts// vendure-config.tsimport { LoyaltyPointsPlugin } from '@acme/vendure-plugin-loyalty-points';export const config = {    //...    plugins: [        LoyaltyPointsPlugin.init({            enablePartialRedemption: true,        }),    ],};```[If your plugin includes UI extensions]If not already installed, install the `@vendure/ui-devkit` package:```bashnpm install @vendure/ui-devkit```Then set up the compilation of the UI extensions for the Admin UI:```ts// vendure-config.tsimport { compileUiExtensions } from '@vendure/ui-devkit/compiler';import { LoyaltyPointsPlugin } from '@acme/vendure-plugin-loyalty-points';// ...plugins: [  AdminUiPlugin.init({    route: 'admin',    port: 3002,    app: compileUiExtensions({      outputPath: path.join(__dirname, '../admin-ui'),      extensions: [LoyaltyPointsPlugin.uiExtensions],      devMode: false,    })  }),],```[/If your plugin includes UI extensions]## UsageDescribe how to use your plugin here. Make sure to cover the keyfunctionality and any configuration options. Include exampleswhere possible.Make sure to document any extensions made to the GraphQL APIs,as well as how to integrate the plugin with a storefront app.

```

#### JS Docs​


[​](#js-docs)All publicly-exposed services, entities, strategies, interfaces etc should be documented using JSDoc comments.
Not only does this improve the developer experience for your users, but it also allows Vendure Hub to auto-generate
documentation pages for your plugin.

Here are some examples of well-documented plugin code (implementation details omitted for brevity):

- Plugin
- Plugin options
- Services
- Entities
- Events

- Tag the plugin with @category Plugin. This will be used when generating the docs pages to group plugins together.
- Usually the .init() method is the thing that users will call to configure the plugin. Document this method with an example of how to use it.
- The constructor and any lifecycle methods should be tagged with @internal.

```
/** * Advanced search and search analytics for Vendure. * * @category Plugin */@VendurePlugin({    imports: [PluginCommonModule],    // ...})export class LoyaltyPointsPlugin implements OnApplicationBootstrap {    /** @internal */    static options: LoyaltyPointsPluginInitOptions;    /**     * The static `init()` method is called with the options to     * configure the plugin.     *     * @example     * ```ts     * LoyaltyPointsPlugin.init({     *     enablePartialRedemption: true     * }),     * ```     */    static init(options: LoyaltyPointsPluginInitOptions) {        this.options = options;        return AdvancedSearchPlugin;    }    /**     * The static `uiExtensions` property is used to provide the     * necessary UI extensions to the Admin UI     * in order to display the loyalty points admin features.     * This property is used in the `AdminUiPlugin` initialization.     *     * @example     * ```ts     * import { compileUiExtensions } from '@vendure/ui-devkit/compiler';     * import { AdvancedSearchPlugin } from '@acme/vendure-plugin-loyalty-points';     *     * // ...     * plugins: [     *   AdminUiPlugin.init({     *     route: 'admin',     *     port: 3002,     *     app: compileUiExtensions({     *       outputPath: path.join(__dirname, '../admin-ui'),     *       extensions: [LoyaltyPointsPlugin.uiExtensions],     *       devMode: false,     *     })     *   }),     * ],     * ```     */    static uiExtensions = advancedSearchPluginUi;    /** @internal */    constructor(/* ... */) {}    /** @internal */    async onApplicationBootstrap() {        // Logic to set up event subscribers etc.    }}
```

- Tag the options interface with @category Plugin.
- Document any default values for optional properties.

```
/** * Configuration options for the LoyaltyPointsPlugin. * * @category Plugin */export interface LoyaltyPointsPluginInitOptions {    /**     * Whether to allow partial redemption of points.     *     * @default true     */    enablePartialRedemption?: boolean;}
```

- Only services that are exported in the plugin's exports array need to be documented. Internal services can be left undocumented.
- Tag services with @category Services. This will be used when generating the docs pages to group services together.
- By default all non-private methods are included in the docs. If you want to exclude a method, tag it with @internal.

```
/** * The LoyaltyPointsService provides methods for managing a * customer's loyalty points balance. * * @category Services */@Injectable()export class LoyaltyPointsService {    /** @internal */    constructor(private connection: TransactionalConnection) {}    /**     * Adds the given number of points to the customer's balance.     */    addPoints(ctx: RequestContext, customerId: ID, points: number): Promise<LoyaltyPointsTransaction> {        // implementation...    }    /**     * Deducts the given number of points from the customer's balance.     */    deductPoints(customerId: ID, points: number): Promise<LoyaltyPointsTransaction> {        // implementation...    }}
```

- Tag entities with @category Entities. This will be used when generating the docs pages to group entities together.

```
/** * Represents a transaction of loyalty points, * when points are added or deducted. * * @category Entities */@Entity()export class LoyaltyPointsTransaction extends VendureEntity {    /**     * The number of points added or deducted.     * A negative value indicates points deducted.     */    @Column()    points: number;    /**     * The Customer to whom the points were added or deducted.     */    @ManyToOne(type => Customer)    customer: Customer;    /**     * The reason for the points transaction.     */    @Column()    reason: string;}
```

- Tag events with @category Events. This will be used when generating the docs pages to group events together.

```
/** * This event is fired whenever a LoyaltyPointsTransaction is created. * * @category Events */export class LoyaltyPointsTransactionEvent extends VendureEvent {    constructor(public ctx: RequestContext, public transaction: LoyaltyPointsTransaction) {        super();    }}
```

### Tests​


[​](#tests)Testing is an important part of ensuring the quality of your plugin, as well as preventing regressions when you make
changes.

For plugins of any complexity, you should aim to have a suite of end-to-end tests as covered in the testing docs.

[testing docs](/guides/developer-guide/testing/)In future we may use the test results to help determine the quality of a plugin.

## Submitting to Vendure Hub​


[​](#submitting-to-vendure-hub)Once your plugin is published to npm and satisfies the requirements above, you can submit it to Vendure Hub
via our contact form, making sure to include
a link to the npm package and the GitHub repository.

[contact form](https://vendure.io/contact?interested_in=publish_paid_plugins)
## Publishing a paid plugin​


[​](#publishing-a-paid-plugin)Vendure Hub supports the listing of paid plugins. If you would like to sell plugins through Vendure Hub,
please contact us and provide
details about the plugins you would like to sell.

[contact us](https://vendure.io/contact?interested_in=publish_paid_plugins)


---

# Integrating S3-Compatible Asset Storage


This guide demonstrates how to integrate S3-compatible asset storage into your Vendure application using multiple cloud storage platforms. You'll learn to configure a single, platform-agnostic storage solution that works seamlessly with AWS S3, DigitalOcean Spaces, MinIO, CloudFlare R2, and Supabase Storage.

## Working Example Repository​


[​](#working-example-repository)This guide is based on the s3-file-storage example.
Refer to the complete working code for full implementation details.

[s3-file-storage](https://github.com/vendure-ecommerce/examples/tree/publish/examples/s3-file-storage)
## Prerequisites​


[​](#prerequisites)- Node.js 20+ with npm package manager
- An existing Vendure project created with the Vendure create command
- An account with one of the supported S3-compatible storage providers

[Vendure create command](/guides/getting-started/installation/)
## S3-Compatible Storage Provider Setup​


[​](#s3-compatible-storage-provider-setup)Configure your chosen storage provider by following the setup instructions for your preferred platform:

- AWS S3
- Supabase Storage
- DigitalOcean Spaces
- CloudFlare R2
- Hetzner Object Storage
- MinIO

### Setting up AWS S3​


[​](#setting-up-aws-s3)- Create an S3 Bucket

Navigate to AWS S3 Console
Click "Create bucket"
Enter a unique bucket name (e.g., my-vendure-assets)
Choose your preferred AWS region
Configure permissions as needed for public asset access
- Navigate to AWS S3 Console
- Click "Create bucket"
- Enter a unique bucket name (e.g., my-vendure-assets)
- Choose your preferred AWS region
- Configure permissions as needed for public asset access
- Create IAM User with S3 Permissions

Go to AWS IAM Console
Navigate to "Users" and click "Create user"
Enter username and proceeed to Set Permissions
Select the Attach existing policies directly option
Attach the AmazonS3FullAccess policy (or create a custom policy with minimal permissions)
- Go to AWS IAM Console
- Navigate to "Users" and click "Create user"
- Enter username and proceeed to Set Permissions
- Select the Attach existing policies directly option
- Attach the AmazonS3FullAccess policy (or create a custom policy with minimal permissions)
- Generate Access Keys

After creating the user, click on the user name
Go to "Security credentials" tab
Click "Create access key" and select "Application running on AWS service"
Copy the Access Key ID and Secret Access Key (Download the CSV file if needed)
- After creating the user, click on the user name
- Go to "Security credentials" tab
- Click "Create access key" and select "Application running on AWS service"
- Copy the Access Key ID and Secret Access Key (Download the CSV file if needed)
- Environment Variables
# AWS S3 ConfigurationS3_BUCKET=my-vendure-assetsS3_ACCESS_KEY_ID=AKIA...S3_SECRET_ACCESS_KEY=wJalrXUtn...S3_REGION=us-east-1# Leave S3_ENDPOINT empty for AWS S3# Leave S3_FORCE_PATH_STYLE empty for AWS S3


Create an S3 Bucket

- Navigate to AWS S3 Console
- Click "Create bucket"
- Enter a unique bucket name (e.g., my-vendure-assets)
- Choose your preferred AWS region
- Configure permissions as needed for public asset access

[AWS S3 Console](https://console.aws.amazon.com/s3/)Create IAM User with S3 Permissions

- Go to AWS IAM Console
- Navigate to "Users" and click "Create user"
- Enter username and proceeed to Set Permissions
- Select the Attach existing policies directly option
- Attach the AmazonS3FullAccess policy (or create a custom policy with minimal permissions)

[AWS IAM Console](https://console.aws.amazon.com/iam/)Generate Access Keys

- After creating the user, click on the user name
- Go to "Security credentials" tab
- Click "Create access key" and select "Application running on AWS service"
- Copy the Access Key ID and Secret Access Key (Download the CSV file if needed)

Environment Variables

```
# AWS S3 ConfigurationS3_BUCKET=my-vendure-assetsS3_ACCESS_KEY_ID=AKIA...S3_SECRET_ACCESS_KEY=wJalrXUtn...S3_REGION=us-east-1# Leave S3_ENDPOINT empty for AWS S3# Leave S3_FORCE_PATH_STYLE empty for AWS S3

```

### Setting up Supabase S3 Storage​


[​](#setting-up-supabase-s3-storage)- Create Supabase Project

Sign up at Supabase
Click "New project" and fill in project details
Wait for project initialization to complete
- Sign up at Supabase
- Click "New project" and fill in project details
- Wait for project initialization to complete
- Navigate to Storage

Go to "Storage" section in your project dashboard
Click "Create a new bucket"
Enter bucket name: assets (or your preferred name)
Configure bucket to be public if you need direct asset access
Click "Create bucket"
- Go to "Storage" section in your project dashboard
- Click "Create a new bucket"
- Enter bucket name: assets (or your preferred name)
- Configure bucket to be public if you need direct asset access
- Click "Create bucket"
- Generate Service Role Key

Navigate to "Settings" → "API"
Copy your Project URL and Project Reference ID
Copy the service_role key (keep this secure)
The service_role key provides full access to your project
- Navigate to "Settings" → "API"
- Copy your Project URL and Project Reference ID
- Copy the service_role key (keep this secure)
- The service_role key provides full access to your project
- Environment Variables
# Supabase Storage ConfigurationS3_BUCKET=assetsS3_ACCESS_KEY_ID=your-supabase-access-key-idS3_SECRET_ACCESS_KEY=your-service-role-keyS3_REGION=us-east-1S3_ENDPOINT=https://your-project-ref.supabase.co/storage/v1/s3S3_FORCE_PATH_STYLE=true

infoReplace your-project-ref with your actual Supabase project reference ID found in your project settings.

Create Supabase Project

- Sign up at Supabase
- Click "New project" and fill in project details
- Wait for project initialization to complete

[Supabase](https://supabase.com/)Navigate to Storage

- Go to "Storage" section in your project dashboard
- Click "Create a new bucket"
- Enter bucket name: assets (or your preferred name)
- Configure bucket to be public if you need direct asset access
- Click "Create bucket"

Generate Service Role Key

- Navigate to "Settings" → "API"
- Copy your Project URL and Project Reference ID
- Copy the service_role key (keep this secure)
- The service_role key provides full access to your project

Environment Variables

```
# Supabase Storage ConfigurationS3_BUCKET=assetsS3_ACCESS_KEY_ID=your-supabase-access-key-idS3_SECRET_ACCESS_KEY=your-service-role-keyS3_REGION=us-east-1S3_ENDPOINT=https://your-project-ref.supabase.co/storage/v1/s3S3_FORCE_PATH_STYLE=true

```

Replace your-project-ref with your actual Supabase project reference ID found in your project settings.

### Setting up DigitalOcean Spaces​


[​](#setting-up-digitalocean-spaces)- Create a DigitalOcean Account

Sign up at DigitalOcean
Navigate to the Spaces section in your dashboard
- Sign up at DigitalOcean
- Navigate to the Spaces section in your dashboard
- Create a Space

Click "Create a Space"
Choose your datacenter region (e.g., fra1 for Frankfurt)
Enter a unique Space name (e.g., my-vendure-assets)
Choose File Listing permissions based on your needs
Optionally enable CDN to improve global asset delivery
- Click "Create a Space"
- Choose your datacenter region (e.g., fra1 for Frankfurt)
- Enter a unique Space name (e.g., my-vendure-assets)
- Choose File Listing permissions based on your needs
- Optionally enable CDN to improve global asset delivery
- Generate Spaces Access Keys

Go to API Tokens page
Click "Generate New Key" in the Spaces Keys section
Enter a name for your key
Copy the generated Key and Secret
- Go to API Tokens page
- Click "Generate New Key" in the Spaces Keys section
- Enter a name for your key
- Copy the generated Key and Secret
- Configure CORS Policy (Optional)
For browser-based uploads, configure CORS in your Space settings:
[  {    "allowed_origins": ["https://yourdomain.com"],    "allowed_methods": ["GET", "POST", "PUT"],    "allowed_headers": ["*"],    "max_age": 3000  }]
- Environment Variables
# DigitalOcean Spaces ConfigurationS3_BUCKET=my-vendure-assetsS3_ACCESS_KEY_ID=DO00...S3_SECRET_ACCESS_KEY=wJalrXUtn...S3_REGION=fra1S3_ENDPOINT=https://fra1.digitaloceanspaces.comS3_FORCE_PATH_STYLE=false

tipUse the regional endpoint (e.g., https://fra1.digitaloceanspaces.com) not the CDN endpoint. The AWS SDK constructs URLs automatically.

Create a DigitalOcean Account

- Sign up at DigitalOcean
- Navigate to the Spaces section in your dashboard

[DigitalOcean](https://www.digitalocean.com/)Create a Space

- Click "Create a Space"
- Choose your datacenter region (e.g., fra1 for Frankfurt)
- Enter a unique Space name (e.g., my-vendure-assets)
- Choose File Listing permissions based on your needs
- Optionally enable CDN to improve global asset delivery

Generate Spaces Access Keys

- Go to API Tokens page
- Click "Generate New Key" in the Spaces Keys section
- Enter a name for your key
- Copy the generated Key and Secret

[API Tokens page](https://cloud.digitalocean.com/account/api/tokens)Configure CORS Policy (Optional)
For browser-based uploads, configure CORS in your Space settings:

```
[  {    "allowed_origins": ["https://yourdomain.com"],    "allowed_methods": ["GET", "POST", "PUT"],    "allowed_headers": ["*"],    "max_age": 3000  }]
```

Environment Variables

```
# DigitalOcean Spaces ConfigurationS3_BUCKET=my-vendure-assetsS3_ACCESS_KEY_ID=DO00...S3_SECRET_ACCESS_KEY=wJalrXUtn...S3_REGION=fra1S3_ENDPOINT=https://fra1.digitaloceanspaces.comS3_FORCE_PATH_STYLE=false

```

Use the regional endpoint (e.g., https://fra1.digitaloceanspaces.com) not the CDN endpoint. The AWS SDK constructs URLs automatically.

### Setting up CloudFlare R2​


[​](#setting-up-cloudflare-r2)- Create CloudFlare Account

Sign up at CloudFlare
Complete account verification process
- Sign up at CloudFlare
- Complete account verification process
- Enable R2 Object Storage

Navigate to R2 Object Storage in your dashboard
You may need to provide payment information (R2 has generous free tier)
Accept the R2 terms of service
- Navigate to R2 Object Storage in your dashboard
- You may need to provide payment information (R2 has generous free tier)
- Accept the R2 terms of service
- Create R2 Bucket

Click "Create bucket"
Enter a globally unique bucket name: vendure-assets
Select "Automatic" for location optimization
Choose "Standard" storage class for most use cases
Click "Create bucket" to finalize
- Click "Create bucket"
- Enter a globally unique bucket name: vendure-assets
- Select "Automatic" for location optimization
- Choose "Standard" storage class for most use cases
- Click "Create bucket" to finalize
- Generate API Tokens

Go to "Manage R2 API tokens" section
Click "Create API token"
Configure token name: "Vendure R2 Token"
Under Permissions, select "Object Read & Write"
Optionally restrict to specific buckets under "Account resources"
Click "Create API token"
- Go to "Manage R2 API tokens" section
- Click "Create API token"
- Configure token name: "Vendure R2 Token"
- Under Permissions, select "Object Read & Write"
- Optionally restrict to specific buckets under "Account resources"
- Click "Create API token"
- Retrieve Credentials

Copy the Access Key ID and Secret Access Key
Copy the jurisdiction-specific endpoint for S3 clients
Note your account ID from the URL or dashboard
- Copy the Access Key ID and Secret Access Key
- Copy the jurisdiction-specific endpoint for S3 clients
- Note your account ID from the URL or dashboard
- Environment Variables
# CloudFlare R2 ConfigurationS3_BUCKET=vendure-assetsS3_ACCESS_KEY_ID=your-r2-access-keyS3_SECRET_ACCESS_KEY=your-r2-secret-keyS3_REGION=autoS3_ENDPOINT=https://your-account-id.r2.cloudflarestorage.comS3_FORCE_PATH_STYLE=true

warningReplace your-account-id with your actual CloudFlare account ID. If using a custom domain, update S3_FILE_URL to point to your custom domain with https://.

Create CloudFlare Account

- Sign up at CloudFlare
- Complete account verification process

[CloudFlare](https://www.cloudflare.com/)Enable R2 Object Storage

- Navigate to R2 Object Storage in your dashboard
- You may need to provide payment information (R2 has generous free tier)
- Accept the R2 terms of service

Create R2 Bucket

- Click "Create bucket"
- Enter a globally unique bucket name: vendure-assets
- Select "Automatic" for location optimization
- Choose "Standard" storage class for most use cases
- Click "Create bucket" to finalize

Generate API Tokens

- Go to "Manage R2 API tokens" section
- Click "Create API token"
- Configure token name: "Vendure R2 Token"
- Under Permissions, select "Object Read & Write"
- Optionally restrict to specific buckets under "Account resources"
- Click "Create API token"

Retrieve Credentials

- Copy the Access Key ID and Secret Access Key
- Copy the jurisdiction-specific endpoint for S3 clients
- Note your account ID from the URL or dashboard

Environment Variables

```
# CloudFlare R2 ConfigurationS3_BUCKET=vendure-assetsS3_ACCESS_KEY_ID=your-r2-access-keyS3_SECRET_ACCESS_KEY=your-r2-secret-keyS3_REGION=autoS3_ENDPOINT=https://your-account-id.r2.cloudflarestorage.comS3_FORCE_PATH_STYLE=true

```

Replace your-account-id with your actual CloudFlare account ID. If using a custom domain, update S3_FILE_URL to point to your custom domain with https://.

### Setting up Hetzner Object Storage​


[​](#setting-up-hetzner-object-storage)- Create Hetzner Cloud Account

Sign up at Hetzner Cloud
Complete account verification and billing setup
Navigate to the Hetzner Cloud Console
- Sign up at Hetzner Cloud
- Complete account verification and billing setup
- Navigate to the Hetzner Cloud Console
- Access Object Storage Service

In the Hetzner Cloud Console, navigate to "Object Storage" in the left sidebar
If Object Storage is not visible, you may need to request access (service availability varies by region)
Accept the Object Storage terms of service when prompted
- In the Hetzner Cloud Console, navigate to "Object Storage" in the left sidebar
- If Object Storage is not visible, you may need to request access (service availability varies by region)
- Accept the Object Storage terms of service when prompted
- Create Storage Bucket

Click "Create Bucket" in the Object Storage section
Enter a globally unique bucket name (e.g., vendure-assets-yourname)
Select your preferred location (e.g., fsn1 for Falkenstein, Germany)
Choose bucket visibility:

Private: Requires authentication for all access
Public: Allows public read access for assets

Click "Create" to create the bucket
- Click "Create Bucket" in the Object Storage section
- Enter a globally unique bucket name (e.g., vendure-assets-yourname)
- Select your preferred location (e.g., fsn1 for Falkenstein, Germany)
- Choose bucket visibility:

Private: Requires authentication for all access
Public: Allows public read access for assets
- Private: Requires authentication for all access
- Public: Allows public read access for assets
- Click "Create" to create the bucket
- Generate S3 API Credentials

In the Object Storage section, navigate to "API Credentials" or "Access Keys"
Click "Generate new credentials" or "Create access key"
Provide a name for the credentials (e.g., "Vendure API Key")
Copy the generated Access Key and Secret Key
⚠️ Important: Save the Secret Key immediately as it cannot be viewed again
- In the Object Storage section, navigate to "API Credentials" or "Access Keys"
- Click "Generate new credentials" or "Create access key"
- Provide a name for the credentials (e.g., "Vendure API Key")
- Copy the generated Access Key and Secret Key
- ⚠️ Important: Save the Secret Key immediately as it cannot be viewed again
- Environment Variables
# Hetzner Object Storage ConfigurationS3_BUCKET=vendure-assets-yournameS3_ACCESS_KEY_ID=your-hetzner-access-keyS3_SECRET_ACCESS_KEY=your-hetzner-secret-keyS3_REGION=fsn1S3_ENDPOINT=https://fsn1.your-objectstorage.comS3_FORCE_PATH_STYLE=true

noteReplace fsn1 with your chosen location (e.g., nbg1 for Nuremberg). The endpoint URL will match your bucket's location. Ensure the region and endpoint location match.

Create Hetzner Cloud Account

- Sign up at Hetzner Cloud
- Complete account verification and billing setup
- Navigate to the Hetzner Cloud Console

[Hetzner Cloud](https://www.hetzner.com/cloud)Access Object Storage Service

- In the Hetzner Cloud Console, navigate to "Object Storage" in the left sidebar
- If Object Storage is not visible, you may need to request access (service availability varies by region)
- Accept the Object Storage terms of service when prompted

Create Storage Bucket

- Click "Create Bucket" in the Object Storage section
- Enter a globally unique bucket name (e.g., vendure-assets-yourname)
- Select your preferred location (e.g., fsn1 for Falkenstein, Germany)
- Choose bucket visibility:

Private: Requires authentication for all access
Public: Allows public read access for assets
- Private: Requires authentication for all access
- Public: Allows public read access for assets
- Click "Create" to create the bucket

- Private: Requires authentication for all access
- Public: Allows public read access for assets

Generate S3 API Credentials

- In the Object Storage section, navigate to "API Credentials" or "Access Keys"
- Click "Generate new credentials" or "Create access key"
- Provide a name for the credentials (e.g., "Vendure API Key")
- Copy the generated Access Key and Secret Key
- ⚠️ Important: Save the Secret Key immediately as it cannot be viewed again

Environment Variables

```
# Hetzner Object Storage ConfigurationS3_BUCKET=vendure-assets-yournameS3_ACCESS_KEY_ID=your-hetzner-access-keyS3_SECRET_ACCESS_KEY=your-hetzner-secret-keyS3_REGION=fsn1S3_ENDPOINT=https://fsn1.your-objectstorage.comS3_FORCE_PATH_STYLE=true

```

Replace fsn1 with your chosen location (e.g., nbg1 for Nuremberg). The endpoint URL will match your bucket's location. Ensure the region and endpoint location match.

### Setting up MinIO (Self-Hosted)​


[​](#setting-up-minio-self-hosted)- Install MinIO Server
Option A: Using Docker (Recommended)
# Create a docker-compose.yml filedocker compose up -d minio

Option B: Direct Installation

Download MinIO from MinIO Downloads
Follow installation instructions for your operating system
Start MinIO server with: minio server /data --console-address ":9001"
- Download MinIO from MinIO Downloads
- Follow installation instructions for your operating system
- Start MinIO server with: minio server /data --console-address ":9001"
- Access MinIO Console

Open http://localhost:9001 in your browser
Default credentials: minioadmin / minioadmin
Change these credentials in production environments
- Open http://localhost:9001 in your browser
- Default credentials: minioadmin / minioadmin
- Change these credentials in production environments
- Create Access Keys
The MinIO web console in development setups typically only shows bucket management. For access key creation, use the MinIO CLI:
Install MinIO Client (if not already installed):
# macOSbrew install minio/stable/mc# Linuxcurl https://dl.min.io/client/mc/release/linux-amd64/mc \  --create-dirs -o $HOME/minio-binaries/mcchmod +x $HOME/minio-binaries/mcexport PATH=$PATH:$HOME/minio-binaries/# Windows# Download mc.exe from https://dl.min.io/client/mc/release/windows-amd64/mc.exe

Configure and create access keys:
# Set up MinIO client alias (replace with your MinIO server details)mc alias set local http://localhost:9000 minioadmin minioadmin# Create a service account (access key pair)mc admin user svcacct add local minioadmin# This will output something like:# Access Key: AKIAIOSFODNN7EXAMPLE# Secret Key: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

⚠️ Important: Save both keys immediately as the Secret Key won't be shown again
- Create Storage Bucket

In the MinIO console, you should see a "Buckets" section showing available buckets
Click "Create Bucket" (usually a + icon or button)
Enter bucket name: vendure-assets
Click "Create" to create the bucket

Alternative using CLI:
# Create bucket using MinIO clientmc mb local/vendure-assets

- In the MinIO console, you should see a "Buckets" section showing available buckets
- Click "Create Bucket" (usually a + icon or button)
- Enter bucket name: vendure-assets
- Click "Create" to create the bucket
- Configure Public Access Policy
For public asset access, set the bucket policy using the MinIO CLI (console UI may not have policy editor):
# Create a policy file for public read accesscat > public-read-policy.json << EOF{  "Version": "2012-10-17",  "Statement": [    {      "Effect": "Allow",      "Principal": "*",      "Action": "s3:GetObject",      "Resource": "arn:aws:s3:::vendure-assets/*"    }  ]}EOF# Apply the policy to the bucketmc anonymous set download local/vendure-assets# Or apply the JSON policy directlymc admin policy create local public-read public-read-policy.json

Alternative simple approach:
# Make bucket publicly readable (simpler method)mc anonymous set download local/vendure-assets

- Environment Variables
# MinIO ConfigurationS3_BUCKET=vendure-assetsS3_ACCESS_KEY_ID=minio-access-keyS3_SECRET_ACCESS_KEY=minio-secret-keyS3_REGION=us-east-1S3_ENDPOINT=http://localhost:9000S3_FORCE_PATH_STYLE=true


Install MinIO Server

Option A: Using Docker (Recommended)

```
# Create a docker-compose.yml filedocker compose up -d minio

```

Option B: Direct Installation

- Download MinIO from MinIO Downloads
- Follow installation instructions for your operating system
- Start MinIO server with: minio server /data --console-address ":9001"

[MinIO Downloads](https://min.io/download)Access MinIO Console

- Open http://localhost:9001 in your browser
- Default credentials: minioadmin / minioadmin
- Change these credentials in production environments

[http://localhost:9001](http://localhost:9001)Create Access Keys

The MinIO web console in development setups typically only shows bucket management. For access key creation, use the MinIO CLI:

Install MinIO Client (if not already installed):

```
# macOSbrew install minio/stable/mc# Linuxcurl https://dl.min.io/client/mc/release/linux-amd64/mc \  --create-dirs -o $HOME/minio-binaries/mcchmod +x $HOME/minio-binaries/mcexport PATH=$PATH:$HOME/minio-binaries/# Windows# Download mc.exe from https://dl.min.io/client/mc/release/windows-amd64/mc.exe

```

Configure and create access keys:

```
# Set up MinIO client alias (replace with your MinIO server details)mc alias set local http://localhost:9000 minioadmin minioadmin# Create a service account (access key pair)mc admin user svcacct add local minioadmin# This will output something like:# Access Key: AKIAIOSFODNN7EXAMPLE# Secret Key: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

```

⚠️ Important: Save both keys immediately as the Secret Key won't be shown again

Create Storage Bucket

- In the MinIO console, you should see a "Buckets" section showing available buckets
- Click "Create Bucket" (usually a + icon or button)
- Enter bucket name: vendure-assets
- Click "Create" to create the bucket

Alternative using CLI:

```
# Create bucket using MinIO clientmc mb local/vendure-assets

```

Configure Public Access Policy

For public asset access, set the bucket policy using the MinIO CLI (console UI may not have policy editor):

```
# Create a policy file for public read accesscat > public-read-policy.json << EOF{  "Version": "2012-10-17",  "Statement": [    {      "Effect": "Allow",      "Principal": "*",      "Action": "s3:GetObject",      "Resource": "arn:aws:s3:::vendure-assets/*"    }  ]}EOF# Apply the policy to the bucketmc anonymous set download local/vendure-assets# Or apply the JSON policy directlymc admin policy create local public-read public-read-policy.json

```

Alternative simple approach:

```
# Make bucket publicly readable (simpler method)mc anonymous set download local/vendure-assets

```

Environment Variables

```
# MinIO ConfigurationS3_BUCKET=vendure-assetsS3_ACCESS_KEY_ID=minio-access-keyS3_SECRET_ACCESS_KEY=minio-secret-keyS3_REGION=us-east-1S3_ENDPOINT=http://localhost:9000S3_FORCE_PATH_STYLE=true

```

## Vendure Configuration​


[​](#vendure-configuration)Configure your Vendure application to use S3-compatible asset storage by modifying your vendure-config.ts:

```
import { VendureConfig } from '@vendure/core';import {  AssetServerPlugin,  configureS3AssetStorage} from '@vendure/asset-server-plugin';import 'dotenv/config';import path from 'path';const IS_DEV = process.env.APP_ENV === 'dev';export const config: VendureConfig = {  // ... other configuration options  plugins: [    AssetServerPlugin.init({      route: 'assets',      assetUploadDir: path.join(__dirname, '../static/assets'),      assetUrlPrefix: IS_DEV ? undefined : 'https://www.my-shop.com/assets/',      // S3-Compatible Storage Configuration      // Dynamically switches between local storage and S3 based on environment      storageStrategyFactory: process.env.S3_BUCKET        ? configureS3AssetStorage({            bucket: process.env.S3_BUCKET,            credentials: {              accessKeyId: process.env.S3_ACCESS_KEY_ID!,              secretAccessKey: process.env.S3_SECRET_ACCESS_KEY!,            },            nativeS3Configuration: {              // Platform-specific endpoint configuration              endpoint: process.env.S3_ENDPOINT,              region: process.env.S3_REGION,              forcePathStyle: process.env.S3_FORCE_PATH_STYLE === 'true',              signatureVersion: 'v4',            },          })        : undefined, // Fallback to local storage when S3 not configured    }),    // ... other plugins  ],};
```

IMPORTANT: The configuration uses a conditional approach - when S3_BUCKET is set, it activates S3 storage; otherwise, it falls back to local file storage. This enables seamless development-to-production transitions.

## Environment Configuration​


[​](#environment-configuration)Create a .env file in your project root with your chosen storage provider configuration:

```
# Basic Vendure ConfigurationAPP_ENV=devSUPERADMIN_USERNAME=superadminSUPERADMIN_PASSWORD=superadminCOOKIE_SECRET=your-cookie-secret-32-characters-min# S3-Compatible Storage ConfigurationS3_BUCKET=your-bucket-nameS3_ACCESS_KEY_ID=your-access-key-idS3_SECRET_ACCESS_KEY=your-secret-access-keyS3_REGION=your-regionS3_ENDPOINT=your-endpoint-urlS3_FORCE_PATH_STYLE=true-or-false

```

Preconfigured environment examples for each storage provider are available in the s3-file-storage example repository.

[s3-file-storage example repository](https://github.com/vendure-ecommerce/examples/tree/publish/examples/s3-file-storage)[Vendure CLI](/guides/developer-guide/cli/)
## Testing Your Configuration​


[​](#testing-your-configuration)Verify your S3 storage configuration works correctly:

- Start your Vendure server:
npm run dev:server
- Access the Dashboard:

Open http://localhost:3000/dashboard
Log in with your superadmin credentials
- Open http://localhost:3000/dashboard
- Log in with your superadmin credentials
- Test asset upload:

Navigate to "Catalog" → "Assets"
Click "Upload assets"
Select a test image and upload
Verify the image appears in the asset gallery
- Navigate to "Catalog" → "Assets"
- Click "Upload assets"
- Select a test image and upload
- Verify the image appears in the asset gallery
- Verify storage backend:

Check your S3 bucket/storage service for the uploaded file
Confirm the asset URL is accessible
- Check your S3 bucket/storage service for the uploaded file
- Confirm the asset URL is accessible

Start your Vendure server:

```
npm run dev:server
```

Access the Dashboard:

- Open http://localhost:3000/dashboard
- Log in with your superadmin credentials

[http://localhost:3000/dashboard](http://localhost:3000/dashboard)Test asset upload:

- Navigate to "Catalog" → "Assets"
- Click "Upload assets"
- Select a test image and upload
- Verify the image appears in the asset gallery

Verify storage backend:

- Check your S3 bucket/storage service for the uploaded file
- Confirm the asset URL is accessible

## Advanced Configuration​


[​](#advanced-configuration)
### Custom Asset URL Prefix​


[​](#custom-asset-url-prefix)For production deployments with CDN or custom domains:

```
AssetServerPlugin.init({  route: 'assets',  assetUrlPrefix: 'https://cdn.yourdomain.com/assets/',  storageStrategyFactory: process.env.S3_BUCKET    ? configureS3AssetStorage({        // ... S3 configuration      })    : undefined,});
```

### Environment-Specific Configuration​


[​](#environment-specific-configuration)Use different buckets for different environments:

```
# DevelopmentS3_BUCKET=vendure-dev-assets# StagingS3_BUCKET=vendure-staging-assets# ProductionS3_BUCKET=vendure-prod-assets

```

### Migration Between Platforms​


[​](#migration-between-platforms)Switching between storage providers requires updating only the environment variables:

```
# From AWS S3 to CloudFlare R2# Change these variables:S3_ENDPOINT=https://account-id.r2.cloudflarestorage.comS3_FORCE_PATH_STYLE=true# Keep the same bucket name and credentials structure

```

## Troubleshooting​


[​](#troubleshooting)
### Common Issues​


[​](#common-issues)- "Access Denied" Errors:

Verify your access key has proper permissions
Check bucket policies allow the required operations
Ensure credentials are correctly set in environment variables
- Verify your access key has proper permissions
- Check bucket policies allow the required operations
- Ensure credentials are correctly set in environment variables
- "Bucket Not Found" Errors:

Verify bucket name matches exactly (case-sensitive)
Check that S3_REGION matches your bucket's region
For MinIO/R2, ensure S3_FORCE_PATH_STYLE=true
- Verify bucket name matches exactly (case-sensitive)
- Check that S3_REGION matches your bucket's region
- For MinIO/R2, ensure S3_FORCE_PATH_STYLE=true
- Assets Not Loading:

Verify bucket has public read access (if needed)
Check CORS configuration for browser-based access
Ensure assetUrlPrefix matches your actual domain
- Verify bucket has public read access (if needed)
- Check CORS configuration for browser-based access
- Ensure assetUrlPrefix matches your actual domain
- Connection Timeout Issues:

Verify S3_ENDPOINT URL is correct and accessible
Check firewall settings for outbound connections
For self-hosted MinIO, ensure server is running and accessible
- Verify S3_ENDPOINT URL is correct and accessible
- Check firewall settings for outbound connections
- For self-hosted MinIO, ensure server is running and accessible

"Access Denied" Errors:

- Verify your access key has proper permissions
- Check bucket policies allow the required operations
- Ensure credentials are correctly set in environment variables

"Bucket Not Found" Errors:

- Verify bucket name matches exactly (case-sensitive)
- Check that S3_REGION matches your bucket's region
- For MinIO/R2, ensure S3_FORCE_PATH_STYLE=true

Assets Not Loading:

- Verify bucket has public read access (if needed)
- Check CORS configuration for browser-based access
- Ensure assetUrlPrefix matches your actual domain

Connection Timeout Issues:

- Verify S3_ENDPOINT URL is correct and accessible
- Check firewall settings for outbound connections
- For self-hosted MinIO, ensure server is running and accessible

## Conclusion​


[​](#conclusion)You now have a robust, platform-agnostic S3-compatible asset storage solution integrated with your Vendure application. This configuration provides:

- Seamless switching between storage providers via environment variables
- Development-to-production workflow with local storage fallback
- Built-in compatibility with major S3-compatible services
- Production-ready configuration patterns

The unified approach eliminates the need for custom storage plugins while maintaining flexibility across different cloud storage platforms. Your assets will be reliably stored and served regardless of which S3-compatible provider you choose.

## Next Steps​


[​](#next-steps)- Set up CDN integration for improved global asset delivery
- Implement backup strategies for critical assets
- Configure monitoring and alerting for storage operations
- Consider implementing asset optimization and transformation workflows


---

# Open Telemetry


Open Telemetry is a set of APIs, libraries, agents, and instrumentation to provide observability for applications.
It provides a standard way to collect and export telemetry data such as traces, metrics, and logs from applications.

[Open Telemetry](https://opentelemetry.io/)From Vendure v3.3, Vendure has built-in support for Open Telemetry, via the @vendure/telemetry-plugin package.
This package provides a set of decorators and utilities to instrument Vendure services and entities with Open Telemetry.

In this guide we will set up a local Vendure server with Open Telemetry, collecting traces and logs
using the following parts:

- Open Telemetry: The standard for observability.
- Vendure Telemetry Plugin: Instruments the Vendure server & worker for Open Telemetry.
- Jaeger: A distributed tracing system that can be used to collect and visualize traces.
- Loki: A log aggregation system that can be used to collect and visualize logs.
- Grafana: A visualization tool that can be used to visualize traces and logs from Jaeger and Loki.

[Open Telemetry](https://opentelemetry.io/)[Vendure Telemetry Plugin](/reference/core-plugins/telemetry-plugin/)[Jaeger](https://www.jaegertracing.io/)[Loki](https://grafana.com/oss/loki/)[Grafana](https://grafana.com/oss/grafana/)There are many other tools and services that can be used with Open Telemetry, such as Prometheus, Zipkin, Sentry, Dynatrace and others.

In this guide we have chosen some widely-used and open-source tools to demonstrate the capabilities of Open Telemetry.

## Setup​


[​](#setup)
### Set up Jaeger, Loki & Grafana​


[​](#set-up-jaeger-loki--grafana)We will be using Docker to run Jaeger, Loki, and Grafana locally. Create a file called docker-compose.yml
in the root of your project (standard Vendure installations already have one) and add the following contents:

```
services:    jaeger:        image: jaegertracing/all-in-one:latest        ports:            - '4318:4318' # OTLP HTTP receiver            - '16686:16686' # Web UI        environment:            - COLLECTOR_OTLP_ENABLED=true        volumes:            - jaeger_data:/badger        networks:            - jaeger    loki:        image: grafana/loki:3.4        ports:            - '3100:3100'        networks:            - loki    grafana:        environment:            - GF_PATHS_PROVISIONING=/etc/grafana/provisioning            - GF_AUTH_ANONYMOUS_ENABLED=true            - GF_AUTH_ANONYMOUS_ORG_ROLE=Admin            - GF_FEATURE_TOGGLES_ENABLE=alertingSimplifiedRouting,alertingQueryAndExpressionsStepMode        image: grafana/grafana:latest        ports:            - '3200:3000'        networks:            - loki            - jaeger        volumes:            - grafana-storage:/var/lib/grafana    networks:        loki:            driver: bridge        jaeger:            driver: bridge    volumes:        jaeger_data:            driver: local        grafana-storage:            driver: local

```

You can start the services using the following command:

```
docker-compose up -d jaeger loki grafana
```

Once the images have downloaded and the containers are running, you can access:

- Jaeger at http://localhost:16686
- Grafana at http://localhost:3200

[http://localhost:16686](http://localhost:16686)[http://localhost:3200](http://localhost:3200)
### Install the Telemetry Plugin​


[​](#install-the-telemetry-plugin)
```
npm install @vendure/telemetry-plugin
```

Add the plugin to your Vendure config:

```
import { VendureConfig, LogLevel } from '@vendure/core';import { TelemetryPlugin } from '@vendure/telemetry-plugin';export const config: VendureConfig = {    // ... other config options    plugins: [        TelemetryPlugin.init({            loggerOptions: {                // Optional: log to the console as well as                // sending to the telemetry server. Can be                // useful for debugging.                logToConsole: LogLevel.Verbose,            },        }),    ],};
```

### Set environment variables​


[​](#set-environment-variables)In order to send telemetry data to the Jaeger and Loki services, you need to set some environment variables.
In a standard Vendure installation, there is an .env file in the root of the project. We will add the following:

```
# Open TelemetryOTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:3100/otlpOTEL_EXPORTER_OTLP_TRACES_ENDPOINT=http://localhost:4318/v1/tracesOTEL_LOGS_EXPORTER=otlp

```

### Create a preload script​


[​](#create-a-preload-script)The Open Telemetry libraries for Node.js instrument underlying libraries such as NestJS, GraphQL,
Redis, database drivers, etc. to collect telemetry data. In order to do this, they need to be
preloaded before any of the Vendure application code. This is done by means of a preload script.

Create a file called preload.ts in the src dir of your project with the following contents:

```
import { OTLPLogExporter } from '@opentelemetry/exporter-logs-otlp-proto';import { OTLPTraceExporter } from '@opentelemetry/exporter-trace-otlp-http';import { BatchLogRecordProcessor } from '@opentelemetry/sdk-logs';import { NodeSDK } from '@opentelemetry/sdk-node';import { BatchSpanProcessor } from '@opentelemetry/sdk-trace-base';import { getSdkConfiguration } from '@vendure/telemetry-plugin/preload';import 'dotenv/config';const traceExporter = new OTLPTraceExporter();const logExporter = new OTLPLogExporter();const config = getSdkConfiguration({    config: {        spanProcessors: [new BatchSpanProcessor(traceExporter)],        logRecordProcessors: [new BatchLogRecordProcessor(logExporter)],    },});const sdk = new NodeSDK(config);sdk.start();
```

There are many, many configuration options available for Open Telemetry. The above is an example that works
with the services used in this guide. The important things is to make sure the use the
getSdkConfiguration function from the @vendure/telemetry-plugin/preload package, as this will ensure that
the Vendure core is instrumented correctly.

To run the preload script, you need to set the --require flag when starting the Vendure server. We will
also set an environment variable to distinguish the server from the worker process.

You can do this by adding the following script to your package.json:

```
{    "scripts": {        "dev:server": "OTEL_RESOURCE_ATTRIBUTES=service.name=vendure-server ts-node --require ./src/preload.ts ./src/index.ts",        "dev:worker": "OTEL_RESOURCE_ATTRIBUTES=service.name=vendure-worker ts-node --require ./src/preload.ts ./src/index-worker.ts",        "dev": "concurrently npm:dev:*",        "build": "tsc",        "start:server": "OTEL_RESOURCE_ATTRIBUTES=service.name=vendure-server node --require ./dist/preload.js ./dist/index.js",        "start:worker": "OTEL_RESOURCE_ATTRIBUTES=service.name=vendure-worker node --require ./dist/preload.js ./dist/index-worker.js",        "start": "concurrently npm:start:*"    },}
```

## Viewing Logs​


[​](#viewing-logs)Once you have started up your server with the preload script, Loki should start receiving logs.

Let's take a look at the logs in Grafana.

Open the Grafana dashboard at http://localhost:3200 and
select Connections > Data Sources from the left-hand menu. Then click the "Add data source" button.

[http://localhost:3200](http://localhost:3200)Find "Loki" and select it. In the config form that opens, set the URL to http://loki:3100 and click "Save & Test".

Now you can select Drilldown > Logs from the left-hand menu. In the "Data source" dropdown, select "Loki".

## Viewing Traces​


[​](#viewing-traces)You can view traces in Jaeger by going to http://localhost:16686.

[http://localhost:16686](http://localhost:16686)Select the "vendure-dev-server" service from the dropdown and click "Find Traces".

Clicking a trace will show you the details of the trace.

You can also view traces in Grafana by connecting it to Jaeger.

To do this, go to the Grafana dashboard at http://localhost:3200 and
select Connections > Data Sources from the left-hand menu. Then click the "Add data source" button.

[http://localhost:3200](http://localhost:3200)Find "Jaeger" and select it. In the config form that opens, set the URL to http://jaeger:16686 and click "Save & Test".

Now you can select Explore from the left-hand menu, select "Jaeger" from the dropdown and then click the
"search" tab and select the "vendure-dev-server" service from the dropdown.

Clicking the blue "Run Query" button will show you the traces for that service.

## Instrumenting Your Plugins​


[​](#instrumenting-your-plugins)You can also instrument your own plugins and services with Open Telemetry. To do so,
add the Instrument decorator to your service class:

[Instrument decorator](/reference/typescript-api/telemetry/instrument)
```
import { Injectable } from '@nestjs/common';import { Instrument } from '@vendure/core';@Instrument()@Injectable()export class MyService {    async myMethod() {        // ...    }}
```

You should now be able to see calls to MyService.myMethod in your traces.

You should not decorate GraphQL resolvers & REST controllers with this decorator. Those will
already be instrumented, and adding the @Instrument() decorator will potentially
interfere with other NestJS decorators on your resolver methods.
