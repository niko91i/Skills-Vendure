# Vendure Dashboard - Composants Framework

> Généré automatiquement le 2025-10-27 07:58:02
> Source : https://storybook.vendure.io

## 📋 Table des Matières

- [AssetGallery](#assetgallery) (1 exemples)
- [AssetPickerDialog](#assetpickerdialog) (1 exemples)
- [DataTable](#datatable) (1 exemples)
- [DetailPageButton](#detailpagebutton) (1 exemples)
- [FacetValueSelector](#facetvalueselector) (1 exemples)
- [PaginatedListDataTable](#paginatedlistdatatable) (1 exemples)
- [PermissionGuard](#permissionguard) (1 exemples)
- [VendureImage](#vendureimage) (6 exemples)

---

## 🚀 Import Rapide

```tsx
import {
  AssetGallery,
  AssetPickerDialog,
  DataTable,
  DetailPageButton,
  FacetValueSelector,
  PaginatedListDataTable,
  PermissionGuard,
  VendureImage,
} from '@vendure/dashboard';
```

---

## AssetGallery

**Import** : `import { AssetGallery } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/framework-assetgallery--docs](https://storybook.vendure.io/?path=/docs/framework-assetgallery--docs)

### Exemples (1)

#### 1. Default

```tsx
<AssetGallery
  onSelect={handleAssetSelect}
  multiSelect="manual"
  initialSelectedAssets={initialSelectedAssets}
  fixedHeight={false}
  displayBulkActions={false}
  />
```

---

## AssetPickerDialog

A dialog which allows the creation and selection of assets.

**Import** : `import { AssetPickerDialog } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/framework-assetpickerdialog--docs](https://storybook.vendure.io/?path=/docs/framework-assetpickerdialog--docs)

### Exemples (1)

#### 1. Default

```tsx
<YFt router={[object Object]}>
  <div>
    <Button onClick={function ZAe(){}}>
      Open Asset Picker
    </Button>
    <AssetPickerDialog
      onClose={function ZAe(){}}
      onSelect={function ZAe(){}}
      title="Select Assets"
    />
  </div>
</YFt>
```

---

## DataTable

A data table which includes sorting, filtering, pagination, bulk actions, column controls etc.  This is the building block of all data tables in the Dashboard.

**Import** : `import { DataTable } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/framework-datatable--docs](https://storybook.vendure.io/?path=/docs/framework-datatable--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => {
    const [page, setPage] = useState(1);
    const [pageSize, setPageSize] = useState(10);
    const [sorting, setSorting] = useState<SortingState>([{
      id: 'name',
      desc: false
    }]);
    const [filters, setFilters] = useState<ColumnFiltersState>([]);
    const [searchTerm, setSearchTerm] = useState('');

    // Define columns
    const columns: ColumnDef<Product>[] = [{
      id: 'name',
      accessorKey: 'name',
      header: 'Product Name',
      cell: ({
        row
      }) => <span className="font-medium">{row.original.name}</span>
    }, {
      id: 'category',
      accessorKey: 'category',
      header: 'Category',
      cell: ({
        row
      }) => <span>{row.original.category}</span>
    }, {
      id: 'price',
      accessorKey: 'price',
      header: 'Price',
      cell: ({
        row
      }) => <span>${row.original.price.toFixed(2)}</span>
    }, {
      id: 'stock',
      accessorKey: 'stock',
      header: 'Stock',
      cell: ({
        row
      }) => {
        const stock = row.original.stock;
        return <Badge variant={stock > 50 ? 'default' : stock > 20 ? 'secondary' : 'destructive'}>
                            {stock}
                        </Badge>;
      }
    }, {
      id: 'status',
      accessorKey: 'status',
      header: 'Status',
      cell: ({
        row
      }) => {
        const status = row.original.status;
        return <Badge variant={status === 'active' ? 'default' : status === 'inactive' ? 'secondary' : 'outline'}>
                            {status}
                        </Badge>;
      }
    }, {
      id: 'createdAt',
      accessorKey: 'createdAt',
      header: 'Created',
      cell: ({
        row
      }) => new Date(row.original.createdAt).toLocaleDateString()
    }, {
      id: 'actions',
      header: 'Actions',
      cell: ({
        row
      }) => <div className="flex gap-2">
                        <Button variant="ghost" size="sm" onClick={() => console.log('Edit', row.original.id)}>
                            Edit
                        </Button>
                        <Button variant="ghost" size="sm" onClick={() => console.log('Delete', row.original.id)}>
                            Delete
                        </Button>
                    </div>
    }];

    // Filter and sort data based on state
    let filteredData = [...sampleData];

    // Apply search filter
    if (searchTerm) {
      filteredData = filteredData.filter(item => item.name.toLowerCase().includes(searchTerm.toLowerCase()));
    }

    // Apply column filters
    filters.forEach(filter => {
      if (filter.id === 'status' && Array.isArray(filter.value)) {
        filteredData = filteredData.filter(item => filter.value.includes(item.status));
      }
      if (filter.id === 'category' && Array.isArray(filter.value)) {
        filteredData = filteredData.filter(item => filter.value.includes(item.category));
      }
    });

    // Apply sorting
    if (sorting.length > 0) {
      const sort = sorting[0];
      filteredData.sort((a, b) => {
        const aValue = a[sort.id as keyof Product];
        const bValue = b[sort.id as keyof Product];
        if (aValue < bValue) return sort.desc ? 1 : -1;
        if (aValue > bValue) return sort.desc ? -1 : 1;
        return 0;
      });
    }
    const totalItems = filteredData.length;
    const paginatedData = filteredData.slice((page - 1) * pageSize, page * pageSize);
    return <div className="p-6">
                <Page pageId="test-page">
                    <PageLayout>
                        <FullWidthPageBlock blockId="test-block">
                            <DataTable columns={columns} data={paginatedData} totalItems={totalItems} page={page} itemsPerPage={pageSize} sorting={sorting} columnFilters={filters} defaultColumnVisibility={{
              createdAt: false
            }} onPageChange={(_, newPage, newPageSize) => {
              setPage(newPage);
              setPageSize(newPageSize);
            }} onSortChange={(_, newSorting) => {
              setSorting(newSorting);
            }} onFilterChange={(_, newFilters) => {
              setFilters(newFilters);
              setPage(1); // Reset to first page when filters change
            }} onSearchTermChange={term => {
              setSearchTerm(term);
              setPage(1); // Reset to first page when search changes
            }} facetedFilters={{
              status: {
                title: 'Status',
                options: [{
                  label: 'Active',
                  value: 'active'
                }, {
                  label: 'Inactive',
                  value: 'inactive'
                }, {
                  label: 'Discontinued',
                  value: 'discontinued'
                }]
              },
              category: {
                title: 'Category',
                options: [{
                  label: 'Electronics',
                  value: 'Electronics'
                }, {
                  label: 'Clothing',
                  value: 'Clothing'
                }, {
                  label: 'Home & Garden',
                  value: 'Home & Garden'
                }, {
                  label: 'Sports',
                  value: 'Sports'
                }, {
                  label: 'Books',
                  value: 'Books'
                }]
              }
            }} bulkActions={[{
              label: 'Delete selected',
              icon: 'trash',
              onClick: (selectedItems: Product[]) => {
                console.log('Delete selected:', selectedItems);
              }
            }, {
              label: 'Export selected',
              icon: 'download',
              onClick: (selectedItems: Product[]) => {
                console.log('Export selected:', selectedItems);
              }
            }]} onRefresh={() => {
              console.log('Refresh data');
            }} />
                        </FullWidthPageBlock>
                    </PageLayout>
                </Page>
            </div>;
  }
}
```

---

## DetailPageButton

**Import** : `import { DetailPageButton } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/framework-detailpagebutton--docs](https://storybook.vendure.io/?path=/docs/framework-detailpagebutton--docs)

### Exemples (1)

#### 1. Default

```tsx
// Basic usage with ID (relative navigation)
<DetailPageButton id="123" label="Product Name" />
```

---

## FacetValueSelector

**Import** : `import { FacetValueSelector } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/framework-facetvalueselector--docs](https://storybook.vendure.io/?path=/docs/framework-facetvalueselector--docs)

### Exemples (1)

#### 1. Default

```tsx
<FacetValueSelector onValueSelect={onValueSelectHandler} disabled={disabled} />
```

---

## PaginatedListDataTable

**Import** : `import { PaginatedListDataTable } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/framework-paginatedlistdatatable--docs](https://storybook.vendure.io/?path=/docs/framework-paginatedlistdatatable--docs)

### Exemples (1)

#### 1. Default

```tsx
import { Money } from '\@/vdb/components/data-display/money.js';
import { PaginatedListDataTable } from '\@/vdb/components/shared/paginated-list-data-table.js';
import { Badge } from '\@/vdb/components/ui/badge.js';
import { Button } from '\@/vdb/components/ui/button.js';
import { Link } from '\@tanstack/react-router';
import { ColumnFiltersState, SortingState } from '\@tanstack/react-table';
import { useState } from 'react';
import { customerOrderListDocument } from '../customers.graphql.js';

interface CustomerOrderTableProps {
    customerId: string;
}

export function CustomerOrderTable({ customerId }: Readonly<CustomerOrderTableProps>) {
    const [page, setPage] = useState(1);
    const [pageSize, setPageSize] = useState(10);
    const [sorting, setSorting] = useState<SortingState>([{ id: 'orderPlacedAt', desc: true }]);
    const [filters, setFilters] = useState<ColumnFiltersState>([]);

    return (
        <PaginatedListDataTable
            listQuery={customerOrderListDocument}
            transformVariables={variables => {
                return {
                    ...variables,
                    customerId,
                };
            }}
            defaultVisibility={{
                id: false,
                createdAt: false,
                updatedAt: false,
                type: false,
                currencyCode: false,
                total: false,
            }}
            customizeColumns={{
                total: {
                    header: 'Total',
                    cell: ({ cell, row }) => {
                        const value = cell.getValue();
                        const currencyCode = row.original.currencyCode;
                        return <Money value={value} currency={currencyCode} />;
                    },
                },
                totalWithTax: {
                    header: 'Total with Tax',
                    cell: ({ cell, row }) => {
                        const value = cell.getValue();
                        const currencyCode = row.original.currencyCode;
                        return <Money value={value} currency={currencyCode} />;
                    },
                },
                state: {
                    header: 'State',
                    cell: ({ cell }) => {
                        const value = cell.getValue() as string;
                        return <Badge variant="outline">{value}</Badge>;
                    },
                },
                code: {
                    header: 'Code',
                    cell: ({ cell, row }) => {
                        const value = cell.getValue() as string;
                        const id = row.original.id;
                        return (
                            <Button asChild variant="ghost">
                                <Link to={`/orders/${id}`}>{value}</Link>
                            </Button>
                        );
                    },
                },
            }}
            page={page}
            itemsPerPage={pageSize}
            sorting={sorting}
            columnFilters={filters}
            onPageChange={(_, page, perPage) => {
                setPage(page);
                setPageSize(perPage);
            }}
            onSortChange={(_, sorting) => {
                setSorting(sorting);
            }}
            onFilterChange={(_, filters) => {
                setFilters(filters);
            }}
        />
    );
}
```

---

## PermissionGuard

**Import** : `import { PermissionGuard } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/framework-permissionguard--docs](https://storybook.vendure.io/?path=/docs/framework-permissionguard--docs)

### Exemples (1)

#### 1. Default

```tsx
<PermissionGuard requires={['UpdateTaxCategory']}>
    <Button type="submit">
        <Trans>Update</Trans>
    </Button>
</PermissionGuard>
```

---

## VendureImage

**Import** : `import { VendureImage } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/framework-vendureimage--docs](https://storybook.vendure.io/?path=/docs/framework-vendureimage--docs)

### Exemples (6)

#### 1. Default

```tsx
<VendureImage
     asset={asset}
     preset="thumb"
     className="w-full h-full object-contain"
 />
```

#### 2. Playground

```tsx
<VendureImage
     asset={asset}
     preset="thumb"
     className="w-full h-full object-contain"
 />
```

#### 3. Preset Sizes

```tsx
<VendureImage
     asset={asset}
     preset="thumb"
     className="w-full h-full object-contain"
 />
```

#### 4. Custom Dimensions

```tsx
<VendureImage
     asset={asset}
     preset="thumb"
     className="w-full h-full object-contain"
 />
```

#### 5. Formats

```tsx
<VendureImage
     asset={asset}
     preset="thumb"
     className="w-full h-full object-contain"
 />
```

#### 6. Fallbacks

```tsx
<VendureImage
     asset={asset}
     preset="thumb"
     className="w-full h-full object-contain"
 />
```

---

## 📚 Ressources

- [Storybook Vendure](https://storybook.vendure.io)
- [Documentation Vendure](https://docs.vendure.io)
