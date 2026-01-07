# Auth


Authentication is the process of determining the identity of a user. Common ways of authenticating a user are by asking the user for secret credentials (username & password) or by a third-party authentication provider such as Facebook or Google login.

Authorization is a related concept, which means that once we have verified the identity of a user, we can then determine what that user is allowed to do. For example, a user may be authorized to view a product, but not to edit it.

The term auth is shorthand for both authentication and authorization.

Auth in Vendure applies to both administrators and customers. Authentication is controlled by the configured AuthenticationStrategies, and authorization is controlled by the configured Roles and Permissions.

## Administrator auth​


[​](#administrator-auth)Administrators are required to authenticate before they can perform any operations in the Admin API.

Here is a diagram of the parts that make up Administrator authentication:

Roles can be created to allow fine-grained control over what a particular administrator has access to (see the section below).

## Customer auth​


[​](#customer-auth)Customer only need to authenticate if they want to access a restricted operation related to their account, such as
viewing past orders or updating an address.

Here are the parts that make up Customer authentication:

### Guest customers​


[​](#guest-customers)Vendure also supports guest customers, meaning that a customer can place an order without needing to register an account, and thus not getting an
associated user or role. A guest customer, having no roles and thus no permissions, is then unable to view past orders or access any other restricted API
operations.

However, a guest customer can at a later point register an account using the same email address, at which point they will get a user with the "Customer" role,
and be able to view their past orders.

## Roles & Permissions​


[​](#roles--permissions)Both the Customer and Administrator entities relate to a single User entity which in turn has one or more Roles for controlling permissions.

[User](/reference/typescript-api/entities/user/)[Roles](/reference/typescript-api/entities/role/)In the example above, the administrator Sam Bailey has two roles assigned: "Order Manager" and "Catalog Manager". An administrator
can have any number of roles assigned, and the permissions of all roles are combined to determine the permissions of the
administrator. In this way, you can have fine-grained control over which administrators can perform which actions.

There are 2 special roles which are created by default and cannot be changed:

- SuperAdmin: This role has all permissions, and cannot be edited or deleted. It is assigned to the first administrator
created when the server is started.
- Customer: This role is assigned to all registered customers.

All other roles can be user-defined. Here's an example of an "Inventory Manager" role being defined in the Admin UI:

## Native authentication​


[​](#native-authentication)By default, Vendure uses a username/email address and password to authenticate users, which is implemented by the NativeAuthenticationStrategy.

[NativeAuthenticationStrategy](/reference/typescript-api/auth/native-authentication-strategy/)There is a login mutation available in both the Shop API and Admin API which allows a customer or administrator to authenticate using
native authentication:

```
mutation {  login(username: "superadmin", password: "superadmin") {    ...on CurrentUser {      id      identifier    }    ...on ErrorResult {      errorCode      message    }  }}
```

See the Managing Sessions guide for how to manage authenticated sessions in your storefront/client applications.

[Managing Sessions guide](/guides/storefront/connect-api/#managing-sessions)
## External authentication​


[​](#external-authentication)In addition to the built-in NativeAuthenticationStrategy, it is possible to define a custom AuthenticationStrategy which allows your Vendure server to support other authentication methods such as:

[AuthenticationStrategy](/reference/typescript-api/auth/authentication-strategy)- Social logins (Facebook, Google, GitHub, etc.)
- Single Sign-On (SSO) providers such as Keycloak, Auth0, etc.
- Alternative factors such as SMS, TOTP, etc.

Custom authentication strategies are set via the VendureConfig.authOptions object:

[VendureConfig.authOptions object](/reference/typescript-api/auth/auth-options/#shopauthenticationstrategy)
```
import { VendureConfig, NativeAuthenticationStrategy } from '@vendure/core';import { FacebookAuthenticationStrategy } from './plugins/authentication/facebook-authentication-strategy';import { GoogleAuthenticationStrategy } from './plugins/authentication/google-authentication-strategy';import { KeycloakAuthenticationStrategy } from './plugins/authentication/keycloak-authentication-strategy';export const config: VendureConfig = {  authOptions: {      shopAuthenticationStrategy: [        new NativeAuthenticationStrategy(),        new FacebookAuthenticationStrategy(),        new GoogleAuthenticationStrategy(),      ],      adminAuthenticationStrategy: [        new NativeAuthenticationStrategy(),        new KeycloakAuthenticationStrategy(),      ],  }}
```

In the above example, we define the strategies available for authenticating in the Shop API and the Admin API. The NativeAuthenticationStrategy is the only one actually provided by Vendure out-of-the-box, and this is the default username/email + password strategy.

The other strategies would be custom-built (or provided by future npm packages) by creating classes that implement the AuthenticationStrategy interface.

[AuthenticationStrategy interface](/reference/typescript-api/auth/authentication-strategy)Let's take a look at a couple of examples of what a custom AuthenticationStrategy implementation would look like.

## Custom authentication examples​


[​](#custom-authentication-examples)
### Google authentication​


[​](#google-authentication)This example demonstrates how to implement a Google login flow.

#### Storefront setup​


[​](#storefront-setup)In your storefront, you need to integrate the Google sign-in button as described in "Integrating Google Sign-In into your web app". Successful authentication will result in a onSignIn function being called in your app. It will look something like this:

["Integrating Google Sign-In into your web app"](https://developers.google.com/identity/sign-in/web/sign-in)
```
function onSignIn(googleUser) {  graphQlQuery(    `mutation Authenticate($token: String!) {        authenticate(input: {          google: { token: $token }        }) {        ...on CurrentUser {            id            identifier        }      }    }`,    { token: googleUser.getAuthResponse().id_token }  ).then(() => {    // redirect to account page  });}
```

#### Backend​


[​](#backend)On the backend, you'll need to define an AuthenticationStrategy to take the authorization token provided by the
storefront in the authenticate mutation, and use it to get the necessary personal information on that user from
Google.

To do this you'll need to install the google-auth-library npm package as described in the "Authenticate with a backend server" guide.

["Authenticate with a backend server" guide](https://developers.google.com/identity/sign-in/web/backend-auth)
```
import {    AuthenticationStrategy,    ExternalAuthenticationService,    Injector,    RequestContext,    User,} from '@vendure/core';import { OAuth2Client } from 'google-auth-library';import { DocumentNode } from 'graphql';import gql from 'graphql-tag';export type GoogleAuthData = {    token: string;};export class GoogleAuthenticationStrategy implements AuthenticationStrategy<GoogleAuthData> {    readonly name = 'google';    private client: OAuth2Client;    private externalAuthenticationService: ExternalAuthenticationService;    constructor(private clientId: string) {        // The clientId is obtained by creating a new OAuth client ID as described        // in the Google guide linked above.        this.client = new OAuth2Client(clientId);    }    init(injector: Injector) {        // The ExternalAuthenticationService is a helper service which encapsulates much        // of the common functionality related to dealing with external authentication        // providers.        this.externalAuthenticationService = injector.get(ExternalAuthenticationService);    }    defineInputType(): DocumentNode {        // Here we define the expected input object expected by the `authenticate` mutation        // under the "google" key.        return gql`        input GoogleAuthInput {            token: String!        }    `;    }    async authenticate(ctx: RequestContext, data: GoogleAuthData): Promise<User | false> {        // Here is the logic that uses the token provided by the storefront and uses it        // to find the user data from Google.        const ticket = await this.client.verifyIdToken({            idToken: data.token,            audience: this.clientId,        });        const payload = ticket.getPayload();        if (!payload || !payload.email) {            return false;        }        // First we check to see if this user has already authenticated in our        // Vendure server using this Google account. If so, we return that        // User object, and they will be now authenticated in Vendure.        const user = await this.externalAuthenticationService.findCustomerUser(ctx, this.name, payload.sub);        if (user) {            return user;        }        // If no user was found, we need to create a new User and Customer based        // on the details provided by Google. The ExternalAuthenticationService        // provides a convenience method which encapsulates all of this into        // a single method call.        return this.externalAuthenticationService.createCustomerAndUser(ctx, {            strategy: this.name,            externalIdentifier: payload.sub,            verified: payload.email_verified || false,            emailAddress: payload.email,            firstName: payload.given_name,            lastName: payload.family_name,        });    }}
```

### Facebook authentication​


[​](#facebook-authentication)This example demonstrates how to implement a Facebook login flow.

#### Storefront setup​


[​](#storefront-setup-1)In this example, we are assuming the use of the Facebook SDK for JavaScript in the storefront.

[Facebook SDK for JavaScript](https://developers.facebook.com/docs/javascript/)An implementation in React might look like this:

```
/** * Renders a Facebook login button. */export const FBLoginButton = () => {    const fnName = `onFbLoginButtonSuccess`;    const router = useRouter();    const [error, setError] = useState('');    const [socialLoginMutation] = useMutation(AuthenticateDocument);    useEffect(() => {        (window as any)[fnName] = function() {            FB.getLoginStatus(login);        };        return () => {            delete (window as any)[fnName];        };    }, []);    useEffect(() => {        window?.FB?.XFBML.parse();    }, []);    const login = async (response: any) => {        const {status, authResponse} = response;        if (status === 'connected') {            const result = await socialLoginMutation({variables: {token: authResponse.accessToken}});            if (result.data?.authenticate.__typename === 'CurrentUser') {                // The user has logged in, refresh the browser                trackLogin('facebook');                router.reload();                return;            }        }        setError('An error occurred!');    };    return (        <div className="text-center" style={{ width: 188, height: 28 }}>            <FacebookSDK />            <div                className="fb-login-button"                data-width=""                data-size="medium"                data-button-type="login_with"                data-layout="default"                data-auto-logout-link="false"                data-use-continue-as="false"                data-scope="public_profile,email"                data-onlogin={`${fnName}();`}            />            {error && <div className="text-sm text-red-500">{error}</div>}        </div>  );};
```

#### Backend​


[​](#backend-1)
```
import {    AuthenticationStrategy,    ExternalAuthenticationService,    Injector,    Logger,    RequestContext,    User,    UserService,} from '@vendure/core';import { DocumentNode } from 'graphql';import gql from 'graphql-tag';import fetch from 'node-fetch';export type FacebookAuthData = {    token: string;};export type FacebookAuthConfig = {    appId: string;    appSecret: string;    clientToken: string;};export class FacebookAuthenticationStrategy implements AuthenticationStrategy<FacebookAuthData> {    readonly name = 'facebook';    private externalAuthenticationService: ExternalAuthenticationService;    private userService: UserService;    constructor(private config: FacebookAuthConfig) {    }    init(injector: Injector) {        // The ExternalAuthenticationService is a helper service which encapsulates much        // of the common functionality related to dealing with external authentication        // providers.        this.externalAuthenticationService = injector.get(ExternalAuthenticationService);        this.userService = injector.get(UserService);    }    defineInputType(): DocumentNode {        // Here we define the expected input object expected by the `authenticate` mutation        // under the "google" key.        return gql`      input FacebookAuthInput {        token: String!      }    `;    }    private async getAppAccessToken() {        const resp = await fetch(            `https://graph.facebook.com/oauth/access_token?client_id=${this.config.appId}&client_secret=${this.config.appSecret}&grant_type=client_credentials`,        );        return await resp.json();    }    async authenticate(ctx: RequestContext, data: FacebookAuthData): Promise<User | false> {        const {token} = data;        const {access_token} = await this.getAppAccessToken();        const resp = await fetch(            `https://graph.facebook.com/debug_token?input_token=${token}&access_token=${access_token}`,        );        const result = await resp.json();        if (!result.data) {            return false;        }        const uresp = await fetch(`https://graph.facebook.com/me?access_token=${token}&fields=email,first_name,last_name`);        const uresult = (await uresp.json()) as { id?: string; email: string; first_name: string; last_name: string };        if (!uresult.id) {            return false;        }        const existingUser = await this.externalAuthenticationService.findCustomerUser(ctx, this.name, uresult.id);        if (existingUser) {            // This will select all the auth methods            return (await this.userService.getUserById(ctx, existingUser.id))!;        }        Logger.info(`User Create: ${JSON.stringify(uresult)}`);        const user = await this.externalAuthenticationService.createCustomerAndUser(ctx, {            strategy: this.name,            externalIdentifier: uresult.id,            verified: true,            emailAddress: uresult.email,            firstName: uresult.first_name,            lastName: uresult.last_name,        });        user.verified = true;        return user;    }}
```

### Keycloak authentication​


[​](#keycloak-authentication)Here's an example of an AuthenticationStrategy intended to be used on the Admin API. The use-case is when the company has an existing identity server for employees, and you'd like your Vendure shop admins to be able to authenticate with their existing accounts.

This example uses Keycloak, a popular open-source identity management server. To get your own Keycloak server up and running in minutes, follow the Keycloak on Docker guide.

[Keycloak](https://www.keycloak.org/)[Keycloak on Docker](https://www.keycloak.org/getting-started/getting-started-docker)
#### Configure a login page & Admin UI​


[​](#configure-a-login-page--admin-ui)In this example, we'll assume the login page is hosted at http://intranet/login. We'll also assume that a "login to Vendure" button has been added to that page and that the page is using the Keycloak JavaScript adapter, which can be used to get the current user's authorization token:

[Keycloak JavaScript adapter](https://www.keycloak.org/docs/latest/securing_apps/index.html#_javascript_adapter)
```
const vendureLoginButton = document.querySelector('#vendure-login-button');vendureLoginButton.addEventListener('click', () => {  return graphQlQuery(`    mutation Authenticate($token: String!) {      authenticate(input: {        keycloak: {          token: $token        }      }) {        ...on CurrentUser { id }      }    }`,    { token: keycloak.token },  )  .then((result) => {      if (result.data?.authenticate.user) {          // successfully authenticated - redirect to Vendure Admin UI          window.location.replace('http://localhost:3000/admin');      }  });});
```

We also need to tell the Admin UI application about the custom login URL, since we have no need for the default "username/password" login form. This can be done by setting the loginUrl property in the AdminUiConfig:

[loginUrl property](/reference/typescript-api/common/admin-ui/admin-ui-config#loginurl)
```
import { VendureConfig } from '@vendure/core';import { AdminUiPlugin } from '@vendure/admin-ui-plugin';export const config: VendureConfig = {    // ...    plugins: [        AdminUiPlugin.init({            port: 5001,            adminUiConfig: {                loginUrl: 'http://intranet/login',            },        }),    ],};
```

#### Backend​


[​](#backend-2)First we will need to be making an HTTP call to our Keycloak server to validate the token and get the user's details. We'll use the node-fetch library to make the HTTP call:

[node-fetch](https://www.npmjs.com/package/node-fetch)
```
npm install node-fetch
```

The strategy is very similar to the Google authentication example (they both use the OpenID Connect standard), so we'll not duplicate the explanatory comments here:

```
import fetch from 'node-fetch';import {    AuthenticationStrategy,    ExternalAuthenticationService,    Injector,    Logger,    RequestContext,    RoleService,    User,} from '@vendure/core';import { DocumentNode } from 'graphql';import gql from 'graphql-tag';export type KeycloakAuthData = {    token: string;};export class KeycloakAuthenticationStrategy implements AuthenticationStrategy<KeycloakAuthData> {    readonly name = 'keycloak';    private externalAuthenticationService: ExternalAuthenticationService;    private httpService: HttpService;    private roleService: RoleService;    init(injector: Injector) {        this.externalAuthenticationService = injector.get(ExternalAuthenticationService);        this.httpService = injector.get(HttpService);        this.roleService = injector.get(RoleService);    }    defineInputType(): DocumentNode {        return gql`      input KeycloakAuthInput {        token: String!      }    `;    }    async authenticate(ctx: RequestContext, data: KeycloakAuthData): Promise<User | false> {        const { data: userInfo } = await fetch(            'http://localhost:9000/auth/realms/myrealm/protocol/openid-connect/userinfo', {                headers: {                    Authorization: `Bearer ${data.token}`,                },            }).then(res => res.json());        if (!userInfo) {            return false;        }        const user = await this.externalAuthenticationService.findAdministratorUser(ctx, this.name, userInfo.sub);        if (user) {            return user;        }        // When creating an Administrator, we need to know what Role(s) to assign.        // In this example, we've created a "merchant" role and assign that to all        // new Administrators. In a real implementation, you can have more complex        // logic to map an external user to a given role.        const roles = await this.roleService.findAll();        const merchantRole = roles.items.find((r) => r.code === 'merchant');        if (!merchantRole) {            Logger.error(`Could not find "merchant" role`);            return false;        }        return this.externalAuthenticationService.createAdministratorAndUser(ctx, {            strategy: this.name,            externalIdentifier: userInfo.sub,            identifier: userInfo.preferred_username,            emailAddress: userInfo.email,            firstName: userInfo.given_name,            lastName: userInfo.family_name,            roles: [merchantRole],        });    }}
```

---

# Channels


Channels are a feature of Vendure which allows multiple sales channels to be represented in a single Vendure instance. A Channel allows you to:

- Set Channel-specific currency, language, tax and shipping defaults
- Assign only specific products to the channel (with channel-specific prices)
- Create administrator roles limited to one or more channels
- Assign specific stock locations, assets, facets, collections, promotions, and other entities to the channel
- Have orders and customers associated with specific channels.

This is useful for a number of use-cases, including:

- Multi-tenancy: Each channel can be configured with its own set of products, shipping methods, payment methods, etc. This
allows you to run multiple shops from a single Vendure server.
- Multi-vendor: Each channel can represent a distinct vendor or seller, which can be used to implement a marketplace.
- Region-specific stores: Each channel can be configured with its own set of languages, currencies, tax rates, etc. This
allows you to run multiple stores for different regions from a single Vendure server.
- Distinct sales channels: Each channel can represent a sales channel of a single business, with one channel for the online
store, one for selling via Amazon, one for selling via Facebook etc.

Every Vendure server always has a default Channel, which contains all entities. Subsequent channels can then contain a subset of channel-aware entities.

## Channel-aware entities​


[​](#channel-aware-entities)Many entities are channel-aware, meaning that they can be associated with a multiple channels. The following entities are channel-aware:

- Asset
- Collection
- Customer
- Facet
- FacetValue
- Order
- PaymentMethod
- Product
- ProductVariant
- Promotion
- Role
- ShippingMethod
- StockLocation

[Asset](/reference/typescript-api/entities/asset/)[Collection](/reference/typescript-api/entities/collection/)[Customer](/reference/typescript-api/entities/customer/)[Facet](/reference/typescript-api/entities/facet/)[FacetValue](/reference/typescript-api/entities/facet-value/)[Order](/reference/typescript-api/entities/order/)[PaymentMethod](/reference/typescript-api/entities/payment-method/)[Product](/reference/typescript-api/entities/product/)[ProductVariant](/reference/typescript-api/entities/product-variant/)[Promotion](/reference/typescript-api/entities/promotion/)[Role](/reference/typescript-api/entities/role/)[ShippingMethod](/reference/typescript-api/entities/shipping-method/)[StockLocation](/reference/typescript-api/entities/stock-location/)
## Channels & Sellers​


[​](#channels--sellers)Each channel is also assigned a single Seller. This entity is used to represent
the vendor or seller of the products in the channel. This is useful for implementing a marketplace, where each channel represents
a distinct vendor. The Seller entity can be extended with custom fields to store additional information about the seller, such as a logo, contact details etc.

[Seller](/reference/typescript-api/entities/seller/)[custom fields](/guides/developer-guide/custom-fields/)
## Channels, Currencies & Prices​


[​](#channels-currencies--prices)Each Channel has a set of availableCurrencyCodes, and one of these is designated as the defaultCurrencyCode, which sets the default currency for all monetary values in that channel.

Internally, there is a one-to-many relation from ProductVariant to ProductVariantPrice. So the ProductVariant does not hold a price for the product - this is actually stored on the ProductVariantPrice entity, and there will be at least one for each Channel to which the ProductVariant has been assigned.

[ProductVariant](/reference/typescript-api/entities/product-variant/)[ProductVariantPrice](/reference/typescript-api/entities/product-variant-price)In this diagram we can see that every channel has at least 1 ProductVariantPrice. In the case of the UK Channel, there are 2 prices assigned - one for
GBP and one for USD. This means that you are able to define multiple prices in different currencies on a single product variant for a single channel.

Note: in the diagram above that the ProductVariant is always assigned to the default Channel, and thus will have a price in the default channel too. Likewise, the default Channel also has a defaultCurrencyCode. Depending on your requirements, you may or may not make use of the default Channel.

### Keeping prices synchronized​


[​](#keeping-prices-synchronized)When you have products assigned to multiple channels, updates to the price of a product in one channel will not automatically
be reflected in other channels. For instance, in the diagram above, both the Default channel and the UK channel have a price
in USD for the same product variant.

If an administrator of the UK channel changes the USD price to $20, the price in the Default channel will remain at $30. This
is the default behavior, and is controlled by the ProductVariantPriceUpdateStrategy.

[ProductVariantPriceUpdateStrategy](/reference/typescript-api/configuration/product-variant-price-update-strategy)If you want to keep prices synchronized across all channels, you can set the syncPricesAcrossChannels property of the
DefaultProductVariantPriceUpdateStrategy
to true. This will ensure that when the price of a product variant is updated in one channel, the price in all other channels
(of that particular currency) will be updated to match.

[DefaultProductVariantPriceUpdateStrategy](/reference/typescript-api/configuration/product-variant-price-update-strategy#defaultproductvariantpriceupdatestrategy)
```
import { DefaultProductVariantPriceUpdateStrategy, VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    productVariantPriceUpdateStrategy: new DefaultProductVariantPriceUpdateStrategy({        syncPricesAcrossChannels: true,    }),    // ...};
```

You may however require even more sophisticated logic. For instance, you may want a one-way synchronization, where the price
in the Default channel is always the master price, and the prices in other channels are updated to match. In this case, you
can create a custom ProductVariantPriceUpdateStrategy which implements the desired logic.

## Use cases​


[​](#use-cases)
### Single shop​


[​](#single-shop)This is the simplest set-up. You just use the default Channel for everything.

### Multiple separate shops​


[​](#multiple-separate-shops)Let's say you are running multiple distinct businesses, each with its own distinct inventory and possibly different currencies. In this case, you set up a Channel for each shop and create the Product & Variants in the relevant shop's Channel.

The default Channel can then be used by the superadmin for administrative purposes, but other than that the default Channel would not be used. Storefronts would only target a specific shop's Channel.

### Multiple shops sharing inventory​


[​](#multiple-shops-sharing-inventory)Let's say you have a single inventory but want to split it between multiple shops. There might be overlap in the inventory, e.g. the US & EU shops share 80% of inventory, and then the rest is specific to either shop.

In this case, you can create the entire inventory in the default Channel and then assign the Products & ProductVariants to each Channel as needed, setting the price as appropriate for the currency used by each shop.

Note: When creating a new Product & ProductVariants inside a sub-Channel, it will also always get assigned to the default Channel. If your sub-Channel uses a different currency from the default Channel, you should be aware that in the default Channel, that ProductVariant will be assigned the same price as it has in the sub-Channel. If the currency differs between the Channels, you need to make sure to set the correct price in the default Channel if you are exposing it to Customers via a storefront.

### Multi-vendor marketplace​


[​](#multi-vendor-marketplace)This is the most advanced use of channels. For a detailed guide to this use-case, see our Multi-vendor marketplace guide.

[Multi-vendor marketplace guide](/guides/how-to/multi-vendor-marketplaces/)
## Specifying channel in the GraphQL API​


[​](#specifying-channel-in-the-graphql-api)To specify which channel to use when making an API call, set the 'vendure-token' header to match the token of the desired Channel.

For example, if we have a UK Channel with the token set to "uk-channel" as shown in this screenshot:

Then we can make a GraphQL API call to the UK Channel by setting the 'vendure-token' header to 'uk-channel':

```
const { loading, error, data } = useQuery(GET_PRODUCT_LIST, {    context: {        headers: {            'vendure-token': 'uk-channel',        },    },});
```

This is an example using Apollo Client in React. The same principle applies to any GraphQL client library - set the 'vendure-token' header to the token of the desired Channel.

With the above header set, the API call will be made to the UK Channel, and the response will contain only the entities which are assigned to that Channel.


---

# Collections


Collections are used to categorize and organize your catalog. A collection
contains multiple product variants, and a product variant can belong to multiple collections. Collections can be nested to
create a hierarchy of categories, which is typically used to create a menu structure in the storefront.

[Collections](/reference/typescript-api/entities/collection/)Collections are not only used as the basis of storefront navigation. They are a general-purpose organization tool which can be used
for many purposes, such as:

- Creating a collection of "new arrivals" which is used on the homepage.
- Creating a collection of "best sellers" which is used to display a list of popular products.
- Creating a collection of "sale items" which is used to apply a discount to all products in the collection, via a promotion.

## Collection filters​


[​](#collection-filters)The specific product variants that belong to a collection are determined by the collection's CollectionFilters.
A collection filter is a piece of logic which is used to determine whether a product variant should be included in the collection. By default, Vendure
includes a number of collection filters:

[CollectionFilters](/reference/typescript-api/configuration/collection-filter/)- Filter by facet values: Include all product variants which have a specific set of facet values.
- Filter by product variant name: Include all product variants whose name matches a specific string.
- Manually select product variants: Allows manual selection of individual product variants.
- Manually select products: Allows manual selection of entire products, and then includes all variants of those products.

It is also possible to create your own custom collection filters, which can be used to implement more complex logic. See the section on creating a collection filter for more details.

[creating a collection filter](#creating-a-collection-filter)
### Filter inheritance​


[​](#filter-inheritance)When a collection is nested within another collection, the child collection can inherit the parent's collection filters. This means that the child collection
will combine its own filters with the parent's filters.

In the example above, we have a parent collection "Menswear", with a child collection "Mens' Casual". The parent collection has a filter which includes all
product variants with the "clothing" and "mens" facet values. The child collection is set to inherit the parent's filters, and has an additional filter which
includes all product variants with the "casual" facet value.

Thus, the child collection will include all product variants which have the "clothing", "mens" and "casual" facet values.

When filter inheritance is enabled, a child collection will contain a subset of the product variants of its parent collection.

In order to create a child collection which contains product variants not contained by the parent collection, you must disable filter inheritance
in the child collection.

### Creating a collection filter​


[​](#creating-a-collection-filter)You can create your own custom collection filters with the CollectionFilter class. This class
is a configurable operation where the specific
filtering logic is implemented in the apply() method passed to its constructor.

[CollectionFilter](/reference/typescript-api/configuration/collection-filter/)[configurable operation](/guides/developer-guide/strategies-configurable-operations/#configurable-operations)The apply() method receives an instance of the TypeORM SelectQueryBuilder which should have filtering logic
added to it using the .andWhere() method.

[TypeORM SelectQueryBuilder](https://typeorm.io/select-query-builder)Here's an example of a collection filter which filters by SKU:

```
import { CollectionFilter, LanguageCode } from '@vendure/core';export const skuCollectionFilter = new CollectionFilter({    args: {        // The `args` object defines the user-configurable arguments        // which will get passed to the filter's `apply()` function.        sku: {            type: 'string',            label: [{ languageCode: LanguageCode.en, value: 'SKU' }],            description: [                {                    languageCode: LanguageCode.en,                    value: 'Matches any product variants with an SKU containing this value',                },            ],        },    },    code: 'variant-sku-filter',    description: [{ languageCode: LanguageCode.en, value: 'Filter by matching SKU' }],    // This is the function that defines the logic of the filter.    apply: (qb, args) => {        // Sometimes syntax differs between database types, so we use        // the `type` property of the connection options to determine        // which syntax to use.        const LIKE = qb.connection.options.type === 'postgres' ? 'ILIKE' : 'LIKE';        return qb.andWhere(`productVariant.sku ${LIKE} :sku`, {            sku: `%${args.sku}%`        });    },});
```

In the apply() method, the product variant entity is aliased as 'productVariant'.

This custom filter is then added to the defaults in your config:

```
import { defaultCollectionFilters, VendureConfig } from '@vendure/core';import { skuCollectionFilter } from './config/sku-collection-filter';export const config: VendureConfig = {    // ...    catalogOptions: {        collectionFilters: [            ...defaultCollectionFilters,            skuCollectionFilter        ],    },};
```

To see some more advanced collection filter examples, you can look at the source code of the
default collection filters.

[default collection filters](https://github.com/vendure-ecommerce/vendure/blob/master/packages/core/src/config/catalog/default-collection-filters.ts)


---

# Customers


A Customer is a person who can buy from your shop. A customer can have one or more
Addresses, which are used for shipping and billing.

[Customer](/reference/typescript-api/entities/customer/)[Addresses](/reference/typescript-api/entities/address/)If a customer has registered an account, they will have an associated User. The user
entity is used for authentication and authorization. Guest checkouts are also possible, in which case a customer will not have a user.

[User](/reference/typescript-api/entities/user/)See the Auth guide for a detailed explanation of the relationship between
customers and users.

[Auth guide](/guides/core-concepts/auth/#customer-auth)Customers can be organized into CustomerGroups. These groups can be used in
logic relating to promotions, shipping rules, payment rules etc. For example, you could create a "VIP" customer group and then create
a promotion which grants members of this group free shipping. Or a "B2B" group which is used in a custom tax calculator to
apply a different tax rate to B2B customers.

[CustomerGroups](/reference/typescript-api/entities/customer-group/)

---

# Email & Notifications


A typical ecommerce application needs to notify customers of certain events, such as when they place an order or
when their order has been shipped. This is usually done via email, but can also be done via SMS or push notifications.

## Email​


[​](#email)Email is the most common way to notify customers of events, so a default Vendure installation includes our EmailPlugin.

[EmailPlugin](/reference/core-plugins/email-plugin)The EmailPlugin by default uses Nodemailer to send emails via a variety of
different transports, including SMTP, SendGrid, Mailgun, and more.
The plugin is configured with a list of EmailEventHandlers which are responsible for
sending emails in response to specific events.

[Nodemailer](https://nodemailer.com/about/)[EmailEventHandlers](/reference/core-plugins/email-plugin/email-event-handler)This guide will cover some of the main concepts of the EmailPlugin, but for a more in-depth look at how to configure
and use it, see the EmailPlugin API docs.

[EmailPlugin API docs](/reference/core-plugins/email-plugin)Here's an illustration of the flow of an email being sent:

All emails are triggered by a particular Event - in this case when the state of an
Order changes. The EmailPlugin ships with a set of default email handlers,
one of which is responsible for sending "order confirmation" emails.

[Event](/guides/developer-guide/events/)[default email handlers](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/default-email-handlers.ts)
### EmailEventHandlers​


[​](#emaileventhandlers)Let's take a closer look at a simplified version of the orderConfirmationHandler:

```
import { OrderStateTransitionEvent } from '@vendure/core';import { EmailEventListener, transformOrderLineAssetUrls, hydrateShippingLines } from '@vendure/email-plugin';// The 'order-confirmation' string is used by the EmailPlugin to identify// which template to use when rendering the email.export const orderConfirmationHandler = new EmailEventListener('order-confirmation')    .on(OrderStateTransitionEvent)    // Only send the email when the Order is transitioning to the    // "PaymentSettled" state and the Order has a customer associated with it.    .filter(        event =>            event.toState === 'PaymentSettled'            && !!event.order.customer,    )    // We commonly need to load some additional data to be able to render the email    // template. This is done via the `loadData()` method. In this method we are    // mutating the Order object to ensure that product images are correctly    // displayed in the email, as well as fetching shipping line data from the database.    .loadData(async ({ event, injector }) => {        transformOrderLineAssetUrls(event.ctx, event.order, injector);        const shippingLines = await hydrateShippingLines(event.ctx, event.order, injector);        return { shippingLines };    })    // Here we are setting the recipient of the email to be the    // customer's email address.    .setRecipient(event => event.order.customer!.emailAddress)    // We can interpolate variables from the EmailPlugin's configured    // `globalTemplateVars` object.    .setFrom('{{ fromAddress }}')    // We can also interpolate variables made available by the    // `setTemplateVars()` method below    .setSubject('Order confirmation for #{{ order.code }}')    // The object returned here defines the variables which are    // available to the email template.    .setTemplateVars(event => ({ order: event.order, shippingLines: event.data.shippingLines }))
```

To recap:

- The handler listens for a specific event
- It optionally filters those events to determine whether an email should be sent
- It specifies the details of the email to be sent, including the recipient, subject, template variables, etc.

The full range of methods available when setting up an EmailEventHandler can be found in the EmailEventHandler API docs.

[EmailEventHandler API docs](/reference/core-plugins/email-plugin/email-event-handler)
### Email variables​


[​](#email-variables)In the example above, we used the setTemplateVars() method to define the variables which are available to the email template.
Additionally, there are global variables which are made available to all email templates & EmailEventHandlers. These are
defined in the globalTemplateVars property of the EmailPlugin config:

```
import { VendureConfig } from '@vendure/core';import { EmailPlugin } from '@vendure/email-plugin';export const config: VendureConfig = {    // ...    plugins: [        EmailPlugin.init({            // ...            globalTemplateVars: {                fromAddress: '"MyShop" <noreply@myshop.com>',                verifyEmailAddressUrl: 'https://www.myshop.com/verify',                passwordResetUrl: 'https://www.myshop.com/password-reset',                changeEmailAddressUrl: 'https://www.myshop.com/verify-email-address-change'            },        }),    ],};
```

### Email integrations​


[​](#email-integrations)The EmailPlugin is designed to be flexible enough to work with many different email services. The default
configuration uses Nodemailer to send emails via SMTP, but you can easily configure it to use a different
transport. For instance:

- AWS SES
- SendGrid

[AWS SES](https://www.vendure.io/marketplace/aws-ses)[SendGrid](https://www.vendure.io/marketplace/sendgrid)
## Other notification methods​


[​](#other-notification-methods)The pattern of listening for events and triggering some action in response is not limited to emails. You can
use the same pattern to trigger other actions, such as sending SMS messages or push notifications. For instance,
let's say you wanted to create a plugin which sends an SMS message to the customer when their order is shipped.

This is just a simplified example to illustrate the pattern.

```
import { OnModuleInit } from '@nestjs/common';import { PluginCommonModule, VendurePlugin, EventBus } from '@vendure/core';import { OrderStateTransitionEvent } from '@vendure/core';// A custom service which sends SMS messages// using a third-party SMS provider such as Twilio.import { SmsService } from './sms.service';@VendurePlugin({    imports: [PluginCommonModule],    providers: [SmsService],})export class SmsPlugin implements OnModuleInit {    constructor(        private eventBus: EventBus,        private smsService: SmsService,    ) {}    onModuleInit() {        this.eventBus            .ofType(OrderStateTransitionEvent)            .filter(event => event.toState === 'Shipped')            .subscribe(event => {                this.smsService.sendOrderShippedMessage(event.order);            });    }}
```

---

# Images & Assets


Assets are used to store files such as images, videos, PDFs, etc. Assets can be
assigned to products, variants and collections by default. By using custom fields it is
possible to assign assets to other entities. For example, for implementing customer profile images.

[Assets](/reference/typescript-api/entities/asset/)[custom fields](/guides/developer-guide/custom-fields/)The handling of assets in Vendure is implemented in a modular way, allowing you full control over the way assets
are stored, named, imported and previewed.

- An asset is created by uploading an image. Internally the createAssets mutation will be executed.
- The AssetNamingStrategy is used to generate file names for the source image and the preview. This is useful for normalizing file names as well as handling name conflicts.
- The AssetPreviewStrategy generates a preview image of the asset. For images, this typically involves creating a version with constraints on the maximum dimensions. It could also be used to e.g. generate a preview image for uploaded PDF files, videos or other non-image assets (such functionality would require a custom AssetPreviewStrategy to be defined).
- The source file as well as the preview image are then passed to the AssetStorageStrategy which stores the files to some form of storage. This could be the local disk or an object store such as AWS S3 or Minio.
- When an asset is later read, e.g. when a customer views a product detail page which includes an image of the product, the AssetStorageStrategy can be used to
read the file from the storage location.

[createAssets mutation](/reference/graphql-api/admin/mutations/#createassets)[AssetNamingStrategy](/reference/typescript-api/assets/asset-naming-strategy/)[AssetPreviewStrategy](/reference/typescript-api/assets/asset-preview-strategy)[AssetStorageStrategy](/reference/typescript-api/assets/asset-storage-strategy)
## AssetServerPlugin​


[​](#assetserverplugin)Vendure comes with the @vendure/asset-server-plugin package pre-installed. This provides the AssetServerPlugin which provides many advanced features to make working with
assets easier.

[AssetServerPlugin](/reference/core-plugins/asset-server-plugin/)The plugin provides a ready-made set of strategies for handling assets, but also allows you to replace these defaults with
your own implementations. For example, here are instructions on how to replace the default storage strategy with one
that stores your assets on AWS S3 or Minio: configure S3 asset storage

[configure S3 asset storage](/reference/core-plugins/asset-server-plugin/s3asset-storage-strategy#configures3assetstorage)It also features a powerful image transformation API, which allows you to specify the dimensions, crop, and image format
using query parameters.

See the AssetServerPlugin docs for a detailed description of all the features.

[AssetServerPlugin docs](/reference/core-plugins/asset-server-plugin/)
## Asset Tags​


[​](#asset-tags)Assets can be tagged. A Tag is a simple text label that can be applied to an asset. An asset can have multiple tags or none. Tags are useful for organizing assets, since assets are otherwise organized as a flat list with no concept of a directory structure.

[Tag](/reference/typescript-api/entities/tag/)


---

# Money & Currency


In Vendure, monetary values are stored as integers using the minor unit of the selected currency.
For example, if the currency is set to USD, then the integer value 100 would represent $1.00.
This is a common practice in financial applications, as it avoids the rounding errors that can occur when using floating-point numbers.

For example, here's the response from a query for a product's variant prices:

```
{  "data": {    "product": {      "id": "42",      "variants": [        {          "id": "74",          "name": "Bonsai Tree",          "currencyCode": "USD",          "price": 1999,          "priceWithTax": 2399,        }      ]    }  }}
```

In this example, the tax-inclusive price of the variant is $23.99.

To illustrate the problem with storing money as decimals, imagine that we want to add the price of two items:

- Product A: $1.21
- Product B: $1.22

We should expect the sum of these two amounts to equal $2.43. However, if we perform this addition in JavaScript (and the same
holds true for most common programming languages), we will instead get $2.4299999999999997!

For a more in-depth explanation of this issue, see this StackOverflow answer

[this StackOverflow answer](https://stackoverflow.com/a/3730040/772859)
## Displaying monetary values​


[​](#displaying-monetary-values)When you are building your storefront, or any other client that needs to display monetary values in a human-readable form,
you need to divide by 100 to convert to the major currency unit and then format with the correct decimal & grouping dividers.

In JavaScript environments such as browsers & Node.js, we can take advantage of the excellent Intl.NumberFormat API.

[Intl.NumberFormat API](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl/NumberFormat)Here's a function you can use in your projects:

```
export function formatCurrency(value: number, currencyCode: string, locale?: string) {    const majorUnits = value / 100;    try {        // Note: if no `locale` is provided, the browser's default        // locale will be used.        return new Intl.NumberFormat(locale, {            style: 'currency',            currency: currencyCode,        }).format(majorUnits);    } catch (e: any) {        // A fallback in case the NumberFormat fails for any reason        return majorUnits.toFixed(2);    }}
```

If you are building an Dashboard extension, you can use the built-in useLocalFormat hook:

[useLocalFormat hook](/reference/dashboard/hooks/use-local-format)
```
import { useLocalFormat } from '@vendure/dashboard';export function MyComponent({ variant }: MyComponentProps) {    const { formatCurrency } = useLocalFormat();    return (        <div>            Variant price: { formatCurrency(variant.price, variant.currencyCode) }        </div>    )}
```

## Support for multiple currencies​


[​](#support-for-multiple-currencies)Vendure supports multiple currencies out-of-the-box. The available currencies must first be set at the Channel level
(see the Channels, Currencies & Prices section), and then
a price may be set on a ProductVariant in each of the available currencies.

[Channels, Currencies & Prices section](/guides/core-concepts/channels/#channels-currencies--prices)When using multiple currencies, the ProductVariantPriceSelectionStrategy
is used to determine which of the available prices to return when fetching the details of a ProductVariant. The default strategy
is to return the price in the currency of the current session request context, which is determined firstly by any ?currencyCode=XXX query parameter
on the request, and secondly by the defaultCurrencyCode of the Channel.

[ProductVariantPriceSelectionStrategy](/reference/typescript-api/configuration/product-variant-price-selection-strategy/)
## The GraphQL Money scalar​


[​](#the-graphql-money-scalar)In the GraphQL APIs, we use a custom Money scalar type to represent
all monetary values. We do this for two reasons:

[Money scalar type](/reference/graphql-api/admin/object-types/#money)- The built-in Int type is that the GraphQL spec imposes an upper limit of
2147483647, which in some cases (especially currencies with very large amounts) is not enough.
- Very advanced use-cases might demand more precision than is possible with an integer type. Using our own custom
scalar gives us the possibility of supporting more precision.

Here's how the Money scalar is used in the ShippingLine type:

```
type ShippingLine {    id: ID!    shippingMethod: ShippingMethod!    price: Money!    priceWithTax: Money!    discountedPrice: Money!    discountedPriceWithTax: Money!    discounts: [Discount!]!}
```

If you are defining custom GraphQL types, or adding fields to existing types (see the Extending the GraphQL API doc),
then you should also use the Money scalar for any monetary values.

[Extending the GraphQL API doc](/guides/developer-guide/extend-graphql-api/)
## The @Money() decorator​


[​](#the-money-decorator)When defining new database entities, if you need to store a monetary value, then rather than using the TypeORM @Column()
decorator, you should use Vendure's @Money() decorator.

[defining new database entities](/guides/developer-guide/database-entity)[@Money() decorator](/reference/typescript-api/money/money-decorator)Using this decorator allows Vendure to correctly store the value in the database according to the configured MoneyStrategy (see below).

```
import { DeepPartial } from '@vendure/common/lib/shared-types';import { VendureEntity, Order, EntityId, Money, CurrencyCode, ID } from '@vendure/core';import { Column, Entity, ManyToOne } from 'typeorm';@Entity()class Quote extends VendureEntity {    constructor(input?: DeepPartial<Quote>) {        super(input);    }    @ManyToOne(type => Order)    order: Order;    @EntityId()    orderId: ID;    @Column()    text: string;    @Money()    value: number;    // Whenever you store a monetary value, it's a good idea to also    // explicitly store the currency code too. This makes it possible    // to support multiple currencies and correctly format the amount    // when displaying the value.    @Column('varchar')    currencyCode: CurrencyCode;    @Column()    approved: boolean;}
```

## Advanced configuration: MoneyStrategy​


[​](#advanced-configuration-moneystrategy)For advanced use-cases, it is possible to configure aspects of how Vendure handles monetary values internally by defining
a custom MoneyStrategy.

[MoneyStrategy](/reference/typescript-api/money/money-strategy/)The MoneyStrategy allows you to define:

- How the value is stored and retrieved from the database
- How rounding is applied internally
- The precision represented by the monetary value (since v2.2.0)

For example, in addition to the DefaultMoneyStrategy, Vendure
also provides the BigIntMoneyStrategy which stores monetary values
using the bigint data type, allowing much larger amounts to be stored.

[DefaultMoneyStrategy](/reference/typescript-api/money/default-money-strategy)[BigIntMoneyStrategy](/reference/typescript-api/money/big-int-money-strategy)Here's how you would configure your server to use this strategy:

```
import { VendureConfig, BigIntMoneyStrategy } from '@vendure/core';export const config: VendureConfig = {    // ...    entityOptions: {        moneyStrategy: new BigIntMoneyStrategy(),    }}
```

### Example: supporting three decimal places​


[​](#example-supporting-three-decimal-places)Let's say you have a B2B store which sells products in bulk, and you want to support prices with three decimal places.
For example, you want to be able to sell a product for $1.234 per unit. To do this, you would need to:

- Configure the MoneyStrategy to use three decimal places

```
import { DefaultMoneyStrategy, VendureConfig } from '@vendure/core';export class ThreeDecimalPlacesMoneyStrategy extends DefaultMoneyStrategy {    readonly precision = 3;}export const config: VendureConfig = {    // ...    entityOptions: {        moneyStrategy: new ThreeDecimalPlacesMoneyStrategy(),    }};
```

- Set up your storefront to correctly convert the integer value to a decimal value with three decimal places. Using the
formatCurrency example above, we can modify it to divide by 1000 instead of 100:

```
export function formatCurrency(value: number, currencyCode: string, locale?: string) {    const majorUnits = value / 1000;    try {        return new Intl.NumberFormat(locale, {            style: 'currency',            currency: currencyCode,            minimumFractionDigits: 3,            maximumFractionDigits: 3,        }).format(majorUnits);    } catch (e: any) {        return majorUnits.toFixed(3);    }}
```


---

# Orders


In Vendure, the Order entity represents the entire lifecycle of an order, from the moment a customer adds an item to their cart, through to the point where the order is completed and the customer has received their goods.

[Order](/reference/typescript-api/entities/order/)An Order is composed of one or more OrderLines.
Each order line represents a single product variant, and contains information such as the quantity, price, tax rate, etc.

[Order](/reference/typescript-api/entities/order/)[OrderLines](/reference/typescript-api/entities/order-line/)In turn, the order is associated with a Customer and contains information such as
the shipping address, billing address, shipping method, payment method, etc.

[Customer](/reference/typescript-api/entities/customer/)
## The Order Process​


[​](#the-order-process)Vendure defines an order process which is based on a finite state machine (a method of precisely controlling how the order moves from one state to another). This means that the Order.state property will be one of a set of pre-defined states. From the current state, the Order can then transition (change) to another state, and the available next states depend on what the current state is.

[finite state machine](/reference/typescript-api/state-machine/fsm/)[Order.state property](/reference/typescript-api/entities/order/#state)[pre-defined states](/reference/typescript-api/orders/order-process/#orderstate)In Vendure, there is no distinction between a "cart" and an "order". The same entity is used for both. A "cart" is simply an order
which is still "active" according to its current state.

You can see the current state of an order via state field on the Order type:

- Request
- Response

```
query ActiveOrder {    activeOrder {        id        state    }}
```

```
{  "data": {    "activeOrder": {      "id": "4",      "state": "AddingItems"    }  }}
```

The next possible states can be queried via the nextOrderStates query:

[nextOrderStates](/reference/graphql-api/shop/queries/#nextorderstates)- Request
- Response

```
query NextStates {  nextOrderStates}
```

```
{  "data": {    "nextOrderStates": [      "ArrangingPayment",      "Cancelled"    ]  }}
```

The available states and the permissible transitions between them are defined by the configured OrderProcess. By default, Vendure defines a DefaultOrderProcess which is suitable for typical B2C use-cases. Here's a simplified diagram of the default order process:

[OrderProcess](/reference/typescript-api/orders/order-process/)[DefaultOrderProcess](/reference/typescript-api/orders/order-process/#defaultorderprocess)Let's take a look at each of these states, and the transitions between them:

- AddingItems: All orders begin in the AddingItems state. This means that the customer is adding items to his or her shopping cart. This is the state an order would be in as long as the customer is still browsing the store.
- ArrangingPayment: From there, the Order can transition to the ArrangingPayment, which will prevent any further modifications to the order, which ensures the price that is sent to the payment provider is the same as the price that the customer saw when they added the items to their cart. At this point, the storefront will execute the addPaymentToOrder mutation.
- PaymentAuthorized: Depending on the configured payment method, the order may then transition to the PaymentAuthorized state, which indicates that the payment has been successfully authorized by the payment provider. This is the state that the order will be in if the payment is not captured immediately. Once the payment is captured, the order will transition to the PaymentSettled state.
- PaymentSettled: If the payment captured immediately, the order will transition to the PaymentSettled state once the payment succeeds.
- At this point, one or more fulfillments can be created. A Fulfillment represents the process of shipping one or more items to the customer ("shipping" applies equally to physical or digital goods - it just means getting the product to the customer by any means). A fulfillment can be created via the addFulfillmentToOrder mutation, or via the Dashboard. If multiple fulfillments are created, then the order can end up partial states - PartiallyShipped or PartiallyDelivered. If there is only a single fulfillment which includes the entire order, then partial states are not possible.
- Shipped: When all fulfillments have been shipped, the order will transition to the Shipped state. This means the goods have left the warehouse and are en route to the customer.
- Delivered: When all fulfillments have been delivered, the order will transition to the Delivered state. This means the goods have arrived at the customer's address. This is the final state of the order.

[addPaymentToOrder mutation](/reference/graphql-api/shop/mutations/#addpaymenttoorder)[addFulfillmentToOrder mutation](/reference/graphql-api/admin/mutations/#addfulfillmenttoorder)
## Customizing the Default Order Process​


[​](#customizing-the-default-order-process)It is possible to customize the defaultOrderProcess to better match your business needs. For example, you might want to disable some of the constraints that are imposed by the default process, such as the requirement that a customer must have a shipping address before the Order can be completed.

[defaultOrderProcess](/reference/typescript-api/orders/order-process/#defaultorderprocess)This can be done by creating a custom version of the default process using the configureDefaultOrderProcess function, and then passing it to the OrderOptions.process config property.

[configureDefaultOrderProcess](/reference/typescript-api/orders/order-process/#configuredefaultorderprocess)[OrderOptions.process](/reference/typescript-api/orders/order-options/#process)
```
import { configureDefaultOrderProcess, VendureConfig } from '@vendure/core';const myCustomOrderProcess = configureDefaultOrderProcess({  // Disable the constraint that requires  // Orders to have a shipping method assigned  // before payment.  arrangingPaymentRequiresShipping: false,      // Other constraints which can be disabled. See the  // DefaultOrderProcessOptions interface docs for full  // explanations.  //    // checkModificationPayments: false,  // checkAdditionalPaymentsAmount: false,  // checkAllVariantsExist: false,  // arrangingPaymentRequiresContents: false,  // arrangingPaymentRequiresCustomer: false,  // arrangingPaymentRequiresStock: false,  // checkPaymentsCoverTotal: false,  // checkAllItemsBeforeCancel: false,  // checkFulfillmentStates: false,});export const config: VendureConfig = {  orderOptions: {    process: [myCustomOrderProcess],  },};
```

## Custom Order Processes​


[​](#custom-order-processes)Sometimes you might need to extend things beyond what is provided by the default Order process to better match your business needs. This is done by defining one or more OrderProcess objects and passing them to the OrderOptions.process config property.

[OrderProcess](/reference/typescript-api/orders/order-process#orderprocess)[OrderOptions.process](/reference/typescript-api/orders/order-options/#process)
### Adding a new state​


[​](#adding-a-new-state)Let's say your company can only sell to customers with a valid EU tax ID. We'll assume that you've already used a custom field to store that code on the Customer entity.

[custom field](/guides/developer-guide/custom-fields/)Now you want to add a step before the customer handles payment, where we can collect and verify the tax ID.

So we want to change the default process of:

```
AddingItems -> ArrangingPayment
```

to instead be:

```
AddingItems -> ValidatingCustomer -> ArrangingPayment
```

Here's how we would define the new state:

```
import { OrderProcess } from '@vendure/core';export const customerValidationProcess: OrderProcess<'ValidatingCustomer'> = {  transitions: {    AddingItems: {      to: ['ValidatingCustomer'],      mergeStrategy: 'replace',    },    ValidatingCustomer: {      to: ['ArrangingPayment', 'AddingItems'],    },  },};
```

This object means:

- the AddingItems state may only transition to the ValidatingCustomer state (mergeStrategy: 'replace' tells Vendure to discard any existing transition targets and replace with this one).
- the ValidatingCustomer may transition to the ArrangingPayment state (assuming the tax ID is valid) or back to the AddingItems state.

And then add this configuration to our main VendureConfig:

```
import { defaultOrderProcess, VendureConfig } from '@vendure/core';import { customerValidationProcess } from './plugins/tax-id/customer-validation-process';export const config: VendureConfig = {  // ...  orderOptions: {    process: [defaultOrderProcess, customerValidationProcess],  },};
```

Note that we also include the defaultOrderProcess in the array, otherwise we will lose all the default states and transitions.

To add multiple new States you need to extend the generic type like this:

```
import { OrderProcess } from '@vendure/core';export const customerValidationProcess: OrderProcess<'ValidatingCustomer'|'AnotherState'> = {...}
```

This way multiple custom states get defined.

### Intercepting a state transition​


[​](#intercepting-a-state-transition)Now we have defined our new ValidatingCustomer state, but there is as yet nothing to enforce that the tax ID is valid. To add this constraint, we'll use the onTransitionStart state transition hook.

[onTransitionStart state transition hook](/reference/typescript-api/state-machine/state-machine-config#ontransitionstart)This allows us to perform our custom logic and potentially prevent the transition from occurring. We will also assume that we have a provider named TaxIdService available which contains the logic to validate a tax ID.

```
import { OrderProcess } from '@vendure/core';import { TaxIdService } from './services/tax-id.service';let taxIdService: TaxIdService;const customerValidationProcess: OrderProcess<'ValidatingCustomer'> = {  transitions: {    AddingItems: {      to: ['ValidatingCustomer'],      mergeStrategy: 'replace',    },    ValidatingCustomer: {      to: ['ArrangingPayment', 'AddingItems'],    },  },  init(injector) {    taxIdService = injector.get(TaxIdService);  },  // The logic for enforcing our validation goes here  async onTransitionStart(fromState, toState, data) {    if (fromState === 'ValidatingCustomer' && toState === 'ArrangingPayment') {      const isValid = await taxIdService.verifyTaxId(data.order.customer);      if (!isValid) {        // Returning a string is interpreted as an error message.        // The state transition will fail.        return `The tax ID is not valid`;      }    }  },};
```

For an explanation of the init() method and injector argument, see the guide on injecting dependencies in configurable operations.

[injecting dependencies in configurable operations](/guides/developer-guide/strategies-configurable-operations/#injecting-dependencies)
### Responding to a state transition​


[​](#responding-to-a-state-transition)Once an order has successfully transitioned to a new state, the onTransitionEnd state transition hook is called. This can be used to perform some action
upon successful state transition.

[onTransitionEnd state transition hook](/reference/typescript-api/state-machine/state-machine-config#ontransitionend)In this example, we have a referral service which creates a new referral for a customer when they complete an order. We want to create the referral only if the customer has a referral code associated with their account.

```
import { OrderProcess, OrderState } from '@vendure/core';import { ReferralService } from '../service/referral.service';let referralService: ReferralService;export const referralOrderProcess: OrderProcess<OrderState> = {    init: (injector) => {        referralService = injector.get(ReferralService);    },    onTransitionEnd: async (fromState, toState, data) => {        const { order, ctx } = data;        if (toState === 'PaymentSettled') {            if (order.customFields.referralCode) {                await referralService.createReferralForOrder(ctx, order);            }        }    },};
```

Use caution when modifying an order inside the onTransitionEnd function. The order object that gets passed in to this function
will later be persisted to the database. Therefore any changes must be made to that order object, otherwise the changes might be lost.

As an example, let's say we want to add a Surcharge to the order. The following code will not work as expected:

```
export const myOrderProcess: OrderProcess<OrderState> = {    async onTransitionEnd(fromState, toState, data) {        if (fromState === 'AddingItems' && toState === 'ArrangingPayment') {            // WARNING: This will not work!              await orderService.addSurchargeToOrder(ctx, order.id, {                description: 'Test',                listPrice: 42,                listPriceIncludesTax: false,            });        }    }};
```

Instead, you need to ensure you mutate the order object:

```
export const myOrderProcess: OrderProcess<OrderState> = {    async onTransitionEnd(fromState, toState, data) {        if (fromState === 'AddingItems' && toState === 'ArrangingPayment') {            const {surcharges} = await orderService.addSurchargeToOrder(ctx, order.id, {                description: 'Test',                listPrice: 42,                listPriceIncludesTax: false,            });            // Important: mutate the order object            order.surcharges = surcharges;        }    },}
```

## TypeScript Typings​


[​](#typescript-typings)To make your custom states compatible with standard services you should declare your new states in the following way:

```
import { CustomOrderStates } from '@vendure/core';declare module '@vendure/core' {  interface CustomOrderStates {    ValidatingCustomer: never;  }}
```

This technique uses advanced TypeScript features - declaration merging and  ambient modules.

[declaration merging](https://www.typescriptlang.org/docs/handbook/declaration-merging.html#merging-interfaces)[ambient modules](https://www.typescriptlang.org/docs/handbook/modules.html#ambient-modules)
## Controlling custom states in the Dashboard​


[​](#controlling-custom-states-in-the-dashboard)If you have defined custom order states, the Dashboard will allow you to manually transition an
order from one state to another:

## Order Interceptors​


[​](#order-interceptors)Vendure v3.1 introduces the concept of Order Interceptors.
These are a way to intercept operations that add, modify or remove order lines. Examples use-cases include:

[Order Interceptors](/reference/typescript-api/orders/order-interceptor/)- Preventing certain products from being added to the order based on some criteria, e.g. if the  product is already in another active order.
- Enforcing a minimum or maximum quantity of a given product in the order
- Using a CAPTCHA to prevent automated order creation

Check the Order Interceptor docs for more information as well as a complete
example of how to implement an interceptor.

[Order Interceptor](/reference/typescript-api/orders/order-interceptor/)


---

# Payment


Vendure can support many kinds of payment workflows, such as authorizing and capturing payment in a single step upon checkout or authorizing on checkout and then capturing on fulfillment.

For complete working examples of real payment integrations, see the payments-plugins

[payments-plugins](https://github.com/vendure-ecommerce/vendure/tree/master/packages/payments-plugin/src)
## Authorization & Settlement​


[​](#authorization--settlement)Typically, there are 2 parts to an online payment: authorization and settlement:

- Authorization is the process by which the customer's bank is contacted to check whether the transaction is allowed. At this stage, no funds are removed from the customer's account.
- Settlement (also known as "capture") is the process by which the funds are transferred from the customer's account to the merchant.

Some merchants do both of these steps at once, when the customer checks out of the store. Others do the authorize step at checkout, and only do the settlement at some later point, e.g. upon shipping the goods to the customer.

This two-step workflow can also be applied to other non-card forms of payment: e.g. if providing a "payment on delivery" option, the authorization step would occur on checkout, and the settlement step would be triggered upon delivery, either manually by an administrator of via an app integration with the Admin API.

## Creating an integration​


[​](#creating-an-integration)Payment integrations are created by defining a new PaymentMethodHandler and passing that handler into the paymentOptions.paymentMethodHandlers array in the VendureConfig.

[PaymentMethodHandler](/reference/typescript-api/payment/payment-method-handler/)[paymentOptions.paymentMethodHandlers](/reference/typescript-api/payment/payment-options#paymentmethodhandlers)
```
import {    CancelPaymentResult,    CancelPaymentErrorResult,    PaymentMethodHandler,    VendureConfig,    CreatePaymentResult,    SettlePaymentResult,    SettlePaymentErrorResult} from '@vendure/core';import { sdk } from 'payment-provider-sdk';/** * This is a handler which integrates Vendure with an imaginary * payment provider, who provide a Node SDK which we use to * interact with their APIs. */const myPaymentHandler = new PaymentMethodHandler({    code: 'my-payment-method',    description: [{        languageCode: LanguageCode.en,        value: 'My Payment Provider',    }],    args: {        apiKey: {type: 'string'},    },    /** This is called when the `addPaymentToOrder` mutation is executed */    createPayment: async (ctx, order, amount, args, metadata): Promise<CreatePaymentResult> => {        try {            const result = await sdk.charges.create({                amount,                apiKey: args.apiKey,                source: metadata.token,            });            return {                amount: order.total,                state: 'Authorized' as const,                transactionId: result.id.toString(),                metadata: {                    cardInfo: result.cardInfo,                    // Any metadata in the `public` field                    // will be available in the Shop API,                    // All other metadata is private and                    // only available in the Admin API.                    public: {                        referenceCode: result.publicId,                    }                },            };        } catch (err) {            return {                amount: order.total,                state: 'Declined' as const,                metadata: {                    errorMessage: err.message,                },            };        }    },    /** This is called when the `settlePayment` mutation is executed */    settlePayment: async (ctx, order, payment, args): Promise<SettlePaymentResult | SettlePaymentErrorResult> => {        try {            const result = await sdk.charges.capture({                apiKey: args.apiKey,                id: payment.transactionId,            });            return {success: true};        } catch (err) {            return {                success: false,                errorMessage: err.message,            }        }    },    /** This is called when a payment is cancelled. */    cancelPayment: async (ctx, order, payment, args): Promise<CancelPaymentResult | CancelPaymentErrorResult> => {        try {            const result = await sdk.charges.cancel({                apiKey: args.apiKey,                id: payment.transactionId,            });            return {success: true};        } catch (err) {            return {                success: false,                errorMessage: err.message,            }        }    },});
```

We can now add this handler to our configuration:

```
import { VendureConfig } from '@vendure/core';import { myPaymentHandler } from './plugins/payment-plugin/my-payment-handler';export const config: VendureConfig = {    // ...    paymentOptions: {        paymentMethodHandlers: [myPaymentHandler],    },};
```

If your PaymentMethodHandler needs access to the database or other providers, see the configurable operation dependency injection guide.

[configurable operation dependency injection guide](/guides/developer-guide/strategies-configurable-operations/#injecting-dependencies)
## The PaymentMethod entity​


[​](#the-paymentmethod-entity)Once the PaymentMethodHandler is defined as above, you can use it to create a new PaymentMethod via the Dashboard (Settings -> Payment methods, then Create new payment method) or via the Admin API createPaymentMethod mutation.

[PaymentMethod](/reference/typescript-api/entities/payment-method/)A payment method consists of an optional PaymentMethodEligibilityChecker, which is used to determine whether the payment method is available to the customer, and a PaymentMethodHandler.

[PaymentMethodEligibilityChecker](/reference/typescript-api/payment/payment-method-eligibility-checker/)[PaymentMethodHandler](/reference/typescript-api/payment/payment-method-handler)The payment method also has a code, which is a string identifier used to specify this method when adding a payment to an order.

## Payment flow​


[​](#payment-flow)
### Eligible payment methods​


[​](#eligible-payment-methods)Once the active Order has been transitioned to the ArrangingPayment state (see the Order guide), we can query the available payment methods by executing the eligiblePaymentMethods query.

[Order guide](/guides/core-concepts/orders/)[eligiblePaymentMethods query](/reference/graphql-api/shop/queries#eligiblepaymentmethods)- Request
- Response

```
query GetEligiblePaymentMethods {    eligiblePaymentMethods {        code        name        isEligible        eligibilityMessage    }}
```

```
{  "data": {    "eligiblePaymentMethods": [      {        "code": "my-payment-method",        "name": "My Payment Method",        "isEligible": true,        "eligibilityMessage": null      }    ]  }}
```

### Add payment to order​


[​](#add-payment-to-order)One or more Payments are created by executing the addPaymentToOrder mutation. This mutation has a required method input field, which must match the code of an eligible PaymentMethod. In the case above, this would be set to "my-payment-method".

[addPaymentToOrder mutation](/reference/graphql-api/shop/mutations#addpaymenttoorder)- Request
- Response

```
mutation {    addPaymentToOrder(        input: {            method: "my-payment-method"            metadata: { token: "<some token from the payment provider>" }        }    ) {        ... on Order {            id            code            state            # ... etc        }        ... on ErrorResult {            errorCode            message        }        ...on PaymentFailedError {            paymentErrorMessage        }        ...on PaymentDeclinedError {            paymentErrorMessage        }        ...on IneligiblePaymentMethodError {            eligibilityCheckerMessage        }    }}

```

```
{  "data": {    "addPaymentToOrder": {      "id": "12345",      "code": "J9AC5PY13BQGRKTF",      "state": "PaymentAuthorized"    }  }}
```

The metadata field is used to store the specific data required by the payment provider. E.g. some providers have a client-side part which begins the transaction and returns a token which must then be verified on the server side.

The metadata field is required, so if your payment provider does not require any additional data, you can simply pass an empty object: metadata: {}.

- This mutation internally invokes the PaymentMethodHandler's createPayment() function. This function returns a CreatePaymentResult object which is used to create a new Payment. If the Payment amount equals the order total, then the Order is transitioned to either the PaymentAuthorized or PaymentSettled state and the customer checkout flow is complete.

[PaymentMethodHandler's createPayment() function](/reference/typescript-api/payment/payment-method-config-options/#createpayment)[CreatePaymentResult object](/reference/typescript-api/payment/payment-method-types#createpaymentfn)[Payment](/reference/typescript-api/entities/payment)
### Single-step​


[​](#single-step)If the createPayment() function returns a result with the state set to 'Settled', then this is a single-step ("authorize & capture") flow, as illustrated below:

### Two-step​


[​](#two-step)If the createPayment() function returns a result with the state set to 'Authorized', then this is a two-step flow, and the settlement / capture part is performed at some later point, e.g. when shipping the goods, or on confirmation of payment-on-delivery.

## Custom Payment Flows​


[​](#custom-payment-flows)If you need to support an entirely different payment flow than the above, it is also possible to do so by configuring a PaymentProcess. This allows new Payment states and transitions to be defined, as well as allowing custom logic to run on Payment state transitions.

[PaymentProcess](/reference/typescript-api/payment/payment-process)Here's an example which adds a new "Validating" state to the Payment state machine, and combines it with a OrderProcess, PaymentMethodHandler and OrderPlacedStrategy.

[OrderProcess](/reference/typescript-api/orders/order-process)[PaymentMethodHandler](/reference/typescript-api/payment/payment-method-handler)[OrderPlacedStrategy](/reference/typescript-api/orders/order-placed-strategy)
```
├── plugins    └── my-payment-plugin        ├── payment-process.ts        ├── payment-method-handler.ts        ├── order-process.ts        └── order-placed-strategy.ts
```

```
import { PaymentProcess } from '@vendure/core';/** * Declare your custom state in special interface to make it type-safe */declare module '@vendure/core' {    interface PaymentStates {        Validating: never;    }}/** * Define a new "Validating" Payment state, and set up the * permitted transitions to/from it. */const customPaymentProcess: PaymentProcess<'Validating'> = {    transitions: {        Created: {            to: ['Validating'],            mergeStrategy: 'replace',        },        Validating: {            to: ['Settled', 'Declined', 'Cancelled'],        },    },};
```

```
import { OrderProcess } from '@vendure/core';/** * Define a new "ValidatingPayment" Order state, and set up the * permitted transitions to/from it. */const customOrderProcess: OrderProcess<'ValidatingPayment'> = {    transitions: {        ArrangingPayment: {            to: ['ValidatingPayment'],            mergeStrategy: 'replace',        },        ValidatingPayment: {            to: ['PaymentAuthorized', 'PaymentSettled', 'ArrangingAdditionalPayment'],        },    },};
```

```
import { LanguageCode, PaymentMethodHandler } from '@vendure/core';/** * This PaymentMethodHandler creates the Payment in the custom "Validating" * state. */const myPaymentHandler = new PaymentMethodHandler({    code: 'my-payment-handler',    description: [{languageCode: LanguageCode.en, value: 'My payment handler'}],    args: {},    createPayment: (ctx, order, amount, args, metadata) => {        // payment provider logic omitted        return {            state: 'Validating' as any,            amount,            metadata,        };    },    settlePayment: (ctx, order, payment) => {        return {            success: true,        };    },});
```

```
import { OrderPlacedStrategy, OrderState, RequestContext } from '@vendure/core';/** * This OrderPlacedStrategy tells Vendure to set the Order as "placed" * when it transitions to the custom "ValidatingPayment" state. */class MyOrderPlacedStrategy implements OrderPlacedStrategy {    shouldSetAsPlaced(ctx: RequestContext, fromState: OrderState, toState: OrderState): boolean | Promise<boolean> {        return fromState === 'ArrangingPayment' && toState === ('ValidatingPayment' as any);    }}
```

```
import { defaultOrderProcess, defaultPaymentProcess, VendureConfig } from '@vendure/core';import { customOrderProcess } from './plugins/my-payment-plugin/order-process';import { customPaymentProcess } from './plugins/my-payment-plugin/payment-process';import { myPaymentHandler } from './plugins/my-payment-plugin/payment-method-handler';import { MyOrderPlacedStrategy } from './plugins/my-payment-plugin/order-placed-strategy';// Combine the above in the VendureConfigexport const config: VendureConfig = {    // ...    orderOptions: {        process: [defaultOrderProcess, customOrderProcess],        orderPlacedStrategy: new MyOrderPlacedStrategy(),    },    paymentOptions: {        process: [defaultPaymentProcess, customPaymentProcess],        paymentMethodHandlers: [myPaymentHandler],    },};
```

### Integration with hosted payment pages​


[​](#integration-with-hosted-payment-pages)A hosted payment page is a system that works similar to Stripe checkout. The idea behind this flow is that the customer does not enter any credit card data anywhere on the merchant's site which waives the merchant from the responsibility to take care of sensitive data.

[Stripe checkout](https://stripe.com/payments/checkout)The checkout flow works as follows:

- The user makes a POST to the card processor's URL via a Vendure served page
- The card processor accepts card information from the user and authorizes a payment
- The card processor redirects the user back to Vendure via a POST which contains details about the processed payment
- There is a pre-shared secret between the merchant and processor used to sign cross-site POST requests

When integrating with a system like this, you would need to create a Controller to accept POST redirects from the payment processor (usually a success and a failure URL), as well as serve a POST form on your store frontend.

With a hosted payment form the payment is already authorized by the time the card processor makes the POST request to Vendure, possibly settled even, so the payment handler won't do anything in particular - just return the data it has been passed. The validation of the POST request is done in the controller or service and the payment amount and payment reference are just passed to the payment handler which passes them on.


---

# Products


Your catalog is composed of Products and ProductVariants.
A Product always has at least one ProductVariant. You can think of the product as a "container" which includes a name, description, and images that apply to all of
its variants.

[Products](/reference/typescript-api/entities/product/)[ProductVariants](/reference/typescript-api/entities/product-variant/)Here's a visual example, in which we have a "Hoodie" product which is available in 3 sizes. Therefore, we have
3 variants of that product:

Multiple variants are made possible by adding one or more ProductOptionGroups to
the product. These option groups then define the available ProductOptions

[ProductOptionGroups](/reference/typescript-api/entities/product-option-group)[ProductOptions](/reference/typescript-api/entities/product-option)If we were to add a new option group to the example above for "Color", with 2 options, "Black" and "White", then in total
we would be able to define up to 6 variants:

- Hoodie Small Black
- Hoodie Small White
- Hoodie Medium Black
- Hoodie Medium White
- Hoodie Large Black
- Hoodie Large White

When a customer adds a product to their cart, they are adding a specific ProductVariant to their cart, not the Product itself.
It is the ProductVariant that contains the SKU ("stock keeping unit", or product code) and price information.

## Product price and stock​


[​](#product-price-and-stock)The ProductVariant entity contains the price and stock information for a product. Since a given product variant can have more
than one price, and more than one stock level (in the case of multiple warehouses), the ProductVariant entity contains
relations to one or more ProductVariantPrice entities and
one or more StockLevel entities.

[ProductVariantPrice](/reference/typescript-api/entities/product-variant-price)[StockLevel](/reference/typescript-api/entities/stock-level)
## Facets​


[​](#facets)Facets are used to add structured labels to products and variants. A facet has
one or more FacetValues. Facet values can be assigned to products or
product variants.

[Facets](/reference/typescript-api/entities/facet/)[FacetValues](/reference/typescript-api/entities/facet-value/)For example, a "Brand" facet could be used to label products with the brand name, with each facet value representing a different brand. You can
also use facets to add other metadata to products and variants such as "New", "Sale", "Featured", etc.

These are the typical uses of facets in Vendure:

- As the basis of Collections, in order to categorize your catalog.
- To filter products in the storefront, also known as "faceted search". For example, a customer is on the "hoodies" collection
page and wants to filter to only show Nike hoodies.
- For internal logic, such as a promotion that applies to all variants with the "Summer Sale" facet value, or a shipping calculation
that applies a surcharge to all products with the "Fragile" facet value. Such facets can be set to be private so that they
are not exposed to the storefront.

[Collections](/guides/core-concepts/collections)


---

# Promotions


Promotions are a means of offering discounts on an order based on various criteria. A Promotion consists of conditions and actions.

- conditions are the rules which determine whether the Promotion should be applied to the order.
- actions specify exactly how this Promotion should modify the order.

## Parts of a Promotion​


[​](#parts-of-a-promotion)
### Constraints​


[​](#constraints)All Promotions can have the following constraints applied to them:

- Date range Using the "starts at" and "ends at" fields, the Promotion can be scheduled to only be active during the given date range.
- Coupon code A Promotion can require a coupon code first be activated using the applyCouponCode mutation in the Shop API.
- Per-customer limit A Promotion coupon may be limited to a given number of uses per Customer.

[applyCouponCode mutation](/reference/graphql-api/shop/mutations/#applycouponcode)
### Conditions​


[​](#conditions)A Promotion may be additionally constrained by one or more conditions. When evaluating whether a Promotion should be applied, each of the defined conditions is checked in turn. If all the conditions evaluate to true, then any defined actions are applied to the order.

Vendure comes with some built-in conditions, but you can also create your own conditions (see section below).

### Actions​


[​](#actions)A promotion action defines exactly how the order discount should be calculated. At least one action must be specified for a valid Promotion.

Vendure comes with some built-in actions, but you can also create your own actions (see section below).

## Creating custom conditions​


[​](#creating-custom-conditions)To create a custom condition, you need to define a new PromotionCondition object.
A promotion condition is an example of a configurable operation.
Here is an annotated example of one of the built-in PromotionConditions.

[PromotionCondition object](/reference/typescript-api/promotions/promotion-condition/)[configurable operation](/guides/developer-guide/strategies-configurable-operations/#configurable-operations)
```
import { LanguageCode, PromotionCondition } from '@vendure/core';export const minimumOrderAmount = new PromotionCondition({    /** A unique identifier for the condition */    code: 'minimum_order_amount',    /**     * A human-readable description. Values defined in the     * `args` object can be interpolated using the curly-braces syntax.     */    description: [        {languageCode: LanguageCode.en, value: 'If order total is greater than { amount }'},    ],    /**     * Arguments which can be specified when configuring the condition     * in the Dashboard. The values of these args are then available during     * the execution of the `check` function.     */    args: {        amount: {            type: 'int',            // The optional `ui` object allows you to customize            // how this arg is rendered in the Dashboard.            ui: {component: 'currency-form-input'},        },        taxInclusive: {type: 'boolean'},    },    /**     * This is the business logic of the condition. It is a function that     * must resolve to a boolean value indicating whether the condition has     * been satisfied.     */    check(ctx, order, args) {        if (args.taxInclusive) {            return order.subTotalWithTax >= args.amount;        } else {            return order.subTotal >= args.amount;        }    },});
```

Custom promotion conditions are then passed into the VendureConfig PromotionOptions to make them available when setting up Promotions:

[PromotionOptions](/reference/typescript-api/promotions/promotion-options/)
```
import { defaultPromotionConditions, VendureConfig } from '@vendure/core';import { minimumOrderAmount } from './minimum-order-amount';export const config: VendureConfig = {    // ...    promotionOptions: {        promotionConditions: [            ...defaultPromotionConditions,            minimumOrderAmount,        ],    }}
```

## Creating custom actions​


[​](#creating-custom-actions)There are three kinds of PromotionAction:

- PromotionItemAction applies a discount on the OrderLine level, i.e. it would be used for a promotion like "50% off USB cables".
- PromotionOrderAction applies a discount on the Order level, i.e. it would be used for a promotion like "5% off the order total".
- PromotionShippingAction applies a discount on the shipping, i.e. it would be used for a promotion like "free shipping".

[PromotionItemAction](/reference/typescript-api/promotions/promotion-action#promotionitemaction)[PromotionOrderAction](/reference/typescript-api/promotions/promotion-action#promotionorderaction)[PromotionShippingAction](/reference/typescript-api/promotions/promotion-action#promotionshippingaction)The implementations of each type is similar, with the difference being the arguments passed to the execute().

Here's an example of a simple PromotionOrderAction.

```
import { LanguageCode, PromotionOrderAction } from '@vendure/core';export const orderPercentageDiscount = new PromotionOrderAction({    // See the custom condition example above for explanations    // of code, description & args fields.    code: 'order_percentage_discount',    description: [{languageCode: LanguageCode.en, value: 'Discount order by { discount }%'}],    args: {        discount: {            type: 'int',            ui: {                component: 'number-form-input',                suffix: '%',            },        },    },    /**     * This is the function that defines the actual amount to be discounted.     * It should return a negative number representing the discount in     * pennies/cents etc. Rounding to an integer is handled automatically.     */    execute(ctx, order, args) {        const orderTotal = ctx.channel.pricesIncludeTax ? order.subTotalWithTax : order.subTotal;        return -orderTotal * (args.discount / 100);    },});
```

Custom PromotionActions are then passed into the VendureConfig PromotionOptions to make them available when setting up Promotions:

[PromotionOptions](/reference/typescript-api/promotions/promotion-options)
```
import { defaultPromotionActions, VendureConfig } from '@vendure/core';import { orderPercentageDiscount } from './order-percentage-discount';export const config: VendureConfig = {    // ...    promotionOptions: {        promotionActions: [            ...defaultPromotionActions,            orderPercentageDiscount,        ],    }};
```

## Free gift promotions​


[​](#free-gift-promotions)Vendure v1.8 introduced a new side effect API to PromotionActions, which allow you to define some additional action to be performed when a Promotion becomes active or inactive.

A primary use-case of this API is to add a free gift to the Order. Here's an example of a plugin which implements a "free gift" action:

```
import {	ID, idsAreEqual, isGraphQlErrorResult, LanguageCode, Logger,	OrderLine, OrderService, PromotionItemAction, VendurePlugin,} from "@vendure/core";import { createHash } from "crypto";let orderService: OrderService;export const freeGiftAction = new PromotionItemAction({	code: "free_gift",	description: [{ languageCode: LanguageCode.en, value: "Add free gifts to the order" }],	args: {		productVariantIds: {			type: "ID",			list: true,			ui: { component: "product-selector-form-input" },			label: [{ languageCode: LanguageCode.en, value: "Gift product variants" }],		},	},	init(injector) {		orderService = injector.get(OrderService);	},	execute(ctx, orderLine, args) {		// This part is responsible for ensuring the variants marked as		// "free gifts" have their price reduced to zero		if (lineContainsIds(args.productVariantIds, orderLine)) {			const unitPrice = orderLine.productVariant.listPriceIncludesTax				? orderLine.unitPriceWithTax				: orderLine.unitPrice;			return -unitPrice;		}		return 0;	},	// The onActivate function is part of the side effect API, and	// allows us to perform some action whenever a Promotion becomes active	// due to it's conditions & constraints being satisfied.	async onActivate(ctx, order, args, promotion) {		for (const id of args.productVariantIds) {			if (				!order.lines.find(					(line) =>						idsAreEqual(line.productVariant.id, id) &&						line.customFields.freeGiftPromotionId == null				)			) {				// The order does not yet contain this free gift, so add it				const result = await orderService.addItemToOrder(ctx, order.id, id, 1, {					freeGiftPromotionId: promotion.id.toString(),				});				if (isGraphQlErrorResult(result)) {					Logger.error(`Free gift action error for variantId "${id}": ${result.message}`);				}			}		}	},	// The onDeactivate function is the other part of the side effect API and is called	// when an active Promotion becomes no longer active. It should reverse any	// side effect performed by the onActivate function.	async onDeactivate(ctx, order, args, promotion) {		const linesWithFreeGift = order.lines.filter(			(line) => line.customFields.freeGiftPromotionId === promotion.id.toString()		);		for (const line of linesWithFreeGift) {			await orderService.removeItemFromOrder(ctx, order.id, line.id);		}	},});function lineContainsIds(ids: ID[], line: OrderLine): boolean {	return !!ids.find((id) => idsAreEqual(id, line.productVariant.id));}@VendurePlugin({	configuration: (config) => {		config.customFields.OrderLine.push({			name: "freeGiftPromotionId",			type: "string",			public: true,			readonly: true,			nullable: true,		});		config.customFields.OrderLine.push({			name: "freeGiftDescription",			type: "string",			public: true,			readonly: true,			nullable: true,		});		config.promotionOptions.promotionActions.push(freeGiftAction);		return config;	},})export class FreeGiftPromotionPlugin {}
```

## Dependency relationships​


[​](#dependency-relationships)It is possible to establish dependency relationships between a PromotionAction and one or more PromotionConditions.

For example, if we want to set up a "buy 1, get 1 free" offer, we need to:

- Establish whether the Order contains the particular ProductVariant under offer (done in the PromotionCondition)
- Apply a discount to the qualifying OrderLine (done in the PromotionAction)

In this scenario, we would have to repeat the logic for checking the Order contents in both the PromotionCondition and the PromotionAction. Not only is this duplicated work for the server, it also means that setting up the promotion relies on the same parameters being input into the PromotionCondition and the PromotionAction.

Note the use of PromotionItemAction to get a reference to the OrderLine as opposed to the Order.

Instead, we can say that the PromotionAction depends on the PromotionCondition:

```
export const buy1Get1FreeAction = new PromotionItemAction({    code: 'buy_1_get_1_free',    description: [{        languageCode: LanguageCode.en,        value: 'Buy 1, get 1 free',    }],    args: {},    conditions: [buyXGetYFreeCondition],    execute(ctx, orderLine, args, state) {        const freeItemIds = state.buy_x_get_y_free.freeItemIds;        if (idsContainsItem(freeItemIds, orderLine)) {            const unitPrice = ctx.channel.pricesIncludeTax ? orderLine.unitPriceWithTax : orderLine.unitPrice;            return -unitPrice;        }        return 0;    },});
```

In the above code, we are stating that this PromotionAction depends on the buyXGetYFreeCondition PromotionCondition. Attempting to create a Promotion using the buy1Get1FreeAction without also using the buyXGetYFreeCondition will result in an error.

In turn, the buyXGetYFreeCondition can return a state object with the type { [key: string]: any; } instead of just a true boolean value. This state object is then passed to the PromotionConditions which depend on it, as part of the last argument (state).

```
export const buyXGetYFreeCondition = new PromotionCondition({    code: 'buy_x_get_y_free',    description: [{        languageCode: LanguageCode.en,        value: 'Buy { amountX } of { variantIdsX } products, get { amountY } of { variantIdsY } products free',    }],    args: {        // omitted for brevity    },    async check(ctx, order, args) {        // logic omitted for brevity        if (freeItemIds.length === 0) {            return false;        }        return {freeItemIds};    },});
```

## Injecting providers​


[​](#injecting-providers)If your PromotionCondition or PromotionAction needs access to the database or other providers, they can be injected by defining an init() function in your PromotionAction or PromotionCondition. See the configurable operation guide for details.

[configurable operation guide](/guides/developer-guide/strategies-configurable-operations/#injecting-dependencies)


---

# Shipping & Fulfillment


Shipping in Vendure is handled by ShippingMethods.
A ShippingMethod is composed of a checker and a calculator.

[ShippingMethods](/reference/typescript-api/entities/shipping-method/)- The ShippingEligibilityChecker determines whether the order is eligible for the ShippingMethod. It can contain custom logic such as checking the total weight of the order, or whether the order is being shipped to a particular country.
- The ShippingCalculator calculates the cost of shipping the order. The calculation can be performed directly by the calculator itself, or it could call out to a third-party API to determine the cost.

[ShippingEligibilityChecker](/reference/typescript-api/shipping/shipping-eligibility-checker/)[ShippingCalculator](/reference/typescript-api/shipping/shipping-calculator/)Multiple shipping methods can be set up and then your storefront can query eligibleShippingMethods to find out which ones can be applied to the active order.

[eligibleShippingMethods](/reference/graphql-api/shop/queries/#eligibleshippingmethods)When querying eligibleShippingMethods, each of the defined ShippingMethods' checker functions is executed to find out whether the order is eligible for that method, and if so, the calculator is executed to determine what the cost of shipping will be for that method.

- Request
- Response

```
query GetEligibleShippingMethods {    eligibleShippingMethods {        id        name        price        priceWithTax    }}
```

```
{  "data": {    "eligibleShippingMethods": [      {        "id": "1",        "name": "Standard Shipping",        "price": 500,        "priceWithTax": 500      },      {        "id": "2",        "name": "Express Shipping",        "price": 1000,        "priceWithTax": 1000      }    ]  }}
```

## Creating a custom checker​


[​](#creating-a-custom-checker)Custom checkers can be created by defining a ShippingEligibilityChecker object.

[ShippingEligibilityChecker object](/reference/typescript-api/shipping/shipping-eligibility-checker/)For example, you could create a checker which works with a custom "weight" field to only apply to orders below a certain weight:

```
import { LanguageCode, ShippingEligibilityChecker } from '@vendure/core';export const maxWeightChecker = new ShippingEligibilityChecker({    code: 'max-weight-checker',    description: [        {languageCode: LanguageCode.en, value: 'Max Weight Checker'}    ],    args: {        maxWeight: {            type: 'int',            ui: {component: 'number-form-input', suffix: 'grams'},            label: [{languageCode: LanguageCode.en, value: 'Maximum order weight'}],            description: [                {                    languageCode: LanguageCode.en,                    value: 'Order is eligible only if its total weight is less than the specified value',                },            ],        },    },    /**     * Must resolve to a boolean value, where `true` means that the order is     * eligible for this ShippingMethod.     *     * (This example assumes a custom field "weight" is defined on the     * ProductVariant entity)     */    check: (ctx, order, args) => {        const totalWeight = order.lines            .map(l => l.productVariant.customFields.weight ?? 0 * l.quantity)            .reduce((total, lineWeight) => total + lineWeight, 0);        return totalWeight <= args.maxWeight;    },});
```

Custom checkers are then passed into the VendureConfig ShippingOptions to make them available when setting up new ShippingMethods:

[ShippingOptions](/reference/typescript-api/shipping/shipping-options/#shippingeligibilitycheckers)
```
import { defaultShippingEligibilityChecker, VendureConfig } from '@vendure/core';import { maxWeightChecker } from './shipping-methods/max-weight-checker';export const config: VendureConfig = {    // ...    shippingOptions: {        shippingEligibilityCheckers: [            defaultShippingEligibilityChecker,            maxWeightChecker,        ],    }}
```

## Creating a custom calculator​


[​](#creating-a-custom-calculator)Custom calculators can be created by defining a ShippingCalculator object.

[ShippingCalculator object](/reference/typescript-api/shipping/shipping-calculator/)For example, you could create a calculator which consults an external data source (e.g. a spreadsheet, database or 3rd-party API) to find out the cost and estimated delivery time for the order.

```
import { LanguageCode, ShippingCalculator } from '@vendure/core';import { shippingDataSource } from './shipping-data-source';export const externalShippingCalculator = new ShippingCalculator({    code: 'external-shipping-calculator',    description: [{languageCode: LanguageCode.en, value: 'Calculates cost from external source'}],    args: {        taxRate: {            type: 'int',            ui: {component: 'number-form-input', suffix: '%'},            label: [{languageCode: LanguageCode.en, value: 'Tax rate'}],        },    },    calculate: async (ctx, order, args) => {        // `shippingDataSource` is assumed to fetch the data from some        // external data source.        const { rate, deliveryDate, courier } = await shippingDataSource.getRate({            destination: order.shippingAddress,            contents: order.lines,        });        return {            price: rate,            priceIncludesTax: ctx.channel.pricesIncludeTax,            taxRate: args.taxRate,            // metadata is optional but can be used to pass arbitrary            // data about the shipping estimate to the storefront.            metadata: { courier, deliveryDate },        };    },});
```

Custom calculators are then passed into the VendureConfig ShippingOptions to make them available when setting up new ShippingMethods:

[ShippingOptions](/reference/typescript-api/shipping/shipping-options/#shippingcalculators)
```
import { defaultShippingCalculator, VendureConfig } from '@vendure/core';import { externalShippingCalculator } from './external-shipping-calculator';export const config: VendureConfig = {  // ...  shippingOptions: {    shippingCalculators: [      defaultShippingCalculator,      externalShippingCalculator,    ],  }}
```

If your ShippingEligibilityChecker or ShippingCalculator needs access to the database or other providers, see the configurable operation dependency injection guide.

[configurable operation dependency injection guide](/guides/developer-guide/strategies-configurable-operations/#injecting-dependencies)
## Fulfillments​


[​](#fulfillments)Fulfillments represent the actual shipping status of items in an order. When an order is placed and payment has been settled, the order items are then delivered to the customer in one or more Fulfillments.

- Physical goods: A fulfillment would represent the actual boxes or packages which are shipped to the customer. When the package leaves the warehouse, the fulfillment is marked as Shipped. When the package arrives with the customer, the fulfillment is marked as Delivered.
- Digital goods: A fulfillment would represent the means of delivering the digital goods to the customer, e.g. a download link or a license key. For example, when the link is sent to the customer, the fulfillment can be marked as Shipped and then Delivered.

### FulfillmentHandlers​


[​](#fulfillmenthandlers)It is often required to integrate your fulfillment process, e.g. with an external shipping API which provides shipping labels or tracking codes. This is done by defining FulfillmentHandlers (click the link for full documentation) and passing them in to the shippingOptions.fulfillmentHandlers array in your config.

[FulfillmentHandlers](/reference/typescript-api/fulfillment/fulfillment-handler/)By default, Vendure uses a manual fulfillment handler, which requires the Administrator to manually enter the method and tracking code of the Fulfillment.

### Fulfillment state machine​


[​](#fulfillment-state-machine)Like Orders, Fulfillments are governed by a finite state machine and by default, a Fulfillment can be in one of the following states:

[finite state machine](/reference/typescript-api/state-machine/fsm/)[following states](/reference/typescript-api/fulfillment/fulfillment-state#fulfillmentstate)- Pending The Fulfillment has been created
- Shipped The Fulfillment has been shipped
- Delivered The Fulfillment has arrived with the customer
- Cancelled The Fulfillment has been cancelled

These states cover the typical workflow for fulfilling orders. However, it is possible to customize the fulfillment workflow by defining a FulfillmentProcess and passing it to your VendureConfig:

[FulfillmentProcess](/reference/typescript-api/fulfillment/fulfillment-process)
```
import { FulfillmentProcess, VendureConfig } from '@vendure/core';import { myCustomFulfillmentProcess } from './my-custom-fulfillment-process';export const config: VendureConfig = {  // ...  shippingOptions: {    process: [myCustomFulfillmentProcess],  },};
```

For a more detailed look at how custom processes are used, see the custom order processes guide.

[custom order processes guide](/guides/core-concepts/orders/#custom-order-processes)

---

# Stock Control


Vendure includes features to help manage your stock levels, stock allocations and back orders. The basic purpose is to help you keep track of how many of a given ProductVariant you have available to sell.

Stock control is enabled globally via the Global Settings:

It can be disabled if, for example, you manage your stock with a separate inventory management system and synchronize stock levels into Vendure automatically. The setting can also be overridden at the individual ProductVariant level.

## Stock Locations​


[​](#stock-locations)Vendure uses the concept of StockLocations to represent the physical locations where stock is stored. This could be a warehouse, a retail store, or any other location. If you do not have multiple stock locations, then you can simply use the default location which is created automatically.

[StockLocations](/reference/typescript-api/entities/stock-location/)
### Selecting a stock location​


[​](#selecting-a-stock-location)When you have multiple stock locations set up, you need a way to determine which location to use when querying stock levels and when allocating stock to orders. This is handled by the StockLocationStrategy. This strategy exposes a number of methods which are used to determine which location (or locations) to use when:

[StockLocationStrategy](/reference/typescript-api/products-stock/stock-location-strategy/)- querying stock levels (getAvailableStock)
- allocating stock to orders (forAllocation)
- releasing stock from orders (forRelease)
- creating sales upon fulfillment (forSale)
- returning items to stock upon cancellation (forCancellation)

The default strategy is the DefaultStockLocationStrategy, which simply uses the default location for all of the above methods. This is suitable for all cases where there is just a single stock location.

[DefaultStockLocationStrategy](/reference/typescript-api/products-stock/default-stock-location-strategy)If you have multiple stock locations, you'll need to implement a custom strategy which uses custom logic to determine which stock location to use. For instance, you could:

- Use the location with the most stock available
- Use the location closest to the customer
- Use the location which has the cheapest shipping cost

### Displaying stock levels in the storefront​


[​](#displaying-stock-levels-in-the-storefront)The StockDisplayStrategy is used to determine how stock levels are displayed in the storefront. The default strategy is the DefaultStockDisplayStrategy, which will only display one of three states: 'IN_STOCK', 'OUT_OF_STOCK' or 'LOW_STOCK'. This is to avoid exposing your exact stock levels to the public, which can sometimes be undesirable.

[StockDisplayStrategy](/reference/typescript-api/products-stock/stock-display-strategy/)[DefaultStockDisplayStrategy](/reference/typescript-api/products-stock/default-stock-display-strategy)You can implement a custom strategy to display stock levels in a different way. Here's how you would implement a custom strategy to display exact stock levels:

```
import { RequestContext, StockDisplayStrategy, ProductVariant } from '@vendure/core';export class ExactStockDisplayStrategy implements StockDisplayStrategy {    getStockLevel(ctx: RequestContext, productVariant: ProductVariant, saleableStockLevel: number): string {        return saleableStockLevel.toString();    }}
```

This strategy is then used in your config:

```
import { VendureConfig } from '@vendure/core';import { ExactStockDisplayStrategy } from './exact-stock-display-strategy';export const config: VendureConfig = {    // ...    catalogOptions: {        stockDisplayStrategy: new ExactStockDisplayStrategy(),    },};
```

## Stock Control Concepts​


[​](#stock-control-concepts)- Stock on hand: This refers to the number of physical units of a particular variant which you have in stock right now. This can be zero or more, but not negative.
- Allocated: This refers to the number of units which have been assigned to Orders, but which have not yet been fulfilled.
- Out-of-stock threshold: This value determines the stock level at which the variant is considered "out of stock". This value is set globally, but can be overridden for specific variants. It defaults to 0.
- Saleable: This means the number of units that can be sold right now. The formula is:
saleable = stockOnHand - allocated - outOfStockThreshold

Here's a table to better illustrate the relationship between these concepts:

The saleable value is what determines whether the customer is able to add a variant to an order. If there is 0 saleable stock, then any attempt to add to the order will result in an InsufficientStockError.

[InsufficientStockError](/reference/graphql-api/admin/object-types/#insufficientstockerror)- Request
- Response

```
query AddItemToOrder {    addItemToOrder(productVariantId: 123, quantity: 150) {        ...on Order {            id            code            totalQuantity        }        ...on ErrorResult {            errorCode            message        }        ...on InsufficientStockError {            errorCode            message            quantityAvailable            order {                id                totalQuantity            }        }    }}
```

```
{  "data": {    "addItemToOrder": {      "errorCode": "INSUFFICIENT_STOCK_ERROR",      "message": "Only 105 items were added to the order due to insufficient stock",      "quantityAvailable": 105,      "order": {        "id": "2",        "totalQuantity": 106      }    }  }}
```

### Stock allocation​


[​](#stock-allocation)Allocation mean we are setting stock aside because it has been purchased but not yet shipped. It prevents us from selling more of a particular item than we are able to deliver.

By default, stock gets allocated to an order once the order transitions to the PaymentAuthorized or PaymentSettled state. This is defined by the DefaultStockAllocationStrategy. Using a custom StockAllocationStrategy you can define your own rules for when stock is allocated.

[DefaultStockAllocationStrategy](/reference/typescript-api/orders/default-stock-allocation-strategy)[StockAllocationStrategy](/reference/typescript-api/orders/stock-allocation-strategy/)With the defaultFulfillmentProcess, allocated stock will be converted to sales and minused from the stockOnHand value when a Fulfillment is created.

[defaultFulfillmentProcess](/reference/typescript-api/fulfillment/fulfillment-process/#defaultfulfillmentprocess)
### Back orders​


[​](#back-orders)You may have noticed that the outOfStockThreshold value can be set to a negative number. This allows you to sell variants even when you don't physically have them in stock. This is known as a "back order".

Back orders can be really useful to allow orders to keep flowing even when stockOnHand temporarily drops to zero. For many businesses with predictable re-supply schedules they make a lot of sense.

Once a customer completes checkout, those variants in the order are marked as allocated. When a Fulfillment is created, those allocations are converted to Sales and the stockOnHand of each variant is adjusted. Fulfillments may only be created if there is sufficient stock on hand.

### Stock movements​


[​](#stock-movements)There is a StockMovement entity which records the history of stock changes. StockMovement is actually an abstract class, with the following concrete implementations:

[StockMovement](/reference/typescript-api/entities/stock-movement/)- Allocation: When stock is allocated to an order, before the order is fulfilled. Adds stock to allocated, which reduces the saleable stock.
- Sale: When allocated stock gets fulfilled. Removes stock from allocated as well as stockOnHand.
- Cancellation: When items from a fulfilled order are cancelled, the stock is returned to stockOnHand. Adds stock to stockOnHand.
- Release: When items which have been allocated (but not yet converted to sales via the creation of a Fulfillment) are cancelled. Removes stock from allocated.
- StockAdjustment: A general-purpose stock adjustment. Adds or removes stock from stockOnHand. Used when manually setting stock levels via the Dashboard, for example.

[Allocation](/reference/typescript-api/entities/stock-movement/#allocation)[Sale](/reference/typescript-api/entities/stock-movement/#sale)[Cancellation](/reference/typescript-api/entities/stock-movement/#cancellation)[Release](/reference/typescript-api/entities/stock-movement/#release)[StockAdjustment](/reference/typescript-api/entities/stock-movement/#stockadjustment)Stock movements can be queried via the ProductVariant.stockMovements. Here's an example where we query the stock levels and stock movements of a particular variant:

- Request
- Response

```
query GetStockMovements {    productVariant(id: 1) {        id        name        stockLevels {            stockLocation {                name            }            stockOnHand            stockAllocated        }        stockMovements {            items {                ...on StockMovement {                    createdAt                    type                    quantity                }            }        }    }}
```

```
{  "data": {    "productVariant": {      "id": "1",      "name": "Laptop 13 inch 8GB",      "stockLevels": [        {          "stockLocation": {            "name": "Default Stock Location"          },          "stockOnHand": 100,          "stockAllocated": 0        }      ],      "stockMovements": {        "items": [          {            "createdAt": "2023-07-13T13:21:10.000Z",            "type": "ADJUSTMENT",            "quantity": 100          }        ]      }    }  }}
```


---

# Taxes


E-commerce applications need to correctly handle taxes such as sales tax or value added tax (VAT). In Vendure, tax handling consists of:

- Tax categories Each ProductVariant is assigned to a specific TaxCategory. In some tax systems, the tax rate differs depending on the type of good. For example, VAT in the UK has 3 rates, "standard" (most goods), "reduced" (e.g. child car seats) and "zero" (e.g. books).
- Tax rates This is the tax rate applied to a specific tax category for a specific Zone. E.g., the tax rate for "standard" goods in the UK Zone is 20%.
- Channel tax settings Each Channel can specify whether the prices of product variants are inclusive of tax or not, and also specify the default Zone to use for tax calculations.
- TaxZoneStrategy Determines the active tax Zone used when calculating what TaxRate to apply. By default, it uses the default tax Zone from the Channel settings.
- TaxLineCalculationStrategy This determines the taxes applied when adding an item to an Order. If you want to integrate a 3rd-party tax API or other async lookup, this is where it would be done.

[Zone](/reference/typescript-api/entities/zone/)
## API conventions​


[​](#api-conventions)In the GraphQL API, any type which has a taxable price will split that price into two fields: price and priceWithTax. This pattern also holds for other price fields, e.g.

```
query {  activeOrder {    ...on Order {      lines {        linePrice        linePriceWithTax      }      subTotal      subTotalWithTax      shipping      shippingWithTax      total      totalWithTax    }  }}
```

In your storefront, you can therefore choose whether to display the prices with or without tax, according to the laws and conventions of the area in which your business operates.

## Calculating tax on order lines​


[​](#calculating-tax-on-order-lines)When a customer adds an item to the Order, the following logic takes place:

- The price of the item, and whether that price is inclusive of tax, is determined according to the configured OrderItemPriceCalculationStrategy.
- The active tax Zone is determined based on the configured TaxZoneStrategy. By default, Vendure will use the default tax Zone from the Channel settings.
However, you often want to use the customer's address as the basis for determining the tax Zone. In this case, you should use the AddressBasedTaxZoneStrategy.
- The applicable TaxRate is fetched based on the ProductVariant's TaxCategory and the active tax Zone determined in step 1.
- The TaxLineCalculationStrategy.calculate() of the configured TaxLineCalculationStrategy is called, which will return one or more TaxLines.
- The final priceWithTax of the order line is calculated based on all the above.

[OrderItemPriceCalculationStrategy](/reference/typescript-api/orders/order-item-price-calculation-strategy/)[TaxZoneStrategy](/reference/typescript-api/tax/tax-zone-strategy/)[AddressBasedTaxZoneStrategy](/reference/typescript-api/tax/address-based-tax-zone-strategy)[TaxLineCalculationStrategy](/reference/typescript-api/tax/tax-line-calculation-strategy/)[TaxLines](/reference/graphql-api/admin/object-types/#taxline)
## Calculating tax on shipping​


[​](#calculating-tax-on-shipping)The taxes on shipping is calculated by the ShippingCalculator of the Order's selected ShippingMethod.

[ShippingCalculator](/reference/typescript-api/shipping/shipping-calculator/)[ShippingMethod](/reference/typescript-api/entities/shipping-method/)
## Configuration​


[​](#configuration)This example shows the default configuration for taxes (you don't need to specify this in your own config, as these are the defaults):

```
import {    DefaultTaxLineCalculationStrategy,    DefaultTaxZoneStrategy,    DefaultOrderItemPriceCalculationStrategy,    VendureConfig} from '@vendure/core';export const config: VendureConfig = {  taxOptions: {    taxZoneStrategy: new DefaultTaxZoneStrategy(),    taxLineCalculationStrategy: new DefaultTaxLineCalculationStrategy(),  },  orderOptions: {    orderItemPriceCalculationStrategy: new DefaultOrderItemPriceCalculationStrategy()  }}
```