# Enums


## AdjustmentType​


[​](#adjustmenttype)
## AssetType​


[​](#assettype)
## CurrencyCode​


[​](#currencycode)
## DeletionResult​


[​](#deletionresult)
## ErrorCode​


[​](#errorcode)
## GlobalFlag​


[​](#globalflag)
## HistoryEntryType​


[​](#historyentrytype)
## JobState​


[​](#jobstate)
## LanguageCode​


[​](#languagecode)[Unicode CLDR summary list](https://unicode-org.github.io/cldr-staging/charts/37/summary/root.html)
## LogicalOperator​


[​](#logicaloperator)
## MetricInterval​


[​](#metricinterval)
## MetricType​


[​](#metrictype)
## OrderType​


[​](#ordertype)
## Permission​


[​](#permission)
## SortOrder​


[​](#sortorder)
## StockMovementType​


[​](#stockmovementtype)


---

# Input Objects


## AddItemInput​


[​](#additeminput)[ID](/reference/graphql-api/admin/object-types#id)[Int](/reference/graphql-api/admin/object-types#int)
## AddItemToDraftOrderInput​


[​](#additemtodraftorderinput)[ID](/reference/graphql-api/admin/object-types#id)[Int](/reference/graphql-api/admin/object-types#int)
## AddNoteToCustomerInput​


[​](#addnotetocustomerinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)
## AddNoteToOrderInput​


[​](#addnotetoorderinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)
## AdjustDraftOrderLineInput​


[​](#adjustdraftorderlineinput)[ID](/reference/graphql-api/admin/object-types#id)[Int](/reference/graphql-api/admin/object-types#int)
## AdministratorFilterParameter​


[​](#administratorfilterparameter)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[AdministratorFilterParameter](/reference/graphql-api/admin/input-types#administratorfilterparameter)[AdministratorFilterParameter](/reference/graphql-api/admin/input-types#administratorfilterparameter)
## AdministratorListOptions​


[​](#administratorlistoptions)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[AdministratorSortParameter](/reference/graphql-api/admin/input-types#administratorsortparameter)[AdministratorFilterParameter](/reference/graphql-api/admin/input-types#administratorfilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## AdministratorPaymentInput​


[​](#administratorpaymentinput)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## AdministratorRefundInput​


[​](#administratorrefundinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[Money](/reference/graphql-api/admin/object-types#money)
## AdministratorSortParameter​


[​](#administratorsortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## AssetFilterParameter​


[​](#assetfilterparameter)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[NumberOperators](/reference/graphql-api/admin/input-types#numberoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[NumberOperators](/reference/graphql-api/admin/input-types#numberoperators)[NumberOperators](/reference/graphql-api/admin/input-types#numberoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[AssetFilterParameter](/reference/graphql-api/admin/input-types#assetfilterparameter)[AssetFilterParameter](/reference/graphql-api/admin/input-types#assetfilterparameter)
## AssetListOptions​


[​](#assetlistoptions)[String](/reference/graphql-api/admin/object-types#string)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[AssetSortParameter](/reference/graphql-api/admin/input-types#assetsortparameter)[AssetFilterParameter](/reference/graphql-api/admin/input-types#assetfilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## AssetSortParameter​


[​](#assetsortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## AssignAssetsToChannelInput​


[​](#assignassetstochannelinput)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)
## AssignCollectionsToChannelInput​


[​](#assigncollectionstochannelinput)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)
## AssignFacetsToChannelInput​


[​](#assignfacetstochannelinput)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)
## AssignPaymentMethodsToChannelInput​


[​](#assignpaymentmethodstochannelinput)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)
## AssignProductVariantsToChannelInput​


[​](#assignproductvariantstochannelinput)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[Float](/reference/graphql-api/admin/object-types#float)
## AssignProductsToChannelInput​


[​](#assignproductstochannelinput)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[Float](/reference/graphql-api/admin/object-types#float)
## AssignPromotionsToChannelInput​


[​](#assignpromotionstochannelinput)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)
## AssignShippingMethodsToChannelInput​


[​](#assignshippingmethodstochannelinput)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)
## AssignStockLocationsToChannelInput​


[​](#assignstocklocationstochannelinput)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)
## AuthenticationInput​


[​](#authenticationinput)[NativeAuthInput](/reference/graphql-api/admin/input-types#nativeauthinput)
## BooleanListOperators​


[​](#booleanlistoperators)[Boolean](/reference/graphql-api/admin/object-types#boolean)
## BooleanOperators​


[​](#booleanoperators)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)
## CancelOrderInput​


[​](#cancelorderinput)[ID](/reference/graphql-api/admin/object-types#id)[OrderLineInput](/reference/graphql-api/admin/input-types#orderlineinput)[Boolean](/reference/graphql-api/admin/object-types#boolean)[String](/reference/graphql-api/admin/object-types#string)
## ChannelFilterParameter​


[​](#channelfilterparameter)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[BooleanOperators](/reference/graphql-api/admin/input-types#booleanoperators)[NumberOperators](/reference/graphql-api/admin/input-types#numberoperators)[BooleanOperators](/reference/graphql-api/admin/input-types#booleanoperators)[ChannelFilterParameter](/reference/graphql-api/admin/input-types#channelfilterparameter)[ChannelFilterParameter](/reference/graphql-api/admin/input-types#channelfilterparameter)
## ChannelListOptions​


[​](#channellistoptions)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[ChannelSortParameter](/reference/graphql-api/admin/input-types#channelsortparameter)[ChannelFilterParameter](/reference/graphql-api/admin/input-types#channelfilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## ChannelSortParameter​


[​](#channelsortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## CollectionFilterParameter​


[​](#collectionfilterparameter)[BooleanOperators](/reference/graphql-api/admin/input-types#booleanoperators)[BooleanOperators](/reference/graphql-api/admin/input-types#booleanoperators)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[NumberOperators](/reference/graphql-api/admin/input-types#numberoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[CollectionFilterParameter](/reference/graphql-api/admin/input-types#collectionfilterparameter)[CollectionFilterParameter](/reference/graphql-api/admin/input-types#collectionfilterparameter)
## CollectionListOptions​


[​](#collectionlistoptions)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[CollectionSortParameter](/reference/graphql-api/admin/input-types#collectionsortparameter)[CollectionFilterParameter](/reference/graphql-api/admin/input-types#collectionfilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## CollectionSortParameter​


[​](#collectionsortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## ConfigArgInput​


[​](#configarginput)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## ConfigurableOperationInput​


[​](#configurableoperationinput)[String](/reference/graphql-api/admin/object-types#string)[ConfigArgInput](/reference/graphql-api/admin/input-types#configarginput)
## CoordinateInput​


[​](#coordinateinput)[Float](/reference/graphql-api/admin/object-types#float)[Float](/reference/graphql-api/admin/object-types#float)
## CountryFilterParameter​


[​](#countryfilterparameter)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[BooleanOperators](/reference/graphql-api/admin/input-types#booleanoperators)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[CountryFilterParameter](/reference/graphql-api/admin/input-types#countryfilterparameter)[CountryFilterParameter](/reference/graphql-api/admin/input-types#countryfilterparameter)
## CountryListOptions​


[​](#countrylistoptions)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[CountrySortParameter](/reference/graphql-api/admin/input-types#countrysortparameter)[CountryFilterParameter](/reference/graphql-api/admin/input-types#countryfilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## CountrySortParameter​


[​](#countrysortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## CountryTranslationInput​


[​](#countrytranslationinput)[ID](/reference/graphql-api/admin/object-types#id)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## CreateAddressInput​


[​](#createaddressinput)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[JSON](/reference/graphql-api/admin/object-types#json)
## CreateAdministratorInput​


[​](#createadministratorinput)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[ID](/reference/graphql-api/admin/object-types#id)[JSON](/reference/graphql-api/admin/object-types#json)
## CreateAssetInput​


[​](#createassetinput)[Upload](/reference/graphql-api/admin/object-types#upload)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## CreateChannelInput​


[​](#createchannelinput)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[Boolean](/reference/graphql-api/admin/object-types#boolean)[CurrencyCode](/reference/graphql-api/admin/enums#currencycode)[CurrencyCode](/reference/graphql-api/admin/enums#currencycode)[CurrencyCode](/reference/graphql-api/admin/enums#currencycode)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Int](/reference/graphql-api/admin/object-types#int)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[JSON](/reference/graphql-api/admin/object-types#json)
## CreateCollectionInput​


[​](#createcollectioninput)[Boolean](/reference/graphql-api/admin/object-types#boolean)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[Boolean](/reference/graphql-api/admin/object-types#boolean)[ConfigurableOperationInput](/reference/graphql-api/admin/input-types#configurableoperationinput)[CreateCollectionTranslationInput](/reference/graphql-api/admin/input-types#createcollectiontranslationinput)[JSON](/reference/graphql-api/admin/object-types#json)
## CreateCollectionTranslationInput​


[​](#createcollectiontranslationinput)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## CreateCountryInput​


[​](#createcountryinput)[String](/reference/graphql-api/admin/object-types#string)[CountryTranslationInput](/reference/graphql-api/admin/input-types#countrytranslationinput)[Boolean](/reference/graphql-api/admin/object-types#boolean)[JSON](/reference/graphql-api/admin/object-types#json)
## CreateCustomerGroupInput​


[​](#createcustomergroupinput)[String](/reference/graphql-api/admin/object-types#string)[ID](/reference/graphql-api/admin/object-types#id)[JSON](/reference/graphql-api/admin/object-types#json)
## CreateCustomerInput​


[​](#createcustomerinput)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## CreateFacetInput​


[​](#createfacetinput)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[FacetTranslationInput](/reference/graphql-api/admin/input-types#facettranslationinput)[CreateFacetValueWithFacetInput](/reference/graphql-api/admin/input-types#createfacetvaluewithfacetinput)[JSON](/reference/graphql-api/admin/object-types#json)
## CreateFacetValueInput​


[​](#createfacetvalueinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[FacetValueTranslationInput](/reference/graphql-api/admin/input-types#facetvaluetranslationinput)[JSON](/reference/graphql-api/admin/object-types#json)
## CreateFacetValueWithFacetInput​


[​](#createfacetvaluewithfacetinput)[String](/reference/graphql-api/admin/object-types#string)[FacetValueTranslationInput](/reference/graphql-api/admin/input-types#facetvaluetranslationinput)
## CreateGroupOptionInput​


[​](#creategroupoptioninput)[String](/reference/graphql-api/admin/object-types#string)[ProductOptionGroupTranslationInput](/reference/graphql-api/admin/input-types#productoptiongrouptranslationinput)
## CreatePaymentMethodInput​


[​](#createpaymentmethodinput)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[ConfigurableOperationInput](/reference/graphql-api/admin/input-types#configurableoperationinput)[ConfigurableOperationInput](/reference/graphql-api/admin/input-types#configurableoperationinput)[PaymentMethodTranslationInput](/reference/graphql-api/admin/input-types#paymentmethodtranslationinput)[JSON](/reference/graphql-api/admin/object-types#json)
## CreateProductInput​


[​](#createproductinput)[ID](/reference/graphql-api/admin/object-types#id)[Boolean](/reference/graphql-api/admin/object-types#boolean)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[ProductTranslationInput](/reference/graphql-api/admin/input-types#producttranslationinput)[JSON](/reference/graphql-api/admin/object-types#json)
## CreateProductOptionGroupInput​


[​](#createproductoptiongroupinput)[String](/reference/graphql-api/admin/object-types#string)[ProductOptionGroupTranslationInput](/reference/graphql-api/admin/input-types#productoptiongrouptranslationinput)[CreateGroupOptionInput](/reference/graphql-api/admin/input-types#creategroupoptioninput)[JSON](/reference/graphql-api/admin/object-types#json)
## CreateProductOptionInput​


[​](#createproductoptioninput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[ProductOptionGroupTranslationInput](/reference/graphql-api/admin/input-types#productoptiongrouptranslationinput)[JSON](/reference/graphql-api/admin/object-types#json)
## CreateProductVariantInput​


[​](#createproductvariantinput)[ID](/reference/graphql-api/admin/object-types#id)[Boolean](/reference/graphql-api/admin/object-types#boolean)[ProductVariantTranslationInput](/reference/graphql-api/admin/input-types#productvarianttranslationinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[Money](/reference/graphql-api/admin/object-types#money)[CreateProductVariantPriceInput](/reference/graphql-api/admin/input-types#createproductvariantpriceinput)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[Int](/reference/graphql-api/admin/object-types#int)[StockLevelInput](/reference/graphql-api/admin/input-types#stocklevelinput)[Int](/reference/graphql-api/admin/object-types#int)[Boolean](/reference/graphql-api/admin/object-types#boolean)[GlobalFlag](/reference/graphql-api/admin/enums#globalflag)[JSON](/reference/graphql-api/admin/object-types#json)
## CreateProductVariantOptionInput​


[​](#createproductvariantoptioninput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[ProductOptionTranslationInput](/reference/graphql-api/admin/input-types#productoptiontranslationinput)
## CreateProductVariantPriceInput​


[​](#createproductvariantpriceinput)[CurrencyCode](/reference/graphql-api/admin/enums#currencycode)[Money](/reference/graphql-api/admin/object-types#money)[JSON](/reference/graphql-api/admin/object-types#json)
## CreatePromotionInput​


[​](#createpromotioninput)[Boolean](/reference/graphql-api/admin/object-types#boolean)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[String](/reference/graphql-api/admin/object-types#string)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[ConfigurableOperationInput](/reference/graphql-api/admin/input-types#configurableoperationinput)[ConfigurableOperationInput](/reference/graphql-api/admin/input-types#configurableoperationinput)[PromotionTranslationInput](/reference/graphql-api/admin/input-types#promotiontranslationinput)[JSON](/reference/graphql-api/admin/object-types#json)
## CreateProvinceInput​


[​](#createprovinceinput)[String](/reference/graphql-api/admin/object-types#string)[ProvinceTranslationInput](/reference/graphql-api/admin/input-types#provincetranslationinput)[Boolean](/reference/graphql-api/admin/object-types#boolean)[JSON](/reference/graphql-api/admin/object-types#json)
## CreateRoleInput​


[​](#createroleinput)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Permission](/reference/graphql-api/admin/enums#permission)[ID](/reference/graphql-api/admin/object-types#id)
## CreateSellerInput​


[​](#createsellerinput)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## CreateShippingMethodInput​


[​](#createshippingmethodinput)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[ConfigurableOperationInput](/reference/graphql-api/admin/input-types#configurableoperationinput)[ConfigurableOperationInput](/reference/graphql-api/admin/input-types#configurableoperationinput)[ShippingMethodTranslationInput](/reference/graphql-api/admin/input-types#shippingmethodtranslationinput)[JSON](/reference/graphql-api/admin/object-types#json)
## CreateStockLocationInput​


[​](#createstocklocationinput)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## CreateTagInput​


[​](#createtaginput)[String](/reference/graphql-api/admin/object-types#string)
## CreateTaxCategoryInput​


[​](#createtaxcategoryinput)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[JSON](/reference/graphql-api/admin/object-types#json)
## CreateTaxRateInput​


[​](#createtaxrateinput)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Float](/reference/graphql-api/admin/object-types#float)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[JSON](/reference/graphql-api/admin/object-types#json)
## CreateZoneInput​


[​](#createzoneinput)[String](/reference/graphql-api/admin/object-types#string)[ID](/reference/graphql-api/admin/object-types#id)[JSON](/reference/graphql-api/admin/object-types#json)
## CustomerFilterParameter​


[​](#customerfilterparameter)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[CustomerFilterParameter](/reference/graphql-api/admin/input-types#customerfilterparameter)[CustomerFilterParameter](/reference/graphql-api/admin/input-types#customerfilterparameter)
## CustomerGroupFilterParameter​


[​](#customergroupfilterparameter)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[CustomerGroupFilterParameter](/reference/graphql-api/admin/input-types#customergroupfilterparameter)[CustomerGroupFilterParameter](/reference/graphql-api/admin/input-types#customergroupfilterparameter)
## CustomerGroupListOptions​


[​](#customergrouplistoptions)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[CustomerGroupSortParameter](/reference/graphql-api/admin/input-types#customergroupsortparameter)[CustomerGroupFilterParameter](/reference/graphql-api/admin/input-types#customergroupfilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## CustomerGroupSortParameter​


[​](#customergroupsortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## CustomerListOptions​


[​](#customerlistoptions)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[CustomerSortParameter](/reference/graphql-api/admin/input-types#customersortparameter)[CustomerFilterParameter](/reference/graphql-api/admin/input-types#customerfilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## CustomerSortParameter​


[​](#customersortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## DateListOperators​


[​](#datelistoperators)[DateTime](/reference/graphql-api/admin/object-types#datetime)
## DateOperators​


[​](#dateoperators)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateRange](/reference/graphql-api/admin/input-types#daterange)[Boolean](/reference/graphql-api/admin/object-types#boolean)
## DateRange​


[​](#daterange)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)
## DeleteAssetInput​


[​](#deleteassetinput)[ID](/reference/graphql-api/admin/object-types#id)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)
## DeleteAssetsInput​


[​](#deleteassetsinput)[ID](/reference/graphql-api/admin/object-types#id)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)
## DeleteStockLocationInput​


[​](#deletestocklocationinput)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)
## DuplicateEntityInput​


[​](#duplicateentityinput)[String](/reference/graphql-api/admin/object-types#string)[ID](/reference/graphql-api/admin/object-types#id)[ConfigurableOperationInput](/reference/graphql-api/admin/input-types#configurableoperationinput)
## FacetFilterParameter​


[​](#facetfilterparameter)[BooleanOperators](/reference/graphql-api/admin/input-types#booleanoperators)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[FacetFilterParameter](/reference/graphql-api/admin/input-types#facetfilterparameter)[FacetFilterParameter](/reference/graphql-api/admin/input-types#facetfilterparameter)
## FacetListOptions​


[​](#facetlistoptions)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[FacetSortParameter](/reference/graphql-api/admin/input-types#facetsortparameter)[FacetFilterParameter](/reference/graphql-api/admin/input-types#facetfilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## FacetSortParameter​


[​](#facetsortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## FacetTranslationInput​


[​](#facettranslationinput)[ID](/reference/graphql-api/admin/object-types#id)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## FacetValueFilterInput​


[​](#facetvaluefilterinput)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)
## FacetValueFilterParameter​


[​](#facetvaluefilterparameter)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[FacetValueFilterParameter](/reference/graphql-api/admin/input-types#facetvaluefilterparameter)[FacetValueFilterParameter](/reference/graphql-api/admin/input-types#facetvaluefilterparameter)
## FacetValueListOptions​


[​](#facetvaluelistoptions)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[FacetValueSortParameter](/reference/graphql-api/admin/input-types#facetvaluesortparameter)[FacetValueFilterParameter](/reference/graphql-api/admin/input-types#facetvaluefilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## FacetValueSortParameter​


[​](#facetvaluesortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## FacetValueTranslationInput​


[​](#facetvaluetranslationinput)[ID](/reference/graphql-api/admin/object-types#id)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## FulfillOrderInput​


[​](#fulfillorderinput)[OrderLineInput](/reference/graphql-api/admin/input-types#orderlineinput)[ConfigurableOperationInput](/reference/graphql-api/admin/input-types#configurableoperationinput)
## HistoryEntryFilterParameter​


[​](#historyentryfilterparameter)[BooleanOperators](/reference/graphql-api/admin/input-types#booleanoperators)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[HistoryEntryFilterParameter](/reference/graphql-api/admin/input-types#historyentryfilterparameter)[HistoryEntryFilterParameter](/reference/graphql-api/admin/input-types#historyentryfilterparameter)
## HistoryEntryListOptions​


[​](#historyentrylistoptions)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[HistoryEntrySortParameter](/reference/graphql-api/admin/input-types#historyentrysortparameter)[HistoryEntryFilterParameter](/reference/graphql-api/admin/input-types#historyentryfilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## HistoryEntrySortParameter​


[​](#historyentrysortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## IDListOperators​


[​](#idlistoperators)[ID](/reference/graphql-api/admin/object-types#id)
## IDOperators​


[​](#idoperators)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)
## JobFilterParameter​


[​](#jobfilterparameter)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[NumberOperators](/reference/graphql-api/admin/input-types#numberoperators)[BooleanOperators](/reference/graphql-api/admin/input-types#booleanoperators)[NumberOperators](/reference/graphql-api/admin/input-types#numberoperators)[NumberOperators](/reference/graphql-api/admin/input-types#numberoperators)[NumberOperators](/reference/graphql-api/admin/input-types#numberoperators)[JobFilterParameter](/reference/graphql-api/admin/input-types#jobfilterparameter)[JobFilterParameter](/reference/graphql-api/admin/input-types#jobfilterparameter)
## JobListOptions​


[​](#joblistoptions)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[JobSortParameter](/reference/graphql-api/admin/input-types#jobsortparameter)[JobFilterParameter](/reference/graphql-api/admin/input-types#jobfilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## JobSortParameter​


[​](#jobsortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## ManualPaymentInput​


[​](#manualpaymentinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## MetricSummaryInput​


[​](#metricsummaryinput)[MetricInterval](/reference/graphql-api/admin/enums#metricinterval)[MetricType](/reference/graphql-api/admin/enums#metrictype)[Boolean](/reference/graphql-api/admin/object-types#boolean)
## ModifyOrderInput​


[​](#modifyorderinput)[Boolean](/reference/graphql-api/admin/object-types#boolean)[ID](/reference/graphql-api/admin/object-types#id)[AddItemInput](/reference/graphql-api/admin/input-types#additeminput)[OrderLineInput](/reference/graphql-api/admin/input-types#orderlineinput)[SurchargeInput](/reference/graphql-api/admin/input-types#surchargeinput)[UpdateOrderAddressInput](/reference/graphql-api/admin/input-types#updateorderaddressinput)[UpdateOrderAddressInput](/reference/graphql-api/admin/input-types#updateorderaddressinput)[String](/reference/graphql-api/admin/object-types#string)[AdministratorRefundInput](/reference/graphql-api/admin/input-types#administratorrefundinput)[AdministratorRefundInput](/reference/graphql-api/admin/input-types#administratorrefundinput)[ModifyOrderOptions](/reference/graphql-api/admin/input-types#modifyorderoptions)[String](/reference/graphql-api/admin/object-types#string)[ID](/reference/graphql-api/admin/object-types#id)
## ModifyOrderOptions​


[​](#modifyorderoptions)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)
## MoveCollectionInput​


[​](#movecollectioninput)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[Int](/reference/graphql-api/admin/object-types#int)
## NativeAuthInput​


[​](#nativeauthinput)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## NumberListOperators​


[​](#numberlistoperators)[Float](/reference/graphql-api/admin/object-types#float)
## NumberOperators​


[​](#numberoperators)[Float](/reference/graphql-api/admin/object-types#float)[Float](/reference/graphql-api/admin/object-types#float)[Float](/reference/graphql-api/admin/object-types#float)[Float](/reference/graphql-api/admin/object-types#float)[Float](/reference/graphql-api/admin/object-types#float)[NumberRange](/reference/graphql-api/admin/input-types#numberrange)[Boolean](/reference/graphql-api/admin/object-types#boolean)
## NumberRange​


[​](#numberrange)[Float](/reference/graphql-api/admin/object-types#float)[Float](/reference/graphql-api/admin/object-types#float)
## OrderFilterParameter​


[​](#orderfilterparameter)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[BooleanOperators](/reference/graphql-api/admin/input-types#booleanoperators)[NumberOperators](/reference/graphql-api/admin/input-types#numberoperators)[NumberOperators](/reference/graphql-api/admin/input-types#numberoperators)[NumberOperators](/reference/graphql-api/admin/input-types#numberoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[NumberOperators](/reference/graphql-api/admin/input-types#numberoperators)[NumberOperators](/reference/graphql-api/admin/input-types#numberoperators)[NumberOperators](/reference/graphql-api/admin/input-types#numberoperators)[NumberOperators](/reference/graphql-api/admin/input-types#numberoperators)[OrderFilterParameter](/reference/graphql-api/admin/input-types#orderfilterparameter)[OrderFilterParameter](/reference/graphql-api/admin/input-types#orderfilterparameter)
## OrderLineInput​


[​](#orderlineinput)[ID](/reference/graphql-api/admin/object-types#id)[Int](/reference/graphql-api/admin/object-types#int)
## OrderListOptions​


[​](#orderlistoptions)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[OrderSortParameter](/reference/graphql-api/admin/input-types#ordersortparameter)[OrderFilterParameter](/reference/graphql-api/admin/input-types#orderfilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## OrderSortParameter​


[​](#ordersortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## PaymentMethodFilterParameter​


[​](#paymentmethodfilterparameter)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[BooleanOperators](/reference/graphql-api/admin/input-types#booleanoperators)[PaymentMethodFilterParameter](/reference/graphql-api/admin/input-types#paymentmethodfilterparameter)[PaymentMethodFilterParameter](/reference/graphql-api/admin/input-types#paymentmethodfilterparameter)
## PaymentMethodListOptions​


[​](#paymentmethodlistoptions)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[PaymentMethodSortParameter](/reference/graphql-api/admin/input-types#paymentmethodsortparameter)[PaymentMethodFilterParameter](/reference/graphql-api/admin/input-types#paymentmethodfilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## PaymentMethodSortParameter​


[​](#paymentmethodsortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## PaymentMethodTranslationInput​


[​](#paymentmethodtranslationinput)[ID](/reference/graphql-api/admin/object-types#id)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## PreviewCollectionVariantsInput​


[​](#previewcollectionvariantsinput)[ID](/reference/graphql-api/admin/object-types#id)[Boolean](/reference/graphql-api/admin/object-types#boolean)[ConfigurableOperationInput](/reference/graphql-api/admin/input-types#configurableoperationinput)
## ProductFilterParameter​


[​](#productfilterparameter)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[BooleanOperators](/reference/graphql-api/admin/input-types#booleanoperators)[ProductFilterParameter](/reference/graphql-api/admin/input-types#productfilterparameter)[ProductFilterParameter](/reference/graphql-api/admin/input-types#productfilterparameter)
## ProductListOptions​


[​](#productlistoptions)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[ProductSortParameter](/reference/graphql-api/admin/input-types#productsortparameter)[ProductFilterParameter](/reference/graphql-api/admin/input-types#productfilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## ProductOptionFilterParameter​


[​](#productoptionfilterparameter)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[ProductOptionFilterParameter](/reference/graphql-api/admin/input-types#productoptionfilterparameter)[ProductOptionFilterParameter](/reference/graphql-api/admin/input-types#productoptionfilterparameter)
## ProductOptionGroupTranslationInput​


[​](#productoptiongrouptranslationinput)[ID](/reference/graphql-api/admin/object-types#id)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## ProductOptionListOptions​


[​](#productoptionlistoptions)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[ProductOptionSortParameter](/reference/graphql-api/admin/input-types#productoptionsortparameter)[ProductOptionFilterParameter](/reference/graphql-api/admin/input-types#productoptionfilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## ProductOptionSortParameter​


[​](#productoptionsortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## ProductOptionTranslationInput​


[​](#productoptiontranslationinput)[ID](/reference/graphql-api/admin/object-types#id)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## ProductSortParameter​


[​](#productsortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## ProductTranslationInput​


[​](#producttranslationinput)[ID](/reference/graphql-api/admin/object-types#id)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## ProductVariantFilterParameter​


[​](#productvariantfilterparameter)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[BooleanOperators](/reference/graphql-api/admin/input-types#booleanoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[NumberOperators](/reference/graphql-api/admin/input-types#numberoperators)[NumberOperators](/reference/graphql-api/admin/input-types#numberoperators)[NumberOperators](/reference/graphql-api/admin/input-types#numberoperators)[BooleanOperators](/reference/graphql-api/admin/input-types#booleanoperators)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[NumberOperators](/reference/graphql-api/admin/input-types#numberoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[NumberOperators](/reference/graphql-api/admin/input-types#numberoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[ProductVariantFilterParameter](/reference/graphql-api/admin/input-types#productvariantfilterparameter)[ProductVariantFilterParameter](/reference/graphql-api/admin/input-types#productvariantfilterparameter)
## ProductVariantListOptions​


[​](#productvariantlistoptions)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[ProductVariantSortParameter](/reference/graphql-api/admin/input-types#productvariantsortparameter)[ProductVariantFilterParameter](/reference/graphql-api/admin/input-types#productvariantfilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## ProductVariantSortParameter​


[​](#productvariantsortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## ProductVariantTranslationInput​


[​](#productvarianttranslationinput)[ID](/reference/graphql-api/admin/object-types#id)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## PromotionFilterParameter​


[​](#promotionfilterparameter)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[NumberOperators](/reference/graphql-api/admin/input-types#numberoperators)[NumberOperators](/reference/graphql-api/admin/input-types#numberoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[BooleanOperators](/reference/graphql-api/admin/input-types#booleanoperators)[PromotionFilterParameter](/reference/graphql-api/admin/input-types#promotionfilterparameter)[PromotionFilterParameter](/reference/graphql-api/admin/input-types#promotionfilterparameter)
## PromotionListOptions​


[​](#promotionlistoptions)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[PromotionSortParameter](/reference/graphql-api/admin/input-types#promotionsortparameter)[PromotionFilterParameter](/reference/graphql-api/admin/input-types#promotionfilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## PromotionSortParameter​


[​](#promotionsortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## PromotionTranslationInput​


[​](#promotiontranslationinput)[ID](/reference/graphql-api/admin/object-types#id)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## ProvinceFilterParameter​


[​](#provincefilterparameter)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[BooleanOperators](/reference/graphql-api/admin/input-types#booleanoperators)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[ProvinceFilterParameter](/reference/graphql-api/admin/input-types#provincefilterparameter)[ProvinceFilterParameter](/reference/graphql-api/admin/input-types#provincefilterparameter)
## ProvinceListOptions​


[​](#provincelistoptions)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[ProvinceSortParameter](/reference/graphql-api/admin/input-types#provincesortparameter)[ProvinceFilterParameter](/reference/graphql-api/admin/input-types#provincefilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## ProvinceSortParameter​


[​](#provincesortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## ProvinceTranslationInput​


[​](#provincetranslationinput)[ID](/reference/graphql-api/admin/object-types#id)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## RefundOrderInput​


[​](#refundorderinput)[OrderLineInput](/reference/graphql-api/admin/input-types#orderlineinput)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)
## RemoveCollectionsFromChannelInput​


[​](#removecollectionsfromchannelinput)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)
## RemoveFacetsFromChannelInput​


[​](#removefacetsfromchannelinput)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[Boolean](/reference/graphql-api/admin/object-types#boolean)
## RemovePaymentMethodsFromChannelInput​


[​](#removepaymentmethodsfromchannelinput)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)
## RemoveProductVariantsFromChannelInput​


[​](#removeproductvariantsfromchannelinput)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)
## RemoveProductsFromChannelInput​


[​](#removeproductsfromchannelinput)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)
## RemovePromotionsFromChannelInput​


[​](#removepromotionsfromchannelinput)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)
## RemoveShippingMethodsFromChannelInput​


[​](#removeshippingmethodsfromchannelinput)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)
## RemoveStockLocationsFromChannelInput​


[​](#removestocklocationsfromchannelinput)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)
## RoleFilterParameter​


[​](#rolefilterparameter)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[RoleFilterParameter](/reference/graphql-api/admin/input-types#rolefilterparameter)[RoleFilterParameter](/reference/graphql-api/admin/input-types#rolefilterparameter)
## RoleListOptions​


[​](#rolelistoptions)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[RoleSortParameter](/reference/graphql-api/admin/input-types#rolesortparameter)[RoleFilterParameter](/reference/graphql-api/admin/input-types#rolefilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## RoleSortParameter​


[​](#rolesortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## SearchInput​


[​](#searchinput)[String](/reference/graphql-api/admin/object-types#string)[ID](/reference/graphql-api/admin/object-types#id)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)[FacetValueFilterInput](/reference/graphql-api/admin/input-types#facetvaluefilterinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[SearchResultSortParameter](/reference/graphql-api/admin/input-types#searchresultsortparameter)
## SearchResultSortParameter​


[​](#searchresultsortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## SellerFilterParameter​


[​](#sellerfilterparameter)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[SellerFilterParameter](/reference/graphql-api/admin/input-types#sellerfilterparameter)[SellerFilterParameter](/reference/graphql-api/admin/input-types#sellerfilterparameter)
## SellerListOptions​


[​](#sellerlistoptions)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[SellerSortParameter](/reference/graphql-api/admin/input-types#sellersortparameter)[SellerFilterParameter](/reference/graphql-api/admin/input-types#sellerfilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## SellerSortParameter​


[​](#sellersortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## SetOrderCustomerInput​


[​](#setordercustomerinput)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)
## SettingsStoreInput​


[​](#settingsstoreinput)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## SettleRefundInput​


[​](#settlerefundinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)
## ShippingMethodFilterParameter​


[​](#shippingmethodfilterparameter)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[ShippingMethodFilterParameter](/reference/graphql-api/admin/input-types#shippingmethodfilterparameter)[ShippingMethodFilterParameter](/reference/graphql-api/admin/input-types#shippingmethodfilterparameter)
## ShippingMethodListOptions​


[​](#shippingmethodlistoptions)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[ShippingMethodSortParameter](/reference/graphql-api/admin/input-types#shippingmethodsortparameter)[ShippingMethodFilterParameter](/reference/graphql-api/admin/input-types#shippingmethodfilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## ShippingMethodSortParameter​


[​](#shippingmethodsortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## ShippingMethodTranslationInput​


[​](#shippingmethodtranslationinput)[ID](/reference/graphql-api/admin/object-types#id)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## SlugForEntityInput​


[​](#slugforentityinput)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[ID](/reference/graphql-api/admin/object-types#id)
## StockLevelInput​


[​](#stocklevelinput)[ID](/reference/graphql-api/admin/object-types#id)[Int](/reference/graphql-api/admin/object-types#int)
## StockLocationFilterParameter​


[​](#stocklocationfilterparameter)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[StockLocationFilterParameter](/reference/graphql-api/admin/input-types#stocklocationfilterparameter)[StockLocationFilterParameter](/reference/graphql-api/admin/input-types#stocklocationfilterparameter)
## StockLocationListOptions​


[​](#stocklocationlistoptions)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[StockLocationSortParameter](/reference/graphql-api/admin/input-types#stocklocationsortparameter)[StockLocationFilterParameter](/reference/graphql-api/admin/input-types#stocklocationfilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## StockLocationSortParameter​


[​](#stocklocationsortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## StockMovementListOptions​


[​](#stockmovementlistoptions)[StockMovementType](/reference/graphql-api/admin/enums#stockmovementtype)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)
## StringListOperators​


[​](#stringlistoperators)[String](/reference/graphql-api/admin/object-types#string)
## StringOperators​


[​](#stringoperators)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)
## SurchargeInput​


[​](#surchargeinput)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Money](/reference/graphql-api/admin/object-types#money)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Float](/reference/graphql-api/admin/object-types#float)[String](/reference/graphql-api/admin/object-types#string)
## TagFilterParameter​


[​](#tagfilterparameter)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[TagFilterParameter](/reference/graphql-api/admin/input-types#tagfilterparameter)[TagFilterParameter](/reference/graphql-api/admin/input-types#tagfilterparameter)
## TagListOptions​


[​](#taglistoptions)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[TagSortParameter](/reference/graphql-api/admin/input-types#tagsortparameter)[TagFilterParameter](/reference/graphql-api/admin/input-types#tagfilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## TagSortParameter​


[​](#tagsortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## TaxCategoryFilterParameter​


[​](#taxcategoryfilterparameter)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[BooleanOperators](/reference/graphql-api/admin/input-types#booleanoperators)[TaxCategoryFilterParameter](/reference/graphql-api/admin/input-types#taxcategoryfilterparameter)[TaxCategoryFilterParameter](/reference/graphql-api/admin/input-types#taxcategoryfilterparameter)
## TaxCategoryListOptions​


[​](#taxcategorylistoptions)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[TaxCategorySortParameter](/reference/graphql-api/admin/input-types#taxcategorysortparameter)[TaxCategoryFilterParameter](/reference/graphql-api/admin/input-types#taxcategoryfilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## TaxCategorySortParameter​


[​](#taxcategorysortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## TaxRateFilterParameter​


[​](#taxratefilterparameter)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[BooleanOperators](/reference/graphql-api/admin/input-types#booleanoperators)[NumberOperators](/reference/graphql-api/admin/input-types#numberoperators)[TaxRateFilterParameter](/reference/graphql-api/admin/input-types#taxratefilterparameter)[TaxRateFilterParameter](/reference/graphql-api/admin/input-types#taxratefilterparameter)
## TaxRateListOptions​


[​](#taxratelistoptions)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[TaxRateSortParameter](/reference/graphql-api/admin/input-types#taxratesortparameter)[TaxRateFilterParameter](/reference/graphql-api/admin/input-types#taxratefilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## TaxRateSortParameter​


[​](#taxratesortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)
## TestEligibleShippingMethodsInput​


[​](#testeligibleshippingmethodsinput)[CreateAddressInput](/reference/graphql-api/admin/input-types#createaddressinput)[TestShippingMethodOrderLineInput](/reference/graphql-api/admin/input-types#testshippingmethodorderlineinput)
## TestShippingMethodInput​


[​](#testshippingmethodinput)[ConfigurableOperationInput](/reference/graphql-api/admin/input-types#configurableoperationinput)[ConfigurableOperationInput](/reference/graphql-api/admin/input-types#configurableoperationinput)[CreateAddressInput](/reference/graphql-api/admin/input-types#createaddressinput)[TestShippingMethodOrderLineInput](/reference/graphql-api/admin/input-types#testshippingmethodorderlineinput)
## TestShippingMethodOrderLineInput​


[​](#testshippingmethodorderlineinput)[ID](/reference/graphql-api/admin/object-types#id)[Int](/reference/graphql-api/admin/object-types#int)
## UpdateActiveAdministratorInput​


[​](#updateactiveadministratorinput)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateAddressInput​


[​](#updateaddressinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateAdministratorInput​


[​](#updateadministratorinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[ID](/reference/graphql-api/admin/object-types#id)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateAssetInput​


[​](#updateassetinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[CoordinateInput](/reference/graphql-api/admin/input-types#coordinateinput)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateChannelInput​


[​](#updatechannelinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[Boolean](/reference/graphql-api/admin/object-types#boolean)[CurrencyCode](/reference/graphql-api/admin/enums#currencycode)[CurrencyCode](/reference/graphql-api/admin/enums#currencycode)[CurrencyCode](/reference/graphql-api/admin/enums#currencycode)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Int](/reference/graphql-api/admin/object-types#int)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateCollectionInput​


[​](#updatecollectioninput)[ID](/reference/graphql-api/admin/object-types#id)[Boolean](/reference/graphql-api/admin/object-types#boolean)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[Boolean](/reference/graphql-api/admin/object-types#boolean)[ConfigurableOperationInput](/reference/graphql-api/admin/input-types#configurableoperationinput)[UpdateCollectionTranslationInput](/reference/graphql-api/admin/input-types#updatecollectiontranslationinput)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateCollectionTranslationInput​


[​](#updatecollectiontranslationinput)[ID](/reference/graphql-api/admin/object-types#id)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateCountryInput​


[​](#updatecountryinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[CountryTranslationInput](/reference/graphql-api/admin/input-types#countrytranslationinput)[Boolean](/reference/graphql-api/admin/object-types#boolean)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateCustomerGroupInput​


[​](#updatecustomergroupinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateCustomerInput​


[​](#updatecustomerinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateCustomerNoteInput​


[​](#updatecustomernoteinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)
## UpdateFacetInput​


[​](#updatefacetinput)[ID](/reference/graphql-api/admin/object-types#id)[Boolean](/reference/graphql-api/admin/object-types#boolean)[String](/reference/graphql-api/admin/object-types#string)[FacetTranslationInput](/reference/graphql-api/admin/input-types#facettranslationinput)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateFacetValueInput​


[​](#updatefacetvalueinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[FacetValueTranslationInput](/reference/graphql-api/admin/input-types#facetvaluetranslationinput)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateGlobalSettingsInput​


[​](#updateglobalsettingsinput)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Int](/reference/graphql-api/admin/object-types#int)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateOrderAddressInput​


[​](#updateorderaddressinput)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## UpdateOrderInput​


[​](#updateorderinput)[ID](/reference/graphql-api/admin/object-types#id)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateOrderNoteInput​


[​](#updateordernoteinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)
## UpdatePaymentMethodInput​


[​](#updatepaymentmethodinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[ConfigurableOperationInput](/reference/graphql-api/admin/input-types#configurableoperationinput)[ConfigurableOperationInput](/reference/graphql-api/admin/input-types#configurableoperationinput)[PaymentMethodTranslationInput](/reference/graphql-api/admin/input-types#paymentmethodtranslationinput)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateProductInput​


[​](#updateproductinput)[ID](/reference/graphql-api/admin/object-types#id)[Boolean](/reference/graphql-api/admin/object-types#boolean)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[ProductTranslationInput](/reference/graphql-api/admin/input-types#producttranslationinput)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateProductOptionGroupInput​


[​](#updateproductoptiongroupinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[ProductOptionGroupTranslationInput](/reference/graphql-api/admin/input-types#productoptiongrouptranslationinput)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateProductOptionInput​


[​](#updateproductoptioninput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[ProductOptionGroupTranslationInput](/reference/graphql-api/admin/input-types#productoptiongrouptranslationinput)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateProductVariantInput​


[​](#updateproductvariantinput)[ID](/reference/graphql-api/admin/object-types#id)[Boolean](/reference/graphql-api/admin/object-types#boolean)[ProductVariantTranslationInput](/reference/graphql-api/admin/input-types#productvarianttranslationinput)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[ID](/reference/graphql-api/admin/object-types#id)[Money](/reference/graphql-api/admin/object-types#money)[UpdateProductVariantPriceInput](/reference/graphql-api/admin/input-types#updateproductvariantpriceinput)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[Int](/reference/graphql-api/admin/object-types#int)[StockLevelInput](/reference/graphql-api/admin/input-types#stocklevelinput)[Int](/reference/graphql-api/admin/object-types#int)[Boolean](/reference/graphql-api/admin/object-types#boolean)[GlobalFlag](/reference/graphql-api/admin/enums#globalflag)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateProductVariantPriceInput​


[​](#updateproductvariantpriceinput)[CurrencyCode](/reference/graphql-api/admin/enums#currencycode)[Money](/reference/graphql-api/admin/object-types#money)[Boolean](/reference/graphql-api/admin/object-types#boolean)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdatePromotionInput​


[​](#updatepromotioninput)[ID](/reference/graphql-api/admin/object-types#id)[Boolean](/reference/graphql-api/admin/object-types#boolean)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[String](/reference/graphql-api/admin/object-types#string)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[ConfigurableOperationInput](/reference/graphql-api/admin/input-types#configurableoperationinput)[ConfigurableOperationInput](/reference/graphql-api/admin/input-types#configurableoperationinput)[PromotionTranslationInput](/reference/graphql-api/admin/input-types#promotiontranslationinput)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateProvinceInput​


[​](#updateprovinceinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[ProvinceTranslationInput](/reference/graphql-api/admin/input-types#provincetranslationinput)[Boolean](/reference/graphql-api/admin/object-types#boolean)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateRoleInput​


[​](#updateroleinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Permission](/reference/graphql-api/admin/enums#permission)[ID](/reference/graphql-api/admin/object-types#id)
## UpdateScheduledTaskInput​


[​](#updatescheduledtaskinput)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)
## UpdateSellerInput​


[​](#updatesellerinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateShippingMethodInput​


[​](#updateshippingmethodinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[ConfigurableOperationInput](/reference/graphql-api/admin/input-types#configurableoperationinput)[ConfigurableOperationInput](/reference/graphql-api/admin/input-types#configurableoperationinput)[ShippingMethodTranslationInput](/reference/graphql-api/admin/input-types#shippingmethodtranslationinput)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateStockLocationInput​


[​](#updatestocklocationinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateTagInput​


[​](#updatetaginput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)
## UpdateTaxCategoryInput​


[​](#updatetaxcategoryinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateTaxRateInput​


[​](#updatetaxrateinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[Float](/reference/graphql-api/admin/object-types#float)[Boolean](/reference/graphql-api/admin/object-types#boolean)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[JSON](/reference/graphql-api/admin/object-types#json)
## UpdateZoneInput​


[​](#updatezoneinput)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## ZoneFilterParameter​


[​](#zonefilterparameter)[IDOperators](/reference/graphql-api/admin/input-types#idoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[DateOperators](/reference/graphql-api/admin/input-types#dateoperators)[StringOperators](/reference/graphql-api/admin/input-types#stringoperators)[ZoneFilterParameter](/reference/graphql-api/admin/input-types#zonefilterparameter)[ZoneFilterParameter](/reference/graphql-api/admin/input-types#zonefilterparameter)
## ZoneListOptions​


[​](#zonelistoptions)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[ZoneSortParameter](/reference/graphql-api/admin/input-types#zonesortparameter)[ZoneFilterParameter](/reference/graphql-api/admin/input-types#zonefilterparameter)[LogicalOperator](/reference/graphql-api/admin/enums#logicaloperator)
## ZoneSortParameter​


[​](#zonesortparameter)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)[SortOrder](/reference/graphql-api/admin/enums#sortorder)


---

# Mutations


## addCustomersToGroup​


[​](#addcustomerstogroup)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[CustomerGroup](/reference/graphql-api/admin/object-types#customergroup)
## addFulfillmentToOrder​


[​](#addfulfillmenttoorder)[FulfillOrderInput](/reference/graphql-api/admin/input-types#fulfillorderinput)[AddFulfillmentToOrderResult](/reference/graphql-api/admin/object-types#addfulfillmenttoorderresult)
## addItemToDraftOrder​


[​](#additemtodraftorder)[ID](/reference/graphql-api/admin/object-types#id)[AddItemToDraftOrderInput](/reference/graphql-api/admin/input-types#additemtodraftorderinput)[UpdateOrderItemsResult](/reference/graphql-api/admin/object-types#updateorderitemsresult)
## addManualPaymentToOrder​


[​](#addmanualpaymenttoorder)[ManualPaymentInput](/reference/graphql-api/admin/input-types#manualpaymentinput)[AddManualPaymentToOrderResult](/reference/graphql-api/admin/object-types#addmanualpaymenttoorderresult)
## addMembersToZone​


[​](#addmemberstozone)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[Zone](/reference/graphql-api/admin/object-types#zone)
## addNoteToCustomer​


[​](#addnotetocustomer)[AddNoteToCustomerInput](/reference/graphql-api/admin/input-types#addnotetocustomerinput)[Customer](/reference/graphql-api/admin/object-types#customer)
## addNoteToOrder​


[​](#addnotetoorder)[AddNoteToOrderInput](/reference/graphql-api/admin/input-types#addnotetoorderinput)[Order](/reference/graphql-api/admin/object-types#order)
## addOptionGroupToProduct​


[​](#addoptiongrouptoproduct)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[Product](/reference/graphql-api/admin/object-types#product)
## adjustDraftOrderLine​


[​](#adjustdraftorderline)[ID](/reference/graphql-api/admin/object-types#id)[AdjustDraftOrderLineInput](/reference/graphql-api/admin/input-types#adjustdraftorderlineinput)[UpdateOrderItemsResult](/reference/graphql-api/admin/object-types#updateorderitemsresult)
## applyCouponCodeToDraftOrder​


[​](#applycouponcodetodraftorder)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[ApplyCouponCodeResult](/reference/graphql-api/admin/object-types#applycouponcoderesult)
## assignAssetsToChannel​


[​](#assignassetstochannel)[AssignAssetsToChannelInput](/reference/graphql-api/admin/input-types#assignassetstochannelinput)[Asset](/reference/graphql-api/admin/object-types#asset)
## assignCollectionsToChannel​


[​](#assigncollectionstochannel)[AssignCollectionsToChannelInput](/reference/graphql-api/admin/input-types#assigncollectionstochannelinput)[Collection](/reference/graphql-api/admin/object-types#collection)
## assignFacetsToChannel​


[​](#assignfacetstochannel)[AssignFacetsToChannelInput](/reference/graphql-api/admin/input-types#assignfacetstochannelinput)[Facet](/reference/graphql-api/admin/object-types#facet)
## assignPaymentMethodsToChannel​


[​](#assignpaymentmethodstochannel)[AssignPaymentMethodsToChannelInput](/reference/graphql-api/admin/input-types#assignpaymentmethodstochannelinput)[PaymentMethod](/reference/graphql-api/admin/object-types#paymentmethod)
## assignProductVariantsToChannel​


[​](#assignproductvariantstochannel)[AssignProductVariantsToChannelInput](/reference/graphql-api/admin/input-types#assignproductvariantstochannelinput)[ProductVariant](/reference/graphql-api/admin/object-types#productvariant)
## assignProductsToChannel​


[​](#assignproductstochannel)[AssignProductsToChannelInput](/reference/graphql-api/admin/input-types#assignproductstochannelinput)[Product](/reference/graphql-api/admin/object-types#product)
## assignPromotionsToChannel​


[​](#assignpromotionstochannel)[AssignPromotionsToChannelInput](/reference/graphql-api/admin/input-types#assignpromotionstochannelinput)[Promotion](/reference/graphql-api/admin/object-types#promotion)
## assignRoleToAdministrator​


[​](#assignroletoadministrator)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[Administrator](/reference/graphql-api/admin/object-types#administrator)
## assignShippingMethodsToChannel​


[​](#assignshippingmethodstochannel)[AssignShippingMethodsToChannelInput](/reference/graphql-api/admin/input-types#assignshippingmethodstochannelinput)[ShippingMethod](/reference/graphql-api/admin/object-types#shippingmethod)
## assignStockLocationsToChannel​


[​](#assignstocklocationstochannel)[AssignStockLocationsToChannelInput](/reference/graphql-api/admin/input-types#assignstocklocationstochannelinput)[StockLocation](/reference/graphql-api/admin/object-types#stocklocation)
## authenticate​


[​](#authenticate)[AuthenticationInput](/reference/graphql-api/admin/input-types#authenticationinput)[Boolean](/reference/graphql-api/admin/object-types#boolean)[AuthenticationResult](/reference/graphql-api/admin/object-types#authenticationresult)
## cancelJob​


[​](#canceljob)[ID](/reference/graphql-api/admin/object-types#id)[Job](/reference/graphql-api/admin/object-types#job)
## cancelOrder​


[​](#cancelorder)[CancelOrderInput](/reference/graphql-api/admin/input-types#cancelorderinput)[CancelOrderResult](/reference/graphql-api/admin/object-types#cancelorderresult)
## cancelPayment​


[​](#cancelpayment)[ID](/reference/graphql-api/admin/object-types#id)[CancelPaymentResult](/reference/graphql-api/admin/object-types#cancelpaymentresult)
## createAdministrator​


[​](#createadministrator)[CreateAdministratorInput](/reference/graphql-api/admin/input-types#createadministratorinput)[Administrator](/reference/graphql-api/admin/object-types#administrator)
## createAssets​


[​](#createassets)[CreateAssetInput](/reference/graphql-api/admin/input-types#createassetinput)[CreateAssetResult](/reference/graphql-api/admin/object-types#createassetresult)
## createChannel​


[​](#createchannel)[CreateChannelInput](/reference/graphql-api/admin/input-types#createchannelinput)[CreateChannelResult](/reference/graphql-api/admin/object-types#createchannelresult)
## createCollection​


[​](#createcollection)[CreateCollectionInput](/reference/graphql-api/admin/input-types#createcollectioninput)[Collection](/reference/graphql-api/admin/object-types#collection)
## createCountry​


[​](#createcountry)[CreateCountryInput](/reference/graphql-api/admin/input-types#createcountryinput)[Country](/reference/graphql-api/admin/object-types#country)
## createCustomer​


[​](#createcustomer)[CreateCustomerInput](/reference/graphql-api/admin/input-types#createcustomerinput)[String](/reference/graphql-api/admin/object-types#string)[CreateCustomerResult](/reference/graphql-api/admin/object-types#createcustomerresult)
## createCustomerAddress​


[​](#createcustomeraddress)[ID](/reference/graphql-api/admin/object-types#id)[CreateAddressInput](/reference/graphql-api/admin/input-types#createaddressinput)[Address](/reference/graphql-api/admin/object-types#address)
## createCustomerGroup​


[​](#createcustomergroup)[CreateCustomerGroupInput](/reference/graphql-api/admin/input-types#createcustomergroupinput)[CustomerGroup](/reference/graphql-api/admin/object-types#customergroup)
## createDraftOrder​


[​](#createdraftorder)[Order](/reference/graphql-api/admin/object-types#order)
## createFacet​


[​](#createfacet)[CreateFacetInput](/reference/graphql-api/admin/input-types#createfacetinput)[Facet](/reference/graphql-api/admin/object-types#facet)
## createFacetValue​


[​](#createfacetvalue)[CreateFacetValueInput](/reference/graphql-api/admin/input-types#createfacetvalueinput)[FacetValue](/reference/graphql-api/admin/object-types#facetvalue)
## createFacetValues​


[​](#createfacetvalues)[CreateFacetValueInput](/reference/graphql-api/admin/input-types#createfacetvalueinput)[FacetValue](/reference/graphql-api/admin/object-types#facetvalue)
## createPaymentMethod​


[​](#createpaymentmethod)[CreatePaymentMethodInput](/reference/graphql-api/admin/input-types#createpaymentmethodinput)[PaymentMethod](/reference/graphql-api/admin/object-types#paymentmethod)
## createProduct​


[​](#createproduct)[CreateProductInput](/reference/graphql-api/admin/input-types#createproductinput)[Product](/reference/graphql-api/admin/object-types#product)
## createProductOption​


[​](#createproductoption)[CreateProductOptionInput](/reference/graphql-api/admin/input-types#createproductoptioninput)[ProductOption](/reference/graphql-api/admin/object-types#productoption)
## createProductOptionGroup​


[​](#createproductoptiongroup)[CreateProductOptionGroupInput](/reference/graphql-api/admin/input-types#createproductoptiongroupinput)[ProductOptionGroup](/reference/graphql-api/admin/object-types#productoptiongroup)
## createProductVariants​


[​](#createproductvariants)[CreateProductVariantInput](/reference/graphql-api/admin/input-types#createproductvariantinput)[ProductVariant](/reference/graphql-api/admin/object-types#productvariant)
## createPromotion​


[​](#createpromotion)[CreatePromotionInput](/reference/graphql-api/admin/input-types#createpromotioninput)[CreatePromotionResult](/reference/graphql-api/admin/object-types#createpromotionresult)
## createProvince​


[​](#createprovince)[CreateProvinceInput](/reference/graphql-api/admin/input-types#createprovinceinput)[Province](/reference/graphql-api/admin/object-types#province)
## createRole​


[​](#createrole)[CreateRoleInput](/reference/graphql-api/admin/input-types#createroleinput)[Role](/reference/graphql-api/admin/object-types#role)
## createSeller​


[​](#createseller)[CreateSellerInput](/reference/graphql-api/admin/input-types#createsellerinput)[Seller](/reference/graphql-api/admin/object-types#seller)
## createShippingMethod​


[​](#createshippingmethod)[CreateShippingMethodInput](/reference/graphql-api/admin/input-types#createshippingmethodinput)[ShippingMethod](/reference/graphql-api/admin/object-types#shippingmethod)
## createStockLocation​


[​](#createstocklocation)[CreateStockLocationInput](/reference/graphql-api/admin/input-types#createstocklocationinput)[StockLocation](/reference/graphql-api/admin/object-types#stocklocation)
## createTag​


[​](#createtag)[CreateTagInput](/reference/graphql-api/admin/input-types#createtaginput)[Tag](/reference/graphql-api/admin/object-types#tag)
## createTaxCategory​


[​](#createtaxcategory)[CreateTaxCategoryInput](/reference/graphql-api/admin/input-types#createtaxcategoryinput)[TaxCategory](/reference/graphql-api/admin/object-types#taxcategory)
## createTaxRate​


[​](#createtaxrate)[CreateTaxRateInput](/reference/graphql-api/admin/input-types#createtaxrateinput)[TaxRate](/reference/graphql-api/admin/object-types#taxrate)
## createZone​


[​](#createzone)[CreateZoneInput](/reference/graphql-api/admin/input-types#createzoneinput)[Zone](/reference/graphql-api/admin/object-types#zone)
## deleteAdministrator​


[​](#deleteadministrator)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteAdministrators​


[​](#deleteadministrators)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteAsset​


[​](#deleteasset)[DeleteAssetInput](/reference/graphql-api/admin/input-types#deleteassetinput)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteAssets​


[​](#deleteassets)[DeleteAssetsInput](/reference/graphql-api/admin/input-types#deleteassetsinput)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteChannel​


[​](#deletechannel)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteChannels​


[​](#deletechannels)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteCollection​


[​](#deletecollection)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteCollections​


[​](#deletecollections)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteCountries​


[​](#deletecountries)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteCountry​


[​](#deletecountry)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteCustomer​


[​](#deletecustomer)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteCustomerAddress​


[​](#deletecustomeraddress)[ID](/reference/graphql-api/admin/object-types#id)[Success](/reference/graphql-api/admin/object-types#success)
## deleteCustomerGroup​


[​](#deletecustomergroup)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteCustomerGroups​


[​](#deletecustomergroups)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteCustomerNote​


[​](#deletecustomernote)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteCustomers​


[​](#deletecustomers)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteDraftOrder​


[​](#deletedraftorder)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteFacet​


[​](#deletefacet)[ID](/reference/graphql-api/admin/object-types#id)[Boolean](/reference/graphql-api/admin/object-types#boolean)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteFacetValues​


[​](#deletefacetvalues)[ID](/reference/graphql-api/admin/object-types#id)[Boolean](/reference/graphql-api/admin/object-types#boolean)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteFacets​


[​](#deletefacets)[ID](/reference/graphql-api/admin/object-types#id)[Boolean](/reference/graphql-api/admin/object-types#boolean)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteOrderNote​


[​](#deleteordernote)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deletePaymentMethod​


[​](#deletepaymentmethod)[ID](/reference/graphql-api/admin/object-types#id)[Boolean](/reference/graphql-api/admin/object-types#boolean)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deletePaymentMethods​


[​](#deletepaymentmethods)[ID](/reference/graphql-api/admin/object-types#id)[Boolean](/reference/graphql-api/admin/object-types#boolean)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteProduct​


[​](#deleteproduct)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteProductOption​


[​](#deleteproductoption)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteProductVariant​


[​](#deleteproductvariant)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteProductVariants​


[​](#deleteproductvariants)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteProducts​


[​](#deleteproducts)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deletePromotion​


[​](#deletepromotion)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deletePromotions​


[​](#deletepromotions)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteProvince​


[​](#deleteprovince)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteRole​


[​](#deleterole)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteRoles​


[​](#deleteroles)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteSeller​


[​](#deleteseller)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteSellers​


[​](#deletesellers)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteShippingMethod​


[​](#deleteshippingmethod)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteShippingMethods​


[​](#deleteshippingmethods)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteStockLocation​


[​](#deletestocklocation)[DeleteStockLocationInput](/reference/graphql-api/admin/input-types#deletestocklocationinput)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteStockLocations​


[​](#deletestocklocations)[DeleteStockLocationInput](/reference/graphql-api/admin/input-types#deletestocklocationinput)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteTag​


[​](#deletetag)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteTaxCategories​


[​](#deletetaxcategories)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteTaxCategory​


[​](#deletetaxcategory)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteTaxRate​


[​](#deletetaxrate)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteTaxRates​


[​](#deletetaxrates)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteZone​


[​](#deletezone)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## deleteZones​


[​](#deletezones)[ID](/reference/graphql-api/admin/object-types#id)[DeletionResponse](/reference/graphql-api/admin/object-types#deletionresponse)
## duplicateEntity​


[​](#duplicateentity)[DuplicateEntityInput](/reference/graphql-api/admin/input-types#duplicateentityinput)[DuplicateEntityResult](/reference/graphql-api/admin/object-types#duplicateentityresult)
## flushBufferedJobs​


[​](#flushbufferedjobs)[String](/reference/graphql-api/admin/object-types#string)[Success](/reference/graphql-api/admin/object-types#success)
## importProducts​


[​](#importproducts)[Upload](/reference/graphql-api/admin/object-types#upload)[ImportInfo](/reference/graphql-api/admin/object-types#importinfo)
## login​


[​](#login)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[NativeAuthenticationResult](/reference/graphql-api/admin/object-types#nativeauthenticationresult)
## logout​


[​](#logout)[Success](/reference/graphql-api/admin/object-types#success)
## modifyOrder​


[​](#modifyorder)[ModifyOrderInput](/reference/graphql-api/admin/input-types#modifyorderinput)[ModifyOrderResult](/reference/graphql-api/admin/object-types#modifyorderresult)
## moveCollection​


[​](#movecollection)[MoveCollectionInput](/reference/graphql-api/admin/input-types#movecollectioninput)[Collection](/reference/graphql-api/admin/object-types#collection)
## refundOrder​


[​](#refundorder)[RefundOrderInput](/reference/graphql-api/admin/input-types#refundorderinput)[RefundOrderResult](/reference/graphql-api/admin/object-types#refundorderresult)
## reindex​


[​](#reindex)[Job](/reference/graphql-api/admin/object-types#job)
## removeCollectionsFromChannel​


[​](#removecollectionsfromchannel)[RemoveCollectionsFromChannelInput](/reference/graphql-api/admin/input-types#removecollectionsfromchannelinput)[Collection](/reference/graphql-api/admin/object-types#collection)
## removeCouponCodeFromDraftOrder​


[​](#removecouponcodefromdraftorder)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[Order](/reference/graphql-api/admin/object-types#order)
## removeCustomersFromGroup​


[​](#removecustomersfromgroup)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[CustomerGroup](/reference/graphql-api/admin/object-types#customergroup)
## removeDraftOrderLine​


[​](#removedraftorderline)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[RemoveOrderItemsResult](/reference/graphql-api/admin/object-types#removeorderitemsresult)
## removeFacetsFromChannel​


[​](#removefacetsfromchannel)[RemoveFacetsFromChannelInput](/reference/graphql-api/admin/input-types#removefacetsfromchannelinput)[RemoveFacetFromChannelResult](/reference/graphql-api/admin/object-types#removefacetfromchannelresult)
## removeMembersFromZone​


[​](#removemembersfromzone)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[Zone](/reference/graphql-api/admin/object-types#zone)
## removeOptionGroupFromProduct​


[​](#removeoptiongroupfromproduct)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[Boolean](/reference/graphql-api/admin/object-types#boolean)[RemoveOptionGroupFromProductResult](/reference/graphql-api/admin/object-types#removeoptiongroupfromproductresult)
## removePaymentMethodsFromChannel​


[​](#removepaymentmethodsfromchannel)[RemovePaymentMethodsFromChannelInput](/reference/graphql-api/admin/input-types#removepaymentmethodsfromchannelinput)[PaymentMethod](/reference/graphql-api/admin/object-types#paymentmethod)
## removeProductVariantsFromChannel​


[​](#removeproductvariantsfromchannel)[RemoveProductVariantsFromChannelInput](/reference/graphql-api/admin/input-types#removeproductvariantsfromchannelinput)[ProductVariant](/reference/graphql-api/admin/object-types#productvariant)
## removeProductsFromChannel​


[​](#removeproductsfromchannel)[RemoveProductsFromChannelInput](/reference/graphql-api/admin/input-types#removeproductsfromchannelinput)[Product](/reference/graphql-api/admin/object-types#product)
## removePromotionsFromChannel​


[​](#removepromotionsfromchannel)[RemovePromotionsFromChannelInput](/reference/graphql-api/admin/input-types#removepromotionsfromchannelinput)[Promotion](/reference/graphql-api/admin/object-types#promotion)
## removeSettledJobs​


[​](#removesettledjobs)[String](/reference/graphql-api/admin/object-types#string)[DateTime](/reference/graphql-api/admin/object-types#datetime)[Int](/reference/graphql-api/admin/object-types#int)
## removeShippingMethodsFromChannel​


[​](#removeshippingmethodsfromchannel)[RemoveShippingMethodsFromChannelInput](/reference/graphql-api/admin/input-types#removeshippingmethodsfromchannelinput)[ShippingMethod](/reference/graphql-api/admin/object-types#shippingmethod)
## removeStockLocationsFromChannel​


[​](#removestocklocationsfromchannel)[RemoveStockLocationsFromChannelInput](/reference/graphql-api/admin/input-types#removestocklocationsfromchannelinput)[StockLocation](/reference/graphql-api/admin/object-types#stocklocation)
## runPendingSearchIndexUpdates​


[​](#runpendingsearchindexupdates)[Success](/reference/graphql-api/admin/object-types#success)
## runScheduledTask​


[​](#runscheduledtask)[String](/reference/graphql-api/admin/object-types#string)[Success](/reference/graphql-api/admin/object-types#success)
## setCustomerForDraftOrder​


[​](#setcustomerfordraftorder)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[CreateCustomerInput](/reference/graphql-api/admin/input-types#createcustomerinput)[SetCustomerForDraftOrderResult](/reference/graphql-api/admin/object-types#setcustomerfordraftorderresult)
## setDraftOrderBillingAddress​


[​](#setdraftorderbillingaddress)[ID](/reference/graphql-api/admin/object-types#id)[CreateAddressInput](/reference/graphql-api/admin/input-types#createaddressinput)[Order](/reference/graphql-api/admin/object-types#order)
## setDraftOrderCustomFields​


[​](#setdraftordercustomfields)[ID](/reference/graphql-api/admin/object-types#id)[UpdateOrderInput](/reference/graphql-api/admin/input-types#updateorderinput)[Order](/reference/graphql-api/admin/object-types#order)
## setDraftOrderShippingAddress​


[​](#setdraftordershippingaddress)[ID](/reference/graphql-api/admin/object-types#id)[CreateAddressInput](/reference/graphql-api/admin/input-types#createaddressinput)[Order](/reference/graphql-api/admin/object-types#order)
## setDraftOrderShippingMethod​


[​](#setdraftordershippingmethod)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[SetOrderShippingMethodResult](/reference/graphql-api/admin/object-types#setordershippingmethodresult)
## setOrderCustomFields​


[​](#setordercustomfields)[UpdateOrderInput](/reference/graphql-api/admin/input-types#updateorderinput)[Order](/reference/graphql-api/admin/object-types#order)
## setOrderCustomer​


[​](#setordercustomer)[SetOrderCustomerInput](/reference/graphql-api/admin/input-types#setordercustomerinput)[Order](/reference/graphql-api/admin/object-types#order)
## setSettingsStoreValue​


[​](#setsettingsstorevalue)[SettingsStoreInput](/reference/graphql-api/admin/input-types#settingsstoreinput)[SetSettingsStoreValueResult](/reference/graphql-api/admin/object-types#setsettingsstorevalueresult)
## setSettingsStoreValues​


[​](#setsettingsstorevalues)[SettingsStoreInput](/reference/graphql-api/admin/input-types#settingsstoreinput)[SetSettingsStoreValueResult](/reference/graphql-api/admin/object-types#setsettingsstorevalueresult)
## settlePayment​


[​](#settlepayment)[ID](/reference/graphql-api/admin/object-types#id)[SettlePaymentResult](/reference/graphql-api/admin/object-types#settlepaymentresult)
## settleRefund​


[​](#settlerefund)[SettleRefundInput](/reference/graphql-api/admin/input-types#settlerefundinput)[SettleRefundResult](/reference/graphql-api/admin/object-types#settlerefundresult)
## transitionFulfillmentToState​


[​](#transitionfulfillmenttostate)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[TransitionFulfillmentToStateResult](/reference/graphql-api/admin/object-types#transitionfulfillmenttostateresult)
## transitionOrderToState​


[​](#transitionordertostate)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[TransitionOrderToStateResult](/reference/graphql-api/admin/object-types#transitionordertostateresult)
## transitionPaymentToState​


[​](#transitionpaymenttostate)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[TransitionPaymentToStateResult](/reference/graphql-api/admin/object-types#transitionpaymenttostateresult)
## unsetDraftOrderBillingAddress​


[​](#unsetdraftorderbillingaddress)[ID](/reference/graphql-api/admin/object-types#id)[Order](/reference/graphql-api/admin/object-types#order)
## unsetDraftOrderShippingAddress​


[​](#unsetdraftordershippingaddress)[ID](/reference/graphql-api/admin/object-types#id)[Order](/reference/graphql-api/admin/object-types#order)
## updateActiveAdministrator​


[​](#updateactiveadministrator)[UpdateActiveAdministratorInput](/reference/graphql-api/admin/input-types#updateactiveadministratorinput)[Administrator](/reference/graphql-api/admin/object-types#administrator)
## updateAdministrator​


[​](#updateadministrator)[UpdateAdministratorInput](/reference/graphql-api/admin/input-types#updateadministratorinput)[Administrator](/reference/graphql-api/admin/object-types#administrator)
## updateAsset​


[​](#updateasset)[UpdateAssetInput](/reference/graphql-api/admin/input-types#updateassetinput)[Asset](/reference/graphql-api/admin/object-types#asset)
## updateChannel​


[​](#updatechannel)[UpdateChannelInput](/reference/graphql-api/admin/input-types#updatechannelinput)[UpdateChannelResult](/reference/graphql-api/admin/object-types#updatechannelresult)
## updateCollection​


[​](#updatecollection)[UpdateCollectionInput](/reference/graphql-api/admin/input-types#updatecollectioninput)[Collection](/reference/graphql-api/admin/object-types#collection)
## updateCountry​


[​](#updatecountry)[UpdateCountryInput](/reference/graphql-api/admin/input-types#updatecountryinput)[Country](/reference/graphql-api/admin/object-types#country)
## updateCustomer​


[​](#updatecustomer)[UpdateCustomerInput](/reference/graphql-api/admin/input-types#updatecustomerinput)[UpdateCustomerResult](/reference/graphql-api/admin/object-types#updatecustomerresult)
## updateCustomerAddress​


[​](#updatecustomeraddress)[UpdateAddressInput](/reference/graphql-api/admin/input-types#updateaddressinput)[Address](/reference/graphql-api/admin/object-types#address)
## updateCustomerGroup​


[​](#updatecustomergroup)[UpdateCustomerGroupInput](/reference/graphql-api/admin/input-types#updatecustomergroupinput)[CustomerGroup](/reference/graphql-api/admin/object-types#customergroup)
## updateCustomerNote​


[​](#updatecustomernote)[UpdateCustomerNoteInput](/reference/graphql-api/admin/input-types#updatecustomernoteinput)[HistoryEntry](/reference/graphql-api/admin/object-types#historyentry)
## updateFacet​


[​](#updatefacet)[UpdateFacetInput](/reference/graphql-api/admin/input-types#updatefacetinput)[Facet](/reference/graphql-api/admin/object-types#facet)
## updateFacetValue​


[​](#updatefacetvalue)[UpdateFacetValueInput](/reference/graphql-api/admin/input-types#updatefacetvalueinput)[FacetValue](/reference/graphql-api/admin/object-types#facetvalue)
## updateFacetValues​


[​](#updatefacetvalues)[UpdateFacetValueInput](/reference/graphql-api/admin/input-types#updatefacetvalueinput)[FacetValue](/reference/graphql-api/admin/object-types#facetvalue)
## updateGlobalSettings​


[​](#updateglobalsettings)[UpdateGlobalSettingsInput](/reference/graphql-api/admin/input-types#updateglobalsettingsinput)[UpdateGlobalSettingsResult](/reference/graphql-api/admin/object-types#updateglobalsettingsresult)
## updateOrderNote​


[​](#updateordernote)[UpdateOrderNoteInput](/reference/graphql-api/admin/input-types#updateordernoteinput)[HistoryEntry](/reference/graphql-api/admin/object-types#historyentry)
## updatePaymentMethod​


[​](#updatepaymentmethod)[UpdatePaymentMethodInput](/reference/graphql-api/admin/input-types#updatepaymentmethodinput)[PaymentMethod](/reference/graphql-api/admin/object-types#paymentmethod)
## updateProduct​


[​](#updateproduct)[UpdateProductInput](/reference/graphql-api/admin/input-types#updateproductinput)[Product](/reference/graphql-api/admin/object-types#product)
## updateProductOption​


[​](#updateproductoption)[UpdateProductOptionInput](/reference/graphql-api/admin/input-types#updateproductoptioninput)[ProductOption](/reference/graphql-api/admin/object-types#productoption)
## updateProductOptionGroup​


[​](#updateproductoptiongroup)[UpdateProductOptionGroupInput](/reference/graphql-api/admin/input-types#updateproductoptiongroupinput)[ProductOptionGroup](/reference/graphql-api/admin/object-types#productoptiongroup)
## updateProductVariant​


[​](#updateproductvariant)[UpdateProductVariantInput](/reference/graphql-api/admin/input-types#updateproductvariantinput)[ProductVariant](/reference/graphql-api/admin/object-types#productvariant)
## updateProductVariants​


[​](#updateproductvariants)[UpdateProductVariantInput](/reference/graphql-api/admin/input-types#updateproductvariantinput)[ProductVariant](/reference/graphql-api/admin/object-types#productvariant)
## updateProducts​


[​](#updateproducts)[UpdateProductInput](/reference/graphql-api/admin/input-types#updateproductinput)[Product](/reference/graphql-api/admin/object-types#product)
## updatePromotion​


[​](#updatepromotion)[UpdatePromotionInput](/reference/graphql-api/admin/input-types#updatepromotioninput)[UpdatePromotionResult](/reference/graphql-api/admin/object-types#updatepromotionresult)
## updateProvince​


[​](#updateprovince)[UpdateProvinceInput](/reference/graphql-api/admin/input-types#updateprovinceinput)[Province](/reference/graphql-api/admin/object-types#province)
## updateRole​


[​](#updaterole)[UpdateRoleInput](/reference/graphql-api/admin/input-types#updateroleinput)[Role](/reference/graphql-api/admin/object-types#role)
## updateScheduledTask​


[​](#updatescheduledtask)[UpdateScheduledTaskInput](/reference/graphql-api/admin/input-types#updatescheduledtaskinput)[ScheduledTask](/reference/graphql-api/admin/object-types#scheduledtask)
## updateSeller​


[​](#updateseller)[UpdateSellerInput](/reference/graphql-api/admin/input-types#updatesellerinput)[Seller](/reference/graphql-api/admin/object-types#seller)
## updateShippingMethod​


[​](#updateshippingmethod)[UpdateShippingMethodInput](/reference/graphql-api/admin/input-types#updateshippingmethodinput)[ShippingMethod](/reference/graphql-api/admin/object-types#shippingmethod)
## updateStockLocation​


[​](#updatestocklocation)[UpdateStockLocationInput](/reference/graphql-api/admin/input-types#updatestocklocationinput)[StockLocation](/reference/graphql-api/admin/object-types#stocklocation)
## updateTag​


[​](#updatetag)[UpdateTagInput](/reference/graphql-api/admin/input-types#updatetaginput)[Tag](/reference/graphql-api/admin/object-types#tag)
## updateTaxCategory​


[​](#updatetaxcategory)[UpdateTaxCategoryInput](/reference/graphql-api/admin/input-types#updatetaxcategoryinput)[TaxCategory](/reference/graphql-api/admin/object-types#taxcategory)
## updateTaxRate​


[​](#updatetaxrate)[UpdateTaxRateInput](/reference/graphql-api/admin/input-types#updatetaxrateinput)[TaxRate](/reference/graphql-api/admin/object-types#taxrate)
## updateZone​


[​](#updatezone)[UpdateZoneInput](/reference/graphql-api/admin/input-types#updatezoneinput)[Zone](/reference/graphql-api/admin/object-types#zone)


---

# Types


## AddFulfillmentToOrderResult​


[​](#addfulfillmenttoorderresult)[Fulfillment](/reference/graphql-api/admin/object-types#fulfillment)[EmptyOrderLineSelectionError](/reference/graphql-api/admin/object-types#emptyorderlineselectionerror)[ItemsAlreadyFulfilledError](/reference/graphql-api/admin/object-types#itemsalreadyfulfillederror)[InsufficientStockOnHandError](/reference/graphql-api/admin/object-types#insufficientstockonhanderror)[InvalidFulfillmentHandlerError](/reference/graphql-api/admin/object-types#invalidfulfillmenthandlererror)[FulfillmentStateTransitionError](/reference/graphql-api/admin/object-types#fulfillmentstatetransitionerror)[CreateFulfillmentError](/reference/graphql-api/admin/object-types#createfulfillmenterror)
## AddManualPaymentToOrderResult​


[​](#addmanualpaymenttoorderresult)[Order](/reference/graphql-api/admin/object-types#order)[ManualPaymentStateError](/reference/graphql-api/admin/object-types#manualpaymentstateerror)
## Address​


[​](#address)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Country](/reference/graphql-api/admin/object-types#country)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[JSON](/reference/graphql-api/admin/object-types#json)
## Adjustment​


[​](#adjustment)[String](/reference/graphql-api/admin/object-types#string)[AdjustmentType](/reference/graphql-api/admin/enums#adjustmenttype)[String](/reference/graphql-api/admin/object-types#string)[Money](/reference/graphql-api/admin/object-types#money)[JSON](/reference/graphql-api/admin/object-types#json)
## Administrator​


[​](#administrator)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[User](/reference/graphql-api/admin/object-types#user)[JSON](/reference/graphql-api/admin/object-types#json)
## AdministratorList​


[​](#administratorlist)[Administrator](/reference/graphql-api/admin/object-types#administrator)[Int](/reference/graphql-api/admin/object-types#int)
## Allocation​


[​](#allocation)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[ProductVariant](/reference/graphql-api/admin/object-types#productvariant)[StockMovementType](/reference/graphql-api/admin/enums#stockmovementtype)[Int](/reference/graphql-api/admin/object-types#int)[OrderLine](/reference/graphql-api/admin/object-types#orderline)[JSON](/reference/graphql-api/admin/object-types#json)
## AlreadyRefundedError​


[​](#alreadyrefundederror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[ID](/reference/graphql-api/admin/object-types#id)
## ApplyCouponCodeResult​


[​](#applycouponcoderesult)[Order](/reference/graphql-api/admin/object-types#order)[CouponCodeExpiredError](/reference/graphql-api/admin/object-types#couponcodeexpirederror)[CouponCodeInvalidError](/reference/graphql-api/admin/object-types#couponcodeinvaliderror)[CouponCodeLimitError](/reference/graphql-api/admin/object-types#couponcodelimiterror)
## Asset​


[​](#asset)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[String](/reference/graphql-api/admin/object-types#string)[AssetType](/reference/graphql-api/admin/enums#assettype)[Int](/reference/graphql-api/admin/object-types#int)[String](/reference/graphql-api/admin/object-types#string)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Coordinate](/reference/graphql-api/admin/object-types#coordinate)[Tag](/reference/graphql-api/admin/object-types#tag)[JSON](/reference/graphql-api/admin/object-types#json)
## AssetList​


[​](#assetlist)[Asset](/reference/graphql-api/admin/object-types#asset)[Int](/reference/graphql-api/admin/object-types#int)
## AuthenticationMethod​


[​](#authenticationmethod)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[String](/reference/graphql-api/admin/object-types#string)
## AuthenticationResult​


[​](#authenticationresult)[CurrentUser](/reference/graphql-api/admin/object-types#currentuser)[InvalidCredentialsError](/reference/graphql-api/admin/object-types#invalidcredentialserror)
## Boolean​


[​](#boolean)
## BooleanCustomFieldConfig​


[​](#booleancustomfieldconfig)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Permission](/reference/graphql-api/admin/enums#permission)[Boolean](/reference/graphql-api/admin/object-types#boolean)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## BooleanStructFieldConfig​


[​](#booleanstructfieldconfig)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[JSON](/reference/graphql-api/admin/object-types#json)
## CancelActiveOrderError​


[​](#cancelactiveordererror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## CancelOrderResult​


[​](#cancelorderresult)[Order](/reference/graphql-api/admin/object-types#order)[EmptyOrderLineSelectionError](/reference/graphql-api/admin/object-types#emptyorderlineselectionerror)[QuantityTooGreatError](/reference/graphql-api/admin/object-types#quantitytoogreaterror)[MultipleOrderError](/reference/graphql-api/admin/object-types#multipleordererror)[CancelActiveOrderError](/reference/graphql-api/admin/object-types#cancelactiveordererror)[OrderStateTransitionError](/reference/graphql-api/admin/object-types#orderstatetransitionerror)
## CancelPaymentError​


[​](#cancelpaymenterror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## CancelPaymentResult​


[​](#cancelpaymentresult)[Payment](/reference/graphql-api/admin/object-types#payment)[CancelPaymentError](/reference/graphql-api/admin/object-types#cancelpaymenterror)[PaymentStateTransitionError](/reference/graphql-api/admin/object-types#paymentstatetransitionerror)
## Cancellation​


[​](#cancellation)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[ProductVariant](/reference/graphql-api/admin/object-types#productvariant)[StockMovementType](/reference/graphql-api/admin/enums#stockmovementtype)[Int](/reference/graphql-api/admin/object-types#int)[OrderLine](/reference/graphql-api/admin/object-types#orderline)[JSON](/reference/graphql-api/admin/object-types#json)
## Channel​


[​](#channel)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Zone](/reference/graphql-api/admin/object-types#zone)[Zone](/reference/graphql-api/admin/object-types#zone)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[CurrencyCode](/reference/graphql-api/admin/enums#currencycode)[CurrencyCode](/reference/graphql-api/admin/enums#currencycode)[CurrencyCode](/reference/graphql-api/admin/enums#currencycode)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Int](/reference/graphql-api/admin/object-types#int)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Seller](/reference/graphql-api/admin/object-types#seller)[JSON](/reference/graphql-api/admin/object-types#json)
## ChannelDefaultLanguageError​


[​](#channeldefaultlanguageerror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## ChannelList​


[​](#channellist)[Channel](/reference/graphql-api/admin/object-types#channel)[Int](/reference/graphql-api/admin/object-types#int)
## Collection​


[​](#collection)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[CollectionBreadcrumb](/reference/graphql-api/admin/object-types#collectionbreadcrumb)[Int](/reference/graphql-api/admin/object-types#int)[String](/reference/graphql-api/admin/object-types#string)[Asset](/reference/graphql-api/admin/object-types#asset)[Asset](/reference/graphql-api/admin/object-types#asset)[Collection](/reference/graphql-api/admin/object-types#collection)[ID](/reference/graphql-api/admin/object-types#id)[Collection](/reference/graphql-api/admin/object-types#collection)[ConfigurableOperation](/reference/graphql-api/admin/object-types#configurableoperation)[CollectionTranslation](/reference/graphql-api/admin/object-types#collectiontranslation)[ProductVariantListOptions](/reference/graphql-api/admin/input-types#productvariantlistoptions)[ProductVariantList](/reference/graphql-api/admin/object-types#productvariantlist)[JSON](/reference/graphql-api/admin/object-types#json)
## CollectionBreadcrumb​


[​](#collectionbreadcrumb)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## CollectionList​


[​](#collectionlist)[Collection](/reference/graphql-api/admin/object-types#collection)[Int](/reference/graphql-api/admin/object-types#int)
## CollectionResult​


[​](#collectionresult)[Collection](/reference/graphql-api/admin/object-types#collection)[Int](/reference/graphql-api/admin/object-types#int)
## CollectionTranslation​


[​](#collectiontranslation)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## ConfigArg​


[​](#configarg)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## ConfigArgDefinition​


[​](#configargdefinition)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[JSON](/reference/graphql-api/admin/object-types#json)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## ConfigurableOperation​


[​](#configurableoperation)[String](/reference/graphql-api/admin/object-types#string)[ConfigArg](/reference/graphql-api/admin/object-types#configarg)
## ConfigurableOperationDefinition​


[​](#configurableoperationdefinition)[String](/reference/graphql-api/admin/object-types#string)[ConfigArgDefinition](/reference/graphql-api/admin/object-types#configargdefinition)[String](/reference/graphql-api/admin/object-types#string)
## Coordinate​


[​](#coordinate)[Float](/reference/graphql-api/admin/object-types#float)[Float](/reference/graphql-api/admin/object-types#float)
## Country​


[​](#country)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Region](/reference/graphql-api/admin/object-types#region)[ID](/reference/graphql-api/admin/object-types#id)[RegionTranslation](/reference/graphql-api/admin/object-types#regiontranslation)[JSON](/reference/graphql-api/admin/object-types#json)
## CountryList​


[​](#countrylist)[Country](/reference/graphql-api/admin/object-types#country)[Int](/reference/graphql-api/admin/object-types#int)
## CouponCodeExpiredError​


[​](#couponcodeexpirederror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## CouponCodeInvalidError​


[​](#couponcodeinvaliderror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## CouponCodeLimitError​


[​](#couponcodelimiterror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Int](/reference/graphql-api/admin/object-types#int)
## CreateAssetResult​


[​](#createassetresult)[Asset](/reference/graphql-api/admin/object-types#asset)[MimeTypeError](/reference/graphql-api/admin/object-types#mimetypeerror)
## CreateChannelResult​


[​](#createchannelresult)[Channel](/reference/graphql-api/admin/object-types#channel)[LanguageNotAvailableError](/reference/graphql-api/admin/object-types#languagenotavailableerror)
## CreateCustomerResult​


[​](#createcustomerresult)[Customer](/reference/graphql-api/admin/object-types#customer)[EmailAddressConflictError](/reference/graphql-api/admin/object-types#emailaddressconflicterror)
## CreateFulfillmentError​


[​](#createfulfillmenterror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## CreatePromotionResult​


[​](#createpromotionresult)[Promotion](/reference/graphql-api/admin/object-types#promotion)[MissingConditionsError](/reference/graphql-api/admin/object-types#missingconditionserror)
## CurrentUser​


[​](#currentuser)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[CurrentUserChannel](/reference/graphql-api/admin/object-types#currentuserchannel)
## CurrentUserChannel​


[​](#currentuserchannel)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Permission](/reference/graphql-api/admin/enums#permission)
## CustomFieldConfig​


[​](#customfieldconfig)[StringCustomFieldConfig](/reference/graphql-api/admin/object-types#stringcustomfieldconfig)[LocaleStringCustomFieldConfig](/reference/graphql-api/admin/object-types#localestringcustomfieldconfig)[IntCustomFieldConfig](/reference/graphql-api/admin/object-types#intcustomfieldconfig)[FloatCustomFieldConfig](/reference/graphql-api/admin/object-types#floatcustomfieldconfig)[BooleanCustomFieldConfig](/reference/graphql-api/admin/object-types#booleancustomfieldconfig)[DateTimeCustomFieldConfig](/reference/graphql-api/admin/object-types#datetimecustomfieldconfig)[RelationCustomFieldConfig](/reference/graphql-api/admin/object-types#relationcustomfieldconfig)[TextCustomFieldConfig](/reference/graphql-api/admin/object-types#textcustomfieldconfig)[LocaleTextCustomFieldConfig](/reference/graphql-api/admin/object-types#localetextcustomfieldconfig)[StructCustomFieldConfig](/reference/graphql-api/admin/object-types#structcustomfieldconfig)
## CustomFields​


[​](#customfields)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)
## Customer​


[​](#customer)[CustomerGroup](/reference/graphql-api/admin/object-types#customergroup)[HistoryEntryListOptions](/reference/graphql-api/admin/input-types#historyentrylistoptions)[HistoryEntryList](/reference/graphql-api/admin/object-types#historyentrylist)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Address](/reference/graphql-api/admin/object-types#address)[OrderListOptions](/reference/graphql-api/admin/input-types#orderlistoptions)[OrderList](/reference/graphql-api/admin/object-types#orderlist)[User](/reference/graphql-api/admin/object-types#user)[JSON](/reference/graphql-api/admin/object-types#json)
## CustomerGroup​


[​](#customergroup)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[String](/reference/graphql-api/admin/object-types#string)[CustomerListOptions](/reference/graphql-api/admin/input-types#customerlistoptions)[CustomerList](/reference/graphql-api/admin/object-types#customerlist)[JSON](/reference/graphql-api/admin/object-types#json)
## CustomerGroupList​


[​](#customergrouplist)[CustomerGroup](/reference/graphql-api/admin/object-types#customergroup)[Int](/reference/graphql-api/admin/object-types#int)
## CustomerList​


[​](#customerlist)[Customer](/reference/graphql-api/admin/object-types#customer)[Int](/reference/graphql-api/admin/object-types#int)
## DateTime​


[​](#datetime)
## DateTimeCustomFieldConfig​


[​](#datetimecustomfieldconfig)[https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/datetime-local#Additional_attributes](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/datetime-local#Additional_attributes)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Permission](/reference/graphql-api/admin/enums#permission)[Boolean](/reference/graphql-api/admin/object-types#boolean)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Int](/reference/graphql-api/admin/object-types#int)[JSON](/reference/graphql-api/admin/object-types#json)
## DateTimeStructFieldConfig​


[​](#datetimestructfieldconfig)[https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/datetime-local#Additional_attributes](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/datetime-local#Additional_attributes)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Int](/reference/graphql-api/admin/object-types#int)[JSON](/reference/graphql-api/admin/object-types#json)
## DeletionResponse​


[​](#deletionresponse)[DeletionResult](/reference/graphql-api/admin/enums#deletionresult)[String](/reference/graphql-api/admin/object-types#string)
## Discount​


[​](#discount)[String](/reference/graphql-api/admin/object-types#string)[AdjustmentType](/reference/graphql-api/admin/enums#adjustmenttype)[String](/reference/graphql-api/admin/object-types#string)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)
## DuplicateEntityError​


[​](#duplicateentityerror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## DuplicateEntityResult​


[​](#duplicateentityresult)[DuplicateEntitySuccess](/reference/graphql-api/admin/object-types#duplicateentitysuccess)[DuplicateEntityError](/reference/graphql-api/admin/object-types#duplicateentityerror)
## DuplicateEntitySuccess​


[​](#duplicateentitysuccess)[ID](/reference/graphql-api/admin/object-types#id)
## EmailAddressConflictError​


[​](#emailaddressconflicterror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)
## EmptyOrderLineSelectionError​


[​](#emptyorderlineselectionerror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)
## EntityCustomFields​


[​](#entitycustomfields)[String](/reference/graphql-api/admin/object-types#string)[CustomFieldConfig](/reference/graphql-api/admin/object-types#customfieldconfig)
## EntityDuplicatorDefinition​


[​](#entityduplicatordefinition)[String](/reference/graphql-api/admin/object-types#string)[ConfigArgDefinition](/reference/graphql-api/admin/object-types#configargdefinition)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Permission](/reference/graphql-api/admin/enums#permission)
## Facet​


[​](#facet)[Boolean](/reference/graphql-api/admin/object-types#boolean)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[FacetValue](/reference/graphql-api/admin/object-types#facetvalue)[FacetValueListOptions](/reference/graphql-api/admin/input-types#facetvaluelistoptions)[FacetValueList](/reference/graphql-api/admin/object-types#facetvaluelist)[FacetTranslation](/reference/graphql-api/admin/object-types#facettranslation)[JSON](/reference/graphql-api/admin/object-types#json)
## FacetInUseError​


[​](#facetinuseerror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)
## FacetList​


[​](#facetlist)[Facet](/reference/graphql-api/admin/object-types#facet)[Int](/reference/graphql-api/admin/object-types#int)
## FacetTranslation​


[​](#facettranslation)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)
## FacetValue​


[​](#facetvalue)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[Facet](/reference/graphql-api/admin/object-types#facet)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[FacetValueTranslation](/reference/graphql-api/admin/object-types#facetvaluetranslation)[JSON](/reference/graphql-api/admin/object-types#json)
## FacetValueList​


[​](#facetvaluelist)[FacetValue](/reference/graphql-api/admin/object-types#facetvalue)[Int](/reference/graphql-api/admin/object-types#int)
## FacetValueResult​


[​](#facetvalueresult)[FacetValue](/reference/graphql-api/admin/object-types#facetvalue)[Int](/reference/graphql-api/admin/object-types#int)
## FacetValueTranslation​


[​](#facetvaluetranslation)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)
## Float​


[​](#float)[IEEE 754](https://en.wikipedia.org/wiki/IEEE_floating_point)
## FloatCustomFieldConfig​


[​](#floatcustomfieldconfig)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Permission](/reference/graphql-api/admin/enums#permission)[Boolean](/reference/graphql-api/admin/object-types#boolean)[String](/reference/graphql-api/admin/object-types#string)[Float](/reference/graphql-api/admin/object-types#float)[Float](/reference/graphql-api/admin/object-types#float)[Float](/reference/graphql-api/admin/object-types#float)[JSON](/reference/graphql-api/admin/object-types#json)
## FloatStructFieldConfig​


[​](#floatstructfieldconfig)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[Float](/reference/graphql-api/admin/object-types#float)[Float](/reference/graphql-api/admin/object-types#float)[Float](/reference/graphql-api/admin/object-types#float)[JSON](/reference/graphql-api/admin/object-types#json)
## Fulfillment​


[​](#fulfillment)[String](/reference/graphql-api/admin/object-types#string)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[FulfillmentLine](/reference/graphql-api/admin/object-types#fulfillmentline)[FulfillmentLine](/reference/graphql-api/admin/object-types#fulfillmentline)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## FulfillmentLine​


[​](#fulfillmentline)[OrderLine](/reference/graphql-api/admin/object-types#orderline)[ID](/reference/graphql-api/admin/object-types#id)[Int](/reference/graphql-api/admin/object-types#int)[Fulfillment](/reference/graphql-api/admin/object-types#fulfillment)[ID](/reference/graphql-api/admin/object-types#id)
## FulfillmentStateTransitionError​


[​](#fulfillmentstatetransitionerror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## GlobalSettings​


[​](#globalsettings)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Int](/reference/graphql-api/admin/object-types#int)[ServerConfig](/reference/graphql-api/admin/object-types#serverconfig)[JSON](/reference/graphql-api/admin/object-types#json)
## GuestCheckoutError​


[​](#guestcheckouterror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## HistoryEntry​


[​](#historyentry)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Administrator](/reference/graphql-api/admin/object-types#administrator)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[HistoryEntryType](/reference/graphql-api/admin/enums#historyentrytype)[JSON](/reference/graphql-api/admin/object-types#json)[JSON](/reference/graphql-api/admin/object-types#json)
## HistoryEntryList​


[​](#historyentrylist)[HistoryEntry](/reference/graphql-api/admin/object-types#historyentry)[Int](/reference/graphql-api/admin/object-types#int)
## ID​


[​](#id)
## ImportInfo​


[​](#importinfo)[String](/reference/graphql-api/admin/object-types#string)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)
## IneligibleShippingMethodError​


[​](#ineligibleshippingmethoderror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)
## InsufficientStockError​


[​](#insufficientstockerror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[Int](/reference/graphql-api/admin/object-types#int)[Order](/reference/graphql-api/admin/object-types#order)
## InsufficientStockOnHandError​


[​](#insufficientstockonhanderror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[Int](/reference/graphql-api/admin/object-types#int)
## Int​


[​](#int)
## IntCustomFieldConfig​


[​](#intcustomfieldconfig)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Permission](/reference/graphql-api/admin/enums#permission)[Boolean](/reference/graphql-api/admin/object-types#boolean)[String](/reference/graphql-api/admin/object-types#string)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[JSON](/reference/graphql-api/admin/object-types#json)
## IntStructFieldConfig​


[​](#intstructfieldconfig)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[JSON](/reference/graphql-api/admin/object-types#json)
## InvalidCredentialsError​


[​](#invalidcredentialserror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## InvalidFulfillmentHandlerError​


[​](#invalidfulfillmenthandlererror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)
## ItemsAlreadyFulfilledError​


[​](#itemsalreadyfulfillederror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)
## JSON​


[​](#json)[ECMA-404](http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-404.pdf)
## Job​


[​](#job)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[String](/reference/graphql-api/admin/object-types#string)[JobState](/reference/graphql-api/admin/enums#jobstate)[Float](/reference/graphql-api/admin/object-types#float)[JSON](/reference/graphql-api/admin/object-types#json)[JSON](/reference/graphql-api/admin/object-types#json)[JSON](/reference/graphql-api/admin/object-types#json)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)
## JobBufferSize​


[​](#jobbuffersize)[String](/reference/graphql-api/admin/object-types#string)[Int](/reference/graphql-api/admin/object-types#int)
## JobList​


[​](#joblist)[Job](/reference/graphql-api/admin/object-types#job)[Int](/reference/graphql-api/admin/object-types#int)
## JobQueue​


[​](#jobqueue)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)
## LanguageNotAvailableError​


[​](#languagenotavailableerror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## LocaleStringCustomFieldConfig​


[​](#localestringcustomfieldconfig)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Int](/reference/graphql-api/admin/object-types#int)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Permission](/reference/graphql-api/admin/enums#permission)[Boolean](/reference/graphql-api/admin/object-types#boolean)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## LocaleTextCustomFieldConfig​


[​](#localetextcustomfieldconfig)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Permission](/reference/graphql-api/admin/enums#permission)[Boolean](/reference/graphql-api/admin/object-types#boolean)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## LocalizedString​


[​](#localizedstring)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)
## ManualPaymentStateError​


[​](#manualpaymentstateerror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)
## MetricSummary​


[​](#metricsummary)[MetricInterval](/reference/graphql-api/admin/enums#metricinterval)[MetricType](/reference/graphql-api/admin/enums#metrictype)[String](/reference/graphql-api/admin/object-types#string)[MetricSummaryEntry](/reference/graphql-api/admin/object-types#metricsummaryentry)
## MetricSummaryEntry​


[​](#metricsummaryentry)[String](/reference/graphql-api/admin/object-types#string)[Float](/reference/graphql-api/admin/object-types#float)
## MimeTypeError​


[​](#mimetypeerror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## MissingConditionsError​


[​](#missingconditionserror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)
## ModifyOrderResult​


[​](#modifyorderresult)[Order](/reference/graphql-api/admin/object-types#order)[NoChangesSpecifiedError](/reference/graphql-api/admin/object-types#nochangesspecifiederror)[OrderModificationStateError](/reference/graphql-api/admin/object-types#ordermodificationstateerror)[PaymentMethodMissingError](/reference/graphql-api/admin/object-types#paymentmethodmissingerror)[RefundPaymentIdMissingError](/reference/graphql-api/admin/object-types#refundpaymentidmissingerror)[OrderLimitError](/reference/graphql-api/admin/object-types#orderlimiterror)[NegativeQuantityError](/reference/graphql-api/admin/object-types#negativequantityerror)[InsufficientStockError](/reference/graphql-api/admin/object-types#insufficientstockerror)[CouponCodeExpiredError](/reference/graphql-api/admin/object-types#couponcodeexpirederror)[CouponCodeInvalidError](/reference/graphql-api/admin/object-types#couponcodeinvaliderror)[CouponCodeLimitError](/reference/graphql-api/admin/object-types#couponcodelimiterror)[IneligibleShippingMethodError](/reference/graphql-api/admin/object-types#ineligibleshippingmethoderror)
## Money​


[​](#money)[IEEE 754](https://en.wikipedia.org/wiki/IEEE_floating_point)
## MultipleOrderError​


[​](#multipleordererror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)
## NativeAuthStrategyError​


[​](#nativeauthstrategyerror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)
## NativeAuthenticationResult​


[​](#nativeauthenticationresult)[CurrentUser](/reference/graphql-api/admin/object-types#currentuser)[InvalidCredentialsError](/reference/graphql-api/admin/object-types#invalidcredentialserror)[NativeAuthStrategyError](/reference/graphql-api/admin/object-types#nativeauthstrategyerror)
## NegativeQuantityError​


[​](#negativequantityerror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)
## NoActiveOrderError​


[​](#noactiveordererror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)
## NoChangesSpecifiedError​


[​](#nochangesspecifiederror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)
## NothingToRefundError​


[​](#nothingtorefunderror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)
## Order​


[​](#order)[String](/reference/graphql-api/admin/object-types#string)[OrderModification](/reference/graphql-api/admin/object-types#ordermodification)[Order](/reference/graphql-api/admin/object-types#order)[Order](/reference/graphql-api/admin/object-types#order)[ID](/reference/graphql-api/admin/object-types#id)[Channel](/reference/graphql-api/admin/object-types#channel)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[OrderType](/reference/graphql-api/admin/enums#ordertype)[DateTime](/reference/graphql-api/admin/object-types#datetime)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Customer](/reference/graphql-api/admin/object-types#customer)[OrderAddress](/reference/graphql-api/admin/object-types#orderaddress)[OrderAddress](/reference/graphql-api/admin/object-types#orderaddress)[OrderLine](/reference/graphql-api/admin/object-types#orderline)[Surcharge](/reference/graphql-api/admin/object-types#surcharge)[Discount](/reference/graphql-api/admin/object-types#discount)[String](/reference/graphql-api/admin/object-types#string)[Promotion](/reference/graphql-api/admin/object-types#promotion)[Payment](/reference/graphql-api/admin/object-types#payment)[Fulfillment](/reference/graphql-api/admin/object-types#fulfillment)[Int](/reference/graphql-api/admin/object-types#int)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[CurrencyCode](/reference/graphql-api/admin/enums#currencycode)[ShippingLine](/reference/graphql-api/admin/object-types#shippingline)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[OrderTaxSummary](/reference/graphql-api/admin/object-types#ordertaxsummary)[HistoryEntryListOptions](/reference/graphql-api/admin/input-types#historyentrylistoptions)[HistoryEntryList](/reference/graphql-api/admin/object-types#historyentrylist)[JSON](/reference/graphql-api/admin/object-types#json)
## OrderAddress​


[​](#orderaddress)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## OrderInterceptorError​


[​](#orderinterceptorerror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## OrderLimitError​


[​](#orderlimiterror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[Int](/reference/graphql-api/admin/object-types#int)
## OrderLine​


[​](#orderline)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[ProductVariant](/reference/graphql-api/admin/object-types#productvariant)[Asset](/reference/graphql-api/admin/object-types#asset)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[Float](/reference/graphql-api/admin/object-types#float)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[Discount](/reference/graphql-api/admin/object-types#discount)[TaxLine](/reference/graphql-api/admin/object-types#taxline)[Order](/reference/graphql-api/admin/object-types#order)[FulfillmentLine](/reference/graphql-api/admin/object-types#fulfillmentline)[JSON](/reference/graphql-api/admin/object-types#json)
## OrderList​


[​](#orderlist)[Order](/reference/graphql-api/admin/object-types#order)[Int](/reference/graphql-api/admin/object-types#int)
## OrderModification​


[​](#ordermodification)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[Money](/reference/graphql-api/admin/object-types#money)[String](/reference/graphql-api/admin/object-types#string)[OrderModificationLine](/reference/graphql-api/admin/object-types#ordermodificationline)[Surcharge](/reference/graphql-api/admin/object-types#surcharge)[Payment](/reference/graphql-api/admin/object-types#payment)[Refund](/reference/graphql-api/admin/object-types#refund)[Boolean](/reference/graphql-api/admin/object-types#boolean)
## OrderModificationError​


[​](#ordermodificationerror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)
## OrderModificationLine​


[​](#ordermodificationline)[OrderLine](/reference/graphql-api/admin/object-types#orderline)[ID](/reference/graphql-api/admin/object-types#id)[Int](/reference/graphql-api/admin/object-types#int)[OrderModification](/reference/graphql-api/admin/object-types#ordermodification)[ID](/reference/graphql-api/admin/object-types#id)
## OrderModificationStateError​


[​](#ordermodificationstateerror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)
## OrderProcessState​


[​](#orderprocessstate)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## OrderStateTransitionError​


[​](#orderstatetransitionerror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## OrderTaxSummary​


[​](#ordertaxsummary)[String](/reference/graphql-api/admin/object-types#string)[Float](/reference/graphql-api/admin/object-types#float)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)
## Payment​


[​](#payment)[String](/reference/graphql-api/admin/object-types#string)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[String](/reference/graphql-api/admin/object-types#string)[Money](/reference/graphql-api/admin/object-types#money)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Refund](/reference/graphql-api/admin/object-types#refund)[JSON](/reference/graphql-api/admin/object-types#json)[JSON](/reference/graphql-api/admin/object-types#json)
## PaymentMethod​


[​](#paymentmethod)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[ConfigurableOperation](/reference/graphql-api/admin/object-types#configurableoperation)[ConfigurableOperation](/reference/graphql-api/admin/object-types#configurableoperation)[PaymentMethodTranslation](/reference/graphql-api/admin/object-types#paymentmethodtranslation)[JSON](/reference/graphql-api/admin/object-types#json)
## PaymentMethodList​


[​](#paymentmethodlist)[PaymentMethod](/reference/graphql-api/admin/object-types#paymentmethod)[Int](/reference/graphql-api/admin/object-types#int)
## PaymentMethodMissingError​


[​](#paymentmethodmissingerror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)
## PaymentMethodQuote​


[​](#paymentmethodquote)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## PaymentMethodTranslation​


[​](#paymentmethodtranslation)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## PaymentOrderMismatchError​


[​](#paymentordermismatcherror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)
## PaymentStateTransitionError​


[​](#paymentstatetransitionerror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## PermissionDefinition​


[​](#permissiondefinition)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)
## PriceRange​


[​](#pricerange)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)
## Product​


[​](#product)[Channel](/reference/graphql-api/admin/object-types#channel)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Asset](/reference/graphql-api/admin/object-types#asset)[Asset](/reference/graphql-api/admin/object-types#asset)[ProductVariant](/reference/graphql-api/admin/object-types#productvariant)[ProductVariantListOptions](/reference/graphql-api/admin/input-types#productvariantlistoptions)[ProductVariantList](/reference/graphql-api/admin/object-types#productvariantlist)[ProductOptionGroup](/reference/graphql-api/admin/object-types#productoptiongroup)[FacetValue](/reference/graphql-api/admin/object-types#facetvalue)[ProductTranslation](/reference/graphql-api/admin/object-types#producttranslation)[Collection](/reference/graphql-api/admin/object-types#collection)[JSON](/reference/graphql-api/admin/object-types#json)
## ProductList​


[​](#productlist)[Product](/reference/graphql-api/admin/object-types#product)[Int](/reference/graphql-api/admin/object-types#int)
## ProductOption​


[​](#productoption)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[ID](/reference/graphql-api/admin/object-types#id)[ProductOptionGroup](/reference/graphql-api/admin/object-types#productoptiongroup)[ProductOptionTranslation](/reference/graphql-api/admin/object-types#productoptiontranslation)[JSON](/reference/graphql-api/admin/object-types#json)
## ProductOptionGroup​


[​](#productoptiongroup)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[ProductOption](/reference/graphql-api/admin/object-types#productoption)[ProductOptionGroupTranslation](/reference/graphql-api/admin/object-types#productoptiongrouptranslation)[JSON](/reference/graphql-api/admin/object-types#json)
## ProductOptionGroupTranslation​


[​](#productoptiongrouptranslation)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)
## ProductOptionInUseError​


[​](#productoptioninuseerror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Int](/reference/graphql-api/admin/object-types#int)
## ProductOptionList​


[​](#productoptionlist)[Int](/reference/graphql-api/admin/object-types#int)[ProductOption](/reference/graphql-api/admin/object-types#productoption)
## ProductOptionTranslation​


[​](#productoptiontranslation)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)
## ProductTranslation​


[​](#producttranslation)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## ProductVariant​


[​](#productvariant)[Boolean](/reference/graphql-api/admin/object-types#boolean)[GlobalFlag](/reference/graphql-api/admin/enums#globalflag)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[Boolean](/reference/graphql-api/admin/object-types#boolean)[ProductVariantPrice](/reference/graphql-api/admin/object-types#productvariantprice)[StockLevel](/reference/graphql-api/admin/object-types#stocklevel)[StockMovementListOptions](/reference/graphql-api/admin/input-types#stockmovementlistoptions)[StockMovementList](/reference/graphql-api/admin/object-types#stockmovementlist)[Channel](/reference/graphql-api/admin/object-types#channel)[ID](/reference/graphql-api/admin/object-types#id)[Product](/reference/graphql-api/admin/object-types#product)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Asset](/reference/graphql-api/admin/object-types#asset)[Asset](/reference/graphql-api/admin/object-types#asset)[Money](/reference/graphql-api/admin/object-types#money)[CurrencyCode](/reference/graphql-api/admin/enums#currencycode)[Money](/reference/graphql-api/admin/object-types#money)[String](/reference/graphql-api/admin/object-types#string)[TaxRate](/reference/graphql-api/admin/object-types#taxrate)[TaxCategory](/reference/graphql-api/admin/object-types#taxcategory)[ProductOption](/reference/graphql-api/admin/object-types#productoption)[FacetValue](/reference/graphql-api/admin/object-types#facetvalue)[ProductVariantTranslation](/reference/graphql-api/admin/object-types#productvarianttranslation)[JSON](/reference/graphql-api/admin/object-types#json)
## ProductVariantList​


[​](#productvariantlist)[ProductVariant](/reference/graphql-api/admin/object-types#productvariant)[Int](/reference/graphql-api/admin/object-types#int)
## ProductVariantPrice​


[​](#productvariantprice)[CurrencyCode](/reference/graphql-api/admin/enums#currencycode)[Money](/reference/graphql-api/admin/object-types#money)[JSON](/reference/graphql-api/admin/object-types#json)
## ProductVariantTranslation​


[​](#productvarianttranslation)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)
## Promotion​


[​](#promotion)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[String](/reference/graphql-api/admin/object-types#string)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[ConfigurableOperation](/reference/graphql-api/admin/object-types#configurableoperation)[ConfigurableOperation](/reference/graphql-api/admin/object-types#configurableoperation)[PromotionTranslation](/reference/graphql-api/admin/object-types#promotiontranslation)[JSON](/reference/graphql-api/admin/object-types#json)
## PromotionList​


[​](#promotionlist)[Promotion](/reference/graphql-api/admin/object-types#promotion)[Int](/reference/graphql-api/admin/object-types#int)
## PromotionTranslation​


[​](#promotiontranslation)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## Province​


[​](#province)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Region](/reference/graphql-api/admin/object-types#region)[ID](/reference/graphql-api/admin/object-types#id)[RegionTranslation](/reference/graphql-api/admin/object-types#regiontranslation)[JSON](/reference/graphql-api/admin/object-types#json)
## ProvinceList​


[​](#provincelist)[Province](/reference/graphql-api/admin/object-types#province)[Int](/reference/graphql-api/admin/object-types#int)
## QuantityTooGreatError​


[​](#quantitytoogreaterror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)
## Refund​


[​](#refund)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[RefundLine](/reference/graphql-api/admin/object-types#refundline)[ID](/reference/graphql-api/admin/object-types#id)[JSON](/reference/graphql-api/admin/object-types#json)[JSON](/reference/graphql-api/admin/object-types#json)
## RefundAmountError​


[​](#refundamounterror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[Int](/reference/graphql-api/admin/object-types#int)
## RefundLine​


[​](#refundline)[OrderLine](/reference/graphql-api/admin/object-types#orderline)[ID](/reference/graphql-api/admin/object-types#id)[Int](/reference/graphql-api/admin/object-types#int)[Refund](/reference/graphql-api/admin/object-types#refund)[ID](/reference/graphql-api/admin/object-types#id)
## RefundOrderResult​


[​](#refundorderresult)[Refund](/reference/graphql-api/admin/object-types#refund)[QuantityTooGreatError](/reference/graphql-api/admin/object-types#quantitytoogreaterror)[NothingToRefundError](/reference/graphql-api/admin/object-types#nothingtorefunderror)[OrderStateTransitionError](/reference/graphql-api/admin/object-types#orderstatetransitionerror)[MultipleOrderError](/reference/graphql-api/admin/object-types#multipleordererror)[PaymentOrderMismatchError](/reference/graphql-api/admin/object-types#paymentordermismatcherror)[RefundOrderStateError](/reference/graphql-api/admin/object-types#refundorderstateerror)[AlreadyRefundedError](/reference/graphql-api/admin/object-types#alreadyrefundederror)[RefundStateTransitionError](/reference/graphql-api/admin/object-types#refundstatetransitionerror)[RefundAmountError](/reference/graphql-api/admin/object-types#refundamounterror)
## RefundOrderStateError​


[​](#refundorderstateerror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## RefundPaymentIdMissingError​


[​](#refundpaymentidmissingerror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)
## RefundStateTransitionError​


[​](#refundstatetransitionerror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## RegionTranslation​


[​](#regiontranslation)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)
## RelationCustomFieldConfig​


[​](#relationcustomfieldconfig)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Permission](/reference/graphql-api/admin/enums#permission)[Boolean](/reference/graphql-api/admin/object-types#boolean)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## Release​


[​](#release)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[ProductVariant](/reference/graphql-api/admin/object-types#productvariant)[StockMovementType](/reference/graphql-api/admin/enums#stockmovementtype)[Int](/reference/graphql-api/admin/object-types#int)[JSON](/reference/graphql-api/admin/object-types#json)
## RemoveFacetFromChannelResult​


[​](#removefacetfromchannelresult)[Facet](/reference/graphql-api/admin/object-types#facet)[FacetInUseError](/reference/graphql-api/admin/object-types#facetinuseerror)
## RemoveOptionGroupFromProductResult​


[​](#removeoptiongroupfromproductresult)[Product](/reference/graphql-api/admin/object-types#product)[ProductOptionInUseError](/reference/graphql-api/admin/object-types#productoptioninuseerror)
## RemoveOrderItemsResult​


[​](#removeorderitemsresult)[Order](/reference/graphql-api/admin/object-types#order)[OrderModificationError](/reference/graphql-api/admin/object-types#ordermodificationerror)[OrderInterceptorError](/reference/graphql-api/admin/object-types#orderinterceptorerror)
## Return​


[​](#return)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[ProductVariant](/reference/graphql-api/admin/object-types#productvariant)[StockMovementType](/reference/graphql-api/admin/enums#stockmovementtype)[Int](/reference/graphql-api/admin/object-types#int)[JSON](/reference/graphql-api/admin/object-types#json)
## Role​


[​](#role)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Permission](/reference/graphql-api/admin/enums#permission)[Channel](/reference/graphql-api/admin/object-types#channel)
## RoleList​


[​](#rolelist)[Role](/reference/graphql-api/admin/object-types#role)[Int](/reference/graphql-api/admin/object-types#int)
## Sale​


[​](#sale)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[ProductVariant](/reference/graphql-api/admin/object-types#productvariant)[StockMovementType](/reference/graphql-api/admin/enums#stockmovementtype)[Int](/reference/graphql-api/admin/object-types#int)[JSON](/reference/graphql-api/admin/object-types#json)
## ScheduledTask​


[​](#scheduledtask)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[Boolean](/reference/graphql-api/admin/object-types#boolean)[JSON](/reference/graphql-api/admin/object-types#json)[Boolean](/reference/graphql-api/admin/object-types#boolean)
## SearchReindexResponse​


[​](#searchreindexresponse)[Boolean](/reference/graphql-api/admin/object-types#boolean)
## SearchResponse​


[​](#searchresponse)[SearchResult](/reference/graphql-api/admin/object-types#searchresult)[Int](/reference/graphql-api/admin/object-types#int)[FacetValueResult](/reference/graphql-api/admin/object-types#facetvalueresult)[CollectionResult](/reference/graphql-api/admin/object-types#collectionresult)
## SearchResult​


[​](#searchresult)[Boolean](/reference/graphql-api/admin/object-types#boolean)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[SearchResultAsset](/reference/graphql-api/admin/object-types#searchresultasset)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[SearchResultAsset](/reference/graphql-api/admin/object-types#searchresultasset)[SearchResultPrice](/reference/graphql-api/admin/object-types#searchresultprice)[SearchResultPrice](/reference/graphql-api/admin/object-types#searchresultprice)[CurrencyCode](/reference/graphql-api/admin/enums#currencycode)[String](/reference/graphql-api/admin/object-types#string)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[ID](/reference/graphql-api/admin/object-types#id)[Float](/reference/graphql-api/admin/object-types#float)
## SearchResultAsset​


[​](#searchresultasset)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[Coordinate](/reference/graphql-api/admin/object-types#coordinate)
## SearchResultPrice​


[​](#searchresultprice)[PriceRange](/reference/graphql-api/admin/object-types#pricerange)[SinglePrice](/reference/graphql-api/admin/object-types#singleprice)
## Seller​


[​](#seller)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## SellerList​


[​](#sellerlist)[Seller](/reference/graphql-api/admin/object-types#seller)[Int](/reference/graphql-api/admin/object-types#int)
## ServerConfig​


[​](#serverconfig)[OrderProcessState](/reference/graphql-api/admin/object-types#orderprocessstate)[String](/reference/graphql-api/admin/object-types#string)[PermissionDefinition](/reference/graphql-api/admin/object-types#permissiondefinition)[Int](/reference/graphql-api/admin/object-types#int)[CustomFields](/reference/graphql-api/admin/object-types#customfields)[EntityCustomFields](/reference/graphql-api/admin/object-types#entitycustomfields)
## SetCustomerForDraftOrderResult​


[​](#setcustomerfordraftorderresult)[Order](/reference/graphql-api/admin/object-types#order)[EmailAddressConflictError](/reference/graphql-api/admin/object-types#emailaddressconflicterror)
## SetOrderShippingMethodResult​


[​](#setordershippingmethodresult)[Order](/reference/graphql-api/admin/object-types#order)[OrderModificationError](/reference/graphql-api/admin/object-types#ordermodificationerror)[IneligibleShippingMethodError](/reference/graphql-api/admin/object-types#ineligibleshippingmethoderror)[NoActiveOrderError](/reference/graphql-api/admin/object-types#noactiveordererror)
## SetSettingsStoreValueResult​


[​](#setsettingsstorevalueresult)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[String](/reference/graphql-api/admin/object-types#string)
## SettlePaymentError​


[​](#settlepaymenterror)[ErrorCode](/reference/graphql-api/admin/enums#errorcode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## SettlePaymentResult​


[​](#settlepaymentresult)[Payment](/reference/graphql-api/admin/object-types#payment)[SettlePaymentError](/reference/graphql-api/admin/object-types#settlepaymenterror)[PaymentStateTransitionError](/reference/graphql-api/admin/object-types#paymentstatetransitionerror)[OrderStateTransitionError](/reference/graphql-api/admin/object-types#orderstatetransitionerror)
## SettleRefundResult​


[​](#settlerefundresult)[Refund](/reference/graphql-api/admin/object-types#refund)[RefundStateTransitionError](/reference/graphql-api/admin/object-types#refundstatetransitionerror)
## ShippingLine​


[​](#shippingline)[ID](/reference/graphql-api/admin/object-types#id)[ShippingMethod](/reference/graphql-api/admin/object-types#shippingmethod)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[Discount](/reference/graphql-api/admin/object-types#discount)[JSON](/reference/graphql-api/admin/object-types#json)
## ShippingMethod​


[​](#shippingmethod)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[ConfigurableOperation](/reference/graphql-api/admin/object-types#configurableoperation)[ConfigurableOperation](/reference/graphql-api/admin/object-types#configurableoperation)[ShippingMethodTranslation](/reference/graphql-api/admin/object-types#shippingmethodtranslation)[JSON](/reference/graphql-api/admin/object-types#json)
## ShippingMethodList​


[​](#shippingmethodlist)[ShippingMethod](/reference/graphql-api/admin/object-types#shippingmethod)[Int](/reference/graphql-api/admin/object-types#int)
## ShippingMethodQuote​


[​](#shippingmethodquote)[ID](/reference/graphql-api/admin/object-types#id)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)[JSON](/reference/graphql-api/admin/object-types#json)
## ShippingMethodTranslation​


[​](#shippingmethodtranslation)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[LanguageCode](/reference/graphql-api/admin/enums#languagecode)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)
## SinglePrice​


[​](#singleprice)[Money](/reference/graphql-api/admin/object-types#money)
## StockAdjustment​


[​](#stockadjustment)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[ProductVariant](/reference/graphql-api/admin/object-types#productvariant)[StockMovementType](/reference/graphql-api/admin/enums#stockmovementtype)[Int](/reference/graphql-api/admin/object-types#int)[JSON](/reference/graphql-api/admin/object-types#json)
## StockLevel​


[​](#stocklevel)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[ID](/reference/graphql-api/admin/object-types#id)[Int](/reference/graphql-api/admin/object-types#int)[Int](/reference/graphql-api/admin/object-types#int)[StockLocation](/reference/graphql-api/admin/object-types#stocklocation)[JSON](/reference/graphql-api/admin/object-types#json)
## StockLocation​


[​](#stocklocation)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## StockLocationList​


[​](#stocklocationlist)[StockLocation](/reference/graphql-api/admin/object-types#stocklocation)[Int](/reference/graphql-api/admin/object-types#int)
## StockMovementItem​


[​](#stockmovementitem)[StockAdjustment](/reference/graphql-api/admin/object-types#stockadjustment)[Allocation](/reference/graphql-api/admin/object-types#allocation)[Sale](/reference/graphql-api/admin/object-types#sale)[Cancellation](/reference/graphql-api/admin/object-types#cancellation)[Return](/reference/graphql-api/admin/object-types#return)[Release](/reference/graphql-api/admin/object-types#release)
## StockMovementList​


[​](#stockmovementlist)[StockMovementItem](/reference/graphql-api/admin/object-types#stockmovementitem)[Int](/reference/graphql-api/admin/object-types#int)
## String​


[​](#string)
## StringCustomFieldConfig​


[​](#stringcustomfieldconfig)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Int](/reference/graphql-api/admin/object-types#int)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Permission](/reference/graphql-api/admin/enums#permission)[Boolean](/reference/graphql-api/admin/object-types#boolean)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[StringFieldOption](/reference/graphql-api/admin/object-types#stringfieldoption)[JSON](/reference/graphql-api/admin/object-types#json)
## StringFieldOption​


[​](#stringfieldoption)[String](/reference/graphql-api/admin/object-types#string)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)
## StringStructFieldConfig​


[​](#stringstructfieldconfig)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[Int](/reference/graphql-api/admin/object-types#int)[String](/reference/graphql-api/admin/object-types#string)[StringFieldOption](/reference/graphql-api/admin/object-types#stringfieldoption)[JSON](/reference/graphql-api/admin/object-types#json)
## StructCustomFieldConfig​


[​](#structcustomfieldconfig)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[StructFieldConfig](/reference/graphql-api/admin/object-types#structfieldconfig)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Permission](/reference/graphql-api/admin/enums#permission)[Boolean](/reference/graphql-api/admin/object-types#boolean)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## StructFieldConfig​


[​](#structfieldconfig)[StringStructFieldConfig](/reference/graphql-api/admin/object-types#stringstructfieldconfig)[IntStructFieldConfig](/reference/graphql-api/admin/object-types#intstructfieldconfig)[FloatStructFieldConfig](/reference/graphql-api/admin/object-types#floatstructfieldconfig)[BooleanStructFieldConfig](/reference/graphql-api/admin/object-types#booleanstructfieldconfig)[DateTimeStructFieldConfig](/reference/graphql-api/admin/object-types#datetimestructfieldconfig)[TextStructFieldConfig](/reference/graphql-api/admin/object-types#textstructfieldconfig)
## Success​


[​](#success)[Boolean](/reference/graphql-api/admin/object-types#boolean)
## Surcharge​


[​](#surcharge)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[TaxLine](/reference/graphql-api/admin/object-types#taxline)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[Float](/reference/graphql-api/admin/object-types#float)
## Tag​


[​](#tag)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[String](/reference/graphql-api/admin/object-types#string)
## TagList​


[​](#taglist)[Tag](/reference/graphql-api/admin/object-types#tag)[Int](/reference/graphql-api/admin/object-types#int)
## TaxCategory​


[​](#taxcategory)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[JSON](/reference/graphql-api/admin/object-types#json)
## TaxCategoryList​


[​](#taxcategorylist)[TaxCategory](/reference/graphql-api/admin/object-types#taxcategory)[Int](/reference/graphql-api/admin/object-types#int)
## TaxLine​


[​](#taxline)[String](/reference/graphql-api/admin/object-types#string)[Float](/reference/graphql-api/admin/object-types#float)
## TaxRate​


[​](#taxrate)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Float](/reference/graphql-api/admin/object-types#float)[TaxCategory](/reference/graphql-api/admin/object-types#taxcategory)[Zone](/reference/graphql-api/admin/object-types#zone)[CustomerGroup](/reference/graphql-api/admin/object-types#customergroup)[JSON](/reference/graphql-api/admin/object-types#json)
## TaxRateList​


[​](#taxratelist)[TaxRate](/reference/graphql-api/admin/object-types#taxrate)[Int](/reference/graphql-api/admin/object-types#int)
## TestShippingMethodQuote​


[​](#testshippingmethodquote)[Money](/reference/graphql-api/admin/object-types#money)[Money](/reference/graphql-api/admin/object-types#money)[JSON](/reference/graphql-api/admin/object-types#json)
## TestShippingMethodResult​


[​](#testshippingmethodresult)[Boolean](/reference/graphql-api/admin/object-types#boolean)[TestShippingMethodQuote](/reference/graphql-api/admin/object-types#testshippingmethodquote)
## TextCustomFieldConfig​


[​](#textcustomfieldconfig)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Permission](/reference/graphql-api/admin/enums#permission)[Boolean](/reference/graphql-api/admin/object-types#boolean)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## TextStructFieldConfig​


[​](#textstructfieldconfig)[String](/reference/graphql-api/admin/object-types#string)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[LocalizedString](/reference/graphql-api/admin/object-types#localizedstring)[JSON](/reference/graphql-api/admin/object-types#json)
## TransitionFulfillmentToStateResult​


[​](#transitionfulfillmenttostateresult)[Fulfillment](/reference/graphql-api/admin/object-types#fulfillment)[FulfillmentStateTransitionError](/reference/graphql-api/admin/object-types#fulfillmentstatetransitionerror)
## TransitionOrderToStateResult​


[​](#transitionordertostateresult)[Order](/reference/graphql-api/admin/object-types#order)[OrderStateTransitionError](/reference/graphql-api/admin/object-types#orderstatetransitionerror)
## TransitionPaymentToStateResult​


[​](#transitionpaymenttostateresult)[Payment](/reference/graphql-api/admin/object-types#payment)[PaymentStateTransitionError](/reference/graphql-api/admin/object-types#paymentstatetransitionerror)
## UpdateChannelResult​


[​](#updatechannelresult)[Channel](/reference/graphql-api/admin/object-types#channel)[LanguageNotAvailableError](/reference/graphql-api/admin/object-types#languagenotavailableerror)
## UpdateCustomerResult​


[​](#updatecustomerresult)[Customer](/reference/graphql-api/admin/object-types#customer)[EmailAddressConflictError](/reference/graphql-api/admin/object-types#emailaddressconflicterror)
## UpdateGlobalSettingsResult​


[​](#updateglobalsettingsresult)[GlobalSettings](/reference/graphql-api/admin/object-types#globalsettings)[ChannelDefaultLanguageError](/reference/graphql-api/admin/object-types#channeldefaultlanguageerror)
## UpdateOrderItemErrorResult​


[​](#updateorderitemerrorresult)[OrderModificationError](/reference/graphql-api/admin/object-types#ordermodificationerror)[OrderLimitError](/reference/graphql-api/admin/object-types#orderlimiterror)[NegativeQuantityError](/reference/graphql-api/admin/object-types#negativequantityerror)[InsufficientStockError](/reference/graphql-api/admin/object-types#insufficientstockerror)[OrderInterceptorError](/reference/graphql-api/admin/object-types#orderinterceptorerror)
## UpdateOrderItemsResult​


[​](#updateorderitemsresult)[Order](/reference/graphql-api/admin/object-types#order)[OrderModificationError](/reference/graphql-api/admin/object-types#ordermodificationerror)[OrderLimitError](/reference/graphql-api/admin/object-types#orderlimiterror)[NegativeQuantityError](/reference/graphql-api/admin/object-types#negativequantityerror)[InsufficientStockError](/reference/graphql-api/admin/object-types#insufficientstockerror)[OrderInterceptorError](/reference/graphql-api/admin/object-types#orderinterceptorerror)
## UpdatePromotionResult​


[​](#updatepromotionresult)[Promotion](/reference/graphql-api/admin/object-types#promotion)[MissingConditionsError](/reference/graphql-api/admin/object-types#missingconditionserror)
## Upload​


[​](#upload)
## User​


[​](#user)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[String](/reference/graphql-api/admin/object-types#string)[Boolean](/reference/graphql-api/admin/object-types#boolean)[Role](/reference/graphql-api/admin/object-types#role)[DateTime](/reference/graphql-api/admin/object-types#datetime)[AuthenticationMethod](/reference/graphql-api/admin/object-types#authenticationmethod)[JSON](/reference/graphql-api/admin/object-types#json)
## Zone​


[​](#zone)[ID](/reference/graphql-api/admin/object-types#id)[DateTime](/reference/graphql-api/admin/object-types#datetime)[DateTime](/reference/graphql-api/admin/object-types#datetime)[String](/reference/graphql-api/admin/object-types#string)[Region](/reference/graphql-api/admin/object-types#region)[JSON](/reference/graphql-api/admin/object-types#json)
## ZoneList​


[​](#zonelist)[Zone](/reference/graphql-api/admin/object-types#zone)[Int](/reference/graphql-api/admin/object-types#int)


---

# Queries


## activeAdministrator​


[​](#activeadministrator)[Administrator](/reference/graphql-api/admin/object-types#administrator)
## activeChannel​


[​](#activechannel)[Channel](/reference/graphql-api/admin/object-types#channel)
## administrator​


[​](#administrator)[ID](/reference/graphql-api/admin/object-types#id)[Administrator](/reference/graphql-api/admin/object-types#administrator)
## administrators​


[​](#administrators)[AdministratorListOptions](/reference/graphql-api/admin/input-types#administratorlistoptions)[AdministratorList](/reference/graphql-api/admin/object-types#administratorlist)
## asset​


[​](#asset)[ID](/reference/graphql-api/admin/object-types#id)[Asset](/reference/graphql-api/admin/object-types#asset)
## assets​


[​](#assets)[AssetListOptions](/reference/graphql-api/admin/input-types#assetlistoptions)[AssetList](/reference/graphql-api/admin/object-types#assetlist)
## channel​


[​](#channel)[ID](/reference/graphql-api/admin/object-types#id)[Channel](/reference/graphql-api/admin/object-types#channel)
## channels​


[​](#channels)[ChannelListOptions](/reference/graphql-api/admin/input-types#channellistoptions)[ChannelList](/reference/graphql-api/admin/object-types#channellist)
## collection​


[​](#collection)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[Collection](/reference/graphql-api/admin/object-types#collection)
## collectionFilters​


[​](#collectionfilters)[ConfigurableOperationDefinition](/reference/graphql-api/admin/object-types#configurableoperationdefinition)
## collections​


[​](#collections)[CollectionListOptions](/reference/graphql-api/admin/input-types#collectionlistoptions)[CollectionList](/reference/graphql-api/admin/object-types#collectionlist)
## countries​


[​](#countries)[CountryListOptions](/reference/graphql-api/admin/input-types#countrylistoptions)[CountryList](/reference/graphql-api/admin/object-types#countrylist)
## country​


[​](#country)[ID](/reference/graphql-api/admin/object-types#id)[Country](/reference/graphql-api/admin/object-types#country)
## customer​


[​](#customer)[ID](/reference/graphql-api/admin/object-types#id)[Customer](/reference/graphql-api/admin/object-types#customer)
## customerGroup​


[​](#customergroup)[ID](/reference/graphql-api/admin/object-types#id)[CustomerGroup](/reference/graphql-api/admin/object-types#customergroup)
## customerGroups​


[​](#customergroups)[CustomerGroupListOptions](/reference/graphql-api/admin/input-types#customergrouplistoptions)[CustomerGroupList](/reference/graphql-api/admin/object-types#customergrouplist)
## customers​


[​](#customers)[CustomerListOptions](/reference/graphql-api/admin/input-types#customerlistoptions)[CustomerList](/reference/graphql-api/admin/object-types#customerlist)
## eligibleShippingMethodsForDraftOrder​


[​](#eligibleshippingmethodsfordraftorder)[ID](/reference/graphql-api/admin/object-types#id)[ShippingMethodQuote](/reference/graphql-api/admin/object-types#shippingmethodquote)
## entityDuplicators​


[​](#entityduplicators)[EntityDuplicatorDefinition](/reference/graphql-api/admin/object-types#entityduplicatordefinition)
## facet​


[​](#facet)[ID](/reference/graphql-api/admin/object-types#id)[Facet](/reference/graphql-api/admin/object-types#facet)
## facetValue​


[​](#facetvalue)[ID](/reference/graphql-api/admin/object-types#id)[FacetValue](/reference/graphql-api/admin/object-types#facetvalue)
## facetValues​


[​](#facetvalues)[FacetValueListOptions](/reference/graphql-api/admin/input-types#facetvaluelistoptions)[FacetValueList](/reference/graphql-api/admin/object-types#facetvaluelist)
## facets​


[​](#facets)[FacetListOptions](/reference/graphql-api/admin/input-types#facetlistoptions)[FacetList](/reference/graphql-api/admin/object-types#facetlist)
## fulfillmentHandlers​


[​](#fulfillmenthandlers)[ConfigurableOperationDefinition](/reference/graphql-api/admin/object-types#configurableoperationdefinition)
## getSettingsStoreValue​


[​](#getsettingsstorevalue)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## getSettingsStoreValues​


[​](#getsettingsstorevalues)[String](/reference/graphql-api/admin/object-types#string)[JSON](/reference/graphql-api/admin/object-types#json)
## globalSettings​


[​](#globalsettings)[GlobalSettings](/reference/graphql-api/admin/object-types#globalsettings)
## job​


[​](#job)[ID](/reference/graphql-api/admin/object-types#id)[Job](/reference/graphql-api/admin/object-types#job)
## jobBufferSize​


[​](#jobbuffersize)[String](/reference/graphql-api/admin/object-types#string)[JobBufferSize](/reference/graphql-api/admin/object-types#jobbuffersize)
## jobQueues​


[​](#jobqueues)[JobQueue](/reference/graphql-api/admin/object-types#jobqueue)
## jobs​


[​](#jobs)[JobListOptions](/reference/graphql-api/admin/input-types#joblistoptions)[JobList](/reference/graphql-api/admin/object-types#joblist)
## jobsById​


[​](#jobsbyid)[ID](/reference/graphql-api/admin/object-types#id)[Job](/reference/graphql-api/admin/object-types#job)
## me​


[​](#me)[CurrentUser](/reference/graphql-api/admin/object-types#currentuser)
## metricSummary​


[​](#metricsummary)[MetricSummaryInput](/reference/graphql-api/admin/input-types#metricsummaryinput)[MetricSummary](/reference/graphql-api/admin/object-types#metricsummary)
## order​


[​](#order)[ID](/reference/graphql-api/admin/object-types#id)[Order](/reference/graphql-api/admin/object-types#order)
## orders​


[​](#orders)[OrderListOptions](/reference/graphql-api/admin/input-types#orderlistoptions)[OrderList](/reference/graphql-api/admin/object-types#orderlist)
## paymentMethod​


[​](#paymentmethod)[ID](/reference/graphql-api/admin/object-types#id)[PaymentMethod](/reference/graphql-api/admin/object-types#paymentmethod)
## paymentMethodEligibilityCheckers​


[​](#paymentmethodeligibilitycheckers)[ConfigurableOperationDefinition](/reference/graphql-api/admin/object-types#configurableoperationdefinition)
## paymentMethodHandlers​


[​](#paymentmethodhandlers)[ConfigurableOperationDefinition](/reference/graphql-api/admin/object-types#configurableoperationdefinition)
## paymentMethods​


[​](#paymentmethods)[PaymentMethodListOptions](/reference/graphql-api/admin/input-types#paymentmethodlistoptions)[PaymentMethodList](/reference/graphql-api/admin/object-types#paymentmethodlist)
## pendingSearchIndexUpdates​


[​](#pendingsearchindexupdates)[Int](/reference/graphql-api/admin/object-types#int)
## previewCollectionVariants​


[​](#previewcollectionvariants)[PreviewCollectionVariantsInput](/reference/graphql-api/admin/input-types#previewcollectionvariantsinput)[ProductVariantListOptions](/reference/graphql-api/admin/input-types#productvariantlistoptions)[ProductVariantList](/reference/graphql-api/admin/object-types#productvariantlist)
## product​


[​](#product)[ID](/reference/graphql-api/admin/object-types#id)[String](/reference/graphql-api/admin/object-types#string)[Product](/reference/graphql-api/admin/object-types#product)
## productOption​


[​](#productoption)[ID](/reference/graphql-api/admin/object-types#id)[ProductOption](/reference/graphql-api/admin/object-types#productoption)
## productOptionGroup​


[​](#productoptiongroup)[ID](/reference/graphql-api/admin/object-types#id)[ProductOptionGroup](/reference/graphql-api/admin/object-types#productoptiongroup)
## productOptionGroups​


[​](#productoptiongroups)[String](/reference/graphql-api/admin/object-types#string)[ProductOptionGroup](/reference/graphql-api/admin/object-types#productoptiongroup)
## productOptions​


[​](#productoptions)[ProductOptionListOptions](/reference/graphql-api/admin/input-types#productoptionlistoptions)[ID](/reference/graphql-api/admin/object-types#id)[ProductOptionList](/reference/graphql-api/admin/object-types#productoptionlist)
## productVariant​


[​](#productvariant)[ID](/reference/graphql-api/admin/object-types#id)[ProductVariant](/reference/graphql-api/admin/object-types#productvariant)
## productVariants​


[​](#productvariants)[ProductVariantListOptions](/reference/graphql-api/admin/input-types#productvariantlistoptions)[ID](/reference/graphql-api/admin/object-types#id)[ProductVariantList](/reference/graphql-api/admin/object-types#productvariantlist)
## products​


[​](#products)[ProductListOptions](/reference/graphql-api/admin/input-types#productlistoptions)[ProductList](/reference/graphql-api/admin/object-types#productlist)
## promotion​


[​](#promotion)[ID](/reference/graphql-api/admin/object-types#id)[Promotion](/reference/graphql-api/admin/object-types#promotion)
## promotionActions​


[​](#promotionactions)[ConfigurableOperationDefinition](/reference/graphql-api/admin/object-types#configurableoperationdefinition)
## promotionConditions​


[​](#promotionconditions)[ConfigurableOperationDefinition](/reference/graphql-api/admin/object-types#configurableoperationdefinition)
## promotions​


[​](#promotions)[PromotionListOptions](/reference/graphql-api/admin/input-types#promotionlistoptions)[PromotionList](/reference/graphql-api/admin/object-types#promotionlist)
## province​


[​](#province)[ID](/reference/graphql-api/admin/object-types#id)[Province](/reference/graphql-api/admin/object-types#province)
## provinces​


[​](#provinces)[ProvinceListOptions](/reference/graphql-api/admin/input-types#provincelistoptions)[ProvinceList](/reference/graphql-api/admin/object-types#provincelist)
## role​


[​](#role)[ID](/reference/graphql-api/admin/object-types#id)[Role](/reference/graphql-api/admin/object-types#role)
## roles​


[​](#roles)[RoleListOptions](/reference/graphql-api/admin/input-types#rolelistoptions)[RoleList](/reference/graphql-api/admin/object-types#rolelist)
## scheduledTasks​


[​](#scheduledtasks)[ScheduledTask](/reference/graphql-api/admin/object-types#scheduledtask)
## search​


[​](#search)[SearchInput](/reference/graphql-api/admin/input-types#searchinput)[SearchResponse](/reference/graphql-api/admin/object-types#searchresponse)
## seller​


[​](#seller)[ID](/reference/graphql-api/admin/object-types#id)[Seller](/reference/graphql-api/admin/object-types#seller)
## sellers​


[​](#sellers)[SellerListOptions](/reference/graphql-api/admin/input-types#sellerlistoptions)[SellerList](/reference/graphql-api/admin/object-types#sellerlist)
## shippingCalculators​


[​](#shippingcalculators)[ConfigurableOperationDefinition](/reference/graphql-api/admin/object-types#configurableoperationdefinition)
## shippingEligibilityCheckers​


[​](#shippingeligibilitycheckers)[ConfigurableOperationDefinition](/reference/graphql-api/admin/object-types#configurableoperationdefinition)
## shippingMethod​


[​](#shippingmethod)[ID](/reference/graphql-api/admin/object-types#id)[ShippingMethod](/reference/graphql-api/admin/object-types#shippingmethod)
## shippingMethods​


[​](#shippingmethods)[ShippingMethodListOptions](/reference/graphql-api/admin/input-types#shippingmethodlistoptions)[ShippingMethodList](/reference/graphql-api/admin/object-types#shippingmethodlist)
## slugForEntity​


[​](#slugforentity)[SlugForEntityInput](/reference/graphql-api/admin/input-types#slugforentityinput)[String](/reference/graphql-api/admin/object-types#string)
## stockLocation​


[​](#stocklocation)[ID](/reference/graphql-api/admin/object-types#id)[StockLocation](/reference/graphql-api/admin/object-types#stocklocation)
## stockLocations​


[​](#stocklocations)[StockLocationListOptions](/reference/graphql-api/admin/input-types#stocklocationlistoptions)[StockLocationList](/reference/graphql-api/admin/object-types#stocklocationlist)
## tag​


[​](#tag)[ID](/reference/graphql-api/admin/object-types#id)[Tag](/reference/graphql-api/admin/object-types#tag)
## tags​


[​](#tags)[TagListOptions](/reference/graphql-api/admin/input-types#taglistoptions)[TagList](/reference/graphql-api/admin/object-types#taglist)
## taxCategories​


[​](#taxcategories)[TaxCategoryListOptions](/reference/graphql-api/admin/input-types#taxcategorylistoptions)[TaxCategoryList](/reference/graphql-api/admin/object-types#taxcategorylist)
## taxCategory​


[​](#taxcategory)[ID](/reference/graphql-api/admin/object-types#id)[TaxCategory](/reference/graphql-api/admin/object-types#taxcategory)
## taxRate​


[​](#taxrate)[ID](/reference/graphql-api/admin/object-types#id)[TaxRate](/reference/graphql-api/admin/object-types#taxrate)
## taxRates​


[​](#taxrates)[TaxRateListOptions](/reference/graphql-api/admin/input-types#taxratelistoptions)[TaxRateList](/reference/graphql-api/admin/object-types#taxratelist)
## testEligibleShippingMethods​


[​](#testeligibleshippingmethods)[TestEligibleShippingMethodsInput](/reference/graphql-api/admin/input-types#testeligibleshippingmethodsinput)[ShippingMethodQuote](/reference/graphql-api/admin/object-types#shippingmethodquote)
## testShippingMethod​


[​](#testshippingmethod)[TestShippingMethodInput](/reference/graphql-api/admin/input-types#testshippingmethodinput)[TestShippingMethodResult](/reference/graphql-api/admin/object-types#testshippingmethodresult)
## zone​


[​](#zone)[ID](/reference/graphql-api/admin/object-types#id)[Zone](/reference/graphql-api/admin/object-types#zone)
## zones​


[​](#zones)[ZoneListOptions](/reference/graphql-api/admin/input-types#zonelistoptions)[ZoneList](/reference/graphql-api/admin/object-types#zonelist)


---

# Enums


## AdjustmentType​


[​](#adjustmenttype)
## AssetType​


[​](#assettype)
## CurrencyCode​


[​](#currencycode)
## DeletionResult​


[​](#deletionresult)
## ErrorCode​


[​](#errorcode)
## GlobalFlag​


[​](#globalflag)
## HistoryEntryType​


[​](#historyentrytype)
## LanguageCode​


[​](#languagecode)[Unicode CLDR summary list](https://unicode-org.github.io/cldr-staging/charts/37/summary/root.html)
## LogicalOperator​


[​](#logicaloperator)
## OrderType​


[​](#ordertype)
## Permission​


[​](#permission)
## SortOrder​


[​](#sortorder)


---

# Input Objects


## AddItemInput​


[​](#additeminput)[ID](/reference/graphql-api/shop/object-types#id)[Int](/reference/graphql-api/shop/object-types#int)
## AuthenticationInput​


[​](#authenticationinput)[NativeAuthInput](/reference/graphql-api/shop/input-types#nativeauthinput)
## BooleanListOperators​


[​](#booleanlistoperators)[Boolean](/reference/graphql-api/shop/object-types#boolean)
## BooleanOperators​


[​](#booleanoperators)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)
## CollectionFilterParameter​


[​](#collectionfilterparameter)[IDOperators](/reference/graphql-api/shop/input-types#idoperators)[DateOperators](/reference/graphql-api/shop/input-types#dateoperators)[DateOperators](/reference/graphql-api/shop/input-types#dateoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[NumberOperators](/reference/graphql-api/shop/input-types#numberoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[IDOperators](/reference/graphql-api/shop/input-types#idoperators)[CollectionFilterParameter](/reference/graphql-api/shop/input-types#collectionfilterparameter)[CollectionFilterParameter](/reference/graphql-api/shop/input-types#collectionfilterparameter)
## CollectionListOptions​


[​](#collectionlistoptions)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Int](/reference/graphql-api/shop/object-types#int)[Int](/reference/graphql-api/shop/object-types#int)[CollectionSortParameter](/reference/graphql-api/shop/input-types#collectionsortparameter)[CollectionFilterParameter](/reference/graphql-api/shop/input-types#collectionfilterparameter)[LogicalOperator](/reference/graphql-api/shop/enums#logicaloperator)
## CollectionSortParameter​


[​](#collectionsortparameter)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)
## ConfigArgInput​


[​](#configarginput)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)
## ConfigurableOperationInput​


[​](#configurableoperationinput)[String](/reference/graphql-api/shop/object-types#string)[ConfigArgInput](/reference/graphql-api/shop/input-types#configarginput)
## CreateAddressInput​


[​](#createaddressinput)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)[JSON](/reference/graphql-api/shop/object-types#json)
## CreateCustomerInput​


[​](#createcustomerinput)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[JSON](/reference/graphql-api/shop/object-types#json)
## CustomerFilterParameter​


[​](#customerfilterparameter)[IDOperators](/reference/graphql-api/shop/input-types#idoperators)[DateOperators](/reference/graphql-api/shop/input-types#dateoperators)[DateOperators](/reference/graphql-api/shop/input-types#dateoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[CustomerFilterParameter](/reference/graphql-api/shop/input-types#customerfilterparameter)[CustomerFilterParameter](/reference/graphql-api/shop/input-types#customerfilterparameter)
## CustomerListOptions​


[​](#customerlistoptions)[Int](/reference/graphql-api/shop/object-types#int)[Int](/reference/graphql-api/shop/object-types#int)[CustomerSortParameter](/reference/graphql-api/shop/input-types#customersortparameter)[CustomerFilterParameter](/reference/graphql-api/shop/input-types#customerfilterparameter)[LogicalOperator](/reference/graphql-api/shop/enums#logicaloperator)
## CustomerSortParameter​


[​](#customersortparameter)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)
## DateListOperators​


[​](#datelistoperators)[DateTime](/reference/graphql-api/shop/object-types#datetime)
## DateOperators​


[​](#dateoperators)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateRange](/reference/graphql-api/shop/input-types#daterange)[Boolean](/reference/graphql-api/shop/object-types#boolean)
## DateRange​


[​](#daterange)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)
## FacetFilterParameter​


[​](#facetfilterparameter)[IDOperators](/reference/graphql-api/shop/input-types#idoperators)[DateOperators](/reference/graphql-api/shop/input-types#dateoperators)[DateOperators](/reference/graphql-api/shop/input-types#dateoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[FacetFilterParameter](/reference/graphql-api/shop/input-types#facetfilterparameter)[FacetFilterParameter](/reference/graphql-api/shop/input-types#facetfilterparameter)
## FacetListOptions​


[​](#facetlistoptions)[Int](/reference/graphql-api/shop/object-types#int)[Int](/reference/graphql-api/shop/object-types#int)[FacetSortParameter](/reference/graphql-api/shop/input-types#facetsortparameter)[FacetFilterParameter](/reference/graphql-api/shop/input-types#facetfilterparameter)[LogicalOperator](/reference/graphql-api/shop/enums#logicaloperator)
## FacetSortParameter​


[​](#facetsortparameter)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)
## FacetValueFilterInput​


[​](#facetvaluefilterinput)[ID](/reference/graphql-api/shop/object-types#id)[ID](/reference/graphql-api/shop/object-types#id)
## FacetValueFilterParameter​


[​](#facetvaluefilterparameter)[IDOperators](/reference/graphql-api/shop/input-types#idoperators)[DateOperators](/reference/graphql-api/shop/input-types#dateoperators)[DateOperators](/reference/graphql-api/shop/input-types#dateoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[IDOperators](/reference/graphql-api/shop/input-types#idoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[FacetValueFilterParameter](/reference/graphql-api/shop/input-types#facetvaluefilterparameter)[FacetValueFilterParameter](/reference/graphql-api/shop/input-types#facetvaluefilterparameter)
## FacetValueListOptions​


[​](#facetvaluelistoptions)[Int](/reference/graphql-api/shop/object-types#int)[Int](/reference/graphql-api/shop/object-types#int)[FacetValueSortParameter](/reference/graphql-api/shop/input-types#facetvaluesortparameter)[FacetValueFilterParameter](/reference/graphql-api/shop/input-types#facetvaluefilterparameter)[LogicalOperator](/reference/graphql-api/shop/enums#logicaloperator)
## FacetValueSortParameter​


[​](#facetvaluesortparameter)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)
## HistoryEntryFilterParameter​


[​](#historyentryfilterparameter)[IDOperators](/reference/graphql-api/shop/input-types#idoperators)[DateOperators](/reference/graphql-api/shop/input-types#dateoperators)[DateOperators](/reference/graphql-api/shop/input-types#dateoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[HistoryEntryFilterParameter](/reference/graphql-api/shop/input-types#historyentryfilterparameter)[HistoryEntryFilterParameter](/reference/graphql-api/shop/input-types#historyentryfilterparameter)
## HistoryEntryListOptions​


[​](#historyentrylistoptions)[Int](/reference/graphql-api/shop/object-types#int)[Int](/reference/graphql-api/shop/object-types#int)[HistoryEntrySortParameter](/reference/graphql-api/shop/input-types#historyentrysortparameter)[HistoryEntryFilterParameter](/reference/graphql-api/shop/input-types#historyentryfilterparameter)[LogicalOperator](/reference/graphql-api/shop/enums#logicaloperator)
## HistoryEntrySortParameter​


[​](#historyentrysortparameter)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)
## IDListOperators​


[​](#idlistoperators)[ID](/reference/graphql-api/shop/object-types#id)
## IDOperators​


[​](#idoperators)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)
## NativeAuthInput​


[​](#nativeauthinput)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)
## NumberListOperators​


[​](#numberlistoperators)[Float](/reference/graphql-api/shop/object-types#float)
## NumberOperators​


[​](#numberoperators)[Float](/reference/graphql-api/shop/object-types#float)[Float](/reference/graphql-api/shop/object-types#float)[Float](/reference/graphql-api/shop/object-types#float)[Float](/reference/graphql-api/shop/object-types#float)[Float](/reference/graphql-api/shop/object-types#float)[NumberRange](/reference/graphql-api/shop/input-types#numberrange)[Boolean](/reference/graphql-api/shop/object-types#boolean)
## NumberRange​


[​](#numberrange)[Float](/reference/graphql-api/shop/object-types#float)[Float](/reference/graphql-api/shop/object-types#float)
## OrderFilterParameter​


[​](#orderfilterparameter)[IDOperators](/reference/graphql-api/shop/input-types#idoperators)[DateOperators](/reference/graphql-api/shop/input-types#dateoperators)[DateOperators](/reference/graphql-api/shop/input-types#dateoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[DateOperators](/reference/graphql-api/shop/input-types#dateoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[BooleanOperators](/reference/graphql-api/shop/input-types#booleanoperators)[NumberOperators](/reference/graphql-api/shop/input-types#numberoperators)[NumberOperators](/reference/graphql-api/shop/input-types#numberoperators)[NumberOperators](/reference/graphql-api/shop/input-types#numberoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[NumberOperators](/reference/graphql-api/shop/input-types#numberoperators)[NumberOperators](/reference/graphql-api/shop/input-types#numberoperators)[NumberOperators](/reference/graphql-api/shop/input-types#numberoperators)[NumberOperators](/reference/graphql-api/shop/input-types#numberoperators)[OrderFilterParameter](/reference/graphql-api/shop/input-types#orderfilterparameter)[OrderFilterParameter](/reference/graphql-api/shop/input-types#orderfilterparameter)
## OrderListOptions​


[​](#orderlistoptions)[Int](/reference/graphql-api/shop/object-types#int)[Int](/reference/graphql-api/shop/object-types#int)[OrderSortParameter](/reference/graphql-api/shop/input-types#ordersortparameter)[OrderFilterParameter](/reference/graphql-api/shop/input-types#orderfilterparameter)[LogicalOperator](/reference/graphql-api/shop/enums#logicaloperator)
## OrderSortParameter​


[​](#ordersortparameter)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)
## PaymentInput​


[​](#paymentinput)[String](/reference/graphql-api/shop/object-types#string)[JSON](/reference/graphql-api/shop/object-types#json)
## ProductFilterParameter​


[​](#productfilterparameter)[IDOperators](/reference/graphql-api/shop/input-types#idoperators)[DateOperators](/reference/graphql-api/shop/input-types#dateoperators)[DateOperators](/reference/graphql-api/shop/input-types#dateoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[BooleanOperators](/reference/graphql-api/shop/input-types#booleanoperators)[ProductFilterParameter](/reference/graphql-api/shop/input-types#productfilterparameter)[ProductFilterParameter](/reference/graphql-api/shop/input-types#productfilterparameter)
## ProductListOptions​


[​](#productlistoptions)[Int](/reference/graphql-api/shop/object-types#int)[Int](/reference/graphql-api/shop/object-types#int)[ProductSortParameter](/reference/graphql-api/shop/input-types#productsortparameter)[ProductFilterParameter](/reference/graphql-api/shop/input-types#productfilterparameter)[LogicalOperator](/reference/graphql-api/shop/enums#logicaloperator)
## ProductSortParameter​


[​](#productsortparameter)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)
## ProductVariantFilterParameter​


[​](#productvariantfilterparameter)[IDOperators](/reference/graphql-api/shop/input-types#idoperators)[IDOperators](/reference/graphql-api/shop/input-types#idoperators)[DateOperators](/reference/graphql-api/shop/input-types#dateoperators)[DateOperators](/reference/graphql-api/shop/input-types#dateoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[NumberOperators](/reference/graphql-api/shop/input-types#numberoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[NumberOperators](/reference/graphql-api/shop/input-types#numberoperators)[StringOperators](/reference/graphql-api/shop/input-types#stringoperators)[ProductVariantFilterParameter](/reference/graphql-api/shop/input-types#productvariantfilterparameter)[ProductVariantFilterParameter](/reference/graphql-api/shop/input-types#productvariantfilterparameter)
## ProductVariantListOptions​


[​](#productvariantlistoptions)[Int](/reference/graphql-api/shop/object-types#int)[Int](/reference/graphql-api/shop/object-types#int)[ProductVariantSortParameter](/reference/graphql-api/shop/input-types#productvariantsortparameter)[ProductVariantFilterParameter](/reference/graphql-api/shop/input-types#productvariantfilterparameter)[LogicalOperator](/reference/graphql-api/shop/enums#logicaloperator)
## ProductVariantSortParameter​


[​](#productvariantsortparameter)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)
## RegisterCustomerInput​


[​](#registercustomerinput)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)
## SearchInput​


[​](#searchinput)[String](/reference/graphql-api/shop/object-types#string)[ID](/reference/graphql-api/shop/object-types#id)[LogicalOperator](/reference/graphql-api/shop/enums#logicaloperator)[FacetValueFilterInput](/reference/graphql-api/shop/input-types#facetvaluefilterinput)[ID](/reference/graphql-api/shop/object-types#id)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Int](/reference/graphql-api/shop/object-types#int)[Int](/reference/graphql-api/shop/object-types#int)[SearchResultSortParameter](/reference/graphql-api/shop/input-types#searchresultsortparameter)
## SearchResultSortParameter​


[​](#searchresultsortparameter)[SortOrder](/reference/graphql-api/shop/enums#sortorder)[SortOrder](/reference/graphql-api/shop/enums#sortorder)
## StringListOperators​


[​](#stringlistoperators)[String](/reference/graphql-api/shop/object-types#string)
## StringOperators​


[​](#stringoperators)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)
## UpdateAddressInput​


[​](#updateaddressinput)[ID](/reference/graphql-api/shop/object-types#id)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)[JSON](/reference/graphql-api/shop/object-types#json)
## UpdateCustomerInput​


[​](#updatecustomerinput)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[JSON](/reference/graphql-api/shop/object-types#json)
## UpdateOrderInput​


[​](#updateorderinput)[JSON](/reference/graphql-api/shop/object-types#json)


---

# Mutations


## addItemToOrder​


[​](#additemtoorder)[ID](/reference/graphql-api/shop/object-types#id)[Int](/reference/graphql-api/shop/object-types#int)[UpdateOrderItemsResult](/reference/graphql-api/shop/object-types#updateorderitemsresult)
## addItemsToOrder​


[​](#additemstoorder)[AddItemInput](/reference/graphql-api/shop/input-types#additeminput)[UpdateMultipleOrderItemsResult](/reference/graphql-api/shop/object-types#updatemultipleorderitemsresult)
## addPaymentToOrder​


[​](#addpaymenttoorder)[PaymentInput](/reference/graphql-api/shop/input-types#paymentinput)[AddPaymentToOrderResult](/reference/graphql-api/shop/object-types#addpaymenttoorderresult)
## adjustOrderLine​


[​](#adjustorderline)[ID](/reference/graphql-api/shop/object-types#id)[Int](/reference/graphql-api/shop/object-types#int)[UpdateOrderItemsResult](/reference/graphql-api/shop/object-types#updateorderitemsresult)
## applyCouponCode​


[​](#applycouponcode)[String](/reference/graphql-api/shop/object-types#string)[ApplyCouponCodeResult](/reference/graphql-api/shop/object-types#applycouponcoderesult)
## authenticate​


[​](#authenticate)[AuthenticationInput](/reference/graphql-api/shop/input-types#authenticationinput)[Boolean](/reference/graphql-api/shop/object-types#boolean)[AuthenticationResult](/reference/graphql-api/shop/object-types#authenticationresult)
## createCustomerAddress​


[​](#createcustomeraddress)[CreateAddressInput](/reference/graphql-api/shop/input-types#createaddressinput)[Address](/reference/graphql-api/shop/object-types#address)
## deleteCustomerAddress​


[​](#deletecustomeraddress)[ID](/reference/graphql-api/shop/object-types#id)[Success](/reference/graphql-api/shop/object-types#success)
## login​


[​](#login)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[NativeAuthenticationResult](/reference/graphql-api/shop/object-types#nativeauthenticationresult)
## logout​


[​](#logout)[Success](/reference/graphql-api/shop/object-types#success)
## refreshCustomerVerification​


[​](#refreshcustomerverification)[String](/reference/graphql-api/shop/object-types#string)[RefreshCustomerVerificationResult](/reference/graphql-api/shop/object-types#refreshcustomerverificationresult)
## registerCustomerAccount​


[​](#registercustomeraccount)[RegisterCustomerInput](/reference/graphql-api/shop/input-types#registercustomerinput)[RegisterCustomerAccountResult](/reference/graphql-api/shop/object-types#registercustomeraccountresult)
## removeAllOrderLines​


[​](#removeallorderlines)[RemoveOrderItemsResult](/reference/graphql-api/shop/object-types#removeorderitemsresult)
## removeCouponCode​


[​](#removecouponcode)[String](/reference/graphql-api/shop/object-types#string)[Order](/reference/graphql-api/shop/object-types#order)
## removeOrderLine​


[​](#removeorderline)[ID](/reference/graphql-api/shop/object-types#id)[RemoveOrderItemsResult](/reference/graphql-api/shop/object-types#removeorderitemsresult)
## requestPasswordReset​


[​](#requestpasswordreset)[String](/reference/graphql-api/shop/object-types#string)[RequestPasswordResetResult](/reference/graphql-api/shop/object-types#requestpasswordresetresult)
## requestUpdateCustomerEmailAddress​


[​](#requestupdatecustomeremailaddress)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[RequestUpdateCustomerEmailAddressResult](/reference/graphql-api/shop/object-types#requestupdatecustomeremailaddressresult)
## resetPassword​


[​](#resetpassword)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[ResetPasswordResult](/reference/graphql-api/shop/object-types#resetpasswordresult)
## setCustomerForOrder​


[​](#setcustomerfororder)[CreateCustomerInput](/reference/graphql-api/shop/input-types#createcustomerinput)[SetCustomerForOrderResult](/reference/graphql-api/shop/object-types#setcustomerfororderresult)
## setOrderBillingAddress​


[​](#setorderbillingaddress)[CreateAddressInput](/reference/graphql-api/shop/input-types#createaddressinput)[ActiveOrderResult](/reference/graphql-api/shop/object-types#activeorderresult)
## setOrderCustomFields​


[​](#setordercustomfields)[UpdateOrderInput](/reference/graphql-api/shop/input-types#updateorderinput)[ActiveOrderResult](/reference/graphql-api/shop/object-types#activeorderresult)
## setOrderShippingAddress​


[​](#setordershippingaddress)[CreateAddressInput](/reference/graphql-api/shop/input-types#createaddressinput)[ActiveOrderResult](/reference/graphql-api/shop/object-types#activeorderresult)
## setOrderShippingMethod​


[​](#setordershippingmethod)[ID](/reference/graphql-api/shop/object-types#id)[SetOrderShippingMethodResult](/reference/graphql-api/shop/object-types#setordershippingmethodresult)
## transitionOrderToState​


[​](#transitionordertostate)[String](/reference/graphql-api/shop/object-types#string)[TransitionOrderToStateResult](/reference/graphql-api/shop/object-types#transitionordertostateresult)
## unsetOrderBillingAddress​


[​](#unsetorderbillingaddress)[ActiveOrderResult](/reference/graphql-api/shop/object-types#activeorderresult)
## unsetOrderShippingAddress​


[​](#unsetordershippingaddress)[ActiveOrderResult](/reference/graphql-api/shop/object-types#activeorderresult)
## updateCustomer​


[​](#updatecustomer)[UpdateCustomerInput](/reference/graphql-api/shop/input-types#updatecustomerinput)[Customer](/reference/graphql-api/shop/object-types#customer)
## updateCustomerAddress​


[​](#updatecustomeraddress)[UpdateAddressInput](/reference/graphql-api/shop/input-types#updateaddressinput)[Address](/reference/graphql-api/shop/object-types#address)
## updateCustomerEmailAddress​


[​](#updatecustomeremailaddress)[String](/reference/graphql-api/shop/object-types#string)[UpdateCustomerEmailAddressResult](/reference/graphql-api/shop/object-types#updatecustomeremailaddressresult)
## updateCustomerPassword​


[​](#updatecustomerpassword)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[UpdateCustomerPasswordResult](/reference/graphql-api/shop/object-types#updatecustomerpasswordresult)
## verifyCustomerAccount​


[​](#verifycustomeraccount)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[VerifyCustomerAccountResult](/reference/graphql-api/shop/object-types#verifycustomeraccountresult)


---

# Types


## ActiveOrderResult​


[​](#activeorderresult)[Order](/reference/graphql-api/shop/object-types#order)[NoActiveOrderError](/reference/graphql-api/shop/object-types#noactiveordererror)
## AddPaymentToOrderResult​


[​](#addpaymenttoorderresult)[Order](/reference/graphql-api/shop/object-types#order)[OrderPaymentStateError](/reference/graphql-api/shop/object-types#orderpaymentstateerror)[IneligiblePaymentMethodError](/reference/graphql-api/shop/object-types#ineligiblepaymentmethoderror)[PaymentFailedError](/reference/graphql-api/shop/object-types#paymentfailederror)[PaymentDeclinedError](/reference/graphql-api/shop/object-types#paymentdeclinederror)[OrderStateTransitionError](/reference/graphql-api/shop/object-types#orderstatetransitionerror)[NoActiveOrderError](/reference/graphql-api/shop/object-types#noactiveordererror)
## Address​


[​](#address)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Country](/reference/graphql-api/shop/object-types#country)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)[JSON](/reference/graphql-api/shop/object-types#json)
## Adjustment​


[​](#adjustment)[String](/reference/graphql-api/shop/object-types#string)[AdjustmentType](/reference/graphql-api/shop/enums#adjustmenttype)[String](/reference/graphql-api/shop/object-types#string)[Money](/reference/graphql-api/shop/object-types#money)[JSON](/reference/graphql-api/shop/object-types#json)
## AlreadyLoggedInError​


[​](#alreadyloggedinerror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)
## ApplyCouponCodeResult​


[​](#applycouponcoderesult)[Order](/reference/graphql-api/shop/object-types#order)[CouponCodeExpiredError](/reference/graphql-api/shop/object-types#couponcodeexpirederror)[CouponCodeInvalidError](/reference/graphql-api/shop/object-types#couponcodeinvaliderror)[CouponCodeLimitError](/reference/graphql-api/shop/object-types#couponcodelimiterror)
## Asset​


[​](#asset)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[String](/reference/graphql-api/shop/object-types#string)[AssetType](/reference/graphql-api/shop/enums#assettype)[Int](/reference/graphql-api/shop/object-types#int)[String](/reference/graphql-api/shop/object-types#string)[Int](/reference/graphql-api/shop/object-types#int)[Int](/reference/graphql-api/shop/object-types#int)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Coordinate](/reference/graphql-api/shop/object-types#coordinate)[Tag](/reference/graphql-api/shop/object-types#tag)[JSON](/reference/graphql-api/shop/object-types#json)
## AssetList​


[​](#assetlist)[Asset](/reference/graphql-api/shop/object-types#asset)[Int](/reference/graphql-api/shop/object-types#int)
## AuthenticationMethod​


[​](#authenticationmethod)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[String](/reference/graphql-api/shop/object-types#string)
## AuthenticationResult​


[​](#authenticationresult)[CurrentUser](/reference/graphql-api/shop/object-types#currentuser)[InvalidCredentialsError](/reference/graphql-api/shop/object-types#invalidcredentialserror)[NotVerifiedError](/reference/graphql-api/shop/object-types#notverifiederror)
## Boolean​


[​](#boolean)
## BooleanCustomFieldConfig​


[​](#booleancustomfieldconfig)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Permission](/reference/graphql-api/shop/enums#permission)[Boolean](/reference/graphql-api/shop/object-types#boolean)[String](/reference/graphql-api/shop/object-types#string)[JSON](/reference/graphql-api/shop/object-types#json)
## BooleanStructFieldConfig​


[​](#booleanstructfieldconfig)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[JSON](/reference/graphql-api/shop/object-types#json)
## Channel​


[​](#channel)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Zone](/reference/graphql-api/shop/object-types#zone)[Zone](/reference/graphql-api/shop/object-types#zone)[LanguageCode](/reference/graphql-api/shop/enums#languagecode)[LanguageCode](/reference/graphql-api/shop/enums#languagecode)[CurrencyCode](/reference/graphql-api/shop/enums#currencycode)[CurrencyCode](/reference/graphql-api/shop/enums#currencycode)[CurrencyCode](/reference/graphql-api/shop/enums#currencycode)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Int](/reference/graphql-api/shop/object-types#int)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Seller](/reference/graphql-api/shop/object-types#seller)[JSON](/reference/graphql-api/shop/object-types#json)
## Collection​


[​](#collection)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[LanguageCode](/reference/graphql-api/shop/enums#languagecode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[CollectionBreadcrumb](/reference/graphql-api/shop/object-types#collectionbreadcrumb)[Int](/reference/graphql-api/shop/object-types#int)[String](/reference/graphql-api/shop/object-types#string)[Asset](/reference/graphql-api/shop/object-types#asset)[Asset](/reference/graphql-api/shop/object-types#asset)[Collection](/reference/graphql-api/shop/object-types#collection)[ID](/reference/graphql-api/shop/object-types#id)[Collection](/reference/graphql-api/shop/object-types#collection)[ConfigurableOperation](/reference/graphql-api/shop/object-types#configurableoperation)[CollectionTranslation](/reference/graphql-api/shop/object-types#collectiontranslation)[ProductVariantListOptions](/reference/graphql-api/shop/input-types#productvariantlistoptions)[ProductVariantList](/reference/graphql-api/shop/object-types#productvariantlist)[JSON](/reference/graphql-api/shop/object-types#json)
## CollectionBreadcrumb​


[​](#collectionbreadcrumb)[ID](/reference/graphql-api/shop/object-types#id)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)
## CollectionList​


[​](#collectionlist)[Collection](/reference/graphql-api/shop/object-types#collection)[Int](/reference/graphql-api/shop/object-types#int)
## CollectionResult​


[​](#collectionresult)[Collection](/reference/graphql-api/shop/object-types#collection)[Int](/reference/graphql-api/shop/object-types#int)
## CollectionTranslation​


[​](#collectiontranslation)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[LanguageCode](/reference/graphql-api/shop/enums#languagecode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)
## ConfigArg​


[​](#configarg)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)
## ConfigArgDefinition​


[​](#configargdefinition)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)[JSON](/reference/graphql-api/shop/object-types#json)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[JSON](/reference/graphql-api/shop/object-types#json)
## ConfigurableOperation​


[​](#configurableoperation)[String](/reference/graphql-api/shop/object-types#string)[ConfigArg](/reference/graphql-api/shop/object-types#configarg)
## ConfigurableOperationDefinition​


[​](#configurableoperationdefinition)[String](/reference/graphql-api/shop/object-types#string)[ConfigArgDefinition](/reference/graphql-api/shop/object-types#configargdefinition)[String](/reference/graphql-api/shop/object-types#string)
## Coordinate​


[​](#coordinate)[Float](/reference/graphql-api/shop/object-types#float)[Float](/reference/graphql-api/shop/object-types#float)
## Country​


[​](#country)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[LanguageCode](/reference/graphql-api/shop/enums#languagecode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Region](/reference/graphql-api/shop/object-types#region)[ID](/reference/graphql-api/shop/object-types#id)[RegionTranslation](/reference/graphql-api/shop/object-types#regiontranslation)[JSON](/reference/graphql-api/shop/object-types#json)
## CountryList​


[​](#countrylist)[Country](/reference/graphql-api/shop/object-types#country)[Int](/reference/graphql-api/shop/object-types#int)
## CouponCodeExpiredError​


[​](#couponcodeexpirederror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)
## CouponCodeInvalidError​


[​](#couponcodeinvaliderror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)
## CouponCodeLimitError​


[​](#couponcodelimiterror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Int](/reference/graphql-api/shop/object-types#int)
## CurrentUser​


[​](#currentuser)[ID](/reference/graphql-api/shop/object-types#id)[String](/reference/graphql-api/shop/object-types#string)[CurrentUserChannel](/reference/graphql-api/shop/object-types#currentuserchannel)
## CurrentUserChannel​


[​](#currentuserchannel)[ID](/reference/graphql-api/shop/object-types#id)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Permission](/reference/graphql-api/shop/enums#permission)
## CustomFieldConfig​


[​](#customfieldconfig)[StringCustomFieldConfig](/reference/graphql-api/shop/object-types#stringcustomfieldconfig)[LocaleStringCustomFieldConfig](/reference/graphql-api/shop/object-types#localestringcustomfieldconfig)[IntCustomFieldConfig](/reference/graphql-api/shop/object-types#intcustomfieldconfig)[FloatCustomFieldConfig](/reference/graphql-api/shop/object-types#floatcustomfieldconfig)[BooleanCustomFieldConfig](/reference/graphql-api/shop/object-types#booleancustomfieldconfig)[DateTimeCustomFieldConfig](/reference/graphql-api/shop/object-types#datetimecustomfieldconfig)[RelationCustomFieldConfig](/reference/graphql-api/shop/object-types#relationcustomfieldconfig)[TextCustomFieldConfig](/reference/graphql-api/shop/object-types#textcustomfieldconfig)[LocaleTextCustomFieldConfig](/reference/graphql-api/shop/object-types#localetextcustomfieldconfig)[StructCustomFieldConfig](/reference/graphql-api/shop/object-types#structcustomfieldconfig)
## Customer​


[​](#customer)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Address](/reference/graphql-api/shop/object-types#address)[OrderListOptions](/reference/graphql-api/shop/input-types#orderlistoptions)[OrderList](/reference/graphql-api/shop/object-types#orderlist)[User](/reference/graphql-api/shop/object-types#user)[JSON](/reference/graphql-api/shop/object-types#json)
## CustomerGroup​


[​](#customergroup)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[String](/reference/graphql-api/shop/object-types#string)[CustomerListOptions](/reference/graphql-api/shop/input-types#customerlistoptions)[CustomerList](/reference/graphql-api/shop/object-types#customerlist)[JSON](/reference/graphql-api/shop/object-types#json)
## CustomerList​


[​](#customerlist)[Customer](/reference/graphql-api/shop/object-types#customer)[Int](/reference/graphql-api/shop/object-types#int)
## DateTime​


[​](#datetime)
## DateTimeCustomFieldConfig​


[​](#datetimecustomfieldconfig)[https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/datetime-local#Additional_attributes](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/datetime-local#Additional_attributes)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Permission](/reference/graphql-api/shop/enums#permission)[Boolean](/reference/graphql-api/shop/object-types#boolean)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Int](/reference/graphql-api/shop/object-types#int)[JSON](/reference/graphql-api/shop/object-types#json)
## DateTimeStructFieldConfig​


[​](#datetimestructfieldconfig)[https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/datetime-local#Additional_attributes](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/datetime-local#Additional_attributes)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Int](/reference/graphql-api/shop/object-types#int)[JSON](/reference/graphql-api/shop/object-types#json)
## DeletionResponse​


[​](#deletionresponse)[DeletionResult](/reference/graphql-api/shop/enums#deletionresult)[String](/reference/graphql-api/shop/object-types#string)
## Discount​


[​](#discount)[String](/reference/graphql-api/shop/object-types#string)[AdjustmentType](/reference/graphql-api/shop/enums#adjustmenttype)[String](/reference/graphql-api/shop/object-types#string)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)
## EmailAddressConflictError​


[​](#emailaddressconflicterror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)
## Facet​


[​](#facet)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[LanguageCode](/reference/graphql-api/shop/enums#languagecode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[FacetValue](/reference/graphql-api/shop/object-types#facetvalue)[FacetValueListOptions](/reference/graphql-api/shop/input-types#facetvaluelistoptions)[FacetValueList](/reference/graphql-api/shop/object-types#facetvaluelist)[FacetTranslation](/reference/graphql-api/shop/object-types#facettranslation)[JSON](/reference/graphql-api/shop/object-types#json)
## FacetList​


[​](#facetlist)[Facet](/reference/graphql-api/shop/object-types#facet)[Int](/reference/graphql-api/shop/object-types#int)
## FacetTranslation​


[​](#facettranslation)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[LanguageCode](/reference/graphql-api/shop/enums#languagecode)[String](/reference/graphql-api/shop/object-types#string)
## FacetValue​


[​](#facetvalue)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[LanguageCode](/reference/graphql-api/shop/enums#languagecode)[Facet](/reference/graphql-api/shop/object-types#facet)[ID](/reference/graphql-api/shop/object-types#id)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[FacetValueTranslation](/reference/graphql-api/shop/object-types#facetvaluetranslation)[JSON](/reference/graphql-api/shop/object-types#json)
## FacetValueList​


[​](#facetvaluelist)[FacetValue](/reference/graphql-api/shop/object-types#facetvalue)[Int](/reference/graphql-api/shop/object-types#int)
## FacetValueResult​


[​](#facetvalueresult)[FacetValue](/reference/graphql-api/shop/object-types#facetvalue)[Int](/reference/graphql-api/shop/object-types#int)
## FacetValueTranslation​


[​](#facetvaluetranslation)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[LanguageCode](/reference/graphql-api/shop/enums#languagecode)[String](/reference/graphql-api/shop/object-types#string)
## Float​


[​](#float)[IEEE 754](https://en.wikipedia.org/wiki/IEEE_floating_point)
## FloatCustomFieldConfig​


[​](#floatcustomfieldconfig)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Permission](/reference/graphql-api/shop/enums#permission)[Boolean](/reference/graphql-api/shop/object-types#boolean)[String](/reference/graphql-api/shop/object-types#string)[Float](/reference/graphql-api/shop/object-types#float)[Float](/reference/graphql-api/shop/object-types#float)[Float](/reference/graphql-api/shop/object-types#float)[JSON](/reference/graphql-api/shop/object-types#json)
## FloatStructFieldConfig​


[​](#floatstructfieldconfig)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[Float](/reference/graphql-api/shop/object-types#float)[Float](/reference/graphql-api/shop/object-types#float)[Float](/reference/graphql-api/shop/object-types#float)[JSON](/reference/graphql-api/shop/object-types#json)
## Fulfillment​


[​](#fulfillment)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[FulfillmentLine](/reference/graphql-api/shop/object-types#fulfillmentline)[FulfillmentLine](/reference/graphql-api/shop/object-types#fulfillmentline)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[JSON](/reference/graphql-api/shop/object-types#json)
## FulfillmentLine​


[​](#fulfillmentline)[OrderLine](/reference/graphql-api/shop/object-types#orderline)[ID](/reference/graphql-api/shop/object-types#id)[Int](/reference/graphql-api/shop/object-types#int)[Fulfillment](/reference/graphql-api/shop/object-types#fulfillment)[ID](/reference/graphql-api/shop/object-types#id)
## GuestCheckoutError​


[​](#guestcheckouterror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)
## HistoryEntry​


[​](#historyentry)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[HistoryEntryType](/reference/graphql-api/shop/enums#historyentrytype)[JSON](/reference/graphql-api/shop/object-types#json)[JSON](/reference/graphql-api/shop/object-types#json)
## HistoryEntryList​


[​](#historyentrylist)[HistoryEntry](/reference/graphql-api/shop/object-types#historyentry)[Int](/reference/graphql-api/shop/object-types#int)
## ID​


[​](#id)
## IdentifierChangeTokenExpiredError​


[​](#identifierchangetokenexpirederror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)
## IdentifierChangeTokenInvalidError​


[​](#identifierchangetokeninvaliderror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)
## IneligiblePaymentMethodError​


[​](#ineligiblepaymentmethoderror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)
## IneligibleShippingMethodError​


[​](#ineligibleshippingmethoderror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)
## InsufficientStockError​


[​](#insufficientstockerror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)[Int](/reference/graphql-api/shop/object-types#int)[Order](/reference/graphql-api/shop/object-types#order)
## Int​


[​](#int)
## IntCustomFieldConfig​


[​](#intcustomfieldconfig)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Permission](/reference/graphql-api/shop/enums#permission)[Boolean](/reference/graphql-api/shop/object-types#boolean)[String](/reference/graphql-api/shop/object-types#string)[Int](/reference/graphql-api/shop/object-types#int)[Int](/reference/graphql-api/shop/object-types#int)[Int](/reference/graphql-api/shop/object-types#int)[JSON](/reference/graphql-api/shop/object-types#json)
## IntStructFieldConfig​


[​](#intstructfieldconfig)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[Int](/reference/graphql-api/shop/object-types#int)[Int](/reference/graphql-api/shop/object-types#int)[Int](/reference/graphql-api/shop/object-types#int)[JSON](/reference/graphql-api/shop/object-types#json)
## InvalidCredentialsError​


[​](#invalidcredentialserror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)
## JSON​


[​](#json)[ECMA-404](http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-404.pdf)
## LocaleStringCustomFieldConfig​


[​](#localestringcustomfieldconfig)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Int](/reference/graphql-api/shop/object-types#int)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Permission](/reference/graphql-api/shop/enums#permission)[Boolean](/reference/graphql-api/shop/object-types#boolean)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[JSON](/reference/graphql-api/shop/object-types#json)
## LocaleTextCustomFieldConfig​


[​](#localetextcustomfieldconfig)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Permission](/reference/graphql-api/shop/enums#permission)[Boolean](/reference/graphql-api/shop/object-types#boolean)[String](/reference/graphql-api/shop/object-types#string)[JSON](/reference/graphql-api/shop/object-types#json)
## LocalizedString​


[​](#localizedstring)[LanguageCode](/reference/graphql-api/shop/enums#languagecode)[String](/reference/graphql-api/shop/object-types#string)
## MissingPasswordError​


[​](#missingpassworderror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)
## Money​


[​](#money)[IEEE 754](https://en.wikipedia.org/wiki/IEEE_floating_point)
## NativeAuthStrategyError​


[​](#nativeauthstrategyerror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)
## NativeAuthenticationResult​


[​](#nativeauthenticationresult)[CurrentUser](/reference/graphql-api/shop/object-types#currentuser)[InvalidCredentialsError](/reference/graphql-api/shop/object-types#invalidcredentialserror)[NotVerifiedError](/reference/graphql-api/shop/object-types#notverifiederror)[NativeAuthStrategyError](/reference/graphql-api/shop/object-types#nativeauthstrategyerror)
## NegativeQuantityError​


[​](#negativequantityerror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)
## NoActiveOrderError​


[​](#noactiveordererror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)
## NotVerifiedError​


[​](#notverifiederror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)
## Order​


[​](#order)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[OrderType](/reference/graphql-api/shop/enums#ordertype)[DateTime](/reference/graphql-api/shop/object-types#datetime)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Customer](/reference/graphql-api/shop/object-types#customer)[OrderAddress](/reference/graphql-api/shop/object-types#orderaddress)[OrderAddress](/reference/graphql-api/shop/object-types#orderaddress)[OrderLine](/reference/graphql-api/shop/object-types#orderline)[Surcharge](/reference/graphql-api/shop/object-types#surcharge)[Discount](/reference/graphql-api/shop/object-types#discount)[String](/reference/graphql-api/shop/object-types#string)[Promotion](/reference/graphql-api/shop/object-types#promotion)[Payment](/reference/graphql-api/shop/object-types#payment)[Fulfillment](/reference/graphql-api/shop/object-types#fulfillment)[Int](/reference/graphql-api/shop/object-types#int)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[CurrencyCode](/reference/graphql-api/shop/enums#currencycode)[ShippingLine](/reference/graphql-api/shop/object-types#shippingline)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[OrderTaxSummary](/reference/graphql-api/shop/object-types#ordertaxsummary)[HistoryEntryListOptions](/reference/graphql-api/shop/input-types#historyentrylistoptions)[HistoryEntryList](/reference/graphql-api/shop/object-types#historyentrylist)[JSON](/reference/graphql-api/shop/object-types#json)
## OrderAddress​


[​](#orderaddress)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[JSON](/reference/graphql-api/shop/object-types#json)
## OrderInterceptorError​


[​](#orderinterceptorerror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)
## OrderLimitError​


[​](#orderlimiterror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)[Int](/reference/graphql-api/shop/object-types#int)
## OrderLine​


[​](#orderline)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[ProductVariant](/reference/graphql-api/shop/object-types#productvariant)[Asset](/reference/graphql-api/shop/object-types#asset)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[Int](/reference/graphql-api/shop/object-types#int)[Int](/reference/graphql-api/shop/object-types#int)[Float](/reference/graphql-api/shop/object-types#float)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[Discount](/reference/graphql-api/shop/object-types#discount)[TaxLine](/reference/graphql-api/shop/object-types#taxline)[Order](/reference/graphql-api/shop/object-types#order)[FulfillmentLine](/reference/graphql-api/shop/object-types#fulfillmentline)[JSON](/reference/graphql-api/shop/object-types#json)
## OrderList​


[​](#orderlist)[Order](/reference/graphql-api/shop/object-types#order)[Int](/reference/graphql-api/shop/object-types#int)
## OrderModificationError​


[​](#ordermodificationerror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)
## OrderPaymentStateError​


[​](#orderpaymentstateerror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)
## OrderStateTransitionError​


[​](#orderstatetransitionerror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)
## OrderTaxSummary​


[​](#ordertaxsummary)[String](/reference/graphql-api/shop/object-types#string)[Float](/reference/graphql-api/shop/object-types#float)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)
## PasswordAlreadySetError​


[​](#passwordalreadyseterror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)
## PasswordResetTokenExpiredError​


[​](#passwordresettokenexpirederror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)
## PasswordResetTokenInvalidError​


[​](#passwordresettokeninvaliderror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)
## PasswordValidationError​


[​](#passwordvalidationerror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)
## Payment​


[​](#payment)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[String](/reference/graphql-api/shop/object-types#string)[Money](/reference/graphql-api/shop/object-types#money)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Refund](/reference/graphql-api/shop/object-types#refund)[JSON](/reference/graphql-api/shop/object-types#json)[JSON](/reference/graphql-api/shop/object-types#json)
## PaymentDeclinedError​


[​](#paymentdeclinederror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)
## PaymentFailedError​


[​](#paymentfailederror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)
## PaymentMethod​


[​](#paymentmethod)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[ConfigurableOperation](/reference/graphql-api/shop/object-types#configurableoperation)[ConfigurableOperation](/reference/graphql-api/shop/object-types#configurableoperation)[PaymentMethodTranslation](/reference/graphql-api/shop/object-types#paymentmethodtranslation)[JSON](/reference/graphql-api/shop/object-types#json)
## PaymentMethodQuote​


[​](#paymentmethodquote)[ID](/reference/graphql-api/shop/object-types#id)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[String](/reference/graphql-api/shop/object-types#string)[JSON](/reference/graphql-api/shop/object-types#json)
## PaymentMethodTranslation​


[​](#paymentmethodtranslation)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[LanguageCode](/reference/graphql-api/shop/enums#languagecode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)
## PriceRange​


[​](#pricerange)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)
## Product​


[​](#product)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[LanguageCode](/reference/graphql-api/shop/enums#languagecode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Asset](/reference/graphql-api/shop/object-types#asset)[Asset](/reference/graphql-api/shop/object-types#asset)[ProductVariant](/reference/graphql-api/shop/object-types#productvariant)[ProductVariantListOptions](/reference/graphql-api/shop/input-types#productvariantlistoptions)[ProductVariantList](/reference/graphql-api/shop/object-types#productvariantlist)[ProductOptionGroup](/reference/graphql-api/shop/object-types#productoptiongroup)[FacetValue](/reference/graphql-api/shop/object-types#facetvalue)[ProductTranslation](/reference/graphql-api/shop/object-types#producttranslation)[Collection](/reference/graphql-api/shop/object-types#collection)[JSON](/reference/graphql-api/shop/object-types#json)
## ProductList​


[​](#productlist)[Product](/reference/graphql-api/shop/object-types#product)[Int](/reference/graphql-api/shop/object-types#int)
## ProductOption​


[​](#productoption)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[LanguageCode](/reference/graphql-api/shop/enums#languagecode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[ID](/reference/graphql-api/shop/object-types#id)[ProductOptionGroup](/reference/graphql-api/shop/object-types#productoptiongroup)[ProductOptionTranslation](/reference/graphql-api/shop/object-types#productoptiontranslation)[JSON](/reference/graphql-api/shop/object-types#json)
## ProductOptionGroup​


[​](#productoptiongroup)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[LanguageCode](/reference/graphql-api/shop/enums#languagecode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[ProductOption](/reference/graphql-api/shop/object-types#productoption)[ProductOptionGroupTranslation](/reference/graphql-api/shop/object-types#productoptiongrouptranslation)[JSON](/reference/graphql-api/shop/object-types#json)
## ProductOptionGroupTranslation​


[​](#productoptiongrouptranslation)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[LanguageCode](/reference/graphql-api/shop/enums#languagecode)[String](/reference/graphql-api/shop/object-types#string)
## ProductOptionTranslation​


[​](#productoptiontranslation)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[LanguageCode](/reference/graphql-api/shop/enums#languagecode)[String](/reference/graphql-api/shop/object-types#string)
## ProductTranslation​


[​](#producttranslation)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[LanguageCode](/reference/graphql-api/shop/enums#languagecode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)
## ProductVariant​


[​](#productvariant)[ID](/reference/graphql-api/shop/object-types#id)[Product](/reference/graphql-api/shop/object-types#product)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[LanguageCode](/reference/graphql-api/shop/enums#languagecode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Asset](/reference/graphql-api/shop/object-types#asset)[Asset](/reference/graphql-api/shop/object-types#asset)[Money](/reference/graphql-api/shop/object-types#money)[CurrencyCode](/reference/graphql-api/shop/enums#currencycode)[Money](/reference/graphql-api/shop/object-types#money)[String](/reference/graphql-api/shop/object-types#string)[TaxRate](/reference/graphql-api/shop/object-types#taxrate)[TaxCategory](/reference/graphql-api/shop/object-types#taxcategory)[ProductOption](/reference/graphql-api/shop/object-types#productoption)[FacetValue](/reference/graphql-api/shop/object-types#facetvalue)[ProductVariantTranslation](/reference/graphql-api/shop/object-types#productvarianttranslation)[JSON](/reference/graphql-api/shop/object-types#json)
## ProductVariantList​


[​](#productvariantlist)[ProductVariant](/reference/graphql-api/shop/object-types#productvariant)[Int](/reference/graphql-api/shop/object-types#int)
## ProductVariantTranslation​


[​](#productvarianttranslation)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[LanguageCode](/reference/graphql-api/shop/enums#languagecode)[String](/reference/graphql-api/shop/object-types#string)
## Promotion​


[​](#promotion)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[String](/reference/graphql-api/shop/object-types#string)[Int](/reference/graphql-api/shop/object-types#int)[Int](/reference/graphql-api/shop/object-types#int)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[ConfigurableOperation](/reference/graphql-api/shop/object-types#configurableoperation)[ConfigurableOperation](/reference/graphql-api/shop/object-types#configurableoperation)[PromotionTranslation](/reference/graphql-api/shop/object-types#promotiontranslation)[JSON](/reference/graphql-api/shop/object-types#json)
## PromotionList​


[​](#promotionlist)[Promotion](/reference/graphql-api/shop/object-types#promotion)[Int](/reference/graphql-api/shop/object-types#int)
## PromotionTranslation​


[​](#promotiontranslation)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[LanguageCode](/reference/graphql-api/shop/enums#languagecode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)
## Province​


[​](#province)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[LanguageCode](/reference/graphql-api/shop/enums#languagecode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Region](/reference/graphql-api/shop/object-types#region)[ID](/reference/graphql-api/shop/object-types#id)[RegionTranslation](/reference/graphql-api/shop/object-types#regiontranslation)[JSON](/reference/graphql-api/shop/object-types#json)
## ProvinceList​


[​](#provincelist)[Province](/reference/graphql-api/shop/object-types#province)[Int](/reference/graphql-api/shop/object-types#int)
## PublicPaymentMethod​


[​](#publicpaymentmethod)[ID](/reference/graphql-api/shop/object-types#id)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[PaymentMethodTranslation](/reference/graphql-api/shop/object-types#paymentmethodtranslation)[JSON](/reference/graphql-api/shop/object-types#json)
## PublicShippingMethod​


[​](#publicshippingmethod)[ID](/reference/graphql-api/shop/object-types#id)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[ShippingMethodTranslation](/reference/graphql-api/shop/object-types#shippingmethodtranslation)[JSON](/reference/graphql-api/shop/object-types#json)
## RefreshCustomerVerificationResult​


[​](#refreshcustomerverificationresult)[Success](/reference/graphql-api/shop/object-types#success)[NativeAuthStrategyError](/reference/graphql-api/shop/object-types#nativeauthstrategyerror)
## Refund​


[​](#refund)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[RefundLine](/reference/graphql-api/shop/object-types#refundline)[ID](/reference/graphql-api/shop/object-types#id)[JSON](/reference/graphql-api/shop/object-types#json)[JSON](/reference/graphql-api/shop/object-types#json)
## RefundLine​


[​](#refundline)[OrderLine](/reference/graphql-api/shop/object-types#orderline)[ID](/reference/graphql-api/shop/object-types#id)[Int](/reference/graphql-api/shop/object-types#int)[Refund](/reference/graphql-api/shop/object-types#refund)[ID](/reference/graphql-api/shop/object-types#id)
## RegionTranslation​


[​](#regiontranslation)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[LanguageCode](/reference/graphql-api/shop/enums#languagecode)[String](/reference/graphql-api/shop/object-types#string)
## RegisterCustomerAccountResult​


[​](#registercustomeraccountresult)[Success](/reference/graphql-api/shop/object-types#success)[MissingPasswordError](/reference/graphql-api/shop/object-types#missingpassworderror)[PasswordValidationError](/reference/graphql-api/shop/object-types#passwordvalidationerror)[NativeAuthStrategyError](/reference/graphql-api/shop/object-types#nativeauthstrategyerror)
## RelationCustomFieldConfig​


[​](#relationcustomfieldconfig)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Permission](/reference/graphql-api/shop/enums#permission)[Boolean](/reference/graphql-api/shop/object-types#boolean)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[JSON](/reference/graphql-api/shop/object-types#json)
## RemoveOrderItemsResult​


[​](#removeorderitemsresult)[Order](/reference/graphql-api/shop/object-types#order)[OrderModificationError](/reference/graphql-api/shop/object-types#ordermodificationerror)[OrderInterceptorError](/reference/graphql-api/shop/object-types#orderinterceptorerror)
## RequestPasswordResetResult​


[​](#requestpasswordresetresult)[Success](/reference/graphql-api/shop/object-types#success)[NativeAuthStrategyError](/reference/graphql-api/shop/object-types#nativeauthstrategyerror)
## RequestUpdateCustomerEmailAddressResult​


[​](#requestupdatecustomeremailaddressresult)[Success](/reference/graphql-api/shop/object-types#success)[InvalidCredentialsError](/reference/graphql-api/shop/object-types#invalidcredentialserror)[EmailAddressConflictError](/reference/graphql-api/shop/object-types#emailaddressconflicterror)[NativeAuthStrategyError](/reference/graphql-api/shop/object-types#nativeauthstrategyerror)
## ResetPasswordResult​


[​](#resetpasswordresult)[CurrentUser](/reference/graphql-api/shop/object-types#currentuser)[PasswordResetTokenInvalidError](/reference/graphql-api/shop/object-types#passwordresettokeninvaliderror)[PasswordResetTokenExpiredError](/reference/graphql-api/shop/object-types#passwordresettokenexpirederror)[PasswordValidationError](/reference/graphql-api/shop/object-types#passwordvalidationerror)[NativeAuthStrategyError](/reference/graphql-api/shop/object-types#nativeauthstrategyerror)[NotVerifiedError](/reference/graphql-api/shop/object-types#notverifiederror)
## Role​


[​](#role)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Permission](/reference/graphql-api/shop/enums#permission)[Channel](/reference/graphql-api/shop/object-types#channel)
## RoleList​


[​](#rolelist)[Role](/reference/graphql-api/shop/object-types#role)[Int](/reference/graphql-api/shop/object-types#int)
## SearchReindexResponse​


[​](#searchreindexresponse)[Boolean](/reference/graphql-api/shop/object-types#boolean)
## SearchResponse​


[​](#searchresponse)[SearchResult](/reference/graphql-api/shop/object-types#searchresult)[Int](/reference/graphql-api/shop/object-types#int)[FacetValueResult](/reference/graphql-api/shop/object-types#facetvalueresult)[CollectionResult](/reference/graphql-api/shop/object-types#collectionresult)
## SearchResult​


[​](#searchresult)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[ID](/reference/graphql-api/shop/object-types#id)[String](/reference/graphql-api/shop/object-types#string)[SearchResultAsset](/reference/graphql-api/shop/object-types#searchresultasset)[ID](/reference/graphql-api/shop/object-types#id)[String](/reference/graphql-api/shop/object-types#string)[SearchResultAsset](/reference/graphql-api/shop/object-types#searchresultasset)[SearchResultPrice](/reference/graphql-api/shop/object-types#searchresultprice)[SearchResultPrice](/reference/graphql-api/shop/object-types#searchresultprice)[CurrencyCode](/reference/graphql-api/shop/enums#currencycode)[String](/reference/graphql-api/shop/object-types#string)[ID](/reference/graphql-api/shop/object-types#id)[ID](/reference/graphql-api/shop/object-types#id)[ID](/reference/graphql-api/shop/object-types#id)[Float](/reference/graphql-api/shop/object-types#float)
## SearchResultAsset​


[​](#searchresultasset)[ID](/reference/graphql-api/shop/object-types#id)[String](/reference/graphql-api/shop/object-types#string)[Coordinate](/reference/graphql-api/shop/object-types#coordinate)
## SearchResultPrice​


[​](#searchresultprice)[PriceRange](/reference/graphql-api/shop/object-types#pricerange)[SinglePrice](/reference/graphql-api/shop/object-types#singleprice)
## Seller​


[​](#seller)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[String](/reference/graphql-api/shop/object-types#string)[JSON](/reference/graphql-api/shop/object-types#json)
## SetCustomerForOrderResult​


[​](#setcustomerfororderresult)[Order](/reference/graphql-api/shop/object-types#order)[AlreadyLoggedInError](/reference/graphql-api/shop/object-types#alreadyloggedinerror)[EmailAddressConflictError](/reference/graphql-api/shop/object-types#emailaddressconflicterror)[NoActiveOrderError](/reference/graphql-api/shop/object-types#noactiveordererror)[GuestCheckoutError](/reference/graphql-api/shop/object-types#guestcheckouterror)
## SetOrderShippingMethodResult​


[​](#setordershippingmethodresult)[Order](/reference/graphql-api/shop/object-types#order)[OrderModificationError](/reference/graphql-api/shop/object-types#ordermodificationerror)[IneligibleShippingMethodError](/reference/graphql-api/shop/object-types#ineligibleshippingmethoderror)[NoActiveOrderError](/reference/graphql-api/shop/object-types#noactiveordererror)
## ShippingLine​


[​](#shippingline)[ID](/reference/graphql-api/shop/object-types#id)[ShippingMethod](/reference/graphql-api/shop/object-types#shippingmethod)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[Discount](/reference/graphql-api/shop/object-types#discount)[JSON](/reference/graphql-api/shop/object-types#json)
## ShippingMethod​


[​](#shippingmethod)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[LanguageCode](/reference/graphql-api/shop/enums#languagecode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[ConfigurableOperation](/reference/graphql-api/shop/object-types#configurableoperation)[ConfigurableOperation](/reference/graphql-api/shop/object-types#configurableoperation)[ShippingMethodTranslation](/reference/graphql-api/shop/object-types#shippingmethodtranslation)[JSON](/reference/graphql-api/shop/object-types#json)
## ShippingMethodList​


[​](#shippingmethodlist)[ShippingMethod](/reference/graphql-api/shop/object-types#shippingmethod)[Int](/reference/graphql-api/shop/object-types#int)
## ShippingMethodQuote​


[​](#shippingmethodquote)[ID](/reference/graphql-api/shop/object-types#id)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[JSON](/reference/graphql-api/shop/object-types#json)[JSON](/reference/graphql-api/shop/object-types#json)
## ShippingMethodTranslation​


[​](#shippingmethodtranslation)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[LanguageCode](/reference/graphql-api/shop/enums#languagecode)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)
## SinglePrice​


[​](#singleprice)[Money](/reference/graphql-api/shop/object-types#money)
## String​


[​](#string)
## StringCustomFieldConfig​


[​](#stringcustomfieldconfig)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Int](/reference/graphql-api/shop/object-types#int)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Permission](/reference/graphql-api/shop/enums#permission)[Boolean](/reference/graphql-api/shop/object-types#boolean)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[StringFieldOption](/reference/graphql-api/shop/object-types#stringfieldoption)[JSON](/reference/graphql-api/shop/object-types#json)
## StringFieldOption​


[​](#stringfieldoption)[String](/reference/graphql-api/shop/object-types#string)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)
## StringStructFieldConfig​


[​](#stringstructfieldconfig)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[Int](/reference/graphql-api/shop/object-types#int)[String](/reference/graphql-api/shop/object-types#string)[StringFieldOption](/reference/graphql-api/shop/object-types#stringfieldoption)[JSON](/reference/graphql-api/shop/object-types#json)
## StructCustomFieldConfig​


[​](#structcustomfieldconfig)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[StructFieldConfig](/reference/graphql-api/shop/object-types#structfieldconfig)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Permission](/reference/graphql-api/shop/enums#permission)[Boolean](/reference/graphql-api/shop/object-types#boolean)[String](/reference/graphql-api/shop/object-types#string)[JSON](/reference/graphql-api/shop/object-types#json)
## StructFieldConfig​


[​](#structfieldconfig)[StringStructFieldConfig](/reference/graphql-api/shop/object-types#stringstructfieldconfig)[IntStructFieldConfig](/reference/graphql-api/shop/object-types#intstructfieldconfig)[FloatStructFieldConfig](/reference/graphql-api/shop/object-types#floatstructfieldconfig)[BooleanStructFieldConfig](/reference/graphql-api/shop/object-types#booleanstructfieldconfig)[DateTimeStructFieldConfig](/reference/graphql-api/shop/object-types#datetimestructfieldconfig)[TextStructFieldConfig](/reference/graphql-api/shop/object-types#textstructfieldconfig)
## Success​


[​](#success)[Boolean](/reference/graphql-api/shop/object-types#boolean)
## Surcharge​


[​](#surcharge)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[TaxLine](/reference/graphql-api/shop/object-types#taxline)[Money](/reference/graphql-api/shop/object-types#money)[Money](/reference/graphql-api/shop/object-types#money)[Float](/reference/graphql-api/shop/object-types#float)
## Tag​


[​](#tag)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[String](/reference/graphql-api/shop/object-types#string)
## TagList​


[​](#taglist)[Tag](/reference/graphql-api/shop/object-types#tag)[Int](/reference/graphql-api/shop/object-types#int)
## TaxCategory​


[​](#taxcategory)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[JSON](/reference/graphql-api/shop/object-types#json)
## TaxLine​


[​](#taxline)[String](/reference/graphql-api/shop/object-types#string)[Float](/reference/graphql-api/shop/object-types#float)
## TaxRate​


[​](#taxrate)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Float](/reference/graphql-api/shop/object-types#float)[TaxCategory](/reference/graphql-api/shop/object-types#taxcategory)[Zone](/reference/graphql-api/shop/object-types#zone)[CustomerGroup](/reference/graphql-api/shop/object-types#customergroup)[JSON](/reference/graphql-api/shop/object-types#json)
## TaxRateList​


[​](#taxratelist)[TaxRate](/reference/graphql-api/shop/object-types#taxrate)[Int](/reference/graphql-api/shop/object-types#int)
## TextCustomFieldConfig​


[​](#textcustomfieldconfig)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Permission](/reference/graphql-api/shop/enums#permission)[Boolean](/reference/graphql-api/shop/object-types#boolean)[String](/reference/graphql-api/shop/object-types#string)[JSON](/reference/graphql-api/shop/object-types#json)
## TextStructFieldConfig​


[​](#textstructfieldconfig)[String](/reference/graphql-api/shop/object-types#string)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[LocalizedString](/reference/graphql-api/shop/object-types#localizedstring)[JSON](/reference/graphql-api/shop/object-types#json)
## TransitionOrderToStateResult​


[​](#transitionordertostateresult)[Order](/reference/graphql-api/shop/object-types#order)[OrderStateTransitionError](/reference/graphql-api/shop/object-types#orderstatetransitionerror)
## UpdateCustomerEmailAddressResult​


[​](#updatecustomeremailaddressresult)[Success](/reference/graphql-api/shop/object-types#success)[IdentifierChangeTokenInvalidError](/reference/graphql-api/shop/object-types#identifierchangetokeninvaliderror)[IdentifierChangeTokenExpiredError](/reference/graphql-api/shop/object-types#identifierchangetokenexpirederror)[NativeAuthStrategyError](/reference/graphql-api/shop/object-types#nativeauthstrategyerror)
## UpdateCustomerPasswordResult​


[​](#updatecustomerpasswordresult)[Success](/reference/graphql-api/shop/object-types#success)[InvalidCredentialsError](/reference/graphql-api/shop/object-types#invalidcredentialserror)[PasswordValidationError](/reference/graphql-api/shop/object-types#passwordvalidationerror)[NativeAuthStrategyError](/reference/graphql-api/shop/object-types#nativeauthstrategyerror)
## UpdateMultipleOrderItemsResult​


[​](#updatemultipleorderitemsresult)[Order](/reference/graphql-api/shop/object-types#order)[UpdateOrderItemErrorResult](/reference/graphql-api/shop/object-types#updateorderitemerrorresult)
## UpdateOrderItemErrorResult​


[​](#updateorderitemerrorresult)[OrderModificationError](/reference/graphql-api/shop/object-types#ordermodificationerror)[OrderLimitError](/reference/graphql-api/shop/object-types#orderlimiterror)[NegativeQuantityError](/reference/graphql-api/shop/object-types#negativequantityerror)[InsufficientStockError](/reference/graphql-api/shop/object-types#insufficientstockerror)[OrderInterceptorError](/reference/graphql-api/shop/object-types#orderinterceptorerror)
## UpdateOrderItemsResult​


[​](#updateorderitemsresult)[Order](/reference/graphql-api/shop/object-types#order)[OrderModificationError](/reference/graphql-api/shop/object-types#ordermodificationerror)[OrderLimitError](/reference/graphql-api/shop/object-types#orderlimiterror)[NegativeQuantityError](/reference/graphql-api/shop/object-types#negativequantityerror)[InsufficientStockError](/reference/graphql-api/shop/object-types#insufficientstockerror)[OrderInterceptorError](/reference/graphql-api/shop/object-types#orderinterceptorerror)
## Upload​


[​](#upload)
## User​


[​](#user)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[String](/reference/graphql-api/shop/object-types#string)[Boolean](/reference/graphql-api/shop/object-types#boolean)[Role](/reference/graphql-api/shop/object-types#role)[DateTime](/reference/graphql-api/shop/object-types#datetime)[AuthenticationMethod](/reference/graphql-api/shop/object-types#authenticationmethod)[JSON](/reference/graphql-api/shop/object-types#json)
## VerificationTokenExpiredError​


[​](#verificationtokenexpirederror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)
## VerificationTokenInvalidError​


[​](#verificationtokeninvaliderror)[ErrorCode](/reference/graphql-api/shop/enums#errorcode)[String](/reference/graphql-api/shop/object-types#string)
## VerifyCustomerAccountResult​


[​](#verifycustomeraccountresult)[CurrentUser](/reference/graphql-api/shop/object-types#currentuser)[VerificationTokenInvalidError](/reference/graphql-api/shop/object-types#verificationtokeninvaliderror)[VerificationTokenExpiredError](/reference/graphql-api/shop/object-types#verificationtokenexpirederror)[MissingPasswordError](/reference/graphql-api/shop/object-types#missingpassworderror)[PasswordValidationError](/reference/graphql-api/shop/object-types#passwordvalidationerror)[PasswordAlreadySetError](/reference/graphql-api/shop/object-types#passwordalreadyseterror)[NativeAuthStrategyError](/reference/graphql-api/shop/object-types#nativeauthstrategyerror)
## Zone​


[​](#zone)[ID](/reference/graphql-api/shop/object-types#id)[DateTime](/reference/graphql-api/shop/object-types#datetime)[DateTime](/reference/graphql-api/shop/object-types#datetime)[String](/reference/graphql-api/shop/object-types#string)[Region](/reference/graphql-api/shop/object-types#region)[JSON](/reference/graphql-api/shop/object-types#json)


---

# Queries


## activeChannel​


[​](#activechannel)[Channel](/reference/graphql-api/shop/object-types#channel)
## activeCustomer​


[​](#activecustomer)[Customer](/reference/graphql-api/shop/object-types#customer)
## activeOrder​


[​](#activeorder)[Order](/reference/graphql-api/shop/object-types#order)
## activePaymentMethods​


[​](#activepaymentmethods)[PublicPaymentMethod](/reference/graphql-api/shop/object-types#publicpaymentmethod)
## activeShippingMethods​


[​](#activeshippingmethods)[PublicShippingMethod](/reference/graphql-api/shop/object-types#publicshippingmethod)
## availableCountries​


[​](#availablecountries)[Country](/reference/graphql-api/shop/object-types#country)
## collection​


[​](#collection)[ID](/reference/graphql-api/shop/object-types#id)[String](/reference/graphql-api/shop/object-types#string)[Collection](/reference/graphql-api/shop/object-types#collection)
## collections​


[​](#collections)[CollectionListOptions](/reference/graphql-api/shop/input-types#collectionlistoptions)[CollectionList](/reference/graphql-api/shop/object-types#collectionlist)
## eligiblePaymentMethods​


[​](#eligiblepaymentmethods)[PaymentMethodQuote](/reference/graphql-api/shop/object-types#paymentmethodquote)
## eligibleShippingMethods​


[​](#eligibleshippingmethods)[ShippingMethodQuote](/reference/graphql-api/shop/object-types#shippingmethodquote)
## facet​


[​](#facet)[ID](/reference/graphql-api/shop/object-types#id)[Facet](/reference/graphql-api/shop/object-types#facet)
## facets​


[​](#facets)[FacetListOptions](/reference/graphql-api/shop/input-types#facetlistoptions)[FacetList](/reference/graphql-api/shop/object-types#facetlist)
## me​


[​](#me)[CurrentUser](/reference/graphql-api/shop/object-types#currentuser)
## nextOrderStates​


[​](#nextorderstates)[String](/reference/graphql-api/shop/object-types#string)
## order​


[​](#order)[ID](/reference/graphql-api/shop/object-types#id)[Order](/reference/graphql-api/shop/object-types#order)
## orderByCode​


[​](#orderbycode)[String](/reference/graphql-api/shop/object-types#string)[Order](/reference/graphql-api/shop/object-types#order)
## product​


[​](#product)[ID](/reference/graphql-api/shop/object-types#id)[String](/reference/graphql-api/shop/object-types#string)[Product](/reference/graphql-api/shop/object-types#product)
## products​


[​](#products)[ProductListOptions](/reference/graphql-api/shop/input-types#productlistoptions)[ProductList](/reference/graphql-api/shop/object-types#productlist)
## search​


[​](#search)[SearchInput](/reference/graphql-api/shop/input-types#searchinput)[SearchResponse](/reference/graphql-api/shop/object-types#searchresponse)
