# Vendure - Other

**Pages:** 27

---

## Customizing Pages

**URL:** https://docs.vendure.io/guides/extending-the-dashboard/customizing-pages/

**Contents:**
- Customizing Pages

Existing pages in the Dashboard can be customized in many ways:

---

## Deploying to Railway

**URL:** https://docs.vendure.io/guides/deployment/deploy-to-railway/

**Contents:**
- Deploying to Railway
- Prerequisites​
- Configuration​
  - Port​
  - Database connection​
  - Asset storage​
- Create a new Railway project​
- Create the database​
- Create the Vendure server​
  - Configure the server service​

Railway is a managed hosting platform which allows you to deploy and scale your Vendure server and infrastructure with ease.

This guide should be runnable on the Railway free trial plan, which means you can deploy it for free and thereafter pay only for the resources you use, which should be around $5 per month.

First of all you'll need to create a new Railway account (click "login" on the website and enter your email address) if you don't already have one.

You'll also need a GitHub account and you'll need to have your Vendure project hosted there.

In order to use the Railway trial plan, you'll need to connect your GitHub account to Railway via the Railway dashboard.

If you'd like to quickly get started with a ready-made Vendure project which includes sample data, you can clone our Vendure one-click-deploy repo.

Railway defines the port via the PORT environment variable, so make sure your Vendure Config uses this variable:

The following is already pre-configured if you are using the one-click-deploy repo.

Make sure your DB connection options uses the following environment variables:

The following is already pre-configured if you are using the one-click-deploy repo.

In this guide we will use the AssetServerPlugin's default local disk storage strategy. Make sure you use the ASSET_UPLOAD_DIR environment variable to set the path to the directory where the uploaded assets will be stored.

From the Railway dashboard, click "New Project" and select "Empty Project". You'll be taken to a screen where you can add the first service to your project.

Click the "Add a Service" button and select "database". Choose a database that matches the one you are using in your Vendure project. If you are following along using the one-click-deploy repo, then choose "Postgres".

Click the "new" button to create a new service, and select "GitHub repo". Select the repository which contains your Vendure project. You may need to configure access to this repo if you haven't already done so.

You should then see a card representing this service in the main area of the dashboard. Click the card and go to the "settings" tab.

In order to persist the uploaded product images, we need to create a volume. Click the "new" button and select "Volume". Attach it to the "vendure-server" service and set the mount path to /vendure-assets.

Click on the "vendure-server" service and go to the "Variables" tab. This is where we will set up the environment variables which are used in our Vendure

*[Content truncated]*

**Examples:**

Example 1 (ts):
```ts
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    apiOptions: {        port: +(process.env.PORT || 3000),        // ...    },    // ...};
```

Example 2 (ts):
```ts
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    dbConnectionOptions: {        // ...        database: process.env.DB_NAME,        host: process.env.DB_HOST,        port: +process.env.DB_PORT,        username: process.env.DB_USERNAME,        password: process.env.DB_PASSWORD,    },};
```

Example 3 (ts):
```ts
import { VendureConfig } from '@vendure/core';import { AssetServerPlugin } from '@vendure/asset-server-plugin';export const config: VendureConfig = {    // ...    plugins: [        AssetServerPlugin.init({            route: 'assets',            assetUploadDir: process.env.ASSET_UPLOAD_DIR || path.join(__dirname, '../static/assets'),        }),    ],    // ...};
```

Example 4 (sh):
```sh
DB_NAME=${{Postgres.PGDATABASE}}DB_USERNAME=${{Postgres.PGUSER}}DB_PASSWORD=${{Postgres.PGPASSWORD}}DB_HOST=${{Postgres.PGHOST}}DB_PORT=${{Postgres.PGPORT}}ASSET_UPLOAD_DIR=/vendure-assetsCOOKIE_SECRET=<add some random characters>SUPERADMIN_USERNAME=superadminSUPERADMIN_PASSWORD=<create some strong password>
```

---

## Insights Page Widgets

**URL:** https://docs.vendure.io/guides/extending-the-dashboard/customizing-pages/insights-widgets

**Contents:**
- Insights Page Widgets
- Example​

The "Insights" page can be extended with custom widgets which are used to display charts, metrics or other information that can be useful for administrators to see at a glance.

Here's an example of a custom widget:

Always wrap your custom widget in the DashboardBaseWidget component, which ensures that it will render correctly in the Insights page.

Use the useWidgetFilters() hook to get the currently-selected date range, if your widget depends on that.

Then register your widget in your dashboard entrypoint file:

Your widget should now be available on the Insights page:

**Examples:**

Example 1 (tsx):
```tsx
import { Badge, DashboardBaseWidget, useLocalFormat, useWidgetFilters } from '@vendure/dashboard';export function CustomWidget() {    const { dateRange } = useWidgetFilters();    const { formatDate } = useLocalFormat();    return (        <DashboardBaseWidget id="custom-widget" title="Custom Widget" description="This is a custom widget">            <div className="flex flex-wrap gap-1">                <span>Displaying results from</span>                <Badge variant="secondary">{formatDate(dateRange.from)}</Badge>                <span>to</span>                <Badge variant="secondary">{forma
...
```

Example 2 (tsx):
```tsx
import { defineDashboardExtension } from '@vendure/dashboard';import { CustomWidget } from './custom-widget';defineDashboardExtension({    widgets: [        {            id: 'custom-widget',            name: 'Custom Widget',            component: CustomWidget,            defaultSize: { w: 3, h: 3 },        },    ],});
```

---

## Relation Selectors

**URL:** https://docs.vendure.io/guides/extending-the-dashboard/custom-form-components/relation-selectors

**Contents:**
- Relation Selectors
- Features​
- Components Overview​
- Basic Usage​
  - Single Selection​
  - Multi Selection​
- Configuration Options​
- Rich Label Display​
  - Product Selector with Images and Pricing​
  - Customer Selector with Status Badges​

Relation selector components provide a powerful way to select related entities in your dashboard forms. They support both single and multi-selection modes with built-in search, infinite scroll pagination, and complete TypeScript type safety.

The relation selector system consists of three main components:

The createRelationSelectorConfig function accepts these options:

The label prop allows you to customize how items are displayed in both the dropdown and selected item chips. This enables rich content like images, badges, and multi-line information.

Register your relation selector components in your dashboard extension:

The relation selector package includes pre-configured setups for common Vendure entities:

Leverage TypeScript generics for full type safety:

When using the label prop for custom rendering:

1. "Cannot query field X on type Query"

Solution: Ensure your GraphQL query field name matches your schema definition exactly.

2. Empty results despite data existing

3. TypeScript errors with config

If you experience slow loading:

**Examples:**

Example 1 (tsx):
```tsx
import {    SingleRelationInput,    createRelationSelectorConfig,    graphql,    ResultOf,    CustomFormComponentInputProps,} from '@vendure/dashboard';// Define your GraphQL queryconst productListQuery = graphql(`    query GetProductsForSelection($options: ProductListOptions) {        products(options: $options) {            items {                id                name                slug                featuredAsset {                    id                    preview                }            }            totalItems        }    }`);// Create the configurationconst productConfig = createRel
...
```

Example 2 (tsx):
```tsx
import { MultiRelationInput, CustomFormComponentInputProps } from '@vendure/dashboard';export function ProductMultiSelectorComponent({ value, onChange, disabled }: CustomFormComponentInputProps) {    return (        <MultiRelationInput            value={value || []}            onChange={onChange}            config={productConfig} // Same config as above            disabled={disabled}        />    );}
```

Example 3 (tsx):
```tsx
interface RelationSelectorConfig<T> {    /** The GraphQL query document for fetching items */    listQuery: DocumentNode;    /** The property key for the entity ID */    idKey: keyof T;    /** The property key for the display label (used as fallback when label function not provided) */    labelKey: keyof T;    /** Number of items to load per page (default: 25) */    pageSize?: number;    /** Placeholder text for the search input */    placeholder?: string;    /** Whether to enable multi-select mode */    multiple?: boolean;    /** Custom filter function for search */    buildSearchFilter?: (se
...
```

Example 4 (tsx):
```tsx
import {    SingleRelationInput,    createRelationSelectorConfig,    graphql,    ResultOf,    CustomFormComponentInputProps,} from '@vendure/dashboard';const productListQuery = graphql(`    query GetProductsWithDetails($options: ProductListOptions) {        products(options: $options) {            items {                id                name                slug                featuredAsset {                    id                    preview                }                variants {                    id                    price                    currencyCode                }            }    
...
```

---

## Getting data into production

**URL:** https://docs.vendure.io/guides/deployment/getting-data-into-production

**Contents:**
- Getting data into production
- Creating the database schema​
- Importing initial & catalog data​
- Importing other data​

Once you have set up your production deployment, you'll need some way to get your products and other data into the system.

The main tasks will be:

The first item - creation of the schema - can be automatically handled by TypeORM's synchronize feature. Switching it on for the initial run will automatically create the schema. This can be done by using an environment variable:

Set the DB_SYNCHRONIZE variable to true on first start, and then after the schema is created, set it to false.

Importing initial and catalog data can be handled by Vendure populate() helper function - see the Importing Product Data guide.

Any kinds of data not covered by the populate() function can be imported using a custom script, which can use any Vendure service or service defined by your custom plugins to populate data in any way you like. See the Stand-alone scripts guide.

**Examples:**

Example 1 (ts):
```ts
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    dbConnectionOptions: {        type: 'postgres',        synchronize: process.env.DB_SYNCHRONIZE,        host: process.env.DB_HOST,        port: process.env.DB_PORT,        username: process.env.DB_USER,        password: process.env.DB_PASSWORD,        database: process.env.DB_DATABASE,    },    // ...};
```

---

## Using Docker

**URL:** https://docs.vendure.io/guides/deployment/using-docker

**Contents:**
- Using Docker
- Docker Compose​
- Kubernetes​
- Health/Readiness Checks​
  - Server​
  - Worker​

Docker is a technology which allows you to run your Vendure application inside a container. The default installation with @vendure/create includes a sample Dockerfile:

This Dockerfile can then be built into an "image" using:

This same image can be used to run both the Vendure server and the worker:

Here is a breakdown of the command used above:

Managing multiple docker containers can be made easier using Docker Compose. In the below example, we use the same Dockerfile defined above, and we also define a Postgres database to connect to:

Kubernetes is used to manage multiple containerized applications. This deployment starts the shop container we created above as both worker and server.

If you wish to deploy with Kubernetes or some similar system, you can make use of the health check endpoints.

This is a regular REST route (note: not GraphQL), available at /health.

Health checks are built on the Nestjs Terminus module. You can also add your own health checks by creating plugins that make use of the HealthCheckRegistryService.

Although the worker is not designed as an HTTP server, it contains a minimal HTTP server specifically to support HTTP health checks. To enable this, you need to call the startHealthCheckServer() method after bootstrapping the worker:

This will make the /health endpoint available. When the worker instance is running, it will return the following:

**Examples:**

Example 1 (dockerfile):
```dockerfile
FROM node:22WORKDIR /usr/src/appCOPY package.json ./COPY package-lock.json ./ RUN npm install --productionCOPY . .RUN npm run build
```

Example 2 (sh):
```sh
docker build -t vendure .
```

Example 3 (sh):
```sh
# Run the serverdocker run -dp 3000:3000 --name vendure-server vendure npm run start:server# Run the workerdocker run -dp 3000:3000 --name vendure-worker vendure npm run start:worker
```

Example 4 (yaml):
```yaml
version: "3"services:  server:    build:      context: .      dockerfile: Dockerfile    ports:      - 3000:3000    command: ["npm", "run", "start:server"]    volumes:      - /usr/src/app    environment:      DB_HOST: database      DB_PORT: 5432      DB_NAME: vendure      DB_USERNAME: postgres      DB_PASSWORD: password  worker:    build:      context: .      dockerfile: Dockerfile    command: ["npm", "run", "start:worker"]    volumes:      - /usr/src/app    environment:      DB_HOST: database      DB_PORT: 5432      DB_NAME: vendure      DB_USERNAME: postgres      DB_PASSWORD: password  databa
...
```

---

## Customizing List Pages

**URL:** https://docs.vendure.io/guides/extending-the-dashboard/customizing-pages/customizing-list-pages

**Contents:**
- Customizing List Pages
- Custom table cell components​
- Bulk actions​
- Extending the list query​

Using the DashboardDataTableExtensionDefinition you can customize any existing data table in the Dashboard.

You can define your own custom components to render specific table cells:

You can define bulk actions on the selected table items. The bulk action component should use DataTableBulkActionItem.

The GraphQL queries used by list views can be extended using the extendListDocument property, and passing the additional fields you want to fetch:

**Examples:**

Example 1 (tsx):
```tsx
import { defineDashboardExtension } from '@vendure/dashboard';defineDashboardExtension({  dataTables: [{      pageId: 'product-list',      displayComponents: [          {              column: 'slug',              // The component will be passed the cell's `value`,              // as well as all the other objects in the Tanstack Table              // `CellContext` object.              component: ({ value, cell, row, table }) => {                  return (                      <a href={`https://storefront.com/products/${value}`} target="_blank">                          {value}                  
...
```

Example 2 (tsx):
```tsx
import { defineDashboardExtension, DataTableBulkActionItem } from '@vendure/dashboard';import { InfoIcon } from 'lucide-react';defineDashboardExtension({  dataTables: [{      pageId: 'product-list',      bulkActions: [          {              component: props => (                  <DataTableBulkActionItem                      onClick={() => {                          console.log('Selection:', props.selection);                          toast.message(`There are ${props.selection.length} selected items`);                      }}                      label="My Custom Action"                      i
...
```

Example 3 (tsx):
```tsx
import { defineDashboardExtension, DataTableBulkActionItem } from '@vendure/dashboard';import { InfoIcon } from 'lucide-react';defineDashboardExtension({  dataTables: [{      pageId: 'product-list',      extendListDocument: `          query {              products {                  items {                      optionGroups {                          id                          name                      }                  }              }          }      `,  }]});
```

---

## Customizing the Login Page

**URL:** https://docs.vendure.io/guides/extending-the-dashboard/customizing-pages/customizing-login-page

**Contents:**
- Customizing the Login Page
- Login page extension points​
- Fully custom login pages​

The login page can be customized with your own logo and messaging, as well as things like SSO login buttons.

Reference documentation can be found at DashboardLoginExtensions.

This will result in a login page like this:

If you need even more control over the login page, you can also create an unauthenticated route with a completely custom layout.

**Examples:**

Example 1 (tsx):
```tsx
import { defineDashboardExtension } from '@vendure/dashboard';import { useSsoLogin } from './use-sso-login';defineDashboardExtension({    login: {        logo: {            component: () => <div className="text-3xl text-muted-foreground">My Logo</div>,        },        beforeForm: {            component: () => <div className="text-muted-foreground">Welcome to My Brand</div>,        },        afterForm: {            component: () => {                const { handleLogin } = useSsoLogin();                return (                    <div>                        <Button variant="secondary" classNam
...
```

Example 2 (tsx):
```tsx
import { defineDashboardExtension } from '@vendure/dashboard';defineDashboardExtension({    routes: [        {            path: '/custom-login',            component: () => (                <div className="flex h-screen items-center justify-center text-2xl">                    This custom login page                </div>            ),            authenticated: false,        },    ],});
```

---

## Page Blocks

**URL:** https://docs.vendure.io/guides/extending-the-dashboard/customizing-pages/page-blocks

**Contents:**
- Page Blocks
- Basic Page Block Example​
- Block Positioning​
  - Before​
  - After​
  - Replace​
- Block Columns​
- Context Data​
- Block Visibility​
- Advanced Example​

In the Dashboard, all pages are built from blocks. Every block has a pageId and a blockId which uniquely locates it in the app (see Dev Mode section).

You can also define your own blocks, which can be added to any page and can even replace the default blocks.

All available options are documented in the DashboardPageBlockDefinition reference

Here's an example of how to define a custom page block:

This will add a "Related Articles" block to the product detail page:

Page blocks can be positioned in three ways relative to existing blocks:

Places the block before the specified blockId:

Places the block after the specified blockId:

Replaces the existing block entirely:

Blocks can be placed in two columns:

The context prop provides access to:

The visibility of a block can be dynamically controlled using the shouldRender function. This function receives the same context object as the block component, and should return a boolean to determine whether the block should be rendered.

The shouldRender function can be used to hide built-in blocks by combining it with the "replace" position on an existing blockId.

Here's a more complex example that shows different types of blocks:

To find the pageId and blockId values for positioning your blocks:

**Examples:**

Example 1 (tsx):
```tsx
import { defineDashboardExtension } from '@vendure/dashboard';defineDashboardExtension({    pageBlocks: [        {            id: 'related-articles',            title: 'Related Articles',            location: {                // This is the pageId of the page where this block will be                pageId: 'product-detail',                // can be "main" or "side"                column: 'side',                position: {                    // Blocks are positioned relative to existing blocks on                    // the page.                    blockId: 'facet-values',                    // C
...
```

Example 2 (tsx):
```tsx
position: {    blockId: 'product-variants',    order: 'before'}
```

Example 3 (tsx):
```tsx
position: {    blockId: 'product-variants',    order: 'after'}
```

Example 4 (tsx):
```tsx
position: {    blockId: 'product-variants',    order: 'replace'}
```

---

## Tech Stack

**URL:** https://docs.vendure.io/guides/extending-the-dashboard/tech-stack/

**Contents:**
- Tech Stack
- Core Technologies​
  - React 19​
  - TypeScript​
  - Vite 6​
- UI Framework​
  - Tailwind CSS v4​
  - Shadcn/ui​
- Data Layer: TanStack Query​
- Routing: TanStack Router​

The Vendure Dashboard is built on a modern stack of technologies that provide a great developer experience and powerful capabilities for building custom extensions.

The dashboard is built with React 19, giving you access to all the latest React features including:

Full TypeScript support throughout the dashboard provides:

Vite 6 powers the development experience with:

The dashboard uses Tailwind CSS v4 for styling:

Built on top of Radix UI primitives, Shadcn/ui provides:

TanStack Query v5 handles all data fetching and server state management:

TanStack Router provides type-safe routing with:

React Hook Form provides powerful form handling with:

gql.tada provides type-safe GraphQL with:

Sonner provides toast notifications with:

Lucide React provides beautiful, customizable icons:

Smooth animations powered by Motion (successor to Framer Motion):

Lingui provides a powerful i18n solution for React:

**Examples:**

Example 1 (tsx):
```tsx
import { useOptimistic, useFormStatus } from 'react';function OptimisticUpdateExample() {    const [optimisticState, addOptimistic] = useOptimistic(state, (currentState, optimisticValue) => {        // Return new state with optimistic update        return [...currentState, optimisticValue];    });    return (        <div>            {optimisticState.map(item => (                <div key={item.id}>{item.name}</div>            ))}        </div>    );}function SubmitButton() {    const { pending } = useFormStatus();    return (        <button type="submit" disabled={pending}>            {pending 
...
```

Example 2 (tsx):
```tsx
// Example using Tailwind classesfunction MyComponent() {    return (        <div className="p-4 bg-white dark:bg-gray-800 rounded-lg shadow-md">            <h2 className="text-lg font-semibold text-gray-900 dark:text-white">My Custom Component</h2>        </div>    );}
```

Example 3 (tsx):
```tsx
import { Button, Input, Card } from '@vendure/dashboard';function MyForm() {    return (        <Card className="p-6">            <Input placeholder="Enter your text" />            <Button className="mt-4">Submit</Button>        </Card>    );}
```

Example 4 (tsx):
```tsx
import { useQuery } from '@tanstack/react-query';import { graphql } from '@/gql';const getProductsQuery = graphql(`    query GetProducts {        products {            items {                id                name                slug            }        }    }`);function ProductList() {    const { data, isLoading, error } = useQuery({        queryKey: ['products'],        queryFn: () => client.request(getProductsQuery),    });    if (isLoading) return <div>Loading...</div>;    if (error) return <div>Error: {error.message}</div>;    return (        <ul>            {data.products.items.map(produ
...
```

---

## Dashboard Theming

**URL:** https://docs.vendure.io/guides/extending-the-dashboard/theming/

**Contents:**
- Dashboard Theming
- Using Themes in Your Components​
  - Using Tailwind Classes​
- Customizing Theme Colors​
- Inspecting element colors in the browser​
- Available Theme Variables​
  - Core Colors​
  - Interactive Colors​
  - Semantic Colors​
  - Border and Input Colors​

The Vendure dashboard uses a modern theming system based on CSS custom properties and Tailwind CSS . This guide shows you how to customize the colors and styles by modifying the theme variables in the Vite plugin.

The dashboard also uses the same theming methodology as shadcn/ui

It also uses the shadcn theme provider implementation for Vite

The Vendure dashboard provides a simple way to access theme variables in your components. Here's how to use them:

The easiest way to use theme colors is through Tailwind variable CSS classes:

You can customize the dashboard theme colors by modifying the theme configuration in your vite.config.mts file. Here's an example showing how to change the primary brand colors:

To identify the exact color values used by dashboard elements, you can use your browser's developer tools:

The dashboard defines comprehensive theme variables that are automatically available as Tailwind classes:

**Examples:**

Example 1 (tsx):
```tsx
function ProductIdWidgetComponent() {    return (        <div className="text-sm">            <p>                This is a custom widget for the product:                <strong className="ml-1 text-foreground">{product.name}</strong>            </p>            <p className="mt-2 text-muted-foreground">Product ID: {product.id}</p>        </div>    );}
```

Example 2 (typescript):
```typescript
// vite.config.mtsimport { vendureDashboardPlugin } from "@vendure/dashboard/plugin";import { defineConfig } from "vite";// ...other importsexport default defineConfig({  plugins: [    vendureDashboardPlugin({      vendureConfigPath: "./src/vendure-config.ts",      adminUiConfig: { apiHost: "http://localhost", apiPort: 3000 },      gqlOutputPath: "./src/gql",      // Theme section      theme: {        light: {          // Change the primary brand color to blue          primary: "oklch(0.55 0.18 240)",          "primary-foreground": "oklch(0.98 0.01 240)",                    // Update the brand
...
```

---

## Deploying to Digital Ocean

**URL:** https://docs.vendure.io/guides/deployment/deploy-to-digital-ocean-app-platform/

**Contents:**
- Deploying to Digital Ocean
- Prerequisites​
- Configuration​
  - Database connection​
  - Asset storage​
- Create Spaces Object Storage​
- Create the server resource​
  - Add a database​
- Set up environment variables​
- Create the worker resource​

App Platform is a fully managed platform which allows you to deploy and scale your Vendure server and infrastructure with ease.

The configuration in this guide will cost around $22 per month to run.

First of all you'll need to create a new Digital Ocean account if you don't already have one.

For this guide you'll need to have your Vendure project in a git repo on either GitHub or GitLab. App Platform also supports deploying from docker registries, but that is out of the scope of this guide.

If you'd like to quickly get started with a ready-made Vendure project which includes sample data, you can clone our Vendure one-click-deploy repo.

The following is already pre-configured if you are using the one-click-deploy repo.

Make sure your DB connection options uses the following environment variables:

The following is already pre-configured if you are using the one-click-deploy repo.

Since App Platform services do not include any persistent storage, we need to configure Vendure to use Digital Ocean's Spaces service, which is an S3-compatible object storage service. This means you'll need to make sure to have the following packages installed:

and set up your AssetServerPlugin like this:

First we'll create a Spaces bucket to store our assets. Click the "Spaces Object Storage" nav item and create a new space and call it "vendure-assets".

Next we need to create an access key and secret. Click the "API" nav item and generate a new key.

Name the key something meaningful like "vendure-assets-key" and then make sure to copy the secret as it will only be shown once. Store the access key and secret key in a safe place for later - we'll be using it when we set up our app's environment variables.

If you forget to copy the secret key, you'll need to delete the key and create a new one.

Now we're ready to create our app infrastructure! Click the "Create" button in the top bar and select "Apps".

Now connect to your git repo, and select the repo of your Vendure project.

Depending on your repo, App Platform may suggest more than one app: in this screenshot we are using the one-click-deploy repo which contains a Dockerfile, so App Platform is suggesting two different ways to deploy the app. We'll select the Dockerfile option, but either option should work fine. Delete the unused resource.

We need to edit the details of the server app. Click the "Edit" button and set the following:

At this point you can also click the "Edit Plan" button to select the resource all

*[Content truncated]*

**Examples:**

Example 1 (ts):
```ts
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    dbConnectionOptions: {        // ...        type: 'postgres',        database: process.env.DB_NAME,        host: process.env.DB_HOST,        port: +process.env.DB_PORT,        username: process.env.DB_USERNAME,        password: process.env.DB_PASSWORD,        ssl: process.env.DB_CA_CERT ? {            ca: process.env.DB_CA_CERT,        } : undefined,    },};
```

Example 2 (text):
```text
npm install @aws-sdk/client-s3 @aws-sdk/lib-storage
```

Example 3 (ts):
```ts
import { VendureConfig } from '@vendure/core';import { AssetServerPlugin, configureS3AssetStorage } from '@vendure/asset-server-plugin';export const config: VendureConfig = {    // ...    plugins: [        AssetServerPlugin.init({            route: 'assets',            assetUploadDir: process.env.ASSET_UPLOAD_DIR || path.join(__dirname, '../static/assets'),            // If the MINIO_ENDPOINT environment variable is set, we'll use            // Minio as the asset storage provider. Otherwise, we'll use the            // default local provider.            storageStrategyFactory: process.env.MINI
...
```

Example 4 (sh):
```sh
DB_NAME=${db.DATABASE}DB_USERNAME=${db.USERNAME}DB_PASSWORD=${db.PASSWORD}DB_HOST=${db.HOSTNAME}DB_PORT=${db.PORT}DB_CA_CERT=${db.CA_CERT}COOKIE_SECRET=<add some random characters>SUPERADMIN_USERNAME=superadminSUPERADMIN_PASSWORD=<create some strong password>MINIO_ACCESS_KEY=<use the key generated earlier>MINIO_SECRET_KEY=<use the secret generated earlier>MINIO_ENDPOINT=<use the endpoint of your spaces bucket>
```

---

## Deployment

**URL:** https://docs.vendure.io/guides/extending-the-dashboard/deployment/

**Contents:**
- Deployment
- Deployment Options​
  - Option 1: Serve with DashboardPlugin​
  - Option 2: Standalone Hosting​
- Serving with DashboardPlugin​
  - 1. Configure Vite Base Path​
  - 2. Add DashboardPlugin to Vendure Config​
- Building for Production​
- Accessing the Dashboard​
- Configuration Options​

The Vendure Dashboard offers flexible deployment options. You can either serve it directly through your Vendure Server using the DashboardPlugin, or host it independently as a static site.

The DashboardPlugin integrates seamlessly with your Vendure Server by:

The Vendure Dashboard can be hosted independently as a static site, since the build produces standard web assets (index.html, CSS, and JS files). This approach offers maximum flexibility for deployment on any static hosting service.

To configure the DashboardPlugin, follow these steps:

Update your vite.config.mts to set the base path where the dashboard will be served:

If you want to use the Admin UI and the Dashboard together please change the compatibilityMode to true.

Add the DashboardPlugin to your vendure-config.ts:

Before deploying your Vendure application, build the dashboard:

This command creates optimized production files in the dist directory that the DashboardPlugin will serve.

Once configured and built, your dashboard will be accessible at:

The dashboard can be hosted independently from your Vendure Server on any static hosting service (Netlify, Vercel, AWS S3, etc.).

When hosting standalone, you must configure the dashboard to connect to your Admin API endpoint:

Environment variables are resolved at build time and embedded as static strings in the final bundles. Ensure these variables are available during the build process, not just at runtime.

Deploy the contents of the dist directory to your hosting service

When hosting the dashboard separately, configure CORS on your Vendure Server:

**Examples:**

Example 1 (typescript):
```typescript
import { vendureDashboardPlugin } from '@vendure/dashboard/vite';import path from 'path';import { pathToFileURL } from 'url';import { defineConfig } from 'vite';export default defineConfig({    base: '/dashboard/',    plugins: [        vendureDashboardPlugin({            vendureConfigPath: pathToFileURL('./src/vendure-config.ts'),            api: {                host: 'http://localhost',                port: 3000,            },            gqlOutputPath: path.resolve(__dirname, './src/gql/'),        }),    ],});
```

Example 2 (typescript):
```typescript
import { DashboardPlugin } from '@vendure/dashboard/plugin';import path from 'path';export const config: VendureConfig = {    // ... other config    plugins: [        // ... other plugins        DashboardPlugin.init({            // Important: This must match the base path from vite.config.mts (without slashes)            route: 'dashboard',            // Path to the Vite build output directory            appDir: path.join(__dirname, './dist'),        }),    ],};
```

Example 3 (bash):
```bash
npx vite build
```

Example 4 (text):
```text
http://your-server-url/dashboard/
```

---

## Deploying to Google Cloud Run

**URL:** https://docs.vendure.io/guides/deployment/deploy-to-google-cloud-run/

**Contents:**
- Deploying to Google Cloud Run
- Prerequisites​
- Setting up a MySQL database with Google Cloud SQL​
- Google Cloud Storage for assets​
- Google Cloud Tasks for Vendure's worker​
- Running locally​
- Dockerize Vendure​
- Deployment​
- Keep alive​

Google Cloud Run is a fully managed platform which allows you to run containerized apps and only pay while your app code is actually running.

This guide was written by Martijn from Pinelab, who have been successfully running multiple Vendure projects on Google Cloud Run. The step by step commands can be found here on GitHub:

This guide assumes you have:

Google Cloud SQL is a fully-managed relational database service that makes it easy to set up, maintain, and manage databases in the cloud. Vendure requires an SQL database to store its data, and Google Cloud SQL is a great option for this because it provides a reliable, scalable, and secure way to host our database.

You can find the gcloud commands to create a MySQL database here: https://github.com/Pinelab-studio/vendure-google-cloud-run-starter/blob/main/README.md#create-a-mysql-database

Vendure stores assets such as product images on file system by default. However, Google Cloud Run does not have internal file storage, so we need to use an external storage service. Google Cloud Storage is a great option for this because it provides a scalable and reliable way to store our assets in the cloud.

Use these gcloud commands to create a storage bucket for our assets.

Vendure uses a worker process to perform asynchronous tasks such as sending emails. To communicate between the main application and the worker process, we need a message queue. Google Cloud Tasks is a great option for this because it provides a fully-managed, scalable, and reliable way to send and receive messages between applications.

You don't need to do anything to enable Cloud Tasks: this plugin automatically creates task queues for you.

Let's test out our application locally before deploying to Cloud Run. Copy this .env.example to .env and fill in your variables. You can skip the WORKER_HOST variable, because we don't have it yet.

Google Cloud Run allows us to deploy containerized applications without worrying about the underlying infrastructure. To deploy Vendure to Google Cloud Run, we need to Dockerize it. Dockerizing Vendure means packaging the application and its dependencies into a container that can be easily deployed to Google Cloud Run.

The setup for containerizing Vendure is already done: This file and this file will build your container.

The example repository contains GitHub action definitions to automatically deploy your app to Cloud Run when you push to the main branch.

Follow these steps to create a service account 

*[Content truncated]*

---

## History Entries

**URL:** https://docs.vendure.io/guides/extending-the-dashboard/customizing-pages/history-entries

**Contents:**
- History Entries
- Example​

The Customer and Order detail pages have a special history timeline, which show a summary of all significant changes and activity relating to that customer or order.

History entries are defined by DashboardHistoryEntryComponent, and the component should be wrapped in HistoryEntry.

Following the backend example of a custom history entry given in the HistoryService docs, we can define a corresponding component to render this entry in the customer history timeline:

This will then appear in the customer history timeline:

**Examples:**

Example 1 (tsx):
```tsx
import { defineDashboardExtension, HistoryEntry } from '@vendure/dashboard';import { IdCard } from 'lucide-react';defineDashboardExtension({    historyEntries: [        {            type: 'CUSTOMER_TAX_ID_VERIFICATION',            component: ({ entry, entity }) => {                return (                    <HistoryEntry                        entry={entry}                        title={'Tax ID verified'}                        timelineIconClassName={'bg-success text-success-foreground'}                        timelineIcon={<IdCard />}                    >                        <div classNam
...
```

---

## Custom Form Elements

**URL:** https://docs.vendure.io/guides/extending-the-dashboard/custom-form-components/

**Contents:**
- Custom Form Elements
- Anatomy of a Form Component​
- Custom Field Components​
- Configurable Operation Components​
- Detail Form Components​
  - Targeting Input Components​
- Form Validation​
- Nested Forms and Event Handling​
  - Why Use handleNestedFormSubmit?​
  - Using handleNestedFormSubmit​

The dashboard allows you to create custom form elements that provide complete control over how data is rendered and how users interact with forms. This includes:

All form components must implement the DashboardFormComponent type.

This type is based on the props that are made available from react-hook-form, which is the underlying form library used by the Dashboard.

Here's an example custom form component that has been annotated to explain the typical parts you will be working with:

Here's how this component will look when rendered in your form:

Let's configure a custom field which uses the ColorPickerComponent as its form component.

First we need to register the component with the defineDashboardExtension function:

Now that we've registered it as a custom field component, we can use it in our custom field definition.

The ColorPickerComponent can also be used as a configurable operation argument component. For example, we can add a color code to a shipping calculator:

Detail form components allow you to replace specific input fields in existing dashboard forms with custom implementations. They are targeted to specific pages, blocks, and fields.

Let's say we want to use a plain text editor for the product description field rather than the default html-based editor.

You can then use this component in your detail form definition:

Input components are targeted using three properties:

You can discover the required IDs by turning on dev mode:

and then hovering over any of the form elements will allow you to view the IDs:

Form validation is handled by the react-hook-form library, which is used by the Dashboard. Internally, the Dashboard uses the zod library to validate the form data, based on the configuration of the custom field or operation argument.

You can access validation data for the current field or the whole form by using the useFormContext hook.

Your component does not need to handle standard error messages - the Dashboard will handle them for you.

For example, if your custom field specifies a pattern property, the Dashboard will automatically display an error message if the input does not match the pattern.

Always import UI components from the @vendure/dashboard package rather than creating custom inputs or buttons. This ensures your components follow the dashboard's design system and remain consistent with future updates.

The unified custom form elements system gives you complete flexibility in how data is presented and edited in th

*[Content truncated]*

**Examples:**

Example 1 (tsx):
```tsx
import { Button, Card, CardContent, cn, DashboardFormComponent, Input } from '@vendure/dashboard';import { useState } from 'react';import { useFormContext } from 'react-hook-form';// By typing your component as DashboardFormComponent, the props will be correctly typedexport const ColorPickerComponent: DashboardFormComponent = ({ value, onChange, name }) => {    // You can use any of the built-in React hooks as usual    const [isOpen, setIsOpen] = useState(false);    // To access the react-hook-form context, use this hook.    // This is useful for getting information about the current    // fie
...
```

Example 2 (tsx):
```tsx
import { defineDashboardExtension } from '@vendure/dashboard';import { ColorPickerComponent } from './components/color-picker';defineDashboardExtension({    customFormComponents: {        // Custom field components for custom fields        customFields: [            {                // The "id" is a global identifier for this custom component. We will                // reference it in the next step.                id: 'color-picker',                component: ColorPickerComponent,            },        ],    },    // ... other extension properties});
```

Example 3 (tsx):
```tsx
@VendurePlugin({    // ...    configuration: config => {        config.customFields.Product.push({            name: 'color',            type: 'string',            pattern: '^#[A-Fa-f0-9]{6}$',            label: [{ languageCode: LanguageCode.en, value: 'Color' }],            description: [{ languageCode: LanguageCode.en, value: 'Main color for this product' }],            ui: {                // This is the ID of the custom field                // component we registered above.                component: 'color-picker',            },        });        return config;    },})export class MyPlugin 
...
```

Example 4 (tsx):
```tsx
const customShippingCalculator = new ShippingCalculator({    code: 'custom-shipping-calculator',    description: [{ languageCode: LanguageCode.en, value: 'Custom Shipping Calculator' }],    args: {        color: {            type: 'string',            label: [{ languageCode: LanguageCode.en, value: 'Color' }],            description: [                { languageCode: LanguageCode.en, value: 'Color code for this shipping calculator' },            ],            ui: { component: 'color-picker' },        },    },    calculate: (ctx, order, args) => {        // ...    },});
```

---

## Action Bar Items

**URL:** https://docs.vendure.io/guides/extending-the-dashboard/customizing-pages/action-bar-items

**Contents:**
- Action Bar Items
- Basic Action Bar Item​
- Context Data​
- Dropdown Menu​
- Practical Examples​
  - Export Button​
  - Sync Button with Loading State​
  - Conditional Action Bar Items​
- Multiple Action Bar Items​
- Available Button Variants​

The Action Bar is the bar at the top of the page where you can add buttons and other actions.

All available options are documented in the DashboardActionBarItem reference

Here's a simple example of adding a button to the action bar:

The context prop provides access to:

You can also define dropdown menu items for the Action Bar. This is useful for secondary actions that are needed less often by administrators.

Make sure to always wrap these in the DropdownMenuItem component for consistent styling.

You can conditionally show action bar items based on the entity or user permissions:

You can add multiple action bar items to the same page:

The dashboard provides several button variants you can use:

To find the pageId for your action bar items:

**Examples:**

Example 1 (tsx):
```tsx
import { Button, defineDashboardExtension } from '@vendure/dashboard';import { useState } from 'react';defineDashboardExtension({    actionBarItems: [        {            pageId: 'product-detail',            component: ({ context }) => {                const [count, setCount] = useState(0);                return (                    <Button type="button" variant="secondary" onClick={() => setCount(x => x + 1)}>                        Counter: {count}                    </Button>                );            },        },    ],});
```

Example 2 (tsx):
```tsx
import { DropdownMenuItem, defineDashboardExtension } from '@vendure/dashboard';import { useState } from 'react';defineDashboardExtension({    actionBarItems: [        {            pageId: 'product-list',            type: 'dropdown',            component: () => <DropdownMenuItem variant="default">My Item</DropdownMenuItem>        }    ],});
```

Example 3 (tsx):
```tsx
import { Button, defineDashboardExtension } from '@vendure/dashboard';import { DownloadIcon } from 'lucide-react';defineDashboardExtension({    actionBarItems: [        {            pageId: 'product-detail',            component: ({ context }) => {                const product = context.entity;                const handleExport = async () => {                    // Export product data                    const data = JSON.stringify(product, null, 2);                    const blob = new Blob([data], { type: 'application/json' });                    const url = URL.createObjectURL(blob);         
...
```

Example 4 (tsx):
```tsx
import { Button, defineDashboardExtension } from '@vendure/dashboard';import { RefreshCwIcon } from 'lucide-react';import { useState } from 'react';import { toast } from 'sonner';defineDashboardExtension({    actionBarItems: [        {            pageId: 'product-detail',            component: ({ context }) => {                const [isSyncing, setIsSyncing] = useState(false);                const product = context.entity;                const handleSync = async () => {                    if (!product) return;                    setIsSyncing(true);                    try {                     
...
```

---

## Creating List Pages

**URL:** https://docs.vendure.io/guides/extending-the-dashboard/creating-pages/list-pages

**Contents:**
- Creating List Pages
- Setup​
- List Page Example​
- The ListPage Component​
- Customizing Columns​

This guide assumes you have a CmsPlugin with an Article entity, as covered in the Extending the Dashboard: Plugin Setup guide.

List pages can be easily created for any query in the Admin API that follows the PaginatedList pattern.

For example, the articles query of our CmsPlugin looks like this:

First we'll create a new article-list.tsx file in the ./src/plugins/cms/dashboard directory:

Let's register this route (and we can also remove the test page) in our index.tsx file:

After adding new Dashboard files to your plugin, you'll need to re-start the dev server for those files to be picked up by Vite:

The ListPage component can be customized to your exact needs, such as:

See the ListPage component reference for an explanation of the available options.

It is common that you will want to customize the way certain columns are rendered. This is done using the customizeColumns prop on the ListPage component.

By default, an appropriate component will be chosen to render the column data based on the data type of the field. However, in many cases you want to have more control over how the column data is rendered.

**Examples:**

Example 1 (graphql):
```graphql
type ArticleList implements PaginatedList {  items: [Article!]!  totalItems: Int!}extend type Query {  articles(options: ArticleListOptions): ArticleList!}
```

Example 2 (tsx):
```tsx
import {    Button,    DashboardRouteDefinition,    ListPage,    PageActionBarRight,    DetailPageButton,} from '@vendure/dashboard';import { Link } from '@tanstack/react-router';import { PlusIcon } from 'lucide-react';// This function is generated for you by the `vendureDashboardPlugin` in your Vite config.// It uses gql-tada to generate TypeScript types which give you type safety as you write// your queries and mutations.import { graphql } from '@/gql';// The fields you select here will be automatically used to generate the appropriate columns in the// data table below.const getArticleList =
...
```

Example 3 (tsx):
```tsx
import { defineDashboardExtension } from '@vendure/dashboard';import { articleList } from './article-list';defineDashboardExtension({    routes: [        articleList,    ],});
```

Example 4 (bash):
```bash
q # to stop the running dev servernpx vite # to restart
```

---

## Customizing Detail Pages

**URL:** https://docs.vendure.io/guides/extending-the-dashboard/customizing-pages/customizing-detail-pages

**Contents:**
- Customizing Detail Pages
- Custom form inputs​
- Extending the detail query​

Using the DashboardDetailFormExtensionDefinition you can customize any existing detail page in the Dashboard.

You can replace any of the default form inputs with your own components using the inputs property.

Let's say you want to replace the default HTML description editor with a markdown editor component:

To learn how to build custom form components, see the Custom Form Elements guide.

You might want to extend the GraphQL query used to fetch the data for the detail page. For example, to include new fields that your plugin has defined so that you can render them in custom page blocks.

**Examples:**

Example 1 (tsx):
```tsx
import { defineDashboardExtension } from '@vendure/dashboard';import { MarkdownEditor } from './markdown-editor';defineDashboardExtension({    detailForms: [        {            pageId: 'product-detail',            inputs: [                {                    blockId: 'main-form',                    field: 'description',                    component: MarkdownEditor,                },            ],        },    ],});
```

Example 2 (tsx):
```tsx
import { defineDashboardExtension } from '@vendure/dashboard';defineDashboardExtension({    detailForms: [        {            pageId: 'product-detail',            extendDetailDocument: `          query {              product(id: $id) {                  relatedProducts {                      id                      name                      featuredAsset {                        id                        preview                      }                  }              }          }      `,        },    ],});
```

---

## Production configuration

**URL:** https://docs.vendure.io/guides/deployment/production-configuration/

**Contents:**
- Production configuration
- Environment variables​
- Superadmin credentials​
- API hardening​
- ID Strategy​
- Database Timezone​
- Trust proxy​
- Security Considerations​

This is a guide to the recommended configuration for a production Vendure application.

Keep sensitive information or context-dependent settings in environment variables. In local development you can store the values in a .env file. For production, you should use the mechanism provided by your hosting platform to set the values for production.

The default @vendure/create project scaffold makes use of environment variables already. For example:

The APP_ENV environment variable can then be set using the admin dashboard of your hosting provider:

If you are using Docker or Kubernetes, they include their own methods of setting environment variables.

Ensure you set the superadmin credentials to something other than the default of superadmin:superadmin. Use your hosting platform's environment variables to set a strong password for the Superadmin account.

It is recommended that you install and configure the HardenPlugin for all production deployments. This plugin locks down your schema (disabling introspection and field suggestions) and protects your Shop API against malicious queries that could otherwise overwhelm your server.

Then add it to your VendureConfig:

For a detailed explanation of how to best configure this plugin, see the HardenPlugin docs.

By default, Vendure uses auto-increment integer IDs as entity primary keys. While easier to work with in development, sequential primary keys can leak information such as the number of orders or customers in the system.

For this reason you should consider using the UuidIdStrategy for production.

Another option, if you wish to stick with integer IDs, is to create a custom EntityIdStrategy which uses the encodeId() and decodeId() methods to obfuscate the sequential nature of the ID.

Vendure internally treats all dates & times as UTC. However, you may sometimes run into issues where dates are offset by some fixed amount of hours. E.g. you place an order at 17:00, but it shows up in the Dashboard as being placed at 19:00. Typically, this is caused by the timezone of your database not being set to UTC.

You can check the timezone in MySQL/MariaDB by executing:

and you should expect to see 00:00:00.

In Postgres, you can execute:

and you should expect to see UTC or Etc/UTC.

When deploying your Vendure application behind a reverse proxy (usually the case with most hosting services), consider configuring Express's trust proxy setting. This allows you to retrieve the original IP address from the X-Forwarded-For

*[Content truncated]*

**Examples:**

Example 1 (ts):
```ts
const IS_DEV = process.env.APP_ENV === 'dev';
```

Example 2 (ts):
```ts
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {  authOptions: {    tokenMethod: ['bearer', 'cookie'],    superadminCredentials: {      identifier: process.env.SUPERADMIN_USERNAME,      password: process.env.SUPERADMIN_PASSWORD,    },  },  // ...};
```

Example 3 (sh):
```sh
npm install @vendure/harden-plugin# oryarn add @vendure/harden-plugin
```

Example 4 (ts):
```ts
import { VendureConfig } from '@vendure/core';import { HardenPlugin } from '@vendure/harden-plugin';const IS_DEV = process.env.APP_ENV === 'dev';export const config: VendureConfig = {  // ...  plugins: [    HardenPlugin.init({      maxQueryComplexity: 500,      apiMode: IS_DEV ? 'dev' : 'prod',    }),    // ...  ]};
```

---

## Deploying to Northflank

**URL:** https://docs.vendure.io/guides/deployment/deploy-to-northflank/

**Contents:**
- Deploying to Northflank
- Set up a Northflank account​
- Create a custom template​
- Run the template​
- Find the public URL​
- Next steps​

Northflank is a comprehensive developer platform to build and scale your apps. It has an outstanding developer experience and has a free tier for small projects, and is well-suited for deploying and scaling Vendure applications.

This guide will walk you through the steps to deploy a sample Vendure application to Northflank.

Go to the Northflank sign up page to create a new account. As part of the sign-up you'll be asked for credit card details, but you won't be charged unless you upgrade to a paid plan.

A template defines the infrastructure that is needed to run your Vendure server. Namely, a server, a worker, MinIO object storage for assets and a Postgres database.

Click the templates menu item in the navbar and click the "Create template" button.

Now paste the following configuration into the editor in the "code" tab:

This template configures a production-like setup for Vendure, with the server and worker running in separate processes and a separate MinIO instance for asset storage.

The resources configured here will cost around $20 per month.

If you want to use the free plan, use the "Lite Template".

This template runs the Vendure server & worker in a single process, and as such will fit within the resource limits of the Northflank free plan. Local disk storage is used for assets, which means that horizontal scaling is not possible.

This setup is suitable for testing purposes, but is not recommended for production use.

Then click the "Create template" button.

Next, click the "run template" button to start the deployment process.

Once the template run has completed, you should be able to see the newly-created project in the project selector.

Click the "Services" menu item in the left sidebar and then click the "Server" service.

In the top right corner you'll see the public URL of your new Vendure server!

Note that it may take a few minutes for the server to start up and populate all the test data because the free tier has limited CPU and memory resources.

Once it is ready, you can navigate to the public URL and append /admin to the end of the URL to access the admin panel.

The superadmin password was generated for you by the template, and can be found in the "Secrets" section from the project nav bar as SUPERADMIN_PASSWORD.

Congratulations on deploying your Vendure server!

Now that you have a basic Vendure server up and running, you can explore some of the other features offered by Northflank that you might need for a full production 

*[Content truncated]*

**Examples:**

Example 1 (json):
```json
{  "apiVersion": "v1.2",  "spec": {    "kind": "Workflow",    "spec": {      "type": "sequential",      "steps": [        {          "kind": "Project",          "ref": "project",          "spec": {            "name": "Vendure",            "region": "europe-west",            "description": "Vendure is a modern, open-source composable commerce platform",            "color": "#17b9ff"          }        },        {          "kind": "Workflow",          "spec": {            "type": "parallel",            "context": {              "projectId": "${refs.project.id}"            },            "steps": [
...
```

Example 2 (json):
```json
{  "apiVersion": "v1.2",  "spec": {    "kind": "Workflow",    "spec": {      "type": "sequential",      "steps": [        {          "kind": "Project",          "ref": "project",           "spec": {            "name": "Vendure Lite",            "region": "europe-west",            "description": "Vendure is a modern, open-source composable commerce platform",            "color": "#17b9ff"          }        },        {          "kind": "Addon",          "spec": {            "name": "database",            "type": "postgres",            "version": "14-latest",            "billing": {              
...
```

---

## Navigation

**URL:** https://docs.vendure.io/guides/extending-the-dashboard/navigation/

**Contents:**
- Navigation
- Adding Navigation Items to Existing Sections​
  - Available Section IDs​
  - Finding Section IDs & Ordering​
- Creating Custom Navigation Sections​
- Section Placement and Ordering​
  - Placement Examples​
  - Order Scoping​
  - Default Section Orders​
- Unauthenticated Routes​

The dashboard provides a flexible navigation system that allows you to add custom navigation sections and menu items. Navigation items are organized into sections that can be placed in either the "Platform" (top) or "Administration" (bottom) areas of the sidebar.

The simplest way to add navigation is to add menu items to existing sections. This is done automatically when you define routes with navMenuItem properties.

The dashboard comes with several built-in sections:

You can find the available IDs & their order value for all navigation sections and items using Dev mode:

You can create entirely new navigation sections with their own icons and ordering:

For documentation on all the configuration properties available, see the reference docs:

The navigation sidebar is divided into two areas:

Order values are scoped within each placement area. This means:

Top Placement (Platform):

Bottom Placement (Administration):

This means if you want to add a section between Catalog and Sales in the top area, you might use order: 250. If you want to add a section before Settings in the bottom area, you could use order: 150.

If you don't specify a placement, sections default to 'top' placement.

By default, all navigation is assumed to be for authenticated routes, i.e. the routes are only accessible to administrators who are logged in.

Sometimes you want to make a certain route accessible to unauthenticated users. For example, you may want to implement a completely custom login page or a password recovery page, which must be accessible to everyone.

This is done by setting authenticated: false in your route definition:

This page will then be accessible to all users at http://localhost:4873/dashboard/public

Here's a comprehensive example showing how to create a complete navigation structure for a content management system:

The dashboard uses Lucide React icons. You can import any icon from the library:

Common icons for navigation sections:

**Examples:**

Example 1 (tsx):
```tsx
import { defineDashboardExtension } from '@vendure/dashboard';defineDashboardExtension({    routes: [        {            path: '/my-custom-page',            component: () => <div>My Custom Page</div>,            navMenuItem: {                // The section where this item should appear                sectionId: 'catalog',                // Unique identifier for this menu item                id: 'my-custom-page',                // Display text in the navigation                title: 'My Custom Page',                // Optional: URL if different from path                url: '/my-custom-page', 
...
```

Example 2 (tsx):
```tsx
import { defineDashboardExtension } from '@vendure/dashboard';import { FileTextIcon, SettingsIcon } from 'lucide-react';defineDashboardExtension({    // Define custom navigation sections    navSections: [        {            id: 'content-management',            title: 'Content',            icon: FileTextIcon,            placement: 'top', // Platform area            order: 350, // After Customers (400), before Marketing (500)        },        {            id: 'integrations',            title: 'Integrations',            icon: SettingsIcon,            placement: 'bottom', // Administration area  
...
```

Example 3 (tsx):
```tsx
defineDashboardExtension({    navSections: [        {            id: 'reports',            title: 'Reports',            icon: BarChartIcon,            placement: 'top', // Appears in Platform area            order: 150, // Positioned within top sections        },        {            id: 'integrations',            title: 'Integrations',            icon: PlugIcon,            placement: 'bottom', // Appears in Administration area            order: 150, // Positioned within bottom sections        },    ],});
```

Example 4 (tsx):
```tsx
import { defineDashboardExtension } from '@vendure/dashboard';defineDashboardExtension({    routes: [        {            path: '/public',            component: () => (                <div className="flex h-screen items-center justify-center text-2xl">This is a public page!</div>            ),            authenticated: false        },    ]});
```

---

## Server resource requirements

**URL:** https://docs.vendure.io/guides/deployment/server-resource-requirements

**Contents:**
- Server resource requirements
- Server resource requirements​
  - RAM​
  - CPU​
- Load testing​

The Vendure server and worker process each use around 200-300MB of RAM when idle. This figure will increase under load.

The total RAM required by a single instance of the server depends on your project size (the number of products, variants, customers, orders etc.) as well as expected load (the number of concurrent users you expect). As a rule, 512MB per process would be a practical minimum for a smaller project with low expected load.

CPU resources are generally measured in "cores" or "vCPUs" (virtual CPUs) depending on the type of hosting. The exact relationship between vCPUs and physical CPU cores is out of the scope of this guide, but for our purposes we will use "CPU" to refer to both physical and virtual CPU resources.

Because Node.js is single-threaded, a single instance of the Vendure server or worker will not be able to take advantage of multiple CPUs. For example, if you set up a server instance running with 4 CPUs, the server will only use 1 of those CPUs and the other 3 will be wasted.

Therefore, when looking to optimize performance (for example, the number of requests that can be serviced per second), it makes sense to scale horizontally by running multiple instances of the Vendure server. See the Horizontal Scaling guide.

It is important to test whether your current server configuration will be able to handle the loads you expect when you go into production. There are numerous tools out there to help you load test your application, such as:

---

## Creating Pages

**URL:** https://docs.vendure.io/guides/extending-the-dashboard/creating-pages/

**Contents:**
- Creating Pages
- Page Structure​
- Page Routes & Navigation​

All pages in the Dashboard follow this structure:

Following this structure ensures that:

Note that the ListPage and DetailPage components internally use this same structure, so when using those top-level components you don't need to wrap them in Page etc.

Once you have defined a page component, you'll need to make it accessible to users with:

Both of these are handled using the DashboardRouteDefinition API:

For a complete guide to the navigation options available, see the Navigation guide

**Examples:**

Example 1 (tsx):
```tsx
import { Page, PageBlock, PageLayout, PageTitle } from '@vendure/dashboard';export function TestPage() {    return (        <Page pageId="test-page">            <PageTitle>Test Page</PageTitle>            <PageLayout>                <PageBlock column="main" blockId="main-stuff">                    This will display in the main area                </PageBlock>                <PageBlock column="side" blockId="side-stuff">                    This will display in the side area                </PageBlock>            </PageLayout>        </Page>    )}
```

Example 2 (tsx):
```tsx
import { defineDashboardExtension } from '@vendure/dashboard';import { TestPage } from './test-page';defineDashboardExtension({    routes: [        {            // The TestPage will be available at e.g.             // http://localhost:5173/dashboard/test            path: '/test',            // The loader function is allows us to define breadcrumbs            loader: () => ({ breadcrumb: 'Test Page' }),            // Here we define the nav menu items            navMenuItem: {                // a unique ID                id: 'test',                // the nav menu item label                title:
...
```

---

## Extending the Dashboard

**URL:** https://docs.vendure.io/guides/extending-the-dashboard/extending-overview/

**Contents:**
- Extending the Dashboard
- Plugin Setup​
- Add Dashboard to Plugin​
- IDE GraphQL Integration​
- Dev Mode​
- What's Next?​

The custom functionality you create in your Vendure plugins often needs to be exposed via the Dashboard so that administrators can interact with it.

This guide covers how you can set up your plugins with extensions to the Dashboard.

For the purposes of the guides in this section of the docs, we will work with a simple Content Management System (CMS) plugin that allows us to create and manage content articles.

Let's create the plugin:

Now let's add an entity to the plugin:

You now have your CmsPlugin created with a new Article entity. You can find the plugin in the ./src/plugins/cms directory.

Let's edit the entity to add the appropriate fields:

Now let's create a new ArticleService to handle the business logic of our new entity:

The service will be created in the ./src/plugins/cms/services directory.

Finally, we'll extend the GraphQL API to expose those CRUD operations:

Now the api extensions and resolver has been created in the ./src/plugins/cms/api-extensions directory.

The last step is to create a migration for our newly-created entity:

Your project should now have the following structure:

Dashboard extensions are declared directly on the plugin metadata. Unlike the old AdminUiPlugin, you do not need to separately declare ui extensions anywhere except on the plugin itself.

You can do this automatically with the CLI command:

This will add the dashboard property to your plugin as above, and will also create the /dashboard/index.tsx file which looks like this:

When extending the dashboard, you'll very often need to work with GraphQL documents for fetching data and executing mutations.

Plugins are available for most popular IDEs & editors which provide auto-complete and type-checking for GraphQL operations as you write them. This is a huge productivity boost, and is highly recommended.

Run the npx vendure schema to generate a GraphQL schema file that your IDE plugin can use to provide autocomplete.

Once you have logged in to the dashboard, you can toggle on "Dev Mode" using the user menu in the bottom left:

In Dev Mode, hovering any block in the dashboard will allow you to find the corresponding pageId and blockId values, which you can later use when customizing the dashboard. This is essential for:

Now that you understand the fundamentals of extending the dashboard, explore these specific guides:

**Examples:**

Example 1 (bash):
```bash
npx vendure add --plugin cms
```

Example 2 (bash):
```bash
npx vendure add --entity Article --selected-plugin CmsPlugin --custom-fields
```

Example 3 (ts):
```ts
import { DeepPartial, HasCustomFields, VendureEntity } from '@vendure/core';import { Column, Entity } from 'typeorm';export class ArticleCustomFields {}@Entity()export class Article extends VendureEntity implements HasCustomFields {    constructor(input?: DeepPartial<Article>) {        super(input);    }    @Column()    slug: string;    @Column()    title: string;    @Column('text')    body: string;    @Column()    isPublished: boolean;    @Column(type => ArticleCustomFields)    customFields: ArticleCustomFields;}
```

Example 4 (bash):
```bash
npx vendure add --service ArticleService --selected-plugin CmsPlugin --selected-entity Article
```

---

## Deploying to Render

**URL:** https://docs.vendure.io/guides/deployment/deploy-to-render/

**Contents:**
- Deploying to Render
- Prerequisites​
- Configuration​
  - Port​
  - Database connection​
  - Asset storage​
- Create a database​
- Create the Vendure server​
  - Configure the server service​
- Configure environment variables​

Render is a managed hosting platform which allows you to deploy and scale your Vendure server and infrastructure with ease.

The configuration in this guide will cost from around $12 per month to run.

First of all you'll need to create a new Render account if you don't already have one.

For this guide you'll need to have your Vendure project in a git repo on either GitHub or GitLab.

If you'd like to quickly get started with a ready-made Vendure project which includes sample data, you can use our Vendure one-click-deploy repo, which means you won't have to set up your own git repo.

Render defines the port via the PORT environment variable and defaults to 10000, so make sure your Vendure Config uses this variable:

The following is already pre-configured if you are using the one-click-deploy repo.

Make sure your DB connection options uses the following environment variables:

The following is already pre-configured if you are using the one-click-deploy repo.

In this guide we will use the AssetServerPlugin's default local disk storage strategy. Make sure you use the ASSET_UPLOAD_DIR environment variable to set the path to the directory where the uploaded assets will be stored.

From the Render dashboard, click the "New" button and select "PostgreSQL" from the list of services:

Give the database a name (e.g. "postgres"), select a region close to you, select an appropriate plan and click "Create Database".

Click the "New" button again and select "Web Service" from the list of services. Choose the "Build and deploy from a Git repository" option.

In the next step you will be prompted to connect to either GitHub or GitLab. Select the appropriate option and follow the instructions to connect your account and grant access to the repository containing your Vendure project.

If you are using the one-click-deploy repo, you should instead use the "Public Git repository" option and enter the URL of the repo:

In the next step you will configure the server:

Click the "Advanced" button to expand the advanced options:

Click "Create Web Service" to create the service.

If you have not already set up payment, you will be prompted to enter credit card details at this point.

Next we need to set up the environment variables which will be used by both the server and worker. Click the "Env Groups" tab and then click the "New Environment Group" button.

Name the group "vendure configuration" and add the following variables. The database variables can be found by navigat

*[Content truncated]*

**Examples:**

Example 1 (ts):
```ts
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    apiOptions: {        port: +(process.env.PORT || 3000),        // ...    },    // ...};
```

Example 2 (ts):
```ts
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    dbConnectionOptions: {        // ...        database: process.env.DB_NAME,        host: process.env.DB_HOST,        port: +process.env.DB_PORT,        username: process.env.DB_USERNAME,        password: process.env.DB_PASSWORD,    },};
```

Example 3 (ts):
```ts
import { VendureConfig } from '@vendure/core';import { AssetServerPlugin } from '@vendure/asset-server-plugin';export const config: VendureConfig = {    // ...    plugins: [        AssetServerPlugin.init({            route: 'assets',            assetUploadDir: process.env.ASSET_UPLOAD_DIR || path.join(__dirname, '../static/assets'),        }),    ],    // ...};
```

Example 4 (text):
```text
https://github.com/vendure-ecommerce/one-click-deploy
```

---

## Data Fetching

**URL:** https://docs.vendure.io/guides/extending-the-dashboard/data-fetching/

**Contents:**
- Data Fetching
- API Client​
  - Importing the API Client​
  - Using with TanStack Query​
    - Query Example​
    - Mutation Example​
- Type Safety​

The API client is the primary way to send queries and mutations to the Vendure backend. It handles channel tokens and authentication automatically.

The API client exposes two main methods:

The API client is designed to work seamlessly with TanStack Query for optimal data fetching and caching:

The Dashboard Vite plugin incorporates gql.tada, which gives you type safety without any code generation step!

It works by analyzing your Admin API schema (including all your custom fields and other API extensions), and outputs the results to a file - by default you can find it at src/gql/graphql-env.d.ts.

When you then use the import { graphql } from '@/gql' function to define your queries and mutations, you get automatic type safety when using the results in your components!

When you have the @/gql path mapping correctly set up as per the getting started guide, you should see that your IDE is able to infer the TypeScript type of your queries and mutations, including the correct inputs and return types!

**Examples:**

Example 1 (tsx):
```tsx
import { api } from '@vendure/dashboard';
```

Example 2 (tsx):
```tsx
import { useQuery } from '@tanstack/react-query';import { api } from '@vendure/dashboard';import { graphql } from '@/gql';const getProductsQuery = graphql(`    query GetProducts($options: ProductListOptions) {        products(options: $options) {            items {                id                name                slug            }            totalItems        }    }`);function ProductList() {    const { data, isLoading, error } = useQuery({        queryKey: ['products'],        queryFn: () =>            api.query(getProductsQuery, {                options: {                    take: 10,   
...
```

Example 3 (tsx):
```tsx
import { useMutation, useQueryClient } from '@tanstack/react-query';import { api } from '@vendure/dashboard';import { graphql } from '@/gql';import { toast } from 'sonner';const updateProductMutation = graphql(`    mutation UpdateProduct($input: UpdateProductInput!) {        updateProduct(input: $input) {            id            name            slug        }    }`);function ProductForm({ product }) {    const queryClient = useQueryClient();    const mutation = useMutation({        mutationFn: input => api.mutate(updateProductMutation, { input }),        onSuccess: () => {            // Invali
...
```

---
