# ActionBarContext


## ActionBarContext​


[​](#actionbarcontext)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[nav-builder-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/nav-builder/nav-builder-types.ts#L90)Providers & data available to the onClick & buttonState functions of an ActionBarItem,
ActionBarDropdownMenuItem or NavMenuItem.

[ActionBarItem](/reference/admin-ui-api/action-bar/action-bar-item#actionbaritem)[ActionBarDropdownMenuItem](/reference/admin-ui-api/action-bar/action-bar-dropdown-menu-item#actionbardropdownmenuitem)[NavMenuItem](/reference/admin-ui-api/nav-menu/nav-menu-item#navmenuitem)
```
interface ActionBarContext {    route: ActivatedRoute;    injector: Injector;    dataService: DataService;    notificationService: NotificationService;    entity$: Observable<Record<string, any> | undefined>;}
```

### route​


[​](#route)The router's ActivatedRoute object for
the current route. This object contains information about the route, its parameters, and additional data
associated with the route.

[ActivatedRoute](https://angular.dev/guide/routing/router-reference#activated-route)
### injector​


[​](#injector)[Injector](/reference/typescript-api/common/injector#injector)The Angular Injector which can be used to get instances
of services and other providers available in the application.

[Injector](https://angular.dev/api/core/Injector)
### dataService​


[​](#dataservice)[DataService](/reference/admin-ui-api/services/data-service#dataservice)The DataService, which provides methods for querying the
server-side data.

[DataService](/reference/admin-ui-api/services/data-service)
### notificationService​


[​](#notificationservice)[NotificationService](/reference/admin-ui-api/services/notification-service#notificationservice)The NotificationService, which provides methods for
displaying notifications to the user.

[NotificationService](/reference/admin-ui-api/services/notification-service)
### entity$​


[​](#entity)An observable of the current entity in a detail view. In a list view the observable will not emit any values.

Example

```
addActionBarDropdownMenuItem({    id: 'print-invoice',    locationId: 'order-detail',    label: 'Print Invoice',    icon: 'printer',    buttonState: context => {        return context.entity$.pipe(            map((order) => {                return order?.state === 'PaymentSettled'                    ? { disabled: false, visible: true }                    : { disabled: true, visible: true };            }),        );    },    requiresPermission: ['UpdateOrder'],}),
```


---

# ActionBarDropdownMenuItem


## ActionBarDropdownMenuItem​


[​](#actionbardropdownmenuitem)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[nav-builder-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/nav-builder/nav-builder-types.ts#L227)A dropdown menu item in the ActionBar area at the top of one of the list or detail views.

```
interface ActionBarDropdownMenuItem {    id: string;    label: string;    locationId: ActionBarLocationId;    hasDivider?: boolean;    buttonState?: (context: ActionBarContext) => Observable<ActionBarButtonState | undefined>;    onClick?: (event: MouseEvent, context: ActionBarContext) => void;    routerLink?: RouterLinkDefinition;    icon?: string;    requiresPermission?: string | string[];}
```

### id​


[​](#id)A unique identifier for the item.

### label​


[​](#label)The label to display for the item. This can also be a translation token,
e.g. invoice-plugin.print-invoice.

### locationId​


[​](#locationid)[ActionBarLocationId](/reference/admin-ui-api/action-bar/action-bar-location-id#actionbarlocationid)The location in the UI where this menu item should be displayed.

### hasDivider​


[​](#hasdivider)Whether to render a divider above this item.

### buttonState​


[​](#buttonstate)[ActionBarContext](/reference/admin-ui-api/action-bar/action-bar-context#actionbarcontext)A function which returns an observable of the button state, allowing you to
dynamically enable/disable or show/hide the button.

### onClick​


[​](#onclick)[ActionBarContext](/reference/admin-ui-api/action-bar/action-bar-context#actionbarcontext)
### routerLink​


[​](#routerlink)[RouterLinkDefinition](/reference/admin-ui-api/action-bar/router-link-definition#routerlinkdefinition)
### icon​


[​](#icon)An optional icon to display with the item. The icon
should be a valid shape name from the Clarity Icons
set.

[Clarity Icons](https://core.clarity.design/foundation/icons/shapes/)
### requiresPermission​


[​](#requirespermission)Control the display of this item based on the user permissions. Note: if you attempt to pass a
PermissionDefinition object, you will get a compilation error. Instead, pass the plain
string version. For example, if the permission is defined as:

[PermissionDefinition](/reference/typescript-api/auth/permission-definition#permissiondefinition)
```
export const MyPermission = new PermissionDefinition('ProductReview');
```

then the generated permission strings will be:

- CreateProductReview
- ReadProductReview
- UpdateProductReview
- DeleteProductReview

---

# ActionBarItem


## ActionBarItem​


[​](#actionbaritem)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[nav-builder-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/nav-builder/nav-builder-types.ts#L158)A button in the ActionBar area at the top of one of the list or detail views.

```
interface ActionBarItem {    id: string;    label: string;    locationId: ActionBarLocationId;    disabled?: Observable<boolean>;    buttonState?: (context: ActionBarContext) => Observable<ActionBarButtonState>;    onClick?: (event: MouseEvent, context: ActionBarContext) => void;    routerLink?: RouterLinkDefinition;    buttonColor?: 'primary' | 'success' | 'warning';    buttonStyle?: 'solid' | 'outline' | 'link';    icon?: string;    requiresPermission?: string | string[];}
```

### id​


[​](#id)A unique identifier for the item.

### label​


[​](#label)The label to display for the item. This can also be a translation token,
e.g. invoice-plugin.print-invoice.

### locationId​


[​](#locationid)[ActionBarLocationId](/reference/admin-ui-api/action-bar/action-bar-location-id#actionbarlocationid)The location in the UI where this button should be displayed.

### disabled​


[​](#disabled)Deprecated since v2.1.0 - use buttonState instead.

### buttonState​


[​](#buttonstate)[ActionBarContext](/reference/admin-ui-api/action-bar/action-bar-context#actionbarcontext)A function which returns an observable of the button state, allowing you to
dynamically enable/disable or show/hide the button.

### onClick​


[​](#onclick)[ActionBarContext](/reference/admin-ui-api/action-bar/action-bar-context#actionbarcontext)
### routerLink​


[​](#routerlink)[RouterLinkDefinition](/reference/admin-ui-api/action-bar/router-link-definition#routerlinkdefinition)
### buttonColor​


[​](#buttoncolor)
### buttonStyle​


[​](#buttonstyle)
### icon​


[​](#icon)An optional icon to display in the button. The icon
should be a valid shape name from the Clarity Icons
set.

[Clarity Icons](https://core.clarity.design/foundation/icons/shapes/)
### requiresPermission​


[​](#requirespermission)Control the display of this item based on the user permissions. Note: if you attempt to pass a
PermissionDefinition object, you will get a compilation error. Instead, pass the plain
string version. For example, if the permission is defined as:

[PermissionDefinition](/reference/typescript-api/auth/permission-definition#permissiondefinition)
```
export const MyPermission = new PermissionDefinition('ProductReview');
```

then the generated permission strings will be:

- CreateProductReview
- ReadProductReview
- UpdateProductReview
- DeleteProductReview

---

# ActionBarLocationId


## ActionBarLocationId​


[​](#actionbarlocationid)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[component-registry-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/common/component-registry-types.ts#L107)The valid locationIds for registering action bar items. For a list of
values, see PageLocationId.

[PageLocationId](/reference/admin-ui-api/action-bar/page-location-id#pagelocationid)
```
type ActionBarLocationId = PageLocationId
```


---

# AddActionBarDropdownMenuItem


## addActionBarDropdownMenuItem​


[​](#addactionbardropdownmenuitem)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[add-action-bar-dropdown-menu-item.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/extension/add-action-bar-dropdown-menu-item.ts#L27)Adds a dropdown menu item to the ActionBar at the top right of each list or detail view. The locationId can
be determined by pressing ctrl + u when running the Admin UI in dev mode.

Example

```
import { addActionBarDropdownMenuItem } from '@vendure/admin-ui/core';export default [    addActionBarDropdownMenuItem({        id: 'print-invoice',        label: 'Print Invoice',        locationId: 'order-detail',        routerLink: ['/extensions/invoicing'],    }),];
```

```
function addActionBarDropdownMenuItem(config: ActionBarDropdownMenuItem): void
```

Parameters

### config​


[​](#config)[ActionBarDropdownMenuItem](/reference/admin-ui-api/action-bar/action-bar-dropdown-menu-item#actionbardropdownmenuitem)



---

# AddActionBarItem


## addActionBarItem​


[​](#addactionbaritem)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[add-action-bar-item.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/extension/add-action-bar-item.ts#L23)Adds a button to the ActionBar at the top right of each list or detail view. The locationId can
be determined by pressing ctrl + u when running the Admin UI in dev mode.

Example

```
export default [    addActionBarItem({        id: 'print-invoice',        label: 'Print Invoice',        locationId: 'order-detail',        routerLink: ['/extensions/invoicing'],    }),];
```

```
function addActionBarItem(config: ActionBarItem): void
```

Parameters

### config​


[​](#config)[ActionBarItem](/reference/admin-ui-api/action-bar/action-bar-item#actionbaritem)


---

# PageLocationId


## PageLocationId​


[​](#pagelocationid)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[component-registry-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/common/component-registry-types.ts#L52)The valid locationIds for registering action bar items or tabs.

```
type PageLocationId = | 'administrator-detail'    | 'administrator-list'    | 'asset-detail'    | 'asset-list'    | 'channel-detail'    | 'channel-list'    | 'collection-detail'    | 'collection-list'    | 'country-detail'    | 'country-list'    | 'customer-detail'    | 'customer-list'    | 'customer-group-list'    | 'customer-group-detail'    | 'draft-order-detail'    | 'facet-detail'    | 'facet-list'    | 'global-setting-detail'    | 'system-status'    | 'job-list'    | 'order-detail'    | 'order-list'    | 'modify-order'    | 'payment-method-detail'    | 'payment-method-list'    | 'product-detail'    | 'product-list'    | 'product-variant-detail'    | 'product-variant-list'    | 'profile'    | 'promotion-detail'    | 'promotion-list'    | 'role-detail'    | 'role-list'    | 'seller-detail'    | 'seller-list'    | 'shipping-method-detail'    | 'shipping-method-list'    | 'stock-location-detail'    | 'stock-location-list'    | 'tax-category-detail'    | 'tax-category-list'    | 'tax-rate-detail'    | 'tax-rate-list'    | 'zone-detail'    | 'zone-list'
```


---

# RouterLinkDefinition


## RouterLinkDefinition​


[​](#routerlinkdefinition)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[nav-builder-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/nav-builder/nav-builder-types.ts#L289)A function which returns the router link for an ActionBarItem or NavMenuItem.

[ActionBarItem](/reference/admin-ui-api/action-bar/action-bar-item#actionbaritem)[NavMenuItem](/reference/admin-ui-api/nav-menu/nav-menu-item#navmenuitem)
```
type RouterLinkDefinition = ((route: ActivatedRoute, context: ActionBarContext) => any[]) | any[]
```


---

# AlertConfig


## AlertConfig​


[​](#alertconfig)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[alerts.service.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/alerts/alerts.service.ts#L63)A configuration object for an Admin UI alert.

```
interface AlertConfig<T = any> {    id: string;    check: (context: AlertContext) => T | Promise<T> | Observable<T>;    recheck?: (context: AlertContext) => Observable<any>;    isAlert: (data: T, context: AlertContext) => boolean;    action: (data: T, context: AlertContext) => void;    label: (        data: T,        context: AlertContext,    ) => { text: string; translationVars?: { [key: string]: string | number } };    requiredPermissions?: Permission[];}
```

### id​


[​](#id)A unique identifier for the alert.

### check​


[​](#check)[AlertContext](/reference/admin-ui-api/alerts/alert-context#alertcontext)A function which is gets the data used to determine whether the alert should be shown.
Typically, this function will query the server or some other remote data source.

This function will be called once when the Admin UI app bootstraps, and can be also
set to run at regular intervals by setting the recheckIntervalMs property.

### recheck​


[​](#recheck)[AlertContext](/reference/admin-ui-api/alerts/alert-context#alertcontext)A function which returns an Observable which is used to determine when to re-run the check
function. Whenever the observable emits, the check function will be called again.

A basic time-interval-based recheck can be achieved by using the interval function from RxJS.

Example

```
import { interval } from 'rxjs';// ...recheck: () => interval(60_000)
```

If this is not set, the check function will only be called once when the Admin UI app bootstraps.

### isAlert​


[​](#isalert)[AlertContext](/reference/admin-ui-api/alerts/alert-context#alertcontext)A function which determines whether the alert should be shown based on the data returned by the check
function.

### action​


[​](#action)[AlertContext](/reference/admin-ui-api/alerts/alert-context#alertcontext)A function which is called when the alert is clicked in the Admin UI.

### label​


[​](#label)[AlertContext](/reference/admin-ui-api/alerts/alert-context#alertcontext)A function which returns the text used in the UI to describe the alert.

### requiredPermissions​


[​](#requiredpermissions)[Permission](/reference/typescript-api/common/permission#permission)A list of permissions which the current Administrator must have in order. If the current
Administrator does not have these permissions, none of the other alert functions will be called.


---

# AlertContext


## AlertContext​


[​](#alertcontext)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[alerts.service.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/alerts/alerts.service.ts#L29)The context object which is passed to the check, isAlert, label and action functions of an
AlertConfig object.

[AlertConfig](/reference/admin-ui-api/alerts/alert-config#alertconfig)
```
interface AlertContext {    injector: Injector;    dataService: DataService;    notificationService: NotificationService;    modalService: ModalService;}
```

### injector​


[​](#injector)[Injector](/reference/typescript-api/common/injector#injector)The Angular Injector which can be used to get instances
of services and other providers available in the application.

[Injector](https://angular.dev/api/core/Injector)
### dataService​


[​](#dataservice)[DataService](/reference/admin-ui-api/services/data-service#dataservice)The DataService, which provides methods for querying the
server-side data.

[DataService](/reference/admin-ui-api/services/data-service)
### notificationService​


[​](#notificationservice)[NotificationService](/reference/admin-ui-api/services/notification-service#notificationservice)The NotificationService, which provides methods for
displaying notifications to the user.

[NotificationService](/reference/admin-ui-api/services/notification-service)
### modalService​


[​](#modalservice)[ModalService](/reference/admin-ui-api/services/modal-service#modalservice)The ModalService, which provides methods for
opening modal dialogs.

[ModalService](/reference/admin-ui-api/services/modal-service)


---

# RegisterAlert


## registerAlert​


[​](#registeralert)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[register-alert.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/extension/register-alert.ts#L12)Registers an alert which can be displayed in the Admin UI alert dropdown in the top bar.
The alert is configured using the AlertConfig object.

[AlertConfig](/reference/admin-ui-api/alerts/alert-config#alertconfig)
```
function registerAlert(config: AlertConfig): void
```

Parameters

### config​


[​](#config)[AlertConfig](/reference/admin-ui-api/alerts/alert-config#alertconfig)


---


# BulkAction


## BulkAction​


[​](#bulkaction)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[bulk-action-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/bulk-action-registry/bulk-action-types.ts#L99)Configures a bulk action which can be performed on all selected items in a list view.

For a full example, see the registerBulkAction docs.

[registerBulkAction](/reference/admin-ui-api/bulk-actions/register-bulk-action#registerbulkaction)
```
interface BulkAction<ItemType = any, ComponentType = any> {    location: BulkActionLocationId;    label: string;    getTranslationVars?: (        context: BulkActionFunctionContext<ItemType, ComponentType>,    ) => Record<string, string | number> | Promise<Record<string, string | number>>;    icon?: string;    iconClass?: string;    onClick: (context: BulkActionClickContext<ItemType, ComponentType>) => void;    isVisible?: (context: BulkActionFunctionContext<ItemType, ComponentType>) => boolean | Promise<boolean>;    requiresPermission?: string | ((userPermissions: string[]) => boolean);}
```

### location​


[​](#location)[BulkActionLocationId](/reference/admin-ui-api/bulk-actions/bulk-action#bulkactionlocationid)
### label​


[​](#label)
### getTranslationVars​


[​](#gettranslationvars)[BulkActionFunctionContext](/reference/admin-ui-api/bulk-actions/bulk-action#bulkactionfunctioncontext)An optional function that should resolve to a map of translation variables which can be
used when translating the label string.

### icon​


[​](#icon)A valid Clarity Icons icon shape, e.g.
"cog", "user", "info-standard".

[Clarity Icons](https://core.clarity.design/foundation/icons/shapes/)
### iconClass​


[​](#iconclass)A class to be added to the icon element. Examples:

- is-success
- is-danger
- is-warning
- is-info
- is-highlight

### onClick​


[​](#onclick)[BulkActionClickContext](/reference/admin-ui-api/bulk-actions/bulk-action#bulkactionclickcontext)Defines the logic that executes when the bulk action button is clicked.

### isVisible​


[​](#isvisible)[BulkActionFunctionContext](/reference/admin-ui-api/bulk-actions/bulk-action#bulkactionfunctioncontext)A function that determines whether this bulk action item should be displayed in the menu.
If not defined, the item will always be displayed.

This function will be invoked each time the selection is changed, so try to avoid expensive code
running here.

Example

```
import { registerBulkAction, DataService } from '@vendure/admin-ui/core';registerBulkAction({  location: 'product-list',  label: 'Assign to channel',  // Only display this action if there are multiple channels  isVisible: ({ injector }) => injector.get(DataService).client    .userStatus()    .mapSingle(({ userStatus }) => 1 < userStatus.channels.length)    .toPromise(),  // ...});
```

### requiresPermission​


[​](#requirespermission)Control the display of this item based on the user permissions.

Example

```
registerBulkAction({  // Can be specified as a simple string  requiresPermission: Permission.UpdateProduct,  // Or as a function that returns a boolean if permissions are satisfied  requiresPermission: userPermissions =>    userPermissions.includes(Permission.UpdateCatalog) ||    userPermissions.includes(Permission.UpdateProduct),  // ...})
```

## BulkActionLocationId​


[​](#bulkactionlocationid)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[bulk-action-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/bulk-action-registry/bulk-action-types.ts#L12)A valid location of a list view that supports the bulk actions API.

```
type BulkActionLocationId = | 'product-list'    | 'facet-list'    | 'collection-list'    | 'customer-list'    | 'customer-group-list'    | 'customer-group-members-list'    | 'customer-group-members-picker-list'    | 'promotion-list'    | 'seller-list'    | 'channel-list'    | 'administrator-list'    | 'role-list'    | 'shipping-method-list'    | 'stock-location-list'    | 'payment-method-list'    | 'tax-category-list'    | 'tax-rate-list'    | 'zone-list'    | 'zone-members-list'    | string
```

## BulkActionFunctionContext​


[​](#bulkactionfunctioncontext)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[bulk-action-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/bulk-action-registry/bulk-action-types.ts#L43)This is the argument which gets passed to the getTranslationVars and isVisible functions
of the BulkAction definition.

```
interface BulkActionFunctionContext<ItemType, ComponentType> {    selection: ItemType[];    hostComponent: ComponentType;    injector: Injector;    route: ActivatedRoute;}
```

### selection​


[​](#selection)An array of the selected items from the list.

### hostComponent​


[​](#hostcomponent)The component instance that is hosting the list view. For instance,
ProductListComponent. This can be used to call methods on the instance,
e.g. calling hostComponent.refresh() to force a list refresh after
deleting the selected items.

### injector​


[​](#injector)[Injector](/reference/typescript-api/common/injector#injector)The Angular Injector which can be used
to get service instances which might be needed in the click handler.

[Injector](https://angular.io/api/core/Injector)
### route​


[​](#route)
## BulkActionClickContext​


[​](#bulkactionclickcontext)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[bulk-action-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/bulk-action-registry/bulk-action-types.ts#L74)This is the argument which gets passed to the onClick function of a BulkAction.

```
interface BulkActionClickContext<ItemType, ComponentType> extends BulkActionFunctionContext<ItemType, ComponentType> {    clearSelection: () => void;    event: MouseEvent;}
```

- Extends: BulkActionFunctionContext<ItemType, ComponentType>

[BulkActionFunctionContext](/reference/admin-ui-api/bulk-actions/bulk-action#bulkactionfunctioncontext)
### clearSelection​


[​](#clearselection)Clears the selection in the active list view.

### event​


[​](#event)The click event itself.


---

# RegisterBulkAction


## registerBulkAction​


[​](#registerbulkaction)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[register-bulk-action.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/extension/register-bulk-action.ts#L52)Registers a custom BulkAction which can be invoked from the bulk action menu
of any supported list view.

[BulkAction](/reference/admin-ui-api/bulk-actions/bulk-action#bulkaction)This allows you to provide custom functionality that can operate on any of the selected
items in the list view.

In this example, imagine we have an integration with a 3rd-party text translation service. This
bulk action allows us to select multiple products from the product list view, and send them for
translation via a custom service which integrates with the translation service's API.

Example

```
import { ModalService, registerBulkAction, SharedModule } from '@vendure/admin-ui/core';import { ProductDataTranslationService } from './product-data-translation.service';export default [    ProductDataTranslationService,    registerBulkAction({        location: 'product-list',        label: 'Send to translation service',        icon: 'language',        onClick: ({ injector, selection }) => {            const modalService = injector.get(ModalService);            const translationService = injector.get(ProductDataTranslationService);            modalService                .dialog({                    title: `Send ${selection.length} products for translation?`,                    buttons: [                        { type: 'secondary', label: 'cancel' },                        { type: 'primary', label: 'send', returnValue: true },                    ],                })                .subscribe(response => {                    if (response) {                        translationService.sendForTranslation(selection.map(item => item.productId));                    }                });        },    }),];
```

```
function registerBulkAction(bulkAction: BulkAction): void
```

Parameters

### bulkAction​


[​](#bulkaction)[BulkAction](/reference/admin-ui-api/bulk-actions/bulk-action#bulkaction)


---

# AssetPickerDialogComponent


## AssetPickerDialogComponent​


[​](#assetpickerdialogcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[asset-picker-dialog.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/components/asset-picker-dialog/asset-picker-dialog.component.ts#L51)A dialog which allows the creation and selection of assets.

Example

```
selectAssets() {  this.modalService    .fromComponent(AssetPickerDialogComponent, {        size: 'xl',    })    .subscribe(result => {        if (result && result.length) {            // ...        }    });}
```

```
class AssetPickerDialogComponent implements OnInit, AfterViewInit, OnDestroy, Dialog<Asset[]> {    assets$: Observable<AssetLike[]>;    allTags$: Observable<TagFragment[]>;    paginationConfig: PaginationInstance = {        currentPage: 1,        itemsPerPage: 25,        totalItems: 1,    };    multiSelect = true;    initialTags: string[] = [];    resolveWith: (result?: Asset[]) => void;    selection: Asset[] = [];    searchTerm$ = new BehaviorSubject<string | undefined>(undefined);    filterByTags$ = new BehaviorSubject<TagFragment[] | undefined>(undefined);    uploading = false;    constructor(dataService: DataService, notificationService: NotificationService)    ngOnInit() => ;    ngAfterViewInit() => ;    ngOnDestroy() => void;    pageChange(page: number) => ;    itemsPerPageChange(itemsPerPage: number) => ;    cancel() => ;    select() => ;    createAssets(files: File[]) => ;}
```

- Implements: OnInit, AfterViewInit, OnDestroy, Dialog<Asset[]>

[Dialog](/reference/admin-ui-api/services/modal-service#dialog)[Asset](/reference/typescript-api/entities/asset#asset)
### assets$​


[​](#assets)
### allTags$​


[​](#alltags)
### paginationConfig​


[​](#paginationconfig)
### multiSelect​


[​](#multiselect)
### initialTags​


[​](#initialtags)
### resolveWith​


[​](#resolvewith)[Asset](/reference/typescript-api/entities/asset#asset)
### selection​


[​](#selection)[Asset](/reference/typescript-api/entities/asset#asset)
### searchTerm$​


[​](#searchterm)
### filterByTags$​


[​](#filterbytags)
### uploading​


[​](#uploading)
### constructor​


[​](#constructor)[DataService](/reference/admin-ui-api/services/data-service#dataservice)[NotificationService](/reference/admin-ui-api/services/notification-service#notificationservice)
### ngOnInit​


[​](#ngoninit)
### ngAfterViewInit​


[​](#ngafterviewinit)
### ngOnDestroy​


[​](#ngondestroy)
### pageChange​


[​](#pagechange)
### itemsPerPageChange​


[​](#itemsperpagechange)
### cancel​


[​](#cancel)
### select​


[​](#select)
### createAssets​


[​](#createassets)


---

# ChipComponent


## ChipComponent​


[​](#chipcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[chip.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/components/chip/chip.component.ts#L16)A chip component for displaying a label with an optional action icon.

Example

```
<vdr-chip [colorFrom]="item.value"          icon="close"          (iconClick)="clear(item)">{{ item.value }}</vdr-chip>
```

```
class ChipComponent {    @Input() icon: string;    @Input() invert = false;    @Input() colorFrom = '';    @Input() colorType: 'error' | 'success' | 'warning';    @Output() iconClick = new EventEmitter<MouseEvent>();}
```

### icon​


[​](#icon)The icon should be the name of one of the available Clarity icons: https://clarity.design/foundation/icons/shapes/

[https://clarity.design/foundation/icons/shapes/](https://clarity.design/foundation/icons/shapes/)
### invert​


[​](#invert)
### colorFrom​


[​](#colorfrom)If set, the chip will have an auto-generated background
color based on the string value passed in.

### colorType​


[​](#colortype)The color of the chip can also be one of the standard status colors.

### iconClick​


[​](#iconclick)


---

# CurrencyInputComponent


## CurrencyInputComponent​


[​](#currencyinputcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[currency-input.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/components/currency-input/currency-input.component.ts#L33)A form input control which displays currency in decimal format, whilst working
with the integer cent value in the background.

Example

```
<vdr-currency-input    [(ngModel)]="entityPrice"    [currencyCode]="currencyCode"></vdr-currency-input>
```

```
class CurrencyInputComponent implements ControlValueAccessor, OnInit, OnChanges, OnDestroy {    @Input() disabled = false;    @Input() readonly = false;    @Input() value: number;    @Input() currencyCode = '';    @Output() valueChange = new EventEmitter();    prefix$: Observable<string>;    suffix$: Observable<string>;    hasFractionPart = true;    onChange: (val: any) => void;    onTouch: () => void;    _inputValue: string;    readonly precision: number;    readonly precisionFactor: number;    constructor(dataService: DataService, currencyService: CurrencyService)    ngOnInit() => ;    ngOnChanges(changes: SimpleChanges) => ;    ngOnDestroy() => ;    registerOnChange(fn: any) => ;    registerOnTouched(fn: any) => ;    setDisabledState(isDisabled: boolean) => ;    onInput(value: string) => ;    onFocus() => ;    writeValue(value: any) => void;}
```

- Implements: ControlValueAccessor, OnInit, OnChanges, OnDestroy

### disabled​


[​](#disabled)
### readonly​


[​](#readonly)
### value​


[​](#value)
### currencyCode​


[​](#currencycode)
### valueChange​


[​](#valuechange)
### prefix$​


[​](#prefix)
### suffix$​


[​](#suffix)
### hasFractionPart​


[​](#hasfractionpart)
### onChange​


[​](#onchange)
### onTouch​


[​](#ontouch)
### _inputValue​


[​](#_inputvalue)
### precision​


[​](#precision)
### precisionFactor​


[​](#precisionfactor)
### constructor​


[​](#constructor)[DataService](/reference/admin-ui-api/services/data-service#dataservice)
### ngOnInit​


[​](#ngoninit)
### ngOnChanges​


[​](#ngonchanges)
### ngOnDestroy​


[​](#ngondestroy)
### registerOnChange​


[​](#registeronchange)
### registerOnTouched​


[​](#registerontouched)
### setDisabledState​


[​](#setdisabledstate)
### onInput​


[​](#oninput)
### onFocus​


[​](#onfocus)
### writeValue​


[​](#writevalue)


---

# DataTableComponent


## DataTableComponent​


[​](#datatablecomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[data-table.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/components/data-table/data-table.component.ts#L86)A table for displaying PaginatedList results. It is designed to be used inside components which
extend the BaseListComponent class.

[BaseListComponent](/reference/admin-ui-api/list-detail-views/base-list-component#baselistcomponent)Deprecated This component is deprecated. Use the DataTable2Component instead.

[DataTable2Component](/reference/admin-ui-api/components/data-table2component#datatable2component)Example

```
<vdr-data-table  [items]="items$ | async"  [itemsPerPage]="itemsPerPage$ | async"  [totalItems]="totalItems$ | async"  [currentPage]="currentPage$ | async"  (pageChange)="setPageNumber($event)"  (itemsPerPageChange)="setItemsPerPage($event)">  <!-- The header columns are defined first -->  <vdr-dt-column>{{ 'common.name' | translate }}</vdr-dt-column>  <vdr-dt-column></vdr-dt-column>  <vdr-dt-column></vdr-dt-column>  <!-- Then we define how a row is rendered -->  <ng-template let-taxRate="item">    <td class="left align-middle">{{ taxRate.name }}</td>    <td class="left align-middle">{{ taxRate.category.name }}</td>    <td class="left align-middle">{{ taxRate.zone.name }}</td>    <td class="left align-middle">{{ taxRate.value }}%</td>    <td class="right align-middle">      <vdr-table-row-action        iconShape="edit"        [label]="'common.edit' | translate"        [linkTo]="['./', taxRate.id]"      ></vdr-table-row-action>    </td>    <td class="right align-middle">      <vdr-dropdown>        <button type="button" class="btn btn-link btn-sm" vdrDropdownTrigger>          {{ 'common.actions' | translate }}          <clr-icon shape="caret down"></clr-icon>        </button>        <vdr-dropdown-menu vdrPosition="bottom-right">          <button              type="button"              class="delete-button"              (click)="deleteTaxRate(taxRate)"              [disabled]="!(['DeleteSettings', 'DeleteTaxRate'] | hasPermission)"              vdrDropdownItem          >              <clr-icon shape="trash" class="is-danger"></clr-icon>              {{ 'common.delete' | translate }}          </button>        </vdr-dropdown-menu>      </vdr-dropdown>    </td>  </ng-template></vdr-data-table>
```

```
class DataTableComponent<T> implements AfterContentInit, OnChanges, OnInit, OnDestroy {    @Input() items: T[];    @Input() itemsPerPage: number;    @Input() currentPage: number;    @Input() totalItems: number;    @Input() emptyStateLabel: string;    @Input() selectionManager?: SelectionManager<T>;    @Output() pageChange = new EventEmitter<number>();    @Output() itemsPerPageChange = new EventEmitter<number>();    @Input() allSelected: boolean;    @Input() isRowSelectedFn: ((item: T) => boolean) | undefined;    @Output() allSelectChange = new EventEmitter<void>();    @Output() rowSelectChange = new EventEmitter<{ event: MouseEvent; item: T }>();    @ContentChildren(DataTableColumnComponent) columns: QueryList<DataTableColumnComponent>;    @ContentChildren(TemplateRef) templateRefs: QueryList<TemplateRef<any>>;    rowTemplate: TemplateRef<any>;    currentStart: number;    currentEnd: number;    disableSelect = false;    constructor(changeDetectorRef: ChangeDetectorRef)    ngOnInit() => ;    ngOnChanges(changes: SimpleChanges) => ;    ngOnDestroy() => ;    ngAfterContentInit() => void;    trackByFn(index: number, item: any) => ;    onToggleAllClick() => ;    onRowClick(item: T, event: MouseEvent) => ;}
```

- Implements: AfterContentInit, OnChanges, OnInit, OnDestroy

### items​


[​](#items)
### itemsPerPage​


[​](#itemsperpage)
### currentPage​


[​](#currentpage)
### totalItems​


[​](#totalitems)
### emptyStateLabel​


[​](#emptystatelabel)
### selectionManager​


[​](#selectionmanager)
### pageChange​


[​](#pagechange)
### itemsPerPageChange​


[​](#itemsperpagechange)
### allSelected​


[​](#allselected)
### isRowSelectedFn​


[​](#isrowselectedfn)
### allSelectChange​


[​](#allselectchange)
### rowSelectChange​


[​](#rowselectchange)
### columns​


[​](#columns)
### templateRefs​


[​](#templaterefs)
### rowTemplate​


[​](#rowtemplate)
### currentStart​


[​](#currentstart)
### currentEnd​


[​](#currentend)
### disableSelect​


[​](#disableselect)
### constructor​


[​](#constructor)
### ngOnInit​


[​](#ngoninit)
### ngOnChanges​


[​](#ngonchanges)
### ngOnDestroy​


[​](#ngondestroy)
### ngAfterContentInit​


[​](#ngaftercontentinit)
### trackByFn​


[​](#trackbyfn)
### onToggleAllClick​


[​](#ontoggleallclick)
### onRowClick​


[​](#onrowclick)


---

# DataTable2Component


## DataTable2Component​


[​](#datatable2component)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[data-table2.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/components/data-table-2/data-table2.component.ts#L101)A table for displaying PaginatedList results. It is designed to be used inside components which
extend the BaseListComponent or TypedBaseListComponent class.

[BaseListComponent](/reference/admin-ui-api/list-detail-views/base-list-component#baselistcomponent)[TypedBaseListComponent](/reference/admin-ui-api/list-detail-views/typed-base-list-component#typedbaselistcomponent)Example

```
<vdr-data-table-2    id="product-review-list"    [items]="items$ | async"    [itemsPerPage]="itemsPerPage$ | async"    [totalItems]="totalItems$ | async"    [currentPage]="currentPage$ | async"    [filters]="filters"    (pageChange)="setPageNumber($event)"    (itemsPerPageChange)="setItemsPerPage($event)">    <vdr-bulk-action-menu        locationId="product-review-list"        [hostComponent]="this"        [selectionManager]="selectionManager"    />    <vdr-dt2-search        [searchTermControl]="searchTermControl"        searchTermPlaceholder="Filter by title"    />    <vdr-dt2-column [heading]="'common.id' | translate" [hiddenByDefault]="true">        <ng-template let-review="item">            {{ review.id }}        </ng-template>    </vdr-dt2-column>    <vdr-dt2-column        [heading]="'common.created-at' | translate"        [hiddenByDefault]="true"        [sort]="sorts.get('createdAt')"    >        <ng-template let-review="item">            {{ review.createdAt | localeDate : 'short' }}        </ng-template>    </vdr-dt2-column>    <vdr-dt2-column        [heading]="'common.updated-at' | translate"        [hiddenByDefault]="true"        [sort]="sorts.get('updatedAt')"    >        <ng-template let-review="item">            {{ review.updatedAt | localeDate : 'short' }}        </ng-template>    </vdr-dt2-column>    <vdr-dt2-column [heading]="'common.name' | translate" [optional]="false" [sort]="sorts.get('name')">        <ng-template let-review="item">            <a class="button-ghost" [routerLink]="['./', review.id]"                ><span>{{ review.name }}</span>                <clr-icon shape="arrow right"></clr-icon>            </a>        </ng-template>    </vdr-dt2-column></vdr-data-table-2>
```

```
class DataTable2Component<T> implements AfterContentInit, OnChanges, OnDestroy {    @Input() id: DataTableLocationId;    @Input() items: T[];    @Input() itemsPerPage: number;    @Input() currentPage: number;    @Input() totalItems: number;    @Input() emptyStateLabel: string;    @Input() filters: DataTableFilterCollection;    @Input() activeIndex = -1;    @Input() trackByPath = 'id';    @Output() pageChange = new EventEmitter<number>();    @Output() itemsPerPageChange = new EventEmitter<number>();    @Output() visibleColumnsChange = new EventEmitter<Array<DataTable2ColumnComponent<T>>>();    @ContentChildren(DataTable2ColumnComponent) columns: QueryList<DataTable2ColumnComponent<T>>;    @ContentChildren(DataTableCustomFieldColumnComponent)    customFieldColumns: QueryList<DataTableCustomFieldColumnComponent<T>>;    @ContentChild(DataTable2SearchComponent) searchComponent: DataTable2SearchComponent;    @ContentChild(BulkActionMenuComponent) bulkActionMenuComponent: BulkActionMenuComponent;    @ContentChild('vdrDt2CustomSearch') customSearchTemplate: TemplateRef<any>;    @ContentChildren(TemplateRef) templateRefs: QueryList<TemplateRef<any>>;    injector = inject(Injector);    route = inject(ActivatedRoute);    filterPresetService = inject(FilterPresetService);    dataTableCustomComponentService = inject(DataTableCustomComponentService);    dataTableConfigService = inject(DataTableConfigService);    protected customComponents = new Map<string, { config: DataTableComponentConfig; injector: Injector }>();    rowTemplate: TemplateRef<any>;    currentStart: number;    currentEnd: number;    disableSelect = false;    showSearchFilterRow = false;    protected uiLanguage$: Observable<LanguageCode>;    protected destroy$ = new Subject<void>();    constructor(changeDetectorRef: ChangeDetectorRef, dataService: DataService)    selectionManager: void    allColumns: void    visibleSortedColumns: void    sortedColumns: void    ngOnChanges(changes: SimpleChanges) => ;    ngOnDestroy() => ;    ngAfterContentInit() => void;    onColumnReorder(event: { column: DataTable2ColumnComponent<any>; newIndex: number }) => ;    onColumnsReset() => ;    toggleSearchFilterRow() => ;    trackByFn(index: number, item: any) => ;    onToggleAllClick() => ;    onRowClick(item: T, event: MouseEvent) => ;}
```

- Implements: AfterContentInit, OnChanges, OnDestroy

### id​


[​](#id)
### items​


[​](#items)
### itemsPerPage​


[​](#itemsperpage)
### currentPage​


[​](#currentpage)
### totalItems​


[​](#totalitems)
### emptyStateLabel​


[​](#emptystatelabel)
### filters​


[​](#filters)
### activeIndex​


[​](#activeindex)
### trackByPath​


[​](#trackbypath)
### pageChange​


[​](#pagechange)
### itemsPerPageChange​


[​](#itemsperpagechange)
### visibleColumnsChange​


[​](#visiblecolumnschange)
### columns​


[​](#columns)
### customFieldColumns​


[​](#customfieldcolumns)
### searchComponent​


[​](#searchcomponent)
### bulkActionMenuComponent​


[​](#bulkactionmenucomponent)
### customSearchTemplate​


[​](#customsearchtemplate)
### templateRefs​


[​](#templaterefs)
### injector​


[​](#injector)
### route​


[​](#route)
### filterPresetService​


[​](#filterpresetservice)
### dataTableCustomComponentService​


[​](#datatablecustomcomponentservice)
### dataTableConfigService​


[​](#datatableconfigservice)
### customComponents​


[​](#customcomponents)
### rowTemplate​


[​](#rowtemplate)
### currentStart​


[​](#currentstart)
### currentEnd​


[​](#currentend)
### disableSelect​


[​](#disableselect)
### showSearchFilterRow​


[​](#showsearchfilterrow)
### uiLanguage$​


[​](#uilanguage)[LanguageCode](/reference/typescript-api/common/language-code#languagecode)
### destroy$​


[​](#destroy)
### constructor​


[​](#constructor)[DataService](/reference/admin-ui-api/services/data-service#dataservice)
### selectionManager​


[​](#selectionmanager)
### allColumns​


[​](#allcolumns)
### visibleSortedColumns​


[​](#visiblesortedcolumns)
### sortedColumns​


[​](#sortedcolumns)
### ngOnChanges​


[​](#ngonchanges)
### ngOnDestroy​


[​](#ngondestroy)
### ngAfterContentInit​


[​](#ngaftercontentinit)
### onColumnReorder​


[​](#oncolumnreorder)
### onColumnsReset​


[​](#oncolumnsreset)
### toggleSearchFilterRow​


[​](#togglesearchfilterrow)
### trackByFn​


[​](#trackbyfn)
### onToggleAllClick​


[​](#ontoggleallclick)
### onRowClick​


[​](#onrowclick)


---

# DatetimePickerComponent


## DatetimePickerComponent​


[​](#datetimepickercomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[datetime-picker.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/components/datetime-picker/datetime-picker.component.ts#L39)A form input for selecting datetime values.

Example

```
<vdr-datetime-picker [(ngModel)]="startDate"></vdr-datetime-picker>
```

```
class DatetimePickerComponent implements ControlValueAccessor, AfterViewInit, OnInit, OnDestroy {    @Input() yearRange;    @Input() weekStartDay: DayOfWeek = 'mon';    @Input() timeGranularityInterval = 5;    @Input() min: string | null = null;    @Input() max: string | null = null;    @Input() readonly = false;    @ViewChild('dropdownComponent', { static: true }) dropdownComponent: DropdownComponent;    @ViewChild('datetimeInput', { static: true }) datetimeInput: ElementRef<HTMLInputElement>;    @ViewChild('calendarTable') calendarTable: ElementRef<HTMLTableElement>;    disabled = false;    calendarView$: Observable<CalendarView>;    current$: Observable<CurrentView>;    selected$: Observable<Date | null>;    selectedHours$: Observable<number | null>;    selectedMinutes$: Observable<number | null>;    years: number[];    weekdays: string[] = [];    hours: number[];    minutes: number[];    constructor(changeDetectorRef: ChangeDetectorRef, datetimePickerService: DatetimePickerService)    ngOnInit() => ;    ngAfterViewInit() => void;    ngOnDestroy() => void;    registerOnChange(fn: any) => ;    registerOnTouched(fn: any) => ;    setDisabledState(isDisabled: boolean) => ;    writeValue(value: string | null) => ;    prevMonth() => ;    nextMonth() => ;    selectToday() => ;    setYear(event: Event) => ;    setMonth(event: Event) => ;    selectDay(day: DayCell) => ;    clearValue() => ;    handleCalendarKeydown(event: KeyboardEvent) => ;    setHour(event: Event) => ;    setMinute(event: Event) => ;    closeDatepicker() => ;}
```

- Implements: ControlValueAccessor, AfterViewInit, OnInit, OnDestroy

### yearRange​


[​](#yearrange)The range above and below the current year which is selectable from
the year select control. If a min or max value is set, these will
override the yearRange.

### weekStartDay​


[​](#weekstartday)The day that the week should start with in the calendar view.

### timeGranularityInterval​


[​](#timegranularityinterval)The granularity of the minutes time picker

### min​


[​](#min)The minimum date as an ISO string

### max​


[​](#max)The maximum date as an ISO string

### readonly​


[​](#readonly)Sets the readonly state

### dropdownComponent​


[​](#dropdowncomponent)[DropdownComponent](/reference/admin-ui-api/components/dropdown-component#dropdowncomponent)
### datetimeInput​


[​](#datetimeinput)
### calendarTable​


[​](#calendartable)
### disabled​


[​](#disabled)
### calendarView$​


[​](#calendarview)
### current$​


[​](#current)
### selected$​


[​](#selected)
### selectedHours$​


[​](#selectedhours)
### selectedMinutes$​


[​](#selectedminutes)
### years​


[​](#years)
### weekdays​


[​](#weekdays)
### hours​


[​](#hours)
### minutes​


[​](#minutes)
### constructor​


[​](#constructor)
### ngOnInit​


[​](#ngoninit)
### ngAfterViewInit​


[​](#ngafterviewinit)
### ngOnDestroy​


[​](#ngondestroy)
### registerOnChange​


[​](#registeronchange)
### registerOnTouched​


[​](#registerontouched)
### setDisabledState​


[​](#setdisabledstate)
### writeValue​


[​](#writevalue)
### prevMonth​


[​](#prevmonth)
### nextMonth​


[​](#nextmonth)
### selectToday​


[​](#selecttoday)
### setYear​


[​](#setyear)
### setMonth​


[​](#setmonth)
### selectDay​


[​](#selectday)
### clearValue​


[​](#clearvalue)
### handleCalendarKeydown​


[​](#handlecalendarkeydown)
### setHour​


[​](#sethour)
### setMinute​


[​](#setminute)
### closeDatepicker​


[​](#closedatepicker)


---

# DropdownComponent


## DropdownComponent​


[​](#dropdowncomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[dropdown.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/components/dropdown/dropdown.component.ts#L28)Used for building dropdown menus.

Example

```
<vdr-dropdown>  <button class="btn btn-outline" vdrDropdownTrigger>      <clr-icon shape="plus"></clr-icon>      Select type  </button>  <vdr-dropdown-menu vdrPosition="bottom-left">    <button      *ngFor="let typeName of allTypes"      type="button"      vdrDropdownItem      (click)="selectType(typeName)"    >      typeName    </button>  </vdr-dropdown-menu></vdr-dropdown>
```

```
class DropdownComponent {    isOpen = false;    public trigger: ElementRef;    @Input() manualToggle = false;    onClick() => ;    toggleOpen() => ;    onOpenChange(callback: (isOpen: boolean) => void) => ;    setTriggerElement(elementRef: ElementRef) => ;}
```

### isOpen​


[​](#isopen)
### trigger​


[​](#trigger)
### manualToggle​


[​](#manualtoggle)
### onClick​


[​](#onclick)
### toggleOpen​


[​](#toggleopen)
### onOpenChange​


[​](#onopenchange)
### setTriggerElement​


[​](#settriggerelement)


---


# FacetValueSelectorComponent


## FacetValueSelectorComponent​


[​](#facetvalueselectorcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[facet-value-selector.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/components/facet-value-selector/facet-value-selector.component.ts#L34)A form control for selecting facet values.

Example

```
<vdr-facet-value-selector  (selectedValuesChange)="selectedValues = $event"></vdr-facet-value-selector>
```

The selectedValuesChange event will emit an array of FacetValue objects.

```
class FacetValueSelectorComponent implements OnInit, OnDestroy, ControlValueAccessor {    @Output() selectedValuesChange = new EventEmitter<FacetValueFragment[]>();    @Input() readonly = false;    @Input() transformControlValueAccessorValue: (value: FacetValueFragment[]) => any[] = value => value;    searchInput$ = new Subject<string>();    searchLoading = false;    searchResults$: Observable<FacetValueFragment[]>;    selectedIds$ = new Subject<string[]>();    onChangeFn: (val: any) => void;    onTouchFn: () => void;    disabled = false;    value: Array<string | FacetValueFragment>;    constructor(dataService: DataService, changeDetectorRef: ChangeDetectorRef)    ngOnInit() => void;    ngOnDestroy() => ;    onChange(selected: FacetValueFragment[]) => ;    registerOnChange(fn: any) => ;    registerOnTouched(fn: any) => ;    setDisabledState(isDisabled: boolean) => void;    focus() => ;    writeValue(obj: string | FacetValueFragment[] | Array<string | number> | null) => void;}
```

- Implements: OnInit, OnDestroy, ControlValueAccessor

### selectedValuesChange​


[​](#selectedvalueschange)
### readonly​


[​](#readonly)
### transformControlValueAccessorValue​


[​](#transformcontrolvalueaccessorvalue)
### searchInput$​


[​](#searchinput)
### searchLoading​


[​](#searchloading)
### searchResults$​


[​](#searchresults)
### selectedIds$​


[​](#selectedids)
### onChangeFn​


[​](#onchangefn)
### onTouchFn​


[​](#ontouchfn)
### disabled​


[​](#disabled)
### value​


[​](#value)
### constructor​


[​](#constructor)[DataService](/reference/admin-ui-api/services/data-service#dataservice)
### ngOnInit​


[​](#ngoninit)
### ngOnDestroy​


[​](#ngondestroy)
### onChange​


[​](#onchange)
### registerOnChange​


[​](#registeronchange)
### registerOnTouched​


[​](#registerontouched)
### setDisabledState​


[​](#setdisabledstate)
### focus​


[​](#focus)
### writeValue​


[​](#writevalue)


---

# ObjectTreeComponent


## ObjectTreeComponent​


[​](#objecttreecomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[object-tree.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/components/object-tree/object-tree.component.ts#L22)This component displays a plain JavaScript object as an expandable tree.

Example

```
<vdr-object-tree [value]="payment.metadata"></vdr-object-tree>
```

```
class ObjectTreeComponent implements OnChanges {    @Input() value: { [key: string]: any } | string;    @Input() isArrayItem = false;    depth: number;    expanded: boolean;    valueIsArray: boolean;    entries: Array<{ key: string; value: any }>;    constructor(parent: ObjectTreeComponent)    ngOnChanges() => ;    isObject(value: any) => boolean;}
```

- Implements: OnChanges

### value​


[​](#value)
### isArrayItem​


[​](#isarrayitem)
### depth​


[​](#depth)
### expanded​


[​](#expanded)
### valueIsArray​


[​](#valueisarray)
### entries​


[​](#entries)
### constructor​


[​](#constructor)[ObjectTreeComponent](/reference/admin-ui-api/components/object-tree-component#objecttreecomponent)
### ngOnChanges​


[​](#ngonchanges)
### isObject​


[​](#isobject)


---

# OrderStateLabelComponent


## OrderStateLabelComponent​


[​](#orderstatelabelcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[order-state-label.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/components/order-state-label/order-state-label.component.ts#L13)Displays the state of an order in a colored chip.

Example

```
<vdr-order-state-label [state]="order.state"></vdr-order-state-label>
```

```
class OrderStateLabelComponent {    @Input() state: string;    chipColorType: void}
```

### state​


[​](#state)
### chipColorType​


[​](#chipcolortype)


---

# ProductVariantSelectorComponent


## ProductVariantSelectorComponent​


[​](#productvariantselectorcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[product-variant-selector.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/components/product-variant-selector/product-variant-selector.component.ts#L21)A component for selecting product variants via an autocomplete-style select input.

Example

```
<vdr-product-variant-selector  (productSelected)="selectResult($event)"></vdr-product-variant-selector>
```

```
class ProductVariantSelectorComponent implements OnInit {    searchInput$ = new Subject<string>();    searchLoading = false;    searchResults$: Observable<ProductSelectorSearchQuery['search']['items']>;    @Output() productSelected = new EventEmitter<ProductSelectorSearchQuery['search']['items'][number]>();    constructor(dataService: DataService)    ngOnInit() => void;    selectResult(product?: ProductSelectorSearchQuery['search']['items'][number]) => ;}
```

- Implements: OnInit

### searchInput$​


[​](#searchinput)
### searchLoading​


[​](#searchloading)
### searchResults$​


[​](#searchresults)
### productSelected​


[​](#productselected)
### constructor​


[​](#constructor)[DataService](/reference/admin-ui-api/services/data-service#dataservice)
### ngOnInit​


[​](#ngoninit)
### selectResult​


[​](#selectresult)


---

# RichTextEditorComponent


## RichTextEditorComponent​


[​](#richtexteditorcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[rich-text-editor.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/components/rich-text-editor/rich-text-editor.component.ts#L32)A rich text (HTML) editor based on Prosemirror (https://prosemirror.net/)

[https://prosemirror.net/](https://prosemirror.net/)Example

```
<vdr-rich-text-editor    [(ngModel)]="description"    label="Description"></vdr-rich-text-editor>
```

```
class RichTextEditorComponent implements ControlValueAccessor, AfterViewInit, OnDestroy {    @Input() label: string;    @HostBinding('class.readonly')    _readonly = false;    onChange: (val: any) => void;    onTouch: () => void;    constructor(changeDetector: ChangeDetectorRef, prosemirrorService: ProsemirrorService, viewContainerRef: ViewContainerRef, contextMenuService: ContextMenuService)    menuElement: HTMLDivElement | null    ngAfterViewInit() => ;    ngOnDestroy() => ;    registerOnChange(fn: any) => ;    registerOnTouched(fn: any) => ;    setDisabledState(isDisabled: boolean) => ;    writeValue(value: any) => ;}
```

- Implements: ControlValueAccessor, AfterViewInit, OnDestroy

### label​


[​](#label)
### _readonly​


[​](#_readonly)
### onChange​


[​](#onchange)
### onTouch​


[​](#ontouch)
### constructor​


[​](#constructor)
### menuElement​


[​](#menuelement)
### ngAfterViewInit​


[​](#ngafterviewinit)
### ngOnDestroy​


[​](#ngondestroy)
### registerOnChange​


[​](#registeronchange)
### registerOnTouched​


[​](#registerontouched)
### setDisabledState​


[​](#setdisabledstate)
### writeValue​


[​](#writevalue)



---

# ZoneSelectorComponent


## ZoneSelectorComponent​


[​](#zoneselectorcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[zone-selector.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/components/zone-selector/zone-selector.component.ts#L40)A form control for selecting zones.

```
class ZoneSelectorComponent implements ControlValueAccessor {    @Output() selectedValuesChange = new EventEmitter<Zone>();    @Input() readonly = false;    @Input() transformControlValueAccessorValue: (value: Zone | undefined) => any = value => value?.id;    selectedId$ = new Subject<string>();    onChangeFn: (val: any) => void;    onTouchFn: () => void;    disabled = false;    value: string | Zone;    zones$ = this.dataService        .query(GetZoneSelectorListDocument, { options: { take: 999 } })        .mapSingle(result => result.zones.items);    constructor(dataService: DataService, changeDetectorRef: ChangeDetectorRef)    onChange(selected: Zone) => ;    registerOnChange(fn: any) => ;    registerOnTouched(fn: any) => ;    setDisabledState(isDisabled: boolean) => void;    focus() => ;    writeValue(obj: string | Zone | null) => void;}
```

- Implements: ControlValueAccessor

### selectedValuesChange​


[​](#selectedvalueschange)
### readonly​


[​](#readonly)
### transformControlValueAccessorValue​


[​](#transformcontrolvalueaccessorvalue)[Zone](/reference/typescript-api/entities/zone#zone)
### selectedId$​


[​](#selectedid)
### onChangeFn​


[​](#onchangefn)
### onTouchFn​


[​](#ontouchfn)
### disabled​


[​](#disabled)
### value​


[​](#value)[Zone](/reference/typescript-api/entities/zone#zone)
### zones$​


[​](#zones)
### constructor​


[​](#constructor)[DataService](/reference/admin-ui-api/services/data-service#dataservice)
### onChange​


[​](#onchange)[Zone](/reference/typescript-api/entities/zone#zone)
### registerOnChange​


[​](#registeronchange)
### registerOnTouched​


[​](#registerontouched)
### setDisabledState​


[​](#setdisabledstate)
### focus​


[​](#focus)
### writeValue​


[​](#writevalue)[Zone](/reference/typescript-api/entities/zone#zone)

---

# CustomDetailComponentConfig


## CustomDetailComponentConfig​


[​](#customdetailcomponentconfig)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[custom-detail-component-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/custom-detail-component/custom-detail-component-types.ts#L25)Configures a CustomDetailComponent to be placed in the given location.

[CustomDetailComponent](/reference/admin-ui-api/custom-detail-components/custom-detail-component#customdetailcomponent)
```
interface CustomDetailComponentConfig {    locationId: CustomDetailComponentLocationId;    component: Type<CustomDetailComponent>;    providers?: Provider[];}
```

### locationId​


[​](#locationid)[CustomDetailComponentLocationId](/reference/admin-ui-api/custom-detail-components/custom-detail-component-location-id#customdetailcomponentlocationid)
### component​


[​](#component)[CustomDetailComponent](/reference/admin-ui-api/custom-detail-components/custom-detail-component#customdetailcomponent)
### providers​


[​](#providers)


---

# CustomDetailComponentLocationId


## CustomDetailComponentLocationId​


[​](#customdetailcomponentlocationid)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[component-registry-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/common/component-registry-types.ts#L115)The valid locations for embedding a CustomDetailComponent.

[CustomDetailComponent](/reference/admin-ui-api/custom-detail-components/custom-detail-component#customdetailcomponent)
```
type CustomDetailComponentLocationId = | 'administrator-profile'    | 'administrator-detail'    | 'channel-detail'    | 'collection-detail'    | 'country-detail'    | 'customer-detail'    | 'customer-group-detail'    | 'draft-order-detail'    | 'facet-detail'    | 'global-settings-detail'    | 'order-detail'    | 'payment-method-detail'    | 'product-detail'    | 'product-variant-detail'    | 'promotion-detail'    | 'seller-detail'    | 'shipping-method-detail'    | 'stock-location-detail'    | 'tax-category-detail'    | 'tax-rate-detail'    | 'zone-detail'
```


---

# CustomDetailComponent


## CustomDetailComponent​


[​](#customdetailcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[custom-detail-component-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/custom-detail-component/custom-detail-component-types.ts#L14)CustomDetailComponents allow any arbitrary Angular components to be embedded in entity detail
pages of the Admin UI.

```
interface CustomDetailComponent {    entity$: Observable<any>;    detailForm: UntypedFormGroup;}
```

### entity$​


[​](#entity)
### detailForm​


[​](#detailform)


---

# RegisterCustomDetailComponent


## registerCustomDetailComponent​


[​](#registercustomdetailcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[register-custom-detail-component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/extension/register-custom-detail-component.ts#L57)Registers a CustomDetailComponent to be placed in a given location. This allows you
to embed any type of custom Angular component in the entity detail pages of the Admin UI.

[CustomDetailComponent](/reference/admin-ui-api/custom-detail-components/custom-detail-component#customdetailcomponent)Example

```
import { Component, OnInit } from '@angular/core';import { switchMap } from 'rxjs';import { FormGroup } from '@angular/forms';import { CustomFieldConfig } from '@vendure/common/lib/generated-types';import {    DataService,    SharedModule,    CustomDetailComponent,    registerCustomDetailComponent,    GetProductWithVariants} from '@vendure/admin-ui/core';@Component({    template: `{{ extraInfo$ | async | json }}`,    standalone: true,    imports: [SharedModule],})export class ProductInfoComponent implements CustomDetailComponent, OnInit {    // These two properties are provided by Vendure and will vary    // depending on the particular detail page you are embedding this    // component into.    entity$: Observable<GetProductWithVariants.Product>    detailForm: FormGroup;    extraInfo$: Observable<any>;    constructor(private cmsDataService: CmsDataService) {}    ngOnInit() {        this.extraInfo$ = this.entity$.pipe(            switchMap(entity => this.cmsDataService.getDataFor(entity.id))        );    }}export default [    registerCustomDetailComponent({        locationId: 'product-detail',        component: ProductInfoComponent,    }),];
```

```
function registerCustomDetailComponent(config: CustomDetailComponentConfig): void
```

Parameters

### config​


[​](#config)[CustomDetailComponentConfig](/reference/admin-ui-api/custom-detail-components/custom-detail-component-config#customdetailcomponentconfig)



---

# CustomerHistoryEntryComponent


## CustomerHistoryEntryComponent​


[​](#customerhistoryentrycomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[history-entry-component-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/custom-history-entry-component/history-entry-component-types.ts#L64)Used to implement a HistoryEntryComponent which requires access to the Customer object.

[HistoryEntryComponent](/reference/admin-ui-api/custom-history-entry-components/history-entry-component#historyentrycomponent)
```
interface CustomerHistoryEntryComponent extends HistoryEntryComponent {    customer: CustomerFragment;}
```

- Extends: HistoryEntryComponent

[HistoryEntryComponent](/reference/admin-ui-api/custom-history-entry-components/history-entry-component#historyentrycomponent)
### customer​


[​](#customer)


---

# HistoryEntryComponent


## HistoryEntryComponent​


[​](#historyentrycomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[history-entry-component-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/custom-history-entry-component/history-entry-component-types.ts#L16)This interface should be implemented by components intended to display a history entry in the
Order or Customer history timeline. If the component needs access to the Order or Customer object itself,
you should implement OrderHistoryEntryComponent or CustomerHistoryEntryComponent respectively.

[OrderHistoryEntryComponent](/reference/admin-ui-api/custom-history-entry-components/order-history-entry-component#orderhistoryentrycomponent)[CustomerHistoryEntryComponent](/reference/admin-ui-api/custom-history-entry-components/customer-history-entry-component#customerhistoryentrycomponent)
```
interface HistoryEntryComponent {    entry: TimelineHistoryEntry;    getDisplayType: (entry: TimelineHistoryEntry) => TimelineDisplayType;    isFeatured: (entry: TimelineHistoryEntry) => boolean;    getName?: (entry: TimelineHistoryEntry) => string | undefined;    getIconShape?: (entry: TimelineHistoryEntry) => string | string[] | undefined;}
```

### entry​


[​](#entry)The HistoryEntry data.

### getDisplayType​


[​](#getdisplaytype)Defines whether this entry is highlighted with a "success", "error" etc. color.

### isFeatured​


[​](#isfeatured)Featured entries are always expanded. Non-featured entries start of collapsed and can be clicked
to expand.

### getName​


[​](#getname)Returns the name of the person who did this action. For example, it could be the Customer's name
or "Administrator".

### getIconShape​


[​](#geticonshape)Optional Clarity icon shape to display with the entry. Examples: 'note', ['success-standard', 'is-solid']


---

# HistoryEntryConfig


## HistoryEntryConfig​


[​](#historyentryconfig)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[history-entry-component-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/custom-history-entry-component/history-entry-component-types.ts#L75)Configuration for registering a custom HistoryEntryComponent.

[HistoryEntryComponent](/reference/admin-ui-api/custom-history-entry-components/history-entry-component#historyentrycomponent)
```
interface HistoryEntryConfig {    type: string;    component: Type<HistoryEntryComponent>;}
```

### type​


[​](#type)The type should correspond to the custom HistoryEntryType string.

### component​


[​](#component)[HistoryEntryComponent](/reference/admin-ui-api/custom-history-entry-components/history-entry-component#historyentrycomponent)The component to be rendered for this history entry type.


---

# OrderHistoryEntryComponent


## OrderHistoryEntryComponent​


[​](#orderhistoryentrycomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[history-entry-component-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/custom-history-entry-component/history-entry-component-types.ts#L53)Used to implement a HistoryEntryComponent which requires access to the Order object.

[HistoryEntryComponent](/reference/admin-ui-api/custom-history-entry-components/history-entry-component#historyentrycomponent)
```
interface OrderHistoryEntryComponent extends HistoryEntryComponent {    order: OrderDetailFragment;}
```

- Extends: HistoryEntryComponent

[HistoryEntryComponent](/reference/admin-ui-api/custom-history-entry-components/history-entry-component#historyentrycomponent)
### order​


[​](#order)


---

# RegisterHistoryEntryComponent


## registerHistoryEntryComponent​


[​](#registerhistoryentrycomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[register-history-entry-component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/extension/register-history-entry-component.ts#L68)Registers a HistoryEntryComponent for displaying history entries in the Order/Customer
history timeline.

[HistoryEntryComponent](/reference/admin-ui-api/custom-history-entry-components/history-entry-component#historyentrycomponent)Example

```
import { Component } from '@angular/core';import {    CustomerFragment,    CustomerHistoryEntryComponent,    registerHistoryEntryComponent,    SharedModule,    TimelineDisplayType,    TimelineHistoryEntry,} from '@vendure/admin-ui/core';@Component({    selector: 'tax-id-verification-component',    template: `        <div *ngIf="entry.data.valid">          Tax ID <strong>{{ entry.data.taxId }}</strong> was verified          <vdr-history-entry-detail *ngIf="entry.data">            <vdr-object-tree [value]="entry.data"></vdr-object-tree>          </vdr-history-entry-detail>        </div>        <div *ngIf="entry.data.valid">Tax ID {{ entry.data.taxId }} could not be verified</div>    `,    standalone: true,    imports: [SharedModule],})class TaxIdHistoryEntryComponent implements CustomerHistoryEntryComponent {    entry: TimelineHistoryEntry;    customer: CustomerFragment;    getDisplayType(entry: TimelineHistoryEntry): TimelineDisplayType {        return entry.data.valid ? 'success' : 'error';    }    getName(entry: TimelineHistoryEntry): string {        return 'Tax ID Verification Plugin';    }    isFeatured(entry: TimelineHistoryEntry): boolean {        return true;    }    getIconShape(entry: TimelineHistoryEntry) {        return entry.data.valid ? 'check-circle' : 'exclamation-circle';    }}export default [    registerHistoryEntryComponent({        type: 'CUSTOMER_TAX_ID_VERIFICATION',        component: TaxIdHistoryEntryComponent,    }),];
```

```
function registerHistoryEntryComponent(config: HistoryEntryConfig): void
```

Parameters

### config​


[​](#config)[HistoryEntryConfig](/reference/admin-ui-api/custom-history-entry-components/history-entry-config#historyentryconfig)


---

# Default Inputs


## BooleanFormInputComponent​


[​](#booleanforminputcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[boolean-form-input.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/dynamic-form-inputs/boolean-form-input/boolean-form-input.component.ts#L14)A checkbox input. The default input component for boolean fields.

```
class BooleanFormInputComponent implements FormInputComponent {    static readonly id: DefaultFormComponentId = 'boolean-form-input';    readonly: boolean;    formControl: UntypedFormControl;    config: DefaultFormComponentConfig<'boolean-form-input'>;}
```

- Implements: FormInputComponent

[FormInputComponent](/reference/admin-ui-api/custom-input-components/form-input-component#forminputcomponent)
### id​


[​](#id)[DefaultFormComponentId](/reference/typescript-api/configurable-operation-def/default-form-component-id#defaultformcomponentid)
### readonly​


[​](#readonly)
### formControl​


[​](#formcontrol)
### config​


[​](#config)
## HtmlEditorFormInputComponent​


[​](#htmleditorforminputcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[html-editor-form-input.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/dynamic-form-inputs/code-editor-form-input/html-editor-form-input.component.ts#L23)A JSON editor input with syntax highlighting and error detection. Works well
with text type fields.

```
class HtmlEditorFormInputComponent extends BaseCodeEditorFormInputComponent implements FormInputComponent, AfterViewInit, OnInit {    static readonly id: DefaultFormComponentId = 'html-editor-form-input';    constructor(changeDetector: ChangeDetectorRef)    ngOnInit() => ;}
```

- Extends: BaseCodeEditorFormInputComponent
- Implements: FormInputComponent, AfterViewInit, OnInit

Extends: BaseCodeEditorFormInputComponent

Implements: FormInputComponent, AfterViewInit, OnInit

[FormInputComponent](/reference/admin-ui-api/custom-input-components/form-input-component#forminputcomponent)
### id​


[​](#id-1)[DefaultFormComponentId](/reference/typescript-api/configurable-operation-def/default-form-component-id#defaultformcomponentid)
### constructor​


[​](#constructor)
### ngOnInit​


[​](#ngoninit)
## JsonEditorFormInputComponent​


[​](#jsoneditorforminputcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[json-editor-form-input.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/dynamic-form-inputs/code-editor-form-input/json-editor-form-input.component.ts#L33)A JSON editor input with syntax highlighting and error detection. Works well
with text type fields.

```
class JsonEditorFormInputComponent extends BaseCodeEditorFormInputComponent implements FormInputComponent, AfterViewInit, OnInit {    static readonly id: DefaultFormComponentId = 'json-editor-form-input';    constructor(changeDetector: ChangeDetectorRef)    ngOnInit() => ;}
```

- Extends: BaseCodeEditorFormInputComponent
- Implements: FormInputComponent, AfterViewInit, OnInit

Extends: BaseCodeEditorFormInputComponent

Implements: FormInputComponent, AfterViewInit, OnInit

[FormInputComponent](/reference/admin-ui-api/custom-input-components/form-input-component#forminputcomponent)
### id​


[​](#id-2)[DefaultFormComponentId](/reference/typescript-api/configurable-operation-def/default-form-component-id#defaultformcomponentid)
### constructor​


[​](#constructor-1)
### ngOnInit​


[​](#ngoninit-1)
## CombinationModeFormInputComponent​


[​](#combinationmodeforminputcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[combination-mode-form-input.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/dynamic-form-inputs/combination-mode-form-input/combination-mode-form-input.component.ts#L17)A special input used to display the "Combination mode" AND/OR toggle.

```
class CombinationModeFormInputComponent implements FormInputComponent, OnInit {    static readonly id: DefaultFormComponentId = 'combination-mode-form-input';    readonly: boolean;    formControl: UntypedFormControl;    config: DefaultFormComponentConfig<'combination-mode-form-input'>;    selectable$: Observable<boolean>;    constructor(configurableInputComponent: ConfigurableInputComponent)    ngOnInit() => ;    setCombinationModeAnd() => ;    setCombinationModeOr() => ;}
```

- Implements: FormInputComponent, OnInit

[FormInputComponent](/reference/admin-ui-api/custom-input-components/form-input-component#forminputcomponent)
### id​


[​](#id-3)[DefaultFormComponentId](/reference/typescript-api/configurable-operation-def/default-form-component-id#defaultformcomponentid)
### readonly​


[​](#readonly-1)
### formControl​


[​](#formcontrol-1)
### config​


[​](#config-1)
### selectable$​


[​](#selectable)
### constructor​


[​](#constructor-2)
### ngOnInit​


[​](#ngoninit-2)
### setCombinationModeAnd​


[​](#setcombinationmodeand)
### setCombinationModeOr​


[​](#setcombinationmodeor)
## CurrencyFormInputComponent​


[​](#currencyforminputcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[currency-form-input.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/dynamic-form-inputs/currency-form-input/currency-form-input.component.ts#L17)An input for monetary values. Should be used with int type fields.

```
class CurrencyFormInputComponent implements FormInputComponent {    static readonly id: DefaultFormComponentId = 'currency-form-input';    @Input() readonly: boolean;    formControl: UntypedFormControl;    currencyCode$: Observable<CurrencyCode>;    config: DefaultFormComponentConfig<'currency-form-input'>;    constructor(dataService: DataService)}
```

- Implements: FormInputComponent

[FormInputComponent](/reference/admin-ui-api/custom-input-components/form-input-component#forminputcomponent)
### id​


[​](#id-4)[DefaultFormComponentId](/reference/typescript-api/configurable-operation-def/default-form-component-id#defaultformcomponentid)
### readonly​


[​](#readonly-2)
### formControl​


[​](#formcontrol-2)
### currencyCode$​


[​](#currencycode)[CurrencyCode](/reference/typescript-api/common/currency-code#currencycode)
### config​


[​](#config-2)
### constructor​


[​](#constructor-3)[DataService](/reference/admin-ui-api/services/data-service#dataservice)
## CustomerGroupFormInputComponent​


[​](#customergroupforminputcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[customer-group-form-input.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/dynamic-form-inputs/customer-group-form-input/customer-group-form-input.component.ts#L20)Allows the selection of a Customer via an autocomplete select input.
Should be used with ID type fields which represent Customer IDs.

```
class CustomerGroupFormInputComponent implements FormInputComponent, OnInit {    static readonly id: DefaultFormComponentId = 'customer-group-form-input';    @Input() readonly: boolean;    formControl: FormControl<string | { id: string }>;    customerGroups$: Observable<GetCustomerGroupsQuery['customerGroups']['items']>;    config: DefaultFormComponentConfig<'customer-group-form-input'>;    constructor(dataService: DataService)    ngOnInit() => ;    selectGroup(group: ItemOf<GetCustomerGroupsQuery, 'customerGroups'>) => ;    compareWith(o1: T, o2: T) => ;}
```

- Implements: FormInputComponent, OnInit

[FormInputComponent](/reference/admin-ui-api/custom-input-components/form-input-component#forminputcomponent)
### id​


[​](#id-5)[DefaultFormComponentId](/reference/typescript-api/configurable-operation-def/default-form-component-id#defaultformcomponentid)
### readonly​


[​](#readonly-3)
### formControl​


[​](#formcontrol-3)
### customerGroups$​


[​](#customergroups)
### config​


[​](#config-3)
### constructor​


[​](#constructor-4)[DataService](/reference/admin-ui-api/services/data-service#dataservice)
### ngOnInit​


[​](#ngoninit-3)
### selectGroup​


[​](#selectgroup)
### compareWith​


[​](#comparewith)
## DateFormInputComponent​


[​](#dateforminputcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[date-form-input.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/dynamic-form-inputs/date-form-input/date-form-input.component.ts#L14)Allows selection of a datetime. Default input for datetime type fields.

```
class DateFormInputComponent implements FormInputComponent {    static readonly id: DefaultFormComponentId = 'date-form-input';    @Input() readonly: boolean;    formControl: UntypedFormControl;    config: DefaultFormComponentConfig<'date-form-input'>;    min: void    max: void    yearRange: void}
```

- Implements: FormInputComponent

[FormInputComponent](/reference/admin-ui-api/custom-input-components/form-input-component#forminputcomponent)
### id​


[​](#id-6)[DefaultFormComponentId](/reference/typescript-api/configurable-operation-def/default-form-component-id#defaultformcomponentid)
### readonly​


[​](#readonly-4)
### formControl​


[​](#formcontrol-4)
### config​


[​](#config-4)
### min​


[​](#min)
### max​


[​](#max)
### yearRange​


[​](#yearrange)
## FacetValueFormInputComponent​


[​](#facetvalueforminputcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[facet-value-form-input.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/dynamic-form-inputs/facet-value-form-input/facet-value-form-input.component.ts#L16)Allows the selection of multiple FacetValues via an autocomplete select input.
Should be used with ID type list fields which represent FacetValue IDs.

```
class FacetValueFormInputComponent implements FormInputComponent {    static readonly id: DefaultFormComponentId = 'facet-value-form-input';    readonly isListInput = true;    readonly: boolean;    formControl: UntypedFormControl;    config: InputComponentConfig;    valueTransformFn = (values: FacetValueFragment[]) => {        const isUsedInConfigArg = this.config.__typename === 'ConfigArgDefinition';        if (isUsedInConfigArg) {            return JSON.stringify(values.map(s => s.id));        } else {            return values;        }    };}
```

- Implements: FormInputComponent

[FormInputComponent](/reference/admin-ui-api/custom-input-components/form-input-component#forminputcomponent)
### id​


[​](#id-7)[DefaultFormComponentId](/reference/typescript-api/configurable-operation-def/default-form-component-id#defaultformcomponentid)
### isListInput​


[​](#islistinput)
### readonly​


[​](#readonly-5)
### formControl​


[​](#formcontrol-5)
### config​


[​](#config-5)
### valueTransformFn​


[​](#valuetransformfn)
## NumberFormInputComponent​


[​](#numberforminputcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[number-form-input.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/dynamic-form-inputs/number-form-input/number-form-input.component.ts#L14)Displays a number input. Default input for int and float type fields.

```
class NumberFormInputComponent implements FormInputComponent {    static readonly id: DefaultFormComponentId = 'number-form-input';    @Input() readonly: boolean;    formControl: UntypedFormControl;    config: DefaultFormComponentConfig<'number-form-input'>;    prefix: void    suffix: void    min: void    max: void    step: void}
```

- Implements: FormInputComponent

[FormInputComponent](/reference/admin-ui-api/custom-input-components/form-input-component#forminputcomponent)
### id​


[​](#id-8)[DefaultFormComponentId](/reference/typescript-api/configurable-operation-def/default-form-component-id#defaultformcomponentid)
### readonly​


[​](#readonly-6)
### formControl​


[​](#formcontrol-6)
### config​


[​](#config-6)
### prefix​


[​](#prefix)
### suffix​


[​](#suffix)
### min​


[​](#min-1)
### max​


[​](#max-1)
### step​


[​](#step)
## PasswordFormInputComponent​


[​](#passwordforminputcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[password-form-input.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/dynamic-form-inputs/password-form-input/password-form-input.component.ts#L14)Displays a password text input. Should be used with string type fields.

```
class PasswordFormInputComponent implements FormInputComponent {    static readonly id: DefaultFormComponentId = 'password-form-input';    readonly: boolean;    formControl: UntypedFormControl;    config: InputComponentConfig;}
```

- Implements: FormInputComponent

[FormInputComponent](/reference/admin-ui-api/custom-input-components/form-input-component#forminputcomponent)
### id​


[​](#id-9)[DefaultFormComponentId](/reference/typescript-api/configurable-operation-def/default-form-component-id#defaultformcomponentid)
### readonly​


[​](#readonly-7)
### formControl​


[​](#formcontrol-7)
### config​


[​](#config-7)
## ProductSelectorFormInputComponent​


[​](#productselectorforminputcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[product-selector-form-input.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/dynamic-form-inputs/product-selector-form-input/product-selector-form-input.component.ts#L20)Allows the selection of multiple ProductVariants via an autocomplete select input.
Should be used with ID type list fields which represent ProductVariant IDs.

```
class ProductSelectorFormInputComponent implements FormInputComponent, OnInit {    static readonly id: DefaultFormComponentId = 'product-selector-form-input';    readonly isListInput = true;    readonly: boolean;    formControl: FormControl<Array<string | { id: string }>>;    config: DefaultFormComponentUiConfig<'product-selector-form-input'>;    selection$: Observable<Array<GetProductVariantQuery['productVariant']>>;    constructor(dataService: DataService)    ngOnInit() => ;    addProductVariant(product: ProductSelectorSearchQuery['search']['items'][number]) => ;    removeProductVariant(id: string) => ;}
```

- Implements: FormInputComponent, OnInit

[FormInputComponent](/reference/admin-ui-api/custom-input-components/form-input-component#forminputcomponent)
### id​


[​](#id-10)[DefaultFormComponentId](/reference/typescript-api/configurable-operation-def/default-form-component-id#defaultformcomponentid)
### isListInput​


[​](#islistinput-1)
### readonly​


[​](#readonly-8)
### formControl​


[​](#formcontrol-8)
### config​


[​](#config-8)
### selection$​


[​](#selection)
### constructor​


[​](#constructor-5)[DataService](/reference/admin-ui-api/services/data-service#dataservice)
### ngOnInit​


[​](#ngoninit-4)
### addProductVariant​


[​](#addproductvariant)
### removeProductVariant​


[​](#removeproductvariant)
## RelationFormInputComponent​


[​](#relationforminputcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[relation-form-input.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/dynamic-form-inputs/relation-form-input/relation-form-input.component.ts#L17)The default input component for relation type custom fields. Allows the selection
of a ProductVariant, Product, Customer or Asset. For other entity types, a custom
implementation will need to be defined. See registerFormInputComponent.

[registerFormInputComponent](/reference/admin-ui-api/custom-input-components/register-form-input-component#registerforminputcomponent)
```
class RelationFormInputComponent implements FormInputComponent {    static readonly id: DefaultFormComponentId = 'relation-form-input';    @Input() readonly: boolean;    formControl: UntypedFormControl;    config: RelationCustomFieldConfig;}
```

- Implements: FormInputComponent

[FormInputComponent](/reference/admin-ui-api/custom-input-components/form-input-component#forminputcomponent)
### id​


[​](#id-11)[DefaultFormComponentId](/reference/typescript-api/configurable-operation-def/default-form-component-id#defaultformcomponentid)
### readonly​


[​](#readonly-9)
### formControl​


[​](#formcontrol-9)
### config​


[​](#config-9)
## RichTextFormInputComponent​


[​](#richtextforminputcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[rich-text-form-input.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/dynamic-form-inputs/rich-text-form-input/rich-text-form-input.component.ts#L14)Uses the RichTextEditorComponent as in input for text type fields.

[RichTextEditorComponent](/reference/admin-ui-api/components/rich-text-editor-component#richtexteditorcomponent)
```
class RichTextFormInputComponent implements FormInputComponent {    static readonly id: DefaultFormComponentId = 'rich-text-form-input';    readonly: boolean;    formControl: UntypedFormControl;    config: DefaultFormComponentConfig<'rich-text-form-input'>;}
```

- Implements: FormInputComponent

[FormInputComponent](/reference/admin-ui-api/custom-input-components/form-input-component#forminputcomponent)
### id​


[​](#id-12)[DefaultFormComponentId](/reference/typescript-api/configurable-operation-def/default-form-component-id#defaultformcomponentid)
### readonly​


[​](#readonly-10)
### formControl​


[​](#formcontrol-10)
### config​


[​](#config-10)
## SelectFormInputComponent​


[​](#selectforminputcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[select-form-input.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/dynamic-form-inputs/select-form-input/select-form-input.component.ts#L18)Uses a select input to allow the selection of a string value. Should be used with
string type fields with options.

```
class SelectFormInputComponent implements FormInputComponent, OnInit {    static readonly id: DefaultFormComponentId = 'select-form-input';    @Input() readonly: boolean;    formControl: UntypedFormControl;    config: DefaultFormComponentConfig<'select-form-input'> & CustomFieldConfigFragment;    uiLanguage$: Observable<LanguageCode>;    options: void    constructor(dataService: DataService)    ngOnInit() => ;    trackByFn(index: number, item: any) => ;}
```

- Implements: FormInputComponent, OnInit

[FormInputComponent](/reference/admin-ui-api/custom-input-components/form-input-component#forminputcomponent)
### id​


[​](#id-13)[DefaultFormComponentId](/reference/typescript-api/configurable-operation-def/default-form-component-id#defaultformcomponentid)
### readonly​


[​](#readonly-11)
### formControl​


[​](#formcontrol-11)
### config​


[​](#config-11)
### uiLanguage$​


[​](#uilanguage)[LanguageCode](/reference/typescript-api/common/language-code#languagecode)
### options​


[​](#options)
### constructor​


[​](#constructor-6)[DataService](/reference/admin-ui-api/services/data-service#dataservice)
### ngOnInit​


[​](#ngoninit-5)
### trackByFn​


[​](#trackbyfn)
## StructFormInputComponent​


[​](#structforminputcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[struct-form-input.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/dynamic-form-inputs/struct-form-input/struct-form-input.component.ts#L18)A checkbox input. The default input component for boolean fields.

```
class StructFormInputComponent implements FormInputComponent, OnInit, OnDestroy {    static readonly id: DefaultFormComponentId = 'struct-form-input';    readonly: boolean;    formControl: UntypedFormControl;    config: DefaultFormComponentConfig<'struct-form-input'>;    uiLanguage$: Observable<LanguageCode>;    protected structFormGroup = new FormGroup({});    protected fields: Array<{        def: StructCustomFieldFragment['fields'][number];        formControl: FormControl;    }>;    constructor(dataService: DataService)    ngOnInit() => ;    ngOnDestroy() => ;}
```

- Implements: FormInputComponent, OnInit, OnDestroy

[FormInputComponent](/reference/admin-ui-api/custom-input-components/form-input-component#forminputcomponent)
### id​


[​](#id-14)[DefaultFormComponentId](/reference/typescript-api/configurable-operation-def/default-form-component-id#defaultformcomponentid)
### readonly​


[​](#readonly-12)
### formControl​


[​](#formcontrol-12)
### config​


[​](#config-12)
### uiLanguage$​


[​](#uilanguage-1)[LanguageCode](/reference/typescript-api/common/language-code#languagecode)
### structFormGroup​


[​](#structformgroup)
### fields​


[​](#fields)
### constructor​


[​](#constructor-7)[DataService](/reference/admin-ui-api/services/data-service#dataservice)
### ngOnInit​


[​](#ngoninit-6)
### ngOnDestroy​


[​](#ngondestroy)
## TextFormInputComponent​


[​](#textforminputcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[text-form-input.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/dynamic-form-inputs/text-form-input/text-form-input.component.ts#L14)Uses a regular text form input. This is the default input for string and localeString type fields.

```
class TextFormInputComponent implements FormInputComponent {    static readonly id: DefaultFormComponentId = 'text-form-input';    readonly: boolean;    formControl: UntypedFormControl;    config: DefaultFormComponentConfig<'text-form-input'>;    prefix: void    suffix: void}
```

- Implements: FormInputComponent

[FormInputComponent](/reference/admin-ui-api/custom-input-components/form-input-component#forminputcomponent)
### id​


[​](#id-15)[DefaultFormComponentId](/reference/typescript-api/configurable-operation-def/default-form-component-id#defaultformcomponentid)
### readonly​


[​](#readonly-13)
### formControl​


[​](#formcontrol-13)
### config​


[​](#config-13)
### prefix​


[​](#prefix-1)
### suffix​


[​](#suffix-1)
## TextareaFormInputComponent​


[​](#textareaforminputcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[textarea-form-input.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/dynamic-form-inputs/textarea-form-input/textarea-form-input.component.ts#L14)Uses textarea form input. This is the default input for text type fields.

```
class TextareaFormInputComponent implements FormInputComponent {    static readonly id: DefaultFormComponentId = 'textarea-form-input';    readonly: boolean;    formControl: UntypedFormControl;    config: DefaultFormComponentConfig<'textarea-form-input'>;    spellcheck: boolean}
```

- Implements: FormInputComponent

[FormInputComponent](/reference/admin-ui-api/custom-input-components/form-input-component#forminputcomponent)
### id​


[​](#id-16)[DefaultFormComponentId](/reference/typescript-api/configurable-operation-def/default-form-component-id#defaultformcomponentid)
### readonly​


[​](#readonly-14)
### formControl​


[​](#formcontrol-14)
### config​


[​](#config-14)
### spellcheck​


[​](#spellcheck)



---

# FormInputComponent


## FormInputComponent​


[​](#forminputcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[component-registry-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/common/component-registry-types.ts#L11)This interface should be implemented by any component being used as a custom input. For example,
inputs for custom fields, or for configurable arguments.

```
interface FormInputComponent<C = InputComponentConfig> {    isListInput?: boolean;    readonly: boolean;    formControl: FormControl;    config: C;}
```

### isListInput​


[​](#islistinput)Should be set to true if this component is designed to handle lists.
If true then the formControl value will be an array of all the
values in the list.

### readonly​


[​](#readonly)This is set by the Admin UI when consuming this component, indicating that the
component should be rendered in a read-only state.

### formControl​


[​](#formcontrol)This controls the actual value of the form item. The current value is available
as this.formControl.value, and an Observable stream of value changes is available
as this.formControl.valueChanges. To update the value, use .setValue(val) and then
.markAsDirty().

Full documentation can be found in the Angular docs.

[Angular docs](https://angular.io/api/forms/FormControl)
### config​


[​](#config)The config property contains the full configuration object of the custom field or configurable argument.


---

# RegisterFormInputComponent


## registerFormInputComponent​


[​](#registerforminputcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[register-form-input-component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/extension/register-form-input-component.ts#L53)Registers a custom FormInputComponent which can be used to control the argument inputs
of a ConfigurableOperationDef (e.g. CollectionFilter, ShippingMethod etc.) or for
a custom field.

[ConfigurableOperationDef](/reference/typescript-api/configurable-operation-def/#configurableoperationdef)Example

```
import { registerFormInputComponent } from '@vendure/admin-ui/core';export default [    registerFormInputComponent('my-custom-input', MyCustomFieldControl),];
```

This input component can then be used in a custom field:

Example

```
import { VendureConfig } from '@vendure/core';const config: VendureConfig = {  // ...  customFields: {    ProductVariant: [      {        name: 'rrp',        type: 'int',        ui: { component: 'my-custom-input' },      },    ]  }}
```

or with an argument of a ConfigurableOperationDef:

[ConfigurableOperationDef](/reference/typescript-api/configurable-operation-def/#configurableoperationdef)Example

```
args: {  rrp: { type: 'int', ui: { component: 'my-custom-input' } },}
```

```
function registerFormInputComponent(id: string, component: Type<FormInputComponent>): void
```

Parameters

### id​


[​](#id)
### component​


[​](#component)[FormInputComponent](/reference/admin-ui-api/custom-input-components/form-input-component#forminputcomponent)


---

# CustomColumnComponent


## CustomColumnComponent​


[​](#customcolumncomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[data-table-custom-component.service.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/components/data-table-2/data-table-custom-component.service.ts#L44)Components which are to be used to render custom cells in a data table should implement this interface.

The rowItem property is the data object for the row, e.g. the Product object if used
in the product-list table.

```
interface CustomColumnComponent {    rowItem: any;}
```

### rowItem​


[​](#rowitem)


---

# DataTableComponentConfig


## DataTableComponentConfig​


[​](#datatablecomponentconfig)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[data-table-custom-component.service.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/components/data-table-2/data-table-custom-component.service.ts#L54)Configures a CustomDetailComponent to be placed in the given location.

[CustomDetailComponent](/reference/admin-ui-api/custom-detail-components/custom-detail-component#customdetailcomponent)
```
interface DataTableComponentConfig {    tableId: DataTableLocationId;    columnId: DataTableColumnId;    component: Type<CustomColumnComponent>;    providers?: Provider[];}
```

### tableId​


[​](#tableid)The location in the UI where the custom component should be placed.

### columnId​


[​](#columnid)The column in the table where the custom component should be placed.

### component​


[​](#component)[CustomColumnComponent](/reference/admin-ui-api/custom-table-components/custom-column-component#customcolumncomponent)The component to render in the table cell. This component should implement the
CustomColumnComponent interface.

[CustomColumnComponent](/reference/admin-ui-api/custom-table-components/custom-column-component#customcolumncomponent)
### providers​


[​](#providers)


---

# RegisterDataTableComponent


## registerDataTableComponent​


[​](#registerdatatablecomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[register-data-table-component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/extension/register-data-table-component.ts#L45)Allows you to override the default component used to render the data of a particular column in a DataTable.
The component should implement the CustomColumnComponent interface. The tableId and columnId can
be determined by pressing ctrl + u when running the Admin UI in dev mode.

[CustomColumnComponent](/reference/admin-ui-api/custom-table-components/custom-column-component#customcolumncomponent)Example

```
import { Component, Input } from '@angular/core';import { CustomColumnComponent } from '@vendure/admin-ui/core';@Component({    selector: 'custom-slug-component',    template: `        <a [href]="'https://example.com/products/' + rowItem.slug" target="_blank">{{ rowItem.slug }}</a>    `,    standalone: true,})export class CustomTableComponent implements CustomColumnComponent {    @Input() rowItem: any;}
```

```
import { registerDataTableComponent } from '@vendure/admin-ui/core';import { CustomTableComponent } from './components/custom-table.component';export default [    registerDataTableComponent({        component: CustomTableComponent,        tableId: 'product-list',        columnId: 'slug',    }),];
```

```
function registerDataTableComponent(config: DataTableComponentConfig): void
```

Parameters

### config​


[​](#config)[DataTableComponentConfig](/reference/admin-ui-api/custom-table-components/data-table-component-config#datatablecomponentconfig)


---

# DashboardWidgetConfig


## DashboardWidgetConfig​


[​](#dashboardwidgetconfig)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[dashboard-widget-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/dashboard-widget/dashboard-widget-types.ts#L11)A configuration object for a dashboard widget.

```
interface DashboardWidgetConfig {    loadComponent: () => Promise<Type<any>> | Type<any>;    title?: string;    supportedWidths?: DashboardWidgetWidth[];    requiresPermissions?: string[];}
```

### loadComponent​


[​](#loadcomponent)Used to specify the widget component. Supports both eager- and lazy-loading.

Example

```
// eager-loadingloadComponent: () => MyWidgetComponent,// lazy-loadingloadComponent: () => import('./path-to/widget.component').then(m => m.MyWidgetComponent),
```

### title​


[​](#title)The title of the widget. Can be a translation token as it will get passed
through the translate pipe.

### supportedWidths​


[​](#supportedwidths)The supported widths of the widget, in terms of a Bootstrap-style 12-column grid.
If omitted, then it is assumed the widget supports all widths.

### requiresPermissions​


[​](#requirespermissions)If set, the widget will only be displayed if the current user has all the
specified permissions.


---

# RegisterDashboardWidget


## registerDashboardWidget​


[​](#registerdashboardwidget)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[register-dashboard-widget.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/extension/register-dashboard-widget.ts#L16)Registers a dashboard widget. Once registered, the widget can be set as part of the default
(using setDashboardWidgetLayout).

[setDashboardWidgetLayout](/reference/admin-ui-api/dashboard-widgets/set-dashboard-widget-layout#setdashboardwidgetlayout)
```
function registerDashboardWidget(id: string, config: DashboardWidgetConfig): void
```

Parameters

### id​


[​](#id)
### config​


[​](#config)[DashboardWidgetConfig](/reference/admin-ui-api/dashboard-widgets/dashboard-widget-config#dashboardwidgetconfig)


---

# SetDashboardWidgetLayout


## setDashboardWidgetLayout​


[​](#setdashboardwidgetlayout)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[register-dashboard-widget.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/extension/register-dashboard-widget.ts#L31)Sets the default widget layout for the Admin UI dashboard.

```
function setDashboardWidgetLayout(layoutDef: WidgetLayoutDefinition): void
```

Parameters

### layoutDef​


[​](#layoutdef)[WidgetLayoutDefinition](/reference/admin-ui-api/dashboard-widgets/widget-layout-definition#widgetlayoutdefinition)


---

# WidgetLayoutDefinition


## WidgetLayoutDefinition​


[​](#widgetlayoutdefinition)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[dashboard-widget-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/dashboard-widget/dashboard-widget-types.ts#L51)A configuration object for the default dashboard widget layout.

```
type WidgetLayoutDefinition = Array<{ id: string; width: DashboardWidgetWidth }>
```


---

# IfMultichannelDirective


## IfMultichannelDirective​


[​](#ifmultichanneldirective)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[if-multichannel.directive.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/directives/if-multichannel.directive.ts#L21)Structural directive that displays the given element if the Vendure instance has multiple channels
configured.

Example

```
<div *vdrIfMultichannel class="channel-selector">  <!-- ... --></ng-container>
```

```
class IfMultichannelDirective extends IfDirectiveBase<[]> {    constructor(_viewContainer: ViewContainerRef, templateRef: TemplateRef<any>, dataService: DataService)}
```

- Extends: IfDirectiveBase<[]>

### constructor​


[​](#constructor)[DataService](/reference/admin-ui-api/services/data-service#dataservice)


---

# IfPermissionsDirective


## IfPermissionsDirective​


[​](#ifpermissionsdirective)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[if-permissions.directive.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/directives/if-permissions.directive.ts#L26)Conditionally shows/hides templates based on the current active user having the specified permission.
Based on the ngIf source. Also support "else" templates:

Example

```
<button *vdrIfPermissions="'DeleteCatalog'; else unauthorized">Delete Product</button><ng-template #unauthorized>Not allowed!</ng-template>
```

The permission can be a single string, or an array. If an array is passed, then all of the permissions
must match (logical AND)

```
class IfPermissionsDirective extends IfDirectiveBase<Array<Permission[] | null>> {    constructor(_viewContainer: ViewContainerRef, templateRef: TemplateRef<any>, changeDetectorRef: ChangeDetectorRef, permissionsService: PermissionsService)}
```

- Extends: IfDirectiveBase<Array<Permission[] | null>>

[Permission](/reference/typescript-api/common/permission#permission)
### constructor​


[​](#constructor)


---

# Vendure Admin UI API Docs


These APIs are used when building your own custom extensions to the Admin UI provided by the AdminUiPlugin.

All documentation in this section is auto-generated from the TypeScript & HTML source of the Vendure Admin UI package.


---

# BaseDetailComponent


## BaseDetailComponent​


[​](#basedetailcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[base-detail.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/common/base-detail.component.ts#L57)A base class for entity detail views. It should be used in conjunction with the
BaseEntityResolver.

[BaseEntityResolver](/reference/admin-ui-api/list-detail-views/base-entity-resolver#baseentityresolver)Example

```
@Component({  selector: 'app-my-entity',  templateUrl: './my-entity.component.html',  styleUrls: ['./my-entity.component.scss'],  changeDetection: ChangeDetectionStrategy.OnPush,})export class GlobalSettingsComponent extends BaseDetailComponent<MyEntityFragment> implements OnInit {  detailForm: FormGroup;  constructor(    router: Router,    route: ActivatedRoute,    serverConfigService: ServerConfigService,    protected dataService: DataService,    private formBuilder: FormBuilder,  ) {    super(route, router, serverConfigService, dataService);    this.detailForm = this.formBuilder.group({      name: [''],    });  }  protected setFormValues(entity: MyEntityFragment, languageCode: LanguageCode): void {    this.detailForm.patchValue({      name: entity.name,    });  }}
```

```
class BaseDetailComponent<Entity extends { id: string; updatedAt?: string }> implements DeactivateAware {    entity$: Observable<Entity>;    availableLanguages$: Observable<LanguageCode[]>;    languageCode$: Observable<LanguageCode>;    languageCode: LanguageCode;    isNew$: Observable<boolean>;    id: string;    abstract detailForm: UntypedFormGroup;    protected destroy$ = new Subject<void>();    constructor(route: ActivatedRoute, router: Router, serverConfigService: ServerConfigService, dataService: DataService, permissionsService: PermissionsService)    init() => ;    setUpStreams() => ;    destroy() => ;    setLanguage(code: LanguageCode) => ;    canDeactivate() => boolean;    setFormValues(entity: Entity, languageCode: LanguageCode) => void;    setCustomFieldFormValues(customFields: CustomFieldConfig[], formGroup: AbstractControl | null, entity: T, currentTranslation?: TranslationOf<T>) => ;    getCustomFieldConfig(key: Exclude<keyof CustomFields, '__typename'>) => CustomFieldConfig[];    setQueryParam(key: string, value: any) => ;}
```

- Implements: DeactivateAware

### entity$​


[​](#entity)
### availableLanguages$​


[​](#availablelanguages)[LanguageCode](/reference/typescript-api/common/language-code#languagecode)
### languageCode$​


[​](#languagecode)[LanguageCode](/reference/typescript-api/common/language-code#languagecode)
### languageCode​


[​](#languagecode-1)[LanguageCode](/reference/typescript-api/common/language-code#languagecode)
### isNew$​


[​](#isnew)
### id​


[​](#id)
### detailForm​


[​](#detailform)
### destroy$​


[​](#destroy)
### constructor​


[​](#constructor)[DataService](/reference/admin-ui-api/services/data-service#dataservice)
### init​


[​](#init)
### setUpStreams​


[​](#setupstreams)
### destroy​


[​](#destroy-1)
### setLanguage​


[​](#setlanguage)[LanguageCode](/reference/typescript-api/common/language-code#languagecode)
### canDeactivate​


[​](#candeactivate)
### setFormValues​


[​](#setformvalues)[LanguageCode](/reference/typescript-api/common/language-code#languagecode)
### setCustomFieldFormValues​


[​](#setcustomfieldformvalues)[CustomFieldConfig](/reference/typescript-api/custom-fields/custom-field-config#customfieldconfig)
### getCustomFieldConfig​


[​](#getcustomfieldconfig)[CustomFields](/reference/typescript-api/custom-fields/#customfields)[CustomFieldConfig](/reference/typescript-api/custom-fields/custom-field-config#customfieldconfig)
### setQueryParam​


[​](#setqueryparam)


---

# BaseEntityResolver


## BaseEntityResolver​


[​](#baseentityresolver)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[base-entity-resolver.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/common/base-entity-resolver.ts#L55)A base resolver for an entity detail route. Resolves to an observable of the given entity, or a "blank"
version if the route id equals "create". Should be used together with details views which extend the
BaseDetailComponent.

[BaseDetailComponent](/reference/admin-ui-api/list-detail-views/base-detail-component#basedetailcomponent)Example

```
@Injectable({  providedIn: 'root',})export class MyEntityResolver extends BaseEntityResolver<MyEntityFragment> {  constructor(router: Router, dataService: DataService) {    super(      router,      {        __typename: 'MyEntity',        id: '',        createdAt: '',        updatedAt: '',        name: '',      },      id => dataService.query(GET_MY_ENTITY, { id }).mapStream(data => data.myEntity),    );  }}
```

```
class BaseEntityResolver<T> {    constructor(router: Router, emptyEntity: T, entityStream: (id: string) => Observable<T | null | undefined>)}
```

### constructor​


[​](#constructor)


---

# BaseListComponent


## BaseListComponent​


[​](#baselistcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[base-list.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/common/base-list.component.ts#L43)This is a base class which implements the logic required to fetch and manipulate
a list of data from a query which returns a PaginatedList type.

It is normally used in combination with the DataTable2Component.

[DataTable2Component](/reference/admin-ui-api/components/data-table2component#datatable2component)
```
class BaseListComponent<ResultType, ItemType, VariableType extends Record<string, any> = any> implements OnInit, OnDestroy {    searchTermControl = new FormControl('');    selectionManager = new SelectionManager<any>({        multiSelect: true,        itemsAreEqual: (a, b) => a.id === b.id,        additiveMode: true,    });    result$: Observable<ResultType>;    items$: Observable<ItemType[]>;    totalItems$: Observable<number>;    itemsPerPage$: Observable<number>;    currentPage$: Observable<number>;    protected destroy$ = new Subject<void>();    protected refresh$ = new BehaviorSubject<undefined>(undefined);    protected visibleCustomFieldColumnChange$ = new Subject<        Array<DataTableCustomFieldColumnComponent<any>>    >();    constructor(router: Router, route: ActivatedRoute)    setQueryFn(listQueryFn: ListQueryFn<ResultType>, mappingFn: MappingFn<ItemType, ResultType>, onPageChangeFn?: OnPageChangeFn<VariableType>, defaults?: { take: number; skip: number }) => ;    refreshListOnChanges(streams: Array<Observable<any>>) => ;    setPageNumber(page: number) => ;    setItemsPerPage(perPage: number) => ;    setVisibleColumns(columns: Array<DataTable2ColumnComponent<any>>) => ;    refresh() => ;    setQueryParam(hash: { [key: string]: any }, options?: { replaceUrl?: boolean; queryParamsHandling?: QueryParamsHandling }) => ;    setQueryParam(key: string, value: any, options?: { replaceUrl?: boolean; queryParamsHandling?: QueryParamsHandling }) => ;    setQueryParam(keyOrHash: string | { [key: string]: any }, valueOrOptions?: any, maybeOptions?: { replaceUrl?: boolean; queryParamsHandling?: QueryParamsHandling }) => ;}
```

- Implements: OnInit, OnDestroy

### searchTermControl​


[​](#searchtermcontrol)
### selectionManager​


[​](#selectionmanager)
### result$​


[​](#result)
### items$​


[​](#items)
### totalItems$​


[​](#totalitems)
### itemsPerPage$​


[​](#itemsperpage)
### currentPage$​


[​](#currentpage)
### destroy$​


[​](#destroy)
### refresh$​


[​](#refresh)
### visibleCustomFieldColumnChange$​


[​](#visiblecustomfieldcolumnchange)
### constructor​


[​](#constructor)
### setQueryFn​


[​](#setqueryfn)Sets the fetch function for the list being implemented.

### refreshListOnChanges​


[​](#refreshlistonchanges)Accepts a list of Observables which will trigger a refresh of the list when any of them emit.

### setPageNumber​


[​](#setpagenumber)Sets the current page number in the url.

### setItemsPerPage​


[​](#setitemsperpage)Sets the number of items per page in the url.

### setVisibleColumns​


[​](#setvisiblecolumns)
### refresh​


[​](#refresh-1)Re-fetch the current page of results.

### setQueryParam​


[​](#setqueryparam)
### setQueryParam​


[​](#setqueryparam-1)
### setQueryParam​


[​](#setqueryparam-2)


---

# DetailComponentWithResolver


## detailComponentWithResolver​


[​](#detailcomponentwithresolver)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[base-detail.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/common/base-detail.component.ts#L256)A helper function for creating tabs that point to a TypedBaseDetailComponent. This takes
care of the route resolver parts so that the detail component automatically has access to the
correct resolved detail data.

[TypedBaseDetailComponent](/reference/admin-ui-api/list-detail-views/typed-base-detail-component#typedbasedetailcomponent)Example

```
@NgModule({  imports: [ReviewsSharedModule],  declarations: [/* ... *\/],  providers: [    registerPageTab({      location: 'product-detail',      tab: 'Specs',      route: 'specs',      component: detailComponentWithResolver({        component: ProductSpecDetailComponent,        query: GetProductSpecsDocument,        entityKey: 'spec',      }),    }),  ],})export class ProductSpecsUiExtensionModule {}
```

```
function detailComponentWithResolver<T extends TypedDocumentNode<any, { id: string }>, Field extends keyof ResultOf<T>, R extends Field>(config: {    component: Type<TypedBaseDetailComponent<T, Field>>;    query: T;    entityKey: R;    getBreadcrumbs?: (entity: ResultOf<T>[R]) => BreadcrumbValue;    variables?: T extends TypedDocumentNode<any, infer V> ? Omit<V, 'id'> : never;}): void
```

Parameters

### config​


[​](#config)[TypedBaseDetailComponent](/reference/admin-ui-api/list-detail-views/typed-base-detail-component#typedbasedetailcomponent)


---

# TypedBaseDetailComponent


## TypedBaseDetailComponent​


[​](#typedbasedetailcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[base-detail.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/common/base-detail.component.ts#L186)A version of the BaseDetailComponent which is designed to be used with a
TypedDocumentNode.

[BaseDetailComponent](/reference/admin-ui-api/list-detail-views/base-detail-component#basedetailcomponent)[TypedDocumentNode](https://the-guild.dev/graphql/codegen/plugins/typescript/typed-document-node)
```
class TypedBaseDetailComponent<T extends TypedDocumentNode<any, any>, Field extends keyof ResultOf<T>> extends BaseDetailComponent<NonNullable<ResultOf<T>[Field]>> {    protected result$: Observable<ResultOf<T>>;    protected entity: ResultOf<T>[Field];    constructor()    init() => ;}
```

- Extends: BaseDetailComponent<NonNullable<ResultOf<T>[Field]>>

[BaseDetailComponent](/reference/admin-ui-api/list-detail-views/base-detail-component#basedetailcomponent)
### result$​


[​](#result)
### entity​


[​](#entity)
### constructor​


[​](#constructor)
### init​


[​](#init)


---

# TypedBaseListComponent


## TypedBaseListComponent​


[​](#typedbaselistcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[base-list.component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/common/base-list.component.ts#L217)A version of the BaseListComponent which is designed to be used with a
TypedDocumentNode.

[BaseListComponent](/reference/admin-ui-api/list-detail-views/base-list-component#baselistcomponent)[TypedDocumentNode](https://the-guild.dev/graphql/codegen/plugins/typescript/typed-document-node)
```
class TypedBaseListComponent<T extends TypedDocumentNode<any, Vars>, Field extends keyof ResultOf<T>, Vars extends { options: { filter: any; sort: any } } = VariablesOf<T>> extends BaseListComponent<ResultOf<T>, ItemOf<ResultOf<T>, Field>, VariablesOf<T>> implements OnInit {    availableLanguages$: Observable<LanguageCode[]>;    contentLanguage$: Observable<LanguageCode>;    protected dataService = inject(DataService);    protected router = inject(Router);    protected serverConfigService = inject(ServerConfigService);    protected permissionsService = inject(PermissionsService);    protected dataTableConfigService = inject(DataTableConfigService);    protected dataTableListId: string | undefined;    constructor()    configure(config: {        document: T;        getItems: (data: ResultOf<T>) => { items: Array<ItemOf<ResultOf<T>, Field>>; totalItems: number };        setVariables?: (skip: number, take: number) => VariablesOf<T>;        refreshListOnChanges?: Array<Observable<any>>;    }) => ;    ngOnInit() => ;    createFilterCollection() => DataTableFilterCollection<NonNullable<NonNullable<Vars['options']>['filter']>>;    createSortCollection() => DataTableSortCollection<NonNullable<NonNullable<Vars['options']>['sort']>>;    setLanguage(code: LanguageCode) => ;    getCustomFieldConfig(key: Exclude<keyof CustomFields, '__typename'> | string) => CustomFieldConfig[];}
```

- Extends: BaseListComponent<ResultOf<T>, ItemOf<ResultOf<T>, Field>, VariablesOf<T>>
- Implements: OnInit

Extends: BaseListComponent<ResultOf<T>, ItemOf<ResultOf<T>, Field>, VariablesOf<T>>

[BaseListComponent](/reference/admin-ui-api/list-detail-views/base-list-component#baselistcomponent)Implements: OnInit

### availableLanguages$​


[​](#availablelanguages)[LanguageCode](/reference/typescript-api/common/language-code#languagecode)
### contentLanguage$​


[​](#contentlanguage)[LanguageCode](/reference/typescript-api/common/language-code#languagecode)
### dataService​


[​](#dataservice)
### router​


[​](#router)
### serverConfigService​


[​](#serverconfigservice)
### permissionsService​


[​](#permissionsservice)
### dataTableConfigService​


[​](#datatableconfigservice)
### dataTableListId​


[​](#datatablelistid)
### constructor​


[​](#constructor)
### configure​


[​](#configure)
### ngOnInit​


[​](#ngoninit)
### createFilterCollection​


[​](#createfiltercollection)
### createSortCollection​


[​](#createsortcollection)
### setLanguage​


[​](#setlanguage)[LanguageCode](/reference/typescript-api/common/language-code#languagecode)
### getCustomFieldConfig​


[​](#getcustomfieldconfig)[CustomFields](/reference/typescript-api/custom-fields/#customfields)[CustomFieldConfig](/reference/typescript-api/custom-fields/custom-field-config#customfieldconfig)


---

# AddNavMenuItem


## addNavMenuItem​


[​](#addnavmenuitem)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[add-nav-menu-item.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/extension/add-nav-menu-item.ts#L66)Add a menu item to an existing section specified by sectionId. The id of the section
can be found by inspecting the DOM and finding the data-section-id attribute.
Providing the before argument will move the item before any existing item with the specified id.
If omitted (or if the name is not found) the item will be appended to the
end of the section.

This should be used in the NgModule providers array of your ui extension module.

Example

```
import { addNavMenuItem } from '@vendure/admin-ui/core';export default [    addNavMenuItem({        id: 'reviews',        label: 'Product Reviews',        routerLink: ['/extensions/reviews'],        icon: 'star',    },    'marketing'),];
```

```
function addNavMenuItem(config: NavMenuItem, sectionId: string, before?: string): void
```

Parameters

### config​


[​](#config)[NavMenuItem](/reference/admin-ui-api/nav-menu/nav-menu-item#navmenuitem)
### sectionId​


[​](#sectionid)
### before​


[​](#before)


---

# AddNavMenuSection


## addNavMenuSection​


[​](#addnavmenusection)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[add-nav-menu-item.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/extension/add-nav-menu-item.ts#L30)Add a section to the main nav menu. Providing the before argument will
move the section before any existing section with the specified id. If
omitted (or if the id is not found) the section will be appended to the
existing set of sections.
This should be used in the NgModule providers array of your ui extension module.

Example

```
import { addNavMenuSection } from '@vendure/admin-ui/core';export default [    addNavMenuSection({        id: 'reports',        label: 'Reports',        items: [{            // ...        }],    },    'settings'),];
```

```
function addNavMenuSection(config: NavMenuSection, before?: string): void
```

Parameters

### config​


[​](#config)[NavMenuSection](/reference/admin-ui-api/nav-menu/nav-menu-section#navmenusection)
### before​


[​](#before)


---

# NavMenuItem


## NavMenuItem​


[​](#navmenuitem)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[nav-builder-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/nav-builder/nav-builder-types.ts#L37)A NavMenuItem is a menu item in the main (left-hand side) nav
bar.

```
interface NavMenuItem {    id: string;    label: string;    routerLink: RouterLinkDefinition;    onClick?: (event: MouseEvent) => void;    icon?: string;    requiresPermission?: string | ((userPermissions: string[]) => boolean);    statusBadge?: Observable<NavMenuBadge>;}
```

### id​


[​](#id)
### label​


[​](#label)
### routerLink​


[​](#routerlink)[RouterLinkDefinition](/reference/admin-ui-api/action-bar/router-link-definition#routerlinkdefinition)
### onClick​


[​](#onclick)
### icon​


[​](#icon)
### requiresPermission​


[​](#requirespermission)
### statusBadge​


[​](#statusbadge)[NavMenuBadge](/reference/admin-ui-api/nav-menu/navigation-types#navmenubadge)


---

# NavMenuSection


## NavMenuSection​


[​](#navmenusection)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[nav-builder-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/nav-builder/nav-builder-types.ts#L57)A NavMenuSection is a grouping of links in the main
(left-hand side) nav bar.

```
interface NavMenuSection {    id: string;    label: string;    items: NavMenuItem[];    icon?: string;    displayMode?: 'regular' | 'settings';    requiresPermission?: string | ((userPermissions: string[]) => boolean);    collapsible?: boolean;    collapsedByDefault?: boolean;}
```

### id​


[​](#id)
### label​


[​](#label)
### items​


[​](#items)[NavMenuItem](/reference/admin-ui-api/nav-menu/nav-menu-item#navmenuitem)
### icon​


[​](#icon)
### displayMode​


[​](#displaymode)
### requiresPermission​


[​](#requirespermission)Control the display of this item based on the user permissions. Note: if you attempt to pass a
PermissionDefinition object, you will get a compilation error. Instead, pass the plain
string version. For example, if the permission is defined as:

[PermissionDefinition](/reference/typescript-api/auth/permission-definition#permissiondefinition)
```
export const MyPermission = new PermissionDefinition('ProductReview');
```

then the generated permission strings will be:

- CreateProductReview
- ReadProductReview
- UpdateProductReview
- DeleteProductReview

### collapsible​


[​](#collapsible)
### collapsedByDefault​


[​](#collapsedbydefault)


---

# Navigation Types


## NavMenuBadge​


[​](#navmenubadge)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[nav-builder-types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/nav-builder/nav-builder-types.ts#L19)A color-coded notification badge which will be displayed by the
NavMenuItem's icon.

```
interface NavMenuBadge {    type: NavMenuBadgeType;    propagateToSection?: boolean;}
```

### type​


[​](#type)
### propagateToSection​


[​](#propagatetosection)If true, the badge will propagate to the NavMenuItem's
parent section, displaying a notification badge next
to the section name.


---

# AssetPreviewPipe


## AssetPreviewPipe​


[​](#assetpreviewpipe)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[asset-preview.pipe.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/pipes/asset-preview.pipe.ts#L19)Given an Asset object (an object with preview and optionally focalPoint properties), this pipe
returns a string with query parameters designed to work with the image resize capabilities of the
AssetServerPlugin.

Example

```
<img [src]="asset | assetPreview:'tiny'" /><img [src]="asset | assetPreview:150" />
```

```
class AssetPreviewPipe implements PipeTransform {    transform(asset?: AssetFragment, preset: string | number = 'thumb') => string;}
```

- Implements: PipeTransform

### transform​


[​](#transform)


---

# DurationPipe


## DurationPipe​


[​](#durationpipe)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[duration.pipe.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/pipes/duration.pipe.ts#L18)Displays a number of milliseconds in a more human-readable format,
e.g. "12ms", "33s", "2:03m"

Example

```
{{ timeInMs | duration }}
```

```
class DurationPipe implements PipeTransform {    constructor(i18nService: I18nService)    transform(value: number) => string;}
```

- Implements: PipeTransform

### constructor​


[​](#constructor)[I18nService](/reference/typescript-api/common/i18n-service#i18nservice)
### transform​


[​](#transform)


---

# FileSizePipe


## FileSizePipe​


[​](#filesizepipe)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[file-size.pipe.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/pipes/file-size.pipe.ts#L14)Formats a number into a human-readable file size string.

Example

```
{{ fileSizeInBytes | filesize }}
```

```
class FileSizePipe implements PipeTransform {    transform(value: number, useSiUnits:  = true) => any;}
```

- Implements: PipeTransform

### transform​


[​](#transform)


---

# HasPermissionPipe


## HasPermissionPipe​


[​](#haspermissionpipe)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[has-permission.pipe.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/pipes/has-permission.pipe.ts#L16)A pipe which checks the provided permission against all the permissions of the current user.
Returns true if the current user has that permission.

Example

```
<button [disabled]="!('UpdateCatalog' | hasPermission)">Save Changes</button>
```

```
class HasPermissionPipe implements PipeTransform, OnDestroy {    constructor(permissionsService: PermissionsService, changeDetectorRef: ChangeDetectorRef)    transform(input: string | string[]) => any;    ngOnDestroy() => ;}
```

- Implements: PipeTransform, OnDestroy

### constructor​


[​](#constructor)
### transform​


[​](#transform)
### ngOnDestroy​


[​](#ngondestroy)


---

# LocaleCurrencyNamePipe


## LocaleCurrencyNamePipe​


[​](#localecurrencynamepipe)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[locale-currency-name.pipe.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/pipes/locale-currency-name.pipe.ts#L18)Displays a human-readable name for a given ISO 4217 currency code.

Example

```
{{ order.currencyCode | localeCurrencyName }}
```

```
class LocaleCurrencyNamePipe extends LocaleBasePipe implements PipeTransform {    constructor(dataService?: DataService, changeDetectorRef?: ChangeDetectorRef)    transform(value: any, display: 'full' | 'symbol' | 'name' = 'full', locale?: unknown) => any;}
```

- Extends: LocaleBasePipe
- Implements: PipeTransform

Extends: LocaleBasePipe

Implements: PipeTransform

### constructor​


[​](#constructor)[DataService](/reference/admin-ui-api/services/data-service#dataservice)
### transform​


[​](#transform)


---

# LocaleCurrencyPipe


## LocaleCurrencyPipe​


[​](#localecurrencypipe)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[locale-currency.pipe.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/pipes/locale-currency.pipe.ts#L20)Formats a Vendure monetary value (in cents) into the correct format for the configured currency and display
locale.

Example

```
{{ variant.priceWithTax | localeCurrency }}
```

```
class LocaleCurrencyPipe extends LocaleBasePipe implements PipeTransform {    readonly precisionFactor: number;    constructor(currencyService: CurrencyService, dataService?: DataService, changeDetectorRef?: ChangeDetectorRef)    transform(value: unknown, args: unknown[]) => string | unknown;}
```

- Extends: LocaleBasePipe
- Implements: PipeTransform

Extends: LocaleBasePipe

Implements: PipeTransform

### precisionFactor​


[​](#precisionfactor)
### constructor​


[​](#constructor)[DataService](/reference/admin-ui-api/services/data-service#dataservice)
### transform​


[​](#transform)


---

# LocaleDatePipe


## LocaleDatePipe​


[​](#localedatepipe)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[locale-date.pipe.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/pipes/locale-date.pipe.ts#L19)A replacement of the Angular DatePipe which makes use of the Intl API
to format dates according to the selected UI language.

Example

```
{{ order.orderPlacedAt | localeDate }}
```

```
class LocaleDatePipe extends LocaleBasePipe implements PipeTransform {    constructor(dataService?: DataService, changeDetectorRef?: ChangeDetectorRef)    transform(value: unknown, args: unknown[]) => unknown;}
```

- Extends: LocaleBasePipe
- Implements: PipeTransform

Extends: LocaleBasePipe

Implements: PipeTransform

### constructor​


[​](#constructor)[DataService](/reference/admin-ui-api/services/data-service#dataservice)
### transform​


[​](#transform)


---

# LocaleLanguageNamePipe


## LocaleLanguageNamePipe​


[​](#localelanguagenamepipe)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[locale-language-name.pipe.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/pipes/locale-language-name.pipe.ts#L18)Displays a human-readable name for a given ISO 639-1 language code.

Example

```
{{ 'zh_Hant' | localeLanguageName }}
```

```
class LocaleLanguageNamePipe extends LocaleBasePipe implements PipeTransform {    constructor(dataService?: DataService, changeDetectorRef?: ChangeDetectorRef)    transform(value: any, locale?: unknown) => string;}
```

- Extends: LocaleBasePipe
- Implements: PipeTransform

Extends: LocaleBasePipe

Implements: PipeTransform

### constructor​


[​](#constructor)[DataService](/reference/admin-ui-api/services/data-service#dataservice)
### transform​


[​](#transform)


---

# LocaleRegionNamePipe


## LocaleRegionNamePipe​


[​](#localeregionnamepipe)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[locale-region-name.pipe.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/pipes/locale-region-name.pipe.ts#L18)Displays a human-readable name for a given region.

Example

```
{{ 'GB' | localeRegionName }}
```

```
class LocaleRegionNamePipe extends LocaleBasePipe implements PipeTransform {    constructor(dataService?: DataService, changeDetectorRef?: ChangeDetectorRef)    transform(value: any, locale?: unknown) => string;}
```

- Extends: LocaleBasePipe
- Implements: PipeTransform

Extends: LocaleBasePipe

Implements: PipeTransform

### constructor​


[​](#constructor)[DataService](/reference/admin-ui-api/services/data-service#dataservice)
### transform​


[​](#transform)


---

# TimeAgoPipe


## TimeAgoPipe​


[​](#timeagopipe)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[time-ago.pipe.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/shared/pipes/time-ago.pipe.ts#L18)Converts a date into the format "3 minutes ago", "5 hours ago" etc.

Example

```
{{ order.orderPlacedAt | timeAgo }}
```

```
class TimeAgoPipe implements PipeTransform {    constructor(i18nService: I18nService)    transform(value: string | Date, nowVal?: string | Date) => string;}
```

- Implements: PipeTransform

### constructor​


[​](#constructor)[I18nService](/reference/typescript-api/common/i18n-service#i18nservice)
### transform​


[​](#transform)


---

# ActionBar


## ActionBar​


[​](#actionbar)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[ActionBar.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/react/src/react-components/ActionBar.tsx#L22)A container for the primary actions on a list or detail page

Example

```
import { ActionBar } from '@vendure/admin-ui/react';export function MyComponent() {  return (    <ActionBar leftContent={<div>Optional left content</div>}>      <button className='button primary'>Primary action</button>    </ActionBar>  );}
```

```
function ActionBar(props: PropsWithChildren<{ leftContent?: ReactNode }>): void
```

Parameters

### props​


[​](#props)


---

# Card


## Card​


[​](#card)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[Card.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/react/src/react-components/Card.tsx#L22)A card component which can be used to group related content.

Example

```
import { Card } from '@vendure/admin-ui/react';export function MyComponent() {  return (    <Card title='My Title'>      <p>Some content</p>    </Card>  );}
```

```
function Card(props: PropsWithChildren<{ title?: string; paddingX?: boolean }>): void
```

Parameters

### props​


[​](#props)


---

# CdsIcon


## CdsIcon​


[​](#cdsicon)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[CdsIcon.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/react/src/react-components/CdsIcon.tsx#L47)A React wrapper for the Clarity UI icon component.

Example

```
import { userIcon } from '@cds/core/icon';import { CdsIcon } from '@vendure/admin-ui/react';registerCdsIcon(userIcon);export function MyComponent() {   return <CdsIcon icon={userIcon} badge="warning" solid size="lg"></CdsIcon>;}
```

```
function CdsIcon(props: { icon: IconShapeTuple; className?: string } & Partial<CdsIconProps>): void
```

Parameters

### props​


[​](#props)

---

# FormField


## FormField​


[​](#formfield)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[FormField.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/react/src/react-components/FormField.tsx#L22)A wrapper around form fields which provides a label, tooltip and error message.

Example

```
import { FormField } from '@vendure/admin-ui/react';export function MyReactComponent() {    return (       <FormField label="My field" tooltip="This is a tooltip" invalid errorMessage="This field is invalid">           <input type="text" />       </FormField>    );}
```

```
function FormField(props: PropsWithChildren<{        for?: string;        label?: string;        tooltip?: string;        invalid?: boolean;        errorMessage?: string;    }>): void
```

Parameters

### props​


[​](#props)


---

# Link


## Link​


[​](#link)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[Link.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/react/src/react-components/Link.tsx#L22)A React component which renders an anchor tag and navigates to the specified route when clicked.
This is useful when you want to use a React component in a Vendure UI plugin which navigates to
a route in the admin-ui.

Example

```
import { Link } from '@vendure/admin-ui/react';export const MyReactComponent = () => {    return <Link href="/extensions/my-extension">Go to my extension</Link>;}
```

```
function Link(props: PropsWithChildren<{ href: string; [props: string]: any }>): void
```

Parameters

### props​


[​](#props)


---

# PageBlock


## PageBlock​


[​](#pageblock)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[PageBlock.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/react/src/react-components/PageBlock.tsx#L22)A container for page content which provides a consistent width and spacing.

Example

```
import { PageBlock } from '@vendure/admin-ui/react';export function MyComponent() {  return (    <PageBlock>      ...    </PageBlock>  );}
```

```
function PageBlock(props: PropsWithChildren): void
```

Parameters

### props​


[​](#props)


---

# PageDetailLayout


## PageDetailLayout​


[​](#pagedetaillayout)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[PageDetailLayout.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/react/src/react-components/PageDetailLayout.tsx#L22)A responsive container for detail views with a main content area and an optional sidebar.

Example

```
import { PageDetailLayout } from '@vendure/admin-ui/react';export function MyComponent() {  return (    <PageDetailLayout sidebar={<div>Sidebar content</div>}>      <div>Main content</div>    </PageDetailLayout>  );}
```

```
function PageDetailLayout(props: PropsWithChildren<{ sidebar?: ReactNode }>): void
```

Parameters

### props​


[​](#props)


---

# RichTextEditor


## RichTextEditor​


[​](#richtexteditor)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[RichTextEditor.tsx](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/react/src/react-components/RichTextEditor.tsx#L60)A rich text editor component which uses ProseMirror (rich text editor) under the hood.

Example

```
import { RichTextEditor } from '@vendure/admin-ui/react';import React from 'react';export function MyComponent() {  const onSubmit = async (e: React.FormEvent) => {    e.preventDefault();    const form = new FormData(e.target as HTMLFormElement);    const content = form.get("content");    console.log(content);  };  return (    <form className="w-full" onSubmit={onSubmit}>      <RichTextEditor        name="content"        readOnly={false}        onMount={(e) => console.log("Mounted", e)}      />      <button type="submit" className="btn btn-primary">        Submit      </button>    </form>  );}
```


---

# ReactCustomDetailComponentConfig


## ReactCustomDetailComponentConfig​


[​](#reactcustomdetailcomponentconfig)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[register-react-custom-detail-component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/react/src/register-react-custom-detail-component.ts#L15)Configures a React-based component to be placed in a detail page in the given location.

```
interface ReactCustomDetailComponentConfig {    locationId: CustomDetailComponentLocationId;    component: ElementType;    props?: Record<string, any>;}
```

### locationId​


[​](#locationid)[CustomDetailComponentLocationId](/reference/admin-ui-api/custom-detail-components/custom-detail-component-location-id#customdetailcomponentlocationid)The id of the detail page location in which to place the component.

### component​


[​](#component)The React component to render.

### props​


[​](#props)Optional props to pass to the React component.


---

# ReactDataTableComponentConfig


## ReactDataTableComponentConfig​


[​](#reactdatatablecomponentconfig)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[register-react-data-table-component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/react/src/register-react-data-table-component.ts#L19)Configures a CustomDetailComponent to be placed in the given location.

[CustomDetailComponent](/reference/admin-ui-api/custom-detail-components/custom-detail-component#customdetailcomponent)
```
interface ReactDataTableComponentConfig {    tableId: DataTableLocationId;    columnId: DataTableColumnId;    component: ElementType;    props?: Record<string, any>;}
```

### tableId​


[​](#tableid)The location in the UI where the custom component should be placed.

### columnId​


[​](#columnid)The column in the table where the custom component should be placed.

### component​


[​](#component)The component to render in the table cell. This component will receive the rowItem prop
which is the data object for the row, e.g. the Product object if used in the product-list table.

### props​


[​](#props)Optional props to pass to the React component.


---

# RegisterReactCustomDetailComponent


## registerReactCustomDetailComponent​


[​](#registerreactcustomdetailcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[register-react-custom-detail-component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/react/src/register-react-custom-detail-component.ts#L40)Registers a React component to be rendered in a detail page in the given location.
Components used as custom detail components can make use of the useDetailComponentData hook.

[useDetailComponentData](/reference/admin-ui-api/react-hooks/use-detail-component-data#usedetailcomponentdata)
```
function registerReactCustomDetailComponent(config: ReactCustomDetailComponentConfig): void
```

Parameters

### config​


[​](#config)[ReactCustomDetailComponentConfig](/reference/admin-ui-api/react-extensions/react-custom-detail-component-config#reactcustomdetailcomponentconfig)


---

# RegisterReactDataTableComponent


## registerReactDataTableComponent​


[​](#registerreactdatatablecomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[register-react-data-table-component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/react/src/register-react-data-table-component.ts#L90)Registers a React component to be rendered in a data table in the given location.
The component will receive the rowItem prop which is the data object for the row,
e.g. the Product object if used in the product-list table.

Example

```
import { ReactDataTableComponentProps } from '@vendure/admin-ui/react';import React from 'react';export function SlugWithLink({ rowItem }: ReactDataTableComponentProps<{ slug: string }>) {    return (        <a href={`https://example.com/products/${rowItem.slug}`} target="_blank">            {rowItem.slug}        </a>    );}
```

```
import { registerReactDataTableComponent } from '@vendure/admin-ui/react';import { SlugWithLink } from './components/SlugWithLink';export default [    registerReactDataTableComponent({        component: SlugWithLink,        tableId: 'product-list',        columnId: 'slug',        props: {          foo: 'bar',        },    }),];
```

```
function registerReactDataTableComponent(config: ReactDataTableComponentConfig): void
```

Parameters

### config​


[​](#config)[ReactDataTableComponentConfig](/reference/admin-ui-api/react-extensions/react-data-table-component-config#reactdatatablecomponentconfig)


---

# RegisterReactFormInputComponent


## registerReactFormInputComponent​


[​](#registerreactforminputcomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[register-react-form-input-component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/react/src/register-react-form-input-component.ts#L15)Registers a React component to be used as a FormInputComponent.

[FormInputComponent](/reference/admin-ui-api/custom-input-components/form-input-component#forminputcomponent)
```
function registerReactFormInputComponent(id: string, component: ElementType): void
```

Parameters

### id​


[​](#id)
### component​


[​](#component)


---

# RegisterReactRouteComponentOptions


## RegisterReactRouteComponentOptions​


[​](#registerreactroutecomponentoptions)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[register-react-route-component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/react/src/register-react-route-component.ts#L15)Configuration for a React-based route component.

```
type RegisterReactRouteComponentOptions<Entity extends { id: string; updatedAt?: string }, T extends DocumentNode | TypedDocumentNode<any, { id: string }>, Field extends keyof ResultOf<T>, R extends Field> = RegisterRouteComponentOptions<ElementType, Entity, T, Field, R> & {    props?: Record<string, any>;}
```


---

# RegisterReactRouteComponent


## registerReactRouteComponent​


[​](#registerreactroutecomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[register-react-route-component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/react/src/register-react-route-component.ts#L30)Registers a React component to be used as a route component.

```
function registerReactRouteComponent<Entity extends { id: string; updatedAt?: string }, T extends DocumentNode | TypedDocumentNode<any, { id: string }>, Field extends keyof ResultOf<T>, R extends Field>(options: RegisterReactRouteComponentOptions<Entity, T, Field, R>): Route
```

Parameters

### options​


[​](#options)[RegisterReactRouteComponentOptions](/reference/admin-ui-api/react-extensions/register-react-route-component-options#registerreactroutecomponentoptions)


---

# UseDetailComponentData


## useDetailComponentData​


[​](#usedetailcomponentdata)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[use-detail-component-data.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/react/src/react-hooks/use-detail-component-data.ts#L34)Provides the data available to React-based CustomDetailComponents.

Example

```
import { Card, useDetailComponentData } from '@vendure/admin-ui/react';import React from 'react';export function CustomDetailComponent(props: any) {    const { entity, detailForm } = useDetailComponentData();    const updateName = () => {        detailForm.get('name')?.setValue('New name');        detailForm.markAsDirty();    };    return (        <Card title={'Custom Detail Component'}>            <button className="button" onClick={updateName}>                Update name            </button>            <pre>{JSON.stringify(entity, null, 2)}</pre>        </Card>    );}
```

```
function useDetailComponentData<T = any>(): void
```


---

# UseFormControl


## useFormControl​


[​](#useformcontrol)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[use-form-control.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/react/src/react-hooks/use-form-control.ts#L31)Provides access to the current FormControl value and a method to update the value.

Example

```
import { useFormControl, ReactFormInputProps } from '@vendure/admin-ui/react';import React from 'react';export function ReactNumberInput({ readonly }: ReactFormInputProps) {    const { value, setFormValue } = useFormControl();    const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {        setFormValue(val);    };    return (        <div>            <input readOnly={readonly} type="number" onChange={handleChange} value={value} />        </div>    );}
```

```
function useFormControl(): void
```


---

# UseInjector


## useInjector​


[​](#useinjector)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[use-injector.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/react/src/react-hooks/use-injector.ts#L27)Exposes the Angular injector which allows the injection of services into React components.

Example

```
import { useInjector } from '@vendure/admin-ui/react';import { NotificationService } from '@vendure/admin-ui/core';export const MyComponent = () => {    const notificationService = useInjector(NotificationService);    const handleClick = () => {        notificationService.success('Hello world!');    };    // ...    return <div>...</div>;}
```

```
function useInjector<T = any>(token: ProviderToken<T>): T
```

Parameters

### token​


[​](#token)


---

# UseLazyQuery


## useLazyQuery​


[​](#uselazyquery)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[use-query.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/react/src/react-hooks/use-query.ts#L119)A React hook which allows you to execute a GraphQL query lazily.

Example

```
import { useLazyQuery } from '@vendure/admin-ui/react';import { gql } from 'graphql-tag';const GET_PRODUCT = gql`   query GetProduct($id: ID!) {     product(id: $id) {       id       name       description     }   }`;type ProductResponse = {    product: {        name: string        description: string    }}export const MyComponent = () => {    const [getProduct, { data, loading, error }] = useLazyQuery<ProductResponse>(GET_PRODUCT, { refetchOnChannelChange: true });   const handleClick = () => {        getProduct({             id: '1',        }).then(result => {            // do something with the result        });    };    if (loading) return <div>Loading...</div>;    if (error) return <div>Error! { error }</div>;    return (    <div>        <button onClick={handleClick}>Get product</button>        {data && (             <div>                 <h1>{data.product.name}</h1>                 <p>{data.product.description}</p>             </div>)}    </div>    );};
```

```
function useLazyQuery<T, V extends Record<string, any> = Record<string, any>>(query: DocumentNode | TypedDocumentNode<T, V>, options: { refetchOnChannelChange: boolean } = { refetchOnChannelChange: false }): void
```

Parameters

### query​


[​](#query)
### options​


[​](#options)


---

# UseMutation


## useMutation​


[​](#usemutation)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[use-query.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/react/src/react-hooks/use-query.ts#L181)A React hook which allows you to execute a GraphQL mutation.

Example

```
import { useMutation } from '@vendure/admin-ui/react';import { gql } from 'graphql-tag';const UPDATE_PRODUCT = gql`  mutation UpdateProduct($input: UpdateProductInput!) {    updateProduct(input: $input) {    id    name  }}`;export const MyComponent = () => {    const [updateProduct, { data, loading, error }] = useMutation(UPDATE_PRODUCT);    const handleClick = () => {        updateProduct({            input: {                id: '1',                name: 'New name',            },        }).then(result => {            // do something with the result        });    };    if (loading) return <div>Loading...</div>;    if (error) return <div>Error! { error }</div>;    return (    <div>        <button onClick={handleClick}>Update product</button>        {data && <div>Product updated!</div>}    </div>    );};
```

```
function useMutation<T, V extends Record<string, any> = Record<string, any>>(mutation: DocumentNode | TypedDocumentNode<T, V>): void
```

Parameters

### mutation​


[​](#mutation)


---

# UsePageMetadata


## usePageMetadata​


[​](#usepagemetadata)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[use-page-metadata.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/react/src/react-hooks/use-page-metadata.ts#L31)Provides functions for setting the current page title and breadcrumb.

Example

```
import { usePageMetadata } from '@vendure/admin-ui/react';import { useEffect } from 'react';export const MyComponent = () => {    const { setTitle, setBreadcrumb } = usePageMetadata();    useEffect(() => {        setTitle('My Page');        setBreadcrumb([            { link: ['./parent'], label: 'Parent Page' },            { link: ['./'], label: 'This Page' },        ]);    }, []);    // ...    return <div>...</div>;}
```

```
function usePageMetadata(): void
```


---

# UseQuery


## useQuery​


[​](#usequery)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[use-query.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/react/src/react-hooks/use-query.ts#L43)A React hook which provides access to the results of a GraphQL query.

Example

```
import { useQuery } from '@vendure/admin-ui/react';import { gql } from 'graphql-tag';const GET_PRODUCT = gql`   query GetProduct($id: ID!) {     product(id: $id) {       id       name       description     }   }`;export const MyComponent = () => {    const { data, loading, error } = useQuery(GET_PRODUCT, { id: '1' }, { refetchOnChannelChange: true });    if (loading) return <div>Loading...</div>;    if (error) return <div>Error! { error }</div>;    return (        <div>            <h1>{data.product.name}</h1>            <p>{data.product.description}</p>        </div>    );};
```

```
function useQuery<T, V extends Record<string, any> = Record<string, any>>(query: DocumentNode | TypedDocumentNode<T, V>, variables?: V, options: { refetchOnChannelChange: boolean } = { refetchOnChannelChange: false }): void
```

Parameters

### query​


[​](#query)
### variables​


[​](#variables)
### options​


[​](#options)


---

# UseRichTextEditor


## useRichTextEditor​


[​](#userichtexteditor)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[use-rich-text-editor.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/react/src/react-hooks/use-rich-text-editor.ts#L40)Provides access to the ProseMirror (rich text editor) instance.

Example

```
import { useRichTextEditor } from '@vendure/admin-ui/react';import React from 'react';export function Component() {    const { ref, editor } = useRichTextEditor({       attributes: { class: '' },       onTextInput: (text) => console.log(text),       isReadOnly: () => false,    });    return <div className="w-full" ref={ref} />}
```


---

# UseRouteParams


## useRouteParams​


[​](#userouteparams)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[use-route-params.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/react/src/react-hooks/use-route-params.ts#L23)Provides access to the current route params and query params.

Example

```
import { useRouteParams } from '@vendure/admin-ui/react';import React from 'react';export function MyComponent() {    const { params, queryParams } = useRouteParams();    // ...    return <div>{ params.id }</div>;}
```

```
function useRouteParams(): void
```


---

# RegisterRouteComponentOptions


## RegisterRouteComponentOptions​


[​](#registerroutecomponentoptions)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[register-route-component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/extension/register-route-component.ts#L19)Configuration for a route component.

```
type RegisterRouteComponentOptions<Component extends any | BaseDetailComponent<Entity>, Entity extends { id: string; updatedAt?: string }, T extends DocumentNode | TypedDocumentNode<any, { id: string }>, Field extends keyof ResultOf<T>, R extends Field> = {    component: Type<Component> | Component;    title?: string;    locationId?: string;    description?: string;    breadcrumb?: BreadcrumbValue;    path?: string;    query?: T;    getBreadcrumbs?: (entity: Exclude<ResultOf<T>[R], 'Query'>) => BreadcrumbValue;    entityKey?: Component extends BaseDetailComponent<any> ? R : string;    variables?: T extends TypedDocumentNode<any, infer V> ? Omit<V, 'id'> : never;    routeConfig?: Route;} & (Component extends BaseDetailComponent<any> ? { entityKey: R } : unknown)
```


---

# RegisterRouteComponent


## registerRouteComponent​


[​](#registerroutecomponent)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[register-route-component.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/extension/register-route-component.ts#L79)Registers an Angular standalone component to be rendered in a route.

Example

```
import { registerRouteComponent } from '@vendure/admin-ui/core';import { registerReactRouteComponent } from '@vendure/admin-ui/react';import { ProductReviewDetailComponent } from './components/product-review-detail/product-review-detail.component';import { AllProductReviewsList } from './components/all-product-reviews-list/all-product-reviews-list.component';import { GetReviewDetailDocument } from './generated-types';export default [    registerRouteComponent({        path: '',        component: AllProductReviewsList,        breadcrumb: 'Product reviews',    }),    registerRouteComponent({        path: ':id',        component: ProductReviewDetailComponent,        query: GetReviewDetailDocument,        entityKey: 'productReview',        getBreadcrumbs: entity => [            {                label: 'Product reviews',                link: ['/extensions', 'product-reviews'],            },            {                label: `#${entity?.id} (${entity?.product.name})`,                link: [],            },        ],    }),];
```

```
function registerRouteComponent<Component extends any | BaseDetailComponent<Entity>, Entity extends { id: string; updatedAt?: string }, T extends DocumentNode | TypedDocumentNode<any, { id: string }>, Field extends keyof ResultOf<T>, R extends Field>(options: RegisterRouteComponentOptions<Component, Entity, T, Field, R>): void
```

Parameters

### options​


[​](#options)[RegisterRouteComponentOptions](/reference/admin-ui-api/routes/register-route-component-options#registerroutecomponentoptions)


---

# DataService


## DataService​


[​](#dataservice)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[data.service.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/data/providers/data.service.ts#L34)Used to interact with the Admin API via GraphQL queries. Internally this service uses the
Apollo Client, which means it maintains a normalized entity cache. For this reason, it is
advisable to always select the id field of any entity, which will allow the returned data
to be effectively cached.

```
class DataService {    query(query: DocumentNode | TypedDocumentNode<T, V>, variables?: V, fetchPolicy: WatchQueryFetchPolicy = 'cache-and-network', options: ExtendedQueryOptions = {}) => QueryResult<T, V>;    mutate(mutation: DocumentNode | TypedDocumentNode<T, V>, variables?: V, update?: MutationUpdaterFunction<T, V, any, any>, options: ExtendedQueryOptions = {}) => Observable<T>;}
```

### query​


[​](#query)[QueryResult](/reference/admin-ui-api/services/data-service#queryresult)Perform a GraphQL query. Returns a QueryResult which allows further control over
they type of result returned, e.g. stream of values, single value etc.

[QueryResult](/reference/admin-ui-api/services/data-service#queryresult)Example

```
const result$ = this.dataService.query(gql`  query MyQuery($id: ID!) {    product(id: $id) {      id      name      slug    }  },  { id: 123 },).mapSingle(data => data.product);
```

### mutate​


[​](#mutate)Perform a GraphQL mutation.

Example

```
const result$ = this.dataService.mutate(gql`  mutation MyMutation($Codegen.UpdateEntityInput!) {    updateEntity(input: $input) {      id      name    }  },  { Codegen.updateEntityInput },);
```

## QueryResult​


[​](#queryresult)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[query-result.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/data/query-result.ts#L31)This class wraps the Apollo Angular QueryRef object and exposes some getters
for convenience.

```
class QueryResult<T, V extends Record<string, any> = Record<string, any>> {    constructor(queryRef: QueryRef<T, V>, apollo: Apollo, customFieldMap: Map<string, CustomFieldConfig[]>)    refetchOnChannelChange() => QueryResult<T, V>;    refetchOnCustomFieldsChange(customFieldsToInclude$: Observable<string[]>) => QueryResult<T, V>;    single$: Observable<T>    stream$: Observable<T>    ref: QueryRef<T, V>    mapSingle(mapFn: (item: T) => R) => Observable<R>;    mapStream(mapFn: (item: T) => R) => Observable<R>;    destroy() => ;}
```

### constructor​


[​](#constructor)[CustomFieldConfig](/reference/typescript-api/custom-fields/custom-field-config#customfieldconfig)
### refetchOnChannelChange​


[​](#refetchonchannelchange)[QueryResult](/reference/admin-ui-api/services/data-service#queryresult)Re-fetch this query whenever the active Channel changes.

### refetchOnCustomFieldsChange​


[​](#refetchoncustomfieldschange)[QueryResult](/reference/admin-ui-api/services/data-service#queryresult)Re-fetch this query whenever the custom fields change, updating the query to include the
specified custom fields.

### single$​


[​](#single)Returns an Observable which emits a single result and then completes.

### stream$​


[​](#stream)Returns an Observable which emits until unsubscribed.

### ref​


[​](#ref)
### mapSingle​


[​](#mapsingle)Returns a single-result Observable after applying the map function.

### mapStream​


[​](#mapstream)Returns a multiple-result Observable after applying the map function.

### destroy​


[​](#destroy)Signals to the internal Observable subscriptions that they should complete.


---

# ModalService


## ModalService​


[​](#modalservice)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[modal.service.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/modal/modal.service.ts#L21)This service is responsible for instantiating a ModalDialog component and
embedding the specified component within.

```
class ModalService {    constructor(overlayHostService: OverlayHostService)    fromComponent(component: Type<T> & Type<Dialog<R>>, options?: ModalOptions<T>) => Observable<R | undefined>;    dialog(config: DialogConfig<T>) => Observable<T | undefined>;}
```

### constructor​


[​](#constructor)
### fromComponent​


[​](#fromcomponent)[Dialog](/reference/admin-ui-api/services/modal-service#dialog)[ModalOptions](/reference/admin-ui-api/services/modal-service#modaloptions)Create a modal from a component. The component must implement the Dialog interface.
Additionally, the component should include templates for the title and the buttons to be
displayed in the modal dialog. See example:

[Dialog](/reference/admin-ui-api/services/modal-service#dialog)Example

```
class MyDialog implements Dialog { resolveWith: (result?: any) => void; okay() {   doSomeWork().subscribe(result => {     this.resolveWith(result);   }) } cancel() {   this.resolveWith(false); }}
```

Example

```
<ng-template vdrDialogTitle>Title of the modal</ng-template><p>  My Content</p><ng-template vdrDialogButtons>  <button type="button"          class="btn"          (click)="cancel()">Cancel</button>  <button type="button"          class="btn btn-primary"          (click)="okay()">Okay</button></ng-template>
```

### dialog​


[​](#dialog)[DialogConfig](/reference/admin-ui-api/services/modal-service#dialogconfig)Displays a modal dialog with the provided title, body and buttons.

## Dialog​


[​](#dialog-1)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[modal.types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/modal/modal.types.ts#L9)Any component intended to be used with the ModalService.fromComponent() method must implement
this interface.

```
interface Dialog<R = any> {    resolveWith: (result?: R) => void;}
```

### resolveWith​


[​](#resolvewith)Function to be invoked in order to close the dialog when the action is complete.
The Observable returned from the .fromComponent() method will emit the value passed
to this method and then complete.

## DialogConfig​


[​](#dialogconfig)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[modal.types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/modal/modal.types.ts#L33)Configures a generic modal dialog.

```
interface DialogConfig<T> {    title: string;    body?: string;    translationVars?: { [key: string]: string | number };    buttons: Array<DialogButtonConfig<T>>;    size?: 'sm' | 'md' | 'lg' | 'xl';}
```

### title​


[​](#title)
### body​


[​](#body)
### translationVars​


[​](#translationvars)
### buttons​


[​](#buttons)
### size​


[​](#size)
## ModalOptions​


[​](#modaloptions)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[modal.types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/modal/modal.types.ts#L48)Options to configure the behaviour of the modal.

```
interface ModalOptions<T> {    size?: 'sm' | 'md' | 'lg' | 'xl';    verticalAlign?: 'top' | 'center' | 'bottom';    closable?: boolean;    locals?: Partial<T>;}
```

### size​


[​](#size-1)Sets the width of the dialog

### verticalAlign​


[​](#verticalalign)Sets the vertical alignment of the dialog

### closable​


[​](#closable)When true, the "x" icon is shown
and clicking it or the mask will close the dialog

### locals​


[​](#locals)Values to be passed directly to the component being instantiated inside the dialog.


---

# NotificationService


## NotificationService​


[​](#notificationservice)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[notification.service.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/notification/notification.service.ts#L54)Provides toast notification functionality.

Example

```
class MyComponent {  constructor(private notificationService: NotificationService) {}  save() {    this.notificationService        .success(_('asset.notify-create-assets-success'), {          count: successCount,        });  }}```ts title="Signature"class NotificationService {    constructor(i18nService: I18nService, resolver: ComponentFactoryResolver, overlayHostService: OverlayHostService)    success(message: string, translationVars?: { [key: string]: string | number }) => void;    info(message: string, translationVars?: { [key: string]: string | number }) => void;    warning(message: string, translationVars?: { [key: string]: string | number }) => void;    error(message: string, translationVars?: { [key: string]: string | number }) => void;    notify(config: ToastConfig) => void;}
```

### constructor​


[​](#constructor)[I18nService](/reference/typescript-api/common/i18n-service#i18nservice)
### success​


[​](#success)Display a success toast notification

### info​


[​](#info)Display an info toast notification

### warning​


[​](#warning)Display a warning toast notification

### error​


[​](#error)Display an error toast notification

### notify​


[​](#notify)[ToastConfig](/reference/admin-ui-api/services/notification-service#toastconfig)Display a toast notification.

## NotificationType​


[​](#notificationtype)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[notification.service.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/notification/notification.service.ts#L14)The types of notification available.

```
type NotificationType = 'info' | 'success' | 'error' | 'warning'
```

## ToastConfig​


[​](#toastconfig)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[notification.service.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/notification/notification.service.ts#L23)Configuration for a toast notification.

```
interface ToastConfig {    message: string;    translationVars?: { [key: string]: string | number };    type?: NotificationType;    duration?: number;}
```

### message​


[​](#message)
### translationVars​


[​](#translationvars)
### type​


[​](#type)[NotificationType](/reference/admin-ui-api/services/notification-service#notificationtype)
### duration​


[​](#duration)


---

# PageTabConfig


## PageTabConfig​


[​](#pagetabconfig)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[page.service.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/providers/page/page.service.ts#L14)The object used to configure a new page tab.

```
interface PageTabConfig {    location: PageLocationId;    tabIcon?: string;    route: string;    tab: string;    priority?: number;    component: Type<any> | ReturnType<typeof detailComponentWithResolver>;    routeConfig?: Route;}
```

### location​


[​](#location)[PageLocationId](/reference/admin-ui-api/action-bar/page-location-id#pagelocationid)A valid location representing a list or detail page.

### tabIcon​


[​](#tabicon)An optional icon to display in the tab. The icon
should be a valid shape name from the Clarity Icons
set.

[Clarity Icons](https://core.clarity.design/foundation/icons/shapes/)
### route​


[​](#route)The route path to the tab. This will be appended to the
route of the parent page.

### tab​


[​](#tab)The name of the tab to display in the UI.

### priority​


[​](#priority)The priority of the tab. Tabs with a lower priority will be displayed first.

### component​


[​](#component)[detailComponentWithResolver](/reference/admin-ui-api/list-detail-views/detail-component-with-resolver#detailcomponentwithresolver)The component to render at the route of the tab.

### routeConfig​


[​](#routeconfig)You can optionally provide any native Angular route configuration options here.
Any values provided here will take precedence over the values generated
by the route and component properties.


---

# RegisterPageTab


## registerPageTab​


[​](#registerpagetab)[@vendure/admin-ui](https://www.npmjs.com/package/@vendure/admin-ui)[register-page-tab.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui/src/lib/core/src/extension/register-page-tab.ts#L24)Add a tab to an existing list or detail page.

Example

```
import { registerPageTab } from '@vendure/admin-ui/core';import { DeletedProductListComponent } from './components/deleted-product-list/deleted-product-list.component';export default [    registerPageTab({        location: 'product-list',        tab: 'Deleted Products',        route: 'deleted',        component: DeletedProductListComponent,    }),];
```

```
function registerPageTab(config: PageTabConfig): void
```

Parameters

### config​


[​](#config)[PageTabConfig](/reference/admin-ui-api/tabs/page-tab-config#pagetabconfig)


---

# AdminUiExtension


## AdminUiExtension​


[​](#adminuiextension)[@vendure/ui-devkit](https://www.npmjs.com/package/@vendure/ui-devkit)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/ui-devkit/src/compiler/types.ts#L130)Defines extensions to the Admin UI application by specifying additional
Angular NgModules which are compiled
into the application.

[NgModules](https://angular.io/guide/ngmodules)See Extending the Admin UI for
detailed instructions.

[Extending the Admin UI](/guides/extending-the-admin-ui/getting-started/)
```
interface AdminUiExtension extends Partial<TranslationExtension>,        Partial<StaticAssetExtension>,        Partial<GlobalStylesExtension> {    id?: string;    extensionPath: string;    ngModules?: Array<AdminUiExtensionSharedModule | AdminUiExtensionLazyModule>;    providers?: string[];    routes?: UiExtensionRouteDefinition[];    pathAlias?: string;    exclude?: string[];}
```

- Extends: Partial<TranslationExtension>, Partial<StaticAssetExtension>, Partial<GlobalStylesExtension>

[TranslationExtension](/reference/admin-ui-api/ui-devkit/admin-ui-extension#translationextension)[StaticAssetExtension](/reference/admin-ui-api/ui-devkit/admin-ui-extension#staticassetextension)[GlobalStylesExtension](/reference/admin-ui-api/ui-devkit/admin-ui-extension#globalstylesextension)
### id​


[​](#id)An optional ID for the extension module. Only used internally for generating
import paths to your module. If not specified, a unique hash will be used as the id.

### extensionPath​


[​](#extensionpath)The path to the directory containing the extension module(s). The entire contents of this directory
will be copied into the Admin UI app, including all TypeScript source files, html templates,
scss style sheets etc.

### ngModules​


[​](#ngmodules)[AdminUiExtensionSharedModule](/reference/admin-ui-api/ui-devkit/admin-ui-extension#adminuiextensionsharedmodule)[AdminUiExtensionLazyModule](/reference/admin-ui-api/ui-devkit/admin-ui-extension#adminuiextensionlazymodule)One or more Angular modules which extend the default Admin UI.

### providers​


[​](#providers)Defines the paths to a file that exports an array of shared providers such as nav menu items, custom form inputs,
custom detail components, action bar items, custom history entry components.

### routes​


[​](#routes)[UiExtensionRouteDefinition](/reference/admin-ui-api/ui-devkit/admin-ui-extension#uiextensionroutedefinition)Defines routes that will be lazy-loaded at the /extensions/ route. The filePath should point to a file
relative to the extensionPath which exports an array of Angular route definitions.

### pathAlias​


[​](#pathalias)An optional alias for the module so it can be referenced by other UI extension modules.

By default, Angular modules declared in an AdminUiExtension do not have access to code outside the directory
defined by the extensionPath. A scenario in which that can be useful though is in a monorepo codebase where
a common NgModule is shared across different plugins, each defined in its own package. An example can be found
below - note that the main tsconfig.json also maps the target module but using a path relative to the project's
root folder. The UI module is not part of the main TypeScript build task as explained in
Extending the Admin UI but having paths
properly configured helps with usual IDE code editing features such as code completion and quick navigation, as
well as linting.

[Extending the Admin UI](https://www.vendure.io/docs/plugins/extending-the-admin-ui/)Example

```
import { NgModule } from '@angular/core';import { SharedModule } from '@vendure/admin-ui/core';import { CommonUiComponent } from './components/common-ui/common-ui.component';export { CommonUiComponent };@NgModule({ imports: [SharedModule], exports: [CommonUiComponent], declarations: [CommonUiComponent],})export class CommonSharedUiModule {}
```

```
import path from 'path';import { AdminUiExtension } from '@vendure/ui-devkit/compiler';export const uiExtensions: AdminUiExtension = {  pathAlias: '@common-ui-module',     // this is the important part  extensionPath: path.join(__dirname, 'ui'),  ngModules: [    {      type: 'shared' as const,      ngModuleFileName: 'ui-shared.module.ts',      ngModuleName: 'CommonSharedUiModule',    },  ],};
```

```
{  "compilerOptions": {    "baseUrl": ".",    "paths": {      "@common-ui-module/*": ["packages/common-ui-module/src/ui/*"]    }  }}
```

```
import { NgModule } from '@angular/core';import { SharedModule } from '@vendure/admin-ui/core';// the import below works both in the context of the custom Admin UI app as well as the main project// '@common-ui-module' is the value of "pathAlias" and 'ui-shared.module' is the file we want to reference inside "extensionPath"import { CommonSharedUiModule, CommonUiComponent } from '@common-ui-module/ui-shared.module';@NgModule({  imports: [    SharedModule,    CommonSharedUiModule,    RouterModule.forChild([      {        path: '',        pathMatch: 'full',        component: CommonUiComponent,      },    ]),  ],})export class SampleUiExtensionModule {}
```

### exclude​


[​](#exclude)Optional array specifying filenames or glob patterns that should
be skipped when copying the directory defined by extensionPath.

[glob](https://github.com/isaacs/node-glob)Example

```
exclude: ['**/*.spec.ts']
```

## TranslationExtension​


[​](#translationextension)[@vendure/ui-devkit](https://www.npmjs.com/package/@vendure/ui-devkit)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/ui-devkit/src/compiler/types.ts#L18)Defines extensions to the Admin UI translations. Can be used as a stand-alone extension definition which only adds translations
without adding new UI functionality, or as part of a full AdminUiExtension.

[AdminUiExtension](/reference/admin-ui-api/ui-devkit/admin-ui-extension#adminuiextension)
```
interface TranslationExtension {    translations: { [languageCode in LanguageCode]?: string };}
```

### translations​


[​](#translations)[LanguageCode](/reference/typescript-api/common/language-code#languagecode)Optional object defining any translation files for the Admin UI. The value should be an object with
the key as a 2-character ISO 639-1 language code,
and the value being a glob for any relevant
translation files in JSON format.

[ISO 639-1 language code](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes)[glob](https://github.com/isaacs/node-glob)Example

```
translations: {  en: path.join(__dirname, 'translations/*.en.json'),  de: path.join(__dirname, 'translations/*.de.json'),}
```

## StaticAssetExtension​


[​](#staticassetextension)[@vendure/ui-devkit](https://www.npmjs.com/package/@vendure/ui-devkit)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/ui-devkit/src/compiler/types.ts#L44)Defines extensions which copy static assets to the custom Admin UI application source asset directory.

```
interface StaticAssetExtension {    staticAssets: StaticAssetDefinition[];}
```

### staticAssets​


[​](#staticassets)[StaticAssetDefinition](/reference/admin-ui-api/ui-devkit/admin-ui-extension#staticassetdefinition)Optional array of paths to static assets which will be copied over to the Admin UI app's /static
directory.

## GlobalStylesExtension​


[​](#globalstylesextension)[@vendure/ui-devkit](https://www.npmjs.com/package/@vendure/ui-devkit)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/ui-devkit/src/compiler/types.ts#L60)Defines extensions which add global styles to the custom Admin UI application.

```
interface GlobalStylesExtension {    globalStyles: string[] | string;}
```

### globalStyles​


[​](#globalstyles)Specifies a path (or array of paths) to global style files (css or Sass) which will be
incorporated into the Admin UI app global stylesheet.

## SassVariableOverridesExtension​


[​](#sassvariableoverridesextension)[@vendure/ui-devkit](https://www.npmjs.com/package/@vendure/ui-devkit)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/ui-devkit/src/compiler/types.ts#L76)Defines an extension which allows overriding Clarity Design System's Sass variables used in styles on the Admin UI.

```
interface SassVariableOverridesExtension {    sassVariableOverrides: string;}
```

### sassVariableOverrides​


[​](#sassvariableoverrides)Specifies a path to a Sass style file containing variable declarations, which will take precedence over
default values defined in Clarity.

## UiExtensionRouteDefinition​


[​](#uiextensionroutedefinition)[@vendure/ui-devkit](https://www.npmjs.com/package/@vendure/ui-devkit)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/ui-devkit/src/compiler/types.ts#L92)Defines a route which will be added to the Admin UI application.

```
interface UiExtensionRouteDefinition {    route: string;    filePath: string;    prefix?: string;}
```

### route​


[​](#route)The name of the route. This will be used as the path in the URL.

### filePath​


[​](#filepath)The path to the file which exports an array of Angular route definitions.

### prefix​


[​](#prefix)All extensions will be mounted under the /extensions/ route. This option allows you to specify a
custom prefix rather than /extensions/. For example, setting this to custom would cause the extension
to be mounted at /custom/<route> instead.

A common use case for this is to mount the extension at the root of the Admin UI, by setting this to an empty string.
This is useful when the extension is intended to replace the default Admin UI, rather than extend it.

## StaticAssetDefinition​


[​](#staticassetdefinition)[@vendure/ui-devkit](https://www.npmjs.com/package/@vendure/ui-devkit)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/ui-devkit/src/compiler/types.ts#L280)A static asset can be provided as a path to the asset, or as an object containing a path and a new
name, which will cause the compiler to copy and then rename the asset.

```
type StaticAssetDefinition = string | { path: string; rename: string }
```

## AdminUiExtensionSharedModule​


[​](#adminuiextensionsharedmodule)[@vendure/ui-devkit](https://www.npmjs.com/package/@vendure/ui-devkit)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/ui-devkit/src/compiler/types.ts#L289)Configuration defining a single NgModule with which to extend the Admin UI.

```
interface AdminUiExtensionSharedModule {    type: 'shared';    ngModuleFileName: string;    ngModuleName: string;}
```

### type​


[​](#type)Shared modules are directly imported into the main AppModule of the Admin UI
and should be used to declare custom form components and define custom
navigation items.

### ngModuleFileName​


[​](#ngmodulefilename)The name of the file containing the extension module class.

### ngModuleName​


[​](#ngmodulename)The name of the extension module class.

## AdminUiExtensionLazyModule​


[​](#adminuiextensionlazymodule)[@vendure/ui-devkit](https://www.npmjs.com/package/@vendure/ui-devkit)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/ui-devkit/src/compiler/types.ts#L316)Configuration defining a single NgModule with which to extend the Admin UI.

```
interface AdminUiExtensionLazyModule {    type: 'lazy';    route: string;    ngModuleFileName: string;    ngModuleName: string;}
```

### type​


[​](#type-1)Lazy modules are lazy-loaded at the /extensions/ route and should be used for
modules which define new views for the Admin UI.

### route​


[​](#route-1)The route specifies the route at which the module will be lazy-loaded. E.g. a value
of 'foo' will cause the module to lazy-load when the /extensions/foo route
is activated.

### ngModuleFileName​


[​](#ngmodulefilename-1)The name of the file containing the extension module class.

### ngModuleName​


[​](#ngmodulename-1)The name of the extension module class.


---

# CompileUiExtensions


## compileUiExtensions​


[​](#compileuiextensions)[@vendure/ui-devkit](https://www.npmjs.com/package/@vendure/ui-devkit)[compile.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/ui-devkit/src/compiler/compile.ts#L36)Compiles the Admin UI app with the specified extensions.

```
function compileUiExtensions(options: UiExtensionCompilerOptions): AdminUiAppConfig | AdminUiAppDevModeConfig
```

Parameters

### options​


[​](#options)[UiExtensionCompilerOptions](/reference/admin-ui-api/ui-devkit/ui-extension-compiler-options#uiextensioncompileroptions)


---

# Helpers


## setBranding​


[​](#setbranding)[@vendure/ui-devkit](https://www.npmjs.com/package/@vendure/ui-devkit)[helpers.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/ui-devkit/src/compiler/helpers.ts#L26)A helper function to simplify the process of setting custom branding images.

Example

```
compileUiExtensions({  outputPath: path.join(__dirname, '../admin-ui'),  extensions: [    setBranding({      // This is used as the branding in the top-left above the navigation      smallLogoPath: path.join(__dirname, 'images/my-logo-sm.png'),      // This is used on the login page      largeLogoPath: path.join(__dirname, 'images/my-logo-lg.png'),      faviconPath: path.join(__dirname, 'images/my-favicon.ico'),    }),  ],});
```

```
function setBranding(options: BrandingOptions): StaticAssetExtension
```

Parameters

### options​


[​](#options)


---

# UiDevkitClient


## setTargetOrigin​


[​](#settargetorigin)[@vendure/ui-devkit](https://www.npmjs.com/package/@vendure/ui-devkit)[devkit-client-api.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/ui-devkit/src/client/devkit-client-api.ts#L24)Set the window.postMessage API
targetOrigin. The Vendure ui-devkit uses the postMessage API to
enable cross-frame and cross-origin communication between the ui extension code and the Admin UI
app. The targetOrigin is a security feature intended to provide control over where messages are sent.

[window.postMessage API](https://developer.mozilla.org/en-US/docs/Web/API/Window/postMessage)
```
function setTargetOrigin(value: string): void
```

Parameters

### value​


[​](#value)
## getActivatedRoute​


[​](#getactivatedroute)[@vendure/ui-devkit](https://www.npmjs.com/package/@vendure/ui-devkit)[devkit-client-api.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/ui-devkit/src/client/devkit-client-api.ts#L43)Retrieves information about the current route of the host application, since it is not possible
to otherwise get this information from within the child iframe.

Example

```
import { getActivatedRoute } from '@vendure/ui-devkit';const route = await getActivatedRoute();const slug = route.params.slug;
```

```
function getActivatedRoute(): Promise<ActiveRouteData>
```

## graphQlQuery​


[​](#graphqlquery)[@vendure/ui-devkit](https://www.npmjs.com/package/@vendure/ui-devkit)[devkit-client-api.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/ui-devkit/src/client/devkit-client-api.ts#L70)Perform a GraphQL query and returns either an Observable or a Promise of the result.

Example

```
import { graphQlQuery } from '@vendure/ui-devkit';const productList = await graphQlQuery(`  query GetProducts($skip: Int, $take: Int) {      products(options: { skip: $skip, take: $take }) {          items { id, name, enabled },          totalItems      }  }`, {    skip: 0,    take: 10,  }).then(data => data.products);
```

```
function graphQlQuery<T, V extends { [key: string]: any }>(document: string, variables?: { [key: string]: any }, fetchPolicy?: WatchQueryFetchPolicy): {    then: Promise<T>['then'];    stream: Observable<T>;}
```

Parameters

### document​


[​](#document)
### variables​


[​](#variables)
### fetchPolicy​


[​](#fetchpolicy)
## graphQlMutation​


[​](#graphqlmutation)[@vendure/ui-devkit](https://www.npmjs.com/package/@vendure/ui-devkit)[devkit-client-api.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/ui-devkit/src/client/devkit-client-api.ts#L112)Perform a GraphQL mutation and returns either an Observable or a Promise of the result.

Example

```
import { graphQlMutation } from '@vendure/ui-devkit';const disableProduct = (id: string) => {  return graphQlMutation(`    mutation DisableProduct($id: ID!) {      updateProduct(input: { id: $id, enabled: false }) {        id        enabled      }    }`, { id })    .then(data => data.updateProduct)}
```

```
function graphQlMutation<T, V extends { [key: string]: any }>(document: string, variables?: { [key: string]: any }): {    then: Promise<T>['then'];    stream: Observable<T>;}
```

Parameters

### document​


[​](#document-1)
### variables​


[​](#variables-1)
## notify​


[​](#notify)[@vendure/ui-devkit](https://www.npmjs.com/package/@vendure/ui-devkit)[devkit-client-api.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/ui-devkit/src/client/devkit-client-api.ts#L147)Display a toast notification.

Example

```
import { notify } from '@vendure/ui-devkit';notify({  message: 'Updated Product',  type: 'success'});
```

```
function notify(options: NotificationMessage['data']): void
```

Parameters

### options​


[​](#options)


---

# UiExtensionBuildCommand


## UiExtensionBuildCommand​


[​](#uiextensionbuildcommand)[@vendure/ui-devkit](https://www.npmjs.com/package/@vendure/ui-devkit)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/ui-devkit/src/compiler/types.ts#L356)The package manager to use when invoking the Angular CLI to build UI extensions.

```
type UiExtensionBuildCommand = 'npm' | 'yarn' | 'pnpm'
```


---

# UiExtensionCompilerOptions


## UiExtensionCompilerOptions​


[​](#uiextensioncompileroptions)[@vendure/ui-devkit](https://www.npmjs.com/package/@vendure/ui-devkit)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/ui-devkit/src/compiler/types.ts#L364)Options to configure how the Admin UI should be compiled.

```
interface UiExtensionCompilerOptions {    outputPath: string;    extensions: Extension[];    ngCompilerPath?: string | undefined;    devMode?: boolean;    baseHref?: string;    watchPort?: number;    command?: UiExtensionBuildCommand;    additionalProcessArguments?: UiExtensionCompilerProcessArgument[];}
```

### outputPath​


[​](#outputpath)The directory into which the sources for the extended Admin UI will be copied.

### extensions​


[​](#extensions)An array of objects which configure Angular modules and/or
translations with which to extend the Admin UI.

### ngCompilerPath​


[​](#ngcompilerpath)Allows you to manually specify the path to the Angular CLI compiler script. This can be useful in scenarios
where for some reason the built-in start/build scripts are unable to locate the ng command.

This option should not usually be required.

Example

```
compileUiExtensions({    ngCompilerPath: path.join(__dirname, '../../node_modules/@angular/cli/bin/ng.js'),    outputPath: path.join(__dirname, '../admin-ui'),    extensions: [      // ...    ],})
```

### devMode​


[​](#devmode)Set to true in order to compile the Admin UI in development mode (using the Angular CLI
ng serve command). When in dev mode, any changes to
UI extension files will be watched and trigger a rebuild of the Admin UI with live
reloading.

[ng serve](https://angular.io/cli/serve)
### baseHref​


[​](#basehref)Allows the baseHref of the compiled Admin UI app to be set. This determines the prefix
of the app, for example with the default value of '/admin/', the Admin UI app
will be configured to be served from http://<host>/admin/.

Note: if you are using this in conjunction with the AdminUiPlugin then you should
also set the route option to match this value.

[AdminUiPlugin](/reference/core-plugins/admin-ui-plugin/#adminuiplugin)Example

```
AdminUiPlugin.init({  route: 'my-route',  port: 5001,  app: compileUiExtensions({    baseHref: '/my-route/',    outputPath: path.join(__dirname, './custom-admin-ui'),    extensions: [],    devMode: true,  }),}),
```

### watchPort​


[​](#watchport)In watch mode, allows the port of the dev server to be specified. Defaults to the Angular CLI default
of 4200.

### command​


[​](#command)[UiExtensionBuildCommand](/reference/admin-ui-api/ui-devkit/ui-extension-build-command#uiextensionbuildcommand)Internally, the Angular CLI will be invoked as an npm script. By default, the compiler will use Yarn
to run the script if it is detected, otherwise it will use npm. This setting allows you to explicitly
set which command to use, including pnpm, rather than relying on the default behavior.

### additionalProcessArguments​


[​](#additionalprocessarguments)[UiExtensionCompilerProcessArgument](/reference/admin-ui-api/ui-devkit/ui-extension-compiler-process-argument#uiextensioncompilerprocessargument)Additional command-line arguments which will get passed to the ng build
command (or ng serve if devMode = true).

[ng build](https://angular.io/cli/build)[ng serve](https://angular.io/cli/serve)Example

['--disable-host-check'] // to disable host check


---

# UiExtensionCompilerProcessArgument


## UiExtensionCompilerProcessArgument​


[​](#uiextensioncompilerprocessargument)[@vendure/ui-devkit](https://www.npmjs.com/package/@vendure/ui-devkit)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/ui-devkit/src/compiler/types.ts#L348)Argument to configure process (watch or compile)

```
type UiExtensionCompilerProcessArgument = string | [string, any]
```

