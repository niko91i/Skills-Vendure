# Vendure User Guide


This section is for store owners and staff who are charged with running a Vendure-based store.

This guide assumes that your Vendure instance is running the AdminUiPlugin.

We will roughly structure this guide to conform to the default layout of the Admin UI main navigation menu.


---

# Collections


Collections allow you to group ProductVariants together by various criteria. A typical use of Collections is to create a hierarchical category tree which can be used in a navigation menu in your storefront.

## Populating Collections​


[​](#populating-collections)Collections are dynamic, which means that you define a set of rules, and Vendure will automatically populate the Collection with ProductVariants according to those rules.

The rules are defined by filters. A Collection can define multiple filters, for example:

- Include all ProductVariants with a certain FacetValue
- Include all ProductVariants whose name includes the word "sale"

## Nesting Collections​


[​](#nesting-collections)Collections can be nested inside one another, as many levels deep as needed.

When populating a nested Collection, its own filters plus the filters of all Collections above it are used to calculate the contents.

## Public vs Private Collections​


[​](#public-vs-private-collections)A Collection can be made private, meaning that it will not be available in the storefront. This can be useful when you need to organize your inventory for internal purposes.

---

# Facets


Facets are the primary means to attach structured data to your Products & ProductVariants. Typical uses of Facets include:

- Enabling faceted search & filtering in the storefront
- Organizing Products into Collections
- Labelling Products for inclusion in Promotions

A Facet has one or more FacetValues, for example:

- Facet: "Brand"
- Values: "Apple", "Logitech", "Sony", "LG" ...

## Assigning to Products & Variants​


[​](#assigning-to-products--variants)In the Product detail page, you can assign FacetValues by clicking the ADD FACETS button toward the bottom of the Product or ProductVariant views.

## Public vs Private Facets​


[​](#public-vs-private-facets)The visibility of a Facet can be set to either public or private.

- Public facets are visible via the Shop API, meaning they can be listed in the storefront and used for faceted searches.
- Private facets are only visible to Administrators, and cannot be used in storefront faceted searches.

Private facets can be useful for labelling Products for internal use. For example, you could create a "profit margin" Facet with "high" and "low" values. You wouldn't want to display these in the storefront, but you may want to use them e.g. in Promotion logic.


---

# Products


Products represent the items you want to sell to your customers.

## Products vs ProductVariants​


[​](#products-vs-productvariants)In Vendure, every Product has one or more ProductVariants. You can think of a Product as a "container" which houses the variants:

In the diagram above you'll notice that it is the ProductVariants which have an SKU (stock-keeping unit: a unique product code) and a price.

Products provide the overall name, description, slug, images. A product does not have a price, sku, or stock level.

ProductVariants have a price, sku, stock level, tax settings. They are the actual things that get added to orders and purchased.

## Tracking Inventory​


[​](#tracking-inventory)Vendure can track the stock levels of each of your ProductVariants. This is done by setting the "track inventory" option to "track" (or "inherit from global settings" if the global setting is set to track).

[global setting](/user-guide/settings/global-settings)When tracking inventory:

- When a customer checks out, the contents of the order will be "allocated". This means that the stock has not yet been sold, but it is no longer available to purchase (no longer saleable).
- Once a Fulfillment has been created (see the Orders section), those allocated items will be converted into sales, meaning the stock level will be lowered by the corresponding quantity.
- If a customer attempts to add more of a ProductVariant than are currently saleable, they will encounter an error.

### Back orders​


[​](#back-orders)Back orders can be enabled by setting a negative value as the "Out-of-stock threshold". This can be done via global settings or on a per-variant basis.

[global settings](/user-guide/settings/global-settings)


---

# Draft Orders


Draft Orders are used when an Administrator would like to manually create an order via the Admin UI. For example, this can be useful when:

- A customer phones up to place an order
- A customer wants to place an order in person
- You want to create an order on behalf of a customer, e.g. for a quote.
- When testing Promotions

To create a Draft Order, click the "Create draft order" button from the Order List view.

From there you can:

- Add ProductVariants to the Order using the search input marked "Add item to order"
- Optionally activate coupon codes to trigger Promotions
- Set the customer, shipping and billing addresses
- Select the shipping method

Once ready, click the "Complete draft" button to convert this Order from a Draft into a regular Order. At this stage the order can be paid for, and you can manually record the payment details.

Note: Draft Orders do not appear in a Customer's order history in the storefront (Shop API) while still
in the "Draft" state.


---

# Orders


An Order is created whenever someone adds an item to their cart in the storefront. In Vendure, there is no distinction between a "cart" and an "order". Thus a "cart" is just an Order which has not yet passed through the checkout process.

## The Order Workflow​


[​](#the-order-workflow)The exact set of stages that an Order goes through can be customized in Vendure to suit your particular business needs, but we can look at the default steps to get a good idea of the typical workflow:

When a new Order arrives, you would:

- Settle the payment if not already done (this may or may not be needed depending on the way your payment provider is configured).
- Create a Fulfillment by clicking the "Fulfill Order" button in the top-right of the order detail page. A Fulfillment represents the physical package which will be sent to the customer. You may split up your order into multiple Fulfillments, if that makes sense from a logistical point of view.
- Mark the Fulfillment as "shipped" once the physical package leaves your warehouse.
- Mark the Fulfillment as "delivered" once you have notice of the package arriving with the customer.

## Refunds​


[​](#refunds)You can refund one or more items from an Order by clicking this menu item, which is available once the payments are settled:

This will bring up a dialog which allows you to select which items to refund, as well as whether to refund shipping. You can also make an arbitrary adjustment to the refund amount if needed.

A Refund is then made against the payment method used in that order. Some payment methods will handle refunds automatically, and others will expect you to perform the refund manually in your payment provider's admin interface, and then record the fact manually.

## Cancellation​


[​](#cancellation)One or more items may also be cancelled in a similar way to how refunds are handled. Performing a cancellation will return the selected items back into stock.

Cancellations and refunds are often done together, but do not have to be. For example, you may refund a faulty item without requiring the customer to return it. This would be a pure refund.

## Modifying an Order​


[​](#modifying-an-order)An Order can be modified after checkout is completed.

Modification allows you to:

- Alter the quantities of any items in the order
- Remove items from the order
- Add new items to the order
- Add arbitrary surcharges or discounts
- Alter the shipping & billing address

Once you have made the desired modifications, you preview the changes including the price difference.

If the modifications have resulted in an increased price (as in the above example), the Order will then be set into the "Arranging additional payment" state. This allows you to process another payment from the customer to make up the price difference.

On the other hand, if the new price is less than what was originally paid (e.g. if the quantity is decreased), then a Refund will be generated against the payment method used.


---

# Customers


A Customer is anybody who has:

- Placed an order
- Registered an account

The Customers section allows you to view and search for your customers. Clicking "edit" in the list view brings up the detail view, allowing you to edit the customer details and view orders and history.

## Guest, Registered, Verified​


[​](#guest-registered-verified)- Guest: Vendure allows "guest checkouts", which means people may place orders without needing to register an account with the storefront.
- Registered: When a customer registers for an account (using their email address by default), they are assigned this status.
- Verified: A registered customer becomes verified once they have been able to confirm ownership of their email account. Note that if alternative authentication methods are set up on your store (e.g. Facebook login), then this workflow might be slightly different.

## Customer Groups​


[​](#customer-groups)Customer Groups can be used for things like:

- Grouping wholesale customers so that alternative tax calculations may be applied
- Grouping members of a loyalty scheme for access to exclusive Promotions
- Segmenting customers for other marketing purposes


---

# Promotions


Promotions are a means of offering discounts on an order based on various criteria. A Promotion consists of conditions and actions.

- conditions are the rules which determine whether the Promotion should be applied to the order.
- actions specify exactly how this Promotion should modify the order.

## Promotion Conditions​


[​](#promotion-conditions)A condition defines the criteria that must be met for the Promotion to be activated. Vendure comes with some simple conditions provided which enable things like:

- If the order total is at least $X
- Buy at least X of a certain product
- Buy at least X of any product with the specified FacetValues
- If the customer is a member of the specified Customer Group

[FacetValues](/user-guide/catalog/facets)[Customer Group](/user-guide/customers#customer-groups)Vendure allows completely custom conditions to be defined by your developers, implementing the specific logic needed by your business.

## Coupon codes​


[​](#coupon-codes)A coupon code can be any text which will activate a Promotion. A coupon code can be used in conjunction with conditions if desired.

Note: Promotions must have either a coupon code or at least 1 condition defined.

## Promotion Actions​


[​](#promotion-actions)If all the defined conditions pass (or if the specified coupon code is used), then the actions are performed on the order. Vendure comes with some commonly-used actions which allow promotions like:

- Discount the whole order by a fixed amount
- Discount the whole order by a percentage
- Discount selected products by a percentage
- Free shipping

## Coupon code per-customer limit​


[​](#coupon-code-per-customer-limit)If a per-customer limit is specified, then the specified coupon code may only be used that many times by a single Customer. For guest checkouts, the "same customer" status is determined by the email address used when checking out.


---

# Administrators & Roles


An administrator is a staff member who has access to the Admin UI, and is able to view and modify some or all of the items and settings.

The exact permissions of what a given administrator may view and modify is defined by which roles are assigned to that administrator.

## Defining a Role​


[​](#defining-a-role)The role detail page allows you to create a new role or edit an existing one. A role can be thought of as a list of permissions. Permissions are usually divided into four types:

- Create allows you to create new items, e.g. "CreateProduct" will allow one to create a new product.
- Read allows you to view items, but not modify or delete them.
- Update allows you to make changes to existing items, but not to create new ones.
- Delete allows you to delete items.

Vendure comes with a few pre-defined roles for commonly-needed tasks, but you are free to modify these or create your own.

In general, it is advisable to create roles with the fewest amount of privileges needed for the staff member to do their jobs. For example, a marketing manager would need to be able to create, read, update and delete promotions, but probably doesn't need to be able to update or delete payment methods.

### The SuperAdmin role​


[​](#the-superadmin-role)This is a special role which cannot be deleted or modified. This role grants all permissions and is used to set up the store initially, and make certain special changes (such as creating new Channels).

## Creating Administrators​


[​](#creating-administrators)For each individual that needs to log in to the Admin UI, you should create a new administrator account.

Apart from filling in their details and selecting a strong password, you then need to assign at least one role. Roles "add together", meaning that when more than one role is assigned, the combined set of permissions of all assigned roles is granted to that administrator.

Thus, it is possible to create a set of specific roles "Inventory Manager", "Order Manager", "Customer Services", "Marketing Manager", and compose them together as needed.


---

# Channels


Channels allow you to split your store into multiple sub-stores, each of which can have its own selection of inventory, customers, orders, shipping methods etc.

There are various reasons why you might want to do this:

- Creating distinct stores for different countries, each with country-specific pricing, shipping and payment rules.
- Implementing a multi-tenant application where many merchants have their own store, each confined to its own channel.
- Implementing a marketplace where each seller has their own channel.

Each channel defines some basic default settings - currency, language, tax options.

There is always a default channel - this is the "root" channel which contains everything, and any sub-channels can then contain a subset of the contents of the default channel.


---

# Countries & Zones


Countries are where you define the list of countries which are relevant to your operations. This does not only include those countries you ship to, but also those countries which may appear on a billing address.

By default, Vendure includes all countries in the list, but you are free to remove or disable any that you don't need.

Zones provide a way to group countries. Zones are used mainly for defining tax rates and can also be used in shipping calculations.

[tax rates](/user-guide/settings/taxes)


---

# Global Settings


The global settings allow you to define certain configurations that affect all channels.

- Available languages defines which languages you wish to make available for translations. When more than one language has been enabled, you will see the language switcher appear when viewing translatable objects such as products, collections, facets and shipping methods.
- Global out-of-stock threshold sets the stock level at which a product variant is considered to be out of stock. Using a negative value enables backorder support. This setting can be overridden by individual product variants (see the tracking inventory guide).
- Track inventory by default sets whether stock levels should be tracked. This setting can be overridden by individual product variants (see the tracking inventory guide).

[tracking inventory](/user-guide/catalog/products#tracking-inventory)[tracking inventory](/user-guide/catalog/products#tracking-inventory)


---

# Payment Methods


Payment methods define how your storefront handles payments. Your storefront may offer multiple payment methods or just one.

A Payment method consists of two parts: an eligibility checker and a handler

## Payment eligibility checker​


[​](#payment-eligibility-checker)This is an optional part which can be useful in certain situations where you want to limit a payment method based on things like:

- Billing address
- Order contents or total price
- Customer group

Since these requirements are particular to your business needs, Vendure does not provide any built-in checkers, but your developers can create one to suit your requirements.

## Payment handler​


[​](#payment-handler)The payment handler contains the actual logic for processing a payment. Again, since there are many ways to handle payments, Vendure only provides a "dummy handler" by default and it is up to your developers to create integrations.

Payment handlers can be created which enable payment via:

- Popular payment services such as Stripe, Paypal, Braintree, Klarna etc
- Pay-on-delivery
- Store credit
- etc


---

# Shipping Methods


Shipping methods define:

- Whether an order is eligible for a particular shipping method
- How much the shipping should cost for a given order
- How the order will be fulfilled

Let's take a closer look at each of these parts:

## Shipping eligibility checker​


[​](#shipping-eligibility-checker)This is how we decide whether a particular shipping method may be applied to an order. This allows you to limit a particular shipping method based on things like:

- Minimum order amount
- Order weight
- Shipping destination
- Particular contents of the order
- etc.

By default, Vendure comes with a checker which can impose a minimum order amount. To implement more complex checks, your developers are able to create custom checkers to suit your requirements.

## Shipping calculator​


[​](#shipping-calculator)The calculator is used to determine how much to charge for shipping an order. Calculators can be written to implement things like:

- Determining shipping based on a 3rd-party service such as Shippo
- Looking up prices from data supplied by couriers
- Flat-rate shipping

By default, Vendure comes with a simple flat-rate shipping calculator. Your developers can create more sophisticated integrations according to your business requirements.

## Fulfillment handler​


[​](#fulfillment-handler)By "fulfillment" we mean how we physically get the goods into the hands of the customer. Common fulfillment methods include:

- Courier services such as FedEx, DPD, DHL, etc.
- Collection by customer
- Delivery via email for digital goods or licenses

By default, Vendure comes with a "manual fulfillment handler", which allows you to manually enter the details of whatever actual method is used. For example, if you send the order by courier, you can enter the courier name and parcel number manually when creating an order.

Your developers can however create much more sophisticated fulfillment handlers, which can enable things like automated calls to courier APIs, automated label generation, and so on.

## Testing a Shipping Method​


[​](#testing-a-shipping-method)At the bottom of the shipping method detail page you can test the current method by creating a fake order and shipping address and testing a) whether this method would be eligible, and b) how much it would cost.

Additionally, on the shipping method list page you can test all shipping methods at once.


---

# Taxes


Taxes represent extra charges on top of the base price of a product. There are various forms of taxes that might be applicable, depending on local laws and the laws of the regions that your business serves. Common forms of applicable taxes are:

- Value added tax (VAT)
- Goods and services tax (GST)
- Sales taxes (as in the USA)

## Tax Category​


[​](#tax-category)In Vendure every product variant is assigned a tax category. In many countries, different rates of tax apply depending on the type of product being sold.

For example, in the UK there are three rates of VAT:

- Standard rate (20%)
- Reduced rate (5%)
- Zero rate (0%)

Most types of products would fall into the "standard rate" category, but for instance books are classified as "zero rate".

## Tax Rate​


[​](#tax-rate)Tax rates set the rate of tax for a given tax category destined for a particular zone. They are used by default in Vendure when calculating all taxes.

## Tax Compliance​


[​](#tax-compliance)Please note that tax compliance is a complex topic that varies significantly between countries. Vendure does not (and cannot) offer a complete out-of-the-box tax solution which is guaranteed to be compliant with your use-case. What we strive to do is to provide a very flexible set of tools that your developers can use to tailor tax calculations exactly to your needs. These are covered in the Developer's guide to taxes.

[Developer's guide to taxes](/guides/core-concepts/taxes/)