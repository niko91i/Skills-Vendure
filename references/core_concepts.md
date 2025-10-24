# Vendure - Core Concepts

**Pages:** 16

---

## Collections

**URL:** https://docs.vendure.io/guides/core-concepts/collections

**Contents:**
- Collections
- Collection filters​
  - Filter inheritance​
  - Creating a collection filter​

Collections are used to categorize and organize your catalog. A collection contains multiple product variants, and a product variant can belong to multiple collections. Collections can be nested to create a hierarchy of categories, which is typically used to create a menu structure in the storefront.

Collections are not only used as the basis of storefront navigation. They are a general-purpose organization tool which can be used for many purposes, such as:

The specific product variants that belong to a collection are determined by the collection's CollectionFilters. A collection filter is a piece of logic which is used to determine whether a product variant should be included in the collection. By default, Vendure includes a number of collection filters:

It is also possible to create your own custom collection filters, which can be used to implement more complex logic. See the section on creating a collection filter for more details.

When a collection is nested within another collection, the child collection can inherit the parent's collection filters. This means that the child collection will combine its own filters with the parent's filters.

In the example above, we have a parent collection "Menswear", with a child collection "Mens' Casual". The parent collection has a filter which includes all product variants with the "clothing" and "mens" facet values. The child collection is set to inherit the parent's filters, and has an additional filter which includes all product variants with the "casual" facet value.

Thus, the child collection will include all product variants which have the "clothing", "mens" and "casual" facet values.

When filter inheritance is enabled, a child collection will contain a subset of the product variants of its parent collection.

In order to create a child collection which contains product variants not contained by the parent collection, you must disable filter inheritance in the child collection.

You can create your own custom collection filters with the CollectionFilter class. This class is a configurable operation where the specific filtering logic is implemented in the apply() method passed to its constructor.

The apply() method receives an instance of the TypeORM SelectQueryBuilder which should have filtering logic added to it using the .andWhere() method.

Here's an example of a collection filter which filters by SKU:

In the apply() method, the product variant entity is aliased as 'productVariant'.

This custom filter must then be registered in your VendureConfig to become available in the Admin UI.

The `apply()` method receives a TypeORM SelectQueryBuilder and uses `.andWhere()` for filtering logic. Database-specific syntax handling ensures compatibility across PostgreSQL and other databases. The `args` object defines user-configurable parameters exposed in the admin interface.

**Examples:**

Example 1 (ts):
```ts
import { CollectionFilter, LanguageCode } from '@vendure/core';export const skuCollectionFilter = new CollectionFilter({    args: {        // The `args` object defines the user-configurable arguments        // which will get passed to the filter's `apply()` function.        sku: {            type: 'string',            label: [{ languageCode: LanguageCode.en, value: 'SKU' }],            description: [                {                    languageCode: LanguageCode.en,                    value: 'Matches any product variants with an SKU containing this value',                },            ],      
...
```

Example 2 (ts):
```ts
import { defaultCollectionFilters, VendureConfig } from '@vendure/core';import { skuCollectionFilter } from './config/sku-collection-filter';export const config: VendureConfig = {    // ...    catalogOptions: {        collectionFilters: [            ...defaultCollectionFilters,            skuCollectionFilter        ],    },};
```

---

## Money & Currency

**URL:** https://docs.vendure.io/guides/core-concepts/money/

**Contents:**
- Money & Currency
- Displaying monetary values​
- Support for multiple currencies​
- The GraphQL Money scalar​
- The @Money() decorator​
- Advanced configuration: MoneyStrategy​
  - Example: supporting three decimal places​

In Vendure, monetary values are stored as integers using the minor unit of the selected currency. For example, if the currency is set to USD, then the integer value 100 would represent $1.00. This is a common practice in financial applications, as it avoids the rounding errors that can occur when using floating-point numbers.

For example, here's the response from a query for a product's variant prices:

In this example, the tax-inclusive price of the variant is $23.99.

To illustrate the problem with storing money as decimals, imagine that we want to add the price of two items:

We should expect the sum of these two amounts to equal $2.43. However, if we perform this addition in JavaScript (and the same holds true for most common programming languages), we will instead get $2.4299999999999997!

For a more in-depth explanation of this issue, see this StackOverflow answer

When you are building your storefront, or any other client that needs to display monetary values in a human-readable form, you need to divide by 100 to convert to the major currency unit and then format with the correct decimal & grouping dividers.

In JavaScript environments such as browsers & Node.js, we can take advantage of the excellent Intl.NumberFormat API.

Here's a function you can use in your projects:

If you are building an Dashboard extension, you can use the built-in useLocalFormat hook:

Vendure supports multiple currencies out-of-the-box. The available currencies must first be set at the Channel level (see the Channels, Currencies & Prices section), and then a price may be set on a ProductVariant in each of the available currencies.

When using multiple currencies, the ProductVariantPriceSelectionStrategy is used to determine which of the available prices to return when fetching the details of a ProductVariant. The default strategy is to return the price in the currency of the current session request context, which is determined firstly by any ?currencyCode=XXX query parameter on the request, and secondly by the defaultCurrencyCode of the Channel.

In the GraphQL APIs, we use a custom Money scalar type to represent all monetary values. We do this for two reasons:

Here's how the Money scalar is used in the ShippingLine type:

If you are defining custom GraphQL types, or adding fields to existing types (see the Extending the GraphQL API doc), then you should also use the Money scalar for any monetary values.

When defining new database entities, if you need to store a monetary value, then rather than using the TypeORM `@Column()` decorator, you should use Vendure's `@Money()` decorator. This ensures that Vendure correctly persists amounts based on the configured MoneyStrategy.

Here's a complete entity example:

```typescript
import { DeepPartial } from '@vendure/common/lib/shared-types';
import { VendureEntity, Order, EntityId, Money, CurrencyCode, ID } from '@vendure/core';
import { Column, Entity, ManyToOne } from 'typeorm';

@Entity()
class Quote extends VendureEntity {
    constructor(input?: DeepPartial<Quote>) {
        super(input);
    }

    @ManyToOne(type => Order)
    order: Order;

    @EntityId()
    orderId: ID;

    @Column()
    text: string;

    @Money()
    value: number;

    @Column('varchar')
    currencyCode: CurrencyCode;

    @Column()
    approved: boolean;
}
```

**Recommendation:** Whenever you store a monetary value, it's a good idea to also explicitly store the currency code too. This makes it possible to support multiple currencies and correctly format the amount when displaying the value.

**Examples:**

Example 1 (json):
```json
{  "data": {    "product": {      "id": "42",      "variants": [        {          "id": "74",          "name": "Bonsai Tree",          "currencyCode": "USD",          "price": 1999,          "priceWithTax": 2399,        }      ]    }  }}
```

Example 2 (ts):
```ts
export function formatCurrency(value: number, currencyCode: string, locale?: string) {    const majorUnits = value / 100;    try {        // Note: if no `locale` is provided, the browser's default        // locale will be used.        return new Intl.NumberFormat(locale, {            style: 'currency',            currency: currencyCode,        }).format(majorUnits);    } catch (e: any) {        // A fallback in case the NumberFormat fails for any reason        return majorUnits.toFixed(2);    }}
```

Example 3 (tsx):
```tsx
import { useLocalFormat } from '@vendure/dashboard';export function MyComponent({ variant }: MyComponentProps) {    const { formatCurrency } = useLocalFormat();    return (        <div>            Variant price: { formatCurrency(variant.price, variant.currencyCode) }        </div>    )}
```

Example 4 (graphql):
```graphql
type ShippingLine {    id: ID!    shippingMethod: ShippingMethod!    price: Money!    priceWithTax: Money!    discountedPrice: Money!    discountedPriceWithTax: Money!    discounts: [Discount!]!}
```

---

## Images & Assets

**URL:** https://docs.vendure.io/guides/core-concepts/images-assets/

**Contents:**
- Images & Assets
- AssetServerPlugin​
- Asset Tags​

Assets are used to store files such as images, videos, PDFs, etc. Assets can be assigned to products, variants and collections by default. By using custom fields it is possible to assign assets to other entities. For example, for implementing customer profile images.

The handling of assets in Vendure is implemented in a modular way, allowing you full control over the way assets are stored, named, imported and previewed.

Vendure comes with the @vendure/asset-server-plugin package pre-installed. This provides the AssetServerPlugin which provides many advanced features to make working with assets easier.

The plugin provides a ready-made set of strategies for handling assets, but also allows you to replace these defaults with your own implementations. For example, here are instructions on how to replace the default storage strategy with one that stores your assets on AWS S3 or Minio: configure S3 asset storage

It also features a powerful image transformation API, which allows you to specify the dimensions, crop, and image format using query parameters.

See the AssetServerPlugin docs for a detailed description of all the features.

Assets can be tagged. A Tag is a simple text label that can be applied to an asset. An asset can have multiple tags or none. Tags are useful for organizing assets, since assets are otherwise organized as a flat list with no concept of a directory structure.

---

## Taxes

**URL:** https://docs.vendure.io/guides/core-concepts/taxes/

**Contents:**
- Taxes
- API conventions​
- Calculating tax on order lines​
- Calculating tax on shipping​
- Configuration​

E-commerce applications need to correctly handle taxes such as sales tax or value added tax (VAT). In Vendure, tax handling consists of:

In the GraphQL API, any type which has a taxable price will split that price into two fields: price and priceWithTax. This pattern also holds for other price fields, e.g.

In your storefront, you can therefore choose whether to display the prices with or without tax, according to the laws and conventions of the area in which your business operates.

When a customer adds an item to the Order, the following logic takes place:

The taxes on shipping is calculated by the ShippingCalculator of the Order's selected ShippingMethod.

This example shows the default configuration for taxes (you don't need to specify this in your own config, as these are the defaults):

**Examples:**

Example 1 (graphql):
```graphql
query {  activeOrder {    ...on Order {      lines {        linePrice        linePriceWithTax      }      subTotal      subTotalWithTax      shipping      shippingWithTax      total      totalWithTax    }  }}
```

Example 2 (ts):
```ts
import {    DefaultTaxLineCalculationStrategy,    DefaultTaxZoneStrategy,    DefaultOrderItemPriceCalculationStrategy,    VendureConfig} from '@vendure/core';export const config: VendureConfig = {  taxOptions: {    taxZoneStrategy: new DefaultTaxZoneStrategy(),    taxLineCalculationStrategy: new DefaultTaxLineCalculationStrategy(),  },  orderOptions: {    orderItemPriceCalculationStrategy: new DefaultOrderItemPriceCalculationStrategy()  }}
```

---

## Payment

**URL:** https://docs.vendure.io/guides/core-concepts/payment/

**Contents:**
- Payment
- Authorization & Settlement​
- Creating an integration​
- The PaymentMethod entity​
- Payment flow​
  - Eligible payment methods​
  - Add payment to order​
  - Single-step​
  - Two-step​
- Custom Payment Flows​

Vendure can support many kinds of payment workflows, such as authorizing and capturing payment in a single step upon checkout or authorizing on checkout and then capturing on fulfillment.

For complete working examples of real payment integrations, see the payments-plugins

Typically, there are 2 parts to an online payment: authorization and settlement:

Some merchants do both of these steps at once, when the customer checks out of the store. Others do the authorize step at checkout, and only do the settlement at some later point, e.g. upon shipping the goods to the customer.

This two-step workflow can also be applied to other non-card forms of payment: e.g. if providing a "payment on delivery" option, the authorization step would occur on checkout, and the settlement step would be triggered upon delivery, either manually by an administrator of via an app integration with the Admin API.

Payment integrations are created by defining a new PaymentMethodHandler and passing that handler into the paymentOptions.paymentMethodHandlers array in the VendureConfig.

We can now add this handler to our configuration:

If your PaymentMethodHandler needs access to the database or other providers, see the configurable operation dependency injection guide.

Once the PaymentMethodHandler is defined as above, you can use it to create a new PaymentMethod via the Dashboard (Settings -> Payment methods, then Create new payment method) or via the Admin API createPaymentMethod mutation.

A payment method consists of an optional PaymentMethodEligibilityChecker, which is used to determine whether the payment method is available to the customer, and a PaymentMethodHandler.

The payment method also has a code, which is a string identifier used to specify this method when adding a payment to an order.

Once the active Order has been transitioned to the ArrangingPayment state (see the Order guide), we can query the available payment methods by executing the eligiblePaymentMethods query.

One or more Payments are created by executing the addPaymentToOrder mutation. This mutation has a required method input field, which must match the code of an eligible PaymentMethod. In the case above, this would be set to "my-payment-method".

The metadata field is used to store the specific data required by the payment provider. E.g. some providers have a client-side part which begins the transaction and returns a token which must then be verified on the server side.

The metadata field is required, so if your payment provider does not require any additional data, you can simply pass an empty object.

Within metadata, certain fields receive special treatment. Data placed in a "public" subfield becomes accessible through the Shop API, while other metadata remains restricted to Admin API access only.

**Payment Flow Types:**

**Single-Step Workflow:** When `createPayment()` returns a state of `'Settled'`, the authorization and capture occur simultaneously. The payment is immediately captured upon checkout completion.

**Two-Step Workflow:** When `createPayment()` returns a state of `'Authorized'`, settlement occurs later—potentially during fulfillment or upon payment-on-delivery confirmation. This approach separates authorization from fund capture.

The `addPaymentToOrder` mutation triggers the PaymentMethodHandler's `createPayment()` function, which returns payment details used to create a Payment entity. When the payment amount matches the order total, the order transitions to either `PaymentAuthorized` or `PaymentSettled` state, completing the checkout flow.

**Examples:**

Example 1 (ts):
```ts
import {    CancelPaymentResult,    CancelPaymentErrorResult,    PaymentMethodHandler,    VendureConfig,    CreatePaymentResult,    SettlePaymentResult,    SettlePaymentErrorResult} from '@vendure/core';import { sdk } from 'payment-provider-sdk';/** * This is a handler which integrates Vendure with an imaginary * payment provider, who provide a Node SDK which we use to * interact with their APIs. */const myPaymentHandler = new PaymentMethodHandler({    code: 'my-payment-method',    description: [{        languageCode: LanguageCode.en,        value: 'My Payment Provider',    }],    args: {     
...
```

Example 2 (ts):
```ts
import { VendureConfig } from '@vendure/core';import { myPaymentHandler } from './plugins/payment-plugin/my-payment-handler';export const config: VendureConfig = {    // ...    paymentOptions: {        paymentMethodHandlers: [myPaymentHandler],    },};
```

Example 3 (graphql):
```graphql
query GetEligiblePaymentMethods {    eligiblePaymentMethods {        code        name        isEligible        eligibilityMessage    }}
```

Example 4 (json):
```json
{  "data": {    "eligiblePaymentMethods": [      {        "code": "my-payment-method",        "name": "My Payment Method",        "isEligible": true,        "eligibilityMessage": null      }    ]  }}
```

---

## Auth

**URL:** https://docs.vendure.io/guides/core-concepts/auth/

**Contents:**
- Auth
- Administrator auth​
- Customer auth​
  - Guest customers​
- Roles & Permissions​
- Native authentication​
- External authentication​
- Custom authentication examples​
  - Google authentication​
    - Storefront setup​

Authentication is the process of determining the identity of a user. Common ways of authenticating a user are by asking the user for secret credentials (username & password) or by a third-party authentication provider such as Facebook or Google login.

Authorization is a related concept, which means that once we have verified the identity of a user, we can then determine what that user is allowed to do. For example, a user may be authorized to view a product, but not to edit it.

The term auth is shorthand for both authentication and authorization.

Auth in Vendure applies to both administrators and customers. Authentication is controlled by the configured AuthenticationStrategies, and authorization is controlled by the configured Roles and Permissions.

Administrators are required to authenticate before they can perform any operations in the Admin API.

Here is a diagram of the parts that make up Administrator authentication:

Roles can be created to allow fine-grained control over what a particular administrator has access to (see the section below).

Customer only need to authenticate if they want to access a restricted operation related to their account, such as viewing past orders or updating an address.

Here are the parts that make up Customer authentication:

Vendure also supports guest customers, meaning that a customer can place an order without needing to register an account, and thus not getting an associated user or role. A guest customer, having no roles and thus no permissions, is then unable to view past orders or access any other restricted API operations.

However, a guest customer can at a later point register an account using the same email address, at which point they will get a user with the "Customer" role, and be able to view their past orders.

Both the Customer and Administrator entities relate to a single User entity which in turn has one or more Roles for controlling permissions.

In the example above, the administrator Sam Bailey has two roles assigned: "Order Manager" and "Catalog Manager". An administrator can have any number of roles assigned, and the permissions of all roles are combined to determine the permissions of the administrator. In this way, you can have fine-grained control over which administrators can perform which actions.

There are 2 special roles which are created by default and cannot be changed:

1. **SuperAdmin**: Possesses all permissions; cannot be edited or deleted. Assigned to the first administrator at server startup.
2. **Customer**: Automatically assigned to all registered customers.

All other roles are customizable and can be defined in the Admin UI to provide fine-grained access control.

**Native Authentication** uses username/email and password via the `NativeAuthenticationStrategy`. This provides a standard `login` mutation available in both Shop and Admin APIs.

**External Authentication** enables custom `AuthenticationStrategy` implementations for alternatives including:
- Social logins (Facebook, Google, GitHub)
- Single Sign-On providers (Keycloak, Auth0)
- Alternative authentication factors (SMS, TOTP)

Strategies are configured via `VendureConfig.authOptions`:

```typescript
authOptions: {
  shopAuthenticationStrategy: [
    new NativeAuthenticationStrategy(),
    new FacebookAuthenticationStrategy(),
    new GoogleAuthenticationStrategy(),
  ],
  adminAuthenticationStrategy: [
    new NativeAuthenticationStrategy(),
    new KeycloakAuthenticationStrategy(),
  ],
}
```

This demonstrates separating authentication methods between customer-facing (shop) and administrator interfaces.

**Examples:**

Example 1 (graphql):
```graphql
mutation {  login(username: "superadmin", password: "superadmin") {    ...on CurrentUser {      id      identifier    }    ...on ErrorResult {      errorCode      message    }  }}
```

Example 2 (ts):
```ts
import { VendureConfig, NativeAuthenticationStrategy } from '@vendure/core';import { FacebookAuthenticationStrategy } from './plugins/authentication/facebook-authentication-strategy';import { GoogleAuthenticationStrategy } from './plugins/authentication/google-authentication-strategy';import { KeycloakAuthenticationStrategy } from './plugins/authentication/keycloak-authentication-strategy';export const config: VendureConfig = {  authOptions: {      shopAuthenticationStrategy: [        new NativeAuthenticationStrategy(),        new FacebookAuthenticationStrategy(),        new GoogleAuthenticati
...
```

Example 3 (ts):
```ts
function onSignIn(googleUser) {  graphQlQuery(    `mutation Authenticate($token: String!) {        authenticate(input: {          google: { token: $token }        }) {        ...on CurrentUser {            id            identifier        }      }    }`,    { token: googleUser.getAuthResponse().id_token }  ).then(() => {    // redirect to account page  });}
```

Example 4 (ts):
```ts
import {    AuthenticationStrategy,    ExternalAuthenticationService,    Injector,    RequestContext,    User,} from '@vendure/core';import { OAuth2Client } from 'google-auth-library';import { DocumentNode } from 'graphql';import gql from 'graphql-tag';export type GoogleAuthData = {    token: string;};export class GoogleAuthenticationStrategy implements AuthenticationStrategy<GoogleAuthData> {    readonly name = 'google';    private client: OAuth2Client;    private externalAuthenticationService: ExternalAuthenticationService;    constructor(private clientId: string) {        // The clientId is
...
```

---

## Customers

**URL:** https://docs.vendure.io/guides/core-concepts/customers/

**Contents:**
- Customers

A Customer is a person who can buy from your shop. A customer can have one or more Addresses, which are used for shipping and billing.

If a customer has registered an account, they will have an associated User. The user entity is used for authentication and authorization. Guest checkouts are also possible, in which case a customer will not have a user.

See the Auth guide for a detailed explanation of the relationship between customers and users.

Customers can be organized into CustomerGroups. These groups can be used in logic relating to promotions, shipping rules, payment rules etc. For example, you could create a "VIP" customer group and then create a promotion which grants members of this group free shipping. Or a "B2B" group which is used in a custom tax calculator to apply a different tax rate to B2B customers.

---

## Channels

**URL:** https://docs.vendure.io/guides/core-concepts/channels/

**Contents:**
- Channels
- Channel-aware entities​
- Channels & Sellers​
- Channels, Currencies & Prices​
  - Keeping prices synchronized​
- Use cases​
  - Single shop​
  - Multiple separate shops​
  - Multiple shops sharing inventory​
  - Multi-vendor marketplace​

Channels are a feature of Vendure which allows multiple sales channels to be represented in a single Vendure instance. A Channel allows you to:

This is useful for a number of use-cases, including:

Every Vendure server always has a default Channel, which contains all entities. Subsequent channels can then contain a subset of channel-aware entities.

Many entities are channel-aware, meaning that they can be associated with a multiple channels. The following entities are channel-aware:

Each channel is also assigned a single Seller. This entity is used to represent the vendor or seller of the products in the channel. This is useful for implementing a marketplace, where each channel represents a distinct vendor. The Seller entity can be extended with custom fields to store additional information about the seller, such as a logo, contact details etc.

Each Channel has a set of availableCurrencyCodes, and one of these is designated as the defaultCurrencyCode, which sets the default currency for all monetary values in that channel.

Internally, there is a one-to-many relation from ProductVariant to ProductVariantPrice. So the ProductVariant does not hold a price for the product - this is actually stored on the ProductVariantPrice entity, and there will be at least one for each Channel to which the ProductVariant has been assigned.

In this diagram we can see that every channel has at least 1 ProductVariantPrice. In the case of the UK Channel, there are 2 prices assigned - one for GBP and one for USD. This means that you are able to define multiple prices in different currencies on a single product variant for a single channel.

Note: in the diagram above that the ProductVariant is always assigned to the default Channel, and thus will have a price in the default channel too. Likewise, the default Channel also has a defaultCurrencyCode. Depending on your requirements, you may or may not make use of the default Channel.

When you have products assigned to multiple channels, updates to the price of a product in one channel will not automatically be reflected in other channels. For instance, in the diagram above, both the Default channel and the UK channel have a price in USD for the same product variant.

If an administrator of the UK channel changes the USD price to $20, the price in the Default channel will remain at $30. This is the default behavior, and is controlled by the ProductVariantPriceUpdateStrategy.

If you want to keep prices synchronized across all channels, you can set the `syncPricesAcrossChannels` property of the DefaultProductVariantPriceUpdateStrategy to `true`. This ensures that modifying a product variant's price in one channel will update matching currency prices across all other channels.

**Configuration Example:**

```typescript
import { DefaultProductVariantPriceUpdateStrategy, VendureConfig } from '@vendure/core';

export const config: VendureConfig = {
    // ...
    productVariantPriceUpdateStrategy: new DefaultProductVariantPriceUpdateStrategy({
        syncPricesAcrossChannels: true,
    }),
    // ...
};
```

For more complex scenarios—such as one-way synchronization where a default channel serves as the master price source—developers can implement custom logic by creating a specialized `ProductVariantPriceUpdateStrategy` with tailored behavior.

**Examples:**

Example 1 (ts):
```ts
import { DefaultProductVariantPriceUpdateStrategy, VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    productVariantPriceUpdateStrategy: new DefaultProductVariantPriceUpdateStrategy({        syncPricesAcrossChannels: true,    }),    // ...};
```

Example 2 (ts):
```ts
const { loading, error, data } = useQuery(GET_PRODUCT_LIST, {    context: {        headers: {            'vendure-token': 'uk-channel',        },    },});
```

---

## Email & Notifications

**URL:** https://docs.vendure.io/guides/core-concepts/email/

**Contents:**
- Email & Notifications
- Email​
  - EmailEventHandlers​
  - Email variables​
  - Email integrations​
- Other notification methods​

A typical ecommerce application needs to notify customers of certain events, such as when they place an order or when their order has been shipped. This is usually done via email, but can also be done via SMS or push notifications.

Email is the most common way to notify customers of events, so a default Vendure installation includes our EmailPlugin.

The EmailPlugin by default uses Nodemailer to send emails via a variety of different transports, including SMTP, SendGrid, Mailgun, and more. The plugin is configured with a list of EmailEventHandlers which are responsible for sending emails in response to specific events.

This guide will cover some of the main concepts of the EmailPlugin, but for a more in-depth look at how to configure and use it, see the EmailPlugin API docs.

Here's an illustration of the flow of an email being sent:

All emails are triggered by a particular Event - in this case when the state of an Order changes. The EmailPlugin ships with a set of default email handlers, one of which is responsible for sending "order confirmation" emails.

Let's take a closer look at a simplified version of the orderConfirmationHandler:

The full range of methods available when setting up an EmailEventHandler can be found in the EmailEventHandler API docs.

In the example above, we used the setTemplateVars() method to define the variables which are available to the email template. Additionally, there are global variables which are made available to all email templates & EmailEventHandlers. These are defined in the globalTemplateVars property of the EmailPlugin config:

The EmailPlugin is designed to be flexible enough to work with many different email services. The default configuration uses Nodemailer to send emails via SMTP, but you can easily configure it to use a different transport. For instance:

The pattern of listening for events and triggering some action in response is not limited to emails. You can use the same pattern to trigger other actions, such as sending SMS messages or push notifications. For instance, let's say you wanted to create a plugin which sends an SMS message to the customer when their order is shipped.

This is just a simplified example to illustrate the pattern.

**Examples:**

Example 1 (ts):
```ts
import { OrderStateTransitionEvent } from '@vendure/core';import { EmailEventListener, transformOrderLineAssetUrls, hydrateShippingLines } from '@vendure/email-plugin';// The 'order-confirmation' string is used by the EmailPlugin to identify// which template to use when rendering the email.export const orderConfirmationHandler = new EmailEventListener('order-confirmation')    .on(OrderStateTransitionEvent)    // Only send the email when the Order is transitioning to the    // "PaymentSettled" state and the Order has a customer associated with it.    .filter(        event =>            event.to
...
```

Example 2 (ts):
```ts
import { VendureConfig } from '@vendure/core';import { EmailPlugin } from '@vendure/email-plugin';export const config: VendureConfig = {    // ...    plugins: [        EmailPlugin.init({            // ...            globalTemplateVars: {                fromAddress: '"MyShop" <noreply@myshop.com>',                verifyEmailAddressUrl: 'https://www.myshop.com/verify',                passwordResetUrl: 'https://www.myshop.com/password-reset',                changeEmailAddressUrl: 'https://www.myshop.com/verify-email-address-change'            },        }),    ],};
```

Example 3 (ts):
```ts
import { OnModuleInit } from '@nestjs/common';import { PluginCommonModule, VendurePlugin, EventBus } from '@vendure/core';import { OrderStateTransitionEvent } from '@vendure/core';// A custom service which sends SMS messages// using a third-party SMS provider such as Twilio.import { SmsService } from './sms.service';@VendurePlugin({    imports: [PluginCommonModule],    providers: [SmsService],})export class SmsPlugin implements OnModuleInit {    constructor(        private eventBus: EventBus,        private smsService: SmsService,    ) {}    onModuleInit() {        this.eventBus            .of
...
```

---

## Orders

**URL:** https://docs.vendure.io/guides/core-concepts/orders/

**Contents:**
- Orders
- The Order Process​
- Customizing the Default Order Process​
- Custom Order Processes​
  - Adding a new state​
  - Intercepting a state transition​
  - Responding to a state transition​
- TypeScript Typings​
- Controlling custom states in the Dashboard​
- Order Interceptors​

In Vendure, the Order entity represents the entire lifecycle of an order, from the moment a customer adds an item to their cart, through to the point where the order is completed and the customer has received their goods.

An Order is composed of one or more OrderLines. Each order line represents a single product variant, and contains information such as the quantity, price, tax rate, etc.

In turn, the order is associated with a Customer and contains information such as the shipping address, billing address, shipping method, payment method, etc.

Vendure defines an order process which is based on a finite state machine (a method of precisely controlling how the order moves from one state to another). This means that the Order.state property will be one of a set of pre-defined states. From the current state, the Order can then transition (change) to another state, and the available next states depend on what the current state is.

In Vendure, there is no distinction between a "cart" and an "order". The same entity is used for both. A "cart" is simply an order which is still "active" according to its current state.

You can see the current state of an order via state field on the Order type:

The next possible states can be queried via the nextOrderStates query:

The available states and the permissible transitions between them are defined by the configured OrderProcess. By default, Vendure defines a DefaultOrderProcess which is suitable for typical B2C use-cases. Here's a simplified diagram of the default order process:

Let's take a look at each of these states, and the transitions between them:

It is possible to customize the defaultOrderProcess to better match your business needs. For example, you might want to disable some of the constraints that are imposed by the default process, such as the requirement that a customer must have a shipping address before the Order can be completed.

This can be done by creating a custom version of the default process using the configureDefaultOrderProcess function, and then passing it to the OrderOptions.process config property.

Sometimes you might need to extend things beyond what is provided by the default Order process to better match your business needs. This is done by defining one or more OrderProcess objects and passing them to the OrderOptions.process config property.

Let's say your company can only sell to customers with a valid EU tax ID. We'll assume that you've already used a custom field to store that code on the Customer entity.

**Adding a New State:**

The proposed state flow changes from:
```
AddingItems -> ArrangingPayment
```

To:
```
AddingItems -> ValidatingCustomer -> ArrangingPayment
```

**Implementation Example:**

```typescript
import { OrderProcess } from '@vendure/core';

export const customerValidationProcess: OrderProcess<'ValidatingCustomer'> = {
  transitions: {
    AddingItems: {
      to: ['ValidatingCustomer'],
      mergeStrategy: 'replace',
    },
    ValidatingCustomer: {
      to: ['ArrangingPayment', 'AddingItems'],
    },
  },
};
```

This configuration is then added to your VendureConfig alongside the default process to preserve existing states.

**Intercepting State Transitions:**

Use the `onTransitionStart` hook to enforce validation logic and prevent invalid transitions:

```typescript
import { OrderProcess } from '@vendure/core';
import { TaxIdService } from './services/tax-id.service';

let taxIdService: TaxIdService;

const customerValidationProcess: OrderProcess<'ValidatingCustomer'> = {
  transitions: {
    AddingItems: {
      to: ['ValidatingCustomer'],
      mergeStrategy: 'replace',
    },
    ValidatingCustomer: {
      to: ['ArrangingPayment', 'AddingItems'],
    },
  },
  init(injector) {
    taxIdService = injector.get(TaxIdService);
  },
  async onTransitionStart(fromState, toState, data) {
    if (fromState === 'ValidatingCustomer' && toState === 'ArrangingPayment') {
      const isValid = await taxIdService.verifyTaxId(data.order.customer);
      if (!isValid) {
        return `The tax ID is not valid`;
      }
    }
  },
};
```

**Responding to State Transitions:**

The `onTransitionEnd` hook executes after successful state transitions. Here's an example creating referrals:

```typescript
import { OrderProcess, OrderState } from '@vendure/core';
import { ReferralService } from '../service/referral.service';

let referralService: ReferralService;

export const referralOrderProcess: OrderProcess<OrderState> = {
    init: (injector) => {
        referralService = injector.get(ReferralService);
    },
    onTransitionEnd: async (fromState, toState, data) => {
        const { order, ctx } = data;
        if (toState === 'PaymentSettled') {
            if (order.customFields.referralCode) {
                await referralService.createReferralForOrder(ctx, order);
            }
        }
    },
};
```

**Important:** When modifying orders within `onTransitionEnd`, always mutate the order object directly rather than calling external services, as changes must be reflected in the persisted object.

**TypeScript Type Declarations:**

Declare custom states using declaration merging:

```typescript
import { CustomOrderStates } from '@vendure/core';

declare module '@vendure/core' {
  interface CustomOrderStates {
    ValidatingCustomer: never;
  }
}
```

**Examples:**

Example 1 (graphql):
```graphql
query ActiveOrder {    activeOrder {        id        state    }}
```

Example 2 (json):
```json
{  "data": {    "activeOrder": {      "id": "4",      "state": "AddingItems"    }  }}
```

Example 3 (graphql):
```graphql
query NextStates {  nextOrderStates}
```

Example 4 (json):
```json
{  "data": {    "nextOrderStates": [      "ArrangingPayment",      "Cancelled"    ]  }}
```

---

## Developer Documentation

**URL:** https://docs.vendure.io

**Contents:**
  - Get Started
  - Learn Vendure
  - API Reference
- Core Concepts
  - Custom Fields
  - Plugins
  - Products
  - Customers
  - Payments
  - Orders

Follow our installation guide and create your first Vendure project.

Understand Vendure's core concepts and architecture principles.

Explore comprehensive GraphQL API documentation and examples.

Adding custom data to any Vendure entity.

The core of Vendure's extensibility.

Multi customer configuration.

Payment integrations and API.

Business logic of checkout.

Learn how to publish your custom plugin to npm.

Sell licenses, services, and other non-physical goods.

Create products with multiple variants and options.

Implement efficient pagination for large datasets.

Generate TypeScript types from your GraphQL schema.

Create a marketplace platform where multiple sellers can sell their products.

Explore Vendure's GraphQL API with this interactive playground.

---

## Collections

**URL:** https://docs.vendure.io/guides/core-concepts/collections/

**Contents:**
- Collections
- Collection filters​
  - Filter inheritance​
  - Creating a collection filter​

Collections are used to categorize and organize your catalog. A collection contains multiple product variants, and a product variant can belong to multiple collections. Collections can be nested to create a hierarchy of categories, which is typically used to create a menu structure in the storefront.

Collections are not only used as the basis of storefront navigation. They are a general-purpose organization tool which can be used for many purposes, such as:

The specific product variants that belong to a collection are determined by the collection's CollectionFilters. A collection filter is a piece of logic which is used to determine whether a product variant should be included in the collection. By default, Vendure includes a number of collection filters:

It is also possible to create your own custom collection filters, which can be used to implement more complex logic. See the section on creating a collection filter for more details.

When a collection is nested within another collection, the child collection can inherit the parent's collection filters. This means that the child collection will combine its own filters with the parent's filters.

In the example above, we have a parent collection "Menswear", with a child collection "Mens' Casual". The parent collection has a filter which includes all product variants with the "clothing" and "mens" facet values. The child collection is set to inherit the parent's filters, and has an additional filter which includes all product variants with the "casual" facet value.

Thus, the child collection will include all product variants which have the "clothing", "mens" and "casual" facet values.

When filter inheritance is enabled, a child collection will contain a subset of the product variants of its parent collection.

In order to create a child collection which contains product variants not contained by the parent collection, you must disable filter inheritance in the child collection.

You can create your own custom collection filters with the CollectionFilter class. This class is a configurable operation where the specific filtering logic is implemented in the apply() method passed to its constructor.

The apply() method receives an instance of the TypeORM SelectQueryBuilder which should have filtering logic added to it using the .andWhere() method.

Here's an example of a collection filter which filters by SKU:

In the apply() method, the product variant entity is aliased as 'productVariant'.

This custom filter must then be registered in your VendureConfig to become available in the Admin UI.

The `apply()` method receives a TypeORM SelectQueryBuilder and uses `.andWhere()` for filtering logic. Database-specific syntax handling ensures compatibility across PostgreSQL and other databases. The `args` object defines user-configurable parameters exposed in the admin interface.

**Examples:**

Example 1 (ts):
```ts
import { CollectionFilter, LanguageCode } from '@vendure/core';export const skuCollectionFilter = new CollectionFilter({    args: {        // The `args` object defines the user-configurable arguments        // which will get passed to the filter's `apply()` function.        sku: {            type: 'string',            label: [{ languageCode: LanguageCode.en, value: 'SKU' }],            description: [                {                    languageCode: LanguageCode.en,                    value: 'Matches any product variants with an SKU containing this value',                },            ],      
...
```

Example 2 (ts):
```ts
import { defaultCollectionFilters, VendureConfig } from '@vendure/core';import { skuCollectionFilter } from './config/sku-collection-filter';export const config: VendureConfig = {    // ...    catalogOptions: {        collectionFilters: [            ...defaultCollectionFilters,            skuCollectionFilter        ],    },};
```

---

## Stock Control

**URL:** https://docs.vendure.io/guides/core-concepts/stock-control/

**Contents:**
- Stock Control
- Stock Locations​
  - Selecting a stock location​
  - Displaying stock levels in the storefront​
- Stock Control Concepts​
  - Stock allocation​
  - Back orders​
  - Stock movements​

Vendure includes features to help manage your stock levels, stock allocations and back orders. The basic purpose is to help you keep track of how many of a given ProductVariant you have available to sell.

Stock control is enabled globally via the Global Settings:

It can be disabled if, for example, you manage your stock with a separate inventory management system and synchronize stock levels into Vendure automatically. The setting can also be overridden at the individual ProductVariant level.

Vendure uses the concept of StockLocations to represent the physical locations where stock is stored. This could be a warehouse, a retail store, or any other location. If you do not have multiple stock locations, then you can simply use the default location which is created automatically.

When you have multiple stock locations set up, you need a way to determine which location to use when querying stock levels and when allocating stock to orders. This is handled by the StockLocationStrategy. This strategy exposes a number of methods which are used to determine which location (or locations) to use when:

The default strategy is the DefaultStockLocationStrategy, which simply uses the default location for all of the above methods. This is suitable for all cases where there is just a single stock location.

If you have multiple stock locations, you'll need to implement a custom strategy which uses custom logic to determine which stock location to use. For instance, you could:

The StockDisplayStrategy is used to determine how stock levels are displayed in the storefront. The default strategy is the DefaultStockDisplayStrategy, which will only display one of three states: 'IN_STOCK', 'OUT_OF_STOCK' or 'LOW_STOCK'. This is to avoid exposing your exact stock levels to the public, which can sometimes be undesirable.

You can implement a custom strategy to display stock levels in a different way. Here's how you would implement a custom strategy to display exact stock levels:

This strategy is then used in your config:

Here's a table to better illustrate the relationship between these concepts:

The saleable value is what determines whether the customer is able to add a variant to an order. If there is 0 saleable stock, then any attempt to add to the order will result in an InsufficientStockError.

Allocation mean we are setting stock aside because it has been purchased but not yet shipped. It prevents us from selling more of a particular item than we are able to deliver.

By default, stock gets allocated to an order once the order transitions to the `PaymentAuthorized` or `PaymentSettled` state. Organizations can customize this timing through a custom `StockAllocationStrategy` to match their business requirements.

When using the default fulfillment process, allocated inventory converts to sales and decreases the `stockOnHand` value upon fulfillment creation.

**Back Orders:**

The system permits negative out-of-stock thresholds, enabling organizations to accept orders for items temporarily unavailable. This practice, known as back-ordering, allows sales to continue during stock shortages when replenishment is predictable.

After checkout completion, variant quantities are marked as allocated. Upon fulfillment creation, these allocations become sales and adjust `stockOnHand` accordingly. Importantly, fulfillments require sufficient physical stock to proceed.

**Stock Movements:**

The `StockMovement` entity tracks inventory changes through five concrete implementations:

- **Allocation**: Reserves stock for orders; reduces saleable inventory
- **Sale**: Converts allocation to fulfilled inventory; decreases both allocated and hand stock
- **Cancellation**: Returns fulfilled items; restores `stockOnHand`
- **Release**: Cancels pre-fulfillment allocations; removes allocated stock
- **StockAdjustment**: General adjustments to `stockOnHand` for manual corrections

These movements provide complete audit trails queryable via `ProductVariant.stockMovements`.

**Examples:**

Example 1 (ts):
```ts
import { RequestContext, StockDisplayStrategy, ProductVariant } from '@vendure/core';export class ExactStockDisplayStrategy implements StockDisplayStrategy {    getStockLevel(ctx: RequestContext, productVariant: ProductVariant, saleableStockLevel: number): string {        return saleableStockLevel.toString();    }}
```

Example 2 (ts):
```ts
import { VendureConfig } from '@vendure/core';import { ExactStockDisplayStrategy } from './exact-stock-display-strategy';export const config: VendureConfig = {    // ...    catalogOptions: {        stockDisplayStrategy: new ExactStockDisplayStrategy(),    },};
```

Example 3 (graphql):
```graphql
query AddItemToOrder {    addItemToOrder(productVariantId: 123, quantity: 150) {        ...on Order {            id            code            totalQuantity        }        ...on ErrorResult {            errorCode            message        }        ...on InsufficientStockError {            errorCode            message            quantityAvailable            order {                id                totalQuantity            }        }    }}
```

Example 4 (json):
```json
{  "data": {    "addItemToOrder": {      "errorCode": "INSUFFICIENT_STOCK_ERROR",      "message": "Only 105 items were added to the order due to insufficient stock",      "quantityAvailable": 105,      "order": {        "id": "2",        "totalQuantity": 106      }    }  }}
```

---

## Products

**URL:** https://docs.vendure.io/guides/core-concepts/products/

**Contents:**
- Products
- Product price and stock​
- Facets​

Your catalog is composed of Products and ProductVariants. A Product always has at least one ProductVariant. You can think of the product as a "container" which includes a name, description, and images that apply to all of its variants.

Here's a visual example, in which we have a "Hoodie" product which is available in 3 sizes. Therefore, we have 3 variants of that product:

Multiple variants are made possible by adding one or more ProductOptionGroups to the product. These option groups then define the available ProductOptions

If we were to add a new option group to the example above for "Color", with 2 options, "Black" and "White", then in total we would be able to define up to 6 variants:

When a customer adds a product to their cart, they are adding a specific ProductVariant to their cart, not the Product itself. It is the ProductVariant that contains the SKU ("stock keeping unit", or product code) and price information.

The ProductVariant entity contains the price and stock information for a product. Since a given product variant can have more than one price, and more than one stock level (in the case of multiple warehouses), the ProductVariant entity contains relations to one or more ProductVariantPrice entities and one or more StockLevel entities.

Facets are used to add structured labels to products and variants. A facet has one or more FacetValues. Facet values can be assigned to products or product variants.

For example, a "Brand" facet could be used to label products with the brand name, with each facet value representing a different brand. You can also use facets to add other metadata to products and variants such as "New", "Sale", "Featured", etc.

These are the typical uses of facets in Vendure:

---

## Shipping & Fulfillment

**URL:** https://docs.vendure.io/guides/core-concepts/shipping/

**Contents:**
- Shipping & Fulfillment
- Creating a custom checker​
- Creating a custom calculator​
- Fulfillments​
  - FulfillmentHandlers​
  - Fulfillment state machine​

Shipping in Vendure is handled by ShippingMethods. A ShippingMethod is composed of a checker and a calculator.

Multiple shipping methods can be set up and then your storefront can query eligibleShippingMethods to find out which ones can be applied to the active order.

When querying eligibleShippingMethods, each of the defined ShippingMethods' checker functions is executed to find out whether the order is eligible for that method, and if so, the calculator is executed to determine what the cost of shipping will be for that method.

Custom checkers can be created by defining a ShippingEligibilityChecker object.

For example, you could create a checker which works with a custom "weight" field to only apply to orders below a certain weight:

Custom checkers are then passed into the VendureConfig ShippingOptions to make them available when setting up new ShippingMethods:

Custom calculators can be created by defining a ShippingCalculator object.

For example, you could create a calculator which consults an external data source (e.g. a spreadsheet, database or 3rd-party API) to find out the cost and estimated delivery time for the order.

Custom calculators are then passed into the VendureConfig ShippingOptions to make them available when setting up new ShippingMethods:

If your ShippingEligibilityChecker or ShippingCalculator needs access to the database or other providers, see the configurable operation dependency injection guide.

Fulfillments represent the actual shipping status of items in an order. When an order is placed and payment has been settled, the order items are then delivered to the customer in one or more Fulfillments.

It is often required to integrate your fulfillment process, e.g. with an external shipping API which provides shipping labels or tracking codes. This is done by defining FulfillmentHandlers (click the link for full documentation) and passing them in to the shippingOptions.fulfillmentHandlers array in your config.

By default, Vendure uses a manual fulfillment handler, which requires the Administrator to manually enter the method and tracking code of the Fulfillment.

Like Orders, Fulfillments are governed by a finite state machine and by default, a Fulfillment can be in one of the following states:

- `Pending` - Initial fulfillment creation
- `Shipped` - Fulfillment dispatched
- `Delivered` - Item received by customer
- `Cancelled` - Fulfillment revoked

These states cover the typical workflow for fulfilling orders. However, it is possible to customize the fulfillment workflow by defining a FulfillmentProcess and passing it to your VendureConfig:

```typescript
import { FulfillmentProcess, VendureConfig } from '@vendure/core';
import { myCustomFulfillmentProcess } from './my-custom-fulfillment-process';

export const config: VendureConfig = {
  shippingOptions: {
    process: [myCustomFulfillmentProcess],
  },
};
```

For a more detailed look at how custom processes operate, see the comprehensive guide on custom order processes which provides deeper insights into implementing state machine customizations within Vendure's architecture.

**Examples:**

Example 1 (graphql):
```graphql
query GetEligibleShippingMethods {    eligibleShippingMethods {        id        name        price        priceWithTax    }}
```

Example 2 (json):
```json
{  "data": {    "eligibleShippingMethods": [      {        "id": "1",        "name": "Standard Shipping",        "price": 500,        "priceWithTax": 500      },      {        "id": "2",        "name": "Express Shipping",        "price": 1000,        "priceWithTax": 1000      }    ]  }}
```

Example 3 (ts):
```ts
import { LanguageCode, ShippingEligibilityChecker } from '@vendure/core';export const maxWeightChecker = new ShippingEligibilityChecker({    code: 'max-weight-checker',    description: [        {languageCode: LanguageCode.en, value: 'Max Weight Checker'}    ],    args: {        maxWeight: {            type: 'int',            ui: {component: 'number-form-input', suffix: 'grams'},            label: [{languageCode: LanguageCode.en, value: 'Maximum order weight'}],            description: [                {                    languageCode: LanguageCode.en,                    value: 'Order is eligi
...
```

Example 4 (ts):
```ts
import { defaultShippingEligibilityChecker, VendureConfig } from '@vendure/core';import { maxWeightChecker } from './shipping-methods/max-weight-checker';export const config: VendureConfig = {    // ...    shippingOptions: {        shippingEligibilityCheckers: [            defaultShippingEligibilityChecker,            maxWeightChecker,        ],    }}
```

---

## Promotions

**URL:** https://docs.vendure.io/guides/core-concepts/promotions/

**Contents:**
- Promotions
- Parts of a Promotion​
  - Constraints​
  - Conditions​
  - Actions​
- Creating custom conditions​
- Creating custom actions​
- Free gift promotions​
- Dependency relationships​
- Injecting providers​

Promotions are a means of offering discounts on an order based on various criteria. A Promotion consists of conditions and actions.

All Promotions can have the following constraints applied to them:

A Promotion may be additionally constrained by one or more conditions. When evaluating whether a Promotion should be applied, each of the defined conditions is checked in turn. If all the conditions evaluate to true, then any defined actions are applied to the order.

Vendure comes with some built-in conditions, but you can also create your own conditions (see section below).

A promotion action defines exactly how the order discount should be calculated. At least one action must be specified for a valid Promotion.

Vendure comes with some built-in actions, but you can also create your own actions (see section below).

To create a custom condition, you need to define a new PromotionCondition object. A promotion condition is an example of a configurable operation. Here is an annotated example of one of the built-in PromotionConditions.

Custom promotion conditions are then passed into the VendureConfig PromotionOptions to make them available when setting up Promotions:

There are three kinds of PromotionAction:

The implementations of each type is similar, with the difference being the arguments passed to the execute().

Here's an example of a simple PromotionOrderAction.

Custom PromotionActions are then passed into the VendureConfig PromotionOptions to make them available when setting up Promotions:

Vendure v1.8 introduced a new side effect API to PromotionActions, which allow you to define some additional action to be performed when a Promotion becomes active or inactive.

A primary use-case of this API is to add a free gift to the Order. Here's an example of a plugin which implements a "free gift" action:

It is possible to establish dependency relationships between a PromotionAction and one or more PromotionConditions.

For example, if we want to set up a "buy 1, get 1 free" offer, we need to:

In this scenario, we would have to repeat the logic for checking the Order contents in both the PromotionCondition and the PromotionAction. Not only is this duplicated work for the server, it also means that setting up the promotion relies on the same parameters being input into the PromotionCondition and the PromotionAction.

Note the use of PromotionItemAction to get a reference to the OrderLine as opposed to the Order.

Instead, we can say that the PromotionAction depends on the PromotionCondition to avoid repeating validation logic in multiple places.

**Configuration Example:**

To implement dependencies, specify the condition in the action's configuration:

```typescript
export const buy1Get1FreeAction = new PromotionItemAction({
    code: 'buy_1_get_1_free',
    description: [{
        languageCode: LanguageCode.en,
        value: 'Buy 1, get 1 free',
    }],
    args: {},
    conditions: [buyXGetYFreeCondition],
    execute(ctx, orderLine, args, state) {
        const freeItemIds = state.buy_x_get_y_free.freeItemIds;
        if (idsContainsItem(freeItemIds, orderLine)) {
            const unitPrice = ctx.channel.pricesIncludeTax ?
                orderLine.unitPriceWithTax : orderLine.unitPrice;
            return -unitPrice;
        }
        return 0;
    },
});
```

**State Object Passing:**

The dependent condition returns a state object instead of a boolean:

```typescript
export const buyXGetYFreeCondition = new PromotionCondition({
    code: 'buy_x_get_y_free',
    // ... configuration
    async check(ctx, order, args) {
        // validation logic
        if (freeItemIds.length === 0) {
            return false;
        }
        return {freeItemIds}; // State object
    },
});
```

This state object is passed to dependent actions as the final argument, enabling seamless data sharing.

**Examples:**

Example 1 (ts):
```ts
import { LanguageCode, PromotionCondition } from '@vendure/core';export const minimumOrderAmount = new PromotionCondition({    /** A unique identifier for the condition */    code: 'minimum_order_amount',    /**     * A human-readable description. Values defined in the     * `args` object can be interpolated using the curly-braces syntax.     */    description: [        {languageCode: LanguageCode.en, value: 'If order total is greater than { amount }'},    ],    /**     * Arguments which can be specified when configuring the condition     * in the Dashboard. The values of these args are then a
...
```

Example 2 (ts):
```ts
import { defaultPromotionConditions, VendureConfig } from '@vendure/core';import { minimumOrderAmount } from './minimum-order-amount';export const config: VendureConfig = {    // ...    promotionOptions: {        promotionConditions: [            ...defaultPromotionConditions,            minimumOrderAmount,        ],    }}
```

Example 3 (ts):
```ts
import { LanguageCode, PromotionOrderAction } from '@vendure/core';export const orderPercentageDiscount = new PromotionOrderAction({    // See the custom condition example above for explanations    // of code, description & args fields.    code: 'order_percentage_discount',    description: [{languageCode: LanguageCode.en, value: 'Discount order by { discount }%'}],    args: {        discount: {            type: 'int',            ui: {                component: 'number-form-input',                suffix: '%',            },        },    },    /**     * This is the function that defines the actua
...
```

Example 4 (ts):
```ts
import { defaultPromotionActions, VendureConfig } from '@vendure/core';import { orderPercentageDiscount } from './order-percentage-discount';export const config: VendureConfig = {    // ...    promotionOptions: {        promotionActions: [            ...defaultPromotionActions,            orderPercentageDiscount,        ],    }};
```

---
