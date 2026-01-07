# Installation


## Requirements​


[​](#requirements)- Node.js v20, v22 and v24 - these versions are tested and supported. (Odd-numbered versions above v20 should still work but are not officially supported.)

[Node.js](https://nodejs.org/en/)
### Optional​


[​](#optional)- Docker Desktop: If you want to use the quick start with Postgres, you must have Docker Desktop installed. If you do not have Docker Desktop installed, then SQLite will be used for your database.
- If you want to use an existing MySQL, MariaDB, or Postgres server as your data store, then you'll need an instance available locally. However, if you are just testing out Vendure, we recommend the quick start option, which handles the database for you.

[Docker Desktop](https://www.docker.com/products/docker-desktop/)
## @vendure/create​


[​](#vendurecreate)The recommended way to get started with Vendure is by using the @vendure/create tool. This is a command-line tool which will scaffold and configure your new Vendure project and install all dependencies.

[@vendure/create](https://github.com/vendure-ecommerce/vendure/tree/master/packages/create)
### Quick Start​


[​](#quick-start)First, run the following command in your terminal, replacing my-shop with the name of your project:

```
npx @vendure/create my-shop
```

Next, choose the "Quick Start" option. This is the fastest way to get a Vendure server up and running and will handle all the configuration for you.
If you have Docker Desktop installed, it will create and configure a Postgres database for you. If not, it will use SQLite.

```
┌  Let's create a Vendure App ✨│◆  How should we proceed?│  ● Quick Start (Get up and running in a single step)│  ○ Manual Configuration└
```

Next you'll be prompted to include our official Next.js storefront starter in your project. This is optional, but recommended if you want to
quickly see a working storefront connected to your Vendure server.

```
┌  Let's create a Vendure App ✨│◇  How should we proceed?│  Quick Start│◇  Using port 3000│◇  Docker is running│◆  Would you like to include the Next.js storefront?│  ○ No│  ● Yes└
```

And that's it! After a minute or two, you'll have a fully-functional Vendure server installed locally.

Once the installation is done, your terminal will output a message indicating a successful installation with:

- The URL to access the Dashboard
- Your admin log-in credentials
- The project file path

Proceed to the Start the server section below to run your Vendure server.

[Start the server](#start-the-server)
### Manual Configuration​


[​](#manual-configuration)If you'd rather have more control over the configuration, you can choose the "Manual Configuration" option. This will prompt you to select a database and whether to populate the database with sample data.

#### 1. Select a database​


[​](#1-select-a-database)Vendure supports a number of different databases. The @vendure/create tool will prompt you to select one.

To quickly test out Vendure, we recommend using SQLite, which requires no external dependencies. You can always switch to a different database later by changing your configuration file.

[by changing your configuration file](/guides/developer-guide/configuration/#connecting-to-the-database)
```
┌  Let's create a Vendure App ✨│◇  How should we proceed?│  Manual Configuration│◇  Using port 3000│◆  Which database are you using?│  ○ MySQL│  ○ MariaDB│  ○ Postgres│  ● SQLite└
```

If you select MySQL, MariaDB, or Postgres, you need to make sure you:

- Have the database server running: You can either install the database locally on your machine, use a cloud provider, or run it via Docker. For local development with Docker, you can use the provided docker-compose.yml file in your project.
- Have created a database: Use your database client to create an empty database (e.g., CREATE DATABASE vendure; in most SQL databases).
- Have database credentials: You need the username and password for a database user that has full permissions (CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT) on the database you created.

Have the database server running: You can either install the database locally on your machine, use a cloud provider, or run it via Docker. For local development with Docker, you can use the provided docker-compose.yml file in your project.

Have created a database: Use your database client to create an empty database (e.g., CREATE DATABASE vendure; in most SQL databases).

Have database credentials: You need the username and password for a database user that has full permissions (CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT) on the database you created.

For detailed database configuration examples, see the Configuration guide.

[Configuration guide](/guides/developer-guide/configuration/#connecting-to-the-database)
#### 2. Populate with data​


[​](#2-populate-with-data)The final prompt will ask whether to populate your new Vendure server with some sample product data.

We recommend you do so, as it will give you a good starting point for exploring the APIs, which we will cover in the Try the API section, as well as providing some data to use when building your own storefront.

[Try the API section](/guides/getting-started/try-the-api/)
```
┌  Let's create a Vendure App ✨│◇  How should we proceed?│  Manual Configuration│// ...│◆  Populate with some sample product data?│  ● yes│  ○ no└
```

#### 3. Optional storefront setup​


[​](#3-optional-storefront-setup)From v3.5.2 onwards, you can choose to include an official Next.js Storefront Starter as part of your new Vendure project.

#### 4. Complete setup​


[​](#4-complete-setup)Next, a project scaffold will be created and dependencies installed. This may take a few minutes.

Once complete, you'll see a message like this:

```
◇  Setup complete! ─────────────────────────────────────╮│                                                       ││  Your new Vendure project was created!                ││  /Users/username/path/my-shop                         ││                                                       ││                                                       ││  This is a monorepo with the following apps:          ││    apps/server     - Vendure backend                  ││    apps/storefront - Next.js frontend                 ││                                                       ││                                                       ││  Next, run:                                           ││  $ cd my-shop                                         ││  $ npm run dev                                        ││                                                       ││                                                       ││  This will start both the server and storefront.      ││                                                       ││                                                       ││  Access points:                                       ││    Dashboard:  http://localhost:3000/dashboard        ││    Storefront: http://localhost:3001                  ││                                                       ││                                                       ││  Use the following credentials to log in:             ││  Username: superadmin                                 ││  Password: superadmin                                 ││                                                       ││                                                       ││  ➡️ Docs: https://docs.vendure.io                     ││  ➡️ Discord community: https://vendure.io/community   ││  ➡️ Star us on GitHub:                                ││     https://github.com/vendure-ecommerce/vendure      ││                                                       │├───────────────────────────────────────────────────────╯│└  Happy hacking!
```

### Start the server​


[​](#start-the-server)Follow the instructions to move into the new directory created for your project, and start the server:

```
cd my-shopnpm run dev
```

You should now be able to access:

- The Vendure Admin GraphQL API: http://localhost:3000/admin-api
- The Vendure Shop GraphQL API: http://localhost:3000/shop-api
- The Vendure Dashboard: http://localhost:3000/dashboard

[http://localhost:3000/admin-api](http://localhost:3000/admin-api)[http://localhost:3000/shop-api](http://localhost:3000/shop-api)[http://localhost:3000/dashboard](http://localhost:3000/dashboard/)If you included the Next.js Storefront Starter, you can also access:

- The Next.js Storefront: http://localhost:3001

[http://localhost:3001](http://localhost:3001/)Congratulations! 🥳 You now have a fully functional Vendure server running locally.

Now you can explore Vendure by following our Try the API guide to learn how to interact with the server.

[Try the API guide](/guides/getting-started/try-the-api/)If you are new to GraphQL, you should also check out our Introducing GraphQL guide.

[Introducing GraphQL guide](/guides/getting-started/graphql-intro/)Open the Dashboard at http://localhost:3000/dashboard in your browser and log in with the superadmin credentials you specified, which default to:

[http://localhost:3000/dashboard](http://localhost:3000/dashboard)- username: superadmin
- password: superadmin

Use npx vendure add to start adding plugins & custom functionality to your Vendure server.

[Vendure CLI](/guides/developer-guide/cli/)
### Troubleshooting​


[​](#troubleshooting)- If you encounter any issues during installation, you can get a more detailed output by setting the log level to verbose:
npx @vendure/create my-shop --log-level verbose
- The supported TypeScript version is set upon installation. Upgrading to a newer version of TypeScript might result in compilation errors because TypeScript sometimes introduces stricter checks in newer versions.
- If you want to use Yarn, from Vendure v2.2.0+, you'll need to use Yarn 2 (Berry) or above.

If you encounter any issues during installation, you can get a more detailed output by setting the log level to verbose:

```
npx @vendure/create my-shop --log-level verbose
```

The supported TypeScript version is set upon installation. Upgrading to a newer version of TypeScript might result in compilation errors because TypeScript sometimes introduces stricter checks in newer versions.

[supported TypeScript version](https://github.com/vendure-ecommerce/vendure/blob/master/packages/create/src/constants.ts#L7)If you want to use Yarn, from Vendure v2.2.0+, you'll need to use Yarn 2 (Berry) or above.


---

# Introducing GraphQL


Vendure uses GraphQL as its API layer.

[GraphQL](https://graphql.org/)This is an introduction to GraphQL for those who are new to it. If you are already familiar with GraphQL, you may choose
to skip this section.

## What is GraphQL?​


[​](#what-is-graphql)From graphql.org:

[graphql.org](https://graphql.org/)> GraphQL is a query language for APIs and a runtime for fulfilling those queries with your existing data. GraphQL provides a complete and understandable description of the data in your API, gives clients the power to ask for exactly what they need and nothing more, makes it easier to evolve APIs over time, and enables powerful developer tools.

GraphQL is a query language for APIs and a runtime for fulfilling those queries with your existing data. GraphQL provides a complete and understandable description of the data in your API, gives clients the power to ask for exactly what they need and nothing more, makes it easier to evolve APIs over time, and enables powerful developer tools.

To put it simply: GraphQL allows you to fetch data from an API via queries, and to update data via mutations.

Here's a GraphQL query which fetches the product with the slug "football":

## GraphQL vs REST​


[​](#graphql-vs-rest)If you are familiar with REST-style APIs, you may be wondering how GraphQL differs. Here are the key ways in which GraphQL differs from REST:

- GraphQL uses a single endpoint, whereas REST uses a different endpoint for each resource.
- GraphQL allows you to specify exactly which fields you want to fetch, whereas REST APIs usually return all fields by default.
- GraphQL allows you to fetch data from multiple resources in a single request (e.g. "fetch a customer including their last 5 orders"), whereas REST APIs usually require you to make multiple requests.
- GraphQL APIs are always defined by a statically typed schema, whereas REST APIs do not have this guarantee.

## Why GraphQL?​


[​](#why-graphql)Both GraphQL and REST are valid approaches to building an API. These are some of the reasons we chose GraphQL when building Vendure:

- No over-fetching: With REST, you often end up fetching more data than you need. For example, if you want to fetch a list of products, you might end up fetching the product name, description, price, and other fields. With GraphQL, you can specify exactly which fields you want to fetch, so you only fetch the data you need. This
can result in a significant reduction in the amount of data transferred over the network.
- Many resources in a single request: Very often, a single page in a web app will need to fetch data from multiple resources. For example, a product detail page might need to fetch the product, the product's variants, the product's collections, the product's reviews, and the product's images. With REST, this would require multiple requests. With GraphQL, you can fetch all of this data in a single request.
- Static typing: GraphQL APIs are always defined by a statically typed schema. This means that you can be sure that the data you receive from the API will always be in the format you expect.
- Developer tooling: The schema definition allows for powerful developer tooling. For example, the GraphQL Playground above with auto-complete and full documentation is generated automatically from the schema definition. You can also get auto-complete and type-checking directly in your IDE.
- Code generation: TypeScript types can be generated automatically from the schema definition. This means that you can be sure that your frontend code is always in sync with the API. This end-to-end type safety is extremely valuable, especially when working on large projects or with teams. See the GraphQL Code Generation guide
- Extensible: Vendure is designed with extensibility in mind, and GraphQL is a perfect fit. You can extend the GraphQL API with your own custom queries, mutations, and types. You can also extend the built-in types with your own custom fields, or supply you own custom logic to resolve existing fields. See the Extend the GraphQL API guide

[GraphQL Code Generation guide](/guides/storefront/codegen/)[Extend the GraphQL API guide](/guides/developer-guide/extend-graphql-api/)
## GraphQL Terminology​


[​](#graphql-terminology)Let's clear up some of the terminology used in GraphQL.

### Types & Fields​


[​](#types--fields)GraphQL has a type system which works in a similar way to other statically typed languages like TypeScript.

Here is an example of a GraphQL type:

```
type Customer {  id: ID!  name: String!  email: String!}
```

The Customer is an object type, and it has three fields: id, name, and email. Each field has a type (e.g. ID! or String!), which
can refer to either a scalar type (a "primitive" type which does not have any fields, but represents a single value) or another object type.

GraphQL has a number of built-in scalar types, including ID, String, Int, Float, Boolean. Vendure further defines a few custom scalar types: DateTime, JSON, Upload & Money.
It is also possible to define your own custom scalar types if required.

The ! symbol after the type name indicates that the field is required (it cannot be null). If a field does not have the ! symbol, it is optional (it can be null).

Here's another example of a couple of types:

```
type Order {  id: ID!  orderPlacedAt: DateTime  isActive: Boolean!  customer: Customer!  lines: [OrderLine!]!}type OrderLine {  id: ID!  productId: ID!  quantity: Int!}
```

Here the Order type has a field called customer which is of type Customer. The Order type also has a field called lines which is a list (an array) of OrderLine objects.

In GraphQL, lists are denoted by square brackets ([]). The ! symbol inside the square brackets indicates that the list cannot contain null values.

The types given here are not the actual types used in the Vendure GraphQL schema, but are used here for illustrative purposes.

### Query & Mutation types​


[​](#query--mutation-types)There are two special types in GraphQL: Query and Mutation. These are the entry points into the API.

The Query type is used for fetching data, and the Mutation type is used for updating data.

Here is an example of a query type:

```
type Query {  customers: [Customer!]!}
```

This defines a customers field on the Query type. This field returns a list of Customer objects.

Here's a mutation type:

```
type Mutation {  updateCustomerEmail(customerId: ID!, email: String!): Customer!}
```

This defines a updateCustomerEmail field on the Mutation type. This field takes two arguments, customerId and email, and returns a Customer object.
It would be used to update the name of the specified customer.

### Input types​


[​](#input-types)Input types are used to pass complex (non-scalar) data to queries or mutations. For example, the updateCustomerEmail mutation above could be re-written
to use an input type:

```
type Mutation {  updateCustomerEmail(input: UpdateCustomerEmailInput!): Customer!}input UpdateCustomerEmailInput {  customerId: ID!  email: String!}
```

Input types look just like object types, but with the input keyword rather than type.

### Schema​


[​](#schema)The schema is the complete definition of the GraphQL API. It defines the types, fields, queries and mutations which are available.

In a GraphQL API like Vendure, you can only query data according to the fields which are defined in the schema.

Here is a complete, minimal schema:

```
schema {  query: Query  mutation: Mutation}type Query {  customers: [Customer!]!}type Mutation {  updateCustomerEmail(input: UpdateCustomerEmailInput!): Customer!}input UpdateCustomerEmailInput {  customerId: ID!  email: String!}type Customer {  id: ID!  name: String!  email: String!}
```

The schema above tells you everything that you can do with the API. You can fetch a list of customers, and you can update a customer's name.

The schema is one of the key benefits of GraphQL. It allows advanced tooling to be built around the API, such as autocomplete in IDEs, and
automatic code generation.

It also ensures that only valid queries can be made against the API.

### Operations​


[​](#operations)An operation is the general name for a GraphQL query or mutation. When you are building your client application, you will
be defining operations which you can then send to the server.

Here's an example of a query operation based on the schema above:

- Query
- Response

```
query {  customers {    id    name    email  }}
```

```
{  "data": {    "customers": [        {            "id": "1",            "name": "John Smith",            "email": "j.smith@email.com"        },        {            "id": "2",            "name": "Jane Doe",            "email": "j.doe@email.com"        }    ]  }}
```

Here's an example mutation operation to update the first customer's email:

- Query
- Response

```
mutation {  updateCustomerEmail(input: {    customerId: "1",    email: "john.smith@email.com"  }) {    id    name    email  }}
```

```
{  "data": {    "updateCustomerEmail": {      "id": "1",      "name": "John Smith",      "email": "john.smith@email.com"    }  }}
```

Operations can also have a name, which, while not required, is recommended for real applications as it makes debugging easier
(similar to having named vs anonymous functions in JavaScript), and also allows you to take advantage of code generation tools.

Here's the above query with a name:

```
query GetCustomers {  customers {    id    name    email  }}
```

### Variables​


[​](#variables)Operations can also have variables. Variables are used to pass input values into the operation. In the example updateCustomerEmail mutation
operation above, we are passing an input object specifying the customerId and email. However, in that example they are hard-coded into the
operation. In a real application, you would want to pass those values in dynamically.

Here's how we can re-write the above mutation operation to use variables:

- Mutation
- Variables
- Response

```
mutation UpdateCustomerEmail($input: UpdateCustomerEmailInput!) {  updateCustomerEmail(input: $input) {    id    name    email  }}
```

```
{  "input": {    "customerId": "1",    "email": "john.smith@email.com"  }}
```

```
{  "data": {    "updateCustomerEmail": {      "id": "1",      "name": "John Smith",      "email": "john.smith@email.com"    }  }}
```

### Fragments​


[​](#fragments)A fragment is a reusable set of fields on an object type. Let's define a fragment for the Customer type that
we can re-use in both the query and the mutation:

```
fragment CustomerFields on Customer {  id  name  email}
```

Now we can re-write the query and mutation operations to use the fragment:

```
query GetCustomers{  customers {    ...CustomerFields  }}
```

```
mutation UpdateCustomerEmail($input: UpdateCustomerEmailInput!) {  updateCustomerEmail(input: $input) {    ...CustomerFields  }}
```

You can think of the syntax as similar to the JavaScript object spread operator (...).

### Union types​


[​](#union-types)A union type is a special type which can be one of a number of other types. Let's say for example that when attempting to update a customer's
email address, we want to return an error type if the email address is already in use. We can update our schema to model this as a union type:

```
type Mutation {  updateCustomerEmail(input: UpdateCustomerEmailInput!): UpdateCustomerEmailResult!}union UpdateCustomerEmailResult = Customer | EmailAddressInUseErrortype EmailAddressInUseError {  errorCode: String!  message: String!}
```

In Vendure, we use this pattern for almost all mutations. You can read more about it in the Error Handling guide.

[Error Handling guide](/guides/developer-guide/error-handling/)Now, when we perform this mutation, we need alter the way we select the fields in the response, since the response could be one of two types:

- Mutation
- Success case
- Error case

```
mutation UpdateCustomerEmail($input: UpdateCustomerEmailInput!) {  updateCustomerEmail(input: $input) {    __typename    ... on Customer {      id      name      email    }    ... on EmailAddressInUseError {      errorCode      message    }  }}
```

```
{  "data": {    "updateCustomerEmail": {      "__typename": "Customer",      "id": "1",      "name": "John Smith",      "email": "john.smith@email.com"    }  }}
```

```
{  "data": {    "updateCustomerEmail": {      "__typename": "EmailAddressInUseError",      "errorCode": "EMAIL_ADDRESS_IN_USE",      "message": "The email address is already in use"    }  }}
```

The __typename field is a special field available on all types which returns the name of the type. This is useful for
determining which type was returned in the response in your client application.

The above operation could also be written to use the CustomerFields fragment we defined earlier:

```
mutation UpdateCustomerEmail($input: UpdateCustomerEmailInput!) {  updateCustomerEmail(input: $input) {    ...CustomerFields    ... on EmailAddressInUseError {      errorCode      message    }  }}
```

### Resolvers​


[​](#resolvers)The schema defines the shape of the data, but it does not define how the data is fetched. This is the job of the resolvers.

A resolver is a function which is responsible for fetching the data for a particular field. For example, the customers field on the Query type
would be resolved by a function which fetches the list of customers from the database.

To get started with Vendure's APIs, you don't need to know much about resolvers beyond this basic understanding. However,
later on you may want to write your own custom resolvers to extend the API. This is covered in the Extending the GraphQL API guide.

[Extending the GraphQL API guide](/guides/developer-guide/extend-graphql-api/)
## Querying data​


[​](#querying-data)Now that we have a basic understanding of the GraphQL type system, let's look at how we can use it to query data from the Vendure API.

In REST terms, a GraphQL query is equivalent to a GET request. It is used to fetch data from the API. Queries should not change any
data on the server.

This is a GraphQL Playground running on a real Vendure server. You can run the query by clicking the "play" button in the
middle of the two panes.

Let's get familiar with the schema:

- Hover your mouse over any field to see its type, and in the case of the product field itself, you'll see documentation about what it does.
- Add a new line after slug and press Ctrl / ⌘ + space to see the available fields. At the bottom of the field list, you'll see the type of that field.
- Try adding the description field and press play. You should see the product's description in the response.
- Try adding variants to the field list. You'll see a red warning in the left edge, and hovering over variants will inform
you that it must have a selection of subfields. This is because the variants field refers to an object type, so we must select
which fields of that object type we want to fetch. For example:

```
query {  product(slug: "football") {    id    name    slug    variants {      # Sub-fields are required for object types      sku      priceWithTax    }  }}

```

## IDE plugins​


[​](#ide-plugins)Plugins are available for most popular IDEs & editors which provide auto-complete and type-checking for GraphQL operations
as you write them. This is a huge productivity boost, and is highly recommended.

- GraphQL extension for VS Code
- GraphQL plugin for IntelliJ (including WebStorm)

[GraphQL extension for VS Code](https://marketplace.visualstudio.com/items?itemName=GraphQL.vscode-graphql)[GraphQL plugin for IntelliJ](https://plugins.jetbrains.com/plugin/8097-graphql)Run the npx vendure schema to generate a GraphQL schema file that your IDE plugin
can use to provide autocomplete.

[Vendure CLI](/guides/developer-guide/cli/)- Install the GraphQL plugin for your IDE
- Run npx vendure schema --api admin to generate a schema.graphql file in your root directory
- Create a graphql.config.yml file in your root directory with the following content:
graphql.config.ymlschema: 'schema.graphql'

```
schema: 'schema.graphql'
```

## Code generation​


[​](#code-generation)Code generation means the automatic generation of TypeScript types based on your GraphQL schema and your GraphQL operations. This is a very powerful feature that allows you to write your code in a type-safe manner, without you needing to manually write any types for your API calls.

For more information see the GraphQL Code Generation guide.

[GraphQL Code Generation guide](/guides/storefront/codegen)
## Further reading​


[​](#further-reading)This is just a very brief overview, intended to introduce you to the main concepts you'll need to build with Vendure.
There are many more language features and best practices to learn about which we did not cover here.

Here are some resources you can use to gain a deeper understanding of GraphQL:

- The official Introduction to GraphQL on graphql.org is comprehensive and easy to follow.
- For a really fundamental understanding, see the GraphQL language spec.
- If you like to learn from videos, the graphql.wtf series is a great resource.

[Introduction to GraphQL on graphql.org](https://graphql.org/learn/)[GraphQL language spec](https://spec.graphql.org/)[graphql.wtf](https://graphql.wtf/)


---

# Try the API


Once you have successfully installed Vendure locally following the installation guide,
it's time to try out the API!

[installation guide](/guides/getting-started/installation)This guide assumes you chose to populate sample data when installing Vendure.

You can also follow along with these example using the public demo playground at demo.vendure.io/graphiql/shop

[demo.vendure.io/graphiql/shop](https://demo.vendure.io/graphiql/shop)
## GraphiQL Interface​


[​](#graphiql-interface)Vendure comes with GraphiQL - a powerful UI for exploring and testing GraphQL APIs. It allows you to run queries and mutations
against both the Shop and Admin APIs, making it easy to explore the API and understand how it works.

In this guide, we'll be using GraphiQL to run queries and mutations. At each step, you paste the query or mutation into the
editor pane, and then click the "Play" button to run it. You'll then see the response in the right-hand pane.

## Shop API​


[​](#shop-api)The Shop API is the public-facing API which is used by the storefront application.

Open the GraphiQL Shop API interface at http://localhost:3000/graphiql/shop.

[http://localhost:3000/graphiql/shop](http://localhost:3000/graphiql/shop)
### Fetch a list of products​


[​](#fetch-a-list-of-products)Let's start with a query. Queries are used to fetch data. We will make a query to get a list of products.

Note that the response only includes the properties we asked for in our query (id and name). This is one of the key benefits
of GraphQL - the client can specify exactly which data it needs, and the server will only return that data!

Let's add a few more properties to the query:

You should see that the response now includes the slug, description and featuredAsset properties. Note that the
featuredAsset property is itself an object, and we can specify which properties of that object we want to include in the
response. This is another benefit of GraphQL - you can "drill down" into the data and specify exactly which properties you
want to include.

Now let's add some arguments to the query. Some queries (and most mutations) can accept argument, which you put in parentheses
after the query name. For example, let's fetch the first 5 products:

On running this query, you should see just the first 5 results being returned.

Let's add a more complex argument: this time we'll filter for only those products which contain the string "shoe" in the
name:

### Add a product to an order​


[​](#add-a-product-to-an-order)Next, let's look at a mutation. Mutations are used to modify data on the server.

Here's a mutation which adds a product to an order:

This mutation adds a product variant with ID 42 to the order. The response will either be an Order object, or an ErrorResult.
We use a special syntax called a fragment to specify which properties we want to include in the response. In this case,
we are saying that if the response is an Order, we want to include the id, code, totalQuantity, totalWithTax etc., and
if the response is an ErrorResult, we want to include the errorCode and message.

Running this mutation a second time should show that the quantity of the product in the order has increased by 1.

For more information about ErrorResult and the handling of errors in Vendure, see the Error Handling guide.

[Error Handling guide](/guides/developer-guide/error-handling)
## Admin API​


[​](#admin-api)The Admin API exposes all the functionality required to manage the store. It is used by the Dashboard, but can also be used
by integrations and custom scripts.

The examples in this section are not interactive, due to security settings on our demo server,
but you can paste them into your local GraphiQL interface.

Open the GraphiQL Admin API interface at http://localhost:3000/graphiql/admin.

[http://localhost:3000/graphiql/admin](http://localhost:3000/graphiql/admin)
### Logging in​


[​](#logging-in)Most Admin API operations are restricted to authenticated users. So first of all we'll need to log in.

```
mutation Login {    login(username: "superadmin", password: "superadmin") {        ... on CurrentUser {            id            identifier        }        ... on ErrorResult {            errorCode            message        }    }}
```

### Fetch a product​


[​](#fetch-a-product)The Admin API exposes a lot more information about products than you can get from the Shop API:

```
query GetProduct {  product(id: 42) {    enabled    name    variants {      id      name      enabled      prices {        currencyCode        price      }      stockLevels {        stockLocationId        stockOnHand        stockAllocated      }    }  }}
```

GraphQL is statically typed and uses a schema containing information about all the available queries, mutations and types. In GraphiQL,
you can explore the schema by clicking the Docs icon (first icon from the top) on the left side of the interface.


