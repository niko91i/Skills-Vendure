# Storefront Starters


## Next.js Storefront Starter​


[​](#nextjs-storefront-starter)The Vendure team has created an official Next.js Storefront Starter that you can use as a base for your own storefront.

From v3.5.2 onwards, new Vendure projects created using the @vendure/create tool can choose to include this Next.js Storefront Starter by default.

This starter includes all basic functionality out of the box, including:

- Product listing
- Product details
- Search with facets
- Cart functionality
- Checkout flow
- Account management
- Styling with Tailwind
- 🔗 next.vendure.io
- 💻 github.com/vendure-ecommerce/storefront-nextjs-starter

Product listing

Product details

Search with facets

Cart functionality

Checkout flow

Account management

Styling with Tailwind

🔗 next.vendure.io

[next.vendure.io](https://next.vendure.io/)💻 github.com/vendure-ecommerce/storefront-nextjs-starter

[github.com/vendure-ecommerce/storefront-nextjs-starter](https://github.com/vendure-ecommerce/nextjs-starter-vendure)Prefer to build your own solution? Follow the rest of the guides in this section to learn how to build a Storefront from scratch.

## Community-maintained Starters​


[​](#community-maintained-starters)The Next.js starter is the official Vendure Storefront starter, but there are also several further starters that were originally created
as demos by the Vendure team, and are now community-maintained.

### Remix Storefront​


[​](#remix-storefront)- 🔗 remix-storefront.vendure.io
- 💻 github.com/vendure-ecommerce/storefront-remix-starter

[remix-storefront.vendure.io](https://remix-storefront.vendure.io/)[github.com/vendure-ecommerce/storefront-remix-starter](https://github.com/vendure-ecommerce/storefront-remix-starter)Remix is a React-based full-stack JavaScript framework which focuses on web standards, modern web app UX, and which helps you build better websites.

[Remix](https://remix.run/)Our official Remix Storefront starter provides you with a lightning-fast, modern storefront solution which can be deployed to any of the popular cloud providers like Vercel, Netlify, or Cloudflare Pages.

### Qwik Storefront​


[​](#qwik-storefront)- 🔗 qwik-storefront.vendure.io
- 💻 github.com/vendure-ecommerce/storefront-qwik-starter

[qwik-storefront.vendure.io](https://qwik-storefront.vendure.io/)[github.com/vendure-ecommerce/storefront-qwik-starter](https://github.com/vendure-ecommerce/storefront-qwik-starter)Qwik is a cutting-edge web framework that offers unmatched performance.

[Qwik](https://qwik.builder.io/)Our official Qwik Storefront starter provides you with a lightning-fast, modern storefront solution which can be deployed to any of the popular cloud providers like Vercel, Netlify, or Cloudflare Pages.

### Angular Storefront​


[​](#angular-storefront)- 🔗 angular-storefront.vendure.io
- 💻 github.com/vendure-ecommerce/storefront-angular-starter

[angular-storefront.vendure.io](https://angular-storefront.vendure.io/)[github.com/vendure-ecommerce/storefront-angular-starter](https://github.com/vendure-ecommerce/storefront-angular-starter)Angular is a popular, stable, enterprise-grade framework made by Google.

[Angular](https://angular.io/)Our official Angular Storefront starter is a modern Progressive Web App that uses Angular Universal server-side rendering.


---

# Connect to the API


The first thing you'll need to do is to connect your storefront app to the Shop API. The Shop API is a GraphQL API
that provides access to the products, collections, customer data, and exposes mutations that allow you to add items to
the cart, checkout, manage customer accounts, and more.

You can explore the Shop API by opening the GraphQL Playground in your browser at
http://localhost:3000/shop-api when your Vendure
server is running locally.

[http://localhost:3000/shop-api](http://localhost:3000/shop-api)
## Select a GraphQL client​


[​](#select-a-graphql-client)GraphQL requests are made over HTTP, so you can use any HTTP client such as the Fetch API to make requests to the Shop API. However, there are also a number of specialized GraphQL clients which can make working with GraphQL APIs easier. Here are some popular options:

[Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API)- Apollo Client: A full-featured client which includes a caching layer and React integration.
- urql: The highly customizable and versatile GraphQL client for React, Svelte, Vue, or plain JavaScript
- graphql-request: Minimal GraphQL client supporting Node and browsers for scripts or simple apps
- TanStack Query: Powerful asynchronous state management for TS/JS, React, Solid, Vue and Svelte, which can be combined with graphql-request.

[Apollo Client](https://www.apollographql.com/docs/react)[urql](https://formidable.com/open-source/urql/)[graphql-request](https://github.com/jasonkuhrt/graphql-request)[TanStack Query](https://tanstack.com/query/latest)
## Managing Sessions​


[​](#managing-sessions)Vendure supports two ways to manage user sessions: cookies and bearer token. The method you choose depends on your requirements, and is specified by the authOptions.tokenMethod property of the VendureConfig. By default, both are enabled on the server:

[authOptions.tokenMethod property](/reference/typescript-api/auth/auth-options/#tokenmethod)
```
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    authOptions: {        tokenMethod: ['bearer', 'cookie'],    },};
```

### Cookie-based sessions​


[​](#cookie-based-sessions)Using cookies is the simpler approach for browser-based applications, since the browser will manage the cookies for you automatically.

- Enable the credentials option in your HTTP client. This allows the browser to send the session cookie with each request.
For example, if using a fetch-based client (such as Apollo client) you would set credentials: 'include' or if using XMLHttpRequest, you would set withCredentials: true
- When using cookie-based sessions, you should set the authOptions.cookieOptions.secret property to some secret string which will be used to sign the cookies sent to clients to prevent tampering. This string could be hard-coded in your config file, or (better) reside in an environment variable:
src/vendure-config.tsimport { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    authOptions: {        tokenMethod: ['bearer', 'cookie'],        cookieOptions: {            secret: process.env.COOKIE_SESSION_SECRET        }    }}

Enable the credentials option in your HTTP client. This allows the browser to send the session cookie with each request.

For example, if using a fetch-based client (such as Apollo client) you would set credentials: 'include' or if using XMLHttpRequest, you would set withCredentials: true

[Apollo client](https://www.apollographql.com/docs/react/recipes/authentication/#cookie)[XMLHttpRequest](https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/withCredentials)When using cookie-based sessions, you should set the authOptions.cookieOptions.secret property to some secret string which will be used to sign the cookies sent to clients to prevent tampering. This string could be hard-coded in your config file, or (better) reside in an environment variable:

[authOptions.cookieOptions.secret property](/reference/typescript-api/auth/cookie-options#secret)
```
import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {    // ...    authOptions: {        tokenMethod: ['bearer', 'cookie'],        cookieOptions: {            secret: process.env.COOKIE_SESSION_SECRET        }    }}
```

SameSite cookies

When using cookies to manage sessions, you need to be aware of the SameSite cookie policy. This policy is designed to prevent cross-site request forgery (CSRF) attacks, but can cause problems when using a headless storefront app which is hosted on a different domain to the Vendure server. See this article for more information.

[this article](https://web.dev/samesite-cookies-explained/)
### Bearer-token sessions​


[​](#bearer-token-sessions)Using bearer tokens involves a bit more work on your part: you'll need to manually read response headers to get the token, and once you have it you'll have to manually add it to the headers of each request.

The workflow would be as follows:

- Certain mutations and queries initiate a session (e.g. logging in, adding an item to an order etc.). When this happens, the response will contain a HTTP header which by default is called 'vendure-auth-token'.
- So your http client would need to check for the presence of this header each time it receives a response from the server.
- If the 'vendure-auth-token' header is present, read the value and store it because this is your bearer token.
- Attach this bearer token to each subsequent request as Authorization: Bearer <token>.

[by default is called 'vendure-auth-token'](/reference/typescript-api/auth/auth-options#authtokenheaderkey)Here's a simplified example of how that would look:

```
let token: string | undefined = localStorage.getItem('token')export async function request(query: string, variables: any) {     // If we already know the token, set the Authorization header.     const headers = token ? { Authorization: `Bearer ${token}` } : {};     const response = await someGraphQlClient(query, variables, headers);     // Check the response headers to see if Vendure has set the     // auth token. The header key "vendure-auth-token" may be set to     // a custom value with the authOptions.authTokenHeaderKey config option.     const authToken = response.headers.get('vendure-auth-token');     if (authToken != null) {         token = authToken;     }     return response.data;}
```

There are some concrete examples of this approach in the examples later on in this guide.

### Session duration​


[​](#session-duration)The duration of a session is determined by the AuthOptions.sessionDuration config
property. Sessions will automatically extend (or "refresh") when a user interacts with the API, so in effect the sessionDuration signifies the
length of time that a session will stay valid since the last API call.

[AuthOptions.sessionDuration](/reference/typescript-api/auth/auth-options#sessionduration)
## Specifying a channel​


[​](#specifying-a-channel)If your project has multiple channels, you can specify the active channel by setting
the vendure-token header on each request to match the channelToken for the desired channel.

[channels](/guides/core-concepts/channels/)Let's say you have a channel with the token uk-channel and you want to make a request to the Shop API to get the
products in that channel. You would set the vendure-token header to uk-channel:

```
export function query(document: string, variables: Record<string, any> = {}) {    return fetch('https://localhost:3000/shop-api', {        method: 'POST',        headers: {            'content-type': 'application/json',            'vendure-token': 'uk-channel',        },        credentials: 'include',        body: JSON.stringify({          query: document,          variables,        }),    })      .then((res) => res.json())      .catch((err) => console.log(err));}
```

If no channel token is specified, then the default channel will be used.

The header name vendure-token is the default, but can be changed using the apiOptions.channelTokenKey config option.

[apiOptions.channelTokenKey](/reference/typescript-api/configuration/api-options/#channeltokenkey)
## Setting language​


[​](#setting-language)If you have translations of your products, collections, facets etc, you can specify the language for the request by setting the languageCode query string on the request. The value should be one of the ISO 639-1 codes defined by the LanguageCode enum.

[LanguageCode enum](/reference/typescript-api/common/language-code/)
```
POST http://localhost:3000/shop-api?languageCode=de
```

## Code generation​


[​](#code-generation)If you are building your storefront with TypeScript, we highly recommend you set up code generation to ensure
that the responses from your queries & mutation are always correctly typed according the fields you request.

See the GraphQL Code Generation guide for more information.

[GraphQL Code Generation guide](/guides/storefront/codegen/)
## Examples​


[​](#examples)Here are some examples of how to set up clients to connect to the Shop API. All of these examples include functions for setting the language and channel token.

### Fetch​


[​](#fetch)First we'll look at a plain fetch-based implementation, to show you that there's no special magic to a GraphQL request - it's just a POST request with a JSON body.

[fetch](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API)Note that we also include a React hook in this example, but that's just to make it more convenient to use the client
in a React component - it is not required.

- client.ts
- App.tsx
- index.ts

```
import { useState, useEffect } from 'react';// If using bearer-token based session management, we'll store the token// in localStorage using this key.const AUTH_TOKEN_KEY = 'auth_token';const API_URL = 'https://readonlydemo.vendure.io/shop-api';let languageCode: string | undefined;let channelToken: string | undefined;export function setLanguageCode(value: string | undefined) {    languageCode = value;}export function setChannelToken(value: string | undefined) {    channelToken = value;}export function query(document: string, variables: Record<string, any> = {}) {    const authToken = localStorage.getItem(AUTH_TOKEN_KEY);    const headers = new Headers({        'content-type': 'application/json',    });    if (authToken) {        headers.append('authorization', `Bearer ${authToken}`);    }    if (channelToken) {        headers.append('vendure-token', channelToken);    }    let endpoint = API_URL;    if (languageCode) {        endpoint += `?languageCode=${languageCode}`;    }    return fetch(endpoint, {        method: 'POST',        headers,        credentials: 'include',        body: JSON.stringify({            query: document,            variables,        }),    }).then((res) => {        if (!res.ok) {            throw new Error(`An error ocurred, HTTP status: ${res.status}`);        }        const newAuthToken = res.headers.get('vendure-auth-token');        if (newAuthToken) {            localStorage.setItem(AUTH_TOKEN_KEY, newAuthToken);        }        return res.json();    });}/** * Here we have wrapped the `query` function into a React hook for convenient use in * React components. */ export function useQuery(    document: string,    variables: Record<string, any> = {}) {    const [data, setData] = useState(null);    const [loading, setLoading] = useState(true);    const [error, setError] = useState(null);    useEffect(() => {        query(document, variables)            .then((result) => {                setData(result.data);                setError(null);            })            .catch((err) => {                setError(err.message);                setData(null);            })            .finally(() => {                setLoading(false);            });    }, []);    return { data, loading, error };}
```

```
import { useQuery } from './client';import './style.css';const GET_PRODUCTS = /*GraphQL*/ `    query GetProducts($options: ProductListOptions) {        products(options: $options) {            items {                id                name                slug                featuredAsset {                    preview                }            }        }    }`;export default function App() {    const { data, loading, error } = useQuery(GET_PRODUCTS, {        options: { take: 3 },    });    if (loading) return <p>Loading...</p>;    if (error) return <p>Error : {error.message}</p>;    return data.products.items.map(({ id, name, slug, featuredAsset }) => (        <div key={id}>            <h3>{name}</h3>            <img src={`${featuredAsset.preview}?preset=small`} alt={name} />        </div>    ));}
```

```
 import * as React from 'react'; import { StrictMode } from 'react'; import { createRoot } from 'react-dom/client'; import App from './App'; const rootElement = document.getElementById('root'); const root = createRoot(rootElement); root.render(     <StrictMode>         <App />     </StrictMode> );
```

Here's a live version of this example:

As you can see, the basic implementation with fetch is quite straightforward. However, it is also lacking some features that other,
dedicated client libraries will provide.

### Apollo Client​


[​](#apollo-client)Here's an example configuration for Apollo Client with a React app.

[Apollo Client](https://www.apollographql.com/docs/react/)Follow the getting started instructions to install the required
packages.

[getting started instructions](https://www.apollographql.com/docs/react/get-started)- client.ts
- index.tsx
- App.tsx

```
import {    ApolloClient,    ApolloLink,    HttpLink,    InMemoryCache,} from '@apollo/client';import { setContext } from '@apollo/client/link/context';const API_URL = `https://demo.vendure.io/shop-api`;// If using bearer-token based session management, we'll store the token// in localStorage using this key.const AUTH_TOKEN_KEY = 'auth_token';let channelToken: string | undefined;let languageCode: string | undefined;const httpLink = new HttpLink({    uri: () => {        if (languageCode) {            return `${API_URL}?languageCode=${languageCode}`;        } else {            return API_URL;        }    },    // This is required if using cookie-based session management,    // so that any cookies get sent with the request.    credentials: 'include',});// This part is used to check for and store the session token// if it is returned by the server.const afterwareLink = new ApolloLink((operation, forward) => {    return forward(operation).map((response) => {        const context = operation.getContext();        const authHeader = context.response.headers.get('vendure-auth-token');        if (authHeader) {            // If the auth token has been returned by the Vendure            // server, we store it in localStorage            localStorage.setItem(AUTH_TOKEN_KEY, authHeader);        }        return response;    });});/** * Used to specify a channel token for projects that use * multiple Channels. */export function setChannelToken(value: string | undefined) {    channelToken = value;}/** * Used to specify a language for any localized results. */export function setLanguageCode(value: string | undefined) {    languageCode = value;}export const client = new ApolloClient({    link: ApolloLink.from([        // If we have stored the authToken from a previous        // response, we attach it to all subsequent requests.        setContext((request, operation) => {            const authToken = localStorage.getItem(AUTH_TOKEN_KEY);            let headers: Record<string, any> = {};            if (authToken) {                headers.authorization = `Bearer ${authToken}`;            }            if (channelToken) {                headers['vendure-token'] = channelToken;            }            return { headers };        }),        afterwareLink,        httpLink,    ]),    cache: new InMemoryCache(),});
```

```
import React from 'react';import * as ReactDOM from 'react-dom/client';import { ApolloProvider } from '@apollo/client';import App from './App';import { client } from './client';// Supported in React 18+const root = ReactDOM.createRoot(document.getElementById('root'));root.render(    <ApolloProvider client={client}>        <App />    </ApolloProvider>,);
```

```
import { useQuery, gql } from '@apollo/client';const GET_PRODUCTS = gql`    query GetProducts($options: ProductListOptions) {        products(options: $options) {            items {                id                name                slug                featuredAsset {                    preview                }            }        }    }`;export default function App() {    const { loading, error, data } = useQuery(GET_PRODUCTS, {        variables: { options: { take: 3 } },    });    if (loading) return <p>Loading...</p>;    if (error) return <p>Error : {error.message}</p>;    return data.products.items.map(({ id, name, slug, featuredAsset }) => (        <div key={id}>            <h3>{name}</h3>            <img src={`${featuredAsset.preview}?preset=small`} alt={name} />        </div>    ));}
```

Here's a live version of this example:

### TanStack Query​


[​](#tanstack-query)Here's an example using @tanstack/query in combination with graphql-request based on this guide.

[@tanstack/query](https://tanstack.com/query/latest)[graphql-request](https://github.com/jasonkuhrt/graphql-request)[this guide](https://tanstack.com/query/v4/docs/react/graphql)Note that in this example we have also installed the @graphql-typed-document-node/core package, which allows the
client to work with TypeScript code generation for type-safe queries.

[@graphql-typed-document-node/core package](https://github.com/dotansimha/graphql-typed-document-node)- client.ts
- App.tsx
- index.tsx

```
import type { TypedDocumentNode } from '@graphql-typed-document-node/core';import {    GraphQLClient,    RequestDocument,    RequestMiddleware,    ResponseMiddleware,    Variables,} from 'graphql-request';// If using bearer-token based session management, we'll store the token// in localStorage using this key.const AUTH_TOKEN_KEY = 'auth_token';const API_URL = 'http://localhost:3000/shop-api';// If we have a session token, add it to the outgoing requestconst requestMiddleware: RequestMiddleware = async (request) => {    const authToken = localStorage.getItem(AUTH_TOKEN_KEY);    return {        ...request,        headers: {            ...request.headers,            ...(authToken ? { authorization: `Bearer ${authToken}` } : {}),        },    };};// Check all responses for a new session tokenconst responseMiddleware: ResponseMiddleware = (response) => {    if (!(response instanceof Error) && !response.errors) {        const authHeader = response.headers.get('vendure-auth-token');        if (authHeader) {            // If the session token has been returned by the Vendure            // server, we store it in localStorage            localStorage.setItem(AUTH_TOKEN_KEY, authHeader);        }    }};const client = new GraphQLClient(API_URL, {    // Required for cookie-based sessions    credentials: 'include',    requestMiddleware,    responseMiddleware,});/** * Sets the languageCode to be used for all subsequent requests. */export function setLanguageCode(languageCode: string | undefined) {    if (!languageCode) {        client.setEndpoint(API_URL);    } else {        client.setEndpoint(`${API_URL}?languageCode=${languageCode}`);    }}/** * Sets the channel token to be used for all subsequent requests. */export function setChannelToken(channelToken: string | undefined) {    if (!channelToken) {        client.setHeader('vendure-token', undefined);    } else {        client.setHeader('vendure-token', channelToken);    }}/** * Makes a GraphQL request using the `graphql-request` client. */export function request<T, V extends Variables = Variables>(    document: RequestDocument | TypedDocumentNode<T, V>,    variables: Record<string, any> = {}) {    return client.request(document, variables);}
```

```
import * as React from 'react';import { gql } from 'graphql-request';import { useQuery } from '@tanstack/react-query';import { request } from './client';const GET_PRODUCTS = gql`    query GetProducts($options: ProductListOptions) {        products(options: $options) {            items {                id                name                slug                featuredAsset {                    preview                }            }        }    }`;export default function App() {    const { isLoading, data } = useQuery({        queryKey: ['products'],        queryFn: async () =>            request(GET_PRODUCTS, {                options: { take: 3 },            }),    });    if (isLoading) return <p>Loading...</p>;    return data ? (        data.products.items.map(({ id, name, slug, featuredAsset }) => (            <div key={id}>                <h3>{name}</h3>                <img src={`${featuredAsset.preview}?preset=small`} alt={name} />            </div>        ))    ) : (        <>Loading...</>    );}
```

```
import * as React from 'react';import { StrictMode } from 'react';import { createRoot } from 'react-dom/client';import { QueryClient, QueryClientProvider } from '@tanstack/react-query';import App from './App';// Create a clientconst queryClient = new QueryClient();const rootElement = document.getElementById('root');const root = createRoot(rootElement);root.render(    <StrictMode>        <QueryClientProvider client={queryClient}>            <App />        </QueryClientProvider>    </StrictMode>);
```

Here's a live version of this example:

```
import * as React from 'react';
import { gql } from 'graphql-request';
import { useQuery } from '@tanstack/react-query';
import { request } from './client';
import './style.css';

const GET_PRODUCTS = gql`
    query GetProducts($options: ProductListOptions) {
        products(options: $options) {
            items {
                id
                name
                slug
                featuredAsset {
                    preview
                }
            }
        }
    }
`;

export default function App() {
  const { isLoading, data } = useQuery({
    queryKey: ['products'],
    queryFn: async () =>
      request(GET_PRODUCTS, {
        options: { take: 3 },
      }),
  });

  if (isLoading) return <p>Loading...</p>;

  return data ? (
    data.products.items.map(({ id, name, slug, featuredAsset }) => (
      <div key={id}>
        <h3>{name}</h3>
        <img src={`${featuredAsset.preview}?preset=small`} alt={name} />
      </div>
    ))
  ) : (
    <>Loading...</>
  );
}

```

---

# Storefront GraphQL Code Generation


Code generation means the automatic generation of TypeScript types based on your GraphQL schema and your GraphQL operations.
This is a very powerful feature that allows you to write your code in a type-safe manner, without you needing to manually
write any types for your API calls.

To do this, we will use Graphql Code Generator.

[Graphql Code Generator](https://the-guild.dev/graphql/codegen)This guide is for adding codegen to your storefront. For a guide on adding codegen to your backend Vendure plugins or UI extensions, see the Plugin Codegen guide.

[Plugin Codegen](/guides/how-to/codegen/)
## Installation​


[​](#installation)Follow the installation instructions in the GraphQL Code Generator Quick Start.

[GraphQL Code Generator Quick Start](https://the-guild.dev/graphql/codegen/docs/getting-started/installation)Namely:

```
npm i graphqlnpm i -D typescript @graphql-codegen/clinpx graphql-code-generator initnpm install
```

During the init step, you'll be prompted to select various options about how to configure the code generation.

- Where is your schema?: Use http://localhost:3000/shop-api (unless you have configured a different GraphQL API URL)
- Where are your operations and fragments?: Use the appropriate glob pattern for you project. For example, src/**/*.{ts,tsx}.
- Select codegen.ts as the name of the config file.

## Configuration​


[​](#configuration)The init step above will create a codegen.ts file in your project root. Add the highlighted lines:

```
import type { CodegenConfig } from '@graphql-codegen/cli';const config: CodegenConfig = {  overwrite: true,  schema: 'http://localhost:3000/shop-api',  documents: 'src/**/*.graphql.ts',  generates: {    'src/gql/': {      preset: 'client',      plugins: [],      config: {        scalars: {            // This tells codegen that the `Money` scalar is a number            Money: 'number',        },        namingConvention: {            // This ensures generated enums do not conflict with the built-in types.            enumValues: 'keep',        },      }    },  }};export default config;
```

## Running Codegen​


[​](#running-codegen)During the init step, you will have installed a codegen script in your package.json. You can run this script to
generate the TypeScript types for your GraphQL operations.

Ensure you have the Vendure server running before running the codegen script.

```
npm run codegen
```

This will generate a src/gql directory containing the TypeScript types for your GraphQL operations.

## Use the graphql() function​


[​](#use-the-graphql-function)If you have existing GraphQL queries and mutations in your application, you can now use the graphql() function
exported by the src/gql/index.ts file to execute them. If you were previously using the gql tagged template function,
replace it with the graphql() function.

```
import { useQuery } from '@tanstack/react-query';import request from 'graphql-request'import { graphql } from './gql';// GET_PRODUCTS will be a `TypedDocumentNode` type,// which encodes the types of the query variables and the response data.const GET_PRODUCTS = graphql(`    query GetProducts($options: ProductListOptions) {        products(options: $options) {            items {                id                name                slug                featuredAsset {                    preview                }            }        }    }`);export default function App() {  // `data` will now be correctly typed  const { isLoading, data } = useQuery({    queryKey: ['products'],    queryFn: async () =>      request(        'http://localhost:3000/shop-api',        GET_PRODUCTS,        {        // The variables will also be correctly typed        options: { take: 3 },        }      ),  });  if (isLoading) return <p>Loading...</p>;  return data ? (    data.products.items.map(({ id, name, slug, featuredAsset }) => (      <div key={id}>        <h3>{name}</h3>        <img src={`${featuredAsset.preview}?preset=small`} alt={name} />      </div>    ))  ) : (    <>Loading...</>  );}
```

In the above example, the type information all works out of the box because the graphql-request library from v5.0.0
has built-in support for the TypedDocumentNode type,
as do the latest versions of most of the popular GraphQL client libraries, such as Apollo Client & Urql.

[TypedDocumentNode](https://github.com/dotansimha/graphql-typed-document-node)In the documentation examples on other pages, we do not assume the use of code generation in order to keep the examples as simple as possible.


---

# Navigation Menu


A navigation menu allows your customers to navigate your store and find the products they are looking for.

Typically, navigation is based on a hierarchy of collections. We can get the top-level
collections using the collections query with the topLevelOnly filter:

[collections](/guides/core-concepts/collections/)- Query
- Response

```
query GetTopLevelCollections {  collections(options: { topLevelOnly: true }) {    items {      id      slug      name      featuredAsset {        id        preview      }    }  }}
```

```
{  "data": {    "collections": {      "items": [        {          "id": "2",          "slug": "electronics",          "name": "Electronics",          "featuredAsset": {            "id": "16",            "preview": "https://demo.vendure.io/assets/preview/5b/jakob-owens-274337-unsplash__preview.jpg"          }        },        {          "id": "5",          "slug": "home-garden",          "name": "Home & Garden",          "featuredAsset": {            "id": "47",            "preview": "https://demo.vendure.io/assets/preview/3e/paul-weaver-1120584-unsplash__preview.jpg"          }        },        {          "id": "8",          "slug": "sports-outdoor",          "name": "Sports & Outdoor",          "featuredAsset": {            "id": "24",            "preview": "https://demo.vendure.io/assets/preview/96/michael-guite-571169-unsplash__preview.jpg"          }        }      ]    }  }}
```

## Building a navigation tree​


[​](#building-a-navigation-tree)The collections query returns a flat list of collections, but we often want to display them in a tree-like structure.
This way, we can build up a navigation menu which reflects the hierarchy of collections.

First of all we need to ensure that we have the parentId property on each collection.

```
query GetAllCollections {  collections(options: { topLevelOnly: true }) {    items {      id      slug      name      parentId      featuredAsset {        id        preview      }    }  }}
```

Then we can use this data to build up a tree structure. The following code snippet shows how this can be done in TypeScript:

```
export type HasParent = { id: string; parentId: string | null };export type TreeNode<T extends HasParent> = T & {    children: Array<TreeNode<T>>;};export type RootNode<T extends HasParent> = {    id?: string;    children: Array<TreeNode<T>>;};/** * Builds a tree from an array of nodes which have a parent. * Based on https://stackoverflow.com/a/31247960/772859, modified to preserve ordering. */export function arrayToTree<T extends HasParent>(nodes: T[]): RootNode<T> {    const topLevelNodes: Array<TreeNode<T>> = [];    const mappedArr: { [id: string]: TreeNode<T> } = {};    // First map the nodes of the array to an object -> create a hash table.    for (const node of nodes) {        mappedArr[node.id] = { ...(node as any), children: [] };    }    for (const id of nodes.map((n) => n.id)) {        if (mappedArr.hasOwnProperty(id)) {            const mappedElem = mappedArr[id];            const parentId = mappedElem.parentId;            if (!parent) {                continue;            }            // If the element is not at the root level, add it to its parent array of children.            const parentIsRoot = !mappedArr[parentId];            if (!parentIsRoot) {                if (mappedArr[parentId]) {                    mappedArr[parentId].children.push(mappedElem);                } else {                    mappedArr[parentId] = { children: [mappedElem] } as any;                }            } else {                topLevelNodes.push(mappedElem);            }        }    }    const rootId = topLevelNodes.length ? topLevelNodes[0].parentId : undefined;    return { id: rootId, children: topLevelNodes };}
```

## Live example​


[​](#live-example)Here's a live demo of the above code in action:

```
import * as React from 'react';
import { arrayToTree, HasParent, TreeNode } from './array-to-tree';
import { query, useQuery } from './client';
import './style.css';

const GET_ALL_COLLECTIONS = /*GraphQL*/ `
  query GetAllCollections {
    collections {
      items {
        id
        slug
        name
        parentId
        featuredAsset {
          id
          preview
        }
      }
    }
  }
`;

export default function App() {
  const { data, loading, error } = useQuery(GET_ALL_COLLECTIONS);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error : {error.message}</p>;
  return <CollectionList collection={arrayToTree(data.collections.items)} />;
}

function CollectionList(props: { collection: TreeNode<any> }) {
  return (
    <ul>
      {props.collection.children.map((child, i) => (
        <li>
          <a href={child.slug}>{child.name}</a>
          <CollectionList collection={child} />
        </li>
      ))}
    </ul>
  );
}
```

---

# Listing Products


Products are listed when:

- Displaying the contents of a collection
- Displaying search results

In Vendure, we usually use the search query for both of these. The reason is that the search query is optimized
for high performance, because it is backed by a dedicated search index. Other queries such as products or Collection.productVariants can also
be used to fetch a list of products, but they need to perform much more complex database queries, and are therefore slower.

## Listing products in a collection​


[​](#listing-products-in-a-collection)Following on from the navigation example, let's assume that a customer has
clicked on a collection item from the menu, and we want to display the products in that collection.

[navigation example](/guides/storefront/navigation-menu/)Typically, we will know the slug of the selected collection, so we can use the collection query to fetch the
details of this collection:

- Query
- Variables
- Response

```
query GetCollection($slug: String!) {  collection(slug: $slug) {    id    name    slug    description    featuredAsset {      id      preview    }  }}
```

```
{  "slug": "electronics"}
```

```
{  "data": {    "collection": {      "id": "2",      "name": "Electronics",      "slug": "electronics",      "description": "",      "featuredAsset": {        "id": "16",        "preview": "https://demo.vendure.io/assets/preview/5b/jakob-owens-274337-unsplash__preview.jpg"      }    }  }}
```

The collection data can be used to render the page header.

Next, we can use the search query to fetch the products in the collection:

- Query
- Variables
- Response

```
query GetCollectionProducts($slug: String!, $skip: Int, $take: Int) {  search(    input: {      collectionSlug: $slug,      groupByProduct: true,      skip: $skip,      take: $take }  ) {    totalItems    items {      productName      slug      productAsset {        id        preview      }      priceWithTax {        ... on SinglePrice {          value        }        ... on PriceRange {          min          max        }      }      currencyCode    }  }}
```

```
{  "slug": "electronics",  "skip": 0,  "take": 10}
```

(the following data has been truncated for brevity)

```
{  "data": {    "search": {      "totalItems": 20,      "items": [        {          "productName": "Laptop",          "slug": "laptop",          "productAsset": {            "id": "1",            "preview": "https://demo.vendure.io/assets/preview/71/derick-david-409858-unsplash__preview.jpg"          },          "priceWithTax": {            "min": 155880,            "max": 275880          },          "currencyCode": "USD"        },        {          "productName": "Tablet",          "slug": "tablet",          "productAsset": {            "id": "2",            "preview": "https://demo.vendure.io/assets/preview/b8/kelly-sikkema-685291-unsplash__preview.jpg"          },          "priceWithTax": {            "min": 39480,            "max": 53400          },          "currencyCode": "USD"        },      ],    },  },}
```

The key thing to note here is that we are using the collectionSlug input to the search query. This ensures
that the results all belong to the selected collection.

Here's a live demo of the above code in action:

## Product search​


[​](#product-search)The search query can also be used to perform a full-text search of the products in the catalog by passing the
term input:

- Query
- Variables
- Response

```
query SearchProducts($term: String!, $skip: Int, $take: Int) {  search(    input: {      term: $term,      groupByProduct: true,      skip: $skip,      take: $take }  ) {    totalItems    items {      productName      slug      productAsset {        id        preview      }      priceWithTax {        ... on SinglePrice {          value        }        ... on PriceRange {          min          max        }      }      currencyCode    }  }}
```

```
{  "term": "camera",  "skip": 0,  "take": 10}
```

(the following data has been truncated for brevity)

```
{  "data": {    "search": {      "totalItems": 8,      "items": [        {          "productName": "Instant Camera",          "slug": "instant-camera",          "productAsset": {            "id": "12",            "preview": "https://demo.vendure.io/assets/preview/b5/eniko-kis-663725-unsplash__preview.jpg"          },          "priceWithTax": {            "min": 20999,            "max": 20999          },          "currencyCode": "USD"        },        {          "productName": "Camera Lens",          "slug": "camera-lens",          "productAsset": {            "id": "13",            "preview": "https://demo.vendure.io/assets/preview/9b/brandi-redd-104140-unsplash__preview.jpg"          },          "priceWithTax": {            "min": 12480,            "max": 12480          },          "currencyCode": "USD"        }      ]    }  }}
```

You can also limit the full-text search to a specific collection by passing the
collectionSlug or collectionId input.

## Faceted search​


[​](#faceted-search)The search query can also be used to perform faceted search. This is a powerful feature which allows customers
to filter the results according to the facet values assigned to the products & variants.

By using the facetValues field, the search query will return a list of all the facet values which are present
in the result set. This can be used to render a list of checkboxes or other UI elements which allow the customer
to filter the results.

- Query
- Variables
- Response

```
query SearchProducts($term: String!, $skip: Int, $take: Int) {  search(    input: {      term: $term,      groupByProduct: true,      skip: $skip,      take: $take }  ) {    totalItems    facetValues {      count      facetValue {        id        name        facet {          id          name        }      }    }    items {      productName      slug      productAsset {        id        preview      }      priceWithTax {        ... on SinglePrice {          value        }        ... on PriceRange {          min          max        }      }      currencyCode    }  }}
```

```
{  "term": "camera",  "skip": 0,  "take": 10}
```

(the following data has been truncated for brevity)

```
{  "data": {    "search": {      "totalItems": 8,      "facetValues": [        {          "facetValue": {            "id": "1",            "name": "Electronics",            "facet": {              "id": "1",              "name": "category"            }          },          "count": 8        },        {          "facetValue": {            "id": "9",            "name": "Photo",            "facet": {              "id": "1",              "name": "category"            }          },          "count": 8        },        {          "facetValue": {            "id": "10",            "name": "Polaroid",            "facet": {              "id": "2",              "name": "brand"            }          },          "count": 1        },        {          "facetValue": {            "id": "11",            "name": "Nikkon",            "facet": {              "id": "2",              "name": "brand"            }          },          "count": 2        },        {          "facetValue": {            "id": "12",            "name": "Agfa",            "facet": {              "id": "2",              "name": "brand"            }          },          "count": 1        },        {          "facetValue": {            "id": "14",            "name": "Kodak",            "facet": {              "id": "2",              "name": "brand"            }          },          "count": 1        },        {          "facetValue": {            "id": "15",            "name": "Sony",            "facet": {              "id": "2",              "name": "brand"            }          },          "count": 1        },        {          "facetValue": {            "id": "16",            "name": "Rolleiflex",            "facet": {              "id": "2",              "name": "brand"            }          },          "count": 1        }      ],      "items": [        {          "productName": "Instant Camera",          "slug": "instant-camera",          "productAsset": {            "id": "12",            "preview": "https://demo.vendure.io/assets/preview/b5/eniko-kis-663725-unsplash__preview.jpg"          },          "priceWithTax": {            "min": 20999,            "max": 20999          },          "currencyCode": "USD"        },        {          "productName": "Camera Lens",          "slug": "camera-lens",          "productAsset": {            "id": "13",            "preview": "https://demo.vendure.io/assets/preview/9b/brandi-redd-104140-unsplash__preview.jpg"          },          "priceWithTax": {            "min": 12480,            "max": 12480          },          "currencyCode": "USD"        },        {          "productName": "Vintage Folding Camera",          "slug": "vintage-folding-camera",          "productAsset": {            "id": "14",            "preview": "https://demo.vendure.io/assets/preview/3c/jonathan-talbert-697262-unsplash__preview.jpg"          },          "priceWithTax": {            "min": 642000,            "max": 642000          },          "currencyCode": "USD"        }      ]    }  }}
```

These facet values can then be used to filter the results by passing them to the facetValueFilters input

For example, let's filter the results to only include products which have the "Nikkon" brand. Based on our last
request we know that there should be 2 such products, and that the facetValue.id for the "Nikkon" brand is 11.

```
{  "facetValue": {    "id": "11",    "name": "Nikkon",    "facet": {      "id": "2",      "name": "brand"    }  },  "count": 2}
```

Here's how we can use this information to filter the results:

In the next example, rather than passing each individual variable (skip, take, term) as a separate argument,
we are passing the entire SearchInput object as a variable. This allows us more flexibility in how
we use the query, as we can easily add or remove properties from the input object without having to
change the query itself.

- Query
- Variables
- Response

```
query SearchProducts($input: SearchInput!) {  search(input: $input) {    totalItems    facetValues {      count      facetValue {        id        name        facet {          id          name        }      }    }    items {      productName      slug      productAsset {        id        preview      }      priceWithTax {        ... on SinglePrice {          value        }        ... on PriceRange {          min          max        }      }      currencyCode    }  }}
```

```
{  "input": {    "term": "camera",    "skip": 0,    "take": 10,    "groupByProduct": true,    "facetValueFilters": [      { "and": "11" }    ]  }}
```

```
{  "data": {    "search": {      "totalItems": 2,      "facetValues": [        {          "facetValue": {            "id": "1",            "name": "Electronics",            "facet": {              "id": "1",              "name": "category"            }          },          "count": 2        },        {          "facetValue": {            "id": "9",            "name": "Photo",            "facet": {              "id": "1",              "name": "category"            }          },          "count": 2        },        {          "facetValue": {            "id": "11",            "name": "Nikkon",            "facet": {              "id": "2",              "name": "brand"            }          },          "count": 2        }      ],      "items": [        {          "productName": "Camera Lens",          "slug": "camera-lens",          "productAsset": {            "id": "13",            "preview": "https://demo.vendure.io/assets/preview/9b/brandi-redd-104140-unsplash__preview.jpg"          },          "priceWithTax": {            "value": 12480          },          "currencyCode": "USD"        },        {          "productName": "Nikkormat SLR Camera",          "slug": "nikkormat-slr-camera",          "productAsset": {            "id": "18",            "preview": "https://demo.vendure.io/assets/preview/95/chuttersnap-324234-unsplash__preview.jpg"          },          "priceWithTax": {            "value": 73800          },          "currencyCode": "USD"        }      ]    }  }}
```

The facetValueFilters input can be used to specify multiple filters, combining each with either and or or.

For example, to filter by both the "Camera" and "Nikkon" facet values, we would use:

```
{  "facetValueFilters": [    { "and": "9" },    { "and": "11" }  ]}
```

To filter by "Nikkon" or "Sony", we would use:

```
{  "facetValueFilters": [    { "or": ["11", "15"] }  ]}
```

Here's a live example of faceted search. Try searching for terms like "shoe", "plant" or "ball".

```
import * as React from 'react';
import { useDebounce } from 'use-debounce';
import { useQuery } from './client';
import { FacetValueFilters } from './FacetValueFilters';
import './style.css';

const SEARCH_PRODUCTS = /*GraphQL*/ `
query SearchProducts($input: SearchInput!) {
  search(input: $input) {
    totalItems
    facetValues {
      count
      facetValue {
        id
        name
        facet {
          id
          name
        }
      }
    }
    items {
      productName
      slug
      productAsset {
        id
        preview
      }
      priceWithTax {
        ... on SinglePrice {
          value
        }
        ... on PriceRange {
          min
          max
        }
      }
      currencyCode
    }
  }
}
`;

export default function App() {
  const [value, setValue] = React.useState('camera');
  const [filterIds, setFilterIds] = React.useState<string[]>([]);
  const [term] = useDebounce(value, 300);
  const { data, loading, error } = useQuery(
    SEARCH_PRODUCTS,
    {
      input: {
        term,
        groupByProduct: true,
        skip: 0,
        take: 10,
        facetValueFilters: filterIds.map((id) => ({ and: id })),
      },
    },
    [term, filterIds]
  );

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error : {error.message}</p>;

  return (
    <div>
      Search:{' '}
      <input
        style={{ fontSize: '16px' }}
        defaultValue={value}
        onChange={(e) => {
          setValue(e.target.value);
        }}
      />
      <FacetValueFilters
        results={data.search.facetValues}
        filerIds={filterIds}
        updateFilterIds={(ids) => setFilterIds(ids)}
      />
      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr' }}>
        {data.search.items.map(({ productName, slug, productAsset }) => (
          <div key={productName}>
            <h3>{productName}</h3>
            <img
              src={`${productAsset.preview}?preset=tiny`}
              alt={productName}
            />
          </div>
        ))}
      </div>
    </div>
  );
}
```

## Listing custom product data​


[​](#listing-custom-product-data)If you have defined custom fields on the Product or ProductVariant entity, you might want to include these in the
search results. With the DefaultSearchPlugin this is
not possible, as this plugin is designed to be a minimal and simple search implementation.

[DefaultSearchPlugin](/reference/typescript-api/default-search-plugin/)Instead, you can use the ElasticsearchPlugin which
provides advanced features which allow you to index custom data. The Elasticsearch plugin is designed as a drop-in
replacement for the DefaultSearchPlugin, so you can simply swap out the plugins in your vendure-config.ts file.

[ElasticsearchPlugin](/reference/core-plugins/elasticsearch-plugin/)


---

# Product Detail Page


The product detail page (often abbreviated to PDP) is the page that shows the details of a product and allows the user to add it to their cart.

Typically, the PDP should include:

- Product name
- Product description
- Available product variants
- Images of the product and its variants
- Price information
- Stock information
- Add to cart button

## Fetching product data​


[​](#fetching-product-data)Let's create a query to fetch the required data. You should have either the product's slug or id available from the
url. We'll use the slug in this example.

- Query
- Variables
- Response

```
query GetProductDetail($slug: String!) {  product(slug: $slug) {    id    name    description    featuredAsset {      id      preview    }    assets {      id      preview    }    variants {      id      name      sku      stockLevel      currencyCode      price      priceWithTax      featuredAsset {        id        preview      }      assets {        id        preview      }    }  }}
```

```
{  "slug": "laptop"}
```

```
{  "data": {    "product": {      "id": "1",      "name": "Laptop",      "description": "Now equipped with seventh-generation Intel Core processors, Laptop is snappier than ever. From daily tasks like launching apps and opening files to more advanced computing, you can power through your day thanks to faster SSDs and Turbo Boost processing up to 3.6GHz.",      "featuredAsset": {        "id": "1",        "preview": "https://demo.vendure.io/assets/preview/71/derick-david-409858-unsplash__preview.jpg"      },      "assets": [        {          "id": "1",          "preview": "https://demo.vendure.io/assets/preview/71/derick-david-409858-unsplash__preview.jpg"        }      ],      "variants": [        {          "id": "1",          "name": "Laptop 13 inch 8GB",          "sku": "L2201308",          "stockLevel": "IN_STOCK",          "currencyCode": "USD",          "price": 129900,          "priceWithTax": 155880,          "featuredAsset": null,          "assets": []        },        {          "id": "2",          "name": "Laptop 15 inch 8GB",          "sku": "L2201508",          "stockLevel": "IN_STOCK",          "currencyCode": "USD",          "price": 139900,          "priceWithTax": 167880,          "featuredAsset": null,          "assets": []        },        {          "id": "3",          "name": "Laptop 13 inch 16GB",          "sku": "L2201316",          "stockLevel": "IN_STOCK",          "currencyCode": "USD",          "price": 219900,          "priceWithTax": 263880,          "featuredAsset": null,          "assets": []        },        {          "id": "4",          "name": "Laptop 15 inch 16GB",          "sku": "L2201516",          "stockLevel": "IN_STOCK",          "currencyCode": "USD",          "price": 229900,          "priceWithTax": 275880,          "featuredAsset": null,          "assets": []        }      ]    }  }}
```

This single query provides all the data we need to display our PDP.

## Formatting prices​


[​](#formatting-prices)As explained in the Money & Currency guide, the prices are returned as integers in the
smallest unit of the currency (e.g. cents for USD). Therefore, when we display the price, we need to divide by 100 and
format it according to the currency's formatting rules.

[Money & Currency guide](/guides/core-concepts/money/)In the demo at the end of this guide, we'll use the formatCurrency function
which makes use of the browser's Intl API to format the price according to the user's locale.

[formatCurrency function](/guides/core-concepts/money/#displaying-monetary-values)
## Displaying images​


[​](#displaying-images)If we are using the AssetServerPlugin to serve our product images (as is the default), then we can take advantage
of the dynamic image transformation abilities in order to display the product images in the correct size and in
and optimized format such as WebP.

[AssetServerPlugin](/reference/core-plugins/asset-server-plugin/)This is done by appending a query string to the image URL. For example, if we want to use the 'large' size preset (800 x 800)
and convert the format to WebP, we'd use a url like this:

```
<img src={product.featuredAsset.preview + '?preset=large&format=webp'} />
```

An even more sophisticated approach would be to make use of the HTML <picture> element to provide multiple image sources
so that the browser can select the optimal format. This can be wrapped in a component to make it easier to use. For example:

[<picture> element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/picture)
```
interface VendureAssetProps {    preview: string;    preset: 'tiny' | 'thumb' | 'small' | 'medium' | 'large';    alt: string;}export function VendureAsset({ preview, preset, alt }: VendureAssetProps) {    return (        <picture>            <source type="image/avif" srcSet={preview + `?preset=${preset}&format=avif`} />            <source type="image/webp" srcSet={preview + `?preset=${preset}&format=webp`} />            <img src={preview + `?preset=${preset}&format=jpg`} alt={alt} />        </picture>    );}
```

## Adding to the order​


[​](#adding-to-the-order)To add a particular product variant to the order, we need to call the addItemToOrder mutation.
This mutation takes the productVariantId and the quantity as arguments.

[addItemToOrder](/reference/graphql-api/shop/mutations/#additemtoorder)- Mutation
- Variables
- Response

```
mutation AddItemToOrder($variantId: ID!, $quantity: Int!) {  addItemToOrder(productVariantId: $variantId, quantity: $quantity) {    __typename    ...UpdatedOrder    ... on ErrorResult {      errorCode      message    }    ... on InsufficientStockError {      quantityAvailable      order {        ...UpdatedOrder      }    }  }}fragment UpdatedOrder on Order {  id  code  state  totalQuantity  totalWithTax  currencyCode  lines {    id    unitPriceWithTax    quantity    linePriceWithTax    productVariant {      id      name    }  }}
```

```
{  "variantId": "4",  "quantity": 1}
```

```
{  "data": {    "addItemToOrder": {      "__typename": "Order",      "id": "5",      "code": "KE5FJPVV3Y3LX134",      "state": "AddingItems",      "totalQuantity": 1,      "totalWithTax": 275880,      "lines": [        {          "id": "14",          "unitPriceWithTax": 275880,          "quantity": 1,          "linePriceWithTax": 275880        }      ]    }  }}
```

There are some important things to note about this mutation:

- Because the addItemToOrder mutation returns a union type, we need to use a fragment to specify the fields we want to return.
In this case we have defined a fragment called UpdatedOrder which contains the fields we are interested in.
- If any expected errors occur, the mutation will return an ErrorResult object. We'll be able to
see the errorCode and message fields in the response, so that we can display a meaningful error message to the user.
- In the special case of the InsufficientStockError, in addition to the errorCode and message fields, we also get the quantityAvailable field
which tells us how many of the requested quantity are available (and have been added to the order). This is useful information to display to the user.
The InsufficientStockError object also embeds the updated Order object, which we can use to update the UI.
- The __typename field can be used by the client to determine which type of object has been returned. Its value will equal the name
of the returned type. This means that we can check whether __typename === 'Order' in order to determine whether the mutation was successful.

[fragment](/guides/getting-started/graphql-intro/#fragments)[expected errors](/guides/developer-guide/error-handling/)
## Live example​


[​](#live-example)Here's an example that brings together all of the above concepts:

```
import * as React from 'react';
import { query, useQuery } from './client';
import { VendureAsset } from './components/VendureAsset';
import './style.css';
import { formatCurrency } from './utils';
import {
  ADD_ITEM_TO_ORDER,
  GET_ACTIVE_ORDER,
  GET_PRODUCT_DETAIL,
} from './documents';
import { OrderPartial, ProductVariantPartial } from './types';
import { OrderContents } from './components/OrderContents';

export default function App() {
  const [selectedVariant, setSelectedVariant] =
    React.useState<ProductVariantPartial>();
  const [activeOrder, setActiveOrder] = React.useState<OrderPartial>();
  const { data: orderData } = useQuery(GET_ACTIVE_ORDER);
  const {
    data: productData,
    loading,
    error,
  } = useQuery(GET_PRODUCT_DETAIL, {
    slug: 'laptop',
  });

  if (orderData?.activeOrder && !activeOrder) {
    setActiveOrder(orderData.activeOrder);
  }

  if (productData?.product && !selectedVariant) {
    setSelectedVariant(productData.product.variants[0]);
  }

  const selectVariant = (e) => {
    const variantId = e.target.value;
    setSelectedVariant(
      productData.product.variants.find((v) => v.id === variantId)
    );
  };

  const addItem = async (e) => {
    // Prevent the browser from reloading the page
    e.preventDefault();
    const form = e.target;
    const quantity = +new FormData(form).get('quantity') ?? 1;
    const result = await query(ADD_ITEM_TO_ORDER, {
      variantId: selectedVariant.id,
      quantity,
    });
    if (result.data.addItemToOrder.__typename !== 'Order') {
      // An error occurred!
      window.alert(result.data.addItemToOrder.message);
    } else {
      setActiveOrder(result.data.addItemToOrder);
    }
  };

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error : {error.message}</p>;

  return (
    <div>
      <h1>{productData.product.name}</h1>
      <p>{productData.product.description}</p>
      <VendureAsset
        preview={productData.product.featuredAsset.preview}
        preset="medium"
        alt={productData.product.name}
      />

      <select name="productVariantId" onChange={selectVariant}>
        {productData.product.variants.map((v) => (
          <option key={v.id} value={v.id}>
            {v.name}
          </option>
        ))}
      </select>
      {selectedVariant && (
        <div className="variant-details">
          <div className="flex">
            <div>{selectedVariant.sku}</div>
            <div className="stock-level">{selectedVariant.stockLevel}</div>
          </div>
          <div>
            <strong>
              {formatCurrency(
                selectedVariant.priceWithTax,
                selectedVariant.currencyCode
              )}
            </strong>
          </div>
          <form method="post" onSubmit={addItem}>
            <input name="quantity" type="number" min="0" defaultValue={1} />
            <button type="submit">Add to cart</button>
          </form>
        </div>
      )}
      {activeOrder && <OrderContents order={activeOrder} />}
    </div>
  );
}
```

---

# Managing the Active Order


The "active order" is what is also known as the "cart" - it is the order that is currently being worked on by the customer.

An order remains active until it is completed, and during this time it can be modified by the customer in various ways:

- Adding an item
- Removing an item
- Changing the quantity of items
- Applying a coupon
- Removing a coupon

This guide will cover how to manage the active order.

## Define an Order fragment​


[​](#define-an-order-fragment)Since all the mutations that we will be using in this guide require an Order object, we will define a fragment that we can
reuse in all of our mutations.

```
const ACTIVE_ORDER_FRAGMENT = /*GraphQL*/`fragment ActiveOrder on Order {  __typename  id  code  couponCodes  state  currencyCode  totalQuantity  subTotalWithTax  shippingWithTax  totalWithTax  discounts {    description    amountWithTax  }  lines {    id    unitPriceWithTax    quantity    linePriceWithTax    productVariant {      id      name      sku    }    featuredAsset {      id      preview    }  }  shippingLines {    shippingMethod {      description    }    priceWithTax  }}`
```

The __typename field is used to determine the type of the object returned by the GraphQL server. In this case, it will always be 'Order'.

Some GraphQL clients such as Apollo Client will automatically add the __typename field to all queries and mutations, but if you are using a different client you may need to add it manually.

This fragment can then be used in subsequent queries and mutations by using the ... spread operator in the place where an Order object is expected.
You can then embed the fragment in the query or mutation by using the ${ACTIVE_ORDER_FRAGMENT} syntax:

```
import { ACTIVE_ORDER_FRAGMENT } from './fragments';export const GET_ACTIVE_ORDER = /*GraphQL*/`  query GetActiveOrder {    activeOrder {      ...ActiveOrder    }  }  ${ACTIVE_ORDER_FRAGMENT}`;
```

For the remainder of this guide, we will list just the body of the query or mutation, and assume that the fragment is defined and imported as above.

## Get the active order​


[​](#get-the-active-order)This fragment can then be used in subsequent queries and mutations. Let's start with a query to get the active order using the activeOrder query:

[activeOrder query](/reference/graphql-api/shop/queries#activeorder)
```
query GetActiveOrder {  activeOrder {    ...ActiveOrder  }}
```

## Add an item​


[​](#add-an-item)To add an item to the active order, we use the addItemToOrder mutation, as we have seen in the Product Detail Page guide.

[addItemToOrder mutation](/reference/graphql-api/shop/mutations/#additemtoorder)[Product Detail Page guide](/guides/storefront/product-detail/)
```
mutation AddItemToOrder($productVariantId: ID!, $quantity: Int!) {  addItemToOrder(productVariantId: $productVariantId, quantity: $quantity) {    ...ActiveOrder    ... on ErrorResult {      errorCode      message    }    ... on InsufficientStockError {      quantityAvailable      order {        ...ActiveOrder      }    }  }}
```

If you have defined any custom fields on the OrderLine entity, you will be able to pass them as a customFields argument to the addItemToOrder mutation.
See the Configurable Products guide for more information.

[Configurable Products guide](/guides/how-to/configurable-products/)
## Remove an item​


[​](#remove-an-item)To remove an item from the active order, we use the removeOrderLine mutation,
and pass the id of the OrderLine to remove.

[removeOrderLine mutation](/reference/graphql-api/shop/mutations/#removeorderline)
```
mutation RemoveItemFromOrder($orderLineId: ID!) {  removeOrderLine(orderLineId: $orderLineId) {    ...ActiveOrder    ... on ErrorResult {      errorCode      message    }  }}
```

## Change the quantity of an item​


[​](#change-the-quantity-of-an-item)To change the quantity of an item in the active order, we use the adjustOrderLine mutation.

[adjustOrderLine mutation](/reference/graphql-api/shop/mutations/#adjustorderline)
```
mutation AdjustOrderLine($orderLineId: ID!, $quantity: Int!) {  adjustOrderLine(orderLineId: $orderLineId, quantity: $quantity) {    ...ActiveOrder    ... on ErrorResult {        errorCode        message    }  }}
```

If you have defined any custom fields on the OrderLine entity, you will be able to update their values by passing a customFields argument to the adjustOrderLine mutation.
See the Configurable Products guide for more information.

[Configurable Products guide](/guides/how-to/configurable-products/)
## Applying a coupon code​


[​](#applying-a-coupon-code)If you have defined any Promotions which use coupon codes, you can apply the a coupon code to the active order
using the applyCouponCode mutation.

[Promotions](/guides/core-concepts/promotions/)[applyCouponCode mutation](/reference/graphql-api/shop/mutations/#applycouponcode)
```
mutation ApplyCouponCode($couponCode: String!) {  applyCouponCode(couponCode: $couponCode) {    ...ActiveOrder    ... on ErrorResult {      errorCode      message    }  }}
```

## Removing a coupon code​


[​](#removing-a-coupon-code)To remove a coupon code from the active order, we use the removeCouponCode mutation.

[removeCouponCode mutation](/reference/graphql-api/shop/mutations/#removecouponcode)
```
mutation RemoveCouponCode($couponCode: String!) {  removeCouponCode(couponCode: $couponCode) {    ...ActiveOrder  }}
```

## Live example​


[​](#live-example)Here is a live example which demonstrates adding, updating and removing items from the active order:

```
import * as React from 'react';
import { query, useQuery } from './client';
import { VendureAsset } from './components/VendureAsset';
import './style.css';
import { formatCurrency } from './utils';
import {
  ADD_ITEM_TO_ORDER,
  ADJUST_ORDER_LINE,
  GET_ACTIVE_ORDER,
  REMOVE_ITEM_FROM_ORDER,
} from './documents';
import { OrderPartial } from './types';

export default function App() {
  const [activeOrder, setActiveOrder] = React.useState<OrderPartial>();
  const { data, loading, error } = useQuery(GET_ACTIVE_ORDER);

  if (data?.activeOrder && !activeOrder) {
    setActiveOrder(data.activeOrder);
  }

  const addItem = async (e) => {
    // Prevent the browser from reloading the page
    e.preventDefault();
    // Read the form data
    const form = e.target;
    const variantId = +new FormData(form).get('productVariantId');
    const result = await query(ADD_ITEM_TO_ORDER, {
      productVariantId: variantId,
      quantity: 1,
    });
    if (result.data.addItemToOrder.__typename !== 'Order') {
      // An error occurred!
      window.alert(result.data.addItemToOrder.message);
    } else {
      setActiveOrder(result.data.addItemToOrder);
    }
  };

  const adjustOrderLine = async (orderLineId: string, quantity: number) => {
    const result = await query(ADJUST_ORDER_LINE, {
      orderLineId,
      quantity,
    });
    if (result.data.adjustOrderLine.__typename !== 'Order') {
      // An error occurred!
      window.alert(result.data.adjustOrderLine.message);
    } else {
      setActiveOrder(result.data.adjustOrderLine);
    }
  };

  const removeItem = async (orderLineId: string) => {
    const result = await query(REMOVE_ITEM_FROM_ORDER, {
      orderLineId,
    });
    if (result.data.removeOrderLine.__typename !== 'Order') {
      // An error occurred!
      window.alert(result.data.removeOrderLine.message);
    } else {
      setActiveOrder(result.data.removeOrderLine);
    }
  };

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error : {error.message}</p>;

  return (
    <div>
      <form method="post" onSubmit={addItem}>
        <select name="productVariantId">
          <option value="84">Wooden Stool</option>
          <option value="34">Twin Lens Camera</option>
          <option value="37">Boxing Gloves</option>
          <option value="67">Spiky Cactus</option>
        </select>
        <button type="submit">Add to order</button>
      </form>
      <div>
        <h2>Active Order</h2>
        {activeOrder ? (
          <table>
            <tbody>
              {activeOrder.lines.map((l) => (
                <tr key={l.id}>
                  <td>
                    <VendureAsset
                      preview={l.featuredAsset.preview}
                      preset="tiny"
                      alt={l.productVariant.name}
                    />
                  </td>
                  <td>{l.productVariant.name}</td>
                  <td>
                    <div className="qty-cell">
                      <button
                        onClick={() => adjustOrderLine(l.id, l.quantity - 1)}
                      >
                        -
                      </button>
                      <span>{l.quantity}</span>
                      <button
                        onClick={() => adjustOrderLine(l.id, l.quantity + 1)}
                      >
                        +
                      </button>
                    </div>
                    <button onClick={() => removeItem(l.id)}>remove</button>
                  </td>
                  <td>
                    {formatCurrency(
                      l.linePriceWithTax,
                      activeOrder.currencyCode
                    )}
                  </td>
                </tr>
              ))}
              <tr className="totals">
                <td></td>
                <td>Total</td>
                <td>{activeOrder.totalQuantity}</td>
                <td>
                  {formatCurrency(
                    activeOrder.totalWithTax,
                    activeOrder.currencyCode
                  )}
                </td>
              </tr>
            </tbody>
          </table>
        ) : (
          <div>Order is empty</div>
        )}
      </div>
    </div>
  );
}
```

---

# Checkout Flow


Once the customer has added the desired products to the active order, it's time to check out.

This guide assumes that you are using the default OrderProcess, so
if you have defined a custom process, some of these steps may be slightly different.

[default OrderProcess](/guides/core-concepts/orders/#the-order-process)In this guide, we will assume that an ActiveOrder fragment has been defined, as detailed in the
Managing the Active Order guide, but for the purposes of
checking out the fragment should also include customer shippingAddress and billingAddress fields.

[Managing the Active Order guide](/guides/storefront/active-order/#define-an-order-fragment)
## Add a customer​


[​](#add-a-customer)Every order must be associated with a customer. If the customer is not logged in, then the setCustomerForOrder mutation must be called. This will create a new Customer record if the provided email address does not already exist in the database.

[setCustomerForOrder](/reference/graphql-api/shop/mutations/#setcustomerfororder)If the customer is already logged in, then this step is skipped.

- Mutation
- Variables

```
mutation SetCustomerForOrder($input: CreateCustomerInput!) {  setCustomerForOrder(input: $input) {    ...ActiveOrder    ...on ErrorResult {      errorCode      message    }  }}
```

```
{  "input": {    "title": "Mr.",    "firstName": "Bob",    "lastName": "Dobalina",    "phoneNumber": "1234556",    "emailAddress": "b.dobalina@email.com",  }}
```

## Set the shipping address​


[​](#set-the-shipping-address)The setOrderShippingAddress mutation must be called to set the shipping address for the order.

[setOrderShippingAddress](/reference/graphql-api/shop/mutations/#setordershippingaddress)- Mutation
- Variables

```
mutation SetOrderShippingAddress($input: CreateAddressInput!) {  setOrderShippingAddress(input: $input) {    ...ActiveOrder    ...on ErrorResult {      errorCode      message    }  }}
```

```
{  "input": {    "fullName": "John Doe",    "company": "ABC Inc.",    "streetLine1": "123 Main St",    "streetLine2": "Apt 4B",    "city": "New York",    "province": "NY",    "postalCode": "10001",    "countryCode": "US",    "phoneNumber": "123-456-7890",    "defaultShippingAddress": true,    "defaultBillingAddress": false  }}
```

If the customer is logged in, you can check their existing addresses and pre-populate an address form if an existing address is found.

- Query
- Result

```
query GetCustomerAddresses {  activeCustomer {    id    addresses {      id      fullName      company      streetLine1      streetLine2      city      province      postalCode      country {        code        name      }      phoneNumber      defaultShippingAddress      defaultBillingAddress    }  }}
```

```
{  "data": {    "activeCustomer": {      "id": "123456",      "addresses": [        {          "id": "123",          "fullName": "John Doe",          "company": "",          "streetLine1": "123 Main St",          "streetLine2": "Apt 4B",          "city": "New York",          "province": "NY",          "postalCode": "10001",          "country": {            "code": "US",            "name": "United States"          },          "phoneNumber": "123-456-7890",          "defaultShippingAddress": true,          "defaultBillingAddress": false        },        {          "id": "124",          "fullName": "John Doe",          "company": "",          "streetLine1": "456 Elm St",          "streetLine2": "",          "city": "Los Angeles",          "province": "CA",          "postalCode": "90001",          "country": {            "code": "US",            "name": "United States"          },          "phoneNumber": "987-654-3210",          "defaultShippingAddress": false,          "defaultBillingAddress": true        }      ]    }  }}
```

## Set the shipping method​


[​](#set-the-shipping-method)Now that we know the shipping address, we can check which shipping methods are available with the eligibleShippingMethods query.

[eligibleShippingMethods](/reference/graphql-api/shop/queries/#eligibleshippingmethods)- Query
- Result

```
query GetShippingMethods {  eligibleShippingMethods {    id    price    description  }}
```

```
{  "data": {    "eligibleShippingMethods": [      {        "id": "1",        "price": 545,        "description": "Standard Shipping"      },      {        "id": "2",        "price": 1250,        "description": "Expedited Shipping"      },      {        "id": "3",        "price": 1695,        "description": "Overnight Shipping"      }    ]  }}
```

The results can then be displayed to the customer so they can choose the desired shipping method. If there is only a single
result, then it can be automatically selected.

The desired shipping method's id is then passed to the setOrderShippingMethod mutation.

[setOrderShippingMethod](/reference/graphql-api/shop/mutations/#setordershippingmethod)
```
mutation SetShippingMethod($id: [ID!]!) {    setOrderShippingMethod(shippingMethodId: $id) {        ...ActiveOrder        ...on ErrorResult {            errorCode            message        }    }}
```

## Add payment​


[​](#add-payment)The eligiblePaymentMethods query can be used to get a list of available payment methods.
This list can then be displayed to the customer, so they can choose the desired payment method.

[eligiblePaymentMethods](/reference/graphql-api/shop/queries/#eligiblepaymentmethods)- Query
- Result

```
query GetPaymentMethods {  eligiblePaymentMethods {    id    name    code    isEligible  }}
```

```
{  "data": {    "eligiblePaymentMethods": [      {        "id": "1",        "name": "Stripe",        "code": "stripe",        "isEligible": true      },      {        "id": "2",        "name": "Apple Pay",        "code": "apple-pay",        "isEligible": true      }      {        "id": "3",        "name": "Pay on delivery",        "code": "pay-on-delivery",        "isEligible": false      }    ]  }}
```

Next, we need to transition the order to the ArrangingPayment state. This state ensures that no other changes can be made to the order
while the payment is being arranged. The transitionOrderToState mutation is used to transition the order to the ArrangingPayment state.

[transitionOrderToState](/reference/graphql-api/shop/mutations/#transitionordertostate)- Query
- Variables

```
mutation TransitionToState($state: String!) {  transitionOrderToState(state: $state) {    ...ActiveOrder    ...on OrderStateTransitionError {      errorCode      message      transitionError      fromState      toState    }  }}
```

```
{  "state": "ArrangingPayment"}
```

At this point, your storefront will use an integration with the payment provider to collect the customer's payment details, and then
the exact sequence of API calls will depend on the payment integration.

The addPaymentToOrder mutation is the general-purpose mutation for adding a payment to an order.
It accepts a method argument which must corresponde to the code of the selected payment method, and a metadata argument which is a JSON object containing any additional information required by that particular integration.

[addPaymentToOrder](/reference/graphql-api/shop/mutations/#addpaymenttoorder)For example, the demo data populated in a new Vendure installation includes a "Standard Payment" method, which uses the dummyPaymentHandler to simulate a payment provider. Here's how you would add a payment using this method:

[dummyPaymentHandler](/reference/typescript-api/payment/dummy-payment-handler)- Mutation
- Variables

```
mutation AddPaymentToOrder($input: PaymentInput!) {  addPaymentToOrder(input: $input) {    ...ActiveOrder    ...on ErrorResult {      errorCode      message    }  }}
```

```
{  "method": "standard-payment",  "metadata": {    "shouldDecline": false,    "shouldError": false,    "shouldErrorOnSettle": false,  }}
```

Other payment integrations have specific setup instructions you must follow:

### Stripe​


[​](#stripe)Our StripePlugin docs describe how to set up your checkout to use Stripe.

[StripePlugin docs](/reference/core-plugins/payments-plugin/stripe-plugin/)
### Braintree​


[​](#braintree)Our BraintreePlugin docs describe how to set up your checkout to use Braintree.

[BraintreePlugin docs](/reference/core-plugins/payments-plugin/braintree-plugin/)
### Mollie​


[​](#mollie)Our MolliePlugin docs describe how to set up your checkout to use Mollie.

[MolliePlugin docs](/reference/core-plugins/payments-plugin/mollie-plugin/)
### Other payment providers​


[​](#other-payment-providers)For more information on how to integrate with a payment provider, see the Payment guide.

[Payment](/guides/core-concepts/payment/)
## Display confirmation​


[​](#display-confirmation)Once the checkout has completed, the order will no longer be considered "active" (see the OrderPlacedStrategy) and so the activeOrder query will return null. Instead, the orderByCode query can be used to retrieve the order by its code to display a confirmation page.

[OrderPlacedStrategy](/reference/typescript-api/orders/order-placed-strategy/)[activeOrder](/reference/graphql-api/shop/queries/#activeorder)[orderByCode](/reference/graphql-api/shop/queries/#orderbycode)- Query
- Variables

```
query GetOrderByCode($code: String!) {  orderByCode(code: $code) {    ...Order  }}
```

```
{  "code": "PJGY46GCB1EDU9YH"}
```

By default Vendure will only allow access to the order by code for the first 2 hours after the order is placed if the customer is not logged in.
This is to prevent a malicious user from guessing order codes and viewing other customers' orders. This can be configured via the OrderByCodeAccessStrategy.

[OrderByCodeAccessStrategy](/reference/typescript-api/orders/order-by-code-access-strategy/)


---

# Customer Accounts


Customers can register accounts and thereby gain the ability to:

- View past orders
- Store multiple addresses
- Maintain an active order across devices
- Take advantage of plugins that expose functionality to registered customers only, such as wishlists & loyalty points.

## Querying the active customer​


[​](#querying-the-active-customer)The activeCustomer query will return a Customer object if the customer is registered and logged in, otherwise it will return null. This can be used in the storefront header for example to
determine whether to display a "sign in" or "my account" link.

[activeCustomer query](/reference/graphql-api/shop/queries/#activecustomer)[Customer](/reference/graphql-api/shop/object-types#customer)- Query
- Result

```
query GetCustomerAddresses {  activeCustomer {    id    title    firstName    lastName    emailAddress  }}
```

```
{  "data": {    "activeCustomer": {      "id": "12345",      "title": "Mr.",      "firstName": "John",      "lastName": "Doe",      "emailAddress": "john.doe@email.com"    }  }}
```

## Logging in and out​


[​](#logging-in-and-out)The login mutation is used to attempt to log in using email address and password.
Given correct credentials, a new authenticated session will begin for that customer.

[login mutation](/reference/graphql-api/shop/mutations#login)- Query
- Variables
- Result

```
mutation LogIn($emailAddress: String!, $password: String!, $rememberMe: Boolean!) {  login(username: $emailAddress, password: $password, rememberMe: $rememberMe) {    ... on  CurrentUser {      id      identifier    }    ... on ErrorResult {      errorCode      message    }  }}
```

```
{  "emailAddress": "john.doe@email.com",  "password": "**********",  "rememberMe": true,}
```

```
{  "data": {    "login": {      "id": "12345",      "identifier": "john.doe@email.com"    }  }}
```

The logout mutation will end an authenticated customer session.

[logout mutation](/reference/graphql-api/shop/mutations#logout)- Query
- Result

```
mutation LogOut {  logout {    success  }}
```

```
{  "data": {    "logout": {      "success": true,    }  }}
```

The login mutation, as well as the following mutations related to registration & password recovery only
apply when using the built-in NativeAuthenticationStrategy.

[NativeAuthenticationStrategy](/reference/typescript-api/auth/native-authentication-strategy/)If you are using alternative authentication strategies in your storefront, you would use the authenticate mutation as covered in the External Authentication guide.

[authenticate mutation](/reference/graphql-api/shop/mutations/#authenticate)[External Authentication guide](/guides/core-concepts/auth/#external-authentication)
## Registering a customer account​


[​](#registering-a-customer-account)The registerCustomerAccount mutation is used to register a new customer account.

[registerCustomerAccount mutation](/reference/graphql-api/shop/mutations/#registercustomeraccount)There are three possible registration flows:
If authOptions.requireVerification is set to true (the default):

[authOptions.requireVerification](/reference/typescript-api/auth/auth-options/#requireverification)- The Customer is registered with a password. A verificationToken will be created (and typically emailed to the Customer). That
verificationToken would then be passed to the verifyCustomerAccount mutation without a password. The Customer is then
verified and authenticated in one step.
- The Customer is registered without a password. A verificationToken will be created (and typically emailed to the Customer). That
verificationToken would then be passed to the verifyCustomerAccount mutation with the chosen password of the Customer. The Customer is then
verified and authenticated in one step.

If authOptions.requireVerification is set to false:

- The Customer must be registered with a password. No further action is needed - the Customer is able to authenticate immediately.

Here's a diagram of the second scenario, where the password is supplied during the verification step.

Here's how the mutations would look for the above flow:

- Mutation
- Variables
- Result

```
mutation Register($input: RegisterCustomerInput!) {  registerCustomerAccount(input: $input) {    ... on Success {      success    }    ...on ErrorResult {      errorCode      message    }  }}
```

```
{  "input: {    "title": "Mr."    "firstName": "Nicky",    "lastName": "Wire",    "emailAddress": "nicky@example.com",    "phoneNumber": "1234567",  }}
```

```
{  "data": {    "registerCustomerAccount": {      "success": true,    }  }}
```

Note that in the variables above, we did not specify a password, as this will be done at the verification step.
If a password does get passed at this step, then it won't be needed at the verification step. This is a decision
you can make based on the desired user experience of your storefront.

Upon registration, the EmailPlugin will generate an email to the
customer containing a link to the verification page. In a default Vendure installation this is set in the vendure config file:

[EmailPlugin](/reference/core-plugins/email-plugin/)
```
EmailPlugin.init({    route: 'mailbox',    handlers: defaultEmailHandlers,    templatePath: path.join(__dirname, '../static/email/templates'),    outputPath: path.join(__dirname, '../static/email/output'),    globalTemplateVars: {        fromAddress: '"Vendure Demo Store" <noreply@vendure.io>',        verifyEmailAddressUrl: 'https://demo.vendure.io/storefront/account/verify',        passwordResetUrl: 'https://demo.vendure.io/storefront/account/reset-password',        changeEmailAddressUrl: 'https://demo.vendure.io/storefront/account/change-email-address'    },    devMode: true,}),
```

The verification page needs to get the token from the query string, and pass it to the verifyCustomerAccount mutation:

[verifyCustomerAccount mutation](/reference/graphql-api/shop/mutations/#verifycustomeraccount)- Mutation
- Variables
- Result

```
mutation Verify($password: String!, $token: String!) {  verifyCustomerAccount(password: $password, token: $token) {    ...on CurrentUser {      id      identifier    }    ...on ErrorResult {      errorCode      message    }  }}
```

```
{  "password": "*********",  "token": "MjAxOS0xMC0wMlQxNToxOTo1NC45NDVa_1DYEWYAB7S3S82JT"}
```

```
{  "data": {    "verifyCustomerAccount": {      "id": "123",      "identifier": "nicky@example.com"    }  }}
```

## Password reset​


[​](#password-reset)Here's how to implement a password reset flow. It is conceptually very similar to the verification flow described above.

A password reset is triggered by the requestPasswordReset mutation:

[requestPasswordReset mutation](/reference/graphql-api/shop/mutations/#requestpasswordreset)- Mutation
- Variables
- Result

```
mutation RequestPasswordReset($emailAddress: String!) {  requestPasswordReset(emailAddress: $emailAddress) {    ... on Success {      success    }    ... on ErrorResult {      errorCode      message    }  }}
```

```
{  "emailAddress": "nicky@example.com",}
```

```
{  "data": {    "requestPasswordReset": {      "success": true,    }  }}
```

Again, this mutation will trigger an event which the EmailPlugin's default email handlers will pick up and send
an email to the customer. The password reset page then needs to get the token from the url and pass it to the
resetPassword mutation:

[resetPassword mutation](/reference/graphql-api/shop/mutations/#resetpassword)- Mutation
- Variables
- Result

```
mutation ResetPassword($token: String! $password: String!) {  resetPassword(token: $token password: $password) {    ...on CurrentUser {      id      identifier    }    ... on ErrorResult {      errorCode      message    }  }}
```

```
{  "token": "MjAxOS0xMC0wMlQxNToxOTo1NC45NDVa_1DYEWYAB7S3S82JT",  "password": "************"}
```

```
{  "data": {    "resetPassword": {      "id": "123",      "identifier": "nicky@example.com"    }  }}
```