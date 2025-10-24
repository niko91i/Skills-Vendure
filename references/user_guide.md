# Vendure - User Guide

**Pages:** 26

---

## Checkout Flow

**URL:** https://docs.vendure.io/guides/storefront/checkout-flow/

**Contents:**
- Checkout Flow
- Add a customer​
- Set the shipping address​
- Set the shipping method​
- Add payment​
  - Stripe​
  - Braintree​
  - Mollie​
  - Other payment providers​
- Display confirmation​

Once the customer has added the desired products to the active order, it's time to check out.

This guide assumes that you are using the default OrderProcess, so if you have defined a custom process, some of these steps may be slightly different.

In this guide, we will assume that an ActiveOrder fragment has been defined, as detailed in the Managing the Active Order guide, but for the purposes of checking out the fragment should also include customer shippingAddress and billingAddress fields.

Every order must be associated with a customer. If the customer is not logged in, then the setCustomerForOrder mutation must be called. This will create a new Customer record if the provided email address does not already exist in the database.

If the customer is already logged in, then this step is skipped.

The setOrderShippingAddress mutation must be called to set the shipping address for the order.

If the customer is logged in, you can check their existing addresses and pre-populate an address form if an existing address is found.

Now that we know the shipping address, we can check which shipping methods are available with the eligibleShippingMethods query.

The results can then be displayed to the customer so they can choose the desired shipping method. If there is only a single result, then it can be automatically selected.

The desired shipping method's id is then passed to the setOrderShippingMethod mutation.

The eligiblePaymentMethods query can be used to get a list of available payment methods. This list can then be displayed to the customer, so they can choose the desired payment method.

Next, we need to transition the order to the ArrangingPayment state. This state ensures that no other changes can be made to the order while the payment is being arranged. The transitionOrderToState mutation is used to transition the order to the ArrangingPayment state.

At this point, your storefront will use an integration with the payment provider to collect the customer's payment details, and then the exact sequence of API calls will depend on the payment integration.

The addPaymentToOrder mutation is the general-purpose mutation for adding a payment to an order. It accepts a method argument which must correspond to the code of the selected payment method, and a metadata argument which is a JSON object containing any additional information required by that particular integration.

For example, the demo data populated in a new Vendure installation includes a "Standard Payment" method using the `dummyPaymentHandler` to simulate payment processing. The metadata object can include flags like `shouldDecline` and `shouldError` for testing purposes.

**Supported Payment Providers:**

Vendure provides dedicated plugins for major payment providers:

1. **Stripe** - See the Stripe plugin documentation for integration details
2. **Braintree** - See the Braintree plugin documentation for setup instructions
3. **Mollie** - See the Mollie plugin documentation for configuration

**Other Payment Providers:**

For payment providers beyond Stripe, Braintree, and Mollie, refer to the broader Payment guide which covers custom payment integrations and implementing your own payment handlers.

The key point is that the exact sequence of API calls will depend on the payment integration you've selected for your storefront.

**Examples:**

Example 1 (graphql):
```graphql
mutation SetCustomerForOrder($input: CreateCustomerInput!) {  setCustomerForOrder(input: $input) {    ...ActiveOrder    ...on ErrorResult {      errorCode      message    }  }}
```

Example 2 (json):
```json
{  "input": {    "title": "Mr.",    "firstName": "Bob",    "lastName": "Dobalina",    "phoneNumber": "1234556",    "emailAddress": "b.dobalina@email.com",  }}
```

Example 3 (graphql):
```graphql
mutation SetOrderShippingAddress($input: CreateAddressInput!) {  setOrderShippingAddress(input: $input) {    ...ActiveOrder    ...on ErrorResult {      errorCode      message    }  }}
```

Example 4 (json):
```json
{  "input": {    "fullName": "John Doe",    "company": "ABC Inc.",    "streetLine1": "123 Main St",    "streetLine2": "Apt 4B",    "city": "New York",    "province": "NY",    "postalCode": "10001",    "countryCode": "US",    "phoneNumber": "123-456-7890",    "defaultShippingAddress": true,    "defaultBillingAddress": false  }}
```

---

## Adding UI Translations

**URL:** https://docs.vendure.io/guides/extending-the-admin-ui/adding-ui-translations/

**Contents:**
- Adding UI Translations
- Translation format​
- Adding a new language​
- Translating UI Extensions​

The Vendure Admin UI is fully localizable, allowing you to:

The Admin UI uses the Messageformat specification to convert i18n tokens to localized strings in the browser. Each language should have a corresponding JSON file containing the translations for that language.

Here is an excerpt from the en.json file that ships with the Admin UI:

The translation tokens are grouped into a single-level deep nested structure. In the Angular code, these are referenced like this:

That is, the { ... } represent variables that are passed from the application code and interpolated into the final localized string.

The Admin UI ships with built-in support for many languages, but allows you to add support for any other language without the need to modify the package internals.

Create your translation file

Start by copying the contents of the English language file into a new file, <languageCode>.json, where languageCode is the 2-character ISO 639-1 code for the language. Replace the strings with the translation for the new language.

Install @vendure/ui-devkit

If not already installed, install the @vendure/ui-devkit package, which allows you to create custom builds of the Admin UI.

Register the translation file

Here's a minimal directory structure and sample code to add your new translation:

And the config code to register the translation file:

You can also create translations for your own UI extensions, in much the same way as outlined above in "Adding a new language". Your translations can be split over several files, since the translations config object can take a glob, e.g.:

This allows you, if you wish, to co-locate your translation files with your components.

Care should be taken to uniquely namespace your translation tokens, as conflicts with the base translation file will cause your translations to overwrite the defaults. This can be solved by using a unique section name, e.g.:

**Examples:**

Example 1 (json):
```json
{  "admin": {    "create-new-administrator": "Create new administrator"  },  "asset": {    "add-asset": "Add asset",    "add-asset-with-count": "Add {count, plural, 0 {assets} one {1 asset} other {{count} assets}}",    "assets-selected-count": "{ count } assets selected",    "dimensions": "Dimensions"  }}
```

Example 2 (html):
```html
<label>{{ 'asset.assets-selected-count' | translate:{ count } }}</label>
```

Example 3 (text):
```text
/src├─ vendure-config.ts└─ translations/    └─ ms.json
```

Example 4 (ts):
```ts
import path from 'path';import { VendureConfig } from '@vendure/core';import { AdminUiPlugin } from '@vendure/admin-ui-plugin';import { compileUiExtensions } from '@vendure/ui-devkit/compiler';export const config: VendureConfig = {    // ...    plugins: [        AdminUiPlugin.init({            port: 3002,            app: compileUiExtensions({                outputPath: path.join(__dirname, '../admin-ui'),                extensions: [{                    translations: {                        ms: path.join(__dirname, 'translations/ms.json'),                    }                }],            })
...
```

---

## Admin UI Theming & Branding

**URL:** https://docs.vendure.io/guides/extending-the-admin-ui/admin-ui-theming-branding/

**Contents:**
- Admin UI Theming & Branding
- AdminUiPlugin branding settings​
- Specifying custom logos​
- Theming​

The Vendure Admin UI can be themed to your company's style and branding.

The AdminUiPlugin allows you to specify your "brand" name, and allows you to control whether to display the Vendure name and version in the UI. Specifying a brand name will also set it as the title of the Admin UI in the browser.

For the simple level of branding shown above, the @vendure/ui-devkit package is not required.

You can replace the Vendure logos and favicon with your own brand logo:

Much of the visual styling of the Admin UI can be customized by providing your own themes in a Sass stylesheet. For the most part, the Admin UI uses CSS custom properties to control colors and other styles. Here's a simple example which changes the color of links:

Some customizable styles in Clarity, the Admin UI's underlying UI framework, are controlled by Sass variables, which can be found on the project's GitHub page. Similar to above, you can also provide your own values, which will override defaults set by the framework. Here's an example which changes the height of the main header:

globalStyles and sassVariableOverrides extensions can be used in conjunction or separately.

**Examples:**

Example 1 (ts):
```ts
import { VendureConfig } from '@vendure/core';import { AdminUiPlugin } from '@vendure/admin-ui-plugin';export const config: VendureConfig = {    // ...    plugins: [        AdminUiPlugin.init({            // ...            adminUiConfig:{                brand: 'My Store',                hideVendureBranding: false,                hideVersion: false,            }        }),    ],};
```

Example 2 (ts):
```ts
import path from 'path';import { AdminUiPlugin } from '@vendure/admin-ui-plugin';import { VendureConfig } from '@vendure/core';import { compileUiExtensions, setBranding } from '@vendure/ui-devkit/compiler';export const config: VendureConfig = {    // ...    plugins: [        AdminUiPlugin.init({            app: compileUiExtensions({                outputPath: path.join(__dirname, '../admin-ui'),                extensions: [                    setBranding({                        // The small logo appears in the top left of the screen                          smallLogoPath: path.join(__dirname,
...
```

Example 3 (css):
```css
:root {  --clr-link-active-color: hsl(110, 65%, 57%);  --clr-link-color: hsl(110, 65%, 57%);  --clr-link-hover-color: hsl(110, 65%, 57%);  --clr-link-visited-color: hsl(110, 55%, 75%);}
```

Example 4 (ts):
```ts
import path from 'path';import { AdminUiPlugin } from '@vendure/admin-ui-plugin';import { VendureConfig } from '@vendure/core';import { compileUiExtensions } from '@vendure/ui-devkit/compiler';export const config: VendureConfig = {    // ...    plugins: [        AdminUiPlugin.init({            app: compileUiExtensions({                outputPath: path.join(__dirname, '../admin-ui'),                extensions: [{                    globalStyles: path.join(__dirname, 'my-theme.scss')                }],            }),        }),    ],}
```

---

## Creating List Views

**URL:** https://docs.vendure.io/guides/extending-the-admin-ui/creating-list-views/

**Contents:**
- Creating List Views
- Example: Creating a Product Reviews List​
  - Use the PaginatedList interface​
  - Create the list component​
  - Create the template​
  - Route config​
- Supporting custom fields​

The two most common type of components you'll be creating in your UI extensions are list components and detail components.

In Vendure, we have standardized the way you write these components so that your ui extensions can be made to fit seamlessly into the rest of the app.

The specific pattern described here is for Angular-based components. It is also possible to create list views using React components, but in that case you won't be able to use the built-in data table & other Angular-specific components.

Let's say you have a plugin which adds a new entity to the database called ProductReview. You want to create a new list view in the Admin UI which displays all the reviews submitted.

To use the standardized list component, you need to make sure your plugin exposes this list in the GraphQL API following the PaginatedList interface:

See the Paginated Lists guide for details on how to implement this in your server plugin code.

The list component itself is an Angular component which extends the BaseListComponent or TypedBaseListComponent class.

This example assumes you have set up your project to use code generation as described in the GraphQL code generation guide.

This is the standard layout for any list view. The main functionality is provided by the DataTable2Component.

From Vendure v2.2, it is possible for your custom entities to support custom fields.

If you have set up your entity to support custom fields, and you want custom fields to be available in the Admin UI list view, you need to add the following to your list component:

and then add the vdr-dt2-custom-field-column component to your data table:

**Examples:**

Example 1 (graphql):
```graphql
type ProductReview implements Node {  id: ID!  createdAt: DateTime!  updatedAt: DateTime!  title: String!  rating: Int!  text: String!  authorName: String!  product: Product!  productId: ID!  }type ProductReviewList implements PaginatedList {  items: [ProductReview!]!  totalItems: Int!}
```

Example 2 (ts):
```ts
import { ChangeDetectionStrategy, Component } from '@angular/core';import { TypedBaseListComponent, SharedModule } from '@vendure/admin-ui/core';// This is the TypedDocumentNode generated by GraphQL Code Generatorimport { graphql } from '../../gql';const getReviewListDocument = graphql(`  query GetReviewList($options: ReviewListOptions) {    reviews(options: $options) {      items {        id        createdAt        updatedAt        title        rating        text        authorName        productId      }      totalItems    }  }`);@Component({    selector: 'review-list',    templateUrl: './rev
...
```

Example 3 (html):
```html
<!-- optional if you want some buttons at the top --><vdr-page-block>    <vdr-action-bar>        <vdr-ab-left></vdr-ab-left>        <vdr-ab-right>            <a class="btn btn-primary" *vdrIfPermissions="['CreateReview']" [routerLink]="['./', 'create']">                <clr-icon shape="plus"></clr-icon>                Create a review            </a>        </vdr-ab-right>    </vdr-action-bar></vdr-page-block><!-- The data table --><vdr-data-table-2        id="review-list"        [items]="items$ | async"        [itemsPerPage]="itemsPerPage$ | async"        [totalItems]="totalItems$ | async"    
...
```

Example 4 (ts):
```ts
import { registerRouteComponent } from '@vendure/admin-ui/core';import { ReviewListComponent } from './components/review-list/review-list.component';export default [    registerRouteComponent({        path: '',        component: ReviewListComponent,        breadcrumb: 'Product reviews',    }),]
```

---

## UI Component Library

**URL:** https://docs.vendure.io/guides/extending-the-admin-ui/ui-library/

**Contents:**
- UI Component Library
- Buttons​
- Icons​
- Form inputs​
- Cards​
- Layout​

The Admin UI is built on a customized version of the Clarity Design System. This means that if you are writing Angular-based UI extensions, you can use the same components that are used in the rest of the Admin UI. If you are using React, we are gradually exporting the most-used components for use with React.

There are three types of button:

You can use the built-in Clarity Icons for a consistent look-and-feel with the rest of the Admin UI app.

Form inputs are styled globally, so you don't need to use special components for these. The label & tooltip styling is controlled by the "form field" wrapper component.

The form-grid class is used to lay out the form fields into a 2-column grid on larger screens, and a single column on smaller screens. If you want to force a particular field to always take up the full width (i.e. to span 2 columns at all screen sizes), you can add the form-grid-span class to that form field.

Cards are used as a general-purpose container for page content, as a way to visually group related sets of components.

The following layout components are available:

**Examples:**

Example 1 (html):
```html
<button class="button primary">Primary</button><button class="button secondary">Secondary</button><button class="button success">Success</button><button class="button warning">Warning</button><button class="button danger">Danger</button><button class="button-ghost">Ghost</button><a class="button-ghost" [routerLink]="['/extensions/my-plugin/my-custom-route']">    <clr-icon shape="arrow" dir="right"></clr-icon>    John Smith</a><button class="button-small">Small</button><button class="button-small">    <clr-icon shape="layers"></clr-icon>    Assign to channel</button>
```

Example 2 (tsx):
```tsx
import React from 'react';import { CdsIcon, Link } from '@vendure/admin-ui/react';export function DemoComponent() {    return (        <>            <button className="button primary">Primary</button>            <button className="button secondary">Secondary</button>            <button className="button success">Success</button>            <button className="button warning">Warning</button>            <button className="button danger">Danger</button>                        <button className="button-ghost">Ghost</button>            <Link className="button-ghost" href="/extensions/my-plugin/my-c
...
```

Example 3 (html):
```html
<clr-icon shape="star" size="8"></clr-icon><clr-icon shape="star" size="16"></clr-icon><clr-icon shape="star" size="24"></clr-icon><clr-icon shape="star" size="36"></clr-icon><clr-icon shape="star" size="48"></clr-icon><clr-icon shape="star" size="56"></clr-icon><clr-icon shape="user" class="has-badge--success"></clr-icon><clr-icon shape="user" class="has-alert"></clr-icon><clr-icon shape="user" class="has-badge--info"></clr-icon><clr-icon shape="user" class="has-badge--error"></clr-icon><clr-icon shape="user" class="is-success"></clr-icon><clr-icon shape="user" class="is-info"></clr-icon><clr
...
```

Example 4 (tsx):
```tsx
import React from 'react';import { starIcon, userIcon } from '@cds/core/icon';import { CdsIcon } from '@vendure/admin-ui/react';export function DemoComponent() {    return (        <>            <CdsIcon icon={starIcon} size="xs" />            <CdsIcon icon={starIcon} size="sm" />            <CdsIcon icon={starIcon} size="md" />            <CdsIcon icon={starIcon} size="lg" />            <CdsIcon icon={starIcon} size="xl" />            <CdsIcon icon={starIcon} size="xxl" />                        <CdsIcon icon={userIcon} badge="success" />            <CdsIcon icon={userIcon} badge="info" />   
...
```

---

## Page Tabs

**URL:** https://docs.vendure.io/guides/extending-the-admin-ui/page-tabs/

**Contents:**
- Page Tabs

You can add your own tabs to any of the Admin UI's list or detail pages using the registerPageTab function. For example, to add a new tab to the product detail page for displaying product reviews:

If you want to add page tabs to a custom admin page, specify the locationId property:

Currently it is only possible to define new tabs using Angular components.

**Examples:**

Example 1 (ts):
```ts
import { registerPageTab } from '@vendure/admin-ui/core';import { ReviewListComponent } from './components/review-list/review-list.component';export default [    registerPageTab({        location: 'product-detail',        tab: 'Reviews',        route: 'reviews',        tabIcon: 'star',        component: ReviewListComponent,    }),];
```

Example 2 (ts):
```ts
import { registerRouteComponent } from '@vendure/admin-ui/core';import { TestComponent } from './components/test/test.component';export default [    registerRouteComponent({        component: TestComponent,        title: 'Test',        locationId: 'my-location-id'    }),];
```

---

## Custom Form Inputs

**URL:** https://docs.vendure.io/guides/extending-the-admin-ui/custom-form-inputs/

**Contents:**
- Custom Form Inputs
- For Custom Fields​
  - 1. Define a component​
  - 2. Register the component​
  - 3. Register the providers​
  - 4. Update the custom field config​
- Custom Field Controls for Relations​
- For ConfigArgs​

You can define custom Angular or React components which can be used to render Custom Fields you have defined on your entities as well as configurable args used by custom Configurable Operations.

Let's say you define a custom "intensity" field on the Product entity:

By default, the "intensity" field will be displayed as a number input:

But let's say we want to display a range slider instead.

First we need to define a new Angular or React component to render the slider:

Angular components will have the readonly, config and formControl properties populated automatically.

React components can use the useFormControl hook to access the form control and set its value. The component will also receive config and readonly data as props.

Next we will register this component in our providers.ts file and give it a unique ID, 'slider-form-input':

The providers.ts is then passed to the compileUiExtensions() function as described in the UI Extensions Getting Started guide:

Once registered, this new slider input can be used in our custom field config:

As we can see, adding the ui property to the custom field config allows us to specify our custom slider component. The component id 'slider-form-input' must match the string passed as the first argument to registerFormInputComponent().

If we want, we can also pass any other arbitrary data in the ui object, which will then be available in our component as this.config.ui.myField. Note that only JSON-compatible data types are permitted, so no functions or class instances.

Re-compiling the Admin UI will result in our SliderControl now being used for the "intensity" custom field:

If you have a custom field of the relation type (which allows you to relate entities with one another), you can also define custom field controls for them. The basic mechanism is exactly the same as with primitive custom field types (i.e. string, int etc.), but there are a couple of important points to know:

Here's an example of a custom field control for a relation field which relates a Product to a custom ProductReview entity:

ConfigArgs are used by classes which extend Configurable Operations (such as ShippingCalculator or PaymentMethodHandler). These ConfigArgs allow user-input values to be passed to the operation's business logic.

They are configured in a very similar way to custom fields, and likewise can use custom form inputs by specifying the ui property.

**Examples:**

Example 1 (ts):
```ts
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    customFields: {        Product: [            { name: 'intensity', type: 'int', min: 0, max: 100, defaultValue: 0 },        ],    },}
```

Example 2 (ts):
```ts
import { Component } from '@angular/core';import { FormControl } from '@angular/forms';import { IntCustomFieldConfig, SharedModule, FormInputComponent } from '@vendure/admin-ui/core';@Component({    template: `      <input          type="range"          [min]="config.min || 0"          [max]="config.max || 100"          [formControl]="formControl" />      {{ formControl.value }}  `,    standalone: true,    imports: [SharedModule],})export class SliderControlComponent implements FormInputComponent<IntCustomFieldConfig> {    readonly: boolean;    config: IntCustomFieldConfig;    formControl: For
...
```

Example 3 (tsx):
```tsx
import React from 'react';import { useFormControl, ReactFormInputOptions, useInjector } from '@vendure/admin-ui/react';export function SliderFormInput({ readonly, config }: ReactFormInputOptions) {    const { value, setFormValue } = useFormControl();    const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {        const val = +e.target.value;        setFormValue(val);    };    return (        <>            <input                type="range"                readOnly={readonly}                min={config.min || 0}                max={config.max || 100}                value={value}    
...
```

Example 4 (ts):
```ts
import { registerFormInputComponent } from '@vendure/admin-ui/core';import { SliderControlComponent } from './components/slider-form-input/slider-form-input.component';export default [    registerFormInputComponent('slider-form-input', SliderControlComponent),];
```

---

## Storefront Starters

**URL:** https://docs.vendure.io/guides/storefront/storefront-starters/

**Contents:**
- Storefront Starters
- Remix Storefront​
- Qwik Storefront​
- Angular Storefront​

Since building an entire Storefront from scratch can be a daunting task, we have prepared a few starter projects that you can use as a base for your own storefront.

These starters provide basic functionality including:

The idea is that you clone the starter project and then customize it to your needs.

Prefer to build your own solution? Follow the rest of the guides in this section to learn how to build a Storefront from scratch.

Remix is a React-based full-stack JavaScript framework which focuses on web standards, modern web app UX, and which helps you build better websites.

Our official Remix Storefront starter provides you with a lightning-fast, modern storefront solution which can be deployed to any of the popular cloud providers like Vercel, Netlify, or Cloudflare Pages.

Qwik is a cutting-edge web framework that offers unmatched performance.

Our official Qwik Storefront starter provides you with a lightning-fast, modern storefront solution which can be deployed to any of the popular cloud providers like Vercel, Netlify, or Cloudflare Pages.

Angular is a popular, stable, enterprise-grade framework made by Google.

Our official Angular Storefront starter is a modern Progressive Web App that uses Angular Universal server-side rendering.

---

## Migrating from Admin UI

**URL:** https://docs.vendure.io/guides/extending-the-dashboard/migration/

**Contents:**
- Migrating from Admin UI
- Running In Parallel​
- AI-Assisted Migration​
  - Full Prompt​
  - Claude Skills​
  - Manual Cleanup​
- Manual Migration​
  - Forms​
  - Custom Field Inputs​
  - List Pages​

If you have existing extensions to the legacy Angular-based Admin UI, you will want to migrate to the new Dashboard to enjoy an improved developer experience, many more customization options, and ongoing support from the Vendure team.

The Angular Admin UI will not be maintained after July 2026. Until then, we will continue patching critical bugs and security issues. Community contributions will always be merged and released.

A recommended approach to migrating is to run both the Admin UI and the new Dashboard in parallel. This allows you to start building new features right away with the new Dashboard while maintaining access to existing features that have not yet been migrated.

To do so, follow the instructions to set up the Dashboard, and then make sure you set the AdminUiPlugin compatibilityMode option to true:

We highly recommend using AI tools such as Claude Code, Codex etc to assist with migrations from the legacy Angular-based UI extensions to the new React-based Dashboard.

The results of AI-assisted migration are heavily dependent on the model that you use. We tested with Claude Code using Sonnet 4.5 & Codex using gpt-5-codex

In our testing, we were able to perform complete migrations quickly using the following approach:

Using this approach we were able to migrate complete plugins involving list/details views, widgets, and custom field components in around 20-30 minutes.

Give a prompt like this to your AI assistant and make sure to specify the plugin by path, i.e.:

Then paste the following prompt in full:

The full prompt is quite large, so it can make sense to first clear the current LLM context, e.g. with /clear in Claude Code or /new in Codex CLI

If you use Claude Code, you can use Agent Skills to set up a specialized skill for migrating plugins. This has the advantage that you do not need to continually paste in the full prompt, and it can also be potentially more token-efficient.

To set up a the skill, run this from the root of your project:

This command uses degit to copy over the vendure-dashboard-migration skill to your local ./claude/skills directory.

You can then have Claude Code use the skill with a prompt like:

The individual files in the skill contain the exact same content as the full prompt above, but are more easily reused and can be more token-efficient

It is very likely you'll still need to do some manual cleanup after an AI-assisted migration. You might run into things like:
- TypeScript compilation errors requiring minor adjustments
- Component imports needing path corrections
- Hook usage requiring refinement
- Permission checks needing migration to the new system

**Manual Migration:**

If you would rather do a full manual migration, the guide provides comprehensive component mapping across major features:

**Forms:**
Replace Angular's `vdr-form-field` with `FormFieldWrapper` using react-hook-form. Structure layouts with `DetailFormGrid` for two-column grids and use `space-y-6` for vertical spacing between sections.

**Custom Field Inputs:**
Migrate from `FormInputComponent` to `DashboardFormComponent`. The new component receives `value`, `onChange`, and `name` props, with access to form context via React hooks.

**List Pages:**
Transform `TypedBaseListComponent` into the `ListPage` component, which auto-generates columns from GraphQL queries. Customize using `customizeColumns`, `defaultVisibility`, and `defaultColumnOrder` properties.

**Detail Pages:**
Replace `TypedBaseDetailComponent` with the `useDetailPage()` hook. Structure layouts using `PageLayout`, `PageBlock`, and `DetailFormGrid` components for consistent styling.

**Navigation & Actions:**
Configure menu items via `navMenuItem` properties on routes. Define action bar items through the `actionBarItems` array for page-level actions.

**Page Blocks & Widgets:**
Implement custom components as page blocks with positioning controls. Create dashboard widgets using the `DashboardBaseWidget` wrapper component.

**Examples:**

Example 1 (ts):
```ts
AdminUiPlugin.init({    // ... existing config    compatibilityMode: true,}),
```

Example 2 (text):
```text
Migrate the plugin at @src/plugins/my-plugin/ to use the new dashboard.
```

Example 3 (md):
```md
## Instructions1. If not explicitly stated by the user, find out which plugin they want to migrate.2. Read and understand the overall rules for migration    - the "General" section below    - the "Common Tasks" section below3. Check the tsconfig setup <tsconfig-setup>. This may or may not already be set up.    - the "TSConfig setup" section below4. Identify each part of the Admin UI extensions that needs to be   migrated, and use the data from the appropriate sections to guide   the migration:    - the "Forms" section below    - the "Custom Field Inputs" section below    - the "List Pages" sec
...
```

Example 4 (text):
```text
npx degit vendure-ecommerce/vendure/.claude/skills#minor .claude/skills
```

---

## Custom Detail Components

**URL:** https://docs.vendure.io/guides/extending-the-admin-ui/custom-detail-components/

**Contents:**
- Custom Detail Components
  - 1. Create a component​
  - 2. Register the component​
- Manipulating the detail form​

Detail views can be extended with custom Angular or React components using the registerCustomDetailComponent and registerReactCustomDetailComponent functions.

Any components registered in this way will appear below the main detail form.

The valid locations for embedding custom detail components can be found in the CustomDetailComponentLocationId docs.

Let's imagine that your project has an external content management system (CMS) which is used to store additional details about products. You might want to display some of this information in the product detail page. We will demonstrate the same component in both Angular and React.

When using React, we can use the useDetailComponentData hook to access the entity and form data.

We can then register the component in our providers.ts file:

When running the Admin UI, the component should now appear in the product detail page:

The detailForm property is an instance of the Angular FormGroup which can be used to manipulate the form fields, set the validity of the form, mark the form as dirty etc. For example, we could add a button which updates the description field of the product:

**Examples:**

Example 1 (ts):
```ts
import { Component, OnInit } from '@angular/core';import { Observable, switchMap } from 'rxjs';import { FormGroup } from '@angular/forms';import { DataService, CustomDetailComponent, SharedModule } from '@vendure/admin-ui/core';import { CmsDataService } from '../../providers/cms-data.service';@Component({    template: `        <vdr-card title="CMS Info">            <pre>{{ extraInfo$ | async | json }}</pre>        </vdr-card>`,    standalone: true,    providers: [CmsDataService],    imports: [SharedModule],})export class ProductInfoComponent implements CustomDetailComponent, OnInit {    // The
...
```

Example 2 (tsx):
```tsx
import React, { useEffect, useState } from 'react';import { Card, useDetailComponentData, useInjector } from '@vendure/admin-ui/react';import { CmsDataService } from '../providers/cms-data.service';export function ProductInfo() {    // The "entity" will vary depending on which detail page this component    // is embedded in. In this case, it will be a "product" entity.    const { entity, detailForm } = useDetailComponentData();    const cmsDataService = useInjector(CmsDataService);    const [extraInfo, setExtraInfo] = useState<any>();        useEffect(() => {        if (!entity?.id) {         
...
```

Example 3 (ts):
```ts
import { registerCustomDetailComponent } from '@vendure/admin-ui/core';import { ProductInfoComponent } from './components/product-info/product-info.component';export default [    registerCustomDetailComponent({        locationId: 'product-detail',        component: ProductInfoComponent,    }),];
```

Example 4 (ts):
```ts
import { registerReactCustomDetailComponent } from '@vendure/admin-ui/react';import { ProductInfo } from './components/ProductInfo';export default [    registerReactCustomDetailComponent({        locationId: 'product-detail',        component: ProductInfo,    }),];
```

---

## Creating Detail Views

**URL:** https://docs.vendure.io/guides/extending-the-admin-ui/creating-detail-views/

**Contents:**
- Creating Detail Views
- Example: Creating a Product Detail View​
  - Extend the TypedBaseDetailComponent class​
  - Create the template​
  - Route config​
- Supporting custom fields​

The two most common type of components you'll be creating in your UI extensions are list components and detail components.

In Vendure, we have standardized the way you write these components so that your ui extensions can be made to fit seamlessly into the rest of the app.

The specific pattern described here is for Angular-based components. It is also possible to create detail views using React components, but in that case you won't be able to use the built-in Angular-specific components.

Let's say you have a plugin which adds a new entity to the database called ProductReview. You have already created a list view, and now you need a detail view which can be used to view and edit individual reviews.

The detail component itself is an Angular component which extends the BaseDetailComponent or TypedBaseDetailComponent class.

This example assumes you have set up your project to use code generation as described in the GraphQL code generation guide.

Here is the standard layout for detail views:

Here's how the routing would look for a typical list & detail view:

From Vendure v2.2, it is possible for your custom entities to support custom fields.

If you have set up your entity to support custom fields, and you want custom fields to be available in the Admin UI detail view, you need to add the following to your detail component:

Then add a card for your custom fields to the template:

**Examples:**

Example 1 (ts):
```ts
import { ResultOf } from '@graphql-typed-document-node/core';import { ChangeDetectionStrategy, Component, OnInit, OnDestroy } from '@angular/core';import { FormBuilder } from '@angular/forms';import { TypedBaseDetailComponent, LanguageCode, NotificationService, SharedModule } from '@vendure/admin-ui/core';// This is the TypedDocumentNode & type generated by GraphQL Code Generatorimport { graphql } from '../../gql';export const reviewDetailFragment = graphql(`  fragment ReviewDetail on ProductReview {    id    createdAt    updatedAt    title    rating    text    authorName    productId  }`);exp
...
```

Example 2 (html):
```html
<vdr-page-block>    <vdr-action-bar>        <vdr-ab-left></vdr-ab-left>        <vdr-ab-right>            <button                class="button primary"                *ngIf="isNew$ | async; else updateButton"                (click)="create()"                [disabled]="detailForm.pristine || detailForm.invalid"            >                {{ 'common.create' | translate }}            </button>            <ng-template #updateButton>                <button                    class="btn btn-primary"                    (click)="update()"                    [disabled]="detailForm.pristine || detailFo
...
```

Example 3 (ts):
```ts
import { registerRouteComponent } from '@vendure/admin-ui/core';import { ReviewDetailComponent, getReviewDetailDocument } from './components/review-detail/review-detail.component';import { ReviewListComponent } from './components/review-list/review-list.component';export default [    // List view    registerRouteComponent({        path: '',        component: ReviewListComponent,        breadcrumb: 'Product reviews',    }),    // Detail view    registerRouteComponent({        path: ':id',        component: ReviewDetailComponent,        query: getReviewDetailDocument,        entityKey: 'productR
...
```

Example 4 (ts):
```ts
import { getCustomFieldsDefaults } from '@vendure/admin-ui/core';@Component({    selector: 'review-detail',    templateUrl: './review-detail.component.html',    styleUrls: ['./review-detail.component.scss'],    changeDetection: ChangeDetectionStrategy.OnPush,    standalone: true,    imports: [SharedModule],})export class ReviewDetailComponent extends TypedBaseDetailComponent<typeof getReviewDetailDocument, 'review'> implements OnInit, OnDestroy {    customFields = this.getCustomFieldConfig('ProductReview');    detailForm = this.formBuilder.group({        title: [''],        rating: [1],       
...
```

---

## Modify the Nav Menu

**URL:** https://docs.vendure.io/guides/extending-the-admin-ui/nav-menu/

**Contents:**
- Modify the Nav Menu
- Extending the NavMenu​
- Overriding existing nav items​
- Removing existing nav items​

The Nav Menu is the main navigation for the Admin UI, located on the left-hand side when in desktop mode. It is used to provide top-level access to routes in the app, and can be extended and modified by UI extensions.

Once you have defined some custom routes, you need some way for the administrator to access them. For this you will use the addNavMenuItem and addNavMenuSection functions.

Let's add a new section to the Admin UI main nav bar containing a link to the "greeter" module from the Getting Started guide example:

Now we must also register these providers with the compiler:

Running the server will compile our new shared module into the app, and the result should look like this:

It is also possible to override one of the default (built-in) nav menu sections or items. This can be useful for example if you wish to provide a completely different implementation of the product list view.

This is done by setting the id property to that of an existing nav menu section or item. The id can be found by inspecting the link element in your browser's dev tools for the data-item-id attribute:

If you would like to remove an existing nav item, you can do so by overriding it and setting the requiresPermission property to an invalid value:

**Examples:**

Example 1 (ts):
```ts
import { addNavMenuSection } from '@vendure/admin-ui/core';export default [    addNavMenuSection({        id: 'greeter',        label: 'My Extensions',        items: [{            id: 'greeter',            label: 'Greeter',            routerLink: ['/extensions/greet'],            // Icon can be any of https://core.clarity.design/foundation/icons/shapes/            icon: 'cursor-hand-open',        }],    },    // Add this section before the "settings" section    'settings'),];
```

Example 2 (ts):
```ts
import path from 'path';import { VendureConfig } from '@vendure/core';import { AdminUiPlugin } from '@vendure/admin-ui-plugin';import { compileUiExtensions } from '@vendure/ui-devkit/compiler';export const config: VendureConfig = {    // ...    plugins: [        AdminUiPlugin.init({            port: 3002,            app: compileUiExtensions({                outputPath: path.join(__dirname, '../admin-ui'),                extensions: [                    {                        id: 'greeter',                        extensionPath: path.join(__dirname, 'plugins/greeter/ui'),                      
...
```

Example 3 (ts):
```ts
import { SharedModule, addNavMenuItem} from '@vendure/admin-ui/core';export default [    addNavMenuItem({        id: 'collections',  // <-- we will override the "collections" menu item        label: 'Collections',        routerLink: ['/catalog', 'collections'],        // we use an invalid permission which ensures it is hidden from all users        requiresPermission: '__disable__'    },    'catalog'),];
```

---

## Listing Products

**URL:** https://docs.vendure.io/guides/storefront/listing-products/

**Contents:**
- Listing Products
- Listing products in a collection​
- Product search​
- Faceted search​
- Listing custom product data​

Products are listed when:

In Vendure, we usually use the search query for both of these. The reason is that the search query is optimized for high performance, because it is backed by a dedicated search index. Other queries such as products or Collection.productVariants can also be used to fetch a list of products, but they need to perform much more complex database queries, and are therefore slower.

Following on from the navigation example, let's assume that a customer has clicked on a collection item from the menu, and we want to display the products in that collection.

Typically, we will know the slug of the selected collection, so we can use the collection query to fetch the details of this collection:

The collection data can be used to render the page header.

Next, we can use the search query to fetch the products in the collection:

(the following data has been truncated for brevity)

The key thing to note here is that we are using the collectionSlug input to the search query. This ensures that the results all belong to the selected collection.

Here's a live demo of the above code in action:

The search query can also be used to perform a full-text search of the products in the catalog by passing the term input:

(the following data has been truncated for brevity)

You can also limit the full-text search to a specific collection by passing the collectionSlug or collectionId input.

The search query can also be used to perform faceted search. This is a powerful feature which allows customers to filter the results according to the facet values assigned to the products & variants.

By using the facetValues field, the search query will return a list of all the facet values which are present in the result set. This can be used to render a list of checkboxes or other UI elements which allow the customer to filter the results.

(the following data has been truncated for brevity)

These facet values can then be used to filter the results by passing them to the facetValueFilters input

For example, let's filter the results to only include products which have the "Nikkon" brand. Based on our last request we know that there should be 2 such products, and that the facetValue.id for the "Nikkon" brand is 11.

Here's how we can use this information to filter the results:

In the next example, rather than passing each individual variable (skip, take, term) as a separate argument, we are passing the entire SearchInput object as a variable. This allows us more flexibility in how we use the query, as we can easily add or remove properties from the input object without having to change the query itself.

**Combining Multiple Filters:**

Multiple facet value filters can be combined using `and` or `or` logic:

- **AND logic**: `{ "facetValueFilters": [{ "and": "9" }, { "and": "11" }] }` - Returns products that have BOTH facet values
- **OR logic**: `{ "facetValueFilters": [{ "or": ["11", "15"] }] }` - Returns products that have EITHER facet value

**Listing Custom Product Data:**

For custom fields on `Product` or `ProductVariant` entities, the basic `DefaultSearchPlugin` has limitations. This plugin is designed to be a minimal and simple search implementation and cannot index custom data.

The `ElasticsearchPlugin` serves as a powerful alternative, offering advanced features which allow you to index custom data. It functions as a drop-in replacement for the `DefaultSearchPlugin` - you can swap plugins in your `vendure-config.ts` configuration without extensive modifications.

**Examples:**

Example 1 (graphql):
```graphql
query GetCollection($slug: String!) {  collection(slug: $slug) {    id    name    slug    description    featuredAsset {      id      preview    }  }}
```

Example 2 (json):
```json
{  "slug": "electronics"}
```

Example 3 (json):
```json
{  "data": {    "collection": {      "id": "2",      "name": "Electronics",      "slug": "electronics",      "description": "",      "featuredAsset": {        "id": "16",        "preview": "https://demo.vendure.io/assets/preview/5b/jakob-owens-274337-unsplash__preview.jpg"      }    }  }}
```

Example 4 (graphql):
```graphql
query GetCollectionProducts($slug: String!, $skip: Int, $take: Int) {  search(    input: {      collectionSlug: $slug,      groupByProduct: true,      skip: $skip,      take: $take }  ) {    totalItems    items {      productName      slug      productAsset {        id        preview      }      priceWithTax {        ... on SinglePrice {          value        }        ... on PriceRange {          min          max        }      }      currencyCode    }  }}
```

---

## Custom History Timeline Components

**URL:** https://docs.vendure.io/guides/extending-the-admin-ui/custom-timeline-components/

**Contents:**
- Custom History Timeline Components

The Order & Customer detail pages feature a timeline of history entries. Since v1.9.0 it is possible to define custom history entry types - see the HistoryService docs for an example.

You can also define a custom Angular component to render any timeline entry using the registerHistoryEntryComponent function.

Currently it is only possible to define new tabs using Angular components.

Following the example used in the HistoryService docs, we can define a component to render the tax ID verification entry in our Customer timeline:

We can then register this component in the providers.ts file:

Then we need to add the providers.ts file to the uiExtensions array as described in the UI Extensions Getting Started guide.

**Examples:**

Example 1 (ts):
```ts
import { Component } from '@angular/core';import {    CustomerFragment,    CustomerHistoryEntryComponent,    SharedModule,    TimelineDisplayType,    TimelineHistoryEntry,} from '@vendure/admin-ui/core';@Component({    selector: 'tax-id-verification-entry',    template: `        <div *ngIf="entry.data.valid">            Tax ID <strong>{{ entry.data.taxId }}</strong> was verified            <vdr-history-entry-detail *ngIf="entry.data">                <vdr-object-tree [value]="entry.data"></vdr-object-tree>            </vdr-history-entry-detail>        </div>        <div *ngIf="!entry.data.valid
...
```

Example 2 (ts):
```ts
import { registerHistoryEntryComponent } from '@vendure/admin-ui/core';import { TaxIdHistoryEntryComponent } from './components/tax-id-history-entry/tax-id-history-entry.component';export default [    registerHistoryEntryComponent({        type: 'CUSTOMER_TAX_ID_VERIFICATION',        component: TaxIdHistoryEntryComponent,    }),];
```

---

## Bulk Actions for List Views

**URL:** https://docs.vendure.io/guides/extending-the-admin-ui/bulk-actions/

**Contents:**
- Bulk Actions for List Views
  - Bulk Action Example​
  - Conditionally displaying bulk actions​

List views in the Admin UI support bulk actions, which are performed on any selected items in the list. There are a default set of bulk actions that are defined by the Admin UI itself (e.g. delete, assign to channels), but using the @vendure/ui-devit package you are also able to define your own bulk actions.

Use cases for bulk actions include things like:

Bulk actions are declared using the registerBulkAction function

Sometimes a bulk action only makes sense in certain circumstances. For example, the "assign to channel" action only makes sense when your server has multiple channels set up.

We can conditionally control the display of a bulk action with the isVisible function, which should return a Promise resolving to a boolean:

**Examples:**

Example 1 (ts):
```ts
import { ModalService, registerBulkAction } from '@vendure/admin-ui/core';import { ProductDataTranslationService } from './product-data-translation.service';export default [    ProductDataTranslationService,    // Here is where we define our bulk action    // for sending the selected products to a 3rd-party    // translation API    registerBulkAction({        // This tells the Admin UI that this bulk action should be made        // available on the product list view.        location: 'product-list',        label: 'Send to translation service',        icon: 'language',        // Here is the log
...
```

Example 2 (ts):
```ts
import { registerBulkAction, DataService } from '@vendure/admin-ui/core';export default [    registerBulkAction({        location: 'product-list',        label: 'Assign to channel',        // Only display this action if there are multiple channels        isVisible: ({ injector }) => injector.get(DataService).client            .userStatus()            .mapSingle(({ userStatus }) => 1 < userStatus.channels.length)            .toPromise(),        // ...    }),];
```

---

## Defining routes

**URL:** https://docs.vendure.io/guides/extending-the-admin-ui/defining-routes/

**Contents:**
- Defining routes
- Example: Creating a "Greeter" route​
  - 1. Create a plugin​
  - 2. Create the route component​
  - 3. Define the route​
  - 4. Add the route to the extension config​
  - 5. Test it out​
- Links​
- Route parameters​
- Injecting services​

Routes allow you to mount entirely custom components at a given URL in the Admin UI. New routes will appear in this area of the Admin UI:

Routes can be defined natively using either Angular or React. It is also possible to use other frameworks in a more limited capacity.

We will first quickly scaffold a new plugin to house our UI extensions:

You should now have a new plugin scaffolded at ./src/plugins/greeter, with some empty UI extension files in the ui directory. If you check your vendure-config.ts file you should also see that your AdminUiPlugin.init() call has been modified to compile the UI extensions:

First we need to create the component which will be mounted at the route. This component can be either an Angular component or a React component.

The <vdr-page-block> (Angular) and <div className="page-block"> (React) is a wrapper that sets the layout and max width of your component to match the rest of the Admin UI. You should usually wrap your component in this element.

Next we need to define a route in our routes.ts file. Note that this file can have any name, but "routes.ts" is a convention.

Using registerRouteComponent you can define a new route based on an Angular component.

Here's the equivalent example using React and registerReactRouteComponent:

The path: '' is actually optional, since '' is the default value. But this is included here to show that you can mount different components at different paths. See the section on route parameters below.

Since you have used the CLI to scaffold your plugin, this part has already been done for you. But for the sake of completeness this is the part of your plugin which is configured to point to your routes file:

Note that by specifying route: 'greeter', we are "mounting" the routes at the /extensions/greeter path.

The /extensions/ prefix is used to avoid conflicts with built-in routes. From Vendure v2.2.0 it is possible to customize this prefix using the prefix property. See the section on overriding built-in routes for more information.

The filePath property is relative to the directory specified in the extensionPath property. In this case, the routes.ts file is located at src/plugins/greeter/ui/routes.ts.

Now run your app with npm run dev. Wait for it to compile the Admin UI extensions.

Now go to the Admin UI app in your browser and log in. You should now be able to manually enter the URL http://localhost:3000/admin/extensions/greeter and you should see the component with the "Hello!" header displayed.

**Links:**

For navigation between pages, Angular uses the `[routerLink]` directive while React uses a `Link` component. Paths should be prefixed with `/extensions/`.

**Route Parameters:**

Routes can accept dynamic parameters using colon notation (e.g., `:id`). Angular components access these via `ActivatedRoute`, while React components use the `useRouteParams()` hook to retrieve parameter values.

**Injecting Services:**

The Admin UI provides built-in services like `NotificationService`. Angular uses constructor injection or the `inject()` function, whereas React applications use the `useInjector()` hook to access services.

**Page Metadata:**

The `PageMetadataService` (Angular) and `usePageMetadata()` hook (React) allow dynamic updates to page titles and breadcrumbs during component lifecycle.

**Advanced: Overriding Built-in Routes:**

From version 2.2.0 onward, developers can override built-in routes by setting the prefix to an empty string and matching existing route paths. This enables complete customization of default Admin UI pages.

**Examples:**

Example 1 (ts):
```ts
AdminUiPlugin.init({    route: 'admin',    port: serverPort + 2,    adminUiConfig: {        apiPort: serverPort,    },    app: compileUiExtensions({        outputPath: path.join(__dirname, '../admin-ui'),        extensions: [            GreeterPlugin.ui,        ],        devMode: true,    }),}),
```

Example 2 (ts):
```ts
import { SharedModule } from '@vendure/admin-ui/core';import { Component } from '@angular/core';@Component({    selector: 'greeter',    template: `        <vdr-page-block>            <h2>{{ greeting }}</h2>        </vdr-page-block>`,    standalone: true,    imports: [SharedModule],})export class GreeterComponent {    greeting = 'Hello!';}
```

Example 3 (ts):
```ts
import React from 'react';export function Greeter() {    const greeting = 'Hello!';    return (        <div className="page-block">            <h2>{greeting}</h2>        </div>    );}
```

Example 4 (ts):
```ts
import { registerRouteComponent } from '@vendure/admin-ui/core';import { GreeterComponent } from './components/greeter/greeter.component';export default [    registerRouteComponent({        component: GreeterComponent,        path: '',        title: 'Greeter Page',        breadcrumb: 'Greeter',    }),];
```

---

## Dashboard Widgets

**URL:** https://docs.vendure.io/guides/extending-the-admin-ui/dashboard-widgets/

**Contents:**
- Dashboard Widgets
- Example: Reviews Widget​
  - Create the widget​
  - Register the widget​
- Setting the default widget layout​
- Overriding default widgets​

Dashboard widgets are components which can be added to the Admin UI dashboard. These widgets are useful for displaying information which is commonly required by administrations, such as sales summaries, lists of incomplete orders, notifications, etc.

The Admin UI comes with a handful of widgets, and you can also create your own widgets.

Currently it is only possible to define new widgets using Angular components.

In this example we will use a hypothetical reviews plugin, which allows customers to write product reviews. These reviews then get approved by an Administrator before being displayed in the storefront.

To notify administrators about new reviews that need approval, we'll create a dashboard widget.

A dashboard widget is an Angular component. This example features a simplified UI, just to illustrate the overall structure:

We also need to define an NgModule for this component. This is because we will be lazy-loading the component at run-time, and the NgModule is required for us to use shared providers (e.g. DataService) and any shared components, directives or pipes defined in the @vendure/admin-ui/core package.

Our widget now needs to be registered in our providers file:

Once registered, the reviews widget will be available to select by administrators with the appropriate permissions.

While administrators can customize which widgets they want to display on the dashboard, and the layout of those widgets, you can also set a default layout:

This defines the order of widgets with their default widths. The actual layout in terms of rows and columns will be calculated at run-time based on what will fit on each row.

The Admin UI comes with a set of default widgets, such as the order summary and latest orders widgets (they can be found in the default-widgets.ts file).

Sometimes you may wish to alter the permissions settings of the default widgets to better control which of your Administrators is able to access it.

For example, the "order summary" widget has a default permission requirement of "ReadOrder". If you want to limit the availability to e.g. the SuperAdmin role, you can do so by overriding the definition like this:

**Examples:**

Example 1 (ts):
```ts
import { Component, OnInit } from '@angular/core';import { DataService, SharedModule } from '@vendure/admin-ui/core';import { Observable } from 'rxjs';@Component({    selector: 'reviews-widget',    template: `        <ul>            <li *ngFor="let review of pendingReviews$ | async">                <a [routerLink]="['/extensions', 'product-reviews', review.id]">{{ review.summary }}</a>                <span class="rating">{{ review.rating }} / 5</span>            </li>        </ul>    `,    standalone: true,    imports: [SharedModule],})export class ReviewsWidgetComponent implements OnInit {   
...
```

Example 2 (ts):
```ts
import { registerDashboardWidget } from '@vendure/admin-ui/core';export default [    registerDashboardWidget('reviews', {        title: 'Latest reviews',        supportedWidths: [4, 6, 8, 12],        requiresPermissions: ['ReadReview'],        loadComponent: () =>            import('./reviews-widget/reviews-widget.component').then(                m => m.ReviewsWidgetComponent,            ),    }),];
```

Example 3 (ts):
```ts
import { registerDashboardWidget, setDashboardWidgetLayout } from '@vendure/admin-ui/core';export default [    registerDashboardWidget('reviews', {        // omitted for brevity    }),    setDashboardWidgetLayout([        { id: 'welcome', width: 12 },        { id: 'orderSummary', width: 4 },        { id: 'latestOrders', width: 8 },        { id: 'reviews', width: 6 },    ]),];
```

Example 4 (ts):
```ts
import { registerDashboardWidget } from '@vendure/admin-ui/core';import { OrderSummaryWidgetComponent } from '@vendure/admin-ui/dashboard';export default [    registerDashboardWidget('orderSummary', {        title: 'dashboard.orders-summary',        loadComponent: () => OrderSummaryWidgetComponent,        requiresPermissions: ['SuperAdmin'],    }),];
```

---

## Page ActionBar Buttons

**URL:** https://docs.vendure.io/guides/extending-the-admin-ui/add-actions-to-pages/

**Contents:**
- Page ActionBar Buttons
- ActionBar button example​
- ActionBar dropdown menu example​
- Handling button clicks​
  - Using routerLink​
  - Using onClick​
- Setting visibility & disabled state​
- Restricting access by permissions​

The ActionBar is the horizontal area at the top of each list or detail page, which contains the main buttons for that page. This guide explains how to add new buttons and dropdown menu items to the ActionBar.

For example, consider an "order invoice" extension that allows you to print invoices for orders. You can add a "print invoice" button to the ActionBar of the order detail page, either as a button or as a dropdown menu item.

Adding a button is done using the addActionBarItem function.

In each list or detail view in the app, the ActionBar has a unique locationId which is how the app knows in which view to place your button. The complete list of available locations into which you can add new ActionBar can be found in the PageLocationId docs. You can also press ctrl + u when in development mode to see the location of all UI extension points.

Vendure v2.2.0 introduced the ability to add dropdown menu items to the ActionBar. If you want to add an action which is less commonly used, or want to take up less space in the action bar, then a dropdown menu item is a good choice. This is done using the addActionBarDropdownMenuItem function.

Let's re-work the "print invoice" button example to display it instead as a dropdown menu item:

There are two ways to handle the click event of an ActionBar button or dropdown menu item:

The routerLink property allows you to specify a route to navigate to when the button is clicked. The route can be a constant value, or it can be a function which receives the current route as well as a context object as arguments.

The onClick property of the addActionBarItem function allows you to define a function that will be executed when the ActionBar button is clicked. This function receives two arguments: the click event and the current context.

The context object provides access to commonly-used services, which allows you to perform GraphQL queries and mutations, and the current route, which can be used to get parameters from the URL.

Here's an example of how to use the onClick property to perform a GraphQL mutation when the ActionBar button is clicked:

In this example, clicking the ActionBar button triggers a GraphQL mutation. The context.dataService is utilized to execute the mutation. It can also be employed to retrieve additional information about the current order if needed. The context.route is used to extract the ID of the current order from the URL.

The utility function `firstValueFrom` from the RxJS library is used to convert Observables to Promises. This conversion allows the use of the `await` keyword to pause execution until the Observable emits its first value or completes.

**Setting Visibility & Disabled State:**

The `buttonState` function lets developers manage visibility and disabled status through Observable streams, with access to entity data via `context.entity$`. This enables dynamic button behavior based on the current state of the page.

**Restricting Access by Permissions:**

The `requiresPermission` property restricts button visibility to users holding specified permissions. This ensures that only authorized users can see and interact with certain ActionBar buttons.

**Dropdown Menu Items:**

Introduced in v2.2.0, the `addActionBarDropdownMenuItem` function provides a space-efficient alternative to regular buttons. Dropdown items support optional visual dividers using the `hasDivider` property for better organization.

**Examples:**

Example 1 (ts):
```ts
import { addActionBarItem } from '@vendure/admin-ui/core';export default [    addActionBarItem({        id: 'print-invoice',        locationId: 'order-detail',        label: 'Print invoice',        icon: 'printer',        routerLink: route => {            const id = route.snapshot.params.id;            return ['./extensions/order-invoices', id];        },        requiresPermission: 'ReadOrder',    }),];
```

Example 2 (ts):
```ts
import { addActionBarDropdownMenuItem } from '@vendure/admin-ui/core';export default [    addActionBarDropdownMenuItem({        id: 'print-invoice',        locationId: 'order-detail',        label: 'Print invoice',        icon: 'printer',        routerLink: route => {            const id = route.snapshot.params.id;            return ['./extensions/order-invoices', id];        },        requiresPermission: 'ReadOrder',        // When set to `true`, a horizontal divider will be        // displayed above this item in the dropdown menu.        hasDivider: true,    }),];
```

Example 3 (ts):
```ts
import { addActionBarItem } from '@vendure/admin-ui/core';export default [    addActionBarItem({        id: 'print-invoice',        label: 'Print invoice',        locationId: 'order-detail',        // The route can be a constant value...        routerLink: ['./extensions/order-invoices'],    }),];
```

Example 4 (ts):
```ts
import { addActionBarItem } from '@vendure/admin-ui/core';export default [    addActionBarItem({        id: 'print-invoice',        label: 'Print invoice',        locationId: 'order-detail',        // The route can be a function        routerLink: route => {            const id = route.snapshot.params.id;            return ['./extensions/order-invoices', id];        },    }),];
```

---

## Alerts

**URL:** https://docs.vendure.io/guides/extending-the-admin-ui/alerts/

**Contents:**
- Alerts

Alerts appear in the top bar of the Admin UI and provide a way of notifying the administrator of important information that may require action.

You can define custom alerts with the registerAlert function.

Let's say you have a custom order process where certain orders require manual review & approval. You could define an alert to notify the administrator when there are orders that require review:

With this example, a check will be performed every 60 seconds to see if there are any orders requiring approval. The actual implementation of the check is left to the ManualOrderReviewService which in this case would make a request to the Vendure server to fetch the required data.

If there are orders requiring approval, the alert will appear in the Admin UI like this:

**Examples:**

Example 1 (ts):
```ts
import { registerAlert } from '@vendure/admin-ui/core';import { Router } from '@angular/router';import { interval } from 'rxjs';import { ManualOrderReviewService } from './providers/manual-order-review.service';export default [    ManualOrderReviewService,    registerAlert({        id: 'orders-require-approval',        // This function is responsible for fetching the data needed to determine        // whether the alert should be displayed.        check: ({ injector }) => {            const manualOrderReviewService = injector.get(ManualOrderReviewService);            return manualOrderReviewSer
...
```

---

## Custom DataTable Components

**URL:** https://docs.vendure.io/guides/extending-the-admin-ui/custom-data-table-components/

**Contents:**
- Custom DataTable Components
  - 1. Define a component​
  - 2. Register the component​

The Admin UI list views are powered by a data table component which features sorting, advanced filtering, pagination and more. It will also give you the option of displaying any configured custom fields for the entity in question.

With Admin UI extensions, you can specify custom components to use in rendering any column of any data table - both custom fields and built-in fields, using either Angular or React components.

Let's say we want to make the product "slug" column link to the matching product detail page in our storefront.

First we'll define the component we will use to render the "slug" column:

Angular components will receive the value of the current column as the rowItem input. In this case, the rowItem will be the Product entity, because we will be adding this to the product list data table.

React components will receive the value of the current column as the rowItem prop. In this case, the rowItem will be the Product entity, because we will be adding this to the product list data table.

Next we need to register the component in out providers.ts file. We need to pass both a tableId and a columnId to identify the table and column to which the component should be added. The values for these IDs can be found by pressing the ctrl + u shortcut when the Admin UI is in dev mode, and then clicking the extension point icon at the top of the column in question:

In this case we want to target the product-list table and the slug column.

When running the Admin UI, the product list slug should now be rendered as a link:

**Examples:**

Example 1 (ts):
```ts
import { Component, Input } from '@angular/core';import { CustomColumnComponent } from '@vendure/admin-ui/core';@Component({    selector: 'slug-link',    template: `        <a [href]="'https://example.com/products/' + rowItem.slug" target="_blank">{{ rowItem.slug }}</a>    `,    standalone: true,})export class SlugLinkComponent implements CustomColumnComponent {    @Input() rowItem: { slug: string };}
```

Example 2 (tsx):
```tsx
import { ReactDataTableComponentProps } from '@vendure/admin-ui/react';import React from 'react';export function SlugLink({ rowItem }: ReactDataTableComponentProps<{ slug: string }>) {    const slug = rowItem.slug;    return (        <a href={`https://example.com/category/${slug}`} target="_blank">            {slug}        </a>    );}
```

Example 3 (ts):
```ts
import { registerDataTableComponent } from '@vendure/admin-ui/core';import { SlugLinkComponent } from './components/slug-link/slug-link.component';export default [    registerDataTableComponent({        component: SlugWithLinkComponent,        tableId: 'product-list',        columnId: 'slug',    }),];
```

Example 4 (ts):
```ts
import { registerReactDataTableComponent } from '@vendure/admin-ui/react';import { SlugLink } from './components/SlugLink';export default [    registerReactDataTableComponent({        component: SlugWithLink,        tableId: 'product-list',        columnId: 'slug',        props: {            // Additional props may be passed to the component            foo: 'bar',        },    }),];
```

---

## Using Other Frameworks

**URL:** https://docs.vendure.io/guides/extending-the-admin-ui/using-other-frameworks/

**Contents:**
- Using Other Frameworks
- 1. Install @vendure/ui-devkit​
- 2. Create the folder structure​
- 3. Create an extension module​
- 4. Define the AdminUiExtension config​
- 5. Build your extension​
- Integrate with the Admin UI​
  - Styling​
  - UiDevkitClient​
    - setTargetOrigin​

From version 2.1.0, Admin UI extensions can be written in either Angular or React. Prior to v2.1.0, only Angular was natively supported.

It is, however, possible to extend the Admin UI using other frameworks such as Vue, Svelte, Solid etc. Note that the extension experience is much more limited than with Angular or React, but depending on your needs it may be sufficient.

For working examples of a UI extensions built with Vue, see the real-world-vendure ui extensions

There is still a small amount of Angular "glue code" needed to let the compiler know how to integrate your extension, so let's take a look at how this is done.

To create UI extensions, you'll need to install the @vendure/ui-devkit package. This package contains a compiler for building your customized version of the Admin UI, as well as the Angular dependencies you'll need to create your extensions.

In this example, we will work with the following folder structure, and use Create React App our example.

Here's the Angular code needed to tell the compiler where to find your extension:

Next we will define an AdminUiExtension object which is passed to the compileUiExtensions() function in your Vendure config:

To ensure things are working we can now build our Vue app by running yarn build in the vue-app directory. This will build and output the app artifacts to the vue-app/build directory - the one we pointed to in the staticAssets array above.

Once build, we can start the Vendure server.

The compileUiExtensions() function returns a compile() function which will be invoked by the AdminUiPlugin upon server bootstrap. During this compilation process, a new directory will be generated at /admin-ui (as specified by the outputPath option) which will contains the un-compiled sources of your new Admin UI app.

Next, these source files will be run through the Angular compiler, the output of which will be visible in the console.

Now go to the Admin UI app in your browser and log in. You should now be able to manually enter the URL http://localhost:3000/admin/extensions/vue-ui and you should see the Vue app rendered in the Admin UI.

The @vendure/admin-ui package (which will be installed alongside the ui-devkit) provides a stylesheet to allow your extension to fit visually with the rest of the Admin UI.

If you have a build step, you can import it into your app like this:

If your extension does not have a build step, you can still include the theme stylesheet as a local resource:

```html
<link rel="stylesheet" href="/admin/assets/styles/theme.css">
```

**UiDevkitClient:**

The `@vendure/ui-devkit` package provides helper methods for extensions to interact with the Admin UI infrastructure through the UiDevkitClient. This client enables extensions to:

- Execute GraphQL queries and mutations without requiring a separate HTTP or GraphQL client, benefiting from the Admin UI's client-side caching
- Display toast notifications to users

**setTargetOrigin:**

The UiDevkitClient uses the browser's postMessage API to facilitate communication between the Admin UI and your extension. Due to security constraints, this channel restricts communication to a specific domain where your extension operates.

To configure this, use the `setTargetOrigin` function:

```javascript
setTargetOrigin('http://my-domain.com');
```

If misconfigured, you'll encounter an error message regarding postMessage execution failure on DOMWindow.

**Usage Approaches:**

For applications with build processes, you can import and use functions directly:

```javascript
import { graphQlMutation, notify } from '@vendure/ui-devkit';
```

For extensions without build steps, the UiDevkitClient can be included as a local resource, exposing a `VendureUiClient` global object accessible in plain JavaScript.

**Examples:**

Example 1 (bash):
```bash
yarn add @vendure/ui-devkit
# or
npm install @vendure/ui-devkit
```

Example 2 (text):
```text
src└─plugins  └─ my-plugin    └─ ui      ├─ routes.ts      └─ vue-app        └─ (directory created by `vue create`, for example)
```

Example 3 (ts):
```ts
import { hostExternalFrame } from '@vendure/admin-ui/core';export default [    hostExternalFrame({        path: '',        // You can also use parameters which allow the app        // to have dynamic routing, e.g.        // path: ':slug'        // Then you can use the getActivatedRoute() function from the        // UiDevkitClient in order to access the value of the "slug"        // parameter.        breadcrumbLabel: 'Vue App',        // This is the URL to the compiled React app index.        // The next step will explain the "assets/react-app" path.        extensionUrl: './assets/vue-app/index
...
```

Example 4 (ts):
```ts
import path from 'path';import { VendureConfig } from '@vendure/core';import { AdminUiPlugin } from '@vendure/admin-ui-plugin';import { compileUiExtensions } from '@vendure/ui-devkit/compiler';export const config: VendureConfig = {    // ...    plugins: [        AdminUiPlugin.init({            route: 'admin',            port: 3002,            app: compileUiExtensions({                outputPath: path.join(__dirname, '../admin-ui'),                extensions: [{                    // Points to the path containing our Angular "glue code" module                    extensionPath: path.join(__dirna
...
```

---

## Managing the Active Order

**URL:** https://docs.vendure.io/guides/storefront/active-order/

**Contents:**
- Managing the Active Order
- Define an Order fragment​
- Get the active order​
- Add an item​
- Remove an item​
- Change the quantity of an item​
- Applying a coupon code​
- Removing a coupon code​
- Live example​

The "active order" is what is also known as the "cart" - it is the order that is currently being worked on by the customer.

An order remains active until it is completed, and during this time it can be modified by the customer in various ways:

This guide will cover how to manage the active order.

Since all the mutations that we will be using in this guide require an Order object, we will define a fragment that we can reuse in all of our mutations.

The __typename field is used to determine the type of the object returned by the GraphQL server. In this case, it will always be 'Order'.

Some GraphQL clients such as Apollo Client will automatically add the __typename field to all queries and mutations, but if you are using a different client you may need to add it manually.

This fragment can then be used in subsequent queries and mutations by using the ... spread operator in the place where an Order object is expected. You can then embed the fragment in the query or mutation by using the ${ACTIVE_ORDER_FRAGMENT} syntax:

For the remainder of this guide, we will list just the body of the query or mutation, and assume that the fragment is defined and imported as above.

This fragment can then be used in subsequent queries and mutations. Let's start with a query to get the active order using the activeOrder query:

To add an item to the active order, we use the addItemToOrder mutation, as we have seen in the Product Detail Page guide.

If you have defined any custom fields on the OrderLine entity, you will be able to pass them as a customFields argument to the addItemToOrder mutation. See the Configurable Products guide for more information.

To remove an item from the active order, we use the removeOrderLine mutation, and pass the id of the OrderLine to remove.

To change the quantity of an item in the active order, we use the adjustOrderLine mutation.

If you have defined any custom fields on the OrderLine entity, you will be able to update their values by passing a customFields argument to the adjustOrderLine mutation. See the Configurable Products guide for more information.

If you have defined any Promotions which use coupon codes, you can apply the a coupon code to the active order using the applyCouponCode mutation.

To remove a coupon code from the active order, we use the removeCouponCode mutation.

Here is a live example which demonstrates adding, updating and removing items from the active order:

**Examples:**

Example 1 (ts):
```ts
const ACTIVE_ORDER_FRAGMENT = /*GraphQL*/`fragment ActiveOrder on Order {  __typename  id  code  couponCodes  state  currencyCode  totalQuantity  subTotalWithTax  shippingWithTax  totalWithTax  discounts {    description    amountWithTax  }  lines {    id    unitPriceWithTax    quantity    linePriceWithTax    productVariant {      id      name      sku    }    featuredAsset {      id      preview    }  }  shippingLines {    shippingMethod {      description    }    priceWithTax  }}`
```

Example 2 (ts):
```ts
import { ACTIVE_ORDER_FRAGMENT } from './fragments';export const GET_ACTIVE_ORDER = /*GraphQL*/`  query GetActiveOrder {    activeOrder {      ...ActiveOrder    }  }  ${ACTIVE_ORDER_FRAGMENT}`;
```

Example 3 (graphql):
```graphql
query GetActiveOrder {  activeOrder {    ...ActiveOrder  }}
```

Example 4 (graphql):
```graphql
mutation AddItemToOrder($productVariantId: ID!, $quantity: Int!) {  addItemToOrder(productVariantId: $productVariantId, quantity: $quantity) {    ...ActiveOrder    ... on ErrorResult {      errorCode      message    }    ... on InsufficientStockError {      quantityAvailable      order {        ...ActiveOrder      }    }  }}
```

---

## Product Detail Page

**URL:** https://docs.vendure.io/guides/storefront/product-detail/

**Contents:**
- Product Detail Page
- Fetching product data​
- Formatting prices​
- Displaying images​
- Adding to the order​
- Live example​

The product detail page (often abbreviated to PDP) is the page that shows the details of a product and allows the user to add it to their cart.

Typically, the PDP should include:

Let's create a query to fetch the required data. You should have either the product's slug or id available from the url. We'll use the slug in this example.

This single query provides all the data we need to display our PDP.

As explained in the Money & Currency guide, the prices are returned as integers in the smallest unit of the currency (e.g. cents for USD). Therefore, when we display the price, we need to divide by 100 and format it according to the currency's formatting rules.

In the demo at the end of this guide, we'll use the formatCurrency function which makes use of the browser's Intl API to format the price according to the user's locale.

If we are using the AssetServerPlugin to serve our product images (as is the default), then we can take advantage of the dynamic image transformation abilities in order to display the product images in the correct size and in and optimized format such as WebP.

This is done by appending a query string to the image URL. For example, if we want to use the 'large' size preset (800 x 800) and convert the format to WebP, we'd use a url like this:

An even more sophisticated approach would be to make use of the HTML <picture> element to provide multiple image sources so that the browser can select the optimal format. This can be wrapped in a component to make it easier to use. For example:

To add a particular product variant to the order, we need to call the addItemToOrder mutation. This mutation takes the productVariantId and the quantity as arguments.

There are some important things to note about this mutation:

Here's an example that brings together all of the above concepts:

**Examples:**

Example 1 (graphql):
```graphql
query GetProductDetail($slug: String!) {  product(slug: $slug) {    id    name    description    featuredAsset {      id      preview    }    assets {      id      preview    }    variants {      id      name      sku      stockLevel      currencyCode      price      priceWithTax      featuredAsset {        id        preview      }      assets {        id        preview      }    }  }}
```

Example 2 (json):
```json
{  "slug": "laptop"}
```

Example 3 (json):
```json
{  "data": {    "product": {      "id": "1",      "name": "Laptop",      "description": "Now equipped with seventh-generation Intel Core processors, Laptop is snappier than ever. From daily tasks like launching apps and opening files to more advanced computing, you can power through your day thanks to faster SSDs and Turbo Boost processing up to 3.6GHz.",      "featuredAsset": {        "id": "1",        "preview": "https://demo.vendure.io/assets/preview/71/derick-david-409858-unsplash__preview.jpg"      },      "assets": [        {          "id": "1",          "preview": "https://demo.vendure.
...
```

Example 4 (tsx):
```tsx
<img src={product.featuredAsset.preview + '?preset=large&format=webp'} />
```

---

## Customer Accounts

**URL:** https://docs.vendure.io/guides/storefront/customer-accounts/

**Contents:**
- Customer Accounts
- Querying the active customer​
- Logging in and out​
- Registering a customer account​
- Password reset​

Customers can register accounts and thereby gain the ability to:

The activeCustomer query will return a Customer object if the customer is registered and logged in, otherwise it will return null. This can be used in the storefront header for example to determine whether to display a "sign in" or "my account" link.

The login mutation is used to attempt to log in using email address and password. Given correct credentials, a new authenticated session will begin for that customer.

The logout mutation will end an authenticated customer session.

The login mutation, as well as the following mutations related to registration & password recovery only apply when using the built-in NativeAuthenticationStrategy.

If you are using alternative authentication strategies in your storefront, you would use the authenticate mutation as covered in the External Authentication guide.

The registerCustomerAccount mutation is used to register a new customer account.

There are three possible registration flows: If authOptions.requireVerification is set to true (the default):

If authOptions.requireVerification is set to false:

Here's a diagram of the second scenario, where the password is supplied during the verification step.

Here's how the mutations would look for the above flow:

Note that in the variables above, we did not specify a password, as this will be done at the verification step. If a password does get passed at this step, then it won't be needed at the verification step. This is a decision you can make based on the desired user experience of your storefront.

Upon registration, the EmailPlugin will generate an email to the customer containing a link to the verification page. In a default Vendure installation this is set in the vendure config file:

The verification page needs to get the token from the query string, and pass it to the verifyCustomerAccount mutation:

Here's how to implement a password reset flow. It is conceptually very similar to the verification flow described above.

A password reset is triggered by the requestPasswordReset mutation:

Again, this mutation will trigger an event which the EmailPlugin's default email handlers will pick up and send an email to the customer. The password reset page then needs to get the token from the url and pass it to the resetPassword mutation:

**Examples:**

Example 1 (graphql):
```graphql
query GetCustomerAddresses {  activeCustomer {    id    title    firstName    lastName    emailAddress  }}
```

Example 2 (json):
```json
{  "data": {    "activeCustomer": {      "id": "12345",      "title": "Mr.",      "firstName": "John",      "lastName": "Doe",      "emailAddress": "john.doe@email.com"    }  }}
```

Example 3 (graphql):
```graphql
mutation LogIn($emailAddress: String!, $password: String!, $rememberMe: Boolean!) {  login(username: $emailAddress, password: $password, rememberMe: $rememberMe) {    ... on  CurrentUser {      id      identifier    }    ... on ErrorResult {      errorCode      message    }  }}
```

Example 4 (json):
```json
{  "emailAddress": "john.doe@email.com",  "password": "**********",  "rememberMe": true,}
```

---

## Navigation Menu

**URL:** https://docs.vendure.io/guides/storefront/navigation-menu/

**Contents:**
- Navigation Menu
- Building a navigation tree​
- Live example​

A navigation menu allows your customers to navigate your store and find the products they are looking for.

Typically, navigation is based on a hierarchy of collections. We can get the top-level collections using the collections query with the topLevelOnly filter:

The collections query returns a flat list of collections, but we often want to display them in a tree-like structure. This way, we can build up a navigation menu which reflects the hierarchy of collections.

First of all we need to ensure that we have the parentId property on each collection.

Then we can use this data to build up a tree structure. The following code snippet shows how this can be done in TypeScript:

Here's a live demo of the above code in action:

**Examples:**

Example 1 (graphql):
```graphql
query GetTopLevelCollections {  collections(options: { topLevelOnly: true }) {    items {      id      slug      name      featuredAsset {        id        preview      }    }  }}
```

Example 2 (json):
```json
{  "data": {    "collections": {      "items": [        {          "id": "2",          "slug": "electronics",          "name": "Electronics",          "featuredAsset": {            "id": "16",            "preview": "https://demo.vendure.io/assets/preview/5b/jakob-owens-274337-unsplash__preview.jpg"          }        },        {          "id": "5",          "slug": "home-garden",          "name": "Home & Garden",          "featuredAsset": {            "id": "47",            "preview": "https://demo.vendure.io/assets/preview/3e/paul-weaver-1120584-unsplash__preview.jpg"          }        },     
...
```

Example 3 (graphql):
```graphql
query GetAllCollections {  collections(options: { topLevelOnly: true }) {    items {      id      slug      name      parentId      featuredAsset {        id        preview      }    }  }}
```

Example 4 (ts):
```ts
export type HasParent = { id: string; parentId: string | null };export type TreeNode<T extends HasParent> = T & {    children: Array<TreeNode<T>>;};export type RootNode<T extends HasParent> = {    id?: string;    children: Array<TreeNode<T>>;};/** * Builds a tree from an array of nodes which have a parent. * Based on https://stackoverflow.com/a/31247960/772859, modified to preserve ordering. */export function arrayToTree<T extends HasParent>(nodes: T[]): RootNode<T> {    const topLevelNodes: Array<TreeNode<T>> = [];    const mappedArr: { [id: string]: TreeNode<T> } = {};    // First map the no
...
```

---

## Deploying the Admin UI

**URL:** https://docs.vendure.io/guides/deployment/deploying-admin-ui

**Contents:**
- Deploying the Admin UI
- Compiling the Admin UI​
- Setting the API host & port​
- Deploying a stand-alone Admin UI​
    - Metrics​
    - Example Script​

If you have customized the Admin UI with extensions, you should compile your custom Admin UI app ahead of time before deploying it. This will bundle the app into a set of static files which are then served by the AdminUiPlugin.

It is not recommended to compile the Admin UI on the server at runtime, as this can be slow and resource-intensive. Instead, compile the Admin UI ahead of time and deploy the compiled assets, as covered in the guide linked above.

When running in development mode, the Admin UI app will "guess" the API host and port based on the current URL in the browser. Typically, this will be http://localhost:3000. For production deployments where the Admin UI app is served from a different host or port than the Vendure server, you'll need to configure the Admin UI app to point to the correct API host and port.

Usually, the Admin UI is served from the Vendure server via the AdminUiPlugin. However, you may wish to deploy the Admin UI app elsewhere. Since it is just a static Angular app, it can be deployed to any static hosting service such as Vercel or Netlify.

The AdminUiPlugin not only serves the Admin UI app, but also provides a metricSummary query which is used to display the order metrics on the dashboard. If you wish to deploy the Admin UI app stand-alone (not served by the AdminUiPlugin), but still want to display the metrics on the dashboard, you'll need to include the AdminUiPlugin in your server's plugins array, but do not call init():

Here's an example script that can be run as part of your host's build command, which will generate a stand-alone app bundle and configure it to point to your remote server API.

This example is for Vercel, and assumes:

**Examples:**

Example 1 (ts):
```ts
import { VendureConfig } from '@vendure/core';import { AdminUiPlugin } from '@vendure/admin-ui-plugin';const config: VendureConfig = {    // ...    plugins: [        AdminUiPlugin.init({            port: 3001,            route: 'admin',            adminUiConfig: {                apiHost: 'https://api.example.com',                apiPort: 443,            },        }),    ],};
```

Example 2 (ts):
```ts
import { AdminUiPlugin } from '@vendure/admin-ui-plugin';const config: VendureConfig = {    plugins: [        AdminUiPlugin, // <== include the plugin, but don't call init()    ],    // ...};
```

Example 3 (json):
```json
{  "name": "standalone-admin-ui",  "version": "0.1.0",  "private": true,  "scripts": {    "build": "ts-node compile.ts"  },  "devDependencies": {    "@vendure/ui-devkit": "^1.4.5",    "ts-node": "^10.2.1",    "typescript": "~4.3.5"  }}
```

Example 4 (ts):
```ts
import { compileUiExtensions } from '@vendure/ui-devkit/compiler';import { DEFAULT_BASE_HREF } from '@vendure/ui-devkit/compiler/constants';import path from 'path';import { promises as fs } from 'fs';/** * Compiles the Admin UI. If the BASE_HREF is defined, use that. * Otherwise, go back to the default admin route. */compileUiExtensions({    outputPath: path.join(__dirname, 'build'),    baseHref: process.env.BASE_HREF ?? DEFAULT_BASE_HREF,    extensions: [        /* any UI extensions would go here, or leave empty */    ],})    .compile?.()    .then(() => {        // If building for Vercel depl
...
```

---
