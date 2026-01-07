# AssetGallery


## AssetGallery​


[​](#assetgallery)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[asset-gallery.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/shared/asset/asset-gallery.tsx#L160)A component for displaying a gallery of assets.

Example

```
 <AssetGallery  onSelect={handleAssetSelect}  multiSelect="manual"  initialSelectedAssets={initialSelectedAssets}  fixedHeight={false}  displayBulkActions={false}  />
```

```
function AssetGallery(props: AssetGalleryProps): void
```

Parameters

### props​


[​](#props)[AssetGalleryProps](/reference/dashboard/components/asset-gallery#assetgalleryprops)
## AssetGalleryProps​


[​](#assetgalleryprops)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[asset-gallery.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/shared/asset/asset-gallery.tsx#L83)Props for the AssetGallery component.

[AssetGallery](/reference/dashboard/components/asset-gallery#assetgallery)
```
interface AssetGalleryProps {    onSelect?: (assets: Asset[]) => void;    selectable?: boolean;    multiSelect?: 'auto' | 'manual';    initialSelectedAssets?: Asset[];    pageSize?: number;    fixedHeight?: boolean;    showHeader?: boolean;    className?: string;    onFilesDropped?: (files: File[]) => void;    bulkActions?: AssetBulkAction[];    displayBulkActions?: boolean;    onPageSizeChange?: (pageSize: number) => void;}
```

### onSelect​


[​](#onselect)[Asset](/reference/typescript-api/entities/asset#asset)
### selectable​


[​](#selectable)
### multiSelect​


[​](#multiselect)Defines whether multiple assets can be selected.

If set to 'auto', the asset selection will be toggled when the user clicks on an asset.
If set to 'manual', multiple selection will occur only if the user holds down the control/cmd key.

### initialSelectedAssets​


[​](#initialselectedassets)[Asset](/reference/typescript-api/entities/asset#asset)The initial assets that should be selected.

### pageSize​


[​](#pagesize)The number of assets to display per page.

### fixedHeight​


[​](#fixedheight)Whether the gallery should have a fixed height.

### showHeader​


[​](#showheader)Whether the gallery should show a header.

### className​


[​](#classname)The class name to apply to the gallery.

### onFilesDropped​


[​](#onfilesdropped)The function to call when files are dropped.

### bulkActions​


[​](#bulkactions)The bulk actions to display in the gallery.

### displayBulkActions​


[​](#displaybulkactions)Whether the gallery should display bulk actions.

### onPageSizeChange​


[​](#onpagesizechange)The function to call when the page size changes.


---

# AssetPickerDialog


## AssetPickerDialog​


[​](#assetpickerdialog)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[asset-picker-dialog.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/shared/asset/asset-picker-dialog.tsx#L60)A dialog which allows the creation and selection of assets.

```
function AssetPickerDialog(props: AssetPickerDialogProps): void
```

Parameters

### props​


[​](#props)[AssetPickerDialogProps](/reference/dashboard/components/asset-picker-dialog#assetpickerdialogprops)
## AssetPickerDialogProps​


[​](#assetpickerdialogprops)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[asset-picker-dialog.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/shared/asset/asset-picker-dialog.tsx#L19)Props for the AssetPickerDialog component.

[AssetPickerDialog](/reference/dashboard/components/asset-picker-dialog#assetpickerdialog)
```
interface AssetPickerDialogProps {    open: boolean;    onClose: () => void;    onSelect: (assets: Asset[]) => void;    multiSelect?: boolean;    initialSelectedAssets?: Asset[];    title?: string;}
```

### open​


[​](#open)Whether the dialog is open.

### onClose​


[​](#onclose)The function to call when the dialog is closed.

### onSelect​


[​](#onselect)[Asset](/reference/typescript-api/entities/asset#asset)The function to call when assets are selected.

### multiSelect​


[​](#multiselect)Whether multiple assets can be selected.

### initialSelectedAssets​


[​](#initialselectedassets)[Asset](/reference/typescript-api/entities/asset#asset)The initial assets that should be selected.

### title​


[​](#title)The title of the dialog.


---

# ChannelChip


## ChannelChip​


[​](#channelchip)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[channel-chip.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/shared/channel-chip.tsx#L18)A component for displaying a channel as a chip.

```
function ChannelChip(props: Readonly<ChannelChipProps>): void
```

Parameters

### props​


[​](#props)


---

# DetailPageButton


## DetailPageButton​


[​](#detailpagebutton)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[detail-page-button.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/shared/detail-page-button.tsx#L33)DetailPageButton is a reusable navigation component designed to provide consistent UX
across list views when linking to detail pages. It renders as a ghost button with
a chevron indicator, making it easy for users to identify clickable links that
navigate to detail views.

Example

```
// Basic usage with ID (relative navigation)<DetailPageButton id="123" label="Product Name" />*Example*```tsx// Custom href with search params<DetailPageButton  href="/products/detail/456"  label="Custom Product"  search={{ tab: 'variants' }}/>
```

```
function DetailPageButton(props: Readonly<{    label: string | React.ReactNode;    id?: string;    href?: string;    disabled?: boolean;    search?: Record<string, string>;    className?: string;}>): void
```

Parameters

### props​


[​](#props)


---

# FacetValueChip


## FacetValueChip​


[​](#facetvaluechip)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[facet-value-chip.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/shared/facet-value-chip.tsx#L30)A component for displaying a facet value as a chip.

```
function FacetValueChip(props: FacetValueChipProps): void
```

Parameters

### props​


[​](#props)


---

# FacetValueSelector


## FacetValueSelector​


[​](#facetvalueselector)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[facet-value-selector.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/shared/facet-value-selector.tsx#L143)A component for selecting facet values.

Example

```
<FacetValueSelector onValueSelect={onValueSelectHandler} disabled={disabled} />
```

```
function FacetValueSelector(props: FacetValueSelectorProps): void
```

Parameters

### props​


[​](#props)[FacetValueSelectorProps](/reference/dashboard/components/facet-value-selector#facetvalueselectorprops)
## FacetValueSelectorProps​


[​](#facetvalueselectorprops)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[facet-value-selector.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/shared/facet-value-selector.tsx#L40)A component for selecting facet values.

```
interface FacetValueSelectorProps {    onValueSelect: (value: FacetValue) => void;    disabled?: boolean;    placeholder?: string;    pageSize?: number;}
```

### onValueSelect​


[​](#onvalueselect)[FacetValue](/reference/typescript-api/entities/facet-value#facetvalue)The function to call when a facet value is selected.

The value will have the following structure:

```
{    id: string;    name: string;    code: string;    facet: {        id: string;        name: string;        code: string;    };}
```

### disabled​


[​](#disabled)Whether the selector is disabled.

### placeholder​


[​](#placeholder)The placeholder text for the selector.

### pageSize​


[​](#pagesize)The number of facet values to display per page.


---

# PermissionGuard


## PermissionGuard​


[​](#permissionguard)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[permission-guard.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/shared/permission-guard.tsx#L44)This component is used to protect a route from unauthorized access.
It will render the children if the user has the required permissions.

Example

```
<PermissionGuard requires={['UpdateTaxCategory']}>    <Button type="submit">        <Trans>Update</Trans>    </Button></PermissionGuard>
```

```
function PermissionGuard(props: Readonly<PermissionGuardProps>): void
```

Parameters

### props​


[​](#props)[PermissionGuardProps](/reference/dashboard/components/permission-guard#permissionguardprops)
## PermissionGuardProps​


[​](#permissionguardprops)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[permission-guard.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/shared/permission-guard.tsx#L12)The props for the PermissionGuard component.

```
interface PermissionGuardProps {    requires: Permission | string | string[] | Permission[];    children: React.ReactNode;}
```

### requires​


[​](#requires)[Permission](/reference/typescript-api/common/permission#permission)[Permission](/reference/typescript-api/common/permission#permission)The permission(s) required to access the children.

### children​


[​](#children)The children to render if the user has the required permissions.


---

# VendureImage


## VendureImage​


[​](#vendureimage)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[vendure-image.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/shared/vendure-image.tsx#L141)A component for displaying an image from a Vendure asset.

Supports the following features:

- Presets
- Cropping
- Resizing
- Formatting
- Quality
- Focal point
- Fallback

Example

```
 <VendureImage     asset={asset}     preset="thumb"     className="w-full h-full object-contain" />
```

```
function VendureImage(props: VendureImageProps): void
```

Parameters

### props​


[​](#props)[VendureImageProps](/reference/dashboard/components/vendure-image#vendureimageprops)
## VendureImageProps​


[​](#vendureimageprops)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[vendure-image.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/shared/vendure-image.tsx#L59)The props for the VendureImage component.

[VendureImage](/reference/dashboard/components/vendure-image#vendureimage)
```
interface VendureImageProps extends React.ImgHTMLAttributes<HTMLImageElement> {    asset: AssetLike | null | undefined;    preset?: ImagePreset;    mode?: ImageMode;    width?: number;    height?: number;    format?: ImageFormat;    quality?: number;    useFocalPoint?: boolean;    fallback?: React.ReactNode;    ref?: React.Ref<HTMLImageElement>;}
```

- Extends: React.ImgHTMLAttributes<HTMLImageElement>

### asset​


[​](#asset)[AssetLike](/reference/dashboard/components/vendure-image#assetlike)The asset to display.

### preset​


[​](#preset)[ImagePreset](/reference/dashboard/components/vendure-image#imagepreset)The preset to use for the image.

### mode​


[​](#mode)[ImageMode](/reference/dashboard/components/vendure-image#imagemode)The crop/resize mode to use for the image.

### width​


[​](#width)The width of the image.

### height​


[​](#height)The height of the image.

### format​


[​](#format)[ImageFormat](/reference/dashboard/components/vendure-image#imageformat)The format of the image.

### quality​


[​](#quality)The quality of the image.

### useFocalPoint​


[​](#usefocalpoint)Whether to use the asset's focal point in crop mode.

### fallback​


[​](#fallback)The fallback to show if no asset is provided. If no fallback is provided,
a default placeholder will be shown.

### ref​


[​](#ref)The ref to the image element.

## AssetLike​


[​](#assetlike)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[vendure-image.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/shared/vendure-image.tsx#L13)The type of object that can be used as an asset in the VendureImage component.

[VendureImage](/reference/dashboard/components/vendure-image#vendureimage)
```
interface AssetLike {    id: string;    preview: string;    name?: string | null;    focalPoint?: { x: number; y: number } | null;}
```

### id​


[​](#id)
### preview​


[​](#preview)
### name​


[​](#name)
### focalPoint​


[​](#focalpoint)
## ImagePreset​


[​](#imagepreset)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[vendure-image.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/shared/vendure-image.tsx#L28)The presets that can be used for the VendureImage component.

[VendureImage](/reference/dashboard/components/vendure-image#vendureimage)
```
type ImagePreset = 'tiny' | 'thumb' | 'small' | 'medium' | 'large' | 'full' | null
```

## ImageFormat​


[​](#imageformat)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[vendure-image.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/shared/vendure-image.tsx#L38)The formats that can be used for the VendureImage component.

[VendureImage](/reference/dashboard/components/vendure-image#vendureimage)
```
type ImageFormat = 'jpg' | 'jpeg' | 'png' | 'webp' | 'avif' | null
```

## ImageMode​


[​](#imagemode)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[vendure-image.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/shared/vendure-image.tsx#L48)The modes that can be used for the VendureImage component.

[VendureImage](/reference/dashboard/components/vendure-image#vendureimage)
```
type ImageMode = 'crop' | 'resize' | null
```


---

# DetailPage


## DetailPage​


[​](#detailpage)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[detail-page.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/page/detail-page.tsx#L147)Auto-generates a detail page with a form based on the provided query and mutation documents.

For more control over the layout, you would use the more low-level Page component.

[Page](/reference/dashboard/page-layout/page#page)
```
function DetailPage<T extends TypedDocumentNode<any, any>, C extends TypedDocumentNode<any, any>, U extends TypedDocumentNode<any, any>>(props: DetailPageProps<T, C, U>): void
```

Parameters

### props​


[​](#props)[DetailPageProps](/reference/dashboard/detail-views/detail-page#detailpageprops)
## DetailPageProps​


[​](#detailpageprops)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[detail-page.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/page/detail-page.tsx#L43)Props to configure the DetailPage component.

[DetailPage](/reference/dashboard/detail-views/detail-page#detailpage)
```
interface DetailPageProps<T extends TypedDocumentNode<any, any>, C extends TypedDocumentNode<any, any>, U extends TypedDocumentNode<any, any>, EntityField extends keyof ResultOf<T> = DetailEntityPath<T>> {    entityName?: string;    pageId: string;    route: AnyRoute;    title: (entity: ResultOf<T>[EntityField]) => string;    queryDocument: T;    createDocument?: C;    updateDocument: U;    setValuesForUpdate: (entity: ResultOf<T>[EntityField]) => VariablesOf<U>['input'];}
```

### entityName​


[​](#entityname)The name of the entity.
If not provided, it will be inferred from the query document.

### pageId​


[​](#pageid)A unique identifier for the page.

### route​


[​](#route)The Tanstack Router route used to navigate to this page.

### title​


[​](#title)The title of the page.

### queryDocument​


[​](#querydocument)The query document used to fetch the entity.

### createDocument​


[​](#createdocument)The mutation document used to create the entity.

### updateDocument​


[​](#updatedocument)The mutation document used to update the entity.

### setValuesForUpdate​


[​](#setvaluesforupdate)A function that sets the values for the update input type based on the entity.


---

# UseDetailPage


## useDetailPage​


[​](#usedetailpage)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[use-detail-page.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/page/use-detail-page.ts#L240)Status: Developer Preview

This hook is used to create an entity detail page which can read
and update an entity.

Example

```
const { form, submitHandler, entity, isPending, resetForm } = useDetailPage({    queryDocument: paymentMethodDetailDocument,    createDocument: createPaymentMethodDocument,    updateDocument: updatePaymentMethodDocument,    setValuesForUpdate: entity => {        return {            id: entity.id,            enabled: entity.enabled,            name: entity.name,            code: entity.code,            description: entity.description,            checker: entity.checker?.code                ? {                      code: entity.checker?.code,                      arguments: entity.checker?.args,                  }                : null,            handler: entity.handler?.code                ? {                      code: entity.handler?.code,                      arguments: entity.handler?.args,                  }                : null,            translations: entity.translations.map(translation => ({                id: translation.id,                languageCode: translation.languageCode,                name: translation.name,                description: translation.description,            })),            customFields: entity.customFields,        };    },    transformCreateInput: input => {        return {            ...input,            checker: input.checker?.code ? input.checker : undefined,            handler: input.handler,        };    },    params: { id: params.id },    onSuccess: async data => {        toast.success(i18n.t('Successfully updated payment method'));        resetForm();        if (creatingNewEntity) {            await navigate({ to: `../$id`, params: { id: data.id } });        }    },    onError: err => {        toast.error(i18n.t('Failed to update payment method'), {            description: err instanceof Error ? err.message : 'Unknown error',        });    },});
```

```
function useDetailPage<T extends TypedDocumentNode<any, any>, C extends TypedDocumentNode<any, any>, U extends TypedDocumentNode<any, any>, EntityField extends keyof ResultOf<T> = keyof ResultOf<T>, VarNameUpdate extends keyof VariablesOf<U> = 'input', VarNameCreate extends keyof VariablesOf<C> = 'input'>(options: DetailPageOptions<T, C, U, EntityField, VarNameCreate, VarNameUpdate>): UseDetailPageResult<T, U, EntityField>
```

Parameters

### options​


[​](#options)[DetailPageOptions](/reference/dashboard/detail-views/use-detail-page#detailpageoptions)
## DetailPageOptions​


[​](#detailpageoptions)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[use-detail-page.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/page/use-detail-page.ts#L46)Options used to configure the result of the useDetailPage hook.

```
interface DetailPageOptions<T extends TypedDocumentNode<any, any>, C extends TypedDocumentNode<any, any>, U extends TypedDocumentNode<any, any>, EntityField extends keyof ResultOf<T> = DetailEntityPath<T>, VarNameCreate extends keyof VariablesOf<C> = 'input', VarNameUpdate extends keyof VariablesOf<U> = 'input'> {    pageId?: string;    queryDocument: T;    entityField?: EntityField;    params: {        id: string;    };    entityName?: string;    createDocument?: C;    updateDocument?: U;    setValuesForUpdate: (        entity: NonNullable<ResultOf<T>[EntityField]>,    ) => WithLooseCustomFields<VariablesOf<U>[VarNameUpdate]>;    transformCreateInput?: (input: VariablesOf<C>[VarNameCreate]) => VariablesOf<C>[VarNameCreate];    transformUpdateInput?: (input: VariablesOf<U>[VarNameUpdate]) => VariablesOf<U>[VarNameUpdate];    onSuccess?: (entity: ResultOf<C>[keyof ResultOf<C>] | ResultOf<U>[keyof ResultOf<U>]) => void;    onError?: (error: unknown) => void;}
```

### pageId​


[​](#pageid)The page id. This is optional, but if provided, it will be used to
identify the page when extending the detail page query

### queryDocument​


[​](#querydocument)The query document to fetch the entity.

### entityField​


[​](#entityfield)The field of the query document that contains the entity.

### params​


[​](#params)The parameters used to identify the entity.

### entityName​


[​](#entityname)The entity type name for custom field configuration lookup.
Required to filter out readonly custom fields before mutations.
If not provided, the function will try to infer it from the query document.

### createDocument​


[​](#createdocument)The document to create the entity.

### updateDocument​


[​](#updatedocument)The document to update the entity.

### setValuesForUpdate​


[​](#setvaluesforupdate)The function to set the values for the update document.

### transformCreateInput​


[​](#transformcreateinput)
### transformUpdateInput​


[​](#transformupdateinput)
### onSuccess​


[​](#onsuccess)The function to call when the update is successful.

### onError​


[​](#onerror)The function to call when the update is successful.

## UseDetailPageResult​


[​](#usedetailpageresult)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[use-detail-page.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/page/use-detail-page.ts#L158)
```
interface UseDetailPageResult<T extends TypedDocumentNode<any, any>, U extends TypedDocumentNode<any, any>, EntityField extends keyof ResultOf<T>> {    form: UseFormReturn<RemoveNullFields<VariablesOf<U>['input']>>;    submitHandler: (event: FormEvent<HTMLFormElement>) => void;    entity?: DetailPageEntity<T, EntityField>;    isPending: boolean;    refreshEntity: () => void;    resetForm: () => void;}
```

### form​


[​](#form)
### submitHandler​


[​](#submithandler)
### entity​


[​](#entity)
### isPending​


[​](#ispending)
### refreshEntity​


[​](#refreshentity)
### resetForm​


[​](#resetform)


---

# UseGeneratedForm


## useGeneratedForm​


[​](#usegeneratedform)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[use-generated-form.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/form-engine/use-generated-form.tsx#L86)This hook is used to create a form from a document and an entity.
It will create a form with the fields defined in the document's input type.
It will also create a submit handler that will submit the form to the server.

This hook is mostly used internally by the higher-level useDetailPage hook,
but can in some cases be useful to use directly.

[useDetailPage](/reference/dashboard/detail-views/use-detail-page#usedetailpage)Example

```
const { form, submitHandler } = useGeneratedForm({ document: setDraftOrderCustomFieldsDocument, varName: undefined, entity: entity, setValues: entity => {   return {     orderId: entity.id,     input: {       customFields: entity.customFields,     },   }; },});
```

```
function useGeneratedForm<T extends TypedDocumentNode<any, any>, VarName extends keyof VariablesOf<T> | undefined, E extends Record<string, any> = Record<string, any>>(options: GeneratedFormOptions<T, VarName, E>): void
```

Parameters

### options​


[​](#options)[GeneratedFormOptions](/reference/dashboard/detail-views/use-generated-form#generatedformoptions)
## GeneratedFormOptions​


[​](#generatedformoptions)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[use-generated-form.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/form-engine/use-generated-form.tsx#L24)Options for the useGeneratedForm hook.

```
interface GeneratedFormOptions<T extends TypedDocumentNode<any, any>, VarName extends keyof VariablesOf<T> | undefined = 'input', E extends Record<string, any> = Record<string, any>> {    document?: T;    varName?: VarName;    entity: E | null | undefined;    customFieldConfig?: any[];    setValues: (        entity: NonNullable<E>,    ) => WithLooseCustomFields<        VarName extends keyof VariablesOf<T> ? VariablesOf<T>[VarName] : VariablesOf<T>    >;    onSubmit?: (        values: VarName extends keyof VariablesOf<T> ? VariablesOf<T>[VarName] : VariablesOf<T>,    ) => void;}
```

### document​


[​](#document)The document to use to generate the form.

### varName​


[​](#varname)The name of the variable to use in the document.

### entity​


[​](#entity)The entity to use to generate the form.

### customFieldConfig​


[​](#customfieldconfig)
### setValues​


[​](#setvalues)
### onSubmit​


[​](#onsubmit)


---

# ActionBar


## DashboardActionBarItem​


[​](#dashboardactionbaritem)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[layout.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/extension-api/types/layout.ts#L17)Allows you to define custom action bar items for any page in the dashboard, which is the
top bar that normally contains the main call-to-action buttons such as "update" or "create".

This API also allows you to specify dropdown menu items, which when defined, will appear in
a context menu to the very right of the ActionBar.

```
interface DashboardActionBarItem {    pageId: string;    component: React.FunctionComponent<{ context: PageContextValue }>;    type?: 'button' | 'dropdown';    requiresPermission?: string | string[];}
```

### pageId​


[​](#pageid)The ID of the page where the action bar item should be displayed.

### component​


[​](#component)A React component that will be rendered in the action bar. Typically, you would use
the default Shadcn <Button> component.

### type​


[​](#type)The type of action bar item to display. Defaults to button.
The 'dropdown' type is used to display the action bar item as a dropdown menu item.

When using the dropdown type, use a suitable dropdown item
component, such as:

[dropdown item](https://ui.shadcn.com/docs/components/dropdown-menu)
```
import { DropdownMenuItem } from '@vendure/dashboard';// ...{  component: () => <DropdownMenuItem>My Item</DropdownMenuItem>}
```

### requiresPermission​


[​](#requirespermission)Any permissions that are required to display this action bar item.


---

# Alerts


## DashboardAlertDefinition​


[​](#dashboardalertdefinition)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[alerts.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/extension-api/types/alerts.ts#L11)Allows you to define custom alerts that can be displayed in the dashboard.

```
interface DashboardAlertDefinition<TResponse = any> {    id: string;    title: string | ((data: TResponse) => string);    description?: string | ((data: TResponse) => string);    severity: AlertSeverity | ((data: TResponse) => AlertSeverity);    check: () => Promise<TResponse> | TResponse;    shouldShow: (data: TResponse) => boolean;    recheckInterval?: number;    actions?: Array<{        label: string;        onClick: (args: { data: TResponse; dismiss: () => void }) => void | Promise<any>;    }>;}
```

### id​


[​](#id)A unique identifier for the alert.

### title​


[​](#title)The title of the alert. Can be a string or a function that returns a string based on the response data.

### description​


[​](#description)The description of the alert. Can be a string or a function that returns a string based on the response data.

### severity​


[​](#severity)The severity level of the alert.

### check​


[​](#check)A function that checks the condition and returns the response data.

### shouldShow​


[​](#shouldshow)A function that determines whether the alert should be rendered based on the response data.

### recheckInterval​


[​](#recheckinterval)The interval in milliseconds to recheck the condition.

### actions​


[​](#actions)Optional actions that can be performed when the alert is shown.

The onClick() handler will receive the data returned by the check function,
as well as a dismiss() function that can be used to immediately dismiss the
current alert.


---

# DataTables


## DashboardDataTableExtensionDefinition​


[​](#dashboarddatatableextensiondefinition)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[data-table.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/extension-api/types/data-table.ts#L131)This allows you to customize aspects of existing data tables in the dashboard.

```
interface DashboardDataTableExtensionDefinition {    pageId: string;    blockId?: string;    bulkActions?: BulkAction[];    extendListDocument?: string | DocumentNode | (() => DocumentNode | string);    displayComponents?: DashboardDataTableDisplayComponent[];}
```

### pageId​


[​](#pageid)The ID of the page where the data table is located, e.g. 'product-list', 'order-list'.

### blockId​


[​](#blockid)The ID of the data table block. Defaults to 'list-table', which is the default blockId
for the standard list pages. However, some other pages may use a different blockId,
such as 'product-variants-table' on the 'product-detail' page.

### bulkActions​


[​](#bulkactions)[BulkAction](/reference/dashboard/list-views/bulk-actions#bulkaction)An array of additional bulk actions that will be available on the data table.

### extendListDocument​


[​](#extendlistdocument)Allows you to extend the list document for the data table.

### displayComponents​


[​](#displaycomponents)[DashboardDataTableDisplayComponent](/reference/dashboard/list-views/data-table#dashboarddatatabledisplaycomponent)Custom display components for specific columns in the data table.


---

# DefineDashboardExtension


## defineDashboardExtension​


[​](#definedashboardextension)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[define-dashboard-extension.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/extension-api/define-dashboard-extension.ts#L62)The main entry point for extensions to the React-based dashboard. Every dashboard extension
must contain a call to this function, usually in the entry point file that is referenced by
the dashboard property of the plugin decorator.

Every type of customisation of the dashboard can be defined here, including:

- Navigation (nav sections and routes)
- Layout (action bar items and page blocks)
- Widgets
- Form components (custom form components, input components, and display components)
- Data tables
- Detail forms
- Login
- Custom history entries

Example

```
defineDashboardExtension({ navSections: [], routes: [], pageBlocks: [], actionBarItems: [],});
```

```
function defineDashboardExtension(extension: DashboardExtension): void
```

Parameters

### extension​


[​](#extension)[DashboardExtension](/reference/dashboard/extensions-api/define-dashboard-extension#dashboardextension)
## DashboardExtension​


[​](#dashboardextension)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[extension-api-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/extension-api/extension-api-types.ts#L34)This is the main interface for defining all extensions to the dashboard.

Every type of customisation of the dashboard can be defined here, including:

- Navigation (nav sections and routes)
- Layout (action bar items and page blocks)
- Widgets for the Insights page
- Form components
- Data tables
- Detail forms
- Login page customisation

```
interface DashboardExtension {    routes?: DashboardRouteDefinition[];    navSections?: DashboardNavSectionDefinition[];    pageBlocks?: DashboardPageBlockDefinition[];    actionBarItems?: DashboardActionBarItem[];    alerts?: DashboardAlertDefinition[];    widgets?: DashboardWidgetDefinition[];    customFormComponents?: DashboardCustomFormComponents;    dataTables?: DashboardDataTableExtensionDefinition[];    detailForms?: DashboardDetailFormExtensionDefinition[];    login?: DashboardLoginExtensions;    historyEntries?: DashboardHistoryEntryComponent[];}
```

### routes​


[​](#routes)[DashboardRouteDefinition](/reference/dashboard/extensions-api/routes#dashboardroutedefinition)Allows you to define custom routes such as list or detail views.

### navSections​


[​](#navsections)[DashboardNavSectionDefinition](/reference/dashboard/extensions-api/navigation#dashboardnavsectiondefinition)Allows you to define custom nav sections for the dashboard.

### pageBlocks​


[​](#pageblocks)[DashboardPageBlockDefinition](/reference/dashboard/extensions-api/page-blocks#dashboardpageblockdefinition)Allows you to define custom page blocks for any page in the dashboard.

### actionBarItems​


[​](#actionbaritems)[DashboardActionBarItem](/reference/dashboard/extensions-api/action-bar#dashboardactionbaritem)Allows you to define custom action bar items for any page in the dashboard.

### alerts​


[​](#alerts)[DashboardAlertDefinition](/reference/dashboard/extensions-api/alerts#dashboardalertdefinition)Allows you to define custom alerts that can be displayed in the dashboard.

### widgets​


[​](#widgets)[DashboardWidgetDefinition](/reference/dashboard/extensions-api/widgets#dashboardwidgetdefinition)Allows you to define custom routes for the dashboard, which will render the
given components and optionally also add a nav menu item.

### customFormComponents​


[​](#customformcomponents)[DashboardCustomFormComponents](/reference/dashboard/extensions-api/form-components#dashboardcustomformcomponents)Unified registration for custom form custom field components.

### dataTables​


[​](#datatables)[DashboardDataTableExtensionDefinition](/reference/dashboard/extensions-api/data-tables#dashboarddatatableextensiondefinition)Allows you to customize aspects of existing data tables in the dashboard.

### detailForms​


[​](#detailforms)[DashboardDetailFormExtensionDefinition](/reference/dashboard/extensions-api/detail-forms#dashboarddetailformextensiondefinition)Allows you to customize the detail form for any page in the dashboard.

### login​


[​](#login)[DashboardLoginExtensions](/reference/dashboard/extensions-api/login#dashboardloginextensions)Allows you to customize the login page with custom components.

### historyEntries​


[​](#historyentries)[DashboardHistoryEntryComponent](/reference/dashboard/extensions-api/history-entries#dashboardhistoryentrycomponent)Allows a custom component to be used to render a history entry item
in the Order or Customer history lists.


---

# DetailForms


## DashboardDetailFormInputComponent​


[​](#dashboarddetailforminputcomponent)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[detail-forms.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/extension-api/types/detail-forms.ts#L13)Allows you to define custom input components for specific fields in detail forms.
The pageId is already defined in the detail form extension, so only the blockId and field are needed.

```
interface DashboardDetailFormInputComponent {    blockId: string;    field: string;    component: DashboardFormComponent;}
```

### blockId​


[​](#blockid)The ID of the block where this input component should be used.

### field​


[​](#field)The name of the field where this input component should be used.

### component​


[​](#component)[DashboardFormComponent](/reference/dashboard/extensions-api/form-components#dashboardformcomponent)The React component that will be rendered as the input.
It should accept value, onChange, and other standard input props.

## DashboardDetailFormExtensionDefinition​


[​](#dashboarddetailformextensiondefinition)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[detail-forms.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/extension-api/types/detail-forms.ts#L41)Allows you to extend existing detail forms (e.g. on the product detail or customer detail pages)
with custom GraphQL queries, input components, and display components.

```
interface DashboardDetailFormExtensionDefinition {    pageId: string;    extendDetailDocument?: string | DocumentNode | (() => DocumentNode | string);    inputs?: DashboardDetailFormInputComponent[];}
```

### pageId​


[​](#pageid)The ID of the page where the detail form is located, e.g. 'product-detail', 'order-detail'.

### extendDetailDocument​


[​](#extenddetaildocument)Extends the GraphQL query used to fetch data for the detail page, allowing you to add additional
fields that can be used by custom input or display components.

### inputs​


[​](#inputs)[DashboardDetailFormInputComponent](/reference/dashboard/extensions-api/detail-forms#dashboarddetailforminputcomponent)Custom input components for specific fields in the detail form.


---

# FormComponents


## DashboardCustomFormComponent​


[​](#dashboardcustomformcomponent)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[form-components.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/extension-api/types/form-components.ts#L11)Allows you to define custom form components for custom fields in the dashboard.

```
interface DashboardCustomFormComponent {    id: string;    component: DashboardFormComponent;}
```

### id​


[​](#id)A unique identifier for the custom form component. It is a good practice to namespace
these IDs to avoid naming collisions, for example "my-plugin.markdown-editor".

### component​


[​](#component)[DashboardFormComponent](/reference/dashboard/extensions-api/form-components#dashboardformcomponent)The React component that will be rendered as the custom form input.

## DashboardCustomFormComponents​


[​](#dashboardcustomformcomponents)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[form-components.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/extension-api/types/form-components.ts#L34)Interface for registering custom field components in the dashboard.
For input and display components, use the co-located approach with detailForms.

```
interface DashboardCustomFormComponents {    customFields?: DashboardCustomFormComponent[];}
```

### customFields​


[​](#customfields)[DashboardCustomFormComponent](/reference/dashboard/extensions-api/form-components#dashboardcustomformcomponent)Custom form components for custom fields. These are used when rendering
custom fields in forms.

## DashboardFormComponentProps​


[​](#dashboardformcomponentprops)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[form-engine-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/form-engine/form-engine-types.ts#L92)Props that get passed to all form input components. They are based on the
controller props used by the underlying react-hook-form, i.e.:

```
export type ControllerRenderProps = {    onChange: (event: any) => void;    onBlur: () => void;    value: any;    disabled?: boolean;    name: string;    ref: RefCallBack;};
```

in addition, they can optionally be passed a fieldDef prop if the
component is used in the context of a custom field or configurable operation arg.

The fieldDef arg, when present, has the following shape:

```
export type ConfigurableArgDef = {    defaultValue: any    description: string | null    label: string | null    list: boolean    name: string    required: boolean    type: string    ui: any}
```

```
type DashboardFormComponentProps<TFieldValues extends FieldValues = FieldValues, TName extends FieldPath<TFieldValues> = FieldPath<TFieldValues>> = ControllerRenderProps<TFieldValues, TName> & {    fieldDef?: ConfigurableFieldDef;}
```

## DashboardFormComponentMetadata​


[​](#dashboardformcomponentmetadata)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[form-engine-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/form-engine/form-engine-types.ts#L124)Metadata which can be defined on a DashboardFormComponent which
provides additional information about how the dashboard should render the
component.

[DashboardFormComponent](/reference/dashboard/extensions-api/form-components#dashboardformcomponent)The metadata is defined by adding the static property on the component:

Example

```
export const MyCustomInput: DashboardFormComponent = props => {  // implementation omitted}MyCustomInput.metadata = {  isListInput: true}
```

```
type DashboardFormComponentMetadata = {    isListInput?: boolean | 'dynamic';    isFullWidth?: boolean;}
```

### isListInput​


[​](#islistinput)Defines whether this form component is designed to handle list inputs.
If set to 'dynamic', it means the component has internal logic that can
handle both lists and single values.

### isFullWidth​


[​](#isfullwidth)TODO: not currently implemented

## DashboardFormComponent​


[​](#dashboardformcomponent)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[form-engine-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/form-engine/form-engine-types.ts#L167)This is the common type for all custom form components registered for:

- custom fields
- configurable operation args
- detail page fields

Here's a simple example:

```
import { DashboardFormComponent, Input } from '@vendure/dashboard';const MyComponent: DashboardFormComponent = (props) => {    return <Input value={props.value}                  onChange={props.onChange}                  onBlur={props.onBlur}                  name={props.name}                  disabled={props.disabled}                  ref={props.ref}                  />;};
```

```
type DashboardFormComponent = React.ComponentType<DashboardFormComponentProps> & {    metadata?: DashboardFormComponentMetadata;}
```


---

# HistoryEntries


## DashboardHistoryEntryComponent​


[​](#dashboardhistoryentrycomponent)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[history-entries.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/extension-api/types/history-entries.ts#L96)A definition of a custom component that will be used to render the given
type of history entry.

Example

```
import { defineDashboardExtension, HistoryEntry } from '@vendure/dashboard';import { IdCard } from 'lucide-react';defineDashboardExtension({    historyEntries: [        {            type: 'CUSTOMER_TAX_ID_APPROVAL',            component: ({ entry, entity }) => {                return (                    <HistoryEntry                        entry={entry}                        title={'Tax ID verified'}                        timelineIconClassName={'bg-success text-success-foreground'}                        timelineIcon={<IdCard />}                    >                        <div className="text-xs">Approval reference: {entry.data.ref}</div>                    </HistoryEntry>                );            },        },    ], });
```

```
interface DashboardHistoryEntryComponent {    type: string;    component: React.ComponentType<{        entry: HistoryEntryItem;        entity: OrderHistoryOrderDetail | CustomerHistoryCustomerDetail;    }>;}
```

### type​


[​](#type)The type should correspond to a valid HistoryEntryType, such as

- CUSTOMER_REGISTERED
- ORDER_STATE_TRANSITION
- some custom type - see the HistoryService docs for a guide on
how to define custom history entry types.

[HistoryService](/reference/typescript-api/services/history-service#historyservice)
### component​


[​](#component)[HistoryEntryItem](/reference/dashboard/extensions-api/history-entries#historyentryitem)The component which is used to render the timeline entry. It should use the
HistoryEntry component and pass the appropriate props to configure
how it will be displayed.

[HistoryEntry](/reference/dashboard/extensions-api/history-entries#historyentry)The entity prop will be a subset of the Order object for Order history entries,
or a subset of the Customer object for customer history entries.

## HistoryEntryItem​


[​](#historyentryitem)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[history-entries.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/extension-api/types/history-entries.ts#L14)This object contains the information about the history entry.

```
interface HistoryEntryItem {    id: string;    type: string;    createdAt: string;    isPublic: boolean;    administrator?: {        id: string;        firstName: string;        lastName: string;    } | null;    data: any;}
```

### id​


[​](#id)
### type​


[​](#type-1)The HistoryEntryType, such as ORDER_STATE_TRANSITION.

### createdAt​


[​](#createdat)
### isPublic​


[​](#ispublic)Whether this entry is visible to customers via the Shop API

### administrator​


[​](#administrator)If an Administrator created this entry, their details will
be available here.

### data​


[​](#data)The entry payload data. This will be an object, which is different
for each type of history entry.

For example, the CUSTOMER_ADDED_TO_GROUP data looks like this:

```
{  groupName: 'Some Group',}
```

and the ORDER_STATE_TRANSITION data looks like this:

```
{  from: 'ArrangingPayment',  to: 'PaymentSettled',}
```

## HistoryEntryProps​


[​](#historyentryprops)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[history-entry.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/history-entry/history-entry.tsx#L14)The props for the HistoryEntry component.

[HistoryEntry](/reference/dashboard/extensions-api/history-entries#historyentry)
```
interface HistoryEntryProps {    entry: HistoryEntryItem;    title: string | React.ReactNode;    timelineIcon?: React.ReactNode;    timelineIconClassName?: string;    actorName?: string;    children: React.ReactNode;    isPrimary?: boolean;}
```

### entry​


[​](#entry)[HistoryEntryItem](/reference/dashboard/extensions-api/history-entries#historyentryitem)The entry itself, which will get passed down to your custom component

### title​


[​](#title)The title of the entry

### timelineIcon​


[​](#timelineicon)An icon which is used to represent the entry. Note that this will only
display if isPrimary is true.

### timelineIconClassName​


[​](#timelineiconclassname)Optional tailwind classes to apply to the icon. For instance

```
const success = 'bg-success text-success-foreground';const destructive = 'bg-destructive text-destructive-foreground';
```

### actorName​


[​](#actorname)The name to display of "who did the action". For instance:

```
const getActorName = (entry: HistoryEntryItem) => {    if (entry.administrator) {        return `${entry.administrator.firstName} ${entry.administrator.lastName}`;    } else if (entity?.customer) {        return `${entity.customer.firstName} ${entity.customer.lastName}`;    }    return '';};
```

### children​


[​](#children)
### isPrimary​


[​](#isprimary)When set to true, the timeline entry will feature the specified icon and will not
be collapsible.

## HistoryEntry​


[​](#historyentry)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[history-entry.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/history-entry/history-entry.tsx#L74)A component which is used to display a history entry in the order/customer history timeline.

```
function HistoryEntry(props: Readonly<HistoryEntryProps>): void
```

Parameters

### props​


[​](#props)[HistoryEntryProps](/reference/dashboard/extensions-api/history-entries#historyentryprops)


---

# Login


## DashboardLoginExtensions​


[​](#dashboardloginextensions)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[login.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/extension-api/types/login.ts#L60)Defines all available login page extensions.

```
interface DashboardLoginExtensions {    logo?: LoginLogoExtension;    beforeForm?: LoginBeforeFormExtension;    afterForm?: LoginAfterFormExtension;}
```

### logo​


[​](#logo)[LoginLogoExtension](/reference/dashboard/extensions-api/login#loginlogoextension)Custom logo component to replace the default Vendure logo.

### beforeForm​


[​](#beforeform)[LoginBeforeFormExtension](/reference/dashboard/extensions-api/login#loginbeforeformextension)Component to render before the login form.

### afterForm​


[​](#afterform)[LoginAfterFormExtension](/reference/dashboard/extensions-api/login#loginafterformextension)Component to render after the login form.

## LoginLogoExtension​


[​](#loginlogoextension)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[login.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/extension-api/types/login.ts#L11)Defines a custom logo component for the login page.

```
interface LoginLogoExtension {    component: React.ComponentType;}
```

### component​


[​](#component)A React component that will replace the default Vendure logo.

## LoginBeforeFormExtension​


[​](#loginbeforeformextension)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[login.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/extension-api/types/login.ts#L27)Defines content to display before the login form.

```
interface LoginBeforeFormExtension {    component: React.ComponentType;}
```

### component​


[​](#component-1)A React component that will be rendered before the login form.

## LoginAfterFormExtension​


[​](#loginafterformextension)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[login.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/extension-api/types/login.ts#L43)Defines content to display after the login form.

```
interface LoginAfterFormExtension {    component: React.ComponentType;}
```

### component​


[​](#component-2)A React component that will be rendered after the login form.


---

# Navigation


## DashboardNavSectionDefinition​


[​](#dashboardnavsectiondefinition)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[navigation.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/extension-api/types/navigation.ts#L73)Defines a custom navigation section in the dashboard sidebar.

Individual items can then be added to the section by defining routes in the
routes property of your Dashboard extension.

```
interface DashboardNavSectionDefinition {    id: string;    title: string;    icon?: LucideIcon;    order?: number;    placement?: 'top' | 'bottom';}
```

### id​


[​](#id)A unique identifier for the navigation section.

### title​


[​](#title)The display title for the navigation section.

### icon​


[​](#icon)Optional icon to display next to the section title. The icons should
be imported from 'lucide-react'.

Example

```
import { PlusIcon } from 'lucide-react';
```

### order​


[​](#order)Optional order number to control the position of this section in the sidebar.

### placement​


[​](#placement)Optional placement to control the position of this section in the sidebar.

## NavMenuItem​


[​](#navmenuitem)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[nav-menu-extensions.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/nav-menu/nav-menu-extensions.ts#L16)Defines an items in the navigation menu.

```
interface NavMenuItem {    id: string;    title: string;    url: string;    icon?: LucideIcon;    order?: number;    placement?: NavMenuSectionPlacement;    requiresPermission?: string | string[];}
```

### id​


[​](#id-1)A unique ID for this nav menu item

### title​


[​](#title-1)The title that will appear in the nav menu

### url​


[​](#url)The url of the route which this nav item links to.

### icon​


[​](#icon-1)An optional icon component to represent the item,
which should be imported from lucide-react.

### order​


[​](#order-1)The order is an number which allows you to control
the relative position in relation to other items in the
menu.
A higher number appears further down the list.

### placement​


[​](#placement-1)
### requiresPermission​


[​](#requirespermission)This can be used to restrict the menu item to the given
permission or permissions.


---

# Page Blocks


## DashboardPageBlockDefinition​


[​](#dashboardpageblockdefinition)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[layout.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/extension-api/types/layout.ts#L95)This allows you to insert a custom component into a specific location
on any page in the dashboard.

```
interface DashboardPageBlockDefinition {    id: string;    title?: React.ReactNode;    location: PageBlockLocation;    component?: React.FunctionComponent<{ context: PageContextValue }>;    shouldRender?: (context: PageContextValue) => boolean;    requiresPermission?: string | string[];}
```

### id​


[​](#id)An ID for the page block. Should be unique at least
to the page in which it appears.

### title​


[​](#title)An optional title for the page block

### location​


[​](#location)[PageBlockLocation](/reference/dashboard/extensions-api/page-blocks#pageblocklocation)The location of the page block. It specifies the pageId, and then the
relative location compared to another existing block.

### component​


[​](#component)The component to be rendered inside the page block.

### shouldRender​


[​](#shouldrender)Control whether to render the page block depending on your custom
logic.

This can also be used to disable any built-in blocks you
do not need to display.

If you need to query aspects about the current context not immediately
provided in the PageContextValue, you can also use hooks such as
useChannel in this function.

### requiresPermission​


[​](#requirespermission)If provided, the logged-in user must have one or more of the specified
permissions in order for the block to render.

For more advanced control over rendering, use the shouldRender function.

## PageBlockPosition​


[​](#pageblockposition)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[layout.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/extension-api/types/layout.ts#L67)The relative position of a PageBlock. This is determined by finding an existing
block, and then specifying whether your custom block should come before, after,
or completely replace that block.

```
type PageBlockPosition = {    blockId: string;    order: 'before' | 'after' | 'replace'}
```

### blockId​


[​](#blockid)
### order​


[​](#order)
## PageBlockLocation​


[​](#pageblocklocation)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[layout.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/extension-api/types/layout.ts#L79)The location of a page block in the dashboard. The location can be found by turning on
"developer mode" in the dashboard user menu (bottom left corner) and then
clicking the < /> icon when hovering over a page block.

```
type PageBlockLocation = {    pageId: string;    position: PageBlockPosition;    column: 'main' | 'side' | 'full';}
```

### pageId​


[​](#pageid)
### position​


[​](#position)[PageBlockPosition](/reference/dashboard/extensions-api/page-blocks#pageblockposition)
### column​


[​](#column)


---

# Routes


## DashboardRouteDefinition​


[​](#dashboardroutedefinition)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[navigation.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/extension-api/types/navigation.ts#L15)Defines a custom route for the dashboard with optional navigation menu integration.

```
interface DashboardRouteDefinition {    component: (route: AnyRoute) => React.ReactNode;    path: string;    navMenuItem?: Partial<NavMenuItem> & { sectionId: string };    loader?: RouteOptions<any>['loader'];    validateSearch?: RouteOptions<any>['validateSearch'];    authenticated?: boolean;}
```

### component​


[​](#component)The React component that will be rendered for this route.

### path​


[​](#path)The URL path for this route, e.g. '/my-custom-page'.

### navMenuItem​


[​](#navmenuitem)[NavMenuItem](/reference/dashboard/extensions-api/navigation#navmenuitem)Optional navigation menu item configuration to add this route to the nav menu
on the left side of the dashboard.

The sectionId specifies which nav menu section (e.g. "catalog", "customers")
this item should appear in. It can also point to custom nav menu sections that
have been defined using the navSections extension property.

### loader​


[​](#loader)Optional loader function to fetch data before the route renders.
The value is a Tanstack Router
loader function

[loader function](https://tanstack.com/router/latest/docs/framework/react/guide/data-loading#route-loaders)
### validateSearch​


[​](#validatesearch)Optional search parameter validation function.
The value is a Tanstack Router
validateSearch function

[validateSearch function](https://tanstack.com/router/latest/docs/framework/react/guide/search-params#search-param-validation)
### authenticated​


[​](#authenticated)Define if the route should be under the authentication context, i.e have the authenticated route
as a parent.


---

# Widgets


## DashboardWidgetDefinition​


[​](#dashboardwidgetdefinition)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[widgets.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/extension-api/types/widgets.ts#L70)Status: Developer Preview

Defines a dashboard widget that can be added to the dashboard.

```
type DashboardWidgetDefinition = {    id: string;    name: string;    component: React.ComponentType<DashboardBaseWidgetProps>;    defaultSize: { w: number; h: number; x?: number; y?: number };    minSize?: { w: number; h: number };    maxSize?: { w: number; h: number };}
```

### id​


[​](#id)A unique identifier for the widget.

### name​


[​](#name)The display name of the widget.

### component​


[​](#component)[DashboardBaseWidgetProps](/reference/dashboard/extensions-api/widgets#dashboardbasewidgetprops)The React component that renders the widget.

### defaultSize​


[​](#defaultsize)The default size and position of the widget.

### minSize​


[​](#minsize)The minimum size constraints for the widget.

### maxSize​


[​](#maxsize)The maximum size constraints for the widget.

---

# AffixedInput


## AffixedInput​


[​](#affixedinput)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[affixed-input.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/data-input/affixed-input.tsx#L31)A component for displaying an input with a prefix and/or a suffix.

Example

```
<AffixedInput    {...field}    type="number"    suffix="%"    value={field.value}    onChange={e => field.onChange(e.target.valueAsNumber)}/>
```

```
function AffixedInput(props: Readonly<AffixedInputProps>): void
```

Parameters

### props​


[​](#props)


---

# BooleanInput


## BooleanInput​


[​](#booleaninput)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[boolean-input.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/data-input/boolean-input.tsx#L12)Displays a boolean value as a switch toggle.

```
function BooleanInput(props: Readonly<DashboardFormComponentProps>): void
```

Parameters

### props​


[​](#props)[DashboardFormComponentProps](/reference/dashboard/extensions-api/form-components#dashboardformcomponentprops)


---

# CheckboxInput


## CheckboxInput​


[​](#checkboxinput)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[checkbox-input.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/data-input/checkbox-input.tsx#L12)Displays a boolean value as a checkbox.

```
function CheckboxInput(props: Readonly<DashboardFormComponentProps>): void
```

Parameters

### props​


[​](#props)[DashboardFormComponentProps](/reference/dashboard/extensions-api/form-components#dashboardformcomponentprops)


---

# DateTimeInput


## DateTimeInput​


[​](#datetimeinput)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[datetime-input.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/data-input/datetime-input.tsx#L41)A component for selecting a date and time.

```
function DateTimeInput(props: Readonly<DashboardFormComponentProps>): void
```

Parameters

### props​


[​](#props)[DashboardFormComponentProps](/reference/dashboard/extensions-api/form-components#dashboardformcomponentprops)


---

# FormFieldWrapper


## FormFieldWrapper​


[​](#formfieldwrapper)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[form-field-wrapper.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/shared/form-field-wrapper.tsx#L74)This is a wrapper that can be used in all forms to wrap the actual form control, and provide a label, description and error message.

Use this instead of the default Shadcn FormField (etc.) components, as it also supports
overridden form components.

Example

```
<PageBlock column="main" blockId="main-form">    <DetailFormGrid>        <FormFieldWrapper            control={form.control}            name="description"            label={<Trans>Description</Trans>}            render={({ field }) => <Input {...field} />}        />        <FormFieldWrapper            control={form.control}            name="code"            label={<Trans>Code</Trans>}            render={({ field }) => <Input {...field} />}        />    </DetailFormGrid></PageBlock>
```

If you are dealing with translatable fields, use the TranslatableFormFieldWrapper component instead.

[TranslatableFormFieldWrapper](/reference/dashboard/form-components/translatable-form-field-wrapper#translatableformfieldwrapper)
```
function FormFieldWrapper<TFieldValues extends FieldValues = FieldValues, TName extends FieldPath<TFieldValues> = FieldPath<TFieldValues>>(props: FormFieldWrapperProps<TFieldValues, TName>): void
```

Parameters

### props​


[​](#props)[FormFieldWrapperProps](/reference/dashboard/form-components/form-field-wrapper#formfieldwrapperprops)
## FormFieldWrapperProps​


[​](#formfieldwrapperprops)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[form-field-wrapper.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/shared/form-field-wrapper.tsx#L14)The props for the FormFieldWrapper component.

```
type FormFieldWrapperProps<TFieldValues extends FieldValues = FieldValues, TName extends FieldPath<TFieldValues> = FieldPath<TFieldValues>> = React.ComponentProps<typeof FormField<TFieldValues, TName>> & {    /**     * @description     * The label for the form field.     */    label?: React.ReactNode;    /**     * @description     * The description for the form field.     */    description?: React.ReactNode;    /**     * @description     * Whether to render the form control.     * If false, the form control will not be rendered.     * This is useful when you want to render the form control in a custom way, e.g. for <Select/> components,     * where the FormControl needs to nested in the root component.     *     * @default true     */    renderFormControl?: boolean;}
```


---

# MoneyInput


## MoneyInput​


[​](#moneyinput)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[money-input.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/data-input/money-input.tsx#L22)A component for displaying a money value. The currency can be specified, but otherwise
will be taken from the active channel's default currency.

```
function MoneyInput(props: Readonly<MoneyInputProps>): void
```

Parameters

### props​


[​](#props)


---

# PasswordInput


## PasswordFormInput​


[​](#passwordforminput)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[password-form-input.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/data-input/password-form-input.tsx#L12)A component for displaying a password input.

```
function PasswordFormInput(props: Readonly<DashboardFormComponentProps>): void
```

Parameters

### props​


[​](#props)[DashboardFormComponentProps](/reference/dashboard/extensions-api/form-components#dashboardformcomponentprops)


---

# NumberInput


## NumberInput​


[​](#numberinput)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[number-input.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/data-input/number-input.tsx#L23)A component for displaying a numeric value.

```
function NumberInput(props: Readonly<NumberInputProps>): void
```

Parameters

### props​


[​](#props)


---

# RichTextInput


## RichTextInput​


[​](#richtextinput)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[rich-text-input.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/data-input/rich-text-input.tsx#L12)A component for displaying a rich text editor. Internally uses ProseMirror (rich text editor) under the hood.

```
function RichTextInput(props: Readonly<DashboardFormComponentProps>): void
```

Parameters

### props​


[​](#props)[DashboardFormComponentProps](/reference/dashboard/extensions-api/form-components#dashboardformcomponentprops)


---

# SlugInput


## SlugInput​


[​](#sluginput)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[slug-input.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/data-input/slug-input.tsx#L137)A component for generating and displaying slugs based on a watched field.
The component watches a source field for changes, debounces the input,
and generates a unique slug via the Admin API. The slug is only auto-generated
when it's empty. For existing slugs, a regenerate button allows manual regeneration.
The input is readonly by default but can be made editable with a toggle button.

Example

```
// In a TranslatableFormFieldWrapper context with translatable field<SlugInput    {...field}    entityName="Product"    fieldName="slug"    watchFieldName="name" // Automatically resolves to "translations.X.name"    entityId={productId}/>// In a TranslatableFormFieldWrapper context with non-translatable field<SlugInput    {...field}    entityName="Product"    fieldName="slug"    watchFieldName="enabled" // Uses "enabled" directly (base entity field)    entityId={productId}/>// For non-translatable entities<SlugInput    {...field}    entityName="Channel"    fieldName="code"    watchFieldName="name" // Uses "name" directly    entityId={channelId}/>
```

```
function SlugInput(props: SlugInputProps): void
```

Parameters

### props​


[​](#props)


---

# TextInput


## TextInput​


[​](#textinput)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[text-input.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/data-input/text-input.tsx#L13)A component for displaying a text input.


---

# TextareaInput


## TextareaInput​


[​](#textareainput)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[textarea-input.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/data-input/textarea-input.tsx#L12)A component for displaying a textarea input.

```
function TextareaInput(props: Readonly<DashboardFormComponentProps>): void
```

Parameters

### props​


[​](#props)[DashboardFormComponentProps](/reference/dashboard/extensions-api/form-components#dashboardformcomponentprops)


---

# TranslatableFormFieldWrapper


## TranslatableFormFieldWrapper​


[​](#translatableformfieldwrapper)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[translatable-form-field.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/shared/translatable-form-field.tsx#L112)This is the equivalent of the FormFieldWrapper component, but for translatable fields.

[FormFieldWrapper](/reference/dashboard/form-components/form-field-wrapper#formfieldwrapper)Example

```
<PageBlock column="main" blockId="main-form">    <DetailFormGrid>        <TranslatableFormFieldWrapper            control={form.control}            name="name"            label={<Trans>Product name</Trans>}            render={({ field }) => <Input {...field} />}        />        <TranslatableFormFieldWrapper            control={form.control}            name="slug"            label={<Trans>Slug</Trans>}            render={({ field }) => <Input {...field} />}        />    </DetailFormGrid>    <TranslatableFormFieldWrapper        control={form.control}        name="description"        label={<Trans>Description</Trans>}        render={({ field }) => <RichTextInput {...field} />}    /></PageBlock>
```

## TranslatableFormFieldProps​


[​](#translatableformfieldprops)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[translatable-form-field.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/shared/translatable-form-field.tsx#L22)The props for the TranslatableFormField component.

```
type TranslatableFormFieldProps<TFieldValues extends TranslatableEntity | TranslatableEntity[]> = Omit<    ControllerProps<TFieldValues>,    'name'> & {    /**     * @description     * The label for the form field.     */    label?: React.ReactNode;    /**     * @description     * The name of the form field.     */    name: TFieldValues extends TranslatableEntity        ? keyof Omit<NonNullable<TFieldValues['translations']>[number], 'languageCode'>        : TFieldValues extends TranslatableEntity[]            ? keyof Omit<NonNullable<TFieldValues[number]['translations']>[number], 'languageCode'>            : never;}
```


---

# UseAlerts


## useAlerts​


[​](#usealerts)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[use-alerts.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/hooks/use-alerts.ts#L31)Returns information about all registered Alerts, including how many are
active and at what severity.

```
function useAlerts(): { alerts: AlertEntry[]; activeCount: number; highestSeverity: AlertSeverity }
```

## AlertEntry​


[​](#alertentry)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[use-alerts.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/hooks/use-alerts.ts#L13)An individual Alert item.

```
interface AlertEntry {    definition: DashboardAlertDefinition;    active: boolean;    currentSeverity?: AlertSeverity;    lastData: any;    dismiss: () => void;}
```

### definition​


[​](#definition)[DashboardAlertDefinition](/reference/dashboard/extensions-api/alerts#dashboardalertdefinition)
### active​


[​](#active)
### currentSeverity​


[​](#currentseverity)
### lastData​


[​](#lastdata)
### dismiss​


[​](#dismiss)


---

# UseAuth


## useAuth​


[​](#useauth)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[use-auth.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/hooks/use-auth.tsx#L15)Provides access to the AuthContext which contains information
about the active channel.

[AuthContext](/reference/dashboard/hooks/use-auth#authcontext)
```
function useAuth(): void
```

## AuthContext​


[​](#authcontext)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[auth.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/providers/auth.tsx#L17)Provides information about the current user & their authentication & authorization
status.

```
interface AuthContext {    status: 'initial' | 'authenticated' | 'verifying' | 'unauthenticated';    authenticationError?: string;    isAuthenticated: boolean;    login: (username: string, password: string, onSuccess?: () => void) => void;    logout: (onSuccess?: () => void) => Promise<void>;    user: ResultOf<typeof CurrentUserQuery>['activeAdministrator'] | undefined;    channels: NonNullable<ResultOf<typeof CurrentUserQuery>['me']>['channels'] | undefined;    refreshCurrentUser: () => void;}
```

### status​


[​](#status)The status of the authentication.

### authenticationError​


[​](#authenticationerror)The error message if the authentication fails.

### isAuthenticated​


[​](#isauthenticated)Whether the user is authenticated.

### login​


[​](#login)The function to login the user.

### logout​


[​](#logout)The function to logout the user.

### user​


[​](#user)The user object.

### channels​


[​](#channels)The channels object.

### refreshCurrentUser​


[​](#refreshcurrentuser)The function to refresh the current user.


---

# UseChannel


## useChannel​


[​](#usechannel)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[use-channel.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/hooks/use-channel.ts#L21)Provides access to the ChannelContext which contains information
about the active channel.

[ChannelContext](/reference/dashboard/hooks/use-channel#channelcontext)Example

```
const { activeChannel } = useChannel();
```

```
function useChannel(): void
```

## ChannelContext​


[​](#channelcontext)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[channel-provider.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/providers/channel-provider.tsx#L71)Provides information about the active channel, and the means to set a new
active channel.

```
interface ChannelContext {    isLoading: boolean;    channels: Channel[];    activeChannel: ActiveChannel | undefined;    setActiveChannel: (channelId: string) => void;    refreshChannels: () => void;}
```

### isLoading​


[​](#isloading)Whether the channels are loading.

### channels​


[​](#channels)[Channel](/reference/typescript-api/entities/channel#channel)An array of all available channels.

### activeChannel​


[​](#activechannel)The active channel.

### setActiveChannel​


[​](#setactivechannel)The function to set the active channel.

### refreshChannels​


[​](#refreshchannels)The function to refresh the channels.


---

# UseCustomFieldConfig


## useCustomFieldConfig​


[​](#usecustomfieldconfig)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[use-custom-field-config.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/hooks/use-custom-field-config.ts#L15)Returns the custom field config for the given entity type (e.g. 'Product').
Also filters out any custom fields that the current active user does not
have permissions to access.

```
function useCustomFieldConfig(entityType: string): CustomFieldConfig[]
```

Parameters

### entityType​


[​](#entitytype)


---

# UseDisplayLocale


## useDisplayLocale​


[​](#usedisplaylocale)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[use-display-locale.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/hooks/use-display-locale.ts#L27)Returns information about the current display language & region.

Example

```
const {  bcp47Tag,  humanReadableLanguageAndLocale,  humanReadableLanguage,  isRTL,} = useDisplayLocale();console.log(bcp47Tag) // "en-GB"console.log(humanReadableLanguage) // "English"console.log(humanReadableLanguageAndLocale) // "British English"console.log(isRTL) // false
```

```
function useDisplayLocale(): void
```


---

# UseDragAndDrop


## useDragAndDrop​


[​](#usedraganddrop)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[use-drag-and-drop.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/hooks/use-drag-and-drop.ts#L22)Provides the sensors and state management for drag and drop functionality.

```
function useDragAndDrop<TData = any>(options: UseDragAndDropOptions<TData>): void
```

Parameters

### options​


[​](#options)


---

# UseLocalFormat


## useLocalFormat​


[​](#uselocalformat)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[use-local-format.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/hooks/use-local-format.ts#L27)This hook is used to format numbers and currencies using the configured language and
locale of the dashboard app.

Example

```
const {         formatCurrency,         formatNumber,         formatDate,         formatLanguageName,         formatCurrencyName,         toMajorUnits,} = useLocalFormat();
```

```
function useLocalFormat(): void
```



---

# UsePaginatedList


## usePaginatedList​


[​](#usepaginatedlist)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[paginated-list-data-table.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/shared/paginated-list-data-table.tsx#L179)Returns the context for the paginated list data table. Must be used within a PaginatedListDataTable.

Example

```
const { refetchPaginatedList } = usePaginatedList();const mutation = useMutation({    mutationFn: api.mutate(updateFacetValueDocument),    onSuccess: () => {        refetchPaginatedList();    },});
```

```
function usePaginatedList(): void
```


---

# UsePermissions


## usePermissions​


[​](#usepermissions)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[use-permissions.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/hooks/use-permissions.ts#L23)Returns a hasPermissions function that can be used to determine whether the active user
has the given permissions on the active channel.

Example

```
const { hasPermissions } = usePermissions();const canReadChannel = hasPermissions(['ReadChannel']);
```

```
function usePermissions(): void
```


---

# UseSortedLanguages


## useSortedLanguages​


[​](#usesortedlanguages)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[use-sorted-languages.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/hooks/use-sorted-languages.ts#L28)This hook takes an array of language codes and returns a sorted array of language objects
with code and localized label, sorted alphabetically by the label.

Example

```
const sortedLanguages = useSortedLanguages(['en', 'fr', 'de']);// Returns: [{ code: 'de', label: 'German' }, { code: 'en', label: 'English' }, { code: 'fr', label: 'French' }]
```

```
function useSortedLanguages(availableLanguages?: string[] | null): SortedLanguage[]
```

Parameters

### availableLanguages​


[​](#availablelanguages)


---

# UseUiLanguageLoader


## useUiLanguageLoader​


[​](#useuilanguageloader)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[use-ui-language-loader.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/hooks/use-ui-language-loader.ts#L15)Loads the UI translations for the given locale and activates it
with the Lingui I18nProvider. Generally this is used internally
when the display language is set via the user > language dialog.

```
function useUiLanguageLoader(): void
```


---

# UseWidgetFilters


## useWidgetFilters​


[​](#usewidgetfilters)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[widget-filters-context.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/dashboard-widget/widget-filters-context.tsx#L29)Exposes a context object for use in building Insights page widgets.

```
function useWidgetFilters(): void
```


---

# Bulk Actions


## DataTableBulkActionItemProps​


[​](#datatablebulkactionitemprops)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[data-table-bulk-action-item.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/data-table/data-table-bulk-action-item.tsx#L26)
```
interface DataTableBulkActionItemProps {    label: React.ReactNode;    icon?: LucideIcon;    confirmationText?: React.ReactNode;    onClick: () => void;    className?: string;    requiresPermission?: string[];    disabled?: boolean;}
```

### label​


[​](#label)
### icon​


[​](#icon)
### confirmationText​


[​](#confirmationtext)
### onClick​


[​](#onclick)
### className​


[​](#classname)
### requiresPermission​


[​](#requirespermission)
### disabled​


[​](#disabled)
## DataTableBulkActionItem​


[​](#datatablebulkactionitem)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[data-table-bulk-action-item.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/data-table/data-table-bulk-action-item.tsx#L67)A component that should be used to implement any bulk actions for list pages & data tables.

Example

```
import { Trans } from '@lingui/react/macro';import { DataTableBulkActionItem, BulkActionComponent } from '@vendure/dashboard';import { Check } from 'lucide-react';export const MyBulkAction: BulkActionComponent<any> = ({ selection, table }) => {  return (    <DataTableBulkActionItem      requiresPermission={['ReadMyCustomEntity']}      onClick={() => {        console.log('Selected items:', selection);      }}      label={<Trans>Delete</Trans>}      confirmationText={<Trans>Are you sure?</Trans>}      icon={Check}      className="text-destructive"    />  );}
```

```
function DataTableBulkActionItem(props: Readonly<DataTableBulkActionItemProps>): void
```

Parameters

### props​


[​](#props)[DataTableBulkActionItemProps](/reference/dashboard/list-views/bulk-actions#datatablebulkactionitemprops)
## BulkAction​


[​](#bulkaction)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[data-table.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/extension-api/types/data-table.ts#L109)A bulk action is a component that will be rendered in the bulk actions dropdown.

The component receives the following props:

- selection: The selected row or rows
- table: A reference to the Tanstack table instance powering the list

The table object has

Example

```
import { BulkActionComponent, DataTableBulkActionItem, usePaginatedList } from '@vendure/dashboard';// This is an example of a bulk action that shows some typical// uses of the provided propsexport const MyBulkAction: BulkActionComponent<any> = ({ selection, table }) => {  const { refetchPaginatedList } = usePaginatedList();  const doTheAction = async () => {    // Actual logic of the action    // goes here...    // On success, we refresh the list    refetchPaginatedList();    // and un-select any selected rows in the table    table.resetRowSelection();  }; return (   <DataTableBulkActionItem     onClick={doTheAction}     label={<Trans>Delete</Trans>}     confirmationText={<Trans>Are you sure?</Trans>}     icon={Check}     className="text-destructive"   /> );}
```

For the common action of deletion, we provide a ready-made helper component:

Example

```
import { BulkActionComponent, DeleteProductsBulkAction } from '@vendure/dashboard';// Define the BulkAction component. This one uses// a built-in wrapper for "delete" actions, which includes// a confirmation dialog.export const DeleteProductsBulkAction: BulkActionComponent<any> = ({ selection, table }) => {    return (        <DeleteBulkAction            mutationDocument={deleteProductsDocument}            entityName="products"            requiredPermissions={['DeleteCatalog', 'DeleteProduct']}            selection={selection}            table={table}        />    );};
```

```
type BulkAction = {    order?: number;    component: BulkActionComponent<any>;}
```

### order​


[​](#order)Optional order number to control the position of this bulk action in the dropdown.
A larger number will appear lower in the list.

### component​


[​](#component)The React component that will be rendered as the bulk action item.


---

# DataTableCellComponent


## DataTableCellComponent​


[​](#datatablecellcomponent)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/data-table/types.ts#L40)This type is used to define re-usable components that can render a table cell in a
DataTable.

Example

```
import { DataTableCellComponent } from '@vendure/dashboard';type CustomerCellData = {    customer: {        id: string;        firstName: string;        lastName: string;    } | null;};export const CustomerCell: DataTableCellComponent<CustomerCellData> = ({ row }) => {    const value = row.original.customer;    if (!value) {        return null;    }    return (        <Button asChild variant="ghost">            <Link to={`/customers/${value.id}`}>                {value.firstName} {value.lastName}            </Link>        </Button>    );};
```

```
type DataTableCellComponent<T> = <Data extends T>(context: CellContext<Data, any>) => any
```


---

# DataTable


## DataTable​


[​](#datatable)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[data-table.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/data-table/data-table.tsx#L164)A data table which includes sorting, filtering, pagination, bulk actions, column controls etc.

This is the building block of all data tables in the Dashboard.

```
function DataTable<TData>(props: Readonly<DataTableProps<TData>>): void
```

Parameters

### props​


[​](#props)[DataTableProps](/reference/dashboard/list-views/data-table#datatableprops)
## DataTableProps​


[​](#datatableprops)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[data-table.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/data-table/data-table.tsx#L113)Props for configuring the DataTable.

[DataTable](/reference/dashboard/list-views/data-table#datatable)
```
interface DataTableProps<TData> {    children?: React.ReactNode;    columns: ColumnDef<TData, any>[];    data: TData[];    totalItems: number;    isLoading?: boolean;    page?: number;    itemsPerPage?: number;    sorting?: SortingState;    columnFilters?: ColumnFiltersState;    onPageChange?: (table: TableType<TData>, page: number, itemsPerPage: number) => void;    onSortChange?: (table: TableType<TData>, sorting: SortingState) => void;    onFilterChange?: (table: TableType<TData>, columnFilters: ColumnFilter[]) => void;    onColumnVisibilityChange?: (table: TableType<TData>, columnVisibility: VisibilityState) => void;    onSearchTermChange?: (searchTerm: string) => void;    defaultColumnVisibility?: VisibilityState;    facetedFilters?: { [key: string]: FacetedFilter | undefined };    disableViewOptions?: boolean;    bulkActions?: BulkAction[];    setTableOptions?: (table: TableOptions<TData>) => TableOptions<TData>;    onRefresh?: () => void;    onReorder?: (oldIndex: number, newIndex: number, item: TData, allItems?: TData[]) => void | Promise<void>;    disableDragAndDrop?: boolean;}
```

### children​


[​](#children)
### columns​


[​](#columns)
### data​


[​](#data)
### totalItems​


[​](#totalitems)
### isLoading​


[​](#isloading)
### page​


[​](#page)
### itemsPerPage​


[​](#itemsperpage)
### sorting​


[​](#sorting)
### columnFilters​


[​](#columnfilters)
### onPageChange​


[​](#onpagechange)
### onSortChange​


[​](#onsortchange)
### onFilterChange​


[​](#onfilterchange)
### onColumnVisibilityChange​


[​](#oncolumnvisibilitychange)
### onSearchTermChange​


[​](#onsearchtermchange)
### defaultColumnVisibility​


[​](#defaultcolumnvisibility)
### facetedFilters​


[​](#facetedfilters)
### disableViewOptions​


[​](#disableviewoptions)
### bulkActions​


[​](#bulkactions)[BulkAction](/reference/dashboard/list-views/bulk-actions#bulkaction)
### setTableOptions​


[​](#settableoptions)This property allows full control over all features of TanStack Table
when needed.

### onRefresh​


[​](#onrefresh)
### onReorder​


[​](#onreorder)Callback when items are reordered via drag and drop.
When provided, enables drag-and-drop functionality.
The fourth parameter provides all items for context-aware reordering.

### disableDragAndDrop​


[​](#disabledraganddrop)When true, drag and drop will be disabled. This will only have an effect if the onReorder prop is also set

## DashboardDataTableDisplayComponent​


[​](#dashboarddatatabledisplaycomponent)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[data-table.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/extension-api/types/data-table.ts#L18)Allows you to define custom display components for specific columns in data tables.
The pageId is already defined in the data table extension, so only the column name is needed.

```
interface DashboardDataTableDisplayComponent {    column: string;    component: DataTableDisplayComponent;}
```

### column​


[​](#column)The name of the column where this display component should be used.

### component​


[​](#component)The React component that will be rendered as the display.
It should accept value and other standard display props.


---

# ListPage


## ListPage​


[​](#listpage)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[list-page.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/page/list-page.tsx#L475)Auto-generates a list page with columns generated based on the provided query document fields.

Example

```
import {    Button,    DashboardRouteDefinition,    ListPage,    PageActionBarRight,    DetailPageButton,} from '@vendure/dashboard';import { Link } from '@tanstack/react-router';import { PlusIcon } from 'lucide-react';// This function is generated for you by the `vendureDashboardPlugin` in your Vite config.// It uses gql-tada to generate TypeScript types which give you type safety as you write// your queries and mutations.import { graphql } from '@/gql';// The fields you select here will be automatically used to generate the appropriate columns in the// data table below.const getArticleList = graphql(`    query GetArticles($options: ArticleListOptions) {        articles(options: $options) {            items {                id                createdAt                updatedAt                isPublished                title                slug                body                customFields            }            totalItems        }    }`);const deleteArticleDocument = graphql(`    mutation DeleteArticle($id: ID!) {        deleteArticle(id: $id) {            result        }    }`);export const articleList: DashboardRouteDefinition = {    navMenuItem: {        sectionId: 'catalog',        id: 'articles',        url: '/articles',        title: 'CMS Articles',    },    path: '/articles',    loader: () => ({        breadcrumb: 'Articles',    }),    component: route => (        <ListPage            pageId="article-list"            title="Articles"            listQuery={getArticleList}            deleteMutation={deleteArticleDocument}            route={route}            customizeColumns={{                title: {                    cell: ({ row }) => {                        const post = row.original;                        return <DetailPageButton id={post.id} label={post.title} />;                    },                },            }}        >            <PageActionBarRight>                <Button asChild>                    <Link to="./new">                        <PlusIcon className="mr-2 h-4 w-4" />                        New article                    </Link>                </Button>            </PageActionBarRight>        </ListPage>    ),};
```

```
function ListPage<T extends TypedDocumentNode<U, V>, U extends Record<string, any> = any, V extends ListQueryOptionsShape = ListQueryOptionsShape, AC extends AdditionalColumns<T> = AdditionalColumns<T>>(props: Readonly<ListPageProps<T, U, V, AC>>): void
```

Parameters

### props​


[​](#props)[ListPageProps](/reference/dashboard/list-views/list-page#listpageprops)
## ListPageProps​


[​](#listpageprops)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[list-page.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/page/list-page.tsx#L36)Props to configure the ListPage component.

[ListPage](/reference/dashboard/list-views/list-page#listpage)
```
interface ListPageProps<T extends TypedDocumentNode<U, V>, U extends ListQueryShape, V extends ListQueryOptionsShape, AC extends AdditionalColumns<T>> {    pageId?: string;    route: AnyRoute | (() => AnyRoute);    title: string | React.ReactElement;    listQuery: T;    deleteMutation?: TypedDocumentNode<any, { id: string }>;    transformVariables?: (variables: V) => V;    onSearchTermChange?: (searchTerm: string) => NonNullable<V['options']>['filter'];    customizeColumns?: CustomizeColumnConfig<T>;    additionalColumns?: AC;    defaultColumnOrder?: (keyof ListQueryFields<T> | keyof AC | CustomFieldKeysOfItem<ListQueryFields<T>>)[];    defaultSort?: SortingState;    defaultVisibility?: Partial<        Record<keyof ListQueryFields<T> | keyof AC | CustomFieldKeysOfItem<ListQueryFields<T>>, boolean>    >;    children?: React.ReactNode;    facetedFilters?: FacetedFilterConfig<T>;    rowActions?: RowAction<ListQueryFields<T>>[];    transformData?: (data: any[]) => any[];    setTableOptions?: (table: TableOptions<any>) => TableOptions<any>;    bulkActions?: BulkAction[];    registerRefresher?: PaginatedListRefresherRegisterFn;    onReorder?: (oldIndex: number, newIndex: number, item: any) => void | Promise<void>;    disableDragAndDrop?: boolean;}
```

### pageId​


[​](#pageid)A unique identifier for the list page. This is important to support
customization functionality that relies on page IDs and makes your
component extensible.

### route​


[​](#route)- The Tanstack Router Route object, which will be defined in the component file.

### title​


[​](#title)- The page title, which will display in the header area.

### listQuery​


[​](#listquery)This DocumentNode of the list query, i.e. a query that fetches
PaginatedList data with "items" and "totalItems", such as:

Example

```
export const collectionListDocument = graphql(`  query CollectionList($options: CollectionListOptions) {    collections(options: $options) {      items {        id        createdAt        updatedAt        name        slug        breadcrumbs {          id          name          slug        }        children {          id          name        }        # ... etc      }      totalItems    }  }`);// ...<ListPage  pageId="collection-list"  listQuery={collectionListDocument}  // .../>

```

### deleteMutation​


[​](#deletemutation)Providing the deleteMutation will automatically add a "delete" menu item to the
actions column dropdown. Note that if this table already has a "delete" bulk action,
you don't need to additionally provide a delete mutation, because the bulk action
will be added to the action column dropdown already.

### transformVariables​


[​](#transformvariables)This prop can be used to intercept and transform the list query variables before they are
sent to the Admin API.

This allows you to implement specific logic that differs from the standard filter/sort
handling.

Example

```
<ListPage  pageId="collection-list"  title="Collections"  listQuery={collectionListDocument}  transformVariables={input => {      const filterTerm = input.options?.filter?.name?.contains;      // If there is a filter term set      // we want to return all results. Else      // we only want top-level Collections      const isFiltering = !!filterTerm;      return {          options: {              ...input.options,              topLevelOnly: !isFiltering,          },      };  }}/>
```

### onSearchTermChange​


[​](#onsearchtermchange)Allows you to customize how the search term is used in the list query options.
For instance, when you want the term to filter on specific fields.

Example

```
 <ListPage   pageId="administrator-list"   title="Administrators"   listQuery={administratorListDocument}   onSearchTermChange={searchTerm => {     return {       firstName: { contains: searchTerm },       lastName: { contains: searchTerm },       emailAddress: { contains: searchTerm },     };   }} />### customizeColumns<MemberInfo kind="property" type={`CustomizeColumnConfig&#60;T&#62;`}   />Allows you to customize the rendering and other aspects of individual columns.By default, an appropriate component will be chosen to render the column databased on the data type of the field. However, in many cases you want to havemore control over how the column data is rendered.*Example*```tsx<ListPage  pageId="collection-list"  listQuery={collectionListDocument}  customizeColumns={{    // The key "name" matches one of the top-level fields of the    // list query type (Collection, in this example)    name: {      meta: {          // The Dashboard optimizes the list query `collectionListDocument` to          // only select field that are actually visible in the ListPage table.          // However, sometimes you want to render data from other fields, i.e.          // this column has a data dependency on the "children" and "breadcrumbs"          // fields in order to correctly render the "name" field.          // In this case, we can declare those data dependencies which means whenever          // the "name" column is visible, it will ensure the "children" and "breadcrumbs"          // fields are also selected in the query.          dependencies: ['children', 'breadcrumbs'],      },      header: 'Collection Name',      cell: ({ row }) => {        const isExpanded = row.getIsExpanded();        const hasChildren = !!row.original.children?.length;        return (          <div            style={{ marginLeft: (row.original.breadcrumbs?.length - 2) * 20 + 'px' }}            className="flex gap-2 items-center"          >            <Button              size="icon"              variant="secondary"              onClick={row.getToggleExpandedHandler()}              disabled={!hasChildren}              className={!hasChildren ? 'opacity-20' : ''}            >              {isExpanded ? <FolderOpen /> : <Folder />}            </Button>            <DetailPageButton id={row.original.id} label={row.original.name} />          </div>          );      },    },

```

### additionalColumns​


[​](#additionalcolumns)Allows you to define extra columns that are not related to actual fields returned in
the query result.

For example, in the Administrator list, we define an additional "name" column composed
of the firstName and lastName fields.

Example

```
<ListPage  pageId="administrator-list"  title="Administrators"  listQuery={administratorListDocument}  additionalColumns={{    name: {        header: 'Name',        cell: ({ row }) => (            <DetailPageButton                id={row.original.id}                label={`${row.original.firstName} ${row.original.lastName}`}            />        ),  },/>
```

### defaultColumnOrder​


[​](#defaultcolumnorder)Allows you to specify the default order of columns in the table. When not defined, the
order of fields in the list query document will be used.

### defaultSort​


[​](#defaultsort)Allows you to specify the default sorting applied to the table.

Example

```
defaultSort={[{ id: 'orderPlacedAt', desc: true }]}
```

### defaultVisibility​


[​](#defaultvisibility)Allows you to specify the default columns that are visible in the table.
If you set them to true, then only those will show by default. If you set them to false,
then all other columns will be visible by default.

Example

```
 <ListPage   pageId="country-list"   listQuery={countriesListQuery}   title="Countries"   defaultVisibility={{       name: true,       code: true,       enabled: true,   }} />
```

### children​


[​](#children)
### facetedFilters​


[​](#facetedfilters)Allows you to define pre-set filters based on an array of possible selections

Example

```
<ListPage  pageId="payment-method-list"  listQuery={paymentMethodListQuery}  title="Payment Methods"  facetedFilters={{      enabled: {          title: 'Enabled',          options: [              { label: 'Enabled', value: true },              { label: 'Disabled', value: false },          ],      },  }}/>
```

### rowActions​


[​](#rowactions)Allows you to specify additional "actions" that will be made available in the "actions" column.
By default, the actions column includes all bulk actions defined in the bulkActions prop.

### transformData​


[​](#transformdata)Allows the returned list query data to be transformed in some way. This is an advanced feature
that is not often required.

### setTableOptions​


[​](#settableoptions)Allows you to directly manipulate the Tanstack Table TableOptions object before the
table is created. And advanced option that is not often required.

### bulkActions​


[​](#bulkactions)[BulkAction](/reference/dashboard/list-views/bulk-actions#bulkaction)Bulk actions are actions that can be applied to one or more table rows, and include things like

- Deleting the rows
- Assigning the rows to another channel
- Bulk editing some aspect of the rows

See the BulkAction docs for an example of how to build the component.

[BulkAction](/reference/dashboard/list-views/bulk-actions#bulkaction)Example

```
<ListPage  pageId="product-list"  listQuery={productListDocument}  title="Products"  bulkActions={[    {      component: AssignProductsToChannelBulkAction,      order: 100,    },    {      component: RemoveProductsFromChannelBulkAction,      order: 200,    },    {      component: DeleteProductsBulkAction,      order: 300,    },  ]}/>
```

### registerRefresher​


[​](#registerrefresher)Register a function that allows you to assign a refresh function for
this list. The function can be assigned to a ref and then called when
the list needs to be refreshed.

### onReorder​


[​](#onreorder)Callback when items are reordered via drag and drop.
Only applies to top-level items. When provided, enables drag-and-drop functionality.

### disableDragAndDrop​


[​](#disabledraganddrop)When true, drag and drop will be disabled. This will only have an effect if the onReorder prop is also set Useful when filtering or searching.
Defaults to false. Only relevant when onReorder is provided.


---

# PaginatedListDataTable


## PaginatedListDataTable​


[​](#paginatedlistdatatable)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[paginated-list-data-table.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/shared/paginated-list-data-table.tsx#L366)A wrapper around the DataTable component, which automatically configures functionality common to
list queries that implement the PaginatedList interface, which is the common way of representing lists
of data in Vendure.

[DataTable](/reference/dashboard/list-views/data-table#datatable)Given a GraphQL query document node, the component will automatically configure the required columns
with sorting & filtering functionality.

The automatic features can be further customized and enhanced using the many options available in the props.

Example

```
import { Money } from '@/vdb/components/data-display/money.js';import { PaginatedListDataTable } from '@/vdb/components/shared/paginated-list-data-table.js';import { Badge } from '@/vdb/components/ui/badge.js';import { Button } from '@/vdb/components/ui/button.js';import { Link } from '@tanstack/react-router';import { ColumnFiltersState, SortingState } from '@tanstack/react-table';import { useState } from 'react';import { customerOrderListDocument } from '../customers.graphql.js';interface CustomerOrderTableProps {    customerId: string;}export function CustomerOrderTable({ customerId }: Readonly<CustomerOrderTableProps>) {    const [page, setPage] = useState(1);    const [pageSize, setPageSize] = useState(10);    const [sorting, setSorting] = useState<SortingState>([{ id: 'orderPlacedAt', desc: true }]);    const [filters, setFilters] = useState<ColumnFiltersState>([]);    return (        <PaginatedListDataTable            listQuery={customerOrderListDocument}            transformVariables={variables => {                return {                    ...variables,                    customerId,                };            }}            defaultVisibility={{                id: false,                createdAt: false,                updatedAt: false,                type: false,                currencyCode: false,                total: false,            }}            customizeColumns={{                total: {                    header: 'Total',                    cell: ({ cell, row }) => {                        const value = cell.getValue();                        const currencyCode = row.original.currencyCode;                        return <Money value={value} currency={currencyCode} />;                    },                },                totalWithTax: {                    header: 'Total with Tax',                    cell: ({ cell, row }) => {                        const value = cell.getValue();                        const currencyCode = row.original.currencyCode;                        return <Money value={value} currency={currencyCode} />;                    },                },                state: {                    header: 'State',                    cell: ({ cell }) => {                        const value = cell.getValue() as string;                        return <Badge variant="outline">{value}</Badge>;                    },                },                code: {                    header: 'Code',                    cell: ({ cell, row }) => {                        const value = cell.getValue() as string;                        const id = row.original.id;                        return (                            <Button asChild variant="ghost">                                <Link to={`/orders/${id}`}>{value}</Link>                            </Button>                        );                    },                },            }}            page={page}            itemsPerPage={pageSize}            sorting={sorting}            columnFilters={filters}            onPageChange={(_, page, perPage) => {                setPage(page);                setPageSize(perPage);            }}            onSortChange={(_, sorting) => {                setSorting(sorting);            }}            onFilterChange={(_, filters) => {                setFilters(filters);            }}        />    );}
```

```
function PaginatedListDataTable<T extends TypedDocumentNode<U, V>, U extends Record<string, any> = any, V extends ListQueryOptionsShape = any, AC extends AdditionalColumns<T> = AdditionalColumns<T>>(props: Readonly<PaginatedListDataTableProps<T, U, V, AC>>): void
```

Parameters

### props​


[​](#props)[PaginatedListDataTableProps](/reference/dashboard/list-views/paginated-list-data-table#paginatedlistdatatableprops)
## PaginatedListDataTableProps​


[​](#paginatedlistdatatableprops)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[paginated-list-data-table.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/components/shared/paginated-list-data-table.tsx#L202)Props to configure the PaginatedListDataTable component.

[PaginatedListDataTable](/reference/dashboard/list-views/paginated-list-data-table#paginatedlistdatatable)
```
interface PaginatedListDataTableProps<T extends TypedDocumentNode<U, V>, U extends ListQueryShape, V extends ListQueryOptionsShape, AC extends AdditionalColumns<T>> {    listQuery: T;    deleteMutation?: TypedDocumentNode<any, any>;    transformQueryKey?: (queryKey: any[]) => any[];    transformVariables?: (variables: V) => V;    customizeColumns?: CustomizeColumnConfig<T>;    additionalColumns?: AC;    defaultColumnOrder?: (keyof ListQueryFields<T> | keyof AC | CustomFieldKeysOfItem<ListQueryFields<T>>)[];    defaultVisibility?: Partial<Record<AllItemFieldKeys<T>, boolean>>;    onSearchTermChange?: (searchTerm: string) => NonNullable<V['options']>['filter'];    page: number;    itemsPerPage: number;    sorting: SortingState;    columnFilters?: ColumnFiltersState;    onPageChange: (table: Table<any>, page: number, perPage: number) => void;    onSortChange: (table: Table<any>, sorting: SortingState) => void;    onFilterChange: (table: Table<any>, filters: ColumnFiltersState) => void;    onColumnVisibilityChange?: (table: Table<any>, columnVisibility: VisibilityState) => void;    facetedFilters?: FacetedFilterConfig<T>;    rowActions?: RowAction<PaginatedListItemFields<T>>[];    bulkActions?: BulkAction[];    disableViewOptions?: boolean;    transformData?: (data: PaginatedListItemFields<T>[]) => PaginatedListItemFields<T>[];    setTableOptions?: (table: TableOptions<any>) => TableOptions<any>;    registerRefresher?: PaginatedListRefresherRegisterFn;    onReorder?: (        oldIndex: number,        newIndex: number,        item: PaginatedListItemFields<T>,    ) => void | Promise<void>;    disableDragAndDrop?: boolean;}
```

### listQuery​


[​](#listquery)
### deleteMutation​


[​](#deletemutation)
### transformQueryKey​


[​](#transformquerykey)
### transformVariables​


[​](#transformvariables)
### customizeColumns​


[​](#customizecolumns)
### additionalColumns​


[​](#additionalcolumns)
### defaultColumnOrder​


[​](#defaultcolumnorder)
### defaultVisibility​


[​](#defaultvisibility)
### onSearchTermChange​


[​](#onsearchtermchange)
### page​


[​](#page)
### itemsPerPage​


[​](#itemsperpage)
### sorting​


[​](#sorting)
### columnFilters​


[​](#columnfilters)
### onPageChange​


[​](#onpagechange)
### onSortChange​


[​](#onsortchange)
### onFilterChange​


[​](#onfilterchange)
### onColumnVisibilityChange​


[​](#oncolumnvisibilitychange)
### facetedFilters​


[​](#facetedfilters)
### rowActions​


[​](#rowactions)
### bulkActions​


[​](#bulkactions)[BulkAction](/reference/dashboard/list-views/bulk-actions#bulkaction)
### disableViewOptions​


[​](#disableviewoptions)
### transformData​


[​](#transformdata)
### setTableOptions​


[​](#settableoptions)
### registerRefresher​


[​](#registerrefresher)
### onReorder​


[​](#onreorder)Callback when items are reordered via drag and drop.
When provided, enables drag-and-drop functionality.

### disableDragAndDrop​


[​](#disabledraganddrop)When true, drag and drop will be disabled. This will only have an effect if the onReorder prop is also set


---

# PageLayout


## PageLayout​


[​](#pagelayout)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[page-layout.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/layout-engine/page-layout.tsx#L211)- 

This component governs the layout of the contents of a Page component.
It should contain all the PageBlock components that are to be displayed on the page.

[Page](/reference/dashboard/page-layout/page#page)[PageBlock](/reference/dashboard/page-layout/page-block#pageblock)
```
function PageLayout(props: Readonly<PageLayoutProps>): void
```

Parameters

### props​


[​](#props)[PageLayoutProps](/reference/dashboard/page-layout/#pagelayoutprops)
## PageLayoutProps​


[​](#pagelayoutprops)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[page-layout.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/layout-engine/page-layout.tsx#L183)Status: Developer Preview

```
type PageLayoutProps = {    children: React.ReactNode;    className?: string;}
```

### children​


[​](#children)
### className​


[​](#classname)


---

# PageActionBar


## PageActionBar​


[​](#pageactionbar)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[page-layout.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/layout-engine/page-layout.tsx#L351)- 

A component for displaying the main actions for a page. This should be used inside the Page component.
It should be used in conjunction with the PageActionBarLeft and PageActionBarRight components
as direct children.

[Page](/reference/dashboard/page-layout/page#page)[PageActionBarLeft](/reference/dashboard/page-layout/page-action-bar#pageactionbarleft)[PageActionBarRight](/reference/dashboard/page-layout/page-action-bar#pageactionbarright)
```
function PageActionBar(props: Readonly<{ children: React.ReactNode }>): void
```

Parameters

### props​


[​](#props)
## PageActionBarLeft​


[​](#pageactionbarleft)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[page-layout.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/layout-engine/page-layout.tsx#L373)The PageActionBarLeft component should be used to display the left content of the action bar.

```
function PageActionBarLeft(props: Readonly<{ children: React.ReactNode }>): void
```

Parameters

### props​


[​](#props-1)
## PageActionBarRight​


[​](#pageactionbarright)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[page-layout.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/layout-engine/page-layout.tsx#L466)The PageActionBarRight component should be used to display the right content of the action bar.

```
function PageActionBarRight(props: Readonly<{    children: React.ReactNode;    dropdownMenuItems?: InlineDropdownItem[];}>): void
```

Parameters

### props​


[​](#props-2)


---

# PageBlock


## PageBlock​


[​](#pageblock)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[page-layout.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/layout-engine/page-layout.tsx#L591)- 

A component for displaying a block of content on a page. This should be used inside the PageLayout component.
It should be provided with a column prop to determine which column it should appear in, and a blockId prop
to identify the block.

[PageLayout](/reference/dashboard/page-layout/#pagelayout)Example

```
<PageBlock column="main" blockId="my-block"> <div>My Block</div></PageBlock>
```

```
function PageBlock(props: Readonly<PageBlockProps>): void
```

Parameters

### props​


[​](#props)[PageBlockProps](/reference/dashboard/page-layout/page-block#pageblockprops)
## PageBlockProps​


[​](#pageblockprops)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[page-layout.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/layout-engine/page-layout.tsx#L540)Props used to configure the PageBlock component.

[PageBlock](/reference/dashboard/page-layout/page-block#pageblock)
```
type PageBlockProps = {    children?: React.ReactNode;    column: 'main' | 'side' | 'full';    blockId?: string;    title?: React.ReactNode | string;    description?: React.ReactNode | string;    className?: string;}
```

### children​


[​](#children)The content of the block.

### column​


[​](#column)Which column this block should appear in

### blockId​


[​](#blockid)The ID of the block, e.g. "gift-cards" or "related-products".

### title​


[​](#title)The title of the block, e.g. "Gift Cards" or "Related Products".

### description​


[​](#description)An optional description of the block.

### className​


[​](#classname)An optional set of CSS classes to apply to the block.

## FullWidthPageBlock​


[​](#fullwidthpageblock)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[page-layout.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/layout-engine/page-layout.tsx#L638)Status: Developer Preview

A component for displaying a block of content on a page that takes up the full width of the page.
This should be used inside the PageLayout component.

[PageLayout](/reference/dashboard/page-layout/#pagelayout)
```
function FullWidthPageBlock(props: Readonly<Pick<PageBlockProps, 'children' | 'className' | 'blockId'>>): void
```

Parameters

### props​


[​](#props-1)[PageBlockProps](/reference/dashboard/page-layout/page-block#pageblockprops)
## CustomFieldsPageBlock​


[​](#customfieldspageblock)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[page-layout.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/layout-engine/page-layout.tsx#L668)- 

A component for displaying an auto-generated form for custom fields on a page.
This is a special form of PageBlock that automatically generates
a form corresponding to the custom fields for the given entity type.

[PageBlock](/reference/dashboard/page-layout/page-block#pageblock)Example

```
<CustomFieldsPageBlock column="main" entityType="Product" control={form.control} />
```

```
function CustomFieldsPageBlock(props: Readonly<{    column: 'main' | 'side';    entityType: string;    control: Control<any, any>;}>): void
```

Parameters

### props​


[​](#props-2)


---

# PageTitle


## PageTitle​


[​](#pagetitle)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[page-layout.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/layout-engine/page-layout.tsx#L336)A component for displaying the title of a page. This should be used inside the Page component.

[Page](/reference/dashboard/page-layout/page#page)
```
function PageTitle(props: Readonly<{ children: React.ReactNode }>): void
```

Parameters

### props​


[​](#props)


---

# Page


## Page​


[​](#page)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[page-layout.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/layout-engine/page-layout.tsx#L91)This component should be used to wrap all pages in the dashboard. It provides
a consistent layout as well as a context for the slot-based PageBlock system.

The typical hierarchy of a page is as follows:

- Page
- PageTitle
- PageActionBar
- PageLayout

[PageTitle](/reference/dashboard/page-layout/page-title#pagetitle)[PageActionBar](/reference/dashboard/page-layout/page-action-bar#pageactionbar)[PageLayout](/reference/dashboard/page-layout/#pagelayout)Example

```
import { Page, PageTitle, PageActionBar, PageLayout, PageBlock, Button } from '@vendure/dashboard';const pageId = 'my-page';export function MyPage() { return (   <Page pageId={pageId} form={form} submitHandler={submitHandler} entity={entity}>     <PageTitle>My Page</PageTitle>     <PageActionBar>       <PageActionBarRight>         <Button>Save</Button>       </PageActionBarRight>     </PageActionBar>     <PageLayout>       <PageBlock column="main" blockId="my-block">         <div>My Block</div>       </PageBlock>     </PageLayout>   </Page> )}
```

```
function Page(props: Readonly<PageProps>): void
```

Parameters

### props​


[​](#props)[PageProps](/reference/dashboard/page-layout/page#pageprops)
## PageProps​


[​](#pageprops)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[page-layout.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/framework/layout-engine/page-layout.tsx#L38)The props used to configure the Page component.

[Page](/reference/dashboard/page-layout/page#page)
```
interface PageProps extends ComponentProps<'div'> {    pageId?: string;    entity?: any;    form?: UseFormReturn<any>;    submitHandler?: any;}
```

- Extends: ComponentProps<'div'>

### pageId​


[​](#pageid)A string identifier for the page, e.g. "product-list", "review-detail", etc.

### entity​


[​](#entity)
### form​


[​](#form)
### submitHandler​


[​](#submithandler)


---

# UsePageBlock


## usePageBlock​


[​](#usepageblock)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[use-page-block.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/src/lib/hooks/use-page-block.tsx#L21)Returns the current PageBlock context, which means there must be
a PageBlock ancestor component higher in the tree.

If optional is set to true, the hook will not throw if no PageBlock
exists higher in the tree, but will just return undefined.

Example

```
const { blockId, title, description, column } = usePageBlock();
```

```
function usePageBlock(props: { optional?: boolean } = {}): void
```

Parameters

### props​


[​](#props)


---

# VendureDashboardPlugin


## vendureDashboardPlugin​


[​](#venduredashboardplugin)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[vite-plugin-vendure-dashboard.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/vite/vite-plugin-vendure-dashboard.ts#L166)This is the Vite plugin which powers the Vendure Dashboard, including:

- Configuring routing, styling and React support
- Analyzing your VendureConfig file and introspecting your schema
- Loading your custom Dashboard extensions

```
function vendureDashboardPlugin(options: VitePluginVendureDashboardOptions): PluginOption[]
```

Parameters

### options​


[​](#options)[VitePluginVendureDashboardOptions](/reference/dashboard/vite-plugin/vendure-dashboard-plugin#vitepluginvenduredashboardoptions)
## VitePluginVendureDashboardOptions​


[​](#vitepluginvenduredashboardoptions)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[vite-plugin-vendure-dashboard.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/vite/vite-plugin-vendure-dashboard.ts#L31)Options for the vendureDashboardPlugin Vite plugin.

[vendureDashboardPlugin](/reference/dashboard/vite-plugin/vendure-dashboard-plugin#venduredashboardplugin)
```
type VitePluginVendureDashboardOptions = {    /**     * @description     * The path to the Vendure server configuration file.     */    vendureConfigPath: string | URL;    /**     * @description     * The {@link PathAdapter} allows you to customize the resolution of paths     * in the compiled Vendure source code which is used as part of the     * introspection step of building the dashboard.     *     * It enables support for more complex repository structures, such as     * monorepos, where the Vendure server configuration file may not     * be located in the root directory of the project.     *     * If you get compilation errors like "Error loading Vendure config: Cannot find module",     * you probably need to provide a custom `pathAdapter` to resolve the paths correctly.     *     * @example     * ```ts     * vendureDashboardPlugin({     *     tempCompilationDir: join(__dirname, './__vendure-dashboard-temp'),     *     pathAdapter: {     *         getCompiledConfigPath: ({ inputRootDir, outputPath, configFileName }) => {     *             const projectName = inputRootDir.split('/libs/')[1].split('/')[0];     *             const pathAfterProject = inputRootDir.split(`/libs/${projectName}`)[1];     *             const compiledConfigFilePath = `${outputPath}/${projectName}${pathAfterProject}`;     *             return path.join(compiledConfigFilePath, configFileName);     *         },     *         transformTsConfigPathMappings: ({ phase, patterns }) => {     *             // "loading" phase is when the compiled Vendure code is being loaded by     *             // the plugin, in order to introspect the configuration of your app.     *             if (phase === 'loading') {     *                 return patterns.map((p) =>     *                     p.replace('libs/', '').replace(/.ts$/, '.js'),     *                 );     *             }     *             return patterns;     *         },     *     },     *     // ...     * }),     * ```     */    pathAdapter?: PathAdapter;    /**     * @description     * The name of the exported variable from the Vendure server configuration file, e.g. `config`.     * This is only required if the plugin is unable to auto-detect the name of the exported variable.     */    vendureConfigExport?: string;    /**     * @description     * The path to the directory where the generated GraphQL Tada files will be output.     */    gqlOutputPath?: string;    tempCompilationDir?: string;    /**     * @description     * Allows you to customize the location of node_modules & glob patterns used to scan for potential     * Vendure plugins installed as npm packages. If not provided, the compiler will attempt to guess     * the location based on the location of the `@vendure/core` package.     */    pluginPackageScanner?: PackageScannerConfig;    /**     * @description     * Allows you to specify the module system to use when compiling and loading your Vendure config.     * By default, the compiler will use CommonJS, but you can set it to `esm` if you are using     * ES Modules in your Vendure project.     *     * **Status** Developer preview. If you are using ESM please try this out and provide us with feedback!     *     * @since 3.5.1     * @default 'commonjs'     */    module?: 'commonjs' | 'esm';    /**     * @description     * Allows you to selectively disable individual plugins.     * @example     * ```ts     * vendureDashboardPlugin({     *   vendureConfigPath: './config.ts',     *   disablePlugins: {     *     react: true,     *     lingui: true,     *   }     * })     * ```     */    disablePlugins?: {        tanstackRouter?: boolean;        react?: boolean;        lingui?: boolean;        themeVariables?: boolean;        tailwindSource?: boolean;        tailwindcss?: boolean;        configLoader?: boolean;        viteConfig?: boolean;        adminApiSchema?: boolean;        dashboardMetadata?: boolean;        uiConfig?: boolean;        gqlTada?: boolean;        transformIndexHtml?: boolean;        translations?: boolean;        hmr?: boolean;    };} & UiConfigPluginOptions &    ThemeVariablesPluginOptions
```

## PathAdapter​


[​](#pathadapter)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/vite/types.ts#L72)The PathAdapter interface allows customization of how paths are handled
when compiling the Vendure config and its imports.

It enables support for more complex repository structures, such as
monorepos, where the Vendure server configuration file may not
be located in the root directory of the project.

If you get compilation errors like "Error loading Vendure config: Cannot find module",
you probably need to provide a custom pathAdapter to resolve the paths correctly.

This can take some trial-and-error. Try logging values from the functions to figure out
the exact settings that you need for your repo setup.

Example

```
vendureDashboardPlugin({    pathAdapter: {        getCompiledConfigPath: ({ inputRootDir, outputPath, configFileName }) => {            const projectName = inputRootDir.split('/libs/')[1].split('/')[0];            const pathAfterProject = inputRootDir.split(`/libs/${projectName}`)[1];            const compiledConfigFilePath = `${outputPath}/${projectName}${pathAfterProject}`;            return path.join(compiledConfigFilePath, configFileName);        },        transformTsConfigPathMappings: ({ phase, patterns }) => {            // "loading" phase is when the compiled Vendure code is being loaded by            // the plugin, in order to introspect the configuration of your app.            if (phase === 'loading') {                return patterns.map((p) =>                    p.replace('libs/', '').replace(/.ts$/, '.js'),                );            }            return patterns;        },    },    // ...}),
```

```
interface PathAdapter {    getCompiledConfigPath?: GetCompiledConfigPathFn;    transformTsConfigPathMappings?: TransformTsConfigPathMappingsFn;}
```

### getCompiledConfigPath​


[​](#getcompiledconfigpath)A function to determine the path to the compiled Vendure config file.

### transformTsConfigPathMappings​


[​](#transformtsconfigpathmappings)
## ApiConfig​


[​](#apiconfig)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[vite-plugin-ui-config.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/vite/vite-plugin-ui-config.ts#L19)Options used by the vendureDashboardPlugin to configure how the Dashboard
connects to the Vendure Admin API

[vendureDashboardPlugin](/reference/dashboard/vite-plugin/vendure-dashboard-plugin#venduredashboardplugin)
```
interface ApiConfig {    host?: string | 'auto';    port?: number | 'auto';    adminApiPath?: string;    tokenMethod?: 'cookie' | 'bearer';    authTokenHeaderKey?: string;    channelTokenKey?: string;}
```

### host​


[​](#host)The hostname of the Vendure server which the admin UI will be making API calls
to. If set to "auto", the Admin UI app will determine the hostname from the
current location (i.e. window.location.hostname).

### port​


[​](#port)The port of the Vendure server which the admin UI will be making API calls
to. If set to "auto", the Admin UI app will determine the port from the
current location (i.e. window.location.port).

### adminApiPath​


[​](#adminapipath)The path to the GraphQL Admin API.

### tokenMethod​


[​](#tokenmethod)Whether to use cookies or bearer tokens to track sessions.
Should match the setting of in the server's tokenMethod config
option.

### authTokenHeaderKey​


[​](#authtokenheaderkey)The header used when using the 'bearer' auth method. Should match the
setting of the server's authOptions.authTokenHeaderKey config option.

### channelTokenKey​


[​](#channeltokenkey)The name of the header which contains the channel token. Should match the
setting of the server's apiOptions.channelTokenKey config option.

## I18nConfig​


[​](#i18nconfig)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[vite-plugin-ui-config.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/vite/vite-plugin-ui-config.ts#L81)Options used by the vendureDashboardPlugin to configure aspects of the
Dashboard UI behaviour.

[vendureDashboardPlugin](/reference/dashboard/vite-plugin/vendure-dashboard-plugin#venduredashboardplugin)
```
interface I18nConfig {    defaultLanguage?: LanguageCode;    defaultLocale?: string;    availableLanguages?: LanguageCode[];    availableLocales?: string[];}
```

### defaultLanguage​


[​](#defaultlanguage)[LanguageCode](/reference/typescript-api/common/language-code#languagecode)[LanguageCode](/reference/typescript-api/common/language-code#languagecode)The default language for the Admin UI. Must be one of the
items specified in the availableLanguages property.

### defaultLocale​


[​](#defaultlocale)The default locale for the Admin UI. The locale affects the formatting of
currencies & dates. Must be one of the items specified
in the availableLocales property.

If not set, the browser default locale will be used.

### availableLanguages​


[​](#availablelanguages)[LanguageCode](/reference/typescript-api/common/language-code#languagecode)An array of languages for which translations exist for the Admin UI.

### availableLocales​


[​](#availablelocales)An array of locales to be used on Admin UI.

## UiConfigPluginOptions​


[​](#uiconfigpluginoptions)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[vite-plugin-ui-config.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/vite/vite-plugin-ui-config.ts#L124)Options used by the vendureDashboardPlugin to configure aspects of the
Dashboard UI behaviour.

[vendureDashboardPlugin](/reference/dashboard/vite-plugin/vendure-dashboard-plugin#venduredashboardplugin)
```
interface UiConfigPluginOptions {    api?: ApiConfig;    i18n?: I18nConfig;}
```

### api​


[​](#api)[ApiConfig](/reference/dashboard/vite-plugin/vendure-dashboard-plugin#apiconfig)Configuration for API connection settings

### i18n​


[​](#i18n)[I18nConfig](/reference/dashboard/vite-plugin/vendure-dashboard-plugin#i18nconfig)Configuration for internationalization settings

