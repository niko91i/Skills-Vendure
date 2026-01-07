# Getting Started


From Vendure v3.5.0, the @vendure/dashboard package and configuration comes as standard with new projects that are started with
the npx @vendure/create command.

This guide serves mainly for those adding the Dashboard to existing project set up prior to v3.5.0.

## Installation & Setup​


[​](#installation--setup)This guide assumes an existing project based on the @vendure/create folder structure.
If you have a different setup (e.g. an Nx monorepo), you may need to adapt the instructions accordingly.

First install the @vendure/dashboard package:

```
npm install @vendure/dashboard
```

Then create a vite.config.mts file in the root of your project (on the same level as your package.json) with the following content:

```
import { vendureDashboardPlugin } from '@vendure/dashboard/vite';import { join, resolve } from 'path';import { pathToFileURL } from 'url';import { defineConfig } from 'vite';export default defineConfig({    base: '/dashboard',    build: {        outDir: join(__dirname, 'dist/dashboard'),    },    plugins: [        vendureDashboardPlugin({            // The vendureDashboardPlugin will scan your configuration in order            // to find any plugins which have dashboard extensions, as well as            // to introspect the GraphQL schema based on any API extensions            // and custom fields that are configured.            vendureConfigPath: pathToFileURL('./src/vendure-config.ts'),            // Points to the location of your Vendure server.            api: { host: 'http://localhost', port: 3000 },            // When you start the Vite server, your Admin API schema will            // be introspected and the types will be generated in this location.            // These types can be used in your dashboard extensions to provide            // type safety when writing queries and mutations.            gqlOutputPath: './src/gql',        }),    ],    resolve: {        alias: {            // This allows all plugins to reference a shared set of            // GraphQL types.            '@/gql': resolve(__dirname, './src/gql/graphql.ts'),        },    },});
```

You should also add the following to your existing tsconfig.json file to exclude the dashboard extensions and Vite config
from your build, and reference a new tsconfig.dashboard.json that will have compiler settings for the Dashboard code.

```
{    // ... existing options    "exclude": [        "node_modules",        "migration.ts",        "src/plugins/**/ui/*",        "admin-ui",        "src/plugins/**/dashboard/*",        "src/gql/*",        "vite.*.*ts"    ],    "references": [        {            "path": "./tsconfig.dashboard.json"        }    ]}
```

Now create a new tsconfig.dashboard.json to allow your IDE
to correctly resolve imports of GraphQL types & interpret JSX in your dashboard extensions:

```
{    "compilerOptions": {        "composite": true,        "module": "ESNext",        "moduleResolution": "bundler",        "jsx": "react-jsx",        "paths": {            // Import alias for the GraphQL types            // Please adjust to the location that you have set in your `vite.config.mts`            "@/gql": [                "./src/gql/graphql.ts"            ],            // This line allows TypeScript to properly resolve internal            // Vendure Dashboard imports, which is necessary for            // type safety in your dashboard extensions.            // This path assumes a root-level tsconfig.json file.            // You may need to adjust it if your project structure is different.            "@/vdb/*": [                "./node_modules/@vendure/dashboard/src/lib/*"            ]        }    },    "include": [        "src/plugins/**/dashboard/*",        "src/gql/**/*.ts"    ]}
```

### Monorepo Setup​


[​](#monorepo-setup)If your project uses a monorepo structure, such as with Nx or Turborepo, then you'll need to make some adjustments
to the paths given above:

If each Vendure plugin is its own "package", outside the main Vendure server app, then it would need its own
tsconfig for each plugin package. You might run into errors like:

```
Error loading Vendure config: Cannot find module
```

In this case, you'll need to configure a PathAdapter.

[PathAdapter](/reference/dashboard/vite-plugin/vendure-dashboard-plugin#pathadapter)You should also put your vite.config.mts file into the Vendure app directory rather than the root.

## The DashboardPlugin​


[​](#the-dashboardplugin)In your vendure-config.ts file, you should also import and configure the DashboardPlugin.

[DashboardPlugin](/reference/core-plugins/dashboard-plugin/)
```
import { DashboardPlugin } from '@vendure/dashboard/plugin';const config: VendureConfig = {    plugins: [        // ... existing plugins        DashboardPlugin.init({            // The route should correspond to the `base` setting            // in the vite.config.mts file            route: 'dashboard',            // This appDir should correspond to the `build.outDir`            // setting in the vite.config.mts file            appDir: './dist/dashboard',        }),    ],};
```

The DashboardPlugin adds the following features that enhance the use of the Dashboard:

- It exposes a set of queries which power the Insights page metrics.
- It registers SettingsStore entries that are used to store your personal display settings on the server side, which
allow administrators to enjoy a consistent experience across browsers and devices.
- It serves the dashboard with a static server at the /dashboard route (by default), meaning you do not
need to set up a separate web server.

## Running the Dashboard​


[​](#running-the-dashboard)Once the above is set up, you can run npm run dev to start your Vendure server, and then visit

```
http://localhost:3000/dashboard
```

which will display a developer placeholder until you start the Vite dev server using

```
npx vite
```

To stop the running dashboard, type q and hit enter.

If you still need to run the legacy Angular-based Admin UI in parallel with the Dashboard,
this is totally possible. Both plugins can now be used simultaneously without any special configuration.


---

# Extending the Dashboard


The custom functionality you create in your Vendure plugins often needs to be exposed via the Dashboard so that
administrators can interact with it.

This guide covers how you can set up your plugins with extensions to the Dashboard.

## Plugin Setup​


[​](#plugin-setup)For the purposes of the guides in this section of the docs, we will work with a simple Content Management System (CMS)
plugin that allows us to create and manage content articles.

Let's create the plugin:

```
npx vendure add --plugin cms
```

Now let's add an entity to the plugin:

```
npx vendure add --entity Article --selected-plugin CmsPlugin --custom-fields
```

You now have your CmsPlugin created with a new Article entity. You can find the plugin in the ./src/plugins/cms directory.

Let's edit the entity to add the appropriate fields:

```
import { DeepPartial, HasCustomFields, VendureEntity } from '@vendure/core';import { Column, Entity } from 'typeorm';export class ArticleCustomFields {}@Entity()export class Article extends VendureEntity implements HasCustomFields {    constructor(input?: DeepPartial<Article>) {        super(input);    }    @Column()    slug: string;    @Column()    title: string;    @Column('text')    body: string;    @Column()    isPublished: boolean;    @Column(type => ArticleCustomFields)    customFields: ArticleCustomFields;}
```

Now let's create a new ArticleService to handle the business logic of our new entity:

```
npx vendure add --service ArticleService --selected-plugin CmsPlugin --selected-entity Article
```

The service will be created in the ./src/plugins/cms/services directory.

Finally, we'll extend the GraphQL API to expose those CRUD operations:

```
npx vendure add --api-extension CmsPlugin --selected-service ArticleService --query-name ArticleQuery
```

Now the api extensions and resolver has been created in the ./src/plugins/cms/api-extensions directory.

The last step is to create a migration for our newly-created entity:

```
npx vendure migrate --generate article
```

Your project should now have the following structure:

```
src└── plugins/    └── cms/        ├── api/        │   ├── api-extensions.ts        │   └── article-admin.resolver.ts        ├── entities/        │   └── article.entity.ts        ├── services/        │   └── article.service.ts        ├── cms.plugin.ts        ├── constants.ts        └── types.ts
```

## Add Dashboard to Plugin​


[​](#add-dashboard-to-plugin)Dashboard extensions are declared directly on the plugin metadata. Unlike the old AdminUiPlugin, you do not need to separately
declare ui extensions anywhere except on the plugin itself.

```
@VendurePlugin({    // ...    entities: [Article],    adminApiExtensions: {        schema: adminApiExtensions,        resolvers: [ArticleAdminResolver],    },    dashboard: './dashboard/index.tsx',})export class CmsPlugin {    // ...}
```

You can do this automatically with the CLI command:

```
npx vendure add --dashboard CmsPlugin
```

This will add the dashboard property to your plugin as above, and will also create the /dashboard/index.tsx file
which looks like this:

```
import { Button, defineDashboardExtension, Page, PageBlock, PageLayout, PageTitle } from '@vendure/dashboard';import { useState } from 'react';defineDashboardExtension({    routes: [        // Here's a custom page so you can test that your Dashboard extensions are working.        // You should be able to access this page via the "Catalog > Test Page" nav menu item.        {            path: '/test',            loader: () => ({ breadcrumb: 'Test Page' }),            navMenuItem: {                id: 'test',                title: 'Test Page',                sectionId: 'catalog',            },            component: () => {                const [count, setCount] = useState(0);                return (                    <Page pageId="test-page">                        <PageTitle>Test Page</PageTitle>                        <PageLayout>                            <PageBlock column="main" blockId="counter">                                <p>Congratulations, your Dashboard extension is working!</p>                                <p className="text-muted-foreground mb-4">                                    As is traditional, let's include a counter:                                </p>                                <Button variant="secondary" onClick={() => setCount(c => c + 1)}>                                    Clicked {count} times                                </Button>                            </PageBlock>                        </PageLayout>                    </Page>                );            },        },    ],    // The following extension points are only listed here    // to give you an idea of all the ways that the Dashboard    // can be extended. Feel free to delete any that you don't need.    pageBlocks: [],    navSections: [],    actionBarItems: [],    alerts: [],    widgets: [],    customFormComponents: {},    dataTables: [],    detailForms: [],    login: {},    historyEntries: [],});
```

## IDE GraphQL Integration​


[​](#ide-graphql-integration)When extending the dashboard, you'll very often need to work with GraphQL documents for fetching data and executing mutations.

Plugins are available for most popular IDEs & editors which provide auto-complete and type-checking for GraphQL operations
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

## Dev Mode​


[​](#dev-mode)Once you have logged in to the dashboard, you can toggle on "Dev Mode" using the user menu in the bottom left:

In Dev Mode, hovering any block in the dashboard will allow you to find the corresponding pageId and blockId values, which you can later use when customizing the dashboard. This is essential for:

- Identifying where to place custom page blocks
- Finding action bar locations
- Understanding the page structure

## What's Next?​


[​](#whats-next)Now that you understand the fundamentals of extending the dashboard, explore these specific guides:

- Creating Pages
- Customizing Pages
- Navigation

[Creating Pages](/guides/extending-the-dashboard/creating-pages/)[Customizing Pages](/guides/extending-the-dashboard/customizing-pages/)[Navigation](/guides/extending-the-dashboard/navigation/)


---

# Creating Pages


## Page Structure​


[​](#page-structure)All pages in the Dashboard follow this structure:

```
import { Page, PageBlock, PageLayout, PageTitle } from '@vendure/dashboard';export function TestPage() {    return (        <Page pageId="test-page">            <PageTitle>Test Page</PageTitle>            <PageLayout>                <PageBlock column="main" blockId="main-stuff">                    This will display in the main area                </PageBlock>                <PageBlock column="side" blockId="side-stuff">                    This will display in the side area                </PageBlock>            </PageLayout>        </Page>    )}
```

- Page component

PageTitle component
PageLayout component

PageBlock components
- PageTitle component
- PageLayout component

PageBlock components
- PageBlock components

[Page component](/reference/dashboard/page-layout/page)- PageTitle component
- PageLayout component

PageBlock components
- PageBlock components

[PageTitle component](/reference/dashboard/page-layout/page-title)[PageLayout component](/reference/dashboard/page-layout)- PageBlock components

[PageBlock components](/reference/dashboard/page-layout/page-block)Following this structure ensures that:

- Your pages look consistent with the rest of the Dashboard
- Your page content is responsive
- Your page can be further extended using the pageBlocks API

[pageBlocks API](/guides/extending-the-dashboard/customizing-pages/page-blocks)Note that the ListPage and DetailPage
components internally use this same structure, so when using those top-level components you don't need to wrap them
in Page etc.

[ListPage](/reference/dashboard/list-views/list-page)[DetailPage](/reference/dashboard/detail-views/detail-page)
## Page Routes & Navigation​


[​](#page-routes--navigation)Once you have defined a page component, you'll need to make it accessible to users with:

- A route (url) by which it can be accessed
- Usually a navigation bar entry in the main side navigation of the Dashboard

Both of these are handled using the DashboardRouteDefinition API:

[DashboardRouteDefinition API](/reference/dashboard/extensions-api/routes)
```
import { defineDashboardExtension } from '@vendure/dashboard';import { TestPage } from './test-page';defineDashboardExtension({    routes: [        {            // The TestPage will be available at e.g.             // http://localhost:5173/dashboard/test            path: '/test',            // The loader function is allows us to define breadcrumbs            loader: () => ({ breadcrumb: 'Test Page' }),            // Here we define the nav menu items            navMenuItem: {                // a unique ID                id: 'test',                // the nav menu item label                title: 'Test Page',                // which section it should appear in                sectionId: 'catalog',            },            component: TestPage,        },    ],});
```

For a complete guide to the navigation options available, see the Navigation guide

[Navigation guide](/guides/extending-the-dashboard/navigation/)

---

# Creating List Pages


## Setup​


[​](#setup)This guide assumes you have a CmsPlugin with an Article entity, as covered in the Extending the Dashboard: Plugin Setup guide.

[Extending the Dashboard: Plugin Setup](/guides/extending-the-dashboard/extending-overview/#plugin-setup)List pages can be easily created for any query in the Admin API that follows the PaginatedList pattern.

[PaginatedList pattern](/guides/how-to/paginated-list/)For example, the articles query of our CmsPlugin looks like this:

```
type ArticleList implements PaginatedList {  items: [Article!]!  totalItems: Int!}extend type Query {  articles(options: ArticleListOptions): ArticleList!}
```

## List Page Example​


[​](#list-page-example)First we'll create a new article-list.tsx file in the ./src/plugins/cms/dashboard directory:

```
import {    Button,    DashboardRouteDefinition,    ListPage,    PageActionBarRight,    DetailPageButton,} from '@vendure/dashboard';import { Link } from '@tanstack/react-router';import { PlusIcon } from 'lucide-react';// This function is generated for you by the `vendureDashboardPlugin` in your Vite config.// It uses gql-tada to generate TypeScript types which give you type safety as you write// your queries and mutations.import { graphql } from '@/gql';// The fields you select here will be automatically used to generate the appropriate columns in the// data table below.const getArticleList = graphql(`    query GetArticles($options: ArticleListOptions) {        articles(options: $options) {            items {                id                createdAt                updatedAt                isPublished                title                slug                body                customFields            }            totalItems        }    }`);const deleteArticleDocument = graphql(`    mutation DeleteArticle($id: ID!) {        deleteArticle(id: $id) {            result        }    }`);export const articleList: DashboardRouteDefinition = {    navMenuItem: {        sectionId: 'catalog',        id: 'articles',        url: '/articles',        title: 'CMS Articles',    },    path: '/articles',    loader: () => ({        breadcrumb: 'Articles',    }),    component: route => (        <ListPage            pageId="article-list"            title="Articles"            listQuery={getArticleList}            deleteMutation={deleteArticleDocument}            route={route}            customizeColumns={{                title: {                    cell: ({ row }) => {                        const post = row.original;                        return <DetailPageButton id={post.id} label={post.title} />;                    },                },            }}        >            <PageActionBarRight>                <Button asChild>                    <Link to="./new">                        <PlusIcon className="mr-2 h-4 w-4" />                        New article                    </Link>                </Button>            </PageActionBarRight>        </ListPage>    ),};
```

Let's register this route (and we can also remove the test page) in our index.tsx file:

```
import { defineDashboardExtension } from '@vendure/dashboard';import { articleList } from './article-list';defineDashboardExtension({    routes: [        articleList,    ],});
```

After adding new Dashboard files to your plugin, you'll need to re-start the dev server for those
files to be picked up by Vite:

```
q # to stop the running dev servernpx vite # to restart

```

## The ListPage Component​


[​](#the-listpage-component)The ListPage component can be customized to your exact needs, such as:

- Setting the columns which are visible by default
- Setting the default order of the columns
- Defining bulk actions ("delete all selected" etc.)

See the ListPage component reference for an explanation of the available options.

[ListPage component reference](/reference/dashboard/list-views/list-page)
## Customizing Columns​


[​](#customizing-columns)It is common that you will want to customize the way certain columns are rendered. This is done
using the customizeColumns prop on the ListPage component.

By default, an appropriate component will be chosen to render the column data
based on the data type of the field. However, in many cases you want to have
more control over how the column data is rendered.

```
<ListPage  pageId="collection-list"  listQuery={collectionListDocument}  customizeColumns={{      // The key "name" matches one of the top-level fields of the      // list query type (Collection, in this example)      name: {          meta: {              // The Dashboard optimizes the list query `collectionListDocument` to              // only select field that are actually visible in the ListPage table.              // However, sometimes you want to render data from other fields, i.e.              // this column has a data dependency on the "children" and "breadcrumbs"              // fields in order to correctly render the "name" field.              // In this case, we can declare those data dependencies which means whenever              // the "name" column is visible, it will ensure the "children" and "breadcrumbs"              // fields are also selected in the query.              dependencies: ['children', 'breadcrumbs'],          },          header: 'Collection Name',          cell: ({ row }) => {              const isExpanded = row.getIsExpanded();              const hasChildren = !!row.original.children?.length;              return (                  <div                      style={{ marginLeft: (row.original.breadcrumbs?.length - 2) * 20 + 'px' }}                      className="flex gap-2 items-center"                  >                      <Button                          size="icon"                          variant="secondary"                          onClick={row.getToggleExpandedHandler()}                          disabled={!hasChildren}                          className={!hasChildren ? 'opacity-20' : ''}                      >                          {isExpanded ? <FolderOpen /> : <Folder />}                      </Button>                      <DetailPageButton id={row.original.id} label={row.original.name} />                  </div>              );          },      },  }}/>
```


---

# Creating Detail Pages


## Setup​


[​](#setup)This guide assumes you have a CmsPlugin with an Article entity, as covered in the Extending the Dashboard: Plugin Setup guide.

[Extending the Dashboard: Plugin Setup](/guides/extending-the-dashboard/extending-overview/#plugin-setup)Detail pages can be created for any entity which has been exposed via the Admin API. Following the
above setup of the CmsPlugin will result in the following additions to your API schema:

```
type Article implements Node {    id: ID!    createdAt: DateTime!    updatedAt: DateTime!    slug: String!    title: String!    body: String!    isPublished: Boolean!}type Query {    # ...    article(id: ID!): Article}type Mutation {    # ...    createArticle(input: CreateArticleInput!): Article!    updateArticle(input: UpdateArticleInput!): Article!    deleteArticle(id: ID!): DeletionResponse!}

```

## Simple Detail Pages​


[​](#simple-detail-pages)Now let's create a detail page so we can start adding articles.

We'll begin with the simplest approach, where the form will be auto-generated for us based on the GraphQL schema
using the DetailPage component.
This is useful for quickly getting started, but you can also to customize the form later on.

[DetailPage](/reference/dashboard/detail-views/detail-page)Create a new file called article-detail.tsx in the ./src/plugins/cms/dashboard directory:

```
import { DashboardRouteDefinition, DetailPage, detailPageRouteLoader } from '@vendure/dashboard';import { graphql } from '@/gql';const articleDetailDocument = graphql(`    query GetArticleDetail($id: ID!) {        article(id: $id) {            id            createdAt            updatedAt            isPublished            title            slug            body            customFields        }    }`);const createArticleDocument = graphql(`    mutation CreateArticle($input: CreateArticleInput!) {        createArticle(input: $input) {            id        }    }`);const updateArticleDocument = graphql(`    mutation UpdateArticle($input: UpdateArticleInput!) {        updateArticle(input: $input) {            id        }    }`);export const articleDetail: DashboardRouteDefinition = {    path: '/articles/$id',    loader: detailPageRouteLoader({        queryDocument: articleDetailDocument,        breadcrumb: (isNew, entity) => [            { path: '/articles', label: 'Articles' },            isNew ? 'New article' : entity?.title,        ],    }),    component: route => {        return (            <DetailPage                pageId="article-detail"                queryDocument={articleDetailDocument}                createDocument={createArticleDocument}                updateDocument={updateArticleDocument}                route={route}                title={article => article?.title ?? 'New article'}                setValuesForUpdate={article => {                    return {                        id: article?.id ?? '',                        isPublished: article?.isPublished ?? false,                        title: article?.title ?? '',                        slug: article?.slug ?? '',                        body: article?.body ?? '',                    };                }}            />        );    },};
```

Now we can register this route in our index.tsx file:

```
import { defineDashboardExtension } from '@vendure/dashboard';import { articleList } from './article-list';import { articleDetail } from './article-detail';defineDashboardExtension({    routes: [        articleList,        articleDetail,    ],});
```

You should now be able to click on the "New article" button in the list view, and see the detail page:

Congratulations! You can now add, edit and delete articles in the dashboard.

## Customizing the detail page​


[​](#customizing-the-detail-page)The auto-generated DetailPage is a great way to get started and quickly be able
to interact with your entities. But let's now see how we can fully customize the layout and form fields.

[DetailPage](/reference/dashboard/detail-views/detail-page)
```
import {    DashboardRouteDefinition,    detailPageRouteLoader,    useDetailPage,    Page,    PageTitle,    PageActionBar,    PageActionBarRight,    PermissionGuard,    Button,    PageLayout,    PageBlock,    FormFieldWrapper,    DetailFormGrid,    Switch,    Input,    RichTextInput,    CustomFieldsPageBlock,} from '@vendure/dashboard';import { AnyRoute, useNavigate } from '@tanstack/react-router';import { toast } from 'sonner';import { graphql } from '@/gql';const articleDetailDocument = graphql(`    query GetArticleDetail($id: ID!) {        article(id: $id) {            id            createdAt            updatedAt            isPublished            title            slug            body            customFields        }    }`);const createArticleDocument = graphql(`    mutation CreateArticle($input: CreateArticleInput!) {        createArticle(input: $input) {            id        }    }`);const updateArticleDocument = graphql(`    mutation UpdateArticle($input: UpdateArticleInput!) {        updateArticle(input: $input) {            id        }    }`);export const articleDetail: DashboardRouteDefinition = {    path: '/articles/$id',    loader: detailPageRouteLoader({        queryDocument: articleDetailDocument,        breadcrumb: (isNew, entity) => [            { path: '/articles', label: 'Articles' },            isNew ? 'New article' : entity?.title,        ],    }),    component: route => {        return <ArticleDetailPage route={route} />;    },};function ArticleDetailPage({ route }: { route: AnyRoute }) {    const params = route.useParams();    const navigate = useNavigate();    const creatingNewEntity = params.id === 'new';    const { form, submitHandler, entity, isPending, resetForm } = useDetailPage({        queryDocument: articleDetailDocument,        createDocument: createArticleDocument,        updateDocument: updateArticleDocument,        setValuesForUpdate: article => {            return {                id: article?.id ?? '',                isPublished: article?.isPublished ?? false,                title: article?.title ?? '',                slug: article?.slug ?? '',                body: article?.body ?? '',            };        },        params: { id: params.id },        onSuccess: async data => {            toast('Successfully updated article');            resetForm();            if (creatingNewEntity) {                await navigate({ to: `../$id`, params: { id: data.id } });            }        },        onError: err => {            toast('Failed to update article', {                description: err instanceof Error ? err.message : 'Unknown error',            });        },    });    return (        <Page pageId="article-detail" form={form} submitHandler={submitHandler}>            <PageTitle>{creatingNewEntity ? 'New article' : (entity?.title ?? '')}</PageTitle>            <PageActionBar>                <PageActionBarRight>                    <PermissionGuard requires={['UpdateProduct', 'UpdateCatalog']}>                        <Button                            type="submit"                            disabled={!form.formState.isDirty || !form.formState.isValid || isPending}                        >                            Update                        </Button>                    </PermissionGuard>                </PageActionBarRight>            </PageActionBar>            <PageLayout>                <PageBlock column="side" blockId="publish-status">                    <FormFieldWrapper                        control={form.control}                        name="isPublished"                        label="Is Published"                        render={({ field }) => (                            <Switch checked={field.value} onCheckedChange={field.onChange} />                        )}                    />                </PageBlock>                <PageBlock column="main" blockId="main-form">                    <DetailFormGrid>                        <FormFieldWrapper                            control={form.control}                            name="title"                            label="Title"                            render={({ field }) => <Input {...field} />}                        />                        <FormFieldWrapper                            control={form.control}                            name="slug"                            label="Slug"                            render={({ field }) => <Input {...field} />}                        />                    </DetailFormGrid>                    <FormFieldWrapper                        control={form.control}                        name="body"                        label="Content"                        render={({ field }) => (                            <RichTextInput value={field.value ?? ''} onChange={field.onChange} />                        )}                    />                </PageBlock>                <CustomFieldsPageBlock column="main" entityType="Article" control={form.control} />            </PageLayout>        </Page>    );}
```

In the above example, we have:

- Used the Page, PageTitle,
PageActionBar and PageLayout components to create a layout for our page.
- Used PageBlock components to structure the page into blocks.
- Used FormFieldWrapper around form components for consistent styling and
layout of inputs.
- Used custom form components (such as the RichTextInput) to better represent the data.

[Page](/reference/dashboard/page-layout/page)[PageTitle](/reference/dashboard/page-layout/page-title)[PageActionBar](/reference/dashboard/page-layout/page-action-bar)[PageLayout](/reference/dashboard/page-layout)[PageBlock](/reference/dashboard/page-layout/page-block)[FormFieldWrapper](/reference/dashboard/form-components/form-field-wrapper)[RichTextInput](/reference/dashboard/form-components/rich-text-input)


---

# Creating Tabbed Pages


## Setup​


[​](#setup)This guide assumes you have a basic understanding of creating custom pages in the Vendure Dashboard, as covered in the Creating List Pages and Creating Detail Pages guides.

[Creating List Pages](/guides/extending-the-dashboard/creating-pages/list-pages)[Creating Detail Pages](/guides/extending-the-dashboard/creating-pages/detail-pages)Tabbed pages allow you to organize related content into separate tabs within a single page. This is useful
for grouping configuration settings, related data views, or different aspects of an entity.

While using them within page blocks is supported, by simply using the Tabs component directly, you may want to use Tabs on the top level of your page.
This is where this guide comes in.

## Tabbed Page Example​


[​](#tabbed-page-example)The Dashboard provides tab components that work seamlessly with the Page component to create tabbed interfaces.
Using the correct format is important to avoid style issues and ensure consistent behavior.

When a component grows, you may want to consider using the Tabs component to help you organize your content.

```
import {    Page,    PageTitle,    Tabs,    TabsContent,    TabsList,    TabsTrigger,    DashboardRouteDefinition,} from '@vendure/dashboard';export const settingsPage: DashboardRouteDefinition = {    navMenuItem: { sectionId: 'settings', title: 'My Settings', order: 10 },    path: '/settings/my-settings',    loader: () => ({        breadcrumb: 'My Settings',    }),    component: () => {        return (            <Page pageId="my-settings">                <PageTitle>My Tabbed Page</PageTitle>                <Tabs defaultValue="main-stuff" className="w-full">                    <TabsList>                        <TabsTrigger value="main-stuff">main stuff</TabsTrigger>                        <TabsTrigger value="other-stuff">other stuff</TabsTrigger>                    </TabsList>                    <TabsContent value="main-stuff">                        <PageLayout>                            <PageBlock column="main" blockId="main-stuff">                                This will display in the main area *in a tab*                            </PageBlock>                        </PageLayout>                    </TabsContent>                    <TabsContent value="other-stuff">                        <PageLayout>                            <PageBlock column="main" blockId="other-stuff">                                This will display in the main area *in another tab*                            </PageBlock>                        </PageLayout>                    </TabsContent>                </Tabs>            </Page>        );    },};
```

## Tab Component​


[​](#tab-component)This uses the stock shadcn tab component, docs are avilable here.

[here](https://ui.shadcn.com/docs/components/tabs)Always use the Page component as the root and PageLayout as the only child of the TabContent when creating tabbed pages. This ensures proper styling
and integration with the Dashboard layout system.

## Avoiding Nested Layouts​


[​](#avoiding-nested-layouts)The purpose of this structure is to avoid nested layout components, which can cause style and layout issues.

One might be tempted to wrap tab content in a FullWidthPageBlock or PageLayout and then place other PageBlock components inside it. This will cause layout problems.

Instead, place PageBlock components directly inside each TabsContent, just as you would in a regular detail page.

Incorrect approach:

```
<Tabs value="general">    <PageLayout>        // this will not render correctly        <FullWidthPageBlock blockId="tabbed-page">            <TabsList>                <TabsTrigger value="main-stuff">main stuff</TabsTrigger>                <TabsTrigger value="also-main-stuff">also main stuff</TabsTrigger>            </TabsList>            <TabsContent value="main-stuff">                <PageBlock column="main" blockId="main-stuff">                    This will display in the main area *in a new tab*                </PageBlock>            </TabsContent>        </FullWidthPageBlock>    </PageLayout></Tabs>
```

## Using Tabs with Components​


[​](#using-tabs-with-components)You can use any Dashboard components within tab content, including forms, lists, or custom components:

```
<TabsContent value="general">    <PageBlock column="main" blockId="general-settings">        <DetailFormGrid>            <FormFieldWrapper                control={form.control}                name="siteName"                label="Site Name"                render={({ field }) => <Input {...field} />}            />            <FormFieldWrapper                control={form.control}                name="siteUrl"                label="Site URL"                render={({ field }) => <Input {...field} />}            />        </DetailFormGrid>    </PageBlock></TabsContent>
```


---

# Customizing Pages


Existing pages in the Dashboard can be customized in many ways:

- Action bar buttons can be added to the top of the page
- Page blocks can be added at any position, and existing page blocks can be replaced or removed.
- Extend list pages with custom components, data and bulk actions
- Extend detail pages with custom components and data

[Action bar buttons](/guides/extending-the-dashboard/customizing-pages/action-bar-items)[Page blocks](/guides/extending-the-dashboard/customizing-pages/page-blocks)[Extend list pages](/guides/extending-the-dashboard/customizing-pages/customizing-list-pages)[Extend detail pages](/guides/extending-the-dashboard/customizing-pages/customizing-detail-pages)

---


# Customizing List Pages


Using the DashboardDataTableExtensionDefinition you can
customize any existing data table in the Dashboard.

[DashboardDataTableExtensionDefinition](/reference/dashboard/extensions-api/data-tables#dashboarddatatableextensiondefinition)
## Custom table cell components​


[​](#custom-table-cell-components)You can define your own custom components to render specific table cells:

```
import { defineDashboardExtension } from '@vendure/dashboard';defineDashboardExtension({  dataTables: [{      pageId: 'product-list',      displayComponents: [          {              column: 'slug',              // The component will be passed the cell's `value`,              // as well as all the other objects in the Tanstack Table              // `CellContext` object.              component: ({ value, cell, row, table }) => {                  return (                      <a href={`https://storefront.com/products/${value}`} target="_blank">                          {value}                      </a>                  );              },          },      ],  }]});
```

## Bulk actions​


[​](#bulk-actions)You can define bulk actions on the selected table items. The bulk action component should use
DataTableBulkActionItem.

[DataTableBulkActionItem](/reference/dashboard/list-views/bulk-actions#datatablebulkactionitem)
```
import { defineDashboardExtension, DataTableBulkActionItem } from '@vendure/dashboard';import { InfoIcon } from 'lucide-react';defineDashboardExtension({  dataTables: [{      pageId: 'product-list',      bulkActions: [          {              component: props => (                  <DataTableBulkActionItem                      onClick={() => {                          console.log('Selection:', props.selection);                          toast.message(`There are ${props.selection.length} selected items`);                      }}                      label="My Custom Action"                      icon={InfoIcon}                  />              ),          },      ],  }]});
```

## Extending the list query​


[​](#extending-the-list-query)The GraphQL queries used by list views can be extended using the extendListDocument property, and passing
the additional fields you want to fetch:

```
import { defineDashboardExtension, DataTableBulkActionItem } from '@vendure/dashboard';import { InfoIcon } from 'lucide-react';defineDashboardExtension({  dataTables: [{      pageId: 'product-list',      extendListDocument: `          query {              products {                  items {                      optionGroups {                          id                          name                      }                  }              }          }      `,  }]});
```


---

# Customizing Detail Pages


Using the DashboardDetailFormExtensionDefinition you can
customize any existing detail page in the Dashboard.

[DashboardDetailFormExtensionDefinition](/reference/dashboard/extensions-api/detail-forms#dashboarddetailformextensiondefinition)
## Custom form inputs​


[​](#custom-form-inputs)You can replace any of the default form inputs with your own components using the inputs property.

Let's say you want to replace the default HTML description editor with a markdown editor component:

```
import { defineDashboardExtension } from '@vendure/dashboard';import { MarkdownEditor } from './markdown-editor';defineDashboardExtension({    detailForms: [        {            pageId: 'product-detail',            inputs: [                {                    blockId: 'main-form',                    field: 'description',                    component: MarkdownEditor,                },            ],        },    ],});
```

To learn how to build custom form components, see the Custom Form Elements guide.

[Custom Form Elements guide](/guides/extending-the-dashboard/custom-form-components/)
## Extending the detail query​


[​](#extending-the-detail-query)You might want to extend the GraphQL query used to fetch the data for the detail page. For example, to include new
fields that your plugin has defined so that you can render them in custom page blocks.

[custom page blocks](/guides/extending-the-dashboard/customizing-pages/page-blocks)
```
import { defineDashboardExtension } from '@vendure/dashboard';defineDashboardExtension({    detailForms: [        {            pageId: 'product-detail',            extendDetailDocument: `          query {              product(id: $id) {                  relatedProducts {                      id                      name                      featuredAsset {                        id                        preview                      }                  }              }          }      `,        },    ],});
```

## Interacting with the detail page form​


[​](#interacting-with-the-detail-page-form)Sometimes you want to define a page block that needs to interact with the detail page's form:

[page block](/guides/extending-the-dashboard/customizing-pages/page-blocks)- To take some action when the form is submitted
- To mark the form as dirty from inside your page block

These advanced use-cases can be achieved by using the useFormContext hook from react-hook-form.

### Reacting to form submission​


[​](#reacting-to-form-submission)Here's how you can use the formState to react to a form submission:

```
import { useEffect } from 'react';import { useFormContext } from 'react-hook-form';export function MyPageBlock() {    const { formState: { isSubmitSuccessful } } = useFormContext();    useEffect(() => {        if (isSubmitSuccessful) {            console.log('The detail page form was submitted');        }    }, [isSubmitSuccessful]);}
```

### Setting the form as dirty​


[​](#setting-the-form-as-dirty)Let's say you have a page block that interacts with a custom mutation to set some
data related to a Product. You want to fire your custom mutation when the form is submitted -
this is done using the pattern above.

However, you need to somehow signal to the form that it is now dirty and can be save, even though
no property of the Product itself may have changed.

Here's a work-around to allow this:

```
import { useEffect } from 'react';import { useFormContext } from 'react-hook-form';import { Button } from '@vendure/dashboard';export function MyPageBlock() {    const { register } = useFormContext();    useEffect(() => {        // We register a "fake" field on the form that we only use        // to track the dirty state of this page block component        register('my-page-block-dirty-tracker')    }, [register]);        return (        <Button onClick={() => {            // We set that "fake" field to a random value to mark the whole            // form as dirty, so the "save" button becomes enabled.            setValue('dirty-tracker', Math.random(), { shouldDirty: true });        }}>Set dirty</Button>    );}
```


---

# Customizing the Login Page


The login page can be customized with your own logo and messaging, as well as things like SSO login buttons.

Reference documentation can be found at DashboardLoginExtensions.

[DashboardLoginExtensions](/reference/dashboard/extensions-api/login#dashboardloginextensions)
## Login page extension points​


[​](#login-page-extension-points)
```
import { defineDashboardExtension } from '@vendure/dashboard';import { useSsoLogin } from './use-sso-login';defineDashboardExtension({    login: {        logo: {            component: () => <div className="text-3xl text-muted-foreground">My Logo</div>,        },        beforeForm: {            component: () => <div className="text-muted-foreground">Welcome to My Brand</div>,        },        afterForm: {            component: () => {                const { handleLogin } = useSsoLogin();                return (                    <div>                        <Button variant="secondary" className="w-full" onClick={handleLogin}>                            Login with SSO                        </Button>                    </div>                );            },        },    },});
```

This will result in a login page like this:

## Fully custom login pages​


[​](#fully-custom-login-pages)If you need even more control over the login page, you can also create an
unauthenticated route with a completely
custom layout.

[unauthenticated route](/guides/extending-the-dashboard/navigation/#unauthenticated-routes)
```
import { defineDashboardExtension } from '@vendure/dashboard';defineDashboardExtension({    routes: [        {            path: '/custom-login',            component: () => (                <div className="flex h-screen items-center justify-center text-2xl">                    This custom login page                </div>            ),            authenticated: false,        },    ],});
```


---

# Page Blocks


In the Dashboard, all pages are built from blocks. Every block has a pageId and a blockId which uniquely locates it in the
app (see Dev Mode section).

[Dev Mode](/guides/extending-the-dashboard/extending-overview/#dev-mode)You can also define your own blocks, which can be added to any page and can even replace the default blocks.

All available options are documented in the DashboardPageBlockDefinition reference

[DashboardPageBlockDefinition reference](/reference/dashboard/extensions-api/page-blocks#dashboardpageblockdefinition)
## Basic Page Block Example​


[​](#basic-page-block-example)Here's an example of how to define a custom page block:

```
import { defineDashboardExtension } from '@vendure/dashboard';defineDashboardExtension({    pageBlocks: [        {            id: 'related-articles',            title: 'Related Articles',            location: {                // This is the pageId of the page where this block will be                pageId: 'product-detail',                // can be "main", "side" or "full"                column: 'side',                position: {                    // Blocks are positioned relative to existing blocks on                    // the page.                    blockId: 'facet-values',                    // Can be "before", "after" or "replace"                    // Here we'll place it after the `facet-values` block.                    order: 'after',                },            },            component: ({ context }) => {                // In the component, you can use the `context` prop to                // access the entity and the form instance.                return <div className="text-sm">Articles related to {context.entity.name}</div>;            },        },    ],});
```

This will add a "Related Articles" block to the product detail page:

## Block Positioning​


[​](#block-positioning)Page blocks can be positioned in three ways relative to existing blocks:

### Before​


[​](#before)Places the block before the specified blockId:

```
position: {    blockId: 'product-variants',    order: 'before'}
```

### After​


[​](#after)Places the block after the specified blockId:

```
position: {    blockId: 'product-variants',    order: 'after'}
```

### Replace​


[​](#replace)Replaces the existing block entirely:

```
position: {    blockId: 'product-variants',    order: 'replace'}
```

## Block Columns​


[​](#block-columns)Blocks can be placed in three columns:

- main: The main content area (wider column on the left)
- side: The sidebar area (narrower column on the right)
- full: Takes up the full horizontal width. This is mostly useful for adding blocks to list pages

## Context Data​


[​](#context-data)The context prop provides access to:

- entity: The current entity being viewed/edited (e.g., Product, Customer, etc.)
- form: The React Hook Form instance for the current page (if applicable)
- route: Route information and parameters

## Block Visibility​


[​](#block-visibility)The visibility of a block can be dynamically controlled using the shouldRender function. This function receives the same
context object as the block component, and should return a boolean to determine whether the block should be rendered.

```
import { defineDashboardExtension } from '@vendure/dashboard';import { AdvancedTaxInfo } from './advanced-tax-info.tsx';defineDashboardExtension({    pageBlocks: [        {            id: 'advanced-tax-info',            location: {                pageId: 'product-variant-detail',                column: 'side',                position: {                    blockId: 'facet-values',                    order: 'after',                },            },            component: AdvancedTaxInfo,            shouldRender: context => {                // You can use custom and build-in hooks                // in this function                const { activeChannel } = useChannel();                const hasTaxSettings = context.entity?.customFields?.taxSettings                // This block will only render if the entity has the                // expected custom field data, and the active channel has                // the given tax setting                return hasTaxSettings && activeChannel.pricesIncludeTax === false;            },        },    ],});
```

The shouldRender function can be used to hide built-in blocks by combining it with the "replace" position
on an existing blockId.

## Advanced Example​


[​](#advanced-example)Here's a more complex example that shows different types of blocks:

```
import { defineDashboardExtension, Button } from '@vendure/dashboard';import { useState } from 'react';defineDashboardExtension({    pageBlocks: [        // Analytics block for product page        {            id: 'product-analytics',            title: 'Product Analytics',            location: {                pageId: 'product-detail',                column: 'side',                position: {                    blockId: 'product-assets',                    order: 'after',                },            },            component: ({ context }) => {                const product = context.entity;                return (                    <div className="space-y-2">                        <div className="text-sm text-muted-foreground">Last 30 days</div>                        <div className="grid grid-cols-2 gap-4">                            <div>                                <div className="text-2xl font-bold">142</div>                                <div className="text-xs text-muted-foreground">Views</div>                            </div>                            <div>                                <div className="text-2xl font-bold">23</div>                                <div className="text-xs text-muted-foreground">Orders</div>                            </div>                        </div>                    </div>                );            },        },        // Quick actions block        {            id: 'quick-actions',            title: 'Quick Actions',            location: {                pageId: 'product-detail',                column: 'main',                position: {                    blockId: 'product-variants',                    order: 'after',                },            },            component: ({ context }) => {                const [isProcessing, setIsProcessing] = useState(false);                const handleSync = async () => {                    setIsProcessing(true);                    // Simulate API call                    await new Promise(resolve => setTimeout(resolve, 2000));                    setIsProcessing(false);                };                return (                    <div className="flex gap-2">                        <Button variant="outline" onClick={handleSync} disabled={isProcessing}>                            {isProcessing ? 'Syncing...' : 'Sync to External System'}                        </Button>                        <Button variant="outline">Generate QR Code</Button>                    </div>                );            },        },    ],});
```

## Finding Block IDs​


[​](#finding-block-ids)To find the pageId and blockId values for positioning your blocks:

- Enable Dev Mode in the dashboard
- Navigate to the page where you want to add your block
- Hover over existing blocks to see their IDs
- Use these IDs in your block positioning configuration

[Dev Mode](/guides/extending-the-dashboard/extending-overview/#dev-mode)- Use descriptive IDs: Choose clear, unique IDs for your blocks
- Position thoughtfully: Consider the user experience when placing blocks
- Handle loading states: Show appropriate loading indicators for async operations
- Follow design patterns: Use the dashboard's existing UI components for consistency
- Test thoroughly: Verify your blocks work correctly on different screen sizes

---

# Action Bar Items


The Action Bar is the bar at the top of the page where you can add
buttons and other actions.

All available options are documented in the DashboardActionBarItem reference

[DashboardActionBarItem reference](/reference/dashboard/extensions-api/action-bar#dashboardactionbaritem)
## Basic Action Bar Item​


[​](#basic-action-bar-item)Here's a simple example of adding a button to the action bar:

```
import { Button, defineDashboardExtension } from '@vendure/dashboard';import { useState } from 'react';defineDashboardExtension({    actionBarItems: [        {            pageId: 'product-detail',            component: ({ context }) => {                const [count, setCount] = useState(0);                return (                    <Button type="button" variant="secondary" onClick={() => setCount(x => x + 1)}>                        Counter: {count}                    </Button>                );            },        },    ],});
```

## Context Data​


[​](#context-data)The context prop provides access to:

- entity: The current entity being viewed/edited (e.g., Product, Customer, etc.)
- form: The React Hook Form instance for the current page (if applicable)
- route: Route information and parameters

## Dropdown Menu​


[​](#dropdown-menu)You can also define dropdown menu items for the Action Bar. This is useful for secondary actions that are needed
less often by administrators.

Make sure to always wrap these in the DropdownMenuItem component for consistent styling.

```
import { DropdownMenuItem, defineDashboardExtension } from '@vendure/dashboard';import { useState } from 'react';defineDashboardExtension({    actionBarItems: [        {            pageId: 'product-list',            type: 'dropdown',            component: () => <DropdownMenuItem variant="default">My Item</DropdownMenuItem>        }    ],});
```

## Practical Examples​


[​](#practical-examples)
### Export Button​


[​](#export-button)
```
import { Button, defineDashboardExtension } from '@vendure/dashboard';import { DownloadIcon } from 'lucide-react';defineDashboardExtension({    actionBarItems: [        {            pageId: 'product-detail',            component: ({ context }) => {                const product = context.entity;                const handleExport = async () => {                    // Export product data                    const data = JSON.stringify(product, null, 2);                    const blob = new Blob([data], { type: 'application/json' });                    const url = URL.createObjectURL(blob);                    const a = document.createElement('a');                    a.href = url;                    a.download = `product-${product.id}.json`;                    a.click();                    URL.revokeObjectURL(url);                };                return (                    <Button variant="outline" onClick={handleExport} disabled={!product}>                        <DownloadIcon className="mr-2 h-4 w-4" />                        Export                    </Button>                );            },        },    ],});
```

### Sync Button with Loading State​


[​](#sync-button-with-loading-state)
```
import { Button, defineDashboardExtension } from '@vendure/dashboard';import { RefreshCwIcon } from 'lucide-react';import { useState } from 'react';import { toast } from 'sonner';defineDashboardExtension({    actionBarItems: [        {            pageId: 'product-detail',            component: ({ context }) => {                const [isSyncing, setIsSyncing] = useState(false);                const product = context.entity;                const handleSync = async () => {                    if (!product) return;                    setIsSyncing(true);                    try {                        // Simulate API call to external system                        await fetch(`/api/sync-product/${product.id}`, {                            method: 'POST',                        });                        toast.success('Product synced successfully');                    } catch (error) {                        toast.error('Failed to sync product');                    } finally {                        setIsSyncing(false);                    }                };                return (                    <Button variant="outline" onClick={handleSync} disabled={!product || isSyncing}>                        <RefreshCwIcon className={`mr-2 h-4 w-4 ${isSyncing ? 'animate-spin' : ''}`} />                        {isSyncing ? 'Syncing...' : 'Sync to ERP'}                    </Button>                );            },        },    ],});
```

### Conditional Action Bar Items​


[​](#conditional-action-bar-items)You can conditionally show action bar items based on the entity or user permissions:

```
import { Button, defineDashboardExtension, PermissionGuard } from '@vendure/dashboard';import { SendIcon } from 'lucide-react';defineDashboardExtension({    actionBarItems: [        {            pageId: 'customer-detail',            component: ({ context }) => {                const customer = context.entity;                // Only show for customers with email addresses                if (!customer?.emailAddress) {                    return null;                }                const handleSendEmail = () => {                    // Open email composer or trigger email send                    console.log('Sending email to:', customer.emailAddress);                };                return (                    <PermissionGuard requires={['UpdateCustomer']}>                        <Button variant="outline" onClick={handleSendEmail}>                            <SendIcon className="mr-2 h-4 w-4" />                            Send Email                        </Button>                    </PermissionGuard>                );            },        },    ],});
```

## Multiple Action Bar Items​


[​](#multiple-action-bar-items)You can add multiple action bar items to the same page:

```
import { Button, defineDashboardExtension } from '@vendure/dashboard';import { DownloadIcon, RefreshCwIcon, SendIcon } from 'lucide-react';defineDashboardExtension({    actionBarItems: [        {            pageId: 'product-detail',            component: ({ context }) => (                <Button variant="outline">                    <DownloadIcon className="mr-2 h-4 w-4" />                    Export                </Button>            ),        },        {            pageId: 'product-detail',            component: ({ context }) => (                <Button variant="outline">                    <RefreshCwIcon className="mr-2 h-4 w-4" />                    Sync                </Button>            ),        },        {            pageId: 'product-detail',            component: ({ context }) => (                <Button variant="outline">                    <SendIcon className="mr-2 h-4 w-4" />                    Share                </Button>            ),        },    ],});
```

## Available Button Variants​


[​](#available-button-variants)The dashboard provides several button variants you can use:

- default - Primary button style
- secondary - Secondary button style
- outline - Outlined button style
- ghost - Minimal button style
- destructive - For destructive actions (delete, etc.)

```
<Button variant="default">Primary</Button><Button variant="secondary">Secondary</Button><Button variant="outline">Outline</Button><Button variant="ghost">Ghost</Button><Button variant="destructive">Delete</Button>
```

## Best Practices​


[​](#best-practices)- Use appropriate icons: Icons help users quickly understand the action
- Provide loading states: Show loading indicators for async operations
- Handle errors gracefully: Use toast notifications for feedback
- Consider permissions: Use PermissionGuard for actions that require specific permissions
- Keep labels concise: Use short, descriptive labels for buttons
- Group related actions: Consider the order and grouping of multiple action items
- Test thoroughly: Verify your actions work correctly across different entity states

## Finding Page IDs​


[​](#finding-page-ids)To find the pageId for your action bar items:

- Enable Dev Mode in the dashboard
- Navigate to the page where you want to add your action
- The page ID will be shown in the dev mode overlay
- Use this ID in your action bar item configuration

[Dev Mode](/guides/extending-the-dashboard/extending-overview/#dev-mode)


---

# Insights Page Widgets


The "Insights" page can be extended with custom widgets which are used to display charts, metrics or other information that can
be useful for administrators to see at a glance.

## Example​


[​](#example)Here's an example of a custom widget:

```
import { Badge, DashboardBaseWidget, useLocalFormat, useWidgetFilters } from '@vendure/dashboard';export function CustomWidget() {    const { dateRange } = useWidgetFilters();    const { formatDate } = useLocalFormat();    return (        <DashboardBaseWidget id="custom-widget" title="Custom Widget" description="This is a custom widget">            <div className="flex flex-wrap gap-1">                <span>Displaying results from</span>                <Badge variant="secondary">{formatDate(dateRange.from)}</Badge>                <span>to</span>                <Badge variant="secondary">{formatDate(dateRange.to)}</Badge>            </div>        </DashboardBaseWidget>    );}
```

Always wrap your custom widget in the DashboardBaseWidget component, which ensures that it will render correctly
in the Insights page.

Use the useWidgetFilters() hook to get the currently-selected date range, if your widget depends on that.

Then register your widget in your dashboard entrypoint file:

```
import { defineDashboardExtension } from '@vendure/dashboard';import { CustomWidget } from './custom-widget';defineDashboardExtension({    widgets: [        {            id: 'custom-widget',            name: 'Custom Widget',            component: CustomWidget,            defaultSize: { w: 3, h: 3 },        },    ],});
```

Your widget should now be available on the Insights page:


---

# History Entries


The Customer and Order detail pages have a special history timeline, which show a summary of all significant changes and
activity relating to that customer or order.

History entries are defined by DashboardHistoryEntryComponent,
and the component should be wrapped in HistoryEntry.

[DashboardHistoryEntryComponent](/reference/dashboard/extensions-api/history-entries#dashboardhistoryentrycomponent)[HistoryEntry](/reference/dashboard/extensions-api/history-entries#historyentry)
## Example​


[​](#example)Following the backend example of a custom history entry given in the HistoryService docs,
we can define a corresponding component to render this entry in the customer history timeline:

[HistoryService docs](/reference/typescript-api/services/history-service)
```
import { defineDashboardExtension, HistoryEntry } from '@vendure/dashboard';import { IdCard } from 'lucide-react';defineDashboardExtension({    historyEntries: [        {            type: 'CUSTOMER_TAX_ID_VERIFICATION',            component: ({ entry, entity }) => {                return (                    <HistoryEntry                        entry={entry}                        title={'Tax ID verified'}                        timelineIconClassName={'bg-success text-success-foreground'}                        timelineIcon={<IdCard />}                    >                        <div className="text-xs">Approval reference: {entry.data.ref}</div>                    </HistoryEntry>                );            },        },    ],});
```

This will then appear in the customer history timeline:



---

# Custom Form Elements


The dashboard allows you to create custom form elements that provide complete control over how data is rendered and how users
interact with forms. This includes:

- Custom Field Components - Globally-registered components that can be used to render custom fields and configurable operation arguments
- Detail Form Components - Form input components that target specific fields of detail pages.

## Anatomy of a Form Component​


[​](#anatomy-of-a-form-component)All form components must implement the DashboardFormComponent type.

[DashboardFormComponent type](/reference/dashboard/extensions-api/form-components#dashboardformcomponent)This type is based on the props that are made available from react-hook-form, which is the
underlying form library used by the Dashboard.

Here's an example custom form component that has been annotated to explain the typical parts you will be working with:

```
import { Button, Card, CardContent, cn, DashboardFormComponent, Input } from '@vendure/dashboard';import { useState } from 'react';import { useFormContext } from 'react-hook-form';// By typing your component as DashboardFormComponent, the props will be correctly typedexport const ColorPickerComponent: DashboardFormComponent = ({ value, onChange, name }) => {    // You can use any of the built-in React hooks as usual    const [isOpen, setIsOpen] = useState(false);    // To access the react-hook-form context, use this hook.    // This is useful for getting information about the current    // field, or even other fields in the form, which allows you    // to create advanced components that depend on the state of    // other fields in the form.    const { getFieldState } = useFormContext();    // The current field name is always passed in as a prop, allowing    // you to look up the field state    const error = getFieldState(name).error;    const colors = ['#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FECA57', '#FF9FF3', '#54A0FF', '#5F27CD'];    return (        <div className="space-y-2">            <div className="flex items-center space-x-2">                <Button                    type="button"                    variant="outline"                    size="icon"                    className={cn('w-8 h-8 border-2 border-gray-300 p-0', error && 'border-red-500')}                    style={{ backgroundColor: error ? 'transparent' : value || '#ffffff' }}                    onClick={() => setIsOpen(!isOpen)}                />                <Input value={value || ''} onChange={e => onChange(e.target.value)} placeholder="#ffffff" />            </div>            {isOpen && (                <Card>                    <CardContent className="grid grid-cols-4 gap-2 p-2">                        {colors.map(color => (                            <Button                                key={color}                                type="button"                                variant="outline"                                size="icon"                                className="w-8 h-8 border-2 border-gray-300 hover:border-gray-500 p-0"                                style={{ backgroundColor: color }}                                onClick={() => {                                    onChange(color);                                    setIsOpen(false);                                }}                            />                        ))}                    </CardContent>                </Card>            )}        </div>    );};
```

Here's how this component will look when rendered in your form:

## Custom Field Components​


[​](#custom-field-components)Let's configure a custom field which uses the ColorPickerComponent as its form component.

[custom field](/guides/developer-guide/custom-fields/)First we need to register the component with the defineDashboardExtension function:

```
import { defineDashboardExtension } from '@vendure/dashboard';import { ColorPickerComponent } from './components/color-picker';defineDashboardExtension({    customFormComponents: {        // Custom field components for custom fields        customFields: [            {                // The "id" is a global identifier for this custom component. We will                // reference it in the next step.                id: 'color-picker',                component: ColorPickerComponent,            },        ],    },    // ... other extension properties});
```

Now that we've registered it as a custom field component, we can use it in our custom field definition.

```
@VendurePlugin({    // ...    configuration: config => {        config.customFields.Product.push({            name: 'color',            type: 'string',            pattern: '^#[A-Fa-f0-9]{6}$',            label: [{ languageCode: LanguageCode.en, value: 'Color' }],            description: [{ languageCode: LanguageCode.en, value: 'Main color for this product' }],            ui: {                // This is the ID of the custom field                // component we registered above.                component: 'color-picker',            },        });        return config;    },})export class MyPlugin {}
```

## Configurable Operation Components​


[​](#configurable-operation-components)The ColorPickerComponent can also be used as a configurable operation argument component. For example, we can add a color code
to a shipping calculator:

[configurable operation argument](/guides/developer-guide/strategies-configurable-operations/#configurable-operations)
```
const customShippingCalculator = new ShippingCalculator({    code: 'custom-shipping-calculator',    description: [{ languageCode: LanguageCode.en, value: 'Custom Shipping Calculator' }],    args: {        color: {            type: 'string',            label: [{ languageCode: LanguageCode.en, value: 'Color' }],            description: [                { languageCode: LanguageCode.en, value: 'Color code for this shipping calculator' },            ],            ui: { component: 'color-picker' },        },    },    calculate: (ctx, order, args) => {        // ...    },});
```

## Detail Form Components​


[​](#detail-form-components)Detail form components allow you to replace specific input fields in existing dashboard forms with custom implementations. They are targeted to specific pages, blocks, and fields.

Let's say we want to use a plain text editor for the product description field rather than the default
html-based editor.

```
import { DashboardFormComponent, Textarea } from '@vendure/dashboard';// This is a simplified example - a real markdown editor should use// a library that handles markdown rendering and editing.export const MarkdownEditorComponent: DashboardFormComponent = props => {    return (        <Textarea            className="font-mono"            ref={props.ref}            onBlur={props.onBlur}            value={props.value}            onChange={e => props.onChange(e.target.value)}            disabled={props.disabled}        />    );};
```

You can then use this component in your detail form definition:

```
import { defineDashboardExtension } from '@vendure/dashboard';import { MarkdownEditorComponent } from './components/markdown-editor';defineDashboardExtension({    detailForms: [        {            pageId: 'product-detail',            inputs: [                {                    blockId: 'main-form',                    field: 'description',                    component: MarkdownEditorComponent,                },            ],        },    ],});
```

### Targeting Input Components​


[​](#targeting-input-components)Input components are targeted using three properties:

- pageId: The ID of the page (e.g., 'product-detail', 'customer-detail')
- blockId: The ID of the form block (e.g., 'product-form', 'customer-info')
- field: The name of the field to replace (e.g., 'price', 'email')

```
inputs: [    {        pageId: 'product-variant-detail',        blockId: 'main-form',        field: 'price',        component: PriceInputComponent,    },    {        pageId: 'customer-detail',        blockId: 'main-form',        field: 'emailAddress',        component: EmailInputComponent,    },];
```

You can discover the required IDs by turning on dev mode:

and then hovering over any of the form elements will allow you to view the IDs:

## Form Validation​


[​](#form-validation)Form validation is handled by the react-hook-form library, which is used by the Dashboard. Internally,
the Dashboard uses the zod library to validate the form data, based on the configuration of the custom field or
operation argument.

You can access validation data for the current field or the whole form by using the useFormContext hook.

Your component does not need to handle standard error messages - the Dashboard will handle them for you.

For example, if your custom field specifies a pattern property, the Dashboard will automatically display an error message
if the input does not match the pattern.

```
import { DashboardFormComponent, Input, Alert, AlertDescription } from '@vendure/dashboard';import { useFormContext } from 'react-hook-form';import { CheckCircle2 } from 'lucide-react';export const ValidatedInputComponent: DashboardFormComponent = ({ value, onChange, name }) => {    const { getFieldState } = useFormContext();    const fieldState = getFieldState(name);    console.log(fieldState);    // will log something like this:    // {    //     "invalid": false,    //     "isDirty": false,    //     "isValidating": false,    //     "isTouched": false    // }    // You can use this data to display validation errors, etc.    return (        <div className="space-y-2">            <Input                value={field.value || ''}                onChange={e => field.onChange(e.target.value)}                onBlur={field.onBlur}                className={fieldState.error ? 'border-destructive' : ''}            />            {fieldState.error && (                <Alert variant="destructive">                    <AlertDescription>{fieldState.error.message}</AlertDescription>                </Alert>            )}            {fieldState.isTouched && !fieldState.error && (                <div className="flex items-center gap-1 text-sm text-green-600">                    <CheckCircle2 className="h-4 w-4" />                    Valid input                </div>            )}        </div>    );}
```

- Always use Shadcn UI components from the @vendure/dashboard package for consistent styling
- Handle React Hook Form events properly - call onChange and onBlur appropriately for custom field components
- Display validation errors from fieldState.error when they exist (custom field components)
- Use dashboard design tokens - leverage text-destructive, text-muted-foreground, etc.
- Provide clear visual feedback for user interactions
- Handle disabled states by using the disabled prop
- Target components precisely using pageId, blockId, and field for input components

Always import UI components from the @vendure/dashboard package rather than creating custom inputs or buttons. This ensures your components follow the dashboard's design system and remain consistent with future updates.

The unified custom form elements system gives you complete flexibility in how data is presented and edited in the dashboard, while maintaining seamless integration with React Hook Form and the dashboard's design system.

## Nested Forms and Event Handling​


[​](#nested-forms-and-event-handling)When creating custom form components that contain their own forms (e.g., dialogs with forms inside detail pages), you need to prevent form submission events from bubbling up to parent forms. The dashboard provides the handleNestedFormSubmit utility for this purpose.

### Why Use handleNestedFormSubmit?​


[​](#why-use-handlenestedformsubmit)Detail pages in the dashboard are themselves forms. If you add a custom component with its own form (like a dialog with create/edit functionality), submitting the inner form will also trigger the outer detail page form submission. This can cause:

- Unintended save operations on the detail page
- Validation errors on unrelated fields
- Loss of unsaved changes in the dialog

### Using handleNestedFormSubmit​


[​](#using-handlenestedformsubmit)The handleNestedFormSubmit utility prevents event propagation and properly handles form submission:

```
import {    Button,    Dialog,    DialogContent,    DialogTrigger,    Form,    DashboardFormComponent,    handleNestedFormSubmit} from '@vendure/dashboard';import { useForm } from 'react-hook-form';import { zodResolver } from '@hookform/resolvers/zod';import { z } from 'zod';const formSchema = z.object({    title: z.string().min(1, 'Title is required'),    description: z.string().min(1, 'Description is required'),});type FormData = z.infer<typeof formSchema>;export const NestedFormDialogComponent: DashboardFormComponent = (props) => {    const form = useForm<FormData>({        resolver: zodResolver(formSchema),        defaultValues: {            title: '',            description: '',        },    });    const onSubmit = (data: FormData) => {        // Handle your form submission logic        console.log('Form submitted:', data);        // You might update the parent form value here        props.onChange(data);        form.reset();    };    return (        <Dialog>            <DialogTrigger asChild>                <Button variant="outline">Open Form</Button>            </DialogTrigger>            <DialogContent>                <Form {...form}>                    {/* Use handleNestedFormSubmit to prevent event bubbling */}                    <form onSubmit={handleNestedFormSubmit(form, onSubmit)}>                        {/* Your form fields here */}                        <Button type="submit">Save</Button>                    </form>                </Form>            </DialogContent>        </Dialog>    );};
```

### What handleNestedFormSubmit Does​


[​](#what-handlenestedformsubmit-does)The utility function:

- Prevents the submit event from propagating to parent forms (e.stopPropagation())
- Prevents the browser's default form submission behavior (e.preventDefault())
- Properly triggers react-hook-form's handleSubmit with your custom handler
- Maintains type safety with TypeScript generics

### When to Use It​


[​](#when-to-use-it)Use handleNestedFormSubmit whenever you have:

- A dialog with a form inside a detail page
- A custom component with its own form that's nested within another form
- Any scenario where form submission events should not bubble up to parent forms

## Relation Selectors​


[​](#relation-selectors)The dashboard includes powerful relation selector components for selecting related entities with built-in search and pagination:

```
import {    SingleRelationInput,    createRelationSelectorConfig,    graphql,    CustomFormComponentInputProps,} from '@vendure/dashboard';const productConfig = createRelationSelectorConfig({    listQuery: graphql(`        query GetProductsForSelection($options: ProductListOptions) {            products(options: $options) {                items {                    id                    name                }                totalItems            }        }    `),    idKey: 'id',    labelKey: 'name',    placeholder: 'Search products...',    buildSearchFilter: (term: string) => ({        name: { contains: term },    }),});export function ProductSelectorComponent({ value, onChange }: CustomFormComponentInputProps) {    return <SingleRelationInput value={value} onChange={onChange} config={productConfig} />;}
```

Features include:

- Real-time search with debounced input
- Infinite scroll pagination loading 25 items by default
- Single and multi-select modes with type safety
- Customizable GraphQL queries and search filters
- Built-in UI components using the dashboard design system

## Further Reading​


[​](#further-reading)For detailed information about specific types of custom form elements, see these dedicated guides:

- Form component examples - Detailed examples of how to use the APIs available for custom form components.
- Relation selectors - Build powerful entity selection components with search, pagination, and multi-select capabilities for custom fields and form inputs

[Form component examples](/guides/extending-the-dashboard/custom-form-components/form-component-examples)[Relation selectors](/guides/extending-the-dashboard/custom-form-components/relation-selectors)

---


# Form Component Examples


## Email Input with Validation​


[​](#email-input-with-validation)This example uses the react-hook-form validation state in order to display an icon indicating
the validity of the email address, as defined by the custom field "pattern" option:

- Component
- Registration
- Custom field definition

```
import {AffixedInput, DashboardFormComponent} from '@vendure/dashboard';import {Mail, Check, X} from 'lucide-react';import {useFormContext} from 'react-hook-form';export const EmailInputComponent: DashboardFormComponent = ({name, value, onChange, disabled}) => {    const {getFieldState} = useFormContext();    const isValid = getFieldState(name).invalid === false;    return (        <AffixedInput            prefix={<Mail className="h-4 w-4 text-muted-foreground" />}            suffix={                value &&                (isValid ? (                    <Check className="h-4 w-4 text-green-500" />                ) : (                    <X className="h-4 w-4 text-red-500" />                ))            }            value={value || ''}            onChange={e => onChange(e.target.value)}            disabled={disabled}            placeholder="Enter email address"            className="pl-10 pr-10"            name={name}        />    );};
```

```
import { defineDashboardExtension } from '@vendure/dashboard';import { EmailInputComponent } from './components/email-input';defineDashboardExtension({    customFormComponents: {        customFields: [            {                id: 'custom-email',                component: EmailInputComponent,            },        ],    }});
```

```
@VendureConfig({    configuration: config => {        config.customFields.Seller.push({            name: 'supplierEmail',            type: 'string',            label: [{ languageCode: LanguageCode.en, value: 'Supplier Email' }],            pattern: '^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$',            ui: { component: 'custom-email' },        });        return config;    }})export class MyPlugin {}
```

## Multi-Currency Price Input​


[​](#multi-currency-price-input)This example demonstrates a component with its own state (using useState) and more complex
internal logic.

- Component
- Registration
- Custom field definition

```
import {    AffixedInput,    DashboardFormComponent,    Select,    SelectContent,    SelectItem,    SelectTrigger,    SelectValue,    useLocalFormat,} from '@vendure/dashboard';import { useState } from 'react';export const MultiCurrencyInputComponent: DashboardFormComponent = ({ value, onChange, disabled, name }) => {    const [currency, setCurrency] = useState('USD');    const { formatCurrencyName } = useLocalFormat();    const currencies = [        { code: 'USD', symbol: '$', rate: 1 },        { code: 'EUR', symbol: '€', rate: 0.85 },        { code: 'GBP', symbol: '£', rate: 0.73 },        { code: 'JPY', symbol: '¥', rate: 110 },    ];    const selectedCurrency = currencies.find(c => c.code === currency) || currencies[0];    // Convert price based on exchange rate    const displayValue = value ? (value * selectedCurrency.rate).toFixed(2) : '';    const handleChange = (val: string) => {        const numericValue = parseFloat(val) || 0;        // Convert back to base currency (USD) for storage        const baseValue = numericValue / selectedCurrency.rate;        onChange(baseValue);    };    return (        <div className="flex space-x-2">            <Select value={currency} onValueChange={setCurrency} disabled={disabled}>                <SelectTrigger className="w-24">                    <SelectValue>                        <div className="flex items-center gap-1">{currency}</div>                    </SelectValue>                </SelectTrigger>                <SelectContent>                    {currencies.map(curr => {                        return (                            <SelectItem key={curr.code} value={curr.code}>                                <div className="flex items-center gap-2">{formatCurrencyName(curr.code)}</div>                            </SelectItem>                        );                    })}                </SelectContent>            </Select>            <AffixedInput                prefix={selectedCurrency.symbol}                value={displayValue}                onChange={e => onChange(e.target.value)}                disabled={disabled}                placeholder="0.00"                name={name}            />        </div>    );};
```

```
import { defineDashboardExtension } from '@vendure/dashboard';import { MultiCurrencyInputComponent } from './components/price-input';defineDashboardExtension({    customFormComponents: {        customFields: [            {                id: 'custom-price',                component: MultiCurrencyInputComponent,            },        ],    }});
```

```
@VendureConfig({    configuration: config => {        config.customFields.Product.push({            name: 'rrp',            type: 'int',            label: [{ languageCode: LanguageCode.en, value: 'RRP' }],            ui: { component: 'custom-price' },        });        return config;    }})export class MyPlugin {}
```

## Tags Input Component​


[​](#tags-input-component)This component brings better UX to a simple comma-separated tags custom field.

- Component
- Registration
- Custom field definition

```
import { Input, Badge, Button, DashboardFormComponent } from '@vendure/dashboard';import { useState, KeyboardEvent } from 'react';import { X } from 'lucide-react';export const TagsInputComponent: DashboardFormComponent = ({ value, onChange, disabled, name, onBlur }) => {    const [inputValue, setInputValue] = useState('');    // Parse tags from string value (comma-separated)    const tags: string[] = value ? value.split(',').filter(Boolean) : [];    const addTag = (tag: string) => {        const trimmedTag = tag.trim();        if (trimmedTag && !tags.includes(trimmedTag)) {            const newTags = [...tags, trimmedTag];            onChange(newTags.join(','));        }        setInputValue('');    };    const removeTag = (tagToRemove: string) => {        const newTags = tags.filter(tag => tag !== tagToRemove);        onChange(newTags.join(','));    };    const handleKeyDown = (e: KeyboardEvent<HTMLInputElement>) => {        if (e.key === 'Enter' || e.key === ',') {            e.preventDefault();            addTag(inputValue);        } else if (e.key === 'Backspace' && inputValue === '' && tags.length > 0) {            removeTag(tags[tags.length - 1]);        }    };    return (        <div className="space-y-2">            {/* Tags Display */}            <div className="flex flex-wrap gap-1">                {tags.map((tag, index) => (                    <Badge key={index} variant="secondary" className="gap-1">                        {tag}                        <Button                            type="button"                            variant="ghost"                            size="icon"                            className="h-4 w-4 p-0 hover:bg-transparent"                            onClick={() => removeTag(tag)}                            disabled={disabled}                        >                            <X className="h-3 w-3" />                        </Button>                    </Badge>                ))}            </div>            {/* Input */}            <Input                value={inputValue}                onChange={e => setInputValue(e.target.value)}                onKeyDown={handleKeyDown}                onBlur={onBlur}                disabled={disabled}                placeholder="Type a tag and press Enter or comma"                name={name}            />        </div>    );};
```

```
import { defineDashboardExtension } from '@vendure/dashboard';import { TagsInputComponent } from './components/tags-input';defineDashboardExtension({    customFormComponents: {        customFields: [            {                id: 'custom-tags',                component: TagsInputComponent,            },        ],    }});
```

```
@VendureConfig({    configuration: config => {        config.customFields.Product.push({            name: 'tags',            type: 'string',            label: [{ languageCode: LanguageCode.en, value: 'Tags' }],            ui: { component: 'custom-tags' },        });        return config;    }})export class MyPlugin {}
```

## Auto-generating Slug Input​


[​](#auto-generating-slug-input)This example demonstrates a component that automatically generates a slug from the product name.
It uses the react-hook-form watch method to get the value of another field in the form and
react to changes in that field.

- Component
- Registration

```
    import { Input, Button, Switch, DashboardFormComponent } from '@vendure/dashboard';    import { useFormContext } from 'react-hook-form';    import { useState, useEffect } from 'react';    import { RefreshCw, Lock, Unlock } from 'lucide-react';    export const SlugInputComponent: DashboardFormComponent = ({ value, onChange, disabled, name }) => {        const [autoGenerate, setAutoGenerate] = useState(!value);        const [isGenerating, setIsGenerating] = useState(false);        const { watch } = useFormContext();        const nameValue = watch('translations.0.name');        const generateSlug = (text: string) => {            return text                .toLowerCase()                .replace(/[^a-z0-9 -]/g, '') // Remove special characters                .replace(/\s+/g, '-') // Replace spaces with hyphens                .replace(/-+/g, '-') // Replace multiple hyphens with single                .trim('-'); // Remove leading/trailing hyphens        };        useEffect(() => {            if (autoGenerate && nameValue) {                const newSlug = generateSlug(nameValue);                if (newSlug !== value) {                    onChange(newSlug);                }            }        }, [nameValue, autoGenerate, onChange, value]);        const handleManualGenerate = async () => {            if (!nameValue) return;            setIsGenerating(true);            // Simulate API call for slug validation/generation            await new Promise(resolve => setTimeout(resolve, 500));            const newSlug = generateSlug(nameValue);            onChange(newSlug);            setIsGenerating(false);        };        return (            <div className="space-y-2">                <div className="flex items-center space-x-2">                    <Input                        value={value || ''}                        onChange={e => onChange(e.target.value)}                        disabled={disabled || autoGenerate}                        placeholder="product-slug"                        className="flex-1"                        name={name}                    />                    <Button                        type="button"                        variant="outline"                        size="icon"                        disabled={disabled || !nameValue || isGenerating}                        onClick={handleManualGenerate}                    >                        <RefreshCw className={`h-4 w-4 ${isGenerating ? 'animate-spin' : ''}`} />                    </Button>                </div>                <div className="flex items-center space-x-2">                    <Switch checked={autoGenerate} onCheckedChange={setAutoGenerate} disabled={disabled} />                    <div className="flex items-center space-x-1 text-sm text-muted-foreground">                        {autoGenerate ? <Lock className="h-3 w-3" /> : <Unlock className="h-3 w-3" />}                        <span>Auto-generate from name</span>                    </div>                </div>            </div>        );    };
```

```
import { defineDashboardExtension } from '@vendure/dashboard';import { SlugInputComponent } from './components/slug-input';defineDashboardExtension({    detailForms: [        {            pageId: 'product-detail',            inputs: [                {                    blockId: 'main-form',                    field: 'slug',                    component: SlugInputComponent,                },            ],        },    ]});
```

Input components completely replace the default input for the targeted field. Make sure your component handles all the data types and scenarios that the original input would have handled.

## Related Guides​


[​](#related-guides)- Custom Form Elements Overview - Learn about the unified system for custom field components, input components, and display components

[Custom Form Elements Overview](/guides/extending-the-dashboard/custom-form-components/)


---

# Relation Selectors


Relation selector components provide a powerful way to select related entities in your dashboard forms. They support both single and multi-selection modes with built-in search, infinite scroll pagination, and complete TypeScript type safety.

## Features​


[​](#features)- Real-time Search: Debounced search with customizable filters
- Infinite Scroll: Automatic pagination loading 25 items by default
- Single/Multi Select: Easy toggle between selection modes
- Type Safe: Full TypeScript support with generic types
- Customizable: Pass your own GraphQL queries and field mappings
- Accessible: Built with Radix UI primitives

## Components Overview​


[​](#components-overview)The relation selector system consists of three main components:

- RelationSelector: The abstract base component that handles all core functionality
- SingleRelationInput: Convenient wrapper for single entity selection
- MultiRelationInput: Convenient wrapper for multiple entity selection

## Basic Usage​


[​](#basic-usage)
### Single Selection​


[​](#single-selection)
```
import {    SingleRelationInput,    createRelationSelectorConfig,    graphql,    ResultOf,    CustomFormComponentInputProps,} from '@vendure/dashboard';// Define your GraphQL queryconst productListQuery = graphql(`    query GetProductsForSelection($options: ProductListOptions) {        products(options: $options) {            items {                id                name                slug                featuredAsset {                    id                    preview                }            }            totalItems        }    }`);// Create the configurationconst productConfig = createRelationSelectorConfig({    listQuery: productListQuery,    idKey: 'id',    labelKey: 'name',    placeholder: 'Search products...',    buildSearchFilter: (term: string) => ({        name: { contains: term },    }),});export function ProductSelectorComponent({ value, onChange, disabled }: CustomFormComponentInputProps) {    return (        <SingleRelationInput value={value} onChange={onChange} config={productConfig} disabled={disabled} />    );}
```

### Multi Selection​


[​](#multi-selection)
```
import { MultiRelationInput, CustomFormComponentInputProps } from '@vendure/dashboard';export function ProductMultiSelectorComponent({ value, onChange, disabled }: CustomFormComponentInputProps) {    return (        <MultiRelationInput            value={value || []}            onChange={onChange}            config={productConfig} // Same config as above            disabled={disabled}        />    );}
```

## Configuration Options​


[​](#configuration-options)The createRelationSelectorConfig function accepts these options:

```
interface RelationSelectorConfig<T> {    /** The GraphQL query document for fetching items */    listQuery: DocumentNode;    /** The property key for the entity ID */    idKey: keyof T;    /** The property key for the display label (used as fallback when label function not provided) */    labelKey: keyof T;    /** Number of items to load per page (default: 25) */    pageSize?: number;    /** Placeholder text for the search input */    placeholder?: string;    /** Whether to enable multi-select mode */    multiple?: boolean;    /** Custom filter function for search */    buildSearchFilter?: (searchTerm: string) => any;    /** Custom label renderer function for rich display */    label?: (item: T) => React.ReactNode;}
```

## Rich Label Display​


[​](#rich-label-display)The label prop allows you to customize how items are displayed in both the dropdown and selected item chips. This enables rich content like images, badges, and multi-line information.

### Product Selector with Images and Pricing​


[​](#product-selector-with-images-and-pricing)
```
import {    SingleRelationInput,    createRelationSelectorConfig,    graphql,    ResultOf,    CustomFormComponentInputProps,} from '@vendure/dashboard';const productListQuery = graphql(`    query GetProductsWithDetails($options: ProductListOptions) {        products(options: $options) {            items {                id                name                slug                featuredAsset {                    id                    preview                }                variants {                    id                    price                    currencyCode                }            }            totalItems        }    }`);const richProductConfig = createRelationSelectorConfig<    ResultOf<typeof productListQuery>['products']['items'][0]>({    listQuery: productListQuery,    idKey: 'id',    labelKey: 'name', // Used as fallback    placeholder: 'Search products...',    label: product => (        <div className="flex items-center gap-3 py-1">            {product.featuredAsset?.preview && (                <img                    src={product.featuredAsset.preview}                    alt={product.name}                    className="w-10 h-10 rounded object-cover"                />            )}            <div className="flex-1 min-w-0">                <div className="font-medium truncate">{product.name}</div>                <div className="text-sm text-muted-foreground">                    {product.variants[0] && (                        <span>                            {product.variants[0].price / 100} {product.variants[0].currencyCode}                        </span>                    )}                </div>            </div>        </div>    ),    buildSearchFilter: (term: string) => ({        name: { contains: term },    }),});export function RichProductSelectorComponent({ value, onChange, disabled }: CustomFormComponentInputProps) {    return (        <SingleRelationInput            value={value}            onChange={onChange}            config={richProductConfig}            disabled={disabled}        />    );}
```

### Customer Selector with Status Badges​


[​](#customer-selector-with-status-badges)
```
import {    MultiRelationInput,    createRelationSelectorConfig,    graphql,    ResultOf,    CustomFormComponentInputProps,} from '@vendure/dashboard';const customerListQuery = graphql(`    query GetCustomersWithStatus($options: CustomerListOptions) {        customers(options: $options) {            items {                id                firstName                lastName                emailAddress                user {                    verified                    lastLogin                }                orders {                    totalQuantity                }            }            totalItems        }    }`);const customerConfig = createRelationSelectorConfig<    ResultOf<typeof customerListQuery>['customers']['items'][0]>({    listQuery: customerListQuery,    idKey: 'id',    labelKey: 'emailAddress',    placeholder: 'Search customers...',    label: customer => (        <div className="flex items-center justify-between py-1 w-full">            <div className="flex-1 min-w-0">                <div className="font-medium truncate">                    {customer.firstName} {customer.lastName}                </div>                <div className="text-sm text-muted-foreground truncate">{customer.emailAddress}</div>            </div>            <div className="flex items-center gap-2 ml-2">                {customer.user?.verified ? (                    <span className="inline-flex items-center px-2 py-1 text-xs font-medium rounded-full bg-green-100 text-green-800">                        Verified                    </span>                ) : (                    <span className="inline-flex items-center px-2 py-1 text-xs font-medium rounded-full bg-gray-100 text-gray-800">                        Unverified                    </span>                )}                <span className="text-xs text-muted-foreground">{customer.orders.totalQuantity} orders</span>            </div>        </div>    ),    buildSearchFilter: (term: string) => ({        or: [            { emailAddress: { contains: term } },            { firstName: { contains: term } },            { lastName: { contains: term } },        ],    }),});export function CustomerSelectorWithStatusComponent({    value,    onChange,    disabled,}: CustomFormComponentInputProps) {    return (        <MultiRelationInput            value={value || []}            onChange={onChange}            config={customerConfig}            disabled={disabled}        />    );}
```

## Advanced Examples​


[​](#advanced-examples)
### Custom Entity with Complex Search​


[​](#custom-entity-with-complex-search)
```
import {    SingleRelationInput,    createRelationSelectorConfig,    graphql,    ResultOf,    CustomFormComponentInputProps,} from '@vendure/dashboard';const reviewFragment = graphql(`    fragment ReviewForSelector on ProductReview {        id        title        rating        summary        state        product {            name        }    }`);const reviewListQuery = graphql(    `        query GetReviewsForSelection($options: ProductReviewListOptions) {            productReviews(options: $options) {                items {                    ...ReviewForSelector                }                totalItems            }        }    `,    [reviewFragment],);const reviewConfig = createRelationSelectorConfig<ResultOf<typeof reviewFragment>>({    listQuery: reviewListQuery,    idKey: 'id',    labelKey: 'title',    placeholder: 'Search reviews by title or summary...',    pageSize: 20, // Custom page size    buildSearchFilter: (term: string) => ({        // Search across multiple fields        or: [            { title: { contains: term } },            { summary: { contains: term } },            { product: { name: { contains: term } } },        ],    }),});export function ReviewSelectorComponent({ value, onChange }: CustomFormComponentInputProps) {    return <SingleRelationInput value={value} onChange={onChange} config={reviewConfig} />;}
```

### Asset Selector with Type Filtering​


[​](#asset-selector-with-type-filtering)
```
import {    graphql,    createRelationSelectorConfig,    SingleRelationInput,    CustomFormComponentInputProps,} from '@vendure/dashboard';const assetListQuery = graphql(`    query GetAssetsForSelection($options: AssetListOptions) {        assets(options: $options) {            items {                id                name                preview                type                fileSize            }            totalItems        }    }`);const imageAssetConfig = createRelationSelectorConfig({    listQuery: assetListQuery,    idKey: 'id',    labelKey: 'name',    placeholder: 'Search images...',    buildSearchFilter: (term: string) => ({        and: [            { type: { eq: 'IMAGE' } }, // Only show images            {                or: [{ name: { contains: term } }, { preview: { contains: term } }],            },        ],    }),});export function ImageSelectorComponent({ value, onChange }: CustomFormComponentInputProps) {    return <SingleRelationInput value={value} onChange={onChange} config={imageAssetConfig} />;}
```

### Multi-Select with Status Filtering​


[​](#multi-select-with-status-filtering)
```
import {    MultiRelationInput,    createRelationSelectorConfig,    graphql,    CustomFormComponentInputProps,} from '@vendure/dashboard';const customerListQuery = graphql(`    query GetCustomersForSelection($options: CustomerListOptions) {        customers(options: $options) {            items {                id                firstName                lastName                emailAddress                user {                    verified                }            }            totalItems        }    }`);const activeCustomerConfig = createRelationSelectorConfig({    listQuery: customerListQuery,    idKey: 'id',    labelKey: 'emailAddress',    placeholder: 'Search verified customers...',    pageSize: 30,    buildSearchFilter: (term: string) => ({        and: [            { user: { verified: { eq: true } } }, // Only verified customers            {                or: [                    { emailAddress: { contains: term } },                    { firstName: { contains: term } },                    { lastName: { contains: term } },                ],            },        ],    }),});export function ActiveCustomerSelectorComponent({ value, onChange }: CustomFormComponentInputProps) {    return <MultiRelationInput value={value || []} onChange={onChange} config={activeCustomerConfig} />;}
```

## Registration​


[​](#registration)Register your relation selector components in your dashboard extension:

```
import { defineDashboardExtension } from '@vendure/dashboard';import {    ProductSelectorComponent,    ReviewSelectorComponent,    ImageSelectorComponent,    ActiveCustomerSelectorComponent,} from './components';defineDashboardExtension({    detailForms: [        {            pageId: 'product-detail',            inputs: [                {                    blockId: 'product-form',                    field: 'featuredProductId',                    component: ProductSelectorComponent,                },                {                    blockId: 'product-form',                    field: 'relatedCustomerIds',                    component: ActiveCustomerSelectorComponent,                },            ],        },        {            pageId: 'collection-detail',            inputs: [                {                    blockId: 'collection-form',                    field: 'featuredImageId',                    component: ImageSelectorComponent,                },                {                    blockId: 'collection-form',                    field: 'featuredReviewId',                    component: ReviewSelectorComponent,                },            ],        },    ],});
```

## Built-in Configurations​


[​](#built-in-configurations)The relation selector package includes pre-configured setups for common Vendure entities:

```
import {    productRelationConfig,    customerRelationConfig,    collectionRelationConfig,    SingleRelationInput,    MultiRelationInput,    CustomFormComponentInputProps,} from '@vendure/dashboard';// Use pre-built configurationsexport function QuickProductSelector({ value, onChange }: CustomFormComponentInputProps) {    return <SingleRelationInput value={value} onChange={onChange} config={productRelationConfig} />;}export function QuickCustomerMultiSelector({ value, onChange }: CustomFormComponentInputProps) {    return <MultiRelationInput value={value || []} onChange={onChange} config={customerRelationConfig} />;}
```

## Best Practices​


[​](#best-practices)
### Query Optimization​


[​](#query-optimization)- Select only needed fields: Include only the fields you actually use to improve performance
- Use fragments: Create reusable fragments for consistent data fetching
- Optimize search filters: Use database indexes for the fields you search on

```
// Good: Minimal required fieldsconst productListQuery = graphql(`    query GetProductsForSelection($options: ProductListOptions) {        products(options: $options) {            items {                id                name                # Only include what you need            }            totalItems        }    }`);// Avoid: Over-fetching unnecessary dataconst productListQuery = graphql(`    query GetProductsForSelection($options: ProductListOptions) {        products(options: $options) {            items {                id                name                description                featuredAsset { ... } # Only if you display it                variants { ... }      # Usually not needed for selection                # etc.            }            totalItems        }    }`);

```

### Performance Tips​


[​](#performance-tips)- Appropriate page sizes: Balance between fewer requests and faster initial loads
- Debounced search: The default 300ms debounce prevents excessive API calls
- Caching: Queries are automatically cached by TanStack Query

```
const config = createRelationSelectorConfig({    listQuery: myQuery,    idKey: 'id',    labelKey: 'name',    pageSize: 25, // Good default, adjust based on your data    buildSearchFilter: (term: string) => ({        // Use indexed fields for better performance        name: { contains: term },    }),});
```

### Type Safety​


[​](#type-safety)Leverage TypeScript generics for full type safety:

```
interface MyEntity {    id: string;    title: string;    status: 'ACTIVE' | 'INACTIVE';}const myEntityConfig = createRelationSelectorConfig<MyEntity>({    listQuery: myEntityQuery,    idKey: 'id', // ✅ TypeScript knows this must be a key of MyEntity    labelKey: 'title', // ✅ TypeScript validates this field exists    buildSearchFilter: (term: string) => ({        title: { contains: term }, // ✅ Auto-completion and validation    }),});
```

### Rich Label Design​


[​](#rich-label-design)When using the label prop for custom rendering:

- Keep it simple: Avoid overly complex layouts that might impact performance
- Handle missing data: Always check for optional fields before rendering
- Maintain accessibility: Use proper semantic HTML and alt text for images
- Consider mobile: Ensure labels work well on smaller screens

```
// Good: Simple, robust label designlabel: item => (    <div className="flex items-center gap-2">        {item.image && <img src={item.image} alt={item.name} className="w-8 h-8 rounded object-cover" />}        <div className="flex-1 min-w-0">            <div className="font-medium truncate">{item.name}</div>            {item.status && <div className="text-sm text-muted-foreground">{item.status}</div>}        </div>    </div>);// Avoid: Overly complex layoutslabel: item => (    <div className="complex-grid-layout-with-many-nested-elements">        {/* Too much complexity can hurt performance */}    </div>);
```

## Troubleshooting​


[​](#troubleshooting)
### Common Issues​


[​](#common-issues)1. "Cannot query field X on type Query"

```
Error: Cannot query field "myEntities" on type "Query"
```

Solution: Ensure your GraphQL query field name matches your schema definition exactly.

2. Empty results despite data existing

```
// Problem: Wrong field used for searchbuildSearchFilter: (term: string) => ({    wrongField: { contains: term }, // This field doesn't exist});// Solution: Use correct field namesbuildSearchFilter: (term: string) => ({    name: { contains: term }, // Correct field name});
```

3. TypeScript errors with config

```
// Problem: Missing type parameterconst config = createRelationSelectorConfig({    // TypeScript can't infer the entity type});// Solution: Provide explicit type or use proper typingconst config = createRelationSelectorConfig<MyEntityType>({    // Now TypeScript knows the shape of your entity});
```

### Performance Issues​


[​](#performance-issues)If you experience slow loading:

- Check your GraphQL query: Ensure it's optimized and uses appropriate filters
- Verify database indexes: Make sure searched fields are indexed
- Adjust page size: Try smaller page sizes for faster initial loads
- Optimize buildSearchFilter: Use efficient query patterns

```
// Efficient search filterbuildSearchFilter: (term: string) => ({    name: { contains: term }, // Simple, indexed field});// Less efficientbuildSearchFilter: (term: string) => ({    or: [        { name: { contains: term } },        { description: { contains: term } },        { deepNestedField: { someComplexFilter: term } }, // Avoid deep nesting    ],});
```


# Navigation


The dashboard provides a flexible navigation system that allows you to add custom navigation sections and menu items. Navigation items are organized into sections that can be placed in either the "Platform" (top) or "Administration" (bottom) areas of the sidebar.

## Adding Navigation Items to Existing Sections​


[​](#adding-navigation-items-to-existing-sections)The simplest way to add navigation is to add menu items to existing sections. This is done automatically when you define routes with navMenuItem properties.

```
import { defineDashboardExtension } from '@vendure/dashboard';defineDashboardExtension({    routes: [        {            path: '/my-custom-page',            component: () => <div>My Custom Page</div>,            navMenuItem: {                // The section where this item should appear                sectionId: 'catalog',                // Unique identifier for this menu item                id: 'my-custom-page',                // Display text in the navigation                title: 'My Custom Page',                // Optional: URL if different from path                url: '/my-custom-page',            },        },    ],});
```

### Available Section IDs​


[​](#available-section-ids)The dashboard comes with several built-in sections:

- catalog - For product-related functionality
- orders - For order management
- customers - For customer management
- marketing - For promotions and marketing tools
- settings - For configuration and admin settings

### Finding Section IDs & Ordering​


[​](#finding-section-ids--ordering)You can find the available IDs & their order value for all navigation sections and items using Dev mode:

[Dev mode](/guides/extending-the-dashboard/extending-overview/#dev-mode)
## Creating Custom Navigation Sections​


[​](#creating-custom-navigation-sections)You can create entirely new navigation sections with their own icons and ordering:

```
import { defineDashboardExtension } from '@vendure/dashboard';import { FileTextIcon, SettingsIcon } from 'lucide-react';defineDashboardExtension({    // Define custom navigation sections    navSections: [        {            id: 'content-management',            title: 'Content',            icon: FileTextIcon,            placement: 'top', // Platform area            order: 350, // After Customers (400), before Marketing (500)        },        {            id: 'integrations',            title: 'Integrations',            icon: SettingsIcon,            placement: 'bottom', // Administration area            order: 150, // Between System (100) and Settings (200)        },    ],    routes: [        {            path: '/articles',            component: () => <div>Articles</div>,            navMenuItem: {                sectionId: 'content-management', // Use our custom section                id: 'articles',                title: 'Articles',            },        },        {            path: '/pages',            component: () => <div>Pages</div>,            navMenuItem: {                sectionId: 'content-management',                id: 'pages',                title: 'Pages',            },        },    ],});
```

For documentation on all the configuration properties available, see the reference docs:

- DashboardNavSectionDefinition
- NavMenuItem

[DashboardNavSectionDefinition](/reference/dashboard/extensions-api/navigation#dashboardnavsectiondefinition)[NavMenuItem](/reference/dashboard/extensions-api/navigation#navmenuitem)
## Section Placement and Ordering​


[​](#section-placement-and-ordering)The navigation sidebar is divided into two areas:

- Top Placement ('top'): The "Platform" area for core functionality (Dashboard, Catalog, Sales, etc.)
- Bottom Placement ('bottom'): The "Administration" area for system and configuration sections (System, Settings)

### Placement Examples​


[​](#placement-examples)
```
defineDashboardExtension({    navSections: [        {            id: 'reports',            title: 'Reports',            icon: BarChartIcon,            placement: 'top', // Appears in Platform area            order: 150, // Positioned within top sections        },        {            id: 'integrations',            title: 'Integrations',            icon: PlugIcon,            placement: 'bottom', // Appears in Administration area            order: 150, // Positioned within bottom sections        },    ],});
```

### Order Scoping​


[​](#order-scoping)Order values are scoped within each placement area. This means:

- Top sections compete only with other top sections for positioning
- Bottom sections compete only with other bottom sections for positioning
- You can use the same order value in both top and bottom without conflict

### Default Section Orders​


[​](#default-section-orders)Top Placement (Platform):

- Dashboard: 100
- Catalog: 200
- Sales: 300
- Customers: 400
- Marketing: 500

Bottom Placement (Administration):

- System: 100
- Settings: 200

This means if you want to add a section between Catalog and Sales in the top area, you might use order: 250. If you want to add a section before Settings in the bottom area, you could use order: 150.

If you don't specify a placement, sections default to 'top' placement.

## Unauthenticated Routes​


[​](#unauthenticated-routes)By default, all navigation is assumed to be for authenticated routes, i.e. the routes are only accessible to administrators
who are logged in.

Sometimes you want to make a certain route accessible to unauthenticated users. For example, you may want to implement
a completely custom login page or a password recovery page, which must be accessible to everyone.

This is done by setting authenticated: false in your route definition:

```
import { defineDashboardExtension } from '@vendure/dashboard';defineDashboardExtension({    routes: [        {            path: '/public',            component: () => (                <div className="flex h-screen items-center justify-center text-2xl">This is a public page!</div>            ),            authenticated: false        },    ]});
```

This page will then be accessible to all users at http://localhost:4873/dashboard/public

## Complete Example​


[​](#complete-example)Here's a comprehensive example showing how to create a complete navigation structure for a content management system:

```
import { defineDashboardExtension } from '@vendure/dashboard';import { FileTextIcon, ImageIcon, TagIcon, FolderIcon, SettingsIcon } from 'lucide-react';defineDashboardExtension({    // Create custom navigation sections    navSections: [        {            id: 'content',            title: 'Content',            icon: FileTextIcon,            placement: 'top', // Platform area            order: 250, // Between Catalog (200) and Sales (300)        },        {            id: 'media',            title: 'Media',            icon: ImageIcon,            placement: 'top', // Platform area            order: 275, // After Content section        },    ],    routes: [        // Content section items        {            path: '/articles',            component: () => <div>Articles List</div>,            navMenuItem: {                sectionId: 'content',                id: 'articles',                title: 'Articles',            },        },        {            path: '/pages',            component: () => <div>Pages List</div>,            navMenuItem: {                sectionId: 'content',                id: 'pages',                title: 'Pages',            },        },        {            path: '/categories',            component: () => <div>Categories List</div>,            navMenuItem: {                sectionId: 'content',                id: 'categories',                title: 'Categories',            },        },        // Media section items        {            path: '/media-library',            component: () => <div>Media Library</div>,            navMenuItem: {                sectionId: 'media',                id: 'media-library',                title: 'Library',            },        },        {            path: '/media-folders',            component: () => <div>Media Folders</div>,            navMenuItem: {                sectionId: 'media',                id: 'media-folders',                title: 'Folders',            },        },        // Add to existing settings section        {            path: '/cms-settings',            component: () => <div>CMS Settings</div>,            navMenuItem: {                sectionId: 'settings',                id: 'cms-settings',                title: 'CMS Settings',            },        },    ],});
```

## Icons​


[​](#icons)The dashboard uses Lucide React icons. You can import any icon from the library:

[Lucide React](https://lucide.dev/)
```
import {    HomeIcon,    ShoppingCartIcon,    UsersIcon,    SettingsIcon,    FileTextIcon,    ImageIcon,    BarChartIcon,    // ... any other Lucide icon} from 'lucide-react';
```

Common icons for navigation sections:

- Content: FileTextIcon, EditIcon, BookOpenIcon
- Media: ImageIcon, FolderIcon, UploadIcon
- Analytics: BarChartIcon, TrendingUpIcon, PieChartIcon
- Tools: WrenchIcon, SettingsIcon, CogIcon
- Integrations: LinkIcon, ZapIcon, PlugIcon

## Best Practices​


[​](#best-practices)- Use descriptive section names: Choose clear, concise names that indicate the section's purpose
- Group related functionality: Keep logically related menu items in the same section
- Choose appropriate icons: Select icons that clearly represent the section's function
- Consider ordering carefully: Place frequently used sections earlier in the navigation
- Keep section counts reasonable: Avoid creating too many sections as it can clutter the navigation
- Use consistent naming: Follow consistent patterns for menu item names within sections


---

# Alerts


Alerts allow you to display important information to the administrators who use the Dashboard. They can be used to notify users about
pending tasks, system status, or any conditions that require attention.

This API is further documented in the DashboardAlertDefinition API reference

[DashboardAlertDefinition API reference](/reference/dashboard/extensions-api/alerts)
## Creating a Custom Alert​


[​](#creating-a-custom-alert)To create a custom alert, you need to define a DashboardAlertDefinition object and register it with the Dashboard.

### Example: Pending Search Index Updates Alert​


[​](#example-pending-search-index-updates-alert)Let's take the built-in "pending search index updates" as an example, since it demonstrates many features you'll also use
in your own custom alerts.

```
import { graphql } from '@/gql';import { api, DashboardAlertDefinition } from '@vendure/dashboard';import { toast } from 'sonner';const pendingSearchIndexUpdatesDocument = graphql(`    query GetPendingSearchIndexUpdates {        pendingSearchIndexUpdates    }`);export const runPendingSearchIndexUpdatesDocument = graphql(`    mutation RunPendingSearchIndexUpdates {        runPendingSearchIndexUpdates {            success        }    }`);export const pendingSearchIndexUpdatesAlert: DashboardAlertDefinition<number> = {    id: 'pending-search-index-updates',    // The `check` function is called periodically based on the `recheckInterval`.    // It will typically do something like checking an API for data. The result    // of this function is then used to decide whether an alert needs to be    // displayed.    check: async () => {        const data = await api.query(pendingSearchIndexUpdatesDocument);        return data.pendingSearchIndexUpdates;    },    recheckInterval: 10_000,    // Determines whether to display the alert. In our case, we want to display    // and alert if there are one or more pendingSearchIndexUpdates    shouldShow: data => data > 0,    title: data => `${data} pending search index updates`,    description: 'Runs all pending search index updates',    // The severity (info, warning, error) can be a static string, or can    // be dynamically set based on the data returned by the `check` function.    severity: data => (data < 10 ? 'info' : 'warning'),    // Actions allow the administrator to take some action based on the    // alert.    actions: [        {            label: `Run pending updates`,            onClick: async ({ dismiss }) => {                await api.mutate(runPendingSearchIndexUpdatesDocument, {});                toast.success('Running pending search index updates');                // Calling this function will immediately dismiss                // the alert.                dismiss();            },        },    ],};
```

This alert is the registered in your dashboard extensions extry point:

```
import { defineDashboardExtension } from '@vendure/dashboard';import { pendingSearchIndexUpdatesAlert } from './pending-updates-alert';defineDashboardExtension({    alerts: [pendingSearchIndexUpdatesAlert],});
```


---

# Data Fetching


## API Client​


[​](#api-client)The API client is the primary way to send queries and mutations to the Vendure backend. It handles channel tokens and authentication automatically.

### Importing the API Client​


[​](#importing-the-api-client)
```
import { api } from '@vendure/dashboard';
```

The API client exposes two main methods:

- query - For GraphQL queries
- mutate - For GraphQL mutations

### Using with TanStack Query​


[​](#using-with-tanstack-query)The API client is designed to work seamlessly with TanStack Query for optimal data fetching and caching:

#### Query Example​


[​](#query-example)
```
import { useQuery } from '@tanstack/react-query';import { api } from '@vendure/dashboard';import { graphql } from '@/gql';const getProductsQuery = graphql(`    query GetProducts($options: ProductListOptions) {        products(options: $options) {            items {                id                name                slug            }            totalItems        }    }`);function ProductList() {    const { data, isLoading, error } = useQuery({        queryKey: ['products'],        queryFn: () =>            api.query(getProductsQuery, {                options: {                    take: 10,                    skip: 0,                },            }),    });    if (isLoading) return <div>Loading...</div>;    if (error) return <div>Error: {error.message}</div>;    return <ul>{data?.products.items.map(product => <li key={product.id}>{product.name}</li>)}</ul>;}
```

#### Mutation Example​


[​](#mutation-example)
```
import { useMutation, useQueryClient } from '@tanstack/react-query';import { api } from '@vendure/dashboard';import { graphql } from '@/gql';import { toast } from 'sonner';const updateProductMutation = graphql(`    mutation UpdateProduct($input: UpdateProductInput!) {        updateProduct(input: $input) {            id            name            slug        }    }`);function ProductForm({ product }) {    const queryClient = useQueryClient();    const mutation = useMutation({        mutationFn: input => api.mutate(updateProductMutation, { input }),        onSuccess: () => {            // Invalidate and refetch product queries            queryClient.invalidateQueries({ queryKey: ['products'] });            toast.success('Product updated successfully');        },        onError: error => {            toast.error('Failed to update product', {                description: error.message,            });        },    });    const handleSubmit = data => {        mutation.mutate({            id: product.id,            ...data,        });    };    return (        // Form implementation        <form onSubmit={handleSubmit}>{/* Form fields */}</form>    );}
```

## Type Safety​


[​](#type-safety)The Dashboard Vite plugin incorporates gql.tada, which gives you type safety without any code generation step!

[gql.tada](https://gql-tada.0no.co/)It works by analyzing your Admin API schema (including all your custom fields and other API extensions), and outputs the results
to a file - by default you can find it at src/gql/graphql-env.d.ts.

When you then use the import { graphql } from '@/gql' function to define your queries and mutations, you get automatic
type safety when using the results in your components!

When you have the @/gql path mapping correctly set up as per the getting started guide, you should see that
your IDE is able to infer the TypeScript type of your queries and mutations, including the correct inputs and return
types!

[set up as per the getting started guide](/guides/extending-the-dashboard/getting-started/#installation--setup)


---

# Dashboard Theming


The Vendure dashboard uses a modern theming system based on CSS custom properties and Tailwind CSS . This guide shows you how to customize the colors and styles by modifying the theme variables in the Vite plugin.

[Tailwind CSS](https://tailwindcss.com/)The dashboard also uses the same theming methodology as shadcn/ui

[shadcn/ui](https://ui.shadcn.com/docs/theming)It also uses the shadcn theme provider implementation for Vite

[shadcn theme provider implementation](https://ui.shadcn.com/docs/dark-mode/vite)
## Using Themes in Your Components​


[​](#using-themes-in-your-components)The Vendure dashboard provides a simple way to access theme variables in your components. Here's how to use them:

### Using Tailwind Classes​


[​](#using-tailwind-classes)The easiest way to use theme colors is through Tailwind variable CSS classes:

```
function ProductIdWidgetComponent() {    return (        <div className="text-sm">            <p>                This is a custom widget for the product:                <strong className="ml-1 text-foreground">{product.name}</strong>            </p>            <p className="mt-2 text-muted-foreground">Product ID: {product.id}</p>        </div>    );}
```

## Customizing Theme Colors​


[​](#customizing-theme-colors)You can customize the dashboard theme colors by modifying the theme configuration in your vite.config.mts file. Here's an example showing how to change the primary brand colors:

```
// vite.config.mtsimport { vendureDashboardPlugin } from "@vendure/dashboard/plugin";import { defineConfig } from "vite";// ...other importsexport default defineConfig({  plugins: [    vendureDashboardPlugin({      vendureConfigPath: "./src/vendure-config.ts",      adminUiConfig: { apiHost: "http://localhost", apiPort: 3000 },      gqlOutputPath: "./src/gql",      // Theme section      theme: {        light: {          // Change the primary brand color to blue          primary: "oklch(0.55 0.18 240)",          "primary-foreground": "oklch(0.98 0.01 240)",                    // Update the brand colors to match          brand: "#2563eb", // Blue-600          "brand-lighter": "#93c5fd", // Blue-300        },        dark: {          // Corresponding dark mode colors          primary: "oklch(0.65 0.16 240)",          "primary-foreground": "oklch(0.12 0.03 240)",                    // Same brand colors work for both themes          brand: "#2563eb",          "brand-lighter": "#93c5fd",        },      },    }),  ],});
```

## Inspecting element colors in the browser​


[​](#inspecting-element-colors-in-the-browser)To identify the exact color values used by dashboard elements, you can use your browser's developer tools:

- Right-click on any element and select "Inspect" to open the developer panel.
- Navigate to the Styles tab.
- From there, you can examine the CSS properties and see the actual color values (hex codes, RGB values, or CSS custom properties) being applied to that element.

## Available Theme Variables​


[​](#available-theme-variables)The dashboard defines comprehensive theme variables that are automatically available as Tailwind classes:

### Core Colors​


[​](#core-colors)
### Interactive Colors​


[​](#interactive-colors)
### Semantic Colors​


[​](#semantic-colors)
### Border and Input Colors​


[​](#border-and-input-colors)
### Chart Colors​


[​](#chart-colors)
### Sidebar Colors​


[​](#sidebar-colors)
### Brand Colors​


[​](#brand-colors)
### Typography​


[​](#typography)
### Border Radius​


[​](#border-radius)

---

# Localization


Support for localization of Dashboard extensions was added in v3.5.1

The Dashboard uses Lingui, which provides a powerful i18n solution for React:

[Lingui](https://lingui.dev/)- ICU MessageFormat support
- Automatic message extraction
- TypeScript integration
- Pluralization support
- Compile-time optimization

## Wrap your strings​


[​](#wrap-your-strings)First you'll need to wrap any strings that need to be localized:

```
import { Trans, useLingui } from '@lingui/react/macro';function MyComponent() {    const { t } = useLingui();    return (        <div>            <h1>                <Trans>Welcome to Dashboard</Trans>            </h1>            <p>{t`Click here to continue`}</p>        </div>    );}
```

You will mainly make use of the Trans component
and the useLingui hook.

[Trans component](https://lingui.dev/ref/react#trans)[useLingui hook](https://lingui.dev/ref/react#uselingui)
## Extract translations​


[​](#extract-translations)Create a lingui.config.js file in your project root, with references to any plugins that need to be localized:

```
import { defineConfig } from '@lingui/cli';export default defineConfig({    sourceLocale: 'en',    // Add any locales you wish to support    locales: ['en', 'de'],    catalogs: [        // For each plugin you want to localize, add a catalog entry        {            // This is the output location of the generated .po files            path: '<rootDir>/src/plugins/reviews/dashboard/i18n/{locale}',            // This is the pattern that tells Lingui which files to scan            // to extract translation strings            include: ['<rootDir>/src/plugins/reviews/dashboard/**'],        },    ],});
```

Then extract the translations:

```
npx lingui extract
```

This will output the given locale files in the directories specified in the config file above.
In this case:

```
src/└── plugins/    └── reviews/        └── dashboard/            └── i18n/                ├── en.po                └── de.po
```

Since we set the "sourceLocale" to be "en", the en.po file will already be complete. You'll then need to
open up the de.po file and add German translations for each of the strings, by filling out the empty msgstr values:

```
#: test-plugins/reviews/dashboard/review-list.tsx:51msgid "Welcome to Dashboard"msgstr "Willkommen zum Dashboard"
```


---

# Deployment


The Vendure Dashboard offers flexible deployment options. You can either serve it directly through your Vendure Server using the DashboardPlugin, or host it independently as a static site.

## Deployment Options​


[​](#deployment-options)
### Option 1: Serve with DashboardPlugin​


[​](#option-1-serve-with-dashboardplugin)The DashboardPlugin integrates seamlessly with your Vendure Server by:

- Serving the React dashboard as static files
- Handling routing for the dashboard UI
- Providing a unified deployment experience

### Option 2: Standalone Hosting​


[​](#option-2-standalone-hosting)The Vendure Dashboard can be hosted independently as a static site, since the build produces standard web assets (index.html, CSS, and JS files). This approach offers maximum flexibility for deployment on any static hosting service.

## Serving with DashboardPlugin​


[​](#serving-with-dashboardplugin)To configure the DashboardPlugin, follow these steps:

### 1. Configure Vite Base Path​


[​](#1-configure-vite-base-path)Update your vite.config.mts to set the base path where the dashboard will be served:

```
import { vendureDashboardPlugin } from '@vendure/dashboard/vite';import path from 'path';import { pathToFileURL } from 'url';import { defineConfig } from 'vite';export default defineConfig({    base: '/dashboard/',    plugins: [        vendureDashboardPlugin({            vendureConfigPath: pathToFileURL('./src/vendure-config.ts'),            api: {                host: 'http://localhost',                port: 3000,            },            gqlOutputPath: path.resolve(__dirname, './src/gql/'),        }),    ],});
```

### 2. Add DashboardPlugin to Vendure Config​


[​](#2-add-dashboardplugin-to-vendure-config)If you want to use the Angular Admin UI and the Dashboard together, both plugins can now be used simultaneously without any special configuration.

Add the DashboardPlugin to your vendure-config.ts:

```
import { DashboardPlugin } from '@vendure/dashboard/plugin';import path from 'path';export const config: VendureConfig = {    // ... other config    plugins: [        // ... other plugins        DashboardPlugin.init({            // Important: This must match the base path from vite.config.mts (without slashes)            route: 'dashboard',            // Path to the Vite build output directory            appDir: path.join(__dirname, './dist'),        }),    ],};
```

## Building for Production​


[​](#building-for-production)Before deploying your Vendure application, build the dashboard:

```
npx vite build
```

This command creates optimized production files in the dist directory that the DashboardPlugin will serve.

## Accessing the Dashboard​


[​](#accessing-the-dashboard)Once configured and built, your dashboard will be accessible at:

```
http://your-server-url/dashboard/
```

## Configuration Options​


[​](#configuration-options)
### DashboardPlugin Options​


[​](#dashboardplugin-options)
## Best Practices​


[​](#best-practices)- Consistent Paths: Always ensure the route in DashboardPlugin matches the base in your Vite config
- Build Before Deploy: Add the Vite build step to your deployment pipeline
- Production Builds: Use npx vite build for optimized production builds

## Example Deployment Script​


[​](#example-deployment-script)
```
{    "scripts": {        "build": "npm run build:server && npm run build:dashboard",        "build:server": "tsc",        "build:dashboard": "vite build",        "start:prod": "node ./dist/index.js"    }}
```

## Standalone Hosting​


[​](#standalone-hosting)The dashboard can be hosted independently from your Vendure Server on any static hosting service (Netlify, Vercel, AWS S3, etc.).

### Configuration​


[​](#configuration)When hosting standalone, you must configure the dashboard to connect to your Admin API endpoint:

```
import { vendureDashboardPlugin } from '@vendure/dashboard/vite';import { defineConfig } from 'vite';export default defineConfig({    plugins: [        vendureDashboardPlugin({            vendureConfigPath: pathToFileURL('./src/vendure-config.ts'),            api: {                host: process.env.VENDURE_API_HOST || 'https://api.mystore.com',                port: parseInt(process.env.VENDURE_API_PORT || '443'),            },            gqlOutputPath: path.resolve(__dirname, './src/gql/'),        }),    ],});
```

Environment variables are resolved at build time and embedded as static strings in the final bundles. Ensure these variables are available during the build process, not just at runtime.

### Build and Deploy​


[​](#build-and-deploy)- Build the dashboard:
npx vite build
- Deploy the contents of the dist directory to your hosting service

Build the dashboard:

```
npx vite build
```

Deploy the contents of the dist directory to your hosting service

### CORS Configuration​


[​](#cors-configuration)When hosting the dashboard separately, configure CORS on your Vendure Server:

```
export const config: VendureConfig = {    apiOptions: {        cors: {            origin: ['https://dashboard.mystore.com'],            credentials: true,        },    },    // ... other config};
```

## Troubleshooting​


[​](#troubleshooting)
### Dashboard Not Loading (DashboardPlugin)​


[​](#dashboard-not-loading-dashboardplugin)- Verify the route matches the base path in Vite config
- Check that the build output exists in the specified appDir
- Ensure the DashboardPlugin is properly initialized in your plugins array

### 404 Errors on Dashboard Routes​


[​](#404-errors-on-dashboard-routes)- Confirm the base path includes trailing slashes where needed
- Verify the server is running and the plugin is loaded

### Connection Issues (Standalone)​


[​](#connection-issues-standalone)- Verify the API host and port are correct
- Check CORS configuration on your Vendure Server
- Ensure environment variables were available during build

---

# Tech Stack


The Vendure Dashboard is built on a modern stack of technologies that provide a great developer experience and powerful capabilities for building custom extensions.

## Core Technologies​


[​](#core-technologies)
### React 19​


[​](#react-19)The dashboard is built with React 19, giving you access to all the latest React features including:

[React 19](https://react.dev/)- React Compiler optimizations
- Improved concurrent features
- Actions and form handling improvements
- Enhanced automatic batching
- Better TypeScript support
- New hooks like useOptimistic and useFormStatus

```
import { useOptimistic, useFormStatus } from 'react';function OptimisticUpdateExample() {    const [optimisticState, addOptimistic] = useOptimistic(state, (currentState, optimisticValue) => {        // Return new state with optimistic update        return [...currentState, optimisticValue];    });    return (        <div>            {optimisticState.map(item => (                <div key={item.id}>{item.name}</div>            ))}        </div>    );}function SubmitButton() {    const { pending } = useFormStatus();    return (        <button type="submit" disabled={pending}>            {pending ? 'Saving...' : 'Save'}        </button>    );}
```

### TypeScript​


[​](#typescript)Full TypeScript support throughout the dashboard provides:

[TypeScript](https://www.typescriptlang.org/)- Type safety for your custom components
- IntelliSense and autocomplete in your IDE
- Compile-time error checking
- Generated types from your GraphQL schema

### Vite 6​


[​](#vite-6)Vite 6 powers the development experience with:

[Vite 6](https://vite.dev/)- Lightning-fast hot module replacement (HMR)
- Optimized build process with Rollup 4
- Modern ES modules support
- Rich plugin ecosystem
- Environment API for better multi-environment support

## UI Framework​


[​](#ui-framework)
### Tailwind CSS v4​


[​](#tailwind-css-v4)The dashboard uses Tailwind CSS v4 for styling:

[Tailwind CSS v4](https://tailwindcss.com/)- Utility-first CSS framework
- Improved performance with Rust-based engine
- Enhanced CSS-first configuration
- Responsive design system
- Built-in dark mode support
- Customizable design tokens

```
// Example using Tailwind classesfunction MyComponent() {    return (        <div className="p-4 bg-white dark:bg-gray-800 rounded-lg shadow-md">            <h2 className="text-lg font-semibold text-gray-900 dark:text-white">My Custom Component</h2>        </div>    );}
```

### Shadcn/ui​


[​](#shadcnui)Built on top of Radix UI primitives, Shadcn/ui provides:

[Radix UI](https://www.radix-ui.com/)[Shadcn/ui](https://ui.shadcn.com/)- Accessible components out of the box
- Consistent design system
- Customizable component library
- Copy-and-paste component approach

```
import { Button, Input, Card } from '@vendure/dashboard';function MyForm() {    return (        <Card className="p-6">            <Input placeholder="Enter your text" />            <Button className="mt-4">Submit</Button>        </Card>    );}
```

## Data Layer: TanStack Query​


[​](#data-layer-tanstack-query)TanStack Query v5 handles all data fetching and server state management:

[TanStack Query](https://tanstack.com/query)- Automatic caching and synchronization
- Background updates
- Optimistic updates
- Error handling and retry logic

```
import { useQuery } from '@tanstack/react-query';import { graphql } from '@/gql';const getProductsQuery = graphql(`    query GetProducts {        products {            items {                id                name                slug            }        }    }`);function ProductList() {    const { data, isLoading, error } = useQuery({        queryKey: ['products'],        queryFn: () => client.request(getProductsQuery),    });    if (isLoading) return <div>Loading...</div>;    if (error) return <div>Error: {error.message}</div>;    return (        <ul>            {data.products.items.map(product => (                <li key={product.id}>{product.name}</li>            ))}        </ul>    );}
```

## Routing: TanStack Router​


[​](#routing-tanstack-router)TanStack Router provides type-safe routing with:

[TanStack Router](https://tanstack.com/router)- File-based routing
- 100% type-safe navigation
- Automatic route validation
- Search params handling
- Built-in caching and preloading
- Route-level code splitting

```
import { Link, useNavigate } from '@tanstack/react-router';function Navigation() {    const navigate = useNavigate();    return (        <div>            <Link to="/products">Products</Link>            <button onClick={() => navigate({ to: '/customers' })}>Go to Customers</button>        </div>    );}
```

## Forms: React Hook Form​


[​](#forms-react-hook-form)React Hook Form provides powerful form handling with:

[React Hook Form](https://react-hook-form.com/)- Minimal re-renders
- Built-in validation
- TypeScript support
- Easy integration with UI libraries

```
import { useForm } from 'react-hook-form';import { FormFieldWrapper, Input, Button } from '@vendure/dashboard';interface FormData {    name: string;    email: string;}function MyForm() {    const form = useForm<FormData>();    const onSubmit = (data: FormData) => {        console.log(data);    };    return (        <form onSubmit={form.handleSubmit(onSubmit)}>            <FormFieldWrapper                control={form.control}                name="name"                label="Name"                render={({ field }) => <Input {...field} />}            />            <FormFieldWrapper                control={form.control}                name="email"                label="Email"                render={({ field }) => <Input type="email" {...field} />}            />            <Button type="submit">Submit</Button>        </form>    );}
```

## GraphQL Integration: gql.tada​


[​](#graphql-integration-gqltada)gql.tada provides type-safe GraphQL with:

[gql.tada](https://gql-tada.0no.co/)- Generated TypeScript types
- IntelliSense for queries and mutations
- Compile-time validation
- Schema introspection

```
import { graphql } from '@/gql';import { useMutation } from '@tanstack/react-query';const createProductMutation = graphql(`    mutation CreateProduct($input: CreateProductInput!) {        createProduct(input: $input) {            id            name            slug        }    }`);function CreateProductForm() {    const mutation = useMutation({        mutationFn: (input: CreateProductInput) => client.request(createProductMutation, { input }),    });    // TypeScript knows the exact shape of the input and response    const handleSubmit = (data: CreateProductInput) => {        mutation.mutate(data);    };    return (        // Form implementation        <div>Create Product Form</div>    );}
```

## Notifications: Sonner​


[​](#notifications-sonner)Sonner provides toast notifications with:

[Sonner](https://sonner.emilkowal.ski/)- Beautiful animations
- Customizable appearance
- Promise-based notifications
- Stacking support

```
import { toast } from 'sonner';function MyComponent() {    const handleSave = async () => {        try {            await saveData();            toast.success('Data saved successfully!');        } catch (error) {            toast.error('Failed to save data', {                description: error.message,            });        }    };    // Promise-based toasts    const handleAsyncAction = () => {        toast.promise(performAsyncAction(), {            loading: 'Saving...',            success: 'Saved successfully!',            error: 'Failed to save',        });    };    return (        <div>            <button onClick={handleSave}>Save</button>            <button onClick={handleAsyncAction}>Async Save</button>        </div>    );}
```

## Icons: Lucide React​


[​](#icons-lucide-react)Lucide React provides beautiful, customizable icons:

[Lucide React](https://lucide.dev/)- Consistent design
- Tree-shakeable
- Customizable size and color
- Accessible by default

```
import { ShoppingCartIcon, UserIcon, SettingsIcon } from 'lucide-react';function Navigation() {    return (        <nav className="flex space-x-4">            <a href="/products" className="flex items-center">                <ShoppingCartIcon className="mr-2 h-4 w-4" />                Products            </a>            <a href="/customers" className="flex items-center">                <UserIcon className="mr-2 h-4 w-4" />                Customers            </a>            <a href="/settings" className="flex items-center">                <SettingsIcon className="mr-2 h-4 w-4" />                Settings            </a>        </nav>    );}
```

## Animations: Motion​


[​](#animations-motion)Smooth animations powered by Motion (successor to Framer Motion):

[Motion](https://motion.dev/)- High-performance animations
- Declarative API
- Spring-based animations
- Layout animations
- Gesture support

```
import { motion } from 'motion/react';function AnimatedCard({ children }) {    return (        <motion.div            initial={{ opacity: 0, y: 20 }}            animate={{ opacity: 1, y: 0 }}            exit={{ opacity: 0, y: -20 }}            className="bg-white p-6 rounded-lg shadow"        >            {children}        </motion.div>    );}
```

## Internationalization: Lingui​


[​](#internationalization-lingui)Lingui provides a powerful i18n solution for React:

[Lingui](https://lingui.dev/)- ICU MessageFormat support
- Automatic message extraction
- TypeScript integration
- Pluralization support
- Compile-time optimization

```
import { Trans, useLingui } from '@lingui/react/macro';function MyComponent() {    const { t } = useLingui();    return (        <div>            <h1>                <Trans>Welcome to Dashboard</Trans>            </h1>            <p>{t`Click here to continue`}</p>        </div>    );}
```


---

# Migrating from Admin UI


If you have existing extensions to the legacy Angular-based Admin UI, you will want to migrate to the new Dashboard to enjoy
an improved developer experience, many more customization options, and ongoing support from the Vendure team.

The Angular Admin UI will not be maintained after July 2026. Until then, we will continue patching critical bugs and security issues.
Community contributions will always be merged and released.

## Running In Parallel​


[​](#running-in-parallel)A recommended approach to migrating is to run both the Admin UI and the new Dashboard in parallel. This allows you to start building
new features right away with the new Dashboard while maintaining access to existing features that have not yet been migrated.

To do so, follow the instructions to set up the Dashboard.
Both plugins can now be used simultaneously without any special configuration.

[set up the Dashboard](/guides/extending-the-dashboard/getting-started/#installation--setup)
## AI-Assisted Migration​


[​](#ai-assisted-migration)We highly recommend using AI tools such as Claude Code, Codex etc to assist with migrations from the legacy Angular-based UI extensions
to the new React-based Dashboard.

The results of AI-assisted migration are heavily dependent on the model that you use. We tested with
Claude Code using Sonnet 4.5 & Codex using gpt-5-codex

In our testing, we were able to perform complete migrations quickly using the following approach:

- Use the provided prompt or Claude skill and specify which plugin you wish to migrate (do 1 at a time)
- Allow the AI tool to complete the migration
- Manually clean up & fix any issues that remain

Using this approach we were able to migrate complete plugins involving list/details views, widgets, and custom field components
in around 20-30 minutes.

### Full Prompt​


[​](#full-prompt)Give a prompt like this to your AI assistant and make sure to specify the plugin by path, i.e.:

```
Migrate the plugin at @src/plugins/my-plugin/ to use the new dashboard.
```

Then paste the following prompt in full:

```
## Instructions1. If not explicitly stated by the user, find out which plugin they want to migrate.2. Read and understand the overall rules for migration    - the "General" section below    - the "Common Tasks" section below3. Check the tsconfig setup <tsconfig-setup>. This may or may not already be set up.    - the "TSConfig setup" section below4. Identify each part of the Admin UI extensions that needs to be   migrated, and use the data from the appropriate sections to guide   the migration:    - the "Forms" section below    - the "Custom Field Inputs" section below    - the "List Pages" section below    - the "Detail Pages" section below    - the "Adding Nav Menu Items" section below    - the "Action Bar Items" section below    - the "Custom Detail Components" section below    - the "Page Tabs" section below    - the "Widgets" section below5. Ensure you have followed the instructions marked "Important" for each section## General- For short we use "old" to refer to code written for the Angular Admin UI, and "new" for the React Dashboard- old code is usually in a plugin's "ui" dir- new code should be in a plugin's "dashboard" dir- new code imports all components from `@vendure/dashboard`. It can also import the following as needed:    - hooks or anything else needed from `react`    - hooks etc from `@tanstack/react-query`    - `Link`, `useNavigate` etc from `@tanstack/react-router`    - `useForm` etc from `react-hook-form`    - `toast` from `sonner`    - icons from `lucide-react`    - for i18n: `Trans`, `useLingui` from `@lingui/react/macro`- Default to the style conventions of the current project as much as possible (single vs double quotes,  indent size etc)## Directory StructureGiven as an example - projects may differ in conventions### Old```- /path/to/plugin    - /ui        - providers.ts        - routes.ts            - /components                - /example                    - example.component.ts                    - example.component.html                    - example.component.scss                    - example.graphql.ts```### New```- /path/to/plugin    - /dashboard        - index.tsx            - /components                - example.tsx```## Registering extensions### Old```ts title="src/plugins/my-plugin/my.plugin.ts"import * as path from 'path';import { VendurePlugin } from '@vendure/core';import { AdminUiExtension } from '@vendure/ui-devkit/compiler';@VendurePlugin({    // ...})export class MyPlugin {    static ui: AdminUiExtension = {        id: 'my-plugin-ui',        extensionPath: path.join(__dirname, 'ui'),        routes: [{ route: 'my-plugin', filePath: 'routes.ts' }],        providers: ['providers.ts'],    };}```### New```ts title="src/plugins/my-plugin/my.plugin.ts"import { VendurePlugin } from '@vendure/core';@VendurePlugin({    // ...    // Note that this needs to match the relative path to the    // index.tsx file from the plugin file    dashboard: '../dashboard/index.tsx',})export class MyPlugin {    // Do not remove any existing AdminUiExtension def    // to preserve backward compatibility    static ui: AdminUiExtension = { /* ... */ }}```Important:  - Ensure the `dashboard` path is correct relative to the locations of the plugin.ts file and the index.ts file## Styling### Oldcustom design system based on Clarity UI```html<button class="button primary">Primary</button><button class="button secondary">Secondary</button><button class="button success">Success</button><button class="button warning">Warning</button><button class="button danger">Danger</button><button class="button-ghost">Ghost</button><a class="button-ghost" [routerLink]="['/extensions/my-plugin/my-custom-route']">    <clr-icon shape="arrow" dir="right"></clr-icon>    John Smith</a><button class="button-small">Small</button><button class="button-small">    <clr-icon shape="layers"></clr-icon>    Assign to channel</button><clr-icon shape="star" size="8"></clr-icon><img [src]="product.featuredAsset?.preview + '?preset=small'" alt="Product preview" />```### Newtailwind + shadcn/ui. Shadcn components import from `@vendure/dashboard````tsximport { Button, DetailPageButton, VendureImage } from '@vendure/dashboard';import { Star } from 'lucide-react';export function MyComponent() {    // non-exhaustive - all standard Shadcn props are available    return (        <Button variant="default">Primary</Button>        <Button variant="secondary">Secondary</Button>        <Button variant="outline">Outline</Button>        <Button variant="destructive">Danger</Button>        <Button variant="ghost">Ghost</Button>                <DetailPageButton id="123" label="John Smith" />        <DetailPageButton href="/affiliates/my-custom-route" label="John Smith" />                <Star />                <VendureImage            src={entity.product.featuredAsset}            alt={entity.product.name}            preset='small'        />    )} ```Important:  - When using `Badge`, prefer variant="secondary" unless especially important data  - Where possible avoid specific tailwind colours like `text-blue-600`. Instead use (where possible)    the Shadcn theme colours, eg:    ```    --color-background    --color-foreground    --color-primary    --color-primary-foreground    --color-secondary    --color-secondary-foreground    --color-muted    --color-muted-foreground    --color-accent    --color-accent-foreground    --color-destructive    --color-destructive-foreground    --color-success    --color-success-foreground    ```  - Buttons which link to detail pages should use `DetailPageButton`## Data access### Old```tsimport { DataService } from '@vendure/admin-ui/core';import { graphql } from "../gql";    export const GET_CUSTOMER_NAME = graphql(`      query GetCustomerName($id: ID!) {          customer(id: $id) {              id              firstName                        lastName            addresses {              ...AddressFragment            }        }    	}`);this.dataService.query(GET_CUSTOMER_NAME, {      id: customerId,  }),```### New```tsimport { useQuery } from '@tanstack/react-query';  import { api } from '@vendure/dashboard';  import { graphql } from '@/gql';const addressFragment = graphql(`   # ...`);const getCustomerNameDocument = graphql(`      query GetCustomerName($id: ID!) {          customer(id: $id) {              id              firstName                        lastName                          addresses {              ...AddressFragment            }        }    	}`, [addressFragment]);  // Fragments MUST be explicitly referencedconst { data, isLoading, error } = useQuery({  	queryKey: ['customer-name', customerId],  	queryFn: () => api.query(getCustomerNameDocument, { id: customerId }),});```Note on graphql fragments: if common fragments are used across files, you may needto extract them into a common-fragments.graphql.ts file, because with gql.tada they*must* be explicitly referenced in every document that uses them.## Common Tasks### Formatting Dates, Currencies, and Numbers```tsximport {useLocalFormat} from '@vendure/dashboard';// ...// Intl API formatting toolsconst {    formatCurrency,    formatNumber,    formatDate,    formatRelativeDate,    formatLanguageName,    formatRegionName,    formatCurrencyName,    toMajorUnits,    toMinorUnits,} = useLocalFormat();formatCurrency(value: number, currency: string, precision?: number)formatCurrencyName(currencyCode: string, display: 'full' | 'symbol' | 'name' = 'full')formatNumber(value: number) // human-readableformatDate(value: string | Date, options?: Intl.DateTimeFormatOptions)formatRelativeDate(value: string | Date, options?: Intl.RelativeTimeFormatOptions)```### LinksExample link destinations:- Customer detail | <Link to="/customers/$id" params={{ id }}>text</Link>- Customer list | <Link to="/customers">text</Link>- Order detail | <Link to="/orders/$id" params={{ id }}>text</Link>Important: when linking to detail pages, prefer the `DetailPageButton`. If not in a table column,add `className='border'`.## TSConfig setupIf not already set up, we need to make sure we have configured tsconfig with:1. jsx support. Usually create `tsconfig.dashboard.json` like this:    ```json    {      "extends": "./tsconfig.json",      "compilerOptions": {        "composite": true,        "jsx": "react-jsx"      },      "include": [        "src/dashboard/**/*.ts",        "src/dashboard/**/*.tsx"      ]    }    ```   then reference it from the appropriate tsconfig.json    ```    {        // ...etc        "references": [            {                "path": "./tsconfig.dashboard.json"            },        ]    }    ```   This may already be set up (check this). In an Nx-like monorepo   where each plugin is a separate project, this will need to be done   per-plugin.2. Path mapping.    ```json     "paths": {        // Import alias for the GraphQL types, this needs to point to        // the location specified in the vite.config.mts file as `gqlOutputPath`        // so will vary depending on project structure        "@/gql": ["./apps/server/src/gql/graphql.ts"],        // This line allows TypeScript to properly resolve internal        // Vendure Dashboard imports, which is necessary for        // type safety in your dashboard extensions.        // This path assumes a root-level tsconfig.json file.        // You may need to adjust it if your project structure is different.        "@/vdb/*": [          "./node_modules/@vendure/dashboard/src/lib/*"     }     ```   In an Nx-like monorepo, this would be added to the tsconfig.base.json or   equivalent.## Forms### Old (Angular)```html<div class="form-grid">    <vdr-form-field label="Page title">        <input type="text" />    </vdr-form-field>    <vdr-form-field label="Select input">        <select>            <option>Option 1</option>            <option>Option 2</option>        </select>    </vdr-form-field>    <vdr-form-field label="Checkbox input">        <input type="checkbox" />    </vdr-form-field>    <vdr-form-field label="Textarea input">        <textarea></textarea>    </vdr-form-field>    <vdr-form-field label="Invalid with error">        <input type="text" [formControl]="invalidFormControl" />    </vdr-form-field>    <vdr-rich-text-editor        class="form-grid-span"        label="Description"    ></vdr-rich-text-editor></div>```### New (React Dashboard)```tsx<PageBlock column="main" blockId="main-form">    <DetailFormGrid>        <FormFieldWrapper            control={form.control}            name="title"            label="Title"            render={({ field }) => <Input {...field} />}        />        <FormFieldWrapper            control={form.control}            name="slug"            label="Slug"            render={({ field }) => <Input {...field} />}        />    </DetailFormGrid>    <div className="space-y-6">        <FormFieldWrapper            control={form.control}            name="body"            label="Content"            render={({ field }) => (                <RichTextInput value={field.value ?? ''} onChange={field.onChange} />            )}        />    </div></PageBlock>;```## Custom Field Inputs### Old (Angular)```ts title="src/plugins/common/ui/components/slider-form-input/slider-form-input.component.ts"import { Component } from '@angular/core';import { FormControl } from '@angular/forms';import { IntCustomFieldConfig, SharedModule, FormInputComponent } from '@vendure/admin-ui/core';@Component({    template: `        <input            type="range"            [min]="config.min || 0"            [max]="config.max || 100"            [formControl]="formControl" />        {{ formControl.value }}    `,    standalone: true,    imports: [SharedModule],})export class SliderControlComponent implements FormInputComponent<IntCustomFieldConfig> {    readonly: boolean;    config: IntCustomFieldConfig;    formControl: FormControl;}``````ts title="src/plugins/common/ui/providers.ts"import { registerFormInputComponent } from '@vendure/admin-ui/core';import { SliderControlComponent } from './components/slider-form-input/slider-form-input.component';export default [    registerFormInputComponent('slider-form-input', SliderControlComponent),];```### New (React Dashboard)```tsx title="src/plugins/my-plugin/dashboard/components/color-picker.tsx"import { Button, Card, CardContent, cn, DashboardFormComponent, Input } from '@vendure/dashboard';import { useState } from 'react';import { useFormContext } from 'react-hook-form';// By typing your component as DashboardFormComponent, the props will be correctly typedexport const ColorPickerComponent: DashboardFormComponent = ({ value, onChange, name }) => {    const [isOpen, setIsOpen] = useState(false);    const { getFieldState } = useFormContext();    const error = getFieldState(name).error;    const colors = ['#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FECA57', '#FF9FF3', '#54A0FF', '#5F27CD'];    return (        <div className="space-y-2">            <div className="flex items-center space-x-2">                <Button                    type="button"                    variant="outline"                    size="icon"                    className={cn('w-8 h-8 border-2 border-gray-300 p-0', error && 'border-red-500')}                    style={{ backgroundColor: error ? 'transparent' : value || '#ffffff' }}                    onClick={() => setIsOpen(!isOpen)}                />                <Input value={value || ''} onChange={e => onChange(e.target.value)} placeholder="#ffffff" />            </div>            {isOpen && (                <Card>                    <CardContent className="grid grid-cols-4 gap-2 p-2">                        {colors.map(color => (                            <Button                                key={color}                                type="button"                                variant="outline"                                size="icon"                                className="w-8 h-8 border-2 border-gray-300 hover:border-gray-500 p-0"                                style={{ backgroundColor: color }}                                onClick={() => {                                    onChange(color);                                    setIsOpen(false);                                }}                            />                        ))}                    </CardContent>                </Card>            )}        </div>    );};``````tsx title="src/plugins/my-plugin/dashboard/index.tsx"import { defineDashboardExtension } from '@vendure/dashboard';import { ColorPickerComponent } from './components/color-picker';defineDashboardExtension({    customFormComponents: {        // Custom field components for custom fields        customFields: [            {                // The "id" is a global identifier for this custom component. We will                // reference it in the next step.                id: 'color-picker',                component: ColorPickerComponent,            },        ],    },    // ... other extension properties});```## List Pages### Old (Angular)```tsimport { ChangeDetectionStrategy, Component } from '@angular/core';import { TypedBaseListComponent, SharedModule } from '@vendure/admin-ui/core';// This is the TypedDocumentNode generated by GraphQL Code Generatorimport { graphql } from '../../gql';const getReviewListDocument = graphql(`  query GetReviewList($options: ReviewListOptions) {    reviews(options: $options) {      items {        id        createdAt        updatedAt        title        rating        text        authorName        productId      }      totalItems    }  }`);@Component({selector: 'review-list',templateUrl: './review-list.component.html',styleUrls: ['./review-list.component.scss'],changeDetection: ChangeDetectionStrategy.OnPush,standalone: true,imports: [SharedModule],})export class ReviewListComponent extends TypedBaseListComponent<typeof getReviewListDocument, 'reviews'> {    // Here we set up the filters that will be available    // to use in the data table    readonly filters = this.createFilterCollection()        .addIdFilter()        .addDateFilters()        .addFilter({            name: 'title',            type: {kind: 'text'},            label: 'Title',            filterField: 'title',        })        .addFilter({            name: 'rating',            type: {kind: 'number'},            label: 'Rating',            filterField: 'rating',        })        .addFilter({            name: 'authorName',            type: {kind: 'text'},            label: 'Author',            filterField: 'authorName',        })        .connectToRoute(this.route);    // Here we set up the sorting options that will be available    // to use in the data table    readonly sorts = this.createSortCollection()        .defaultSort('createdAt', 'DESC')        .addSort({name: 'createdAt'})        .addSort({name: 'updatedAt'})        .addSort({name: 'title'})        .addSort({name: 'rating'})        .addSort({name: 'authorName'})        .connectToRoute(this.route);    constructor() {        super();        super.configure({            document: getReviewListDocument,            getItems: data => data.reviews,            setVariables: (skip, take) => ({                options: {                    skip,                    take,                    filter: {                        title: {                            contains: this.searchTermControl.value,                        },                        ...this.filters.createFilterInput(),                    },                    sort: this.sorts.createSortInput(),                },            }),            refreshListOnChanges: [this.filters.valueChanges, this.sorts.valueChanges],        });    }}``````html<!-- optional if you want some buttons at the top --><vdr-page-block>    <vdr-action-bar>        <vdr-ab-left></vdr-ab-left>        <vdr-ab-right>            <a class="btn btn-primary" *vdrIfPermissions="['CreateReview']" [routerLink]="['./', 'create']">                <clr-icon shape="plus"></clr-icon>                Create a review            </a>        </vdr-ab-right>    </vdr-action-bar></vdr-page-block><!-- The data table --><vdr-data-table-2        id="review-list"        [items]="items$ | async"        [itemsPerPage]="itemsPerPage$ | async"        [totalItems]="totalItems$ | async"        [currentPage]="currentPage$ | async"        [filters]="filters"        (pageChange)="setPageNumber($event)"        (itemsPerPageChange)="setItemsPerPage($event)">    <!-- optional if you want to support bulk actions -->    <vdr-bulk-action-menu            locationId="review-list"            [hostComponent]="this"            [selectionManager]="selectionManager"    />        <!-- Adds a search bar -->    <vdr-dt2-search            [searchTermControl]="searchTermControl"            searchTermPlaceholder="Filter by title"    />        <!-- Here we define all the available columns -->    <vdr-dt2-column id="id" [heading]="'common.id' | translate" [hiddenByDefault]="true">        <ng-template let-review="item">            {{ review.id }}        </ng-template>    </vdr-dt2-column>    <vdr-dt2-column            id="created-at"            [heading]="'common.created-at' | translate"            [hiddenByDefault]="true"            [sort]="sorts.get('createdAt')"    >        <ng-template let-review="item">            {{ review.createdAt | localeDate : 'short' }}        </ng-template>    </vdr-dt2-column>    <vdr-dt2-column            id="updated-at"            [heading]="'common.updated-at' | translate"            [hiddenByDefault]="true"            [sort]="sorts.get('updatedAt')"    >        <ng-template let-review="item">            {{ review.updatedAt | localeDate : 'short' }}        </ng-template>    </vdr-dt2-column>    <vdr-dt2-column id="title" heading="Title" [optional]="false" [sort]="sorts.get('title')">        <ng-template let-review="item">            <a class="button-ghost" [routerLink]="['./', review.id]"            ><span>{{ review.title }}</span>                <clr-icon shape="arrow right"></clr-icon>            </a>        </ng-template>    </vdr-dt2-column>    <vdr-dt2-column id="rating" heading="Rating" [sort]="sorts.get('rating')">        <ng-template let-review="item"><my-star-rating-component [rating]="review.rating"    /></ng-template>    </vdr-dt2-column>    <vdr-dt2-column id="author" heading="Author" [sort]="sorts.get('authorName')">        <ng-template let-review="item">{{ review.authorName }}</ng-template>    </vdr-dt2-column></vdr-data-table-2>``````tsimport { registerRouteComponent } from '@vendure/admin-ui/core';import { ReviewListComponent } from './components/review-list/review-list.component';export default [    registerRouteComponent({        path: '',        component: ReviewListComponent,        breadcrumb: 'Product reviews',    }),]```### New (React Dashboard)```tsximport {    Button,    DashboardRouteDefinition,    ListPage,    PageActionBarRight,    DetailPageButton,} from '@vendure/dashboard';import { Link } from '@tanstack/react-router';import { PlusIcon } from 'lucide-react';// This function is generated for you by the `vendureDashboardPlugin` in your Vite config.// It uses gql-tada to generate TypeScript types which give you type safety as you write// your queries and mutations.import { graphql } from '@/gql';// The fields you select here will be automatically used to generate the appropriate columns in the// data table below.const getArticleList = graphql(`    query GetArticles($options: ArticleListOptions) {        articles(options: $options) {            items {                id                createdAt                updatedAt                isPublished                title                slug                body                customFields            }            totalItems        }    }`);const deleteArticleDocument = graphql(`    mutation DeleteArticle($id: ID!) {        deleteArticle(id: $id) {            result        }    }`);export const articleList: DashboardRouteDefinition = {    navMenuItem: {        sectionId: 'catalog',        id: 'articles',        url: '/articles',        title: 'CMS Articles',    },    path: '/articles',    loader: () => ({        breadcrumb: 'Articles',    }),    component: route => (        <ListPage            pageId="article-list"            title="Articles"            listQuery={getArticleList}            deleteMutation={deleteArticleDocument}            route={route}            customizeColumns={{                title: {                    cell: ({ row }) => {                        const post = row.original;                        return <DetailPageButton id={post.id} label={post.title} />;                    },                },            }}            defaultVisibility={{                type: true,                summary: true,                state: true,                rating: true,                authorName: true,                authorLocation: true,            }}            defaultColumnOrder={[                'type',                'summary',                'authorName',                'authorLocation',                'rating',            ]}        >            <PageActionBarRight>                <Button asChild>                    <Link to="./new">                        <PlusIcon className="mr-2 h-4 w-4" />                        New article                    </Link>                </Button>            </PageActionBarRight>        </ListPage>    ),};```Important:    - When using `defaultVisibility`, specify the specific visible ones with `true`. *Do not* mix      true and false values. It is implicit that any not specified will default to `false`.    - The `id`, `createdAt` and `updatedAt` never need to be specified in `customizeColumns`, defaultVisibility` or `defaultColumnOrder`.      They are handled correctly by default.    - By default the DataTable will handle column names based on the field name,      e.g. `authorName` -> `Author Name`, `rating` -> `Rating`, so an explicit cell header is      not needed unless the column header title must significantly differ from the field name.    - If a custom `cell` function needs to access fields _other_ than the one being rendered,      those other fields *must* be declared as dependencies:      ```tsx      customizeColumns={{        name: {          // Note, we DO NOT need to declare "name" as a dependency here,          // since we are handling the `name` column already.          meta: { dependencies: ['reviewCount'] },          cell: ({ row }) => {            const { name, reviewCount } = row.original;            return <Badge variant="outline">{name} ({reviewCount})</Badge>          },        },      }}      ```## Detail Pages### Old (Angular)```tsimport { ResultOf } from '@graphql-typed-document-node/core';import { ChangeDetectionStrategy, Component, OnInit, OnDestroy } from '@angular/core';import { FormBuilder } from '@angular/forms';import { TypedBaseDetailComponent, LanguageCode, NotificationService, SharedModule } from '@vendure/admin-ui/core';// This is the TypedDocumentNode & type generated by GraphQL Code Generatorimport { graphql } from '../../gql';export const reviewDetailFragment = graphql(`  fragment ReviewDetail on ProductReview {    id    createdAt    updatedAt    title    rating    text    authorName    productId  }`);export const getReviewDetailDocument = graphql(`  query GetReviewDetail($id: ID!) {    review(id: $id) {      ...ReviewDetail    }  }`);export const createReviewDocument = graphql(`  mutation CreateReview($input: CreateProductReviewInput!) {    createProductReview(input: $input) {      ...ReviewDetail    }  }`);export const updateReviewDocument = graphql(`  mutation UpdateReview($input: UpdateProductReviewInput!) {    updateProductReview(input: $input) {      ...ReviewDetail    }  }`);@Component({    selector: 'review-detail',    templateUrl: './review-detail.component.html',    styleUrls: ['./review-detail.component.scss'],    changeDetection: ChangeDetectionStrategy.OnPush,    standalone: true,    imports: [SharedModule],})export class ReviewDetailComponent extends TypedBaseDetailComponent<typeof getReviewDetailDocument, 'review'> implements OnInit, OnDestroy {    detailForm = this.formBuilder.group({        title: [''],        rating: [1],        authorName: [''],    });    constructor(private formBuilder: FormBuilder, private notificationService: NotificationService) {        super();    }    ngOnInit() {        this.init();    }    ngOnDestroy() {        this.destroy();    }    create() {        const { title, rating, authorName } = this.detailForm.value;        if (!title || rating == null || !authorName) {            return;        }        this.dataService            .mutate(createReviewDocument, {                input: { title, rating, authorName },            })            .subscribe(({ createProductReview }) => {                if (createProductReview.id) {                    this.notificationService.success('Review created');                    this.router.navigate(['extensions', 'reviews', createProductReview.id]);                }            });    }    update() {        const { title, rating, authorName } = this.detailForm.value;        this.dataService            .mutate(updateReviewDocument, {                input: { id: this.id, title, rating, authorName },            })            .subscribe(() => {                this.notificationService.success('Review updated');            });    }    protected setFormValues(entity: NonNullable<ResultOf<typeof getReviewDetailDocument>['review']>, languageCode: LanguageCode): void {        this.detailForm.patchValue({            title: entity.name,            rating: entity.rating,            authorName: entity.authorName,            productId: entity.productId,        });    }}``````html<vdr-page-block>    <vdr-action-bar>        <vdr-ab-left></vdr-ab-left>        <vdr-ab-right>            <button                class="button primary"                *ngIf="isNew$ | async; else updateButton"                (click)="create()"                [disabled]="detailForm.pristine || detailForm.invalid"            >                {{ 'common.create' | translate }}            </button>            <ng-template #updateButton>                <button                    class="btn btn-primary"                    (click)="update()"                    [disabled]="detailForm.pristine || detailForm.invalid"                >                    {{ 'common.update' | translate }}                </button>            </ng-template>        </vdr-ab-right>    </vdr-action-bar></vdr-page-block><form class="form" [formGroup]="detailForm">    <vdr-page-detail-layout>        <!-- The sidebar is used for displaying "metadata" type information about the entity -->        <vdr-page-detail-sidebar>            <vdr-card *ngIf="entity$ | async as entity">                <vdr-page-entity-info [entity]="entity" />            </vdr-card>        </vdr-page-detail-sidebar>        <!-- The main content area is used for displaying the entity's fields -->        <vdr-page-block>            <!-- The vdr-card is the container for grouping items together on a page -->            <!-- it can also take an optional [title] property to display a title -->            <vdr-card>                <!-- the form-grid class is used to lay out the form fields -->                <div class="form-grid">                    <vdr-form-field label="Title" for="title">                        <input id="title" type="text" formControlName="title" />                    </vdr-form-field>                    <vdr-form-field label="Rating" for="rating">                        <input id="rating" type="number" min="1" max="5" formControlName="rating" />                    </vdr-form-field>                    <!-- etc -->                </div>            </vdr-card>        </vdr-page-block>    </vdr-page-detail-layout></form>``````tsimport { registerRouteComponent } from '@vendure/admin-ui/core';import { ReviewDetailComponent, getReviewDetailDocument } from './components/review-detail/review-detail.component';export default [    registerRouteComponent({        path: ':id',        component: ReviewDetailComponent,        query: getReviewDetailDocument,        entityKey: 'productReview',        getBreadcrumbs: entity => [            {                label: 'Product reviews',                link: ['/extensions', 'product-reviews'],            },            {                label: `#${entity?.id} (${entity?.product.name})`,                link: [],            },        ],    }),]```### New (React Dashboard)```tsximport {    DashboardRouteDefinition,    detailPageRouteLoader,    useDetailPage,    Page,    PageTitle,    PageActionBar,    PageActionBarRight,    PermissionGuard,    Button,    PageLayout,    PageBlock,    FormFieldWrapper,    DetailFormGrid,    Switch,    Input,    RichTextInput,    CustomFieldsPageBlock,} from '@vendure/dashboard';import { AnyRoute, useNavigate } from '@tanstack/react-router';import { toast } from 'sonner';import { graphql } from '@/gql';const articleDetailDocument = graphql(`    query GetArticleDetail($id: ID!) {        article(id: $id) {            id            createdAt            updatedAt            isPublished            title            slug            body            customFields        }    }`);const createArticleDocument = graphql(`    mutation CreateArticle($input: CreateArticleInput!) {        createArticle(input: $input) {            id        }    }`);const updateArticleDocument = graphql(`    mutation UpdateArticle($input: UpdateArticleInput!) {        updateArticle(input: $input) {            id        }    }`);export const articleDetail: DashboardRouteDefinition = {    path: '/articles/$id',    loader: detailPageRouteLoader({        queryDocument: articleDetailDocument,        breadcrumb: (isNew, entity) => [            { path: '/articles', label: 'Articles' },            isNew ? 'New article' : entity?.title,        ],    }),    component: route => {        return <ArticleDetailPage route={route} />;    },};function ArticleDetailPage({ route }: { route: AnyRoute }) {const params = route.useParams();const navigate = useNavigate();const creatingNewEntity = params.id === 'new';    const { form, submitHandler, entity, isPending, resetForm, refreshEntity } = useDetailPage({        queryDocument: articleDetailDocument,        createDocument: createArticleDocument,        updateDocument: updateArticleDocument,        setValuesForUpdate: article => {            return {                id: article?.id ?? '',                isPublished: article?.isPublished ?? false,                title: article?.title ?? '',                slug: article?.slug ?? '',                body: article?.body ?? '',            };        },        params: { id: params.id },        onSuccess: async data => {            toast.success('Successfully updated article');            resetForm();            if (creatingNewEntity) {                await navigate({ to: `../$id`, params: { id: data.id } });            }        },        onError: err => {            toast.error('Failed to update article', {                description: err instanceof Error ? err.message : 'Unknown error',            });        },    });    return (        <Page pageId="article-detail" form={form} submitHandler={submitHandler}>            <PageTitle>{creatingNewEntity ? 'New article' : (entity?.title ?? '')}</PageTitle>            <PageActionBar>                <PageActionBarRight>                    <PermissionGuard requires={['UpdateProduct', 'UpdateCatalog']}>                        <Button                            type="submit"                            disabled={!form.formState.isDirty || !form.formState.isValid || isPending}                        >                            Update                        </Button>                    </PermissionGuard>                </PageActionBarRight>            </PageActionBar>            <PageLayout>                <PageBlock column="side" blockId="publish-status" title="Status" description="Current status of this article">                    <FormFieldWrapper                        control={form.control}                        name="isPublished"                        label="Is Published"                        render={({ field }) => (                            <Switch checked={field.value} onCheckedChange={field.onChange} />                        )}                    />                </PageBlock>                <PageBlock column="main" blockId="main-form">                    <DetailFormGrid>                        <FormFieldWrapper                            control={form.control}                            name="title"                            label="Title"                            render={({ field }) => <Input {...field} />}                        />                        <FormFieldWrapper                            control={form.control}                            name="slug"                            label="Slug"                            render={({ field }) => <Input {...field} />}                        />                    </DetailFormGrid>                    <div className="space-y-6">                        <FormFieldWrapper                            control={form.control}                            name="body"                            label="Content"                            render={({ field }) => (                                <RichTextInput value={field.value ?? ''} onChange={field.onChange} />                            )}                        />                    </div>                </PageBlock>                <CustomFieldsPageBlock column="main" entityType="Article" control={form.control} />            </PageLayout>        </Page>    );}```Important:    - The PageBlock component should *never* contain any Card-like component, because it already      renders like a card.    - Use `refreshEntity` to trigger a manual reload of the entity data (e.g. after a mutation      succeeds)    - The `DetailFormGrid` has a built-in `mb-6`, but for components not wrapped in this,      manually ensure there is a y gap of 6 (e.g. wrap in `<div className="space-y-6">`)## Adding Nav Menu Items### Old (Angular)```tsimport { addNavMenuSection } from '@vendure/admin-ui/core';export default [    addNavMenuSection({        id: 'greeter',        label: 'My Extensions',        items: [{            id: 'greeter',            label: 'Greeter',            routerLink: ['/extensions/greet'],            // Icon can be any of https://core.clarity.design/foundation/icons/shapes/            icon: 'cursor-hand-open',        }],    },    // Add this section before the "settings" section    'settings'),];```### New (React Dashboard)```tsximport { defineDashboardExtension } from '@vendure/dashboard';defineDashboardExtension({    routes: [        {            path: '/my-custom-page',            component: () => <div>My Custom Page</div>,            navMenuItem: {                // The section where this item should appear                sectionId: 'catalog',                // Unique identifier for this menu item                id: 'my-custom-page',                // Display text in the navigation                title: 'My Custom Page',                // Optional: URL if different from path                url: '/my-custom-page',            },        },    ],});```## Action Bar Items### Old (Angular)```tsimport { addActionBarItem } from '@vendure/admin-ui/core';export default [    addActionBarItem({        id: 'print-invoice',        locationId: 'order-detail',        label: 'Print invoice',        icon: 'printer',        routerLink: route => {            const id = route.snapshot.params.id;            return ['./extensions/order-invoices', id];        },        requiresPermission: 'ReadOrder',    }),];```### New (React Dashboard)```tsximport { Button, defineDashboardExtension } from '@vendure/dashboard';import { useState } from 'react';defineDashboardExtension({    actionBarItems: [        {            pageId: 'product-detail',            component: ({ context }) => {                const [count, setCount] = useState(0);                return (                    <Button type="button" variant="secondary" onClick={() => setCount(x => x + 1)}>                        Counter: {count}                    </Button>                );            },        },    ],});```## Custom Detail Components### Old (Angular)```ts title="src/plugins/cms/ui/components/product-info/product-info.component.ts"import { Component, OnInit } from '@angular/core';import { Observable, switchMap } from 'rxjs';import { FormGroup } from '@angular/forms';import { DataService, CustomDetailComponent, SharedModule } from '@vendure/admin-ui/core';import { CmsDataService } from '../../providers/cms-data.service';@Component({    template: `        <vdr-card title="CMS Info">            <pre>{{ extraInfo$ | async | json }}</pre>        </vdr-card>`,    standalone: true,    providers: [CmsDataService],    imports: [SharedModule],})export class ProductInfoComponent implements CustomDetailComponent, OnInit {    // These two properties are provided by Vendure and will vary    // depending on the particular detail page you are embedding this    // component into. In this case, it will be a "product" entity.    entity$: Observable<any>    detailForm: FormGroup;    extraInfo$: Observable<any>;    constructor(private cmsDataService: CmsDataService) {    }    ngOnInit() {        this.extraInfo$ = this.entity$.pipe(            switchMap(entity => this.cmsDataService.getDataFor(entity.id))        );    }}```### New (React Dashboard)```tsx title="src/plugins/my-plugin/dashboard/index.tsx"import { defineDashboardExtension } from '@vendure/dashboard';defineDashboardExtension({    pageBlocks: [        {            id: 'related-articles',            title: 'Related Articles',            location: {                // This is the pageId of the page where this block will be                pageId: 'product-detail',                // can be "main" or "side"                column: 'side',                position: {                    // Blocks are positioned relative to existing blocks on                    // the page.                    blockId: 'facet-values',                    // Can be "before", "after" or "replace"                    // Here we'll place it after the `facet-values` block.                    order: 'after',                },            },            component: ({ context }) => {                // In the component, you can use the `context` prop to                // access the entity and the form instance.                return <div className="text-sm">Articles related to {context.entity.name}</div>;            },        },    ],});```## Page Tabs### Old (Angular)```tsimport { registerPageTab } from '@vendure/admin-ui/core';import { ReviewListComponent } from './components/review-list/review-list.component';export default [    registerPageTab({        location: 'product-detail',        tab: 'Reviews',        route: 'reviews',        tabIcon: 'star',        component: ReviewListComponent,    }),];```### New (React Dashboard)Page tabs are not supported by the Dashboard. Suggest alternative such as a new route.## Widgets### Old (Angular)```ts title="src/plugins/reviews/ui/components/reviews-widget/reviews-widget.component.ts"import { Component, OnInit } from '@angular/core';import { DataService, SharedModule } from '@vendure/admin-ui/core';import { Observable } from 'rxjs';@Component({    selector: 'reviews-widget',    template: `        <ul>            <li *ngFor="let review of pendingReviews$ | async">                <a [routerLink]="['/extensions', 'product-reviews', review.id]">{{ review.summary }}</a>                <span class="rating">{{ review.rating }} / 5</span>            </li>        </ul>    `,    standalone: true,    imports: [SharedModule],})export class ReviewsWidgetComponent implements OnInit {    pendingReviews$: Observable<any[]>;    constructor(private dataService: DataService) {}    ngOnInit() {        this.pendingReviews$ = this.dataService.query(gql`            query GetAllReviews($options: ProductReviewListOptions) {                productReviews(options: $options) {                    items {                        id                        createdAt                        authorName                        summary                        rating                    }                }            }`, {                options: {                    filter: { state: { eq: 'new' } },                    take: 10,                },            })            .mapStream(data => data.productReviews.items);    }}``````ts title="src/plugins/reviews/ui/providers.ts"import { registerDashboardWidget } from '@vendure/admin-ui/core';export default [    registerDashboardWidget('reviews', {        title: 'Latest reviews',        supportedWidths: [4, 6, 8, 12],        requiresPermissions: ['ReadReview'],        loadComponent: () =>            import('./reviews-widget/reviews-widget.component').then(                m => m.ReviewsWidgetComponent,            ),    }),];```### New (React Dashboard)```tsx title="custom-widget.tsx"import { Badge, DashboardBaseWidget, useLocalFormat, useWidgetFilters } from '@vendure/dashboard';export function CustomWidget() {    const { dateRange } = useWidgetFilters();    const { formatDate } = useLocalFormat();    return (        <DashboardBaseWidget id="custom-widget" title="Custom Widget" description="This is a custom widget">            <div className="flex flex-wrap gap-1">                <span>Displaying results from</span>                <Badge variant="secondary">{formatDate(dateRange.from)}</Badge>                <span>to</span>                <Badge variant="secondary">{formatDate(dateRange.to)}</Badge>            </div>        </DashboardBaseWidget>    );}``````tsx title="index.tsx"import { defineDashboardExtension } from '@vendure/dashboard';import { CustomWidget } from './custom-widget';defineDashboardExtension({    widgets: [        {            id: 'custom-widget',            name: 'Custom Widget',            component: CustomWidget,            defaultSize: { w: 3, h: 3 },        },    ],});```

```

The full prompt is quite large, so it can make sense to first clear the current LLM context,
e.g. with /clear in Claude Code or /new in Codex CLI

### Claude Skills​


[​](#claude-skills)If you use Claude Code, you can use Agent Skills to set
up a specialized skill for migrating plugins. This has the advantage that you do not need to continually paste in the full prompt,
and it can also be potentially more token-efficient.

[Agent Skills](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/overview)To set up a the skill, run this from the root of your project:

```
npx degit vendure-ecommerce/vendure/.claude/skills#minor .claude/skills
```

This command uses degit to copy over the vendure-dashboard-migration skill to
your local ./claude/skills directory.

[degit](https://github.com/Rich-Harris/degit)You can then have Claude Code use the skill with a prompt like:

```
Use the vendure-dashboard-migration skill to migrate @src/plugins/my-plugin to use the dashboard
```

The individual files in the skill contain the exact same content as the full prompt above,
but are more easily reused and can be more token-efficient

### Manual Cleanup​


[​](#manual-cleanup)It is very likely you'll still need to do some manual cleanup after an AI-assisted migration. You might run into
things like:

- Non-optimum styling choices
- Issues with the tsconfig setup not being perfectly implemented.
- For more complex repo structures like a monorepo with plugins as separate libs, you may need to manually implement
the initial setup of the config files.

[tsconfig setup](/guides/extending-the-dashboard/getting-started/#installation--setup)
## Manual Migration​


[​](#manual-migration)If you would rather do a full manual migration, you should first follow the Dashboard Getting Started guide
and the Extending the Dashboard guide.

[Dashboard Getting Started guide](/guides/extending-the-dashboard/getting-started/)[Extending the Dashboard guide](http://localhost:3001/guides/extending-the-dashboard/extending-overview/)The remainder of this document details specific features, and how they are now implemented in the new Dashboard.

### Forms​


[​](#forms)Forms in the Angular Admin UI used vdr-form-field components within a form-grid class. In the Dashboard, forms use FormFieldWrapper with react-hook-form, wrapped in either DetailFormGrid for grid layouts or div containers with space-y-6 for vertical spacing.

```
<PageBlock column="main" blockId="main-form">    <DetailFormGrid>        <FormFieldWrapper            control={form.control}            name="title"            label="Title"            render={({ field }) => <Input {...field} />}        />    </DetailFormGrid>    <div className="space-y-6">        <FormFieldWrapper            control={form.control}            name="body"            label="Content"            render={({ field }) => (                <RichTextInput value={field.value ?? ''} onChange={field.onChange} />            )}        />    </div></PageBlock>
```

### Custom Field Inputs​


[​](#custom-field-inputs)Custom field inputs now use the DashboardFormComponent type and are registered via customFormComponents.customFields in the Dashboard extension definition. Components receive value, onChange, and name props, and can use useFormContext() to access field state and errors.

```
export const ColorPickerComponent: DashboardFormComponent = ({ value, onChange, name }) => {    const { getFieldState } = useFormContext();    const error = getFieldState(name).error;    return (        <Input value={value || ''} onChange={e => onChange(e.target.value)} />    );};// Register in index.tsxdefineDashboardExtension({    customFormComponents: {        customFields: [            { id: 'color-picker', component: ColorPickerComponent },        ],    },});
```

### List Pages​


[​](#list-pages)List pages migrate from TypedBaseListComponent to the ListPage component. The ListPage automatically generates columns from the GraphQL query fields. Use customizeColumns to customize specific columns (e.g., linking with DetailPageButton), defaultVisibility to control which columns show by default, and defaultColumnOrder to set column order.

```
export const articleList: DashboardRouteDefinition = {    path: '/articles',    component: route => (        <ListPage            pageId="article-list"            title="Articles"            listQuery={getArticleList}            deleteMutation={deleteArticleDocument}            route={route}            customizeColumns={{                title: {                    cell: ({ row }) => <DetailPageButton id={row.original.id} label={row.original.title} />,                },            }}            defaultVisibility={{                title: true,                authorName: true,            }}        >            <PageActionBarRight>                <Button asChild>                    <Link to="./new"><PlusIcon /> New article</Link>                </Button>            </PageActionBarRight>        </ListPage>    ),};
```

Important: When using defaultVisibility, only specify visible columns with true. The id, createdAt, and updatedAt columns are handled automatically. If a custom cell function accesses fields other than the one being rendered, declare them in meta.dependencies.

### Detail Pages​


[​](#detail-pages)Detail pages migrate from TypedBaseDetailComponent to the useDetailPage hook. The hook handles form initialization, entity loading, and mutations. Use detailPageRouteLoader for the route loader, and structure the page with Page, PageActionBar, PageLayout, PageBlock, and DetailFormGrid components.

```
export const articleDetail: DashboardRouteDefinition = {    path: '/articles/$id',    loader: detailPageRouteLoader({        queryDocument: articleDetailDocument,        breadcrumb: (isNew, entity) => [            { path: '/articles', label: 'Articles' },            isNew ? 'New article' : entity?.title,        ],    }),    component: route => {        const { form, submitHandler, entity, isPending, refreshEntity } = useDetailPage({            queryDocument: articleDetailDocument,            createDocument: createArticleDocument,            updateDocument: updateArticleDocument,            setValuesForUpdate: article => ({                title: article?.title ?? '',                slug: article?.slug ?? '',            }),            params: { id: route.useParams().id },            onSuccess: async data => {                toast.success('Successfully updated');            },        });        return (            <Page pageId="article-detail" form={form} submitHandler={submitHandler}>                <PageLayout>                    <PageBlock column="main" blockId="main-form">                        <DetailFormGrid>                            <FormFieldWrapper control={form.control} name="title" label="Title"                                render={({ field }) => <Input {...field} />} />                        </DetailFormGrid>                    </PageBlock>                </PageLayout>            </Page>        );    },};
```

Important: PageBlock already renders as a card, so never nest Card components inside it. Use refreshEntity to manually reload entity data after mutations. Ensure vertical spacing of 6 units for components not in DetailFormGrid.

### Nav Menu Items​


[​](#nav-menu-items)Nav menu items are now configured via the navMenuItem property on route definitions within the routes array. Specify sectionId (e.g., 'catalog'), unique id, and title.

```
defineDashboardExtension({    routes: [        {            path: '/my-custom-page',            component: () => <div>My Custom Page</div>,            navMenuItem: {                sectionId: 'catalog',                id: 'my-custom-page',                title: 'My Custom Page',            },        },    ],});
```

### Action Bar Items​


[​](#action-bar-items)Action bar items migrate from addActionBarItem to the actionBarItems array in the Dashboard extension. Each item specifies a pageId and a component function that receives context.

```
defineDashboardExtension({    actionBarItems: [        {            pageId: 'product-detail',            component: ({ context }) => (                <Button type="button" variant="secondary" onClick={() => handleAction()}>                    Custom Action                </Button>            ),        },    ],});
```

### Custom Detail Components (Page Blocks)​


[​](#custom-detail-components-page-blocks)Custom detail components (Angular CustomDetailComponent) are now implemented as page blocks via the pageBlocks array. Each block specifies id, title, location (pageId, column, position), and a component function that receives context with entity and form access.

```
defineDashboardExtension({    pageBlocks: [        {            id: 'related-articles',            title: 'Related Articles',            location: {                pageId: 'product-detail',                column: 'side',                position: { blockId: 'facet-values', order: 'after' },            },            component: ({ context }) => (                <div>Articles related to {context.entity.name}</div>            ),        },    ],});
```

### Page Tabs​


[​](#page-tabs)Page tabs (registerPageTab) are not supported in the Dashboard. Consider alternative approaches such as creating a new route or using page blocks.

### Widgets​


[​](#widgets)Dashboard widgets migrate from registerDashboardWidget to the widgets array. Each widget specifies id, name, component, and defaultSize. Widget components can use useWidgetFilters() and useLocalFormat() hooks, and should wrap content in DashboardBaseWidget.

```
export function CustomWidget() {    const { dateRange } = useWidgetFilters();    const { formatDate } = useLocalFormat();    return (        <DashboardBaseWidget id="custom-widget" title="Custom Widget" description="Widget description">            <div>                <Badge variant="secondary">{formatDate(dateRange.from)}</Badge>                to                <Badge variant="secondary">{formatDate(dateRange.to)}</Badge>            </div>        </DashboardBaseWidget>    );}defineDashboardExtension({    widgets: [        { id: 'custom-widget', name: 'Custom Widget', component: CustomWidget, defaultSize: { w: 3, h: 3 } },    ],});
```

---
