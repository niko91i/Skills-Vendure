# Vendure Dashboard - Composants Layout

> Généré automatiquement le 2025-10-27 07:45:26
> Source : https://storybook.vendure.io

## 📋 Table des Matières

- [Custom Form Page](#custom-form-page) (3 exemples)
- [DetailPage](#detailpage) (1 exemples)
- [ListPage](#listpage) (5 exemples)
- [Page Layout](#page-layout) (7 exemples)

---

## 🚀 Import Rapide

```tsx
import {
  CustomFormPage,
  DetailPage,
  ListPage,
  PageLayout,
} from '@vendure/dashboard';
```

---

## Custom Form Page

**Import** : `import { CustomFormPage } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/layout-custom-form-page--docs](https://storybook.vendure.io/?path=/docs/layout-custom-form-page--docs)

### Exemples (3)

#### 1. Default

```tsx
{
  render: () => {
    const {
      route,
      router
    } = createDemoRoute();
    const form = useForm<ProductFormData>({
      defaultValues: {
        name: 'Wireless Headphones',
        slug: 'wireless-headphones',
        description: 'High-quality wireless headphones with active noise cancellation.',
        enabled: true
      }
    });
    const onSubmit = (data: ProductFormData) => {
      console.log('Form submitted:', data);
      // In a real app, you would call your update mutation here
    };
    return <RouterContextProvider router={router}>
                <Page pageId="product-custom-detail" form={form} submitHandler={form.handleSubmit(onSubmit)} entity={{
        id: '1',
        createdAt: '2024-01-01T00:00:00.000Z',
        updatedAt: '2024-01-15T00:00:00.000Z'
      }}>
                    <PageTitle>
                        <Trans>Product: Wireless Headphones</Trans>
                    </PageTitle>
                    <PageActionBar>
                        <PageActionBarRight>
                            <Button type="submit" disabled={!form.formState.isDirty}>
                                <Trans>Save Changes</Trans>
                            </Button>
                        </PageActionBarRight>
                    </PageActionBar>
                    <PageLayout>
                        <PageBlock column="main" blockId="product-details" title={<Trans>Product Details</Trans>} description={<Trans>Basic information about the product</Trans>}>
                            <DetailFormGrid>
                                <FormFieldWrapper control={form.control} name="name" label={<Trans>Product Name</Trans>} description={<Trans>The display name of the product</Trans>} render={({
                field
              }) => <Input {...field} />} />
                                <FormFieldWrapper control={form.control} name="slug" label={<Trans>Slug</Trans>} description={<Trans>URL-friendly identifier</Trans>} render={({
                field
              }) => <Input {...field} />} />
                            </DetailFormGrid>
                            <FormFieldWrapper control={form.control} name="description" label={<Trans>Description</Trans>} render={({
              field
            }) => <Textarea {...field} rows={4} />} />
                        </PageBlock>
                        <PageBlock column="side" blockId="product-status" title={<Trans>Status</Trans>}>
                            <FormFieldWrapper control={form.control} name="enabled" label={<Trans>Enabled</Trans>} description={<Trans>Whether this product is active</Trans>} render={({
              field
            }) => <div className="flex items-center">
                                        <input type="checkbox" checked={field.value} onChange={field.onChange} className="mr-2" />
                                        <span className="text-sm">
                                            {field.value ? <Trans>Product is enabled</Trans> : <Trans>Product is disabled</Trans>}
                                        </span>
                                    </div>} />
                        </PageBlock>
                    </PageLayout>
                </Page>
            </RouterContextProvider>;
  }
}
```

#### 2. Product Custom Form

```tsx
{
  render: () => {
    const {
      route,
      router
    } = createDemoRoute();
    const form = useForm<ProductFormData>({
      defaultValues: {
        name: 'Wireless Headphones',
        slug: 'wireless-headphones',
        description: 'High-quality wireless headphones with active noise cancellation.',
        enabled: true
      }
    });
    const onSubmit = (data: ProductFormData) => {
      console.log('Form submitted:', data);
      // In a real app, you would call your update mutation here
    };
    return <RouterContextProvider router={router}>
                <Page pageId="product-custom-detail" form={form} submitHandler={form.handleSubmit(onSubmit)} entity={{
        id: '1',
        createdAt: '2024-01-01T00:00:00.000Z',
        updatedAt: '2024-01-15T00:00:00.000Z'
      }}>
                    <PageTitle>
                        <Trans>Product: Wireless Headphones</Trans>
                    </PageTitle>
                    <PageActionBar>
                        <PageActionBarRight>
                            <Button type="submit" disabled={!form.formState.isDirty}>
                                <Trans>Save Changes</Trans>
                            </Button>
                        </PageActionBarRight>
                    </PageActionBar>
                    <PageLayout>
                        <PageBlock column="main" blockId="product-details" title={<Trans>Product Details</Trans>} description={<Trans>Basic information about the product</Trans>}>
                            <DetailFormGrid>
                                <FormFieldWrapper control={form.control} name="name" label={<Trans>Product Name</Trans>} description={<Trans>The display name of the product</Trans>} render={({
                field
              }) => <Input {...field} />} />
                                <FormFieldWrapper control={form.control} name="slug" label={<Trans>Slug</Trans>} description={<Trans>URL-friendly identifier</Trans>} render={({
                field
              }) => <Input {...field} />} />
                            </DetailFormGrid>
                            <FormFieldWrapper control={form.control} name="description" label={<Trans>Description</Trans>} render={({
              field
            }) => <Textarea {...field} rows={4} />} />
                        </PageBlock>
                        <PageBlock column="side" blockId="product-status" title={<Trans>Status</Trans>}>
                            <FormFieldWrapper control={form.control} name="enabled" label={<Trans>Enabled</Trans>} description={<Trans>Whether this product is active</Trans>} render={({
              field
            }) => <div className="flex items-center">
                                        <input type="checkbox" checked={field.value} onChange={field.onChange} className="mr-2" />
                                        <span className="text-sm">
                                            {field.value ? <Trans>Product is enabled</Trans> : <Trans>Product is disabled</Trans>}
                                        </span>
                                    </div>} />
                        </PageBlock>
                    </PageLayout>
                </Page>
            </RouterContextProvider>;
  }
}
```

#### 3. Complex Custom Form

```tsx
{
  render: () => {
    const {
      route,
      router
    } = createDemoRoute();
    const form = useForm({
      defaultValues: {
        // Basic Info
        name: 'Premium Laptop',
        slug: 'premium-laptop',
        sku: 'LAPTOP-001',
        // Pricing
        price: 1299.99,
        salePrice: null,
        costPrice: 899.0,
        // Inventory
        stockOnHand: 50,
        trackInventory: true,
        // Details
        description: 'High-performance laptop for professionals',
        shortDescription: 'Professional laptop',
        // SEO
        metaTitle: '',
        metaDescription: ''
      }
    });
    const onSubmit = (data: any) => {
      console.log('Form submitted:', data);
    };
    return <RouterContextProvider router={router}>
                <Page pageId="product-complex-detail" form={form} submitHandler={form.handleSubmit(onSubmit)} entity={{
        id: '2',
        createdAt: '2024-01-01',
        updatedAt: '2024-01-15'
      }}>
                    <PageTitle>
                        <Trans>Product: Premium Laptop</Trans>
                    </PageTitle>
                    <PageActionBar>
                        <PageActionBarRight>
                            <Button variant="outline" type="button">
                                <Trans>Cancel</Trans>
                            </Button>
                            <Button type="submit" disabled={!form.formState.isDirty}>
                                <Trans>Save Changes</Trans>
                            </Button>
                        </PageActionBarRight>
                    </PageActionBar>
                    <PageLayout>
                        <PageBlock column="main" blockId="basic-info" title={<Trans>Basic Information</Trans>}>
                            <DetailFormGrid>
                                <FormFieldWrapper control={form.control} name="name" label={<Trans>Product Name</Trans>} render={({
                field
              }) => <Input {...field} />} />
                                <FormFieldWrapper control={form.control} name="sku" label={<Trans>SKU</Trans>} render={({
                field
              }) => <Input {...field} />} />
                                <FormFieldWrapper control={form.control} name="slug" label={<Trans>Slug</Trans>} render={({
                field
              }) => <Input {...field} />} />
                            </DetailFormGrid>
                        </PageBlock>

                        <PageBlock column="main" blockId="description" title={<Trans>Description</Trans>}>
                            <FormFieldWrapper control={form.control} name="shortDescription" label={<Trans>Short Description</Trans>} render={({
              field
            }) => <Input {...field} />} />
                            <FormFieldWrapper control={form.control} name="description" label={<Trans>Full Description</Trans>} render={({
              field
            }) => <Textarea {...field} rows={6} />} />
                        </PageBlock>

                        <PageBlock column="main" blockId="pricing" title={<Trans>Pricing</Trans>}>
                            <DetailFormGrid>
                                <FormFieldWrapper control={form.control} name="price" label={<Trans>Price</Trans>} render={({
                field
              }) => <Input {...field} type="number" step="0.01" />} />
                                <FormFieldWrapper control={form.control} name="salePrice" label={<Trans>Sale Price</Trans>} description={<Trans>Optional discounted price</Trans>} render={({
                field
              }) => <Input {...field} type="number" step="0.01" value={field.value ?? ''} />} />
                                <FormFieldWrapper control={form.control} name="costPrice" label={<Trans>Cost Price</Trans>} description={<Trans>Your cost for this product</Trans>} render={({
                field
              }) => <Input {...field} type="number" step="0.01" />} />
                            </DetailFormGrid>
                        </PageBlock>

                        <PageBlock column="side" blockId="inventory" title={<Trans>Inventory</Trans>}>
                            <div className="space-y-4">
                                <FormFieldWrapper control={form.control} name="trackInventory" label={<Trans>Track Inventory</Trans>} render={({
                field
              }) => <div className="flex items-center">
                                            <input type="checkbox" checked={field.value} onChange={field.onChange} className="mr-2" />
                                        </div>} />
                                <FormFieldWrapper control={form.control} name="stockOnHand" label={<Trans>Stock on Hand</Trans>} render={({
                field
              }) => <Input {...field} type="number" />} />
                            </div>
                        </PageBlock>

                        <PageBlock column="side" blockId="seo" title={<Trans>SEO</Trans>}>
                            <div className="space-y-4">
                                <FormFieldWrapper control={form.control} name="metaTitle" label={<Trans>Meta Title</Trans>} render={({
                field
              }) => <Input {...field} />} />
                                <FormFieldWrapper control={form.control} name="metaDescription" label={<Trans>Meta Description</Trans>} render={({
                field
              }) => <Textarea {...field} rows={3} />} />
                            </div>
                        </PageBlock>
                    </PageLayout>
                </Page>
            </RouterContextProvider>;
  }
}
```

---

## DetailPage

Basic example of a DetailPage showing a product entity.
This demonstrates the minimal configuration needed to render a detail page.

**Import** : `import { DetailPage } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/layout-detailpage--docs](https://storybook.vendure.io/?path=/docs/layout-detailpage--docs)

### Exemples (1)

#### 1. Default

```tsx
<nr
  pageId="product-detail"
  queryDocument={graphql`
    query Product($id: ID!) {
      product(id: $id) {
        ...ProductDetail
      }
    }
    
    fragment ProductDetail on Product {
      id
      createdAt
      updatedAt
      name
      slug
      description
      enabled
      featuredAsset {
        id
      }
      assets {
        id
      }
      facetValues {
        id
      }
      translations {
        id
        languageCode
        name
        slug
        description
      }
    }
  `}
  setValuesForUpdate={function ZAe(){}}
  title={function ZAe(){}}
  updateDocument={graphql`
    mutation UpdateProduct($input: UpdateProductInput!) {
      updateProduct(input: $input) {
        id
        name
        slug
        description
        enabled
      }
    }
  `}
/>
```

---

## ListPage

**Import** : `import { ListPage } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/layout-listpage--docs](https://storybook.vendure.io/?path=/docs/layout-listpage--docs)

### Exemples (5)

#### 1. Default

```tsx
<De
  defaultVisibility={{
    code: true,
    enabled: true,
    name: true
  }}
  listQuery={graphql`
    query CountriesList($options: CountryListOptions) {
      countries(options: $options) {
        items {
          ...CountryItem
        }
        totalItems
      }
    }
    
    fragment CountryItem on Country {
      id
      createdAt
      updatedAt
      name
      code
      enabled
    }
  `}
  pageId="country-list"
  title="Countries"
/>
```

#### 2. Basic List

```tsx
<De
  defaultVisibility={{
    code: true,
    enabled: true,
    name: true
  }}
  listQuery={graphql`
    query CountriesList($options: CountryListOptions) {
      countries(options: $options) {
        items {
          ...CountryItem
        }
        totalItems
      }
    }
    
    fragment CountryItem on Country {
      id
      createdAt
      updatedAt
      name
      code
      enabled
    }
  `}
  pageId="country-list"
  title="Countries"
/>
```

#### 3. With Custom Columns

```tsx
<De
  customizeColumns={{
    name: {
      cell: function ZAe(){}
    }
  }}
  defaultVisibility={{
    code: true,
    enabled: true,
    name: true
  }}
  deleteMutation={graphql`
    mutation DeleteCountry($id: ID!) {
      deleteCountry(id: $id) {
        result
        message
      }
    }
  `}
  listQuery={graphql`
    query CountriesList($options: CountryListOptions) {
      countries(options: $options) {
        items {
          ...CountryItem
        }
        totalItems
      }
    }
    
    fragment CountryItem on Country {
      id
      createdAt
      updatedAt
      name
      code
      enabled
    }
  `}
  pageId="country-list-custom"
  title="Countries"
/>
```

#### 4. With Search

```tsx
<De
  customizeColumns={{
    name: {
      cell: function ZAe(){}
    }
  }}
  defaultVisibility={{
    code: true,
    enabled: true,
    name: true
  }}
  listQuery={graphql`
    query CountriesList($options: CountryListOptions) {
      countries(options: $options) {
        items {
          ...CountryItem
        }
        totalItems
      }
    }
    
    fragment CountryItem on Country {
      id
      createdAt
      updatedAt
      name
      code
      enabled
    }
  `}
  onSearchTermChange={function ZAe(){}}
  pageId="country-list-search"
  title="Countries"
  transformVariables={function ZAe(){}}
/>
```

#### 5. Complete

```tsx
<De
  customizeColumns={{
    name: {
      cell: function ZAe(){}
    }
  }}
  defaultVisibility={{
    code: true,
    enabled: true,
    name: true
  }}
  deleteMutation={graphql`
    mutation DeleteCountry($id: ID!) {
      deleteCountry(id: $id) {
        result
        message
      }
    }
  `}
  listQuery={graphql`
    query CountriesList($options: CountryListOptions) {
      countries(options: $options) {
        items {
          ...CountryItem
        }
        totalItems
      }
    }
    
    fragment CountryItem on Country {
      id
      createdAt
      updatedAt
      name
      code
      enabled
    }
  `}
  onSearchTermChange={function ZAe(){}}
  pageId="country-list-complete"
  title="Countries"
  transformVariables={function ZAe(){}}
>
  <PageActionBarRight>
    <Button>
      <Plus />
      Add Country
    </Button>
  </PageActionBarRight>
</De>
```

---

## Page Layout

**Import** : `import { PageLayout } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/layout-page-layout--docs](https://storybook.vendure.io/?path=/docs/layout-page-layout--docs)

### Exemples (7)

#### 1. Default

```tsx
{
  render: () => {
    const {
      route,
      router
    } = createDemoRoute();
    return <RouterContextProvider router={router}>
                <Page pageId="test-page">
                    <PageTitle>Test Page</PageTitle>
                    <PageLayout>
                        <PageBlock column="main" blockId="main-stuff">
                            This will display in the main area
                        </PageBlock>
                        <PageBlock column="side" blockId="side-stuff">
                            This will display in the side area
                        </PageBlock>
                    </PageLayout>
                </Page>
            </RouterContextProvider>;
  }
}
```

#### 2. Playground

```tsx
{
  render: () => {
    const {
      route,
      router
    } = createDemoRoute();
    return <RouterContextProvider router={router}>
                <Page pageId="test-page">
                    <PageTitle>Test Page</PageTitle>
                    <PageLayout>
                        <PageBlock column="main" blockId="main-stuff">
                            This will display in the main area
                        </PageBlock>
                        <PageBlock column="side" blockId="side-stuff">
                            This will display in the side area
                        </PageBlock>
                    </PageLayout>
                </Page>
            </RouterContextProvider>;
  }
}
```

#### 3. With Action Bar

```tsx
{
  render: () => {
    const {
      route,
      router
    } = createDemoRoute();
    return <RouterContextProvider router={router}>
                <Page pageId="product-detail">
                    <PageTitle>Product Details</PageTitle>
                    <PageActionBar>
                        <PageActionBarLeft>
                            <Button variant="outline">Cancel</Button>
                        </PageActionBarLeft>
                        <PageActionBarRight>
                            <Button>Save</Button>
                        </PageActionBarRight>
                    </PageActionBar>
                    <PageLayout>
                        <PageBlock column="main" blockId="product-info" title="Product Information">
                            <div className="space-y-4">
                                <div>
                                    <label className="text-sm font-medium">Name</label>
                                    <input type="text" className="w-full border rounded px-3 py-2 mt-1" defaultValue="Wireless Headphones" />
                                </div>
                                <div>
                                    <label className="text-sm font-medium">Description</label>
                                    <textarea className="w-full border rounded px-3 py-2 mt-1" rows={4} defaultValue="High-quality wireless headphones with active noise cancellation." />
                                </div>
                            </div>
                        </PageBlock>
                        <PageBlock column="side" blockId="product-meta" title="Metadata">
                            <div className="space-y-3">
                                <div>
                                    <div className="text-sm font-medium">Status</div>
                                    <div className="text-sm text-muted-foreground">Active</div>
                                </div>
                                <div>
                                    <div className="text-sm font-medium">SKU</div>
                                    <div className="text-sm text-muted-foreground">WH-001</div>
                                </div>
                                <div>
                                    <div className="text-sm font-medium">Price</div>
                                    <div className="text-sm text-muted-foreground">$299.00</div>
                                </div>
                            </div>
                        </PageBlock>
                    </PageLayout>
                </Page>
            </RouterContextProvider>;
  }
}
```

#### 4. Multiple Blocks

```tsx
{
  render: () => {
    const {
      route,
      router
    } = createDemoRoute();
    return <RouterContextProvider router={router}>
                <Page pageId="complex-page">
                    <PageTitle>Complex Page Layout</PageTitle>
                    <PageLayout>
                        <PageBlock column="main" blockId="block-1" title="Main Block 1" description="This is the first main block">
                            <p>Content for the first main block goes here.</p>
                        </PageBlock>
                        <PageBlock column="main" blockId="block-2" title="Main Block 2" description="This is the second main block">
                            <p>Content for the second main block goes here.</p>
                        </PageBlock>
                        <PageBlock column="side" blockId="side-1" title="Sidebar Block 1">
                            <p>First sidebar block content.</p>
                        </PageBlock>
                        <PageBlock column="side" blockId="side-2" title="Sidebar Block 2">
                            <p>Second sidebar block content.</p>
                        </PageBlock>
                        <PageBlock column="side" blockId="side-3" title="Sidebar Block 3">
                            <p>Third sidebar block content.</p>
                        </PageBlock>
                    </PageLayout>
                </Page>
            </RouterContextProvider>;
  }
}
```

#### 5. With Full Width Block

```tsx
{
  render: () => {
    const {
      route,
      router
    } = createDemoRoute();
    return <RouterContextProvider router={router}>
                <Page pageId="dashboard-overview">
                    <PageTitle>Dashboard Overview</PageTitle>
                    <PageLayout>
                        <FullWidthPageBlock blockId="stats">
                            <div className="grid grid-cols-1 md:grid-cols-4 gap-4 p-6 bg-muted/50 rounded-lg">
                                <div className="text-center">
                                    <div className="text-3xl font-bold">1,234</div>
                                    <div className="text-sm text-muted-foreground">Total Orders</div>
                                </div>
                                <div className="text-center">
                                    <div className="text-3xl font-bold">$45,678</div>
                                    <div className="text-sm text-muted-foreground">Revenue</div>
                                </div>
                                <div className="text-center">
                                    <div className="text-3xl font-bold">567</div>
                                    <div className="text-sm text-muted-foreground">Products</div>
                                </div>
                                <div className="text-center">
                                    <div className="text-3xl font-bold">890</div>
                                    <div className="text-sm text-muted-foreground">Customers</div>
                                </div>
                            </div>
                        </FullWidthPageBlock>
                        <PageBlock column="main" blockId="recent-orders" title="Recent Orders">
                            <div className="space-y-2">
                                {[1, 2, 3].map(i => <div key={i} className="flex justify-between py-2 border-b">
                                        <span>Order #{1000 + i}</span>
                                        <span className="text-muted-foreground">$99.00</span>
                                    </div>)}
                            </div>
                        </PageBlock>
                        <PageBlock column="side" blockId="quick-stats" title="Quick Stats">
                            <div className="space-y-3">
                                <div>
                                    <div className="text-sm font-medium">Pending Orders</div>
                                    <div className="text-2xl font-bold">12</div>
                                </div>
                                <div>
                                    <div className="text-sm font-medium">Low Stock Items</div>
                                    <div className="text-2xl font-bold">5</div>
                                </div>
                            </div>
                        </PageBlock>
                    </PageLayout>
                </Page>
            </RouterContextProvider>;
  }
}
```

#### 6. Minimal Page

```tsx
{
  render: () => {
    const {
      route,
      router
    } = createDemoRoute();
    return <RouterContextProvider router={router}>
                <Page pageId="simple-page">
                    <PageTitle>Simple Page</PageTitle>
                    <PageLayout>
                        <PageBlock column="main" blockId="content">
                            <p>This is a minimal page with just a title and one content block.</p>
                        </PageBlock>
                    </PageLayout>
                </Page>
            </RouterContextProvider>;
  }
}
```

#### 7. With Block Descriptions

```tsx
{
  render: () => {
    const {
      route,
      router
    } = createDemoRoute();
    return <RouterContextProvider router={router}>
                <Page pageId="settings-page">
                    <PageTitle>Settings</PageTitle>
                    <PageLayout>
                        <PageBlock column="main" blockId="general" title="General Settings" description="Configure general application settings and preferences">
                            <div className="space-y-4">
                                <div className="flex items-center justify-between">
                                    <label className="text-sm font-medium">Enable notifications</label>
                                    <input type="checkbox" defaultChecked />
                                </div>
                                <div className="flex items-center justify-between">
                                    <label className="text-sm font-medium">Dark mode</label>
                                    <input type="checkbox" />
                                </div>
                            </div>
                        </PageBlock>
                        <PageBlock column="main" blockId="advanced" title="Advanced Settings" description="Advanced configuration options for power users">
                            <div className="space-y-4">
                                <div>
                                    <label className="text-sm font-medium">API Key</label>
                                    <input type="text" className="w-full border rounded px-3 py-2 mt-1" defaultValue="sk_test_..." />
                                </div>
                            </div>
                        </PageBlock>
                        <PageBlock column="side" blockId="help" title="Help" description="Need assistance?">
                            <Button variant="outline" className="w-full">
                                View Documentation
                            </Button>
                        </PageBlock>
                    </PageLayout>
                </Page>
            </RouterContextProvider>;
  }
}
```

---

## 📚 Ressources

- [Storybook Vendure](https://storybook.vendure.io)
- [Documentation Vendure](https://docs.vendure.io)
