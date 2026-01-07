# AdminUiPlugin


## AdminUiPlugin​


[​](#adminuiplugin)[@vendure/admin-ui-plugin](https://www.npmjs.com/package/@vendure/admin-ui-plugin)[plugin.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui-plugin/src/plugin.ts#L147)From Vendure v3.5.0, the Angular-based Admin UI has been replaced by the new React Admin Dashboard.
The Angular Admin UI will not be maintained after July 2026. Until then, we will continue patching critical bugs and security issues.
Community contributions will always be merged and released.

[React Admin Dashboard](/guides/extending-the-dashboard/getting-started/)This plugin starts a static server for the Admin UI app, and proxies it via the /admin/ path of the main Vendure server.

The Admin UI allows you to administer all aspects of your store, from inventory management to order tracking. It is the tool used by
store administrators on a day-to-day basis for the management of the store.

## Installation​


[​](#installation)yarn add @vendure/admin-ui-plugin

or

npm install @vendure/admin-ui-plugin

Example

```
import { AdminUiPlugin } from '@vendure/admin-ui-plugin';const config: VendureConfig = {  // Add an instance of the plugin to the plugins array  plugins: [    AdminUiPlugin.init({ port: 3002 }),  ],};
```

## Metrics​


[​](#metrics)This plugin also defines a metricSummary query which is used by the Admin UI to display the order metrics on the dashboard.

If you are building a stand-alone version of the Admin UI app, and therefore don't need this plugin to server the Admin UI,
you can still use the metricSummary query by adding the AdminUiPlugin to the plugins array, but without calling the init() method:

Example

```
import { AdminUiPlugin } from '@vendure/admin-ui-plugin';const config: VendureConfig = {  plugins: [    AdminUiPlugin, // <-- no call to .init()  ],  // ...};
```

```
class AdminUiPlugin implements NestModule {    constructor(configService: ConfigService, processContext: ProcessContext)    init(options: AdminUiPluginOptions) => Type<AdminUiPlugin>;    configure(consumer: MiddlewareConsumer) => ;}
```

- Implements: NestModule

### constructor​


[​](#constructor)[ProcessContext](/reference/typescript-api/common/process-context#processcontext)
### init​


[​](#init)[AdminUiPluginOptions](/reference/core-plugins/admin-ui-plugin/admin-ui-plugin-options#adminuipluginoptions)[AdminUiPlugin](/reference/core-plugins/admin-ui-plugin/#adminuiplugin)Set the plugin options

### configure​


[​](#configure)


---

# AdminUiPluginOptions


## AdminUiPluginOptions​


[​](#adminuipluginoptions)[@vendure/admin-ui-plugin](https://www.npmjs.com/package/@vendure/admin-ui-plugin)[plugin.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/admin-ui-plugin/src/plugin.ts#L44)Configuration options for the AdminUiPlugin.

[AdminUiPlugin](/reference/core-plugins/admin-ui-plugin/#adminuiplugin)
```
interface AdminUiPluginOptions {    route: string;    port: number;    hostname?: string;    app?: AdminUiAppConfig | AdminUiAppDevModeConfig;    adminUiConfig?: Partial<AdminUiConfig>;    compatibilityMode?: boolean;}
```

### route​


[​](#route)The route to the Admin UI.

Note: If you are using the compileUiExtensions function to compile a custom version of the Admin UI, then
the route should match the baseHref option passed to that function. The default value of baseHref is /admin/,
so it only needs to be changed if you set this route option to something other than "admin".

### port​


[​](#port)The port on which the server will listen. This port will be proxied by the AdminUiPlugin to the same port that
the Vendure server is running on.

### hostname​


[​](#hostname)The hostname of the server serving the static admin ui files.

### app​


[​](#app)[AdminUiAppConfig](/reference/typescript-api/common/admin-ui/admin-ui-app-config#adminuiappconfig)[AdminUiAppDevModeConfig](/reference/typescript-api/common/admin-ui/admin-ui-app-dev-mode-config#adminuiappdevmodeconfig)By default, the AdminUiPlugin comes bundles with a pre-built version of the
Admin UI. This option can be used to override this default build with a different
version, e.g. one pre-compiled with one or more ui extensions.

### adminUiConfig​


[​](#adminuiconfig)[AdminUiConfig](/reference/typescript-api/common/admin-ui/admin-ui-config#adminuiconfig)Allows the contents of the vendure-ui-config.json file to be set, e.g.
for specifying the Vendure GraphQL API host, available UI languages, etc.

### compatibilityMode​


[​](#compatibilitymode)


---

# AssetServerPlugin


## AssetServerPlugin​


[​](#assetserverplugin)[@vendure/asset-server-plugin](https://www.npmjs.com/package/@vendure/asset-server-plugin)[plugin.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/asset-server-plugin/src/plugin.ts#L176)The AssetServerPlugin serves assets (images and other files) from the local file system, and can also be configured to use
other storage strategies (e.g. S3AssetStorageStrategy. It can also perform on-the-fly image transformations
and caches the results for subsequent calls.

[S3AssetStorageStrategy](/reference/core-plugins/asset-server-plugin/s3asset-storage-strategy#s3assetstoragestrategy)
## Installation​


[​](#installation)yarn add @vendure/asset-server-plugin

or

npm install @vendure/asset-server-plugin

Example

```
import { AssetServerPlugin } from '@vendure/asset-server-plugin';const config: VendureConfig = {  // Add an instance of the plugin to the plugins array  plugins: [    AssetServerPlugin.init({      route: 'assets',      assetUploadDir: path.join(__dirname, 'assets'),    }),  ],};
```

The full configuration is documented at AssetServerOptions

[AssetServerOptions](/reference/core-plugins/asset-server-plugin/asset-server-options)
## Image transformation​


[​](#image-transformation)Asset preview images can be transformed (resized & cropped) on the fly by appending query parameters to the url:

http://localhost:3000/assets/some-asset.jpg?w=500&h=300&mode=resize

The above URL will return some-asset.jpg, resized to fit in the bounds of a 500px x 300px rectangle.

### Preview mode​


[​](#preview-mode)The mode parameter can be either crop or resize. See the ImageTransformMode docs for details.

[ImageTransformMode](/reference/core-plugins/asset-server-plugin/image-transform-mode)
### Focal point​


[​](#focal-point)When cropping an image (mode=crop), Vendure will attempt to keep the most "interesting" area of the image in the cropped frame. It does this
by finding the area of the image with highest entropy (the busiest area of the image). However, sometimes this does not yield a satisfactory
result - part or all of the main subject may still be cropped out.

This is where specifying the focal point can help. The focal point of the image may be specified by passing the fpx and fpy query parameters.
These are normalized coordinates (i.e. a number between 0 and 1), so the fpx=0&fpy=0 corresponds to the top left of the image.

For example, let's say there is a very wide landscape image which we want to crop to be square. The main subject is a house to the far left of the
image. The following query would crop it to a square with the house centered:

http://localhost:3000/assets/landscape.jpg?w=150&h=150&mode=crop&fpx=0.2&fpy=0.7

### Format​


[​](#format)Since v1.7.0, the image format can be specified by adding the format query parameter:

http://localhost:3000/assets/some-asset.jpg?format=webp

This means that, no matter the format of your original asset files, you can use more modern formats in your storefront if the browser
supports them. Supported values for format are:

- jpeg or jpg
- png
- webp
- avif

The format parameter can also be combined with presets (see below).

### Quality​


[​](#quality)Since v2.2.0, the image quality can be specified by adding the q query parameter:

http://localhost:3000/assets/some-asset.jpg?q=75

This applies to the jpg, webp and avif formats. The default quality value for jpg and webp is 80, and for avif is 50.

The q parameter can also be combined with presets (see below).

### Transform presets​


[​](#transform-presets)Presets can be defined which allow a single preset name to be used instead of specifying the width, height and mode. Presets are
configured via the AssetServerOptions presets property.

[presets property](/reference/core-plugins/asset-server-plugin/asset-server-options/#presets)For example, defining the following preset:

```
AssetServerPlugin.init({  // ...  presets: [    { name: 'my-preset', width: 85, height: 85, mode: 'crop' },  ],}),
```

means that a request to:

http://localhost:3000/assets/some-asset.jpg?preset=my-preset

is equivalent to:

http://localhost:3000/assets/some-asset.jpg?w=85&h=85&mode=crop

The AssetServerPlugin comes pre-configured with the following presets:

### Caching​


[​](#caching)By default, the AssetServerPlugin will cache every transformed image, so that the transformation only needs to be performed a single time for
a given configuration. Caching can be disabled per-request by setting the ?cache=false query parameter.

### Limiting transformations​


[​](#limiting-transformations)By default, the AssetServerPlugin will allow any transformation to be performed on an image. However, it is possible to restrict the transformations
which can be performed by using an ImageTransformStrategy. This can be used to limit the transformations to a known set of presets, for example.

[ImageTransformStrategy](/reference/core-plugins/asset-server-plugin/image-transform-strategy#imagetransformstrategy)This is advisable in order to prevent abuse of the image transformation feature, as it can be computationally expensive.

Since v3.1.0 we ship with a PresetOnlyStrategy which allows only transformations using a known set of presets.

[PresetOnlyStrategy](/reference/core-plugins/asset-server-plugin/preset-only-strategy#presetonlystrategy)Example

```
import { AssetServerPlugin, PresetOnlyStrategy } from '@vendure/core';// ...AssetServerPlugin.init({  //...  imageTransformStrategy: new PresetOnlyStrategy({    defaultPreset: 'thumbnail',    permittedQuality: [0, 50, 75, 85, 95],    permittedFormats: ['jpg', 'webp', 'avif'],    allowFocalPoint: false,  }),});
```

```
class AssetServerPlugin implements NestModule, OnApplicationBootstrap, OnApplicationShutdown {    init(options: AssetServerOptions) => Type<AssetServerPlugin>;    constructor(options: AssetServerOptions, processContext: ProcessContext, moduleRef: ModuleRef, assetServer: AssetServer)    configure(consumer: MiddlewareConsumer) => ;}
```

- Implements: NestModule, OnApplicationBootstrap, OnApplicationShutdown

### init​


[​](#init)[AssetServerOptions](/reference/core-plugins/asset-server-plugin/asset-server-options#assetserveroptions)[AssetServerPlugin](/reference/core-plugins/asset-server-plugin/#assetserverplugin)Set the plugin options.

### constructor​


[​](#constructor)[AssetServerOptions](/reference/core-plugins/asset-server-plugin/asset-server-options#assetserveroptions)[ProcessContext](/reference/typescript-api/common/process-context#processcontext)
### configure​


[​](#configure)

---

# AssetServerOptions


## AssetServerOptions​


[​](#assetserveroptions)[@vendure/asset-server-plugin](https://www.npmjs.com/package/@vendure/asset-server-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/asset-server-plugin/src/types.ts#L74)The configuration options for the AssetServerPlugin.

```
interface AssetServerOptions {    route: string;    assetUploadDir: string;    assetUrlPrefix?: string | ((ctx: RequestContext, identifier: string) => string);    previewMaxWidth?: number;    previewMaxHeight?: number;    presets?: ImageTransformPreset[];    imageTransformStrategy?: ImageTransformStrategy | ImageTransformStrategy[];    namingStrategy?: AssetNamingStrategy;    previewStrategy?: AssetPreviewStrategy;    storageStrategyFactory?: (        options: AssetServerOptions,    ) => AssetStorageStrategy | Promise<AssetStorageStrategy>;    cacheHeader?: CacheConfig | string;}
```

### route​


[​](#route)The route to the asset server.

### assetUploadDir​


[​](#assetuploaddir)The local directory to which assets will be uploaded when using the LocalAssetStorageStrategy.

[LocalAssetStorageStrategy](/reference/core-plugins/asset-server-plugin/local-asset-storage-strategy#localassetstoragestrategy)
### assetUrlPrefix​


[​](#asseturlprefix)[RequestContext](/reference/typescript-api/request/request-context#requestcontext)The complete URL prefix of the asset files. For example, "https://demo.vendure.io/assets/". A
function can also be provided to handle more complex cases, such as serving multiple domains
from a single server. In this case, the function should return a string url prefix.

[https://demo.vendure.io/assets/](https://demo.vendure.io/assets/)If not provided, the plugin will attempt to guess based off the incoming
request and the configured route. However, in all but the simplest cases,
this guess may not yield correct results.

### previewMaxWidth​


[​](#previewmaxwidth)The max width in pixels of a generated preview image.

### previewMaxHeight​


[​](#previewmaxheight)The max height in pixels of a generated preview image.

### presets​


[​](#presets)[ImageTransformPreset](/reference/core-plugins/asset-server-plugin/image-transform-preset#imagetransformpreset)An array of additional ImageTransformPreset objects.

[ImageTransformPreset](/reference/core-plugins/asset-server-plugin/image-transform-preset#imagetransformpreset)
### imageTransformStrategy​


[​](#imagetransformstrategy)[ImageTransformStrategy](/reference/core-plugins/asset-server-plugin/image-transform-strategy#imagetransformstrategy)[ImageTransformStrategy](/reference/core-plugins/asset-server-plugin/image-transform-strategy#imagetransformstrategy)The strategy or strategies to use to determine the parameters for transforming an image.
This can be used to implement custom image transformation logic, for example to
limit transform parameters to a known set of presets.

If multiple strategies are provided, they will be executed in the order in which they are defined.
If a strategy throws an error, the image transformation will be aborted and the error
will be logged, with an HTTP 400 response sent to the client.

### namingStrategy​


[​](#namingstrategy)[AssetNamingStrategy](/reference/typescript-api/assets/asset-naming-strategy#assetnamingstrategy)[HashedAssetNamingStrategy](/reference/core-plugins/asset-server-plugin/hashed-asset-naming-strategy#hashedassetnamingstrategy)Defines how asset files and preview images are named before being saved.

### previewStrategy​


[​](#previewstrategy)[AssetPreviewStrategy](/reference/typescript-api/assets/asset-preview-strategy#assetpreviewstrategy)Defines how previews are generated for a given Asset binary. By default, this uses
the SharpAssetPreviewStrategy

[SharpAssetPreviewStrategy](/reference/core-plugins/asset-server-plugin/sharp-asset-preview-strategy#sharpassetpreviewstrategy)
### storageStrategyFactory​


[​](#storagestrategyfactory)[AssetServerOptions](/reference/core-plugins/asset-server-plugin/asset-server-options#assetserveroptions)[AssetStorageStrategy](/reference/typescript-api/assets/asset-storage-strategy#assetstoragestrategy)[AssetStorageStrategy](/reference/typescript-api/assets/asset-storage-strategy#assetstoragestrategy)[LocalAssetStorageStrategy](/reference/core-plugins/asset-server-plugin/local-asset-storage-strategy#localassetstoragestrategy)A function which can be used to configure an AssetStorageStrategy. This is useful e.g. if you wish to store your assets
using a cloud storage provider. By default, the LocalAssetStorageStrategy is used.

[AssetStorageStrategy](/reference/typescript-api/assets/asset-storage-strategy#assetstoragestrategy)[LocalAssetStorageStrategy](/reference/core-plugins/asset-server-plugin/local-asset-storage-strategy#localassetstoragestrategy)
### cacheHeader​


[​](#cacheheader)[CacheConfig](/reference/core-plugins/asset-server-plugin/cache-config#cacheconfig)Configures the Cache-Control directive for response to control caching in browsers and shared caches (e.g. Proxies, CDNs).
Defaults to publicly cached for 6 months.


---

# CacheConfig


## CacheConfig​


[​](#cacheconfig)[@vendure/asset-server-plugin](https://www.npmjs.com/package/@vendure/asset-server-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/asset-server-plugin/src/types.ts#L54)A configuration option for the Cache-Control header in the AssetServerPlugin asset response.

```
type CacheConfig = {    maxAge: number;    restriction?: 'public' | 'private';}
```

### maxAge​


[​](#maxage)The max-age=N response directive indicates that the response remains fresh until N seconds after the response is generated.

### restriction​


[​](#restriction)The private response directive indicates that the response can be stored only in a private cache (e.g. local caches in browsers).
The public response directive indicates that the response can be stored in a shared cache.


---

# HashedAssetNamingStrategy


## HashedAssetNamingStrategy​


[​](#hashedassetnamingstrategy)[@vendure/asset-server-plugin](https://www.npmjs.com/package/@vendure/asset-server-plugin)[hashed-asset-naming-strategy.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/asset-server-plugin/src/config/hashed-asset-naming-strategy.ts#L20)An extension of the DefaultAssetNamingStrategy which prefixes file names with
the type ('source' or 'preview') as well as a 2-character sub-directory based on
the md5 hash of the original file name.

[DefaultAssetNamingStrategy](/reference/typescript-api/assets/default-asset-naming-strategy#defaultassetnamingstrategy)This is an implementation of the technique knows as "hashed directory" file storage,
and the purpose is to reduce the number of files in a single directory, since a very large
number of files can lead to performance issues when reading and writing to that directory.

With this strategy, even with 200,000 total assets stored, each directory would
only contain less than 800 files.

```
class HashedAssetNamingStrategy extends DefaultAssetNamingStrategy {    generateSourceFileName(ctx: RequestContext, originalFileName: string, conflictFileName?: string) => string;    generatePreviewFileName(ctx: RequestContext, originalFileName: string, conflictFileName?: string) => string;}
```

- Extends: DefaultAssetNamingStrategy

[DefaultAssetNamingStrategy](/reference/typescript-api/assets/default-asset-naming-strategy#defaultassetnamingstrategy)
### generateSourceFileName​


[​](#generatesourcefilename)[RequestContext](/reference/typescript-api/request/request-context#requestcontext)
### generatePreviewFileName​


[​](#generatepreviewfilename)[RequestContext](/reference/typescript-api/request/request-context#requestcontext)


---

# ImageTransformMode


## ImageTransformMode​


[​](#imagetransformmode)[@vendure/asset-server-plugin](https://www.npmjs.com/package/@vendure/asset-server-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/asset-server-plugin/src/types.ts#L23)Specifies the way in which an asset preview image will be resized to fit in the
proscribed dimensions:

- crop: crops the image to cover both provided dimensions
- resize: Preserving aspect ratio, resizes the image to be as large as possible
while ensuring its dimensions are less than or equal to both those specified.

```
type ImageTransformMode = 'crop' | 'resize'
```


---

# ImageTransformPreset


## ImageTransformPreset​


[​](#imagetransformpreset)[@vendure/asset-server-plugin](https://www.npmjs.com/package/@vendure/asset-server-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/asset-server-plugin/src/types.ts#L41)A configuration option for an image size preset for the AssetServerPlugin.

Presets allow a shorthand way to generate a thumbnail preview of an asset. For example,
the built-in "tiny" preset generates a 50px x 50px cropped preview, which can be accessed
by appending the string preset=tiny to the asset url:

http://localhost:3000/assets/some-asset.jpg?preset=tiny

is equivalent to:

http://localhost:3000/assets/some-asset.jpg?w=50&h=50&mode=crop

```
interface ImageTransformPreset {    name: string;    width: number;    height: number;    mode: ImageTransformMode;}
```

### name​


[​](#name)
### width​


[​](#width)
### height​


[​](#height)
### mode​


[​](#mode)[ImageTransformMode](/reference/core-plugins/asset-server-plugin/image-transform-mode#imagetransformmode)


---

# ImageTransformStrategy


## ImageTransformStrategy​


[​](#imagetransformstrategy)[@vendure/asset-server-plugin](https://www.npmjs.com/package/@vendure/asset-server-plugin)[image-transform-strategy.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/asset-server-plugin/src/config/image-transform-strategy.ts#L56)An injectable strategy which is used to determine the parameters for transforming an image.
This can be used to implement custom image transformation logic, for example to
limit transform parameters to a known set of presets.

This is set via the imageTransformStrategy option in the AssetServerOptions. Multiple
strategies can be defined and will be executed in the order in which they are defined.

If a strategy throws an error, the image transformation will be aborted and the error
will be logged, with an HTTP 400 response sent to the client.

```
interface ImageTransformStrategy extends InjectableStrategy {    getImageTransformParameters(        args: GetImageTransformParametersArgs,    ): Promise<ImageTransformParameters> | ImageTransformParameters;}
```

- Extends: InjectableStrategy

[InjectableStrategy](/reference/typescript-api/common/injectable-strategy#injectablestrategy)
### getImageTransformParameters​


[​](#getimagetransformparameters)[GetImageTransformParametersArgs](/reference/core-plugins/asset-server-plugin/image-transform-strategy#getimagetransformparametersargs)[ImageTransformParameters](/reference/core-plugins/asset-server-plugin/image-transform-strategy#imagetransformparameters)[ImageTransformParameters](/reference/core-plugins/asset-server-plugin/image-transform-strategy#imagetransformparameters)Given the input parameters, return the parameters which should be used to transform the image.

## ImageTransformParameters​


[​](#imagetransformparameters)[@vendure/asset-server-plugin](https://www.npmjs.com/package/@vendure/asset-server-plugin)[image-transform-strategy.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/asset-server-plugin/src/config/image-transform-strategy.ts#L14)Parameters which are used to transform the image.

```
interface ImageTransformParameters {    width: number | undefined;    height: number | undefined;    mode: ImageTransformMode | undefined;    quality: number | undefined;    format: ImageTransformFormat | undefined;    fpx: number | undefined;    fpy: number | undefined;    preset: string | undefined;}
```

### width​


[​](#width)
### height​


[​](#height)
### mode​


[​](#mode)[ImageTransformMode](/reference/core-plugins/asset-server-plugin/image-transform-mode#imagetransformmode)
### quality​


[​](#quality)
### format​


[​](#format)
### fpx​


[​](#fpx)
### fpy​


[​](#fpy)
### preset​


[​](#preset)
## GetImageTransformParametersArgs​


[​](#getimagetransformparametersargs)[@vendure/asset-server-plugin](https://www.npmjs.com/package/@vendure/asset-server-plugin)[image-transform-strategy.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/asset-server-plugin/src/config/image-transform-strategy.ts#L33)The arguments passed to the getImageTransformParameters method of an ImageTransformStrategy.

```
interface GetImageTransformParametersArgs {    req: Request;    availablePresets: ImageTransformPreset[];    input: ImageTransformParameters;}
```

### req​


[​](#req)
### availablePresets​


[​](#availablepresets)[ImageTransformPreset](/reference/core-plugins/asset-server-plugin/image-transform-preset#imagetransformpreset)
### input​


[​](#input)[ImageTransformParameters](/reference/core-plugins/asset-server-plugin/image-transform-strategy#imagetransformparameters)


---

# LocalAssetStorageStrategy


## LocalAssetStorageStrategy​


[​](#localassetstoragestrategy)[@vendure/asset-server-plugin](https://www.npmjs.com/package/@vendure/asset-server-plugin)[local-asset-storage-strategy.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/asset-server-plugin/src/config/local-asset-storage-strategy.ts#L15)A persistence strategy which saves files to the local file system.

```
class LocalAssetStorageStrategy implements AssetStorageStrategy {    toAbsoluteUrl: ((reqest: Request, identifier: string) => string) | undefined;    constructor(uploadPath: string, toAbsoluteUrlFn?: (reqest: Request, identifier: string) => string)    writeFileFromStream(fileName: string, data: ReadStream) => Promise<string>;    writeFileFromBuffer(fileName: string, data: Buffer) => Promise<string>;    fileExists(fileName: string) => Promise<boolean>;    readFileToBuffer(identifier: string) => Promise<Buffer>;    readFileToStream(identifier: string) => Promise<Stream>;    deleteFile(identifier: string) => Promise<void>;}
```

- Implements: AssetStorageStrategy

[AssetStorageStrategy](/reference/typescript-api/assets/asset-storage-strategy#assetstoragestrategy)
### toAbsoluteUrl​


[​](#toabsoluteurl)
### constructor​


[​](#constructor)
### writeFileFromStream​


[​](#writefilefromstream)
### writeFileFromBuffer​


[​](#writefilefrombuffer)
### fileExists​


[​](#fileexists)
### readFileToBuffer​


[​](#readfiletobuffer)
### readFileToStream​


[​](#readfiletostream)
### deleteFile​


[​](#deletefile)


---

# PresetOnlyStrategy


## PresetOnlyStrategy​


[​](#presetonlystrategy)[@vendure/asset-server-plugin](https://www.npmjs.com/package/@vendure/asset-server-plugin)[preset-only-strategy.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/asset-server-plugin/src/config/preset-only-strategy.ts#L85)An ImageTransformStrategy which only allows transformations to be made using
presets which are defined in the available presets.

[ImageTransformStrategy](/reference/core-plugins/asset-server-plugin/image-transform-strategy#imagetransformstrategy)With this strategy enabled, requests to the asset server must include a preset parameter (or use the default preset)

This is valid: http://localhost:3000/assets/some-asset.jpg?preset=medium

This is invalid: http://localhost:3000/assets/some-asset.jpg?w=200&h=200, and the dimensions will be ignored.

The strategy can be configured to allow only certain quality values and formats, and to
optionally allow the focal point to be specified in the URL.

If a preset is not found in the available presets, an error will be thrown.

Example

```
import { AssetServerPlugin, PresetOnlyStrategy } from '@vendure/core';// ...AssetServerPlugin.init({  //...  imageTransformStrategy: new PresetOnlyStrategy({    defaultPreset: 'thumbnail',    permittedQuality: [0, 50, 75, 85, 95],    permittedFormats: ['jpg', 'webp', 'avif'],    allowFocalPoint: true,  }),});
```

```
class PresetOnlyStrategy implements ImageTransformStrategy {    constructor(options: PresetOnlyStrategyOptions)    getImageTransformParameters({        input,        availablePresets,    }: GetImageTransformParametersArgs) => Promise<ImageTransformParameters> | ImageTransformParameters;}
```

- Implements: ImageTransformStrategy

[ImageTransformStrategy](/reference/core-plugins/asset-server-plugin/image-transform-strategy#imagetransformstrategy)
### constructor​


[​](#constructor)[PresetOnlyStrategyOptions](/reference/core-plugins/asset-server-plugin/preset-only-strategy#presetonlystrategyoptions)
### getImageTransformParameters​


[​](#getimagetransformparameters)[GetImageTransformParametersArgs](/reference/core-plugins/asset-server-plugin/image-transform-strategy#getimagetransformparametersargs)[ImageTransformParameters](/reference/core-plugins/asset-server-plugin/image-transform-strategy#imagetransformparameters)[ImageTransformParameters](/reference/core-plugins/asset-server-plugin/image-transform-strategy#imagetransformparameters)
## PresetOnlyStrategyOptions​


[​](#presetonlystrategyoptions)[@vendure/asset-server-plugin](https://www.npmjs.com/package/@vendure/asset-server-plugin)[preset-only-strategy.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/asset-server-plugin/src/config/preset-only-strategy.ts#L16)Configuration options for the PresetOnlyStrategy.

[PresetOnlyStrategy](/reference/core-plugins/asset-server-plugin/preset-only-strategy#presetonlystrategy)
```
interface PresetOnlyStrategyOptions {    defaultPreset: string;    permittedQuality?: number[];    permittedFormats?: ImageTransformFormat[];    allowFocalPoint?: boolean;}
```

### defaultPreset​


[​](#defaultpreset)The name of the default preset to use if no preset is specified in the URL.

### permittedQuality​


[​](#permittedquality)The permitted quality of the transformed images. If set to 'any', then any quality is permitted.
If set to an array of numbers (0-100), then only those quality values are permitted.

### permittedFormats​


[​](#permittedformats)The permitted formats of the transformed images. If set to 'any', then any format is permitted.
If set to an array of strings e.g. ['jpg', 'webp'], then only those formats are permitted.

### allowFocalPoint​


[​](#allowfocalpoint)Whether to allow the focal point to be specified in the URL.


---

# S3AssetStorageStrategy


## S3AssetStorageStrategy​


[​](#s3assetstoragestrategy)[@vendure/asset-server-plugin](https://www.npmjs.com/package/@vendure/asset-server-plugin)[s3-asset-storage-strategy.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/asset-server-plugin/src/config/s3-asset-storage-strategy.ts#L155)An AssetStorageStrategy which uses Amazon S3 object storage service.
To us this strategy you must first have access to an AWS account.
See their getting started guide for how to get set up.

[AssetStorageStrategy](/reference/typescript-api/assets/asset-storage-strategy#assetstoragestrategy)[Amazon S3](https://aws.amazon.com/s3/)[getting started guide](https://aws.amazon.com/s3/getting-started/)Before using this strategy, make sure you have the @aws-sdk/client-s3 and @aws-sdk/lib-storage package installed:

```
npm install @aws-sdk/client-s3 @aws-sdk/lib-storage
```

Note: Rather than instantiating this manually, use the configureS3AssetStorage function.

[configureS3AssetStorage](/reference/core-plugins/asset-server-plugin/s3asset-storage-strategy#configures3assetstorage)
## Use with S3-compatible services (MinIO)​


[​](#use-with-s3-compatible-services-minio)This strategy will also work with any S3-compatible object storage solutions, such as MinIO.
See the configureS3AssetStorage for an example with MinIO.

[MinIO](https://min.io/)[configureS3AssetStorage](/reference/core-plugins/asset-server-plugin/s3asset-storage-strategy#configures3assetstorage)
```
class S3AssetStorageStrategy implements AssetStorageStrategy {    constructor(s3Config: S3Config, toAbsoluteUrl: (request: Request, identifier: string) => string)    init() => ;    destroy?: (() => void | Promise<void>) | undefined;    writeFileFromBuffer(fileName: string, data: Buffer) => ;    writeFileFromStream(fileName: string, data: Readable) => ;    readFileToBuffer(identifier: string) => ;    readFileToStream(identifier: string) => ;    deleteFile(identifier: string) => ;    fileExists(fileName: string) => ;}
```

- Implements: AssetStorageStrategy

[AssetStorageStrategy](/reference/typescript-api/assets/asset-storage-strategy#assetstoragestrategy)
### constructor​


[​](#constructor)[S3Config](/reference/core-plugins/asset-server-plugin/s3asset-storage-strategy#s3config)
### init​


[​](#init)
### destroy​


[​](#destroy)
### writeFileFromBuffer​


[​](#writefilefrombuffer)
### writeFileFromStream​


[​](#writefilefromstream)
### readFileToBuffer​


[​](#readfiletobuffer)
### readFileToStream​


[​](#readfiletostream)
### deleteFile​


[​](#deletefile)
### fileExists​


[​](#fileexists)
## S3Config​


[​](#s3config)[@vendure/asset-server-plugin](https://www.npmjs.com/package/@vendure/asset-server-plugin)[s3-asset-storage-strategy.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/asset-server-plugin/src/config/s3-asset-storage-strategy.ts#L19)Configuration for connecting to AWS S3.

```
interface S3Config {    credentials: AwsCredentialIdentity | AwsCredentialIdentityProvider;    bucket: string;    nativeS3Configuration?: any;    nativeS3UploadConfiguration?: any;}
```

### credentials​


[​](#credentials)The credentials used to access your s3 account. You can supply either the access key ID & secret, or you can make use of a
shared credentials file
To use a shared credentials file, import the fromIni() function from the "@aws-sdk/credential-provider-ini" or "@aws-sdk/credential-providers" package and supply
the profile name (e.g. { profile: 'default' }) as its argument.

[shared credentials file](https://docs.aws.amazon.com/sdk-for-javascript/v2/developer-guide/loading-node-credentials-shared.html)
### bucket​


[​](#bucket)The S3 bucket in which to store the assets. If it does not exist, it will be created on startup.

### nativeS3Configuration​


[​](#natives3configuration)Configuration object passed directly to the AWS SDK.
S3.Types.ClientConfiguration can be used after importing aws-sdk.
Using type any in order to avoid the need to include aws-sdk dependency in general.

### nativeS3UploadConfiguration​


[​](#natives3uploadconfiguration)Configuration object passed directly to the AWS SDK.
ManagedUpload.ManagedUploadOptions can be used after importing aws-sdk.
Using type any in order to avoid the need to include aws-sdk dependency in general.

## configureS3AssetStorage​


[​](#configures3assetstorage)[@vendure/asset-server-plugin](https://www.npmjs.com/package/@vendure/asset-server-plugin)[s3-asset-storage-strategy.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/asset-server-plugin/src/config/s3-asset-storage-strategy.ts#L119)Returns a configured instance of the S3AssetStorageStrategy which can then be passed to the AssetServerOptionsstorageStrategyFactory property.

[S3AssetStorageStrategy](/reference/core-plugins/asset-server-plugin/s3asset-storage-strategy#s3assetstoragestrategy)[AssetServerOptions](/reference/core-plugins/asset-server-plugin/asset-server-options#assetserveroptions)Before using this strategy, make sure you have the @aws-sdk/client-s3 and @aws-sdk/lib-storage package installed:

```
npm install @aws-sdk/client-s3 @aws-sdk/lib-storage
```

Example

```
import { AssetServerPlugin, configureS3AssetStorage } from '@vendure/asset-server-plugin';import { DefaultAssetNamingStrategy } from '@vendure/core';import { fromEnv } from '@aws-sdk/credential-providers';// ...plugins: [  AssetServerPlugin.init({    route: 'assets',    assetUploadDir: path.join(__dirname, 'assets'),    namingStrategy: new DefaultAssetNamingStrategy(),    storageStrategyFactory: configureS3AssetStorage({      bucket: 'my-s3-bucket',      credentials: fromEnv(), // or any other credential provider      nativeS3Configuration: {        region: process.env.AWS_REGION,      },    }),}),
```

## Usage with MinIO​


[​](#usage-with-minio)Reference: How to use AWS SDK for Javascript with MinIO Server

[How to use AWS SDK for Javascript with MinIO Server](https://docs.min.io/docs/how-to-use-aws-sdk-for-javascript-with-minio-server.html)Example

```
import { AssetServerPlugin, configureS3AssetStorage } from '@vendure/asset-server-plugin';import { DefaultAssetNamingStrategy } from '@vendure/core';// ...plugins: [  AssetServerPlugin.init({    route: 'assets',    assetUploadDir: path.join(__dirname, 'assets'),    namingStrategy: new DefaultAssetNamingStrategy(),    storageStrategyFactory: configureS3AssetStorage({      bucket: 'my-minio-bucket',      credentials: {        accessKeyId: process.env.MINIO_ACCESS_KEY_ID,        secretAccessKey: process.env.MINIO_SECRET_ACCESS_KEY,      },      nativeS3Configuration: {        endpoint: process.env.MINIO_ENDPOINT ?? 'http://localhost:9000',        forcePathStyle: true,        signatureVersion: 'v4',        // The `region` is required by the AWS SDK even when using MinIO,        // so we just use a dummy value here.        region: 'eu-west-1',      },    }),}),
```

```
function configureS3AssetStorage(s3Config: S3Config): void
```

Parameters

### s3Config​


[​](#s3config-1)[S3Config](/reference/core-plugins/asset-server-plugin/s3asset-storage-strategy#s3config)


---

# SharpAssetPreviewStrategy


## SharpAssetPreviewStrategy​


[​](#sharpassetpreviewstrategy)[@vendure/asset-server-plugin](https://www.npmjs.com/package/@vendure/asset-server-plugin)[sharp-asset-preview-strategy.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/asset-server-plugin/src/config/sharp-asset-preview-strategy.ts#L95)This AssetPreviewStrategy uses the Sharp library to generate
preview images of uploaded binary files. For non-image binaries, a generic "file" icon with the mime type
overlay will be generated.

[AssetPreviewStrategy](/reference/typescript-api/assets/asset-preview-strategy#assetpreviewstrategy)[Sharp library](https://sharp.pixelplumbing.com/)By default, this strategy will produce previews up to maximum dimensions of 1600 x 1600 pixels. The created
preview images will match the input format - so a source file in jpeg format will output a jpeg preview,
a webp source file will output a webp preview, and so on.

The settings for the outputs will default to Sharp's defaults (https://sharp.pixelplumbing.com/api-output).
However, it is possible to pass your own configurations to control the output of each format:

[https://sharp.pixelplumbing.com/api-output](https://sharp.pixelplumbing.com/api-output)
```
AssetServerPlugin.init({  previewStrategy: new SharpAssetPreviewStrategy({    jpegOptions: { quality: 95 },    webpOptions: { quality: 95 },  }),}),
```

```
class SharpAssetPreviewStrategy implements AssetPreviewStrategy {    constructor(config?: SharpAssetPreviewConfig)    generatePreviewImage(ctx: RequestContext, mimeType: string, data: Buffer) => Promise<Buffer>;}
```

- Implements: AssetPreviewStrategy

[AssetPreviewStrategy](/reference/typescript-api/assets/asset-preview-strategy#assetpreviewstrategy)
### constructor​


[​](#constructor)[SharpAssetPreviewConfig](/reference/core-plugins/asset-server-plugin/sharp-asset-preview-strategy#sharpassetpreviewconfig)
### generatePreviewImage​


[​](#generatepreviewimage)[RequestContext](/reference/typescript-api/request/request-context#requestcontext)
## SharpAssetPreviewConfig​


[​](#sharpassetpreviewconfig)[@vendure/asset-server-plugin](https://www.npmjs.com/package/@vendure/asset-server-plugin)[sharp-asset-preview-strategy.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/asset-server-plugin/src/config/sharp-asset-preview-strategy.ts#L17)This AssetPreviewStrategy uses the Sharp library to generate
preview images of uploaded binary files. For non-image binaries, a generic "file" icon with the mime type
overlay will be generated.

[AssetPreviewStrategy](/reference/typescript-api/assets/asset-preview-strategy#assetpreviewstrategy)[Sharp library](https://sharp.pixelplumbing.com/)
```
interface SharpAssetPreviewConfig {    maxHeight?: number;    maxWidth?: number;    jpegOptions?: sharp.JpegOptions;    pngOptions?: sharp.PngOptions;    webpOptions?: sharp.WebpOptions;    gifOptions?: sharp.GifOptions;    avifOptions?: sharp.AvifOptions;}
```

### maxHeight​


[​](#maxheight)The max height in pixels of a generated preview image.

### maxWidth​


[​](#maxwidth)The max width in pixels of a generated preview image.

### jpegOptions​


[​](#jpegoptions)Set Sharp's options for encoding jpeg files: https://sharp.pixelplumbing.com/api-output#jpeg

[https://sharp.pixelplumbing.com/api-output#jpeg](https://sharp.pixelplumbing.com/api-output#jpeg)
### pngOptions​


[​](#pngoptions)Set Sharp's options for encoding png files: https://sharp.pixelplumbing.com/api-output#png

[https://sharp.pixelplumbing.com/api-output#png](https://sharp.pixelplumbing.com/api-output#png)
### webpOptions​


[​](#webpoptions)Set Sharp's options for encoding webp files: https://sharp.pixelplumbing.com/api-output#webp

[https://sharp.pixelplumbing.com/api-output#webp](https://sharp.pixelplumbing.com/api-output#webp)
### gifOptions​


[​](#gifoptions)Set Sharp's options for encoding gif files: https://sharp.pixelplumbing.com/api-output#gif

[https://sharp.pixelplumbing.com/api-output#gif](https://sharp.pixelplumbing.com/api-output#gif)
### avifOptions​


[​](#avifoptions)Set Sharp's options for encoding avif files: https://sharp.pixelplumbing.com/api-output#avif

[https://sharp.pixelplumbing.com/api-output#avif](https://sharp.pixelplumbing.com/api-output#avif)


---

# DashboardPlugin


## DashboardPlugin​


[​](#dashboardplugin)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[dashboard.plugin.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/plugin/dashboard.plugin.ts#L119)This plugin serves the static files of the Vendure Dashboard and provides the
GraphQL extensions needed for the order metrics on the dashboard index page.

## Installation​


[​](#installation)npm install @vendure/dashboard

## Usage​


[​](#usage)First you need to set up compilation of the Dashboard, using the Vite configuration
described in the Dashboard Getting Started Guide

[Dashboard Getting Started Guide](/guides/extending-the-dashboard/getting-started/)
## Development vs Production​


[​](#development-vs-production)When developing, you can run npx vite (or npm run dev) to start the Vite development server.
The plugin will automatically detect if Vite is running on the default port (5173) and proxy
requests to it instead of serving static files. This enables hot module replacement and faster
development iterations.

For production, run npx vite build to build the dashboard app. The built app files will be
output to the location specified by build.outDir in your Vite config file. This should then
be passed to the appDir init option, as in the example below:

Example

```
import { DashboardPlugin } from '@vendure/dashboard/plugin';const config: VendureConfig = {  // Add an instance of the plugin to the plugins array  plugins: [    DashboardPlugin.init({      route: 'dashboard',      appDir: './dist/dashboard',      // Optional: customize Vite dev server port (defaults to 5173)      viteDevServerPort: 3000,    }),  ],};
```

## Metrics​


[​](#metrics)This plugin defines a metricSummary query which is used by the Dashboard UI to
display the order metrics on the dashboard.

If you are building a stand-alone version of the Dashboard UI app, and therefore
don't need this plugin to serve the Dashboard UI, you can still use the
metricSummary query by adding the DashboardPlugin to the plugins array,
but without calling the init() method:

Example

```
import { DashboardPlugin } from '@vendure/dashboard-plugin';const config: VendureConfig = {  plugins: [    DashboardPlugin, // <-- no call to .init()  ],  // ...};
```

```
class DashboardPlugin implements NestModule {    constructor(processContext: ProcessContext)    init(options: DashboardPluginOptions) => Type<DashboardPlugin>;    configure(consumer: MiddlewareConsumer) => ;}
```

- Implements: NestModule

### constructor​


[​](#constructor)[ProcessContext](/reference/typescript-api/common/process-context#processcontext)
### init​


[​](#init)[DashboardPluginOptions](/reference/core-plugins/dashboard-plugin/dashboard-plugin-options#dashboardpluginoptions)[DashboardPlugin](/reference/core-plugins/dashboard-plugin/#dashboardplugin)Set the plugin options

### configure​


[​](#configure)


---

# DashboardPluginOptions


## DashboardPluginOptions​


[​](#dashboardpluginoptions)[@vendure/dashboard](https://www.npmjs.com/package/@vendure/dashboard)[dashboard.plugin.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/dashboard/plugin/dashboard.plugin.ts#L29)Configuration options for the DashboardPlugin.

[DashboardPlugin](/reference/core-plugins/dashboard-plugin/#dashboardplugin)
```
interface DashboardPluginOptions {    route: string;    appDir: string;    viteDevServerPort?: number;}
```

### route​


[​](#route)The route to the Dashboard UI.

### appDir​


[​](#appdir)The path to the dashboard UI app dist directory.

### viteDevServerPort​


[​](#vitedevserverport)The port on which to check for a running Vite dev server.
If a Vite dev server is detected on this port, requests will be proxied to it
instead of serving static files from appDir.


---

# ElasticsearchOptions


## ElasticsearchOptions​


[​](#elasticsearchoptions)[@vendure/elasticsearch-plugin](https://www.npmjs.com/package/@vendure/elasticsearch-plugin)[options.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/elasticsearch-plugin/src/options.ts#L30)Configuration options for the ElasticsearchPlugin.

[ElasticsearchPlugin](/reference/core-plugins/elasticsearch-plugin/#elasticsearchplugin)
```
interface ElasticsearchOptions {    host?: string;    port?: number;    connectionAttempts?: number;    connectionAttemptInterval?: number;    clientOptions?: ClientOptions;    indexPrefix?: string;    indexSettings?: object;    indexMappingProperties?: {        [indexName: string]: object;    };    reindexProductsChunkSize?: number;    reindexBulkOperationSizeLimit?: number;    searchConfig?: SearchConfig;    customProductMappings?: {        [fieldName: string]: CustomMapping<            [Product, ProductVariant[], LanguageCode, Injector, RequestContext]        >;    };    customProductVariantMappings?: {        [fieldName: string]: CustomMapping<[ProductVariant, LanguageCode, Injector, RequestContext]>;    };    bufferUpdates?: boolean;    hydrateProductRelations?: Array<EntityRelationPaths<Product>>;    hydrateProductVariantRelations?: Array<EntityRelationPaths<ProductVariant>>;    extendSearchInputType?: {        [name: string]: PrimitiveTypeVariations<GraphQlPrimitive>;    };    extendSearchSortType?: string[];}
```

### host​


[​](#host)The host of the Elasticsearch server. May also be specified in clientOptions.node.

### port​


[​](#port)The port of the Elasticsearch server. May also be specified in clientOptions.node.

### connectionAttempts​


[​](#connectionattempts)Maximum amount of attempts made to connect to the ElasticSearch server on startup.

### connectionAttemptInterval​


[​](#connectionattemptinterval)Interval in milliseconds between attempts to connect to the ElasticSearch server on startup.

### clientOptions​


[​](#clientoptions)Options to pass directly to the
Elasticsearch Node.js client. For example, to
set authentication or other more advanced options.
Note that if the node or nodes option is specified, it will override the values provided in the host and port options.

[Elasticsearch Node.js client](https://www.elastic.co/guide/en/elasticsearch/client/javascript-api/current/index.html)
### indexPrefix​


[​](#indexprefix)Prefix for the indices created by the plugin.

### indexSettings​


[​](#indexsettings)These options
are directly passed to index settings. To apply some settings indices will be recreated.

[These options](https://www.elastic.co/guide/en/elasticsearch/reference/7.x/index-modules.html#index-modules-settings)Example

```
// Configuring an English stemmerindexSettings: {  analysis: {    analyzer: {      custom_analyzer: {        tokenizer: 'standard',        filter: [          'lowercase',          'english_stemmer'        ]      }    },    filter : {      english_stemmer : {        type : 'stemmer',        name : 'english'      }    }  }},
```

A more complete example can be found in the discussion thread
How to make elastic plugin to search by substring with stemming.

[How to make elastic plugin to search by substring with stemming](https://github.com/vendure-ecommerce/vendure/discussions/1066)
### indexMappingProperties​


[​](#indexmappingproperties)This option allow to redefine or define new properties in mapping. More about elastic
mapping
After changing this option indices will be recreated.

[mapping](https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping.html)Example

```
// Configuring custom analyzer for the `productName` field.indexMappingProperties: {  productName: {    type: 'text',    analyzer:'custom_analyzer',    fields: {      keyword: {        type: 'keyword',        ignore_above: 256,      }    }  }}
```

To reference a field defined by customProductMappings or customProductVariantMappings, you will
need to prefix the name with 'product-<name>' or 'variant-<name>' respectively, e.g.:

Example

```
customProductMappings: {   variantCount: {       graphQlType: 'Int!',       valueFn: (product, variants) => variants.length,   },},indexMappingProperties: {  'product-variantCount': {    type: 'integer',  }}
```

### reindexProductsChunkSize​


[​](#reindexproductschunksize)Products limit chunk size for each loop iteration when indexing products.

### reindexBulkOperationSizeLimit​


[​](#reindexbulkoperationsizelimit)Index operations are performed in bulk, with each bulk operation containing a number of individual
index operations. This option sets the maximum number of operations in the memory buffer before a
bulk operation is executed.

### searchConfig​


[​](#searchconfig)[SearchConfig](/reference/core-plugins/elasticsearch-plugin/elasticsearch-options#searchconfig)Configuration of the internal Elasticsearch query.

### customProductMappings​


[​](#customproductmappings)[Product](/reference/typescript-api/entities/product#product)[ProductVariant](/reference/typescript-api/entities/product-variant#productvariant)[LanguageCode](/reference/typescript-api/common/language-code#languagecode)[Injector](/reference/typescript-api/common/injector#injector)[RequestContext](/reference/typescript-api/request/request-context#requestcontext)Custom mappings may be defined which will add the defined data to the
Elasticsearch index and expose that data via the SearchResult GraphQL type,
adding a new customMappings, customProductMappings & customProductVariantMappings fields.

The graphQlType property may be one of String, Int, Float, Boolean, ID or list
versions thereof ([String!] etc) and can be appended with a ! to indicate non-nullable fields.

The public (default = true) property is used to reveal or hide the property in the GraphQL API schema.
If this property is set to false it's not accessible in the customMappings field but it's still getting
parsed to the elasticsearch index.

This config option defines custom mappings which are accessible when the "groupByProduct" or "groupBySKU"
input options is set to true (Do not set both to true at the same time). In addition, custom variant mappings can be accessed by using
the customProductVariantMappings field, which is always available.

Example

```
customProductMappings: {   variantCount: {       graphQlType: 'Int!',       valueFn: (product, variants) => variants.length,   },   reviewRating: {       graphQlType: 'Float',       public: true,       valueFn: product => (product.customFields as any).reviewRating,   },   priority: {       graphQlType: 'Int!',       public: false,       valueFn: product => (product.customFields as any).priority,   },}
```

Example

```
query SearchProducts($input: SearchInput!) {    search(input: $input) {        totalItems        items {            productId            productName            customProductMappings {                variantCount                reviewRating            }            customMappings {                ...on CustomProductMappings {                    variantCount                    reviewRating                }            }        }    }}
```

### customProductVariantMappings​


[​](#customproductvariantmappings)[ProductVariant](/reference/typescript-api/entities/product-variant#productvariant)[LanguageCode](/reference/typescript-api/common/language-code#languagecode)[Injector](/reference/typescript-api/common/injector#injector)[RequestContext](/reference/typescript-api/request/request-context#requestcontext)This config option defines custom mappings which are accessible when the "groupByProduct" and "groupBySKU"
input options are both set to false. In addition, custom product mappings can be accessed by using
the customProductMappings field, which is always available.

Example

```
query SearchProducts($input: SearchInput!) {    search(input: $input) {        totalItems        items {            productId            productName            customProductVariantMappings {                weight            }            customMappings {                ...on CustomProductVariantMappings {                    weight                }            }        }    }}
```

### bufferUpdates​


[​](#bufferupdates)If set to true, updates to Products, ProductVariants and Collections will not immediately
trigger an update to the search index. Instead, all these changes will be buffered and will
only be run via a call to the runPendingSearchIndexUpdates mutation in the Admin API.

This is very useful for installations with a large number of ProductVariants and/or
Collections, as the buffering allows better control over when these expensive jobs are run,
and also performs optimizations to minimize the amount of work that needs to be performed by
the worker.

### hydrateProductRelations​


[​](#hydrateproductrelations)[EntityRelationPaths](/reference/typescript-api/common/entity-relation-paths#entityrelationpaths)[Product](/reference/typescript-api/entities/product#product)Additional product relations that will be fetched from DB while reindexing. This can be used
in combination with customProductMappings to ensure that the required relations are joined
before the product object is passed to the valueFn.

Example

```
{  hydrateProductRelations: ['assets.asset'],  customProductMappings: {    assetPreviews: {      graphQlType: '[String!]',      // Here we can be sure that the `product.assets` array is populated      // with an Asset object      valueFn: (product) => product.assets.map(a => a.asset.preview),    }  }}
```

### hydrateProductVariantRelations​


[​](#hydrateproductvariantrelations)[EntityRelationPaths](/reference/typescript-api/common/entity-relation-paths#entityrelationpaths)[ProductVariant](/reference/typescript-api/entities/product-variant#productvariant)Additional variant relations that will be fetched from DB while reindexing. See
hydrateProductRelations for more explanation and a usage example.

### extendSearchInputType​


[​](#extendsearchinputtype)Allows the SearchInput type to be extended with new input fields. This allows arbitrary
data to be passed in, which can then be used e.g. in the mapQuery() function or
custom scriptFields functions.

Example

```
extendSearchInputType: {  longitude: 'Float',  latitude: 'Float',  radius: 'Float',}
```

This allows the search query to include these new fields:

Example

```
query {  search(input: {    longitude: 101.7117,    latitude: 3.1584,    radius: 50.00  }) {    items {      productName    }  }}
```

### extendSearchSortType​


[​](#extendsearchsorttype)Adds a list of sort parameters. This is mostly important to make the
correct sort order values available inside input parameter of the mapSort option.

Example

```
extendSearchSortType: ["distance"]
```

will extend the SearchResultSortParameter input type like this:

Example

```
extend input SearchResultSortParameter {     distance: SortOrder}
```

## SearchConfig​


[​](#searchconfig-1)[@vendure/elasticsearch-plugin](https://www.npmjs.com/package/@vendure/elasticsearch-plugin)[options.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/elasticsearch-plugin/src/options.ts#L397)Configuration options for the internal Elasticsearch query which is generated when performing a search.

```
interface SearchConfig {    facetValueMaxSize?: number;    collectionMaxSize?: number;    totalItemsMaxSize?: number | boolean;    multiMatchType?: 'best_fields' | 'most_fields' | 'cross_fields' | 'phrase' | 'phrase_prefix' | 'bool_prefix';    boostFields?: BoostFieldsConfig;    priceRangeBucketInterval?: number;    mapQuery?: (        query: any,        input: ElasticSearchInput,        searchConfig: DeepRequired<SearchConfig>,        channelId: ID,        enabledOnly: boolean,        ctx: RequestContext,    ) => any;    scriptFields?: { [fieldName: string]: CustomScriptMapping<[ElasticSearchInput]> };    mapSort?: (sort: ElasticSearchSortInput, input: ElasticSearchInput) => ElasticSearchSortInput;}
```

### facetValueMaxSize​


[​](#facetvaluemaxsize)The maximum number of FacetValues to return from the search query. Internally, this
value sets the "size" property of an Elasticsearch aggregation.

### collectionMaxSize​


[​](#collectionmaxsize)The maximum number of Collections to return from the search query. Internally, this
value sets the "size" property of an Elasticsearch aggregation.

### totalItemsMaxSize​


[​](#totalitemsmaxsize)The maximum number of totalItems to return from the search query. Internally, this
value sets the "track_total_hits" property of an Elasticsearch query.
If this parameter is set to "True", accurate count of totalItems will be returned.
If this parameter is set to "False", totalItems will be returned as 0.
If this parameter is set to integer, accurate count of totalItems will be returned not bigger than integer.

### multiMatchType​


[​](#multimatchtype)Defines the
multi match type
used when matching against a search term.

[multi match type](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-multi-match-query.html#multi-match-types)
### boostFields​


[​](#boostfields)[BoostFieldsConfig](/reference/core-plugins/elasticsearch-plugin/elasticsearch-options#boostfieldsconfig)Set custom boost values for particular fields when matching against a search term.

### priceRangeBucketInterval​


[​](#pricerangebucketinterval)The interval used to group search results into buckets according to price range. For example, setting this to
2000 will group into buckets every $20.00:

```
{  "data": {    "search": {      "totalItems": 32,      "priceRange": {        "buckets": [          {            "to": 2000,            "count": 21          },          {            "to": 4000,            "count": 7          },          {            "to": 6000,            "count": 3          },          {            "to": 12000,            "count": 1          }        ]      }    }  }}
```

### mapQuery​


[​](#mapquery)[SearchConfig](/reference/core-plugins/elasticsearch-plugin/elasticsearch-options#searchconfig)[ID](/reference/typescript-api/common/id#id)[RequestContext](/reference/typescript-api/request/request-context#requestcontext)This config option allows the the modification of the whole (already built) search query. This allows
for e.g. wildcard / fuzzy searches on the index.

Example

```
mapQuery: (query, input, searchConfig, channelId, enabledOnly, ctx) => {  if (query.bool.must) {    delete query.bool.must;  }  query.bool.should = [    {      query_string: {        query: "*" + term + "*",        fields: [          `productName^${searchConfig.boostFields.productName}`,          `productVariantName^${searchConfig.boostFields.productVariantName}`,        ]      }    },    {      multi_match: {        query: term,        type: searchConfig.multiMatchType,        fields: [          `description^${searchConfig.boostFields.description}`,          `sku^${searchConfig.boostFields.sku}`,        ],      },    },  ];  return query;}
```

### scriptFields​


[​](#scriptfields)Sets script_fields inside the elasticsearch body which allows returning a script evaluation for each hit.

The script field definition consists of three properties:

- graphQlType: This is the type that will be returned when this script field is queried
via the GraphQL API. It may be one of String, Int, Float, Boolean, ID or list
versions thereof ([String!] etc) and can be appended with a ! to indicate non-nullable fields.
- context: determines whether this script field is available when grouping by product. Can be
product, variant or both.
- scriptFn: This is the function to run on each hit. Should return an object with a script property,
as covered in the
Elasticsearch script fields docs

[Elasticsearch script fields docs](https://www.elastic.co/guide/en/elasticsearch/reference/7.15/search-fields.html#script-fields)Example

```
extendSearchInputType: {  latitude: 'Float',  longitude: 'Float',},indexMappingProperties: {  // The `product-location` field corresponds to the `location` customProductMapping  // defined below. Here we specify that it would be index as a `geo_point` type,  // which will allow us to perform geo-spacial calculations on it in our script field.  'product-location': {    type: 'geo_point', // contains function arcDistance  },},customProductMappings: {  location: {    graphQlType: 'String',    valueFn: (product: Product) => {      // Assume that the Product entity has this customField defined      const custom = product.customFields.location;      return `${custom.latitude},${custom.longitude}`;    },  }},searchConfig: {  scriptFields: {    distance: {      graphQlType: 'Float!',      // Run this script only when grouping results by product      context: 'product',      scriptFn: (input) => {        // The SearchInput was extended with latitude and longitude        // via the `extendSearchInputType` option above.        const lat = input.latitude;        const lon = input.longitude;        return {          script: `doc['product-location'].arcDistance(${lat}, ${lon})`,        }      }    }  }}
```

### mapSort​


[​](#mapsort)Allows extending the sort input of the elasticsearch body as covered in
Elasticsearch sort docs

[Elasticsearch sort docs](https://www.elastic.co/guide/en/elasticsearch/reference/current/sort-search-results.html)The sort input parameter contains the ElasticSearchSortInput generated for the default sort parameters "name" and "price".
If neither of those are applied it will be empty.

Example

```
mapSort: (sort, input) => {    // Assuming `extendSearchSortType: ["priority"]`    // Assuming priority is never undefined    const { priority } = input.sort;    return [         ...sort,         {             // The `product-priority` field corresponds to the `priority` customProductMapping             // Depending on the index type, this field might require a             // more detailed input (example: 'productName.keyword')             ["product-priority"]: {                 order: priority === SortOrder.ASC ? 'asc' : 'desc'             }         }     ];}
```

A more generic example would be a sort function based on a product location like this:

Example

```
extendSearchInputType: {  latitude: 'Float',  longitude: 'Float',},extendSearchSortType: ["distance"],indexMappingProperties: {  // The `product-location` field corresponds to the `location` customProductMapping  // defined below. Here we specify that it would be index as a `geo_point` type,  // which will allow us to perform geo-spacial calculations on it in our script field.  'product-location': {    type: 'geo_point',  },},customProductMappings: {  location: {    graphQlType: 'String',    valueFn: (product: Product) => {      // Assume that the Product entity has this customField defined      const custom = product.customFields.location;      return `${custom.latitude},${custom.longitude}`;    },  }},searchConfig: {     mapSort: (sort, input) => {         // Assuming distance is never undefined         const { distance } = input.sort;         return [             ...sort,             {                 ["_geo_distance"]: {                     "product-location": [                         input.longitude,                         input.latitude                     ],                     order: distance === SortOrder.ASC ? 'asc' : 'desc',                     unit: "km"                 }             }         ];     }}
```

## BoostFieldsConfig​


[​](#boostfieldsconfig)[@vendure/elasticsearch-plugin](https://www.npmjs.com/package/@vendure/elasticsearch-plugin)[options.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/elasticsearch-plugin/src/options.ts#L683)Configuration for boosting
the scores of given fields when performing a search against a term.

[boosting](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-multi-match-query.html#field-boost)Boosting a field acts as a score multiplier for matches against that field.

```
interface BoostFieldsConfig {    productName?: number;    productVariantName?: number;    description?: number;    sku?: number;}
```

### productName​


[​](#productname)Defines the boost factor for the productName field.

### productVariantName​


[​](#productvariantname)Defines the boost factor for the productVariantName field.

### description​


[​](#description)Defines the boost factor for the description field.

### sku​


[​](#sku)Defines the boost factor for the sku field.


---

# ElasticsearchPlugin


## ElasticsearchPlugin​


[​](#elasticsearchplugin)[@vendure/elasticsearch-plugin](https://www.npmjs.com/package/@vendure/elasticsearch-plugin)[plugin.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/elasticsearch-plugin/src/plugin.ts#L225)This plugin allows your product search to be powered by Elasticsearch - a powerful Open Source search
engine. This is a drop-in replacement for the DefaultSearchPlugin which exposes many powerful configuration options enabling your storefront
to support a wide range of use-cases such as indexing of custom properties, fine control over search index configuration, and to leverage
advanced Elasticsearch features like spacial search.

[Elasticsearch](https://github.com/elastic/elasticsearch)
## Installation​


[​](#installation)**Requires Elasticsearch v7.0 < required Elasticsearch version < 7.10 **
Elasticsearch version 7.10.2 will throw error due to incompatibility with elasticsearch-js client.
Check here for more info.

[Check here for more info](https://github.com/elastic/elasticsearch-js/issues/1519)yarn add @elastic/elasticsearch @vendure/elasticsearch-plugin

or

npm install @elastic/elasticsearch @vendure/elasticsearch-plugin

Make sure to remove the DefaultSearchPlugin if it is still in the VendureConfig plugins array.

Then add the ElasticsearchPlugin, calling the .init() method with ElasticsearchOptions:

[ElasticsearchOptions](/reference/core-plugins/elasticsearch-plugin/elasticsearch-options#elasticsearchoptions)Example

```
import { ElasticsearchPlugin } from '@vendure/elasticsearch-plugin';const config: VendureConfig = {  // Add an instance of the plugin to the plugins array  plugins: [    ElasticsearchPlugin.init({      host: 'http://localhost',      port: 9200,    }),  ],};
```

## Search API Extensions​


[​](#search-api-extensions)This plugin extends the default search query of the Shop API, allowing richer querying of your product data.

The SearchResponse type is extended with information
about price ranges in the result set:

[SearchResponse](/reference/graphql-api/shop/object-types/#searchresponse)
```
extend type SearchResponse {    prices: SearchResponsePriceData!}type SearchResponsePriceData {    range: PriceRange!    rangeWithTax: PriceRange!    buckets: [PriceRangeBucket!]!    bucketsWithTax: [PriceRangeBucket!]!}type PriceRangeBucket {    to: Int!    count: Int!}extend input SearchInput {    priceRange: PriceRangeInput    priceRangeWithTax: PriceRangeInput    inStock: Boolean}input PriceRangeInput {    min: Int!    max: Int!}
```

This SearchResponsePriceData type allows you to query data about the range of prices in the result set.

## Example Request & Response​


[​](#example-request--response)
```
{  search (input: {    term: "table easel"    groupByProduct: true    priceRange: {      min: 500      max: 7000    }  }) {    totalItems    prices {      range {        min        max      }      buckets {        to        count      }    }    items {      productName      score      price {        ...on PriceRange {          min          max        }      }    }  }}
```

```
{ "data": {   "search": {     "totalItems": 9,     "prices": {       "range": {         "min": 999,         "max": 6396,       },       "buckets": [         {           "to": 1000,           "count": 1         },         {           "to": 2000,           "count": 2         },         {           "to": 3000,           "count": 3         },         {           "to": 4000,           "count": 1         },         {           "to": 5000,           "count": 1         },         {           "to": 7000,           "count": 1         }       ]     },     "items": [       {         "productName": "Loxley Yorkshire Table Easel",         "score": 30.58831,         "price": {           "min": 4984,           "max": 4984         }       },       // ... truncated     ]   } }}
```

```
class ElasticsearchPlugin implements OnApplicationBootstrap {    init(options: ElasticsearchOptions) => Type<ElasticsearchPlugin>;}
```

- Implements: OnApplicationBootstrap

### init​


[​](#init)[ElasticsearchOptions](/reference/core-plugins/elasticsearch-plugin/elasticsearch-options#elasticsearchoptions)[ElasticsearchPlugin](/reference/core-plugins/elasticsearch-plugin/#elasticsearchplugin)


---

# EmailPlugin


## EmailPlugin​


[​](#emailplugin)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[plugin.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/plugin.ts#L304)The EmailPlugin creates and sends transactional emails based on Vendure events. By default, it uses an MJML-based
email generator to generate the email body and Nodemailer to send the emails.

[MJML](https://mjml.io/)[Nodemailer](https://nodemailer.com/about/)
## High-level description​


[​](#high-level-description)Vendure has an internal events system (see EventBus) that allows plugins to subscribe to events. The EmailPlugin is configured with EmailEventHandlers
that listen for a specific event and when it is published, the handler defines which template to use to generate the resulting email.

[EventBus](/reference/typescript-api/events/event-bus#eventbus)[EmailEventHandler](/reference/core-plugins/email-plugin/email-event-handler#emaileventhandler)The plugin comes with a set of default handler for the following events:

- Order confirmation
- New customer email address verification
- Password reset request
- Email address change request

You can also create your own handler and register them with the plugin - see the EmailEventHandler docs for more details.

[EmailEventHandler](/reference/core-plugins/email-plugin/email-event-handler#emaileventhandler)
## Installation​


[​](#installation)yarn add @vendure/email-plugin

or

npm install @vendure/email-plugin

Example

```
import { defaultEmailHandlers, EmailPlugin, FileBasedTemplateLoader } from '@vendure/email-plugin';const config: VendureConfig = {  // Add an instance of the plugin to the plugins array  plugins: [    EmailPlugin.init({      handler: defaultEmailHandlers,      templateLoader: new FileBasedTemplateLoader(path.join(__dirname, '../static/email/templates')),      transport: {        type: 'smtp',        host: 'smtp.example.com',        port: 587,        auth: {          user: 'username',          pass: 'password',        }      },    }),  ],};
```

## Email templates​


[​](#email-templates)In the example above, the plugin has been configured to look in <app-root>/static/email/templates
for the email template files. If you used @vendure/create to create your application, the templates will have
been copied to that location during setup.

If you are installing the EmailPlugin separately, then you'll need to copy the templates manually from
node_modules/@vendure/email-plugin/templates to a location of your choice, and then point the templatePath config
property at that directory.

- Dynamic Email Templates​

### Dynamic Email Templates​


[​](#dynamic-email-templates)Instead of passing a static value to templatePath, use templateLoader to define a template path.

```
  EmailPlugin.init({   ...,   templateLoader: new FileBasedTemplateLoader(my/order-confirmation/templates)  })
```

## Customizing templates​


[​](#customizing-templates)Emails are generated from templates which use MJML syntax. MJML is an open-source HTML-like markup
language which makes the task of creating responsive email markup simple. By default, the templates are installed to
<project root>/vendure/email/templates and can be freely edited.

[MJML](https://mjml.io/)Dynamic data such as the recipient's name or order items are specified using Handlebars syntax:

[Handlebars syntax](https://handlebarsjs.com/)
```
<p>Dear {{ order.customer.firstName }} {{ order.customer.lastName }},</p><p>Thank you for your order!</p><mj-table cellpadding="6px">  {{#each order.lines }}    <tr class="order-row">      <td>{{ quantity }} x {{ productVariant.name }}</td>      <td>{{ productVariant.quantity }}</td>      <td>{{ formatMoney totalPrice }}</td>    </tr>  {{/each}}</mj-table>
```

### Setting global variables using globalTemplateVars​


[​](#setting-global-variables-using-globaltemplatevars)globalTemplateVars is an object that can be passed to the configuration of the Email Plugin with static object variables.
You can also pass an async function that will be called with the RequestContext and the Injector so you can access services
and e.g. load channel specific theme configurations.

Example

```
EmailPlugin.init({   globalTemplateVars: {     primaryColor: '#FF0000',     fromAddress: 'no-reply@ourstore.com'   }})
```

or

```
EmailPlugin.init({   globalTemplateVars: async (ctx, injector) => {     const myAsyncService = injector.get(MyAsyncService);     const asyncValue = await myAsyncService.get(ctx);     const channel = ctx.channel;     const { primaryColor } = channel.customFields.theme;     const theme = {        primaryColor,        asyncValue,     };     return theme;   }})
```

### Handlebars helpers​


[​](#handlebars-helpers)The following helper functions are available for use in email templates:

- formatMoney: Formats an amount of money (which are always stored as integers in Vendure) as a decimal, e.g. 123 => 1.23
- formatDate: Formats a Date value with the dateformat package.

[dateformat](https://www.npmjs.com/package/dateformat)
## Extending the default email handler​


[​](#extending-the-default-email-handler)The defaultEmailHandlers array defines the default handler such as for handling new account registration, order confirmation, password reset
etc. These defaults can be extended by adding custom templates for languages other than the default, or even completely new types of emails
which respond to any of the available VendureEvents.

[VendureEvents](/reference/typescript-api/events/)A good way to learn how to create your own email handler is to take a look at the
source code of the default handler.
New handler are defined in exactly the same way.

[source code of the default handler](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/handler/default-email-handlers.ts)It is also possible to modify the default handler:

```
// Rather than importing `defaultEmailHandlers`, you can// import the handler individuallyimport {  orderConfirmationHandler,  emailVerificationHandler,  passwordResetHandler,  emailAddressChangeHandler,} from '@vendure/email-plugin';import { CustomerService } from '@vendure/core';// This allows you to then customize each handler to your needs.// For example, let's set a new subject line to the order confirmation:const myOrderConfirmationHandler = orderConfirmationHandler  .setSubject(`We received your order!`);// Another example: loading additional data and setting new// template variables.const myPasswordResetHandler = passwordResetHandler  .loadData(async ({ event, injector }) => {    const customerService = injector.get(CustomerService);    const customer = await customerService.findOneByUserId(event.ctx, event.user.id);    return { customer };  })  .setTemplateVars(event => ({    passwordResetToken: event.user.getNativeAuthenticationMethod().passwordResetToken,    customer: event.data.customer,  }));// Then you pass the handler to the EmailPlugin init method// individuallyEmailPlugin.init({  handler: [    myOrderConfirmationHandler,    myPasswordResetHandler,    emailVerificationHandler,    emailAddressChangeHandler,  ],  // ...}),
```

For all available methods of extending a handler, see the EmailEventHandler documentation.

[EmailEventHandler](/reference/core-plugins/email-plugin/email-event-handler#emaileventhandler)
## Dynamic SMTP settings​


[​](#dynamic-smtp-settings)Instead of defining static transport settings, you can also provide a function that dynamically resolves
channel aware transport settings.

Example

```
import { defaultEmailHandlers, EmailPlugin, FileBasedTemplateLoader } from '@vendure/email-plugin';import { MyTransportService } from './transport.services.ts';const config: VendureConfig = {  plugins: [    EmailPlugin.init({      handler: defaultEmailHandlers,      templateLoader: new FileBasedTemplateLoader(path.join(__dirname, '../static/email/templates')),      transport: (injector, ctx) => {        if (ctx) {          return injector.get(MyTransportService).getSettings(ctx);        } else {          return {            type: 'smtp',            host: 'smtp.example.com',            // ... etc.          }        }      }    }),  ],};
```

## Dev mode​


[​](#dev-mode)For development, the transport option can be replaced by devMode: true. Doing so configures Vendure to use the
file transport (See FileTransportOptions) and outputs emails as rendered HTML files in the directory specified by the
outputPath property.

[FileTransportOptions](/reference/core-plugins/email-plugin/transport-options#filetransportoptions)
```
EmailPlugin.init({  devMode: true,  route: 'mailbox',  handler: defaultEmailHandlers,  templateLoader: new FileBasedTemplateLoader(path.join(__dirname, '../static/email/templates')),  outputPath: path.join(__dirname, 'test-emails'),})
```

### Dev mailbox​


[​](#dev-mailbox)In dev mode, a webmail-like interface available at the /mailbox path, e.g.
http://localhost:3000/mailbox. This is a simple way to view the output of all emails generated by the EmailPlugin while in dev mode.

[http://localhost:3000/mailbox](http://localhost:3000/mailbox)
## Troubleshooting SMTP Connections​


[​](#troubleshooting-smtp-connections)If you are having trouble sending email over and SMTP connection, set the logging and debug options to true. This will
send detailed information from the SMTP transporter to the configured logger (defaults to console). For maximum detail combine
this with a detail log level in the configured VendureLogger:

```
const config: VendureConfig = {  logger: new DefaultLogger({ level: LogLevel.Debug })  // ...  plugins: [    EmailPlugin.init({      // ...      transport: {        type: 'smtp',        host: 'smtp.example.com',        port: 587,        auth: {          user: 'username',          pass: 'password',        },        logging: true,        debug: true,      },    }),  ],};
```

```
class EmailPlugin implements OnApplicationBootstrap, OnApplicationShutdown, NestModule {    init(options: EmailPluginOptions | EmailPluginDevModeOptions) => Type<EmailPlugin>;    onApplicationShutdown() => ;    configure(consumer: MiddlewareConsumer) => ;}
```

- Implements: OnApplicationBootstrap, OnApplicationShutdown, NestModule

### init​


[​](#init)[EmailPluginOptions](/reference/core-plugins/email-plugin/email-plugin-options#emailpluginoptions)[EmailPluginDevModeOptions](/reference/core-plugins/email-plugin/email-plugin-options#emailplugindevmodeoptions)[EmailPlugin](/reference/core-plugins/email-plugin/#emailplugin)
### onApplicationShutdown​


[​](#onapplicationshutdown)
### configure​


[​](#configure)


---

# EmailEventHandlerWithAsyncData


## EmailEventHandlerWithAsyncData​


[​](#emaileventhandlerwithasyncdata)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[event-handler.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/handler/event-handler.ts#L506)Identical to the EmailEventHandler but with a data property added to the event based on the result
of the .loadData() function.

[EmailEventHandler](/reference/core-plugins/email-plugin/email-event-handler#emaileventhandler)
```
class EmailEventHandlerWithAsyncData<Data, T extends string = string, InputEvent extends EventWithContext = EventWithContext, Event extends EventWithAsyncData<InputEvent, Data> = EventWithAsyncData<InputEvent, Data>> extends EmailEventHandler<T, Event> {    constructor(_loadDataFn: LoadDataFn<InputEvent, Data>, listener: EmailEventListener<T>, event: Type<InputEvent>)}
```

- Extends: EmailEventHandler<T, Event>

[EmailEventHandler](/reference/core-plugins/email-plugin/email-event-handler#emaileventhandler)
### constructor​


[​](#constructor)[LoadDataFn](/reference/core-plugins/email-plugin/email-plugin-types#loaddatafn)[EmailEventListener](/reference/core-plugins/email-plugin/email-event-listener#emaileventlistener)


---

# EmailEventHandler


## EmailEventHandler​


[​](#emaileventhandler)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[event-handler.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/handler/event-handler.ts#L150)The EmailEventHandler defines how the EmailPlugin will respond to a given event.

A handler is created by creating a new EmailEventListener and calling the .on() method
to specify which event to respond to.

[EmailEventListener](/reference/core-plugins/email-plugin/email-event-listener#emaileventlistener)Example

```
const confirmationHandler = new EmailEventListener('order-confirmation')  .on(OrderStateTransitionEvent)  .filter(event => event.toState === 'PaymentSettled')  .setRecipient(event => event.order.customer.emailAddress)  .setFrom('{{ fromAddress }}')  .setSubject(`Order confirmation for #{{ order.code }}`)  .setTemplateVars(event => ({ order: event.order }));
```

This example creates a handler which listens for the OrderStateTransitionEvent and if the Order has
transitioned to the 'PaymentSettled' state, it will generate and send an email.

The string argument passed into the EmailEventListener constructor is used to identify the handler, and
also to locate the directory of the email template files. So in the example above, there should be a directory
<app root>/static/email/templates/order-confirmation which contains a Handlebars template named body.hbs.

## Handling other languages​


[​](#handling-other-languages)By default, the handler will respond to all events on all channels and use the same subject ("Order confirmation for #12345" above)
and body template.

Since v2.0 the .addTemplate() method has been deprecated. To serve different templates — for example, based on the current
languageCode — implement a custom TemplateLoader and pass it to EmailPlugin.init({ templateLoader: new MyTemplateLoader() }).

[TemplateLoader](/reference/core-plugins/email-plugin/template-loader#templateloader)The language is typically determined by the languageCode property of the event's ctx (RequestContext) object, so the
loadTemplate() method can use that to locate the correct template file.

[RequestContext](/reference/typescript-api/request/request-context#requestcontext)Example

```
import { EmailPlugin, TemplateLoader } from '@vendure/email-plugin';import { readFileSync } from 'fs';import path from 'path';class CustomLanguageAwareTemplateLoader implements TemplateLoader {  constructor(private templateDir: string) {}  async loadTemplate(_injector, ctx, { type, templateName }) {    // e.g. returns the content of "body.de.hbs" or "body.en.hbs" depending on ctx.languageCode    const filePath = path.join(this.templateDir, type, `${templateName}.${ctx.languageCode}.hbs`);    return readFileSync(filePath, 'utf-8');  }}EmailPlugin.init({  templateLoader: new CustomLanguageAwareTemplateLoader(path.join(__dirname, '../static/email/templates')),  handlers: defaultEmailHandlers,});
```

## Defining a custom handler​


[​](#defining-a-custom-handler)Let's say you have a plugin which defines a new event type, QuoteRequestedEvent. In your plugin you have defined a mutation
which is executed when the customer requests a quote in your storefront, and in your resolver, you use the EventBus to publish a
new QuoteRequestedEvent.

[EventBus](/reference/typescript-api/events/event-bus#eventbus)You now want to email the customer with their quote. Here are the steps you would take to set this up:

### 1. Create a new handler​


[​](#1-create-a-new-handler)
```
import { EmailEventListener } from `@vendure/email-plugin`;import { QuoteRequestedEvent } from `./events`;const quoteRequestedHandler = new EmailEventListener('quote-requested')  .on(QuoteRequestedEvent)  .setRecipient(event => event.customer.emailAddress)  .setSubject(`Here's the quote you requested`)  .setFrom('{{ fromAddress }}')  .setTemplateVars(event => ({ details: event.details }));
```

### 2. Create the email template​


[​](#2-create-the-email-template)Next you need to make sure there is a template defined at <app root>/static/email/templates/quote-requested/body.hbs. The path
segment quote-requested must match the string passed to the EmailEventListener constructor.

The template would look something like this:

```
{{> header title="Here's the quote you requested" }}<mj-section background-color="#fafafa">    <mj-column>        <mj-text color="#525252">            Thank you for your interest in our products! Here's the details            of the quote you recently requested:        </mj-text>        <!-- your custom email layout goes here -->    </mj-column></mj-section>{{> footer }}
```

You can find pre-made templates on the MJML website.

[MJML website](https://mjml.io/templates/)
### 3. Register the handler​


[​](#3-register-the-handler)Finally, you need to register the handler with the EmailPlugin:

```
import { defaultEmailHandlers, EmailPlugin } from '@vendure/email-plugin';import { quoteRequestedHandler } from './plugins/quote-plugin';const config: VendureConfig = {  // Add an instance of the plugin to the plugins array  plugins: [    EmailPlugin.init({      handler: [...defaultEmailHandlers, quoteRequestedHandler],      // ... etc    }),  ],};
```

```
class EmailEventHandler<T extends string = string, Event extends EventWithContext = EventWithContext> {    constructor(listener: EmailEventListener<T>, event: Type<Event>)    filter(filterFn: (event: Event) => boolean) => EmailEventHandler<T, Event>;    setRecipient(setRecipientFn: (event: Event) => string) => EmailEventHandler<T, Event>;    setLanguageCode(setLanguageCodeFn: (event: Event) => LanguageCode | undefined) => EmailEventHandler<T, Event>;    setTemplateVars(templateVarsFn: SetTemplateVarsFn<Event>) => EmailEventHandler<T, Event>;    setSubject(defaultSubject: string | SetSubjectFn<Event>) => EmailEventHandler<T, Event>;    setFrom(from: string) => EmailEventHandler<T, Event>;    setOptionalAddressFields(optionalAddressFieldsFn: SetOptionalAddressFieldsFn<Event>) => ;    setMetadata(optionalSetMetadataFn: SetMetadataFn<Event>) => ;    setAttachments(setAttachmentsFn: SetAttachmentsFn<Event>) => ;    addTemplate(config: EmailTemplateConfig) => EmailEventHandler<T, Event>;    loadData(loadDataFn: LoadDataFn<Event, R>) => EmailEventHandlerWithAsyncData<R, T, Event, EventWithAsyncData<Event, R>>;    setMockEvent(event: Omit<Event, 'ctx' | 'data'>) => EmailEventHandler<T, Event>;}
```

### constructor​


[​](#constructor)[EmailEventListener](/reference/core-plugins/email-plugin/email-event-listener#emaileventlistener)
### filter​


[​](#filter)[EmailEventHandler](/reference/core-plugins/email-plugin/email-event-handler#emaileventhandler)Defines a predicate function which is used to determine whether the event will trigger an email.
Multiple filter functions may be defined.

### setRecipient​


[​](#setrecipient)[EmailEventHandler](/reference/core-plugins/email-plugin/email-event-handler#emaileventhandler)A function which defines how the recipient email address should be extracted from the incoming event.

The recipient can be a plain email address: 'foobar@example.com'
Or with a formatted name (includes unicode support): 'Ноде Майлер <foobar@example.com>'
Or a comma-separated list of addresses: 'foobar@example.com, "Ноде Майлер" <bar@example.com>'

### setLanguageCode​


[​](#setlanguagecode)[LanguageCode](/reference/typescript-api/common/language-code#languagecode)[EmailEventHandler](/reference/core-plugins/email-plugin/email-event-handler#emaileventhandler)A function which allows to override the language of the email. If not defined, the language from the context will be used.

### setTemplateVars​


[​](#settemplatevars)[SetTemplateVarsFn](/reference/core-plugins/email-plugin/email-plugin-types#settemplatevarsfn)[EmailEventHandler](/reference/core-plugins/email-plugin/email-event-handler#emaileventhandler)A function which returns an object hash of variables which will be made available to the Handlebars template
and subject line for interpolation.

### setSubject​


[​](#setsubject)[SetSubjectFn](/reference/core-plugins/email-plugin/email-plugin-types#setsubjectfn)[EmailEventHandler](/reference/core-plugins/email-plugin/email-event-handler#emaileventhandler)Sets the default subject of the email. The subject string may use Handlebars variables defined by the
setTemplateVars() method.

### setFrom​


[​](#setfrom)[EmailEventHandler](/reference/core-plugins/email-plugin/email-event-handler#emaileventhandler)Sets the default from field of the email. The from string may use Handlebars variables defined by the
setTemplateVars() method.

### setOptionalAddressFields​


[​](#setoptionaladdressfields)[SetOptionalAddressFieldsFn](/reference/core-plugins/email-plugin/email-plugin-types#setoptionaladdressfieldsfn)A function which allows OptionalAddressFields to be specified such as "cc" and "bcc".

[OptionalAddressFields](/reference/core-plugins/email-plugin/email-plugin-types#optionaladdressfields)
### setMetadata​


[​](#setmetadata)[SetMetadataFn](/reference/core-plugins/email-plugin/email-plugin-types#setmetadatafn)A function which allows EmailMetadata to be specified for the email. This can be used
to store arbitrary data about the email which can be used for tracking or other purposes.

[EmailMetadata](/reference/core-plugins/email-plugin/email-plugin-types#emailmetadata)It will be exposed in the EmailSendEvent as event.metadata. Here's an example of usage:

[EmailSendEvent](/reference/core-plugins/email-plugin/email-send-event#emailsendevent)- An OrderStateTransitionEvent occurs, and the EmailEventListener starts processing it.
- The EmailEventHandler attaches metadata to the email:
new EmailEventListener(EventType.ORDER_CONFIRMATION)  .on(OrderStateTransitionEvent)  .setMetadata(event => ({    type: EventType.ORDER_CONFIRMATION,    orderId: event.order.id,  }));
- Then, the EmailPlugin tries to send the email and publishes EmailSendEvent,
passing ctx, emailDetails, error or success, and this metadata.
- In another part of the server, we have an eventBus that subscribes to EmailSendEvent. We can use
metadata.type and metadata.orderId to identify the related order. For example, we can indicate on the
order that the email was successfully sent, or in case of an error, send a notification confirming
the order in another available way.

[OrderStateTransitionEvent](/reference/typescript-api/events/event-types#orderstatetransitionevent)
```
new EmailEventListener(EventType.ORDER_CONFIRMATION)  .on(OrderStateTransitionEvent)  .setMetadata(event => ({    type: EventType.ORDER_CONFIRMATION,    orderId: event.order.id,  }));
```

[EmailSendEvent](/reference/core-plugins/email-plugin/email-send-event#emailsendevent)
### setAttachments​


[​](#setattachments)[SetAttachmentsFn](/reference/core-plugins/email-plugin/email-plugin-types#setattachmentsfn)Defines one or more files to be attached to the email. An attachment can be specified
as either a path (to a file or URL) or as content which can be a string, Buffer or Stream.

Note: When using the content to pass a Buffer or Stream, the raw data will get serialized
into the job queue. For this reason the total size of all attachments passed as content should kept to
less than ~50k. If the attachments are greater than that limit, a warning will be logged and
errors may result if using the DefaultJobQueuePlugin with certain DBs such as MySQL/MariaDB.

Example

```
const testAttachmentHandler = new EmailEventListener('activate-voucher')  .on(ActivateVoucherEvent)  // ... omitted some steps for brevity  .setAttachments(async (event) => {    const { imageUrl, voucherCode } = await getVoucherDataForUser(event.user.id);    return [      {        filename: `voucher-${voucherCode}.jpg`,        path: imageUrl,      },    ];  });
```

### addTemplate​


[​](#addtemplate)[EmailEventHandler](/reference/core-plugins/email-plugin/email-event-handler#emaileventhandler)Add configuration for another template other than the default "body.hbs". Use this method to define specific
templates for channels or languageCodes other than the default.

### loadData​


[​](#loaddata)[LoadDataFn](/reference/core-plugins/email-plugin/email-plugin-types#loaddatafn)[EmailEventHandlerWithAsyncData](/reference/core-plugins/email-plugin/email-event-handler-with-async-data#emaileventhandlerwithasyncdata)[EventWithAsyncData](/reference/core-plugins/email-plugin/email-plugin-types#eventwithasyncdata)Allows data to be loaded asynchronously which can then be used as template variables.
The loadDataFn has access to the event, the TypeORM Connection object, and an
inject() function which can be used to inject any of the providers exported
by the PluginCommonModule. The return value of the loadDataFn will be
added to the event as the data property.

[PluginCommonModule](/reference/typescript-api/plugin/plugin-common-module#plugincommonmodule)Example

```
new EmailEventListener('order-confirmation')  .on(OrderStateTransitionEvent)  .filter(event => event.toState === 'PaymentSettled' && !!event.order.customer)  .loadData(({ event, injector }) => {    const orderService = injector.get(OrderService);    return orderService.getOrderPayments(event.order.id);  })  .setTemplateVars(event => ({    order: event.order,    payments: event.data,  }))  // ...
```

### setMockEvent​


[​](#setmockevent)[EmailEventHandler](/reference/core-plugins/email-plugin/email-event-handler#emaileventhandler)Optionally define a mock Event which is used by the dev mode mailbox app for generating mock emails
from this handler, which is useful when developing the email templates.


---

# EmailEventListener


## EmailEventListener​


[​](#emaileventlistener)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[event-listener.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/event-listener.ts#L13)An EmailEventListener is used to listen for events and set up a EmailEventHandler which
defines how an email will be generated from this event.

[EmailEventHandler](/reference/core-plugins/email-plugin/email-event-handler#emaileventhandler)
```
class EmailEventListener<T extends string> {    public type: T;    constructor(type: T)    on(event: Type<Event>) => EmailEventHandler<T, Event>;}
```

### type​


[​](#type)
### constructor​


[​](#constructor)
### on​


[​](#on)[EmailEventHandler](/reference/core-plugins/email-plugin/email-event-handler#emaileventhandler)Defines the event to listen for.


---

# EmailGenerator


## EmailGenerator​


[​](#emailgenerator)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[email-generator.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/generator/email-generator.ts#L13)An EmailGenerator generates the subject and body details of an email.

```
interface EmailGenerator<T extends string = any, E extends VendureEvent = any> extends InjectableStrategy {    onInit?(options: EmailPluginOptions): void | Promise<void>;    generate(        from: string,        subject: string,        body: string,        templateVars: { [key: string]: any },    ): Pick<EmailDetails, 'from' | 'subject' | 'body'>;}
```

- Extends: InjectableStrategy

[InjectableStrategy](/reference/typescript-api/common/injectable-strategy#injectablestrategy)
### onInit​


[​](#oninit)[EmailPluginOptions](/reference/core-plugins/email-plugin/email-plugin-options#emailpluginoptions)Any necessary setup can be performed here.

### generate​


[​](#generate)[EmailDetails](/reference/core-plugins/email-plugin/email-plugin-types#emaildetails)Given a subject and body from an email template, this method generates the final
interpolated email text.

## HandlebarsMjmlGenerator​


[​](#handlebarsmjmlgenerator)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[handlebars-mjml-generator.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/generator/handlebars-mjml-generator.ts#L17)Uses Handlebars (https://handlebarsjs.com/) to output MJML (https://mjml.io) which is then
compiled down to responsive email HTML.

[https://handlebarsjs.com/](https://handlebarsjs.com/)[https://mjml.io](https://mjml.io)
```
class HandlebarsMjmlGenerator implements EmailGenerator {    onInit(options: InitializedEmailPluginOptions) => ;    generate(from: string, subject: string, template: string, templateVars: any) => ;}
```

- Implements: EmailGenerator

[EmailGenerator](/reference/core-plugins/email-plugin/email-generator#emailgenerator)
### onInit​


[​](#oninit-1)
### generate​


[​](#generate-1)


---

# EmailPluginOptions


## EmailPluginOptions​


[​](#emailpluginoptions)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/types.ts#L77)Configuration for the EmailPlugin.

```
interface EmailPluginOptions {    templatePath?: string;    templateLoader?: TemplateLoader;    transport:        | EmailTransportOptions        | ((              injector?: Injector,              ctx?: RequestContext,          ) => EmailTransportOptions | Promise<EmailTransportOptions>);    handlers: Array<EmailEventHandler<string, any>>;    globalTemplateVars?: { [key: string]: any } | GlobalTemplateVarsFn;    emailSender?: EmailSender;    emailGenerator?: EmailGenerator;}
```

### templatePath​


[​](#templatepath)The path to the location of the email templates. In a default Vendure installation,
the templates are installed to <project root>/vendure/email/templates.

### templateLoader​


[​](#templateloader)[TemplateLoader](/reference/core-plugins/email-plugin/template-loader#templateloader)An optional TemplateLoader which can be used to load templates from a custom location or async service.
The default uses the FileBasedTemplateLoader which loads templates from <project root>/vendure/email/templates

### transport​


[​](#transport)[EmailTransportOptions](/reference/core-plugins/email-plugin/transport-options#emailtransportoptions)[Injector](/reference/typescript-api/common/injector#injector)[RequestContext](/reference/typescript-api/request/request-context#requestcontext)[EmailTransportOptions](/reference/core-plugins/email-plugin/transport-options#emailtransportoptions)[EmailTransportOptions](/reference/core-plugins/email-plugin/transport-options#emailtransportoptions)Configures how the emails are sent.

### handlers​


[​](#handlers)[EmailEventHandler](/reference/core-plugins/email-plugin/email-event-handler#emaileventhandler)An array of EmailEventHandlers which define which Vendure events will trigger
emails, and how those emails are generated.

[EmailEventHandler](/reference/core-plugins/email-plugin/email-event-handler#emaileventhandler)
### globalTemplateVars​


[​](#globaltemplatevars)[GlobalTemplateVarsFn](/reference/core-plugins/email-plugin/email-plugin-options#globaltemplatevarsfn)An object containing variables which are made available to all templates. For example,
the storefront URL could be defined here and then used in the "email address verification"
email. Use the GlobalTemplateVarsFn if you need to retrieve variables from Vendure or
plugin services.

### emailSender​


[​](#emailsender)[EmailSender](/reference/core-plugins/email-plugin/email-sender#emailsender)[NodemailerEmailSender](/reference/core-plugins/email-plugin/email-sender#nodemaileremailsender)An optional allowed EmailSender, used to allow custom implementations of the send functionality
while still utilizing the existing emailPlugin functionality.

### emailGenerator​


[​](#emailgenerator)[EmailGenerator](/reference/core-plugins/email-plugin/email-generator#emailgenerator)[HandlebarsMjmlGenerator](/reference/core-plugins/email-plugin/email-generator#handlebarsmjmlgenerator)An optional allowed EmailGenerator, used to allow custom email generation functionality to
better match with custom email sending functionality.

## GlobalTemplateVarsFn​


[​](#globaltemplatevarsfn)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/types.ts#L64)Allows you to dynamically load the "globalTemplateVars" key async and access Vendure services
to create the object. This is not a requirement. You can also specify a simple static object if your
projects doesn't need to access async or dynamic values.

Example

```
EmailPlugin.init({   globalTemplateVars: async (ctx, injector) => {         const myAsyncService = injector.get(MyAsyncService);         const asyncValue = await myAsyncService.get(ctx);         const channel = ctx.channel;         const { primaryColor } = channel.customFields.theme;         const theme = {             primaryColor,             asyncValue,         };         return theme;     }  [...]})
```

```
type GlobalTemplateVarsFn = (    ctx: RequestContext,    injector: Injector,) => Promise<{ [key: string]: any }>
```

## EmailPluginDevModeOptions​


[​](#emailplugindevmodeoptions)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/types.ts#L150)Configuration for running the EmailPlugin in development mode.

```
interface EmailPluginDevModeOptions extends Omit<EmailPluginOptions, 'transport'> {    devMode: true;    outputPath: string;    route: string;}
```

- Extends: Omit<EmailPluginOptions, 'transport'>

[EmailPluginOptions](/reference/core-plugins/email-plugin/email-plugin-options#emailpluginoptions)
### devMode​


[​](#devmode)
### outputPath​


[​](#outputpath)The path to which html email files will be saved rather than being sent.

### route​


[​](#route)The route to the dev mailbox server.


---

# Email Plugin Types


## EventWithContext​


[​](#eventwithcontext)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/types.ts#L22)A VendureEvent which also includes a ctx property containing the current
RequestContext, which is used to determine the channel and language
to use when generating the email.

[RequestContext](/reference/typescript-api/request/request-context#requestcontext)
```
type EventWithContext = VendureEvent & { ctx: RequestContext }
```

## EventWithAsyncData​


[​](#eventwithasyncdata)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/types.ts#L32)A VendureEvent with a RequestContext and a data property which contains the
value resolved from the EmailEventHandler.loadData() callback.

[RequestContext](/reference/typescript-api/request/request-context#requestcontext)[EmailEventHandler](/reference/core-plugins/email-plugin/email-event-handler#emaileventhandler)
```
type EventWithAsyncData<Event extends EventWithContext, R> = Event & { data: R }
```

## EmailDetails​


[​](#emaildetails)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/types.ts#L288)The final, generated email details to be sent.

```
interface EmailDetails<Type extends 'serialized' | 'unserialized' = 'unserialized'> {    from: string;    recipient: string;    subject: string;    body: string;    attachments: Array<Type extends 'serialized' ? SerializedAttachment : Attachment>;    cc?: string;    bcc?: string;    replyTo?: string;}
```

### from​


[​](#from)
### recipient​


[​](#recipient)
### subject​


[​](#subject)
### body​


[​](#body)
### attachments​


[​](#attachments)
### cc​


[​](#cc)
### bcc​


[​](#bcc)
### replyTo​


[​](#replyto)
## LoadDataFn​


[​](#loaddatafn)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/types.ts#L322)A function used to load async data for use by an EmailEventHandler.

[EmailEventHandler](/reference/core-plugins/email-plugin/email-event-handler#emaileventhandler)
```
type LoadDataFn<Event extends EventWithContext, R> = (context: {    event: Event;    injector: Injector;}) => Promise<R>
```

## EmailAttachment​


[​](#emailattachment)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/types.ts#L341)An object defining a file attachment for an email. Based on the object described
here in the Nodemailer docs, but
only uses the path property to define a filesystem path or a URL pointing to
the attachment file.

[here in the Nodemailer docs](https://nodemailer.com/message/attachments/)
```
type EmailAttachment = Omit<Attachment, 'raw'> & { path?: string }
```

## LoadTemplateInput​


[​](#loadtemplateinput)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/types.ts#L402)The object passed to the TemplateLoader loadTemplate() method.

[TemplateLoader](/reference/core-plugins/email-plugin/template-loader#templateloader)
```
interface LoadTemplateInput {    type: string;    templateName: string;    templateVars: any;}
```

### type​


[​](#type)The type corresponds to the string passed to the EmailEventListener constructor.

### templateName​


[​](#templatename)The template name is specified by the EmailEventHander's call to
the addTemplate() method, and will default to body.hbs

### templateVars​


[​](#templatevars)The variables defined by the globalTemplateVars as well as any variables defined in the
EmailEventHandler's setTemplateVars() method.

## SetTemplateVarsFn​


[​](#settemplatevarsfn)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/types.ts#L435)A function used to define template variables available to email templates.
See EmailEventHandler.setTemplateVars().

[EmailEventHandler](/reference/core-plugins/email-plugin/email-event-handler#emaileventhandler)
```
type SetTemplateVarsFn<Event> = (    event: Event,    globals: { [key: string]: any },) => { [key: string]: any }
```

## SetAttachmentsFn​


[​](#setattachmentsfn)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/types.ts#L449)A function used to define attachments to be sent with the email.
See https://nodemailer.com/message/attachments/ for more information about
how attachments work in Nodemailer.

[https://nodemailer.com/message/attachments/](https://nodemailer.com/message/attachments/)
```
type SetAttachmentsFn<Event> = (event: Event) => EmailAttachment[] | Promise<EmailAttachment[]>
```

## SetSubjectFn​


[​](#setsubjectfn)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/types.ts#L457)A function used to define the subject to be sent with the email.

```
type SetSubjectFn<Event> = (    event: Event,    ctx: RequestContext,    injector: Injector,) => string | Promise<string>
```

## OptionalAddressFields​


[​](#optionaladdressfields)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/types.ts#L471)Optional address-related fields for sending the email.

```
interface OptionalAddressFields {    cc?: string;    bcc?: string;    replyTo?: string;}
```

### cc​


[​](#cc-1)Comma separated list of recipients email addresses that will appear on the Cc: field

### bcc​


[​](#bcc-1)Comma separated list of recipients email addresses that will appear on the Bcc: field

### replyTo​


[​](#replyto-1)An email address that will appear on the Reply-To: field

## SetOptionalAddressFieldsFn​


[​](#setoptionaladdressfieldsfn)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/types.ts#L497)A function used to set the OptionalAddressFields.

[OptionalAddressFields](/reference/core-plugins/email-plugin/email-plugin-types#optionaladdressfields)
```
type SetOptionalAddressFieldsFn<Event> = (    event: Event,) => OptionalAddressFields | Promise<OptionalAddressFields>
```

## SetMetadataFn​


[​](#setmetadatafn)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/types.ts#L509)A function used to set the EmailMetadata.

[EmailMetadata](/reference/core-plugins/email-plugin/email-plugin-types#emailmetadata)
```
type SetMetadataFn<Event> = (event: Event) => EmailMetadata | Promise<EmailMetadata>
```

## EmailMetadata​


[​](#emailmetadata)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/types.ts#L519)Metadata that can be attached to an email via the EmailEventHandler.setMetadata() method.

[EmailEventHandler](/reference/core-plugins/email-plugin/email-event-handler#emaileventhandler)
```
type EmailMetadata = Record<string, any>
```



---

# EmailSendEvent


## EmailSendEvent​


[​](#emailsendevent)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[email-send-event.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/email-send-event.ts#L14)This event is fired when an email sending attempt has been made. If the sending was successful,
the success property will be true, and if not, the error property will contain the error
which occurred.

```
class EmailSendEvent extends VendureEvent {    constructor(ctx: RequestContext, details: EmailDetails, success: boolean, error?: Error, metadata?: EmailMetadata)}
```

- Extends: VendureEvent

[VendureEvent](/reference/typescript-api/events/vendure-event#vendureevent)
### constructor​


[​](#constructor)[RequestContext](/reference/typescript-api/request/request-context#requestcontext)[EmailDetails](/reference/core-plugins/email-plugin/email-plugin-types#emaildetails)[EmailMetadata](/reference/core-plugins/email-plugin/email-plugin-types#emailmetadata)


---

# EmailSender


## EmailSender​


[​](#emailsender)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[email-sender.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/sender/email-sender.ts#L45)An EmailSender is responsible for sending the email, e.g. via an SMTP connection
or using some other mail-sending API. By default, the EmailPlugin uses the
NodemailerEmailSender, but it is also possible to supply a custom implementation:

[NodemailerEmailSender](/reference/core-plugins/email-plugin/email-sender#nodemaileremailsender)Example

```
const sgMail = require('@sendgrid/mail');sgMail.setApiKey(process.env.SENDGRID_API_KEY);class SendgridEmailSender implements EmailSender {  async send(email: EmailDetails) {    await sgMail.send({      to: email.recipient,      from: email.from,      subject: email.subject,      html: email.body,    });  }}const config: VendureConfig = {  logger: new DefaultLogger({ level: LogLevel.Debug })  // ...  plugins: [    EmailPlugin.init({       // ... template, handler config omitted      transport: { type: 'none' },       emailSender: new SendgridEmailSender(),    }),  ],};
```

```
interface EmailSender extends InjectableStrategy {    send: (email: EmailDetails, options: EmailTransportOptions) => void | Promise<void>;}
```

- Extends: InjectableStrategy

[InjectableStrategy](/reference/typescript-api/common/injectable-strategy#injectablestrategy)
### send​


[​](#send)[EmailDetails](/reference/core-plugins/email-plugin/email-plugin-types#emaildetails)[EmailTransportOptions](/reference/core-plugins/email-plugin/transport-options#emailtransportoptions)
## NodemailerEmailSender​


[​](#nodemaileremailsender)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[nodemailer-email-sender.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/sender/nodemailer-email-sender.ts#L39)Uses the configured transport to send the generated email.

```
class NodemailerEmailSender implements EmailSender {    send(email: EmailDetails, options: EmailTransportOptions) => ;}
```

- Implements: EmailSender

[EmailSender](/reference/core-plugins/email-plugin/email-sender#emailsender)
### send​


[​](#send-1)[EmailDetails](/reference/core-plugins/email-plugin/email-plugin-types#emaildetails)[EmailTransportOptions](/reference/core-plugins/email-plugin/transport-options#emailtransportoptions)


---

# Email Utils


## transformOrderLineAssetUrls​


[​](#transformorderlineasseturls)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[default-email-handlers.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/handler/default-email-handlers.ts#L106)Applies the configured AssetStorageStrategy.toAbsoluteUrl() function to each of the
OrderLine's featuredAsset.preview properties, so that they can be correctly displayed
in the email template.
This is required since that step usually happens at the API in middleware, which is not
applicable in this context. So we need to do it manually.

Note: Mutates the Order object

```
function transformOrderLineAssetUrls(ctx: RequestContext, order: Order, injector: Injector): Order
```

Parameters

### ctx​


[​](#ctx)[RequestContext](/reference/typescript-api/request/request-context#requestcontext)
### order​


[​](#order)[Order](/reference/typescript-api/entities/order#order)
### injector​


[​](#injector)[Injector](/reference/typescript-api/common/injector#injector)
## shippingLinesWithMethod​


[​](#shippinglineswithmethod)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[default-email-handlers.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/handler/default-email-handlers.ts#L127)Ensures that the ShippingLines have a shippingMethod so that we can use the
shippingMethod.name property in the email template.

```
function shippingLinesWithMethod(order: Order): ShippingLine[]
```

Parameters

### order​


[​](#order-1)[Order](/reference/typescript-api/entities/order#order)


---

# TemplateLoader


## TemplateLoader​


[​](#templateloader)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[template-loader.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/template-loader/template-loader.ts#L32)Loads email templates based on the given request context, type and template name
and return the template as a string.

Example

```
import { EmailPlugin, TemplateLoader } from '@vendure/email-plugin';class MyTemplateLoader implements TemplateLoader {     loadTemplate(injector, ctx, { type, templateName }){         return myCustomTemplateFunction(ctx);     }}// In vendure-config.ts:...EmailPlugin.init({    templateLoader: new MyTemplateLoader()    ...})
```

```
interface TemplateLoader {    loadTemplate(injector: Injector, ctx: RequestContext, input: LoadTemplateInput): Promise<string>;    loadPartials?(): Promise<Partial[]>;}
```

### loadTemplate​


[​](#loadtemplate)[Injector](/reference/typescript-api/common/injector#injector)[RequestContext](/reference/typescript-api/request/request-context#requestcontext)[LoadTemplateInput](/reference/core-plugins/email-plugin/email-plugin-types#loadtemplateinput)Load template and return it's content as a string

### loadPartials​


[​](#loadpartials)Load partials and return their contents.
This method is only called during initialization, i.e. during server startup.

## FileBasedTemplateLoader​


[​](#filebasedtemplateloader)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[file-based-template-loader.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/template-loader/file-based-template-loader.ts#L17)Loads email templates from the local file system. This is the default
loader used by the EmailPlugin.

```
class FileBasedTemplateLoader implements TemplateLoader {    constructor(templatePath: string)    loadTemplate(_injector: Injector, _ctx: RequestContext, { type, templateName }: LoadTemplateInput) => Promise<string>;    loadPartials() => Promise<Partial[]>;}
```

- Implements: TemplateLoader

[TemplateLoader](/reference/core-plugins/email-plugin/template-loader#templateloader)
### constructor​


[​](#constructor)
### loadTemplate​


[​](#loadtemplate-1)[Injector](/reference/typescript-api/common/injector#injector)[RequestContext](/reference/typescript-api/request/request-context#requestcontext)[LoadTemplateInput](/reference/core-plugins/email-plugin/email-plugin-types#loadtemplateinput)
### loadPartials​


[​](#loadpartials-1)


---

# Transport Options


## EmailTransportOptions​


[​](#emailtransportoptions)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/types.ts#L171)A union of all the possible transport options for sending emails.

```
type EmailTransportOptions = | SMTPTransportOptions    | SendmailTransportOptions    | FileTransportOptions    | NoopTransportOptions    | SESTransportOptions    | TestingTransportOptions
```

## SMTPTransportOptions​


[​](#smtptransportoptions)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/types.ts#L186)The SMTP transport options of Nodemailer

[Nodemailer](https://nodemailer.com/smtp/)
```
interface SMTPTransportOptions extends SMTPTransport.Options {    type: 'smtp';    logging?: boolean;}
```

- Extends: SMTPTransport.Options

### type​


[​](#type)
### logging​


[​](#logging)If true, uses the configured VendureLogger to log messages from Nodemailer as it interacts with
the SMTP server.

[VendureLogger](/reference/typescript-api/logger/vendure-logger#vendurelogger)
## SESTransportOptions​


[​](#sestransportoptions)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/types.ts#L235)The SES transport options of Nodemailer

[Nodemailer](https://nodemailer.com/transports/ses//)See Nodemailers's SES docs for more details

[Nodemailers's SES docs](https://nodemailer.com/transports/ses/)Example

```
 import { SES, SendRawEmailCommand } from '@aws-sdk/client-ses' const ses = new SES({    apiVersion: '2010-12-01',    region: 'eu-central-1',    credentials: {        accessKeyId: process.env.SES_ACCESS_KEY || '',        secretAccessKey: process.env.SES_SECRET_KEY || '',    }, }) const config: VendureConfig = {  // Add an instance of the plugin to the plugins array  plugins: [    EmailPlugin.init({      handler: defaultEmailHandlers,      templateLoader: new FileBasedTemplateLoader(path.join(__dirname, '../static/email/templates')),      transport: {        type: 'ses',        SES: { ses, aws: { SendRawEmailCommand } },        sendingRate: 10, // optional messages per second sending rate      },    }),  ],};
```

```
interface SESTransportOptions extends SESTransport.Options {    type: 'ses';}
```

- Extends: SESTransport.Options

### type​


[​](#type-1)
## SendmailTransportOptions​


[​](#sendmailtransportoptions)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/types.ts#L246)Uses the local Sendmail program to send the email.

```
interface SendmailTransportOptions {    type: 'sendmail';    path?: string;    newline?: string;}
```

### type​


[​](#type-2)
### path​


[​](#path)
### newline​


[​](#newline)
## FileTransportOptions​


[​](#filetransportoptions)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/types.ts#L261)Outputs the email as an HTML file for development purposes.

```
interface FileTransportOptions {    type: 'file';    outputPath: string;    raw?: boolean;}
```

### type​


[​](#type-3)
### outputPath​


[​](#outputpath)
### raw​


[​](#raw)
## NoopTransportOptions​


[​](#nooptransportoptions)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/types.ts#L277)Does nothing with the generated email. Intended for use in testing where we don't care about the email transport,
or when using a custom EmailSender which does not require transport options.

[EmailSender](/reference/core-plugins/email-plugin/email-sender#emailsender)
```
interface NoopTransportOptions {    type: 'none';}
```

### type​


[​](#type-4)
## TestingTransportOptions​


[​](#testingtransportoptions)[@vendure/email-plugin](https://www.npmjs.com/package/@vendure/email-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/email-plugin/src/types.ts#L306)Forwards the raw GeneratedEmailContext object to a provided callback, for use in testing.

```
interface TestingTransportOptions {    type: 'testing';    onSend: (details: EmailDetails) => void;}
```

### type​


[​](#type-5)
### onSend​


[​](#onsend)[EmailDetails](/reference/core-plugins/email-plugin/email-plugin-types#emaildetails)Callback to be invoked when an email would be sent.


---

# GraphiqlPlugin


## GraphiqlPlugin​


[​](#graphiqlplugin)[@vendure/graphiql-plugin](https://www.npmjs.com/package/@vendure/graphiql-plugin)[plugin.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/graphiql-plugin/src/plugin.ts#L64)This plugin provides a GraphiQL UI for exploring and testing the Vendure GraphQL APIs.

It adds routes /graphiql/admin and /graphiql/shop which serve the GraphiQL interface
for the respective APIs.

## Installation​


[​](#installation)
```
import { GraphiqlPlugin } from '@vendure/graphiql-plugin';const config: VendureConfig = {  // Add an instance of the plugin to the plugins array  plugins: [    GraphiqlPlugin.init({      route: 'graphiql', // Optional, defaults to 'graphiql'    }),  ],};
```

## Custom API paths​


[​](#custom-api-paths)By default, the plugin automatically reads the Admin API and Shop API paths from your Vendure configuration.

If you need to override these paths, you can specify them explicitly:

```
GraphiQLPlugin.init({    route: 'my-custom-route', // defaults to `graphiql`});
```

## Query parameters​


[​](#query-parameters)You can add the following query parameters to the GraphiQL URL:

- ?query=... - Pre-populate the query editor with a GraphQL query.
- ?embeddedMode=true - This renders the editor in embedded mode, which hides the header and
the API switcher. This is useful for embedding GraphiQL in other applications such as documentation.
In this mode, the editor also does not persist changes across reloads.

```
class GraphiqlPlugin implements NestModule {    static options: Required<GraphiqlPluginOptions>;    constructor(processContext: ProcessContext, configService: ConfigService, graphiQLService: GraphiQLService)    init(options: GraphiqlPluginOptions = {}) => Type<GraphiqlPlugin>;    configure(consumer: MiddlewareConsumer) => ;}
```

- Implements: NestModule

### options​


[​](#options)
### constructor​


[​](#constructor)[ProcessContext](/reference/typescript-api/common/process-context#processcontext)
### init​


[​](#init)[GraphiqlPlugin](/reference/core-plugins/graphiql-plugin/#graphiqlplugin)
### configure​


[​](#configure)


---

# HardenPlugin


## HardenPlugin​


[​](#hardenplugin)[@vendure/harden-plugin](https://www.npmjs.com/package/@vendure/harden-plugin)[harden.plugin.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/harden-plugin/src/harden.plugin.ts#L146)The HardenPlugin hardens the Shop and Admin GraphQL APIs against attacks and abuse.

- It analyzes the complexity on incoming graphql queries and rejects queries that are too complex and
could be used to overload the resources of the server.
- It disables dev-mode API features such as introspection and the GraphQL playground app.
- It removes field name suggestions to prevent trial-and-error schema sniffing.

It is a recommended plugin for all production configurations.

## Installation​


[​](#installation)yarn add @vendure/harden-plugin

or

npm install @vendure/harden-plugin

Then add the HardenPlugin, calling the .init() method with HardenPluginOptions:

[HardenPluginOptions](/reference/core-plugins/harden-plugin/harden-plugin-options#hardenpluginoptions)Example

```
import { HardenPlugin } from '@vendure/harden-plugin';const config: VendureConfig = {  // Add an instance of the plugin to the plugins array  plugins: [     HardenPlugin.init({       maxQueryComplexity: 650,       apiMode: process.env.APP_ENV === 'dev' ? 'dev' : 'prod',     }),  ],};
```

## Setting the max query complexity​


[​](#setting-the-max-query-complexity)The maxQueryComplexity option determines how complex a query can be. The complexity of a query relates to how many, and how
deeply-nested are the fields being selected, and is intended to roughly correspond to the amount of server resources that would
be required to resolve that query.

The goal of this setting is to prevent attacks in which a malicious actor crafts a very complex query in order to overwhelm your
server resources. Here's an example of a request which would likely overwhelm a Vendure server:

```
query EvilQuery {  products {    items {      collections {        productVariants {          items {            product {              collections {                productVariants {                  items {                    product {                      variants {                        name                      }                    }                  }                }              }            }          }        }      }    }  }}
```

This evil query has a complexity score of 2,443,203 - much greater than the default of 1,000!

The complexity score is calculated by the graphql-query-complexity library,
and by default uses the defaultVendureComplexityEstimator, which is tuned specifically to the Vendure Shop API.

[graphql-query-complexity library](https://www.npmjs.com/package/graphql-query-complexity)[defaultVendureComplexityEstimator](/reference/core-plugins/harden-plugin/default-vendure-complexity-estimator#defaultvendurecomplexityestimator)Note: By default, if the "take" argument is omitted from a list query (e.g. the products or collections query), a default factor of 1000 is applied.

The optimal max complexity score will vary depending on:

- The requirements of your storefront and other clients using the Shop API
- The resources available to your server

You should aim to set the maximum as low as possible while still being able to service all the requests required.
This will take some manual tuning.
While tuning the max, you can turn on the logComplexityScore to get a detailed breakdown of the complexity of each query, as well as how
that total score is derived from its child fields:

Example

```
import { HardenPlugin } from '@vendure/harden-plugin';const config: VendureConfig = {  // A detailed summary is logged at the "debug" level  logger: new DefaultLogger({ level: LogLevel.Debug }),  plugins: [     HardenPlugin.init({       maxQueryComplexity: 650,       logComplexityScore: true,     }),  ],};
```

With logging configured as above, the following query:

```
query ProductList {  products(options: { take: 5 }) {    items {      id      name      featuredAsset {        preview      }    }  }}
```

will log the following breakdown:

```
debug 16/12/22, 14:12 - [HardenPlugin] Calculating complexity of [ProductList]debug 16/12/22, 14:12 - [HardenPlugin] Product.id: ID!     childComplexity: 0, score: 1debug 16/12/22, 14:12 - [HardenPlugin] Product.name: String!       childComplexity: 0, score: 1debug 16/12/22, 14:12 - [HardenPlugin] Asset.preview: String!      childComplexity: 0, score: 1debug 16/12/22, 14:12 - [HardenPlugin] Product.featuredAsset: Asset        childComplexity: 1, score: 2debug 16/12/22, 14:12 - [HardenPlugin] ProductList.items: [Product!]!      childComplexity: 4, score: 20debug 16/12/22, 14:12 - [HardenPlugin] Query.products: ProductList!        childComplexity: 20, score: 35verbose 16/12/22, 14:12 - [HardenPlugin] Query complexity [ProductList]: 35
```

```
class HardenPlugin {    static options: HardenPluginOptions;    init(options: HardenPluginOptions) => ;}
```

### options​


[​](#options)[HardenPluginOptions](/reference/core-plugins/harden-plugin/harden-plugin-options#hardenpluginoptions)
### init​


[​](#init)[HardenPluginOptions](/reference/core-plugins/harden-plugin/harden-plugin-options#hardenpluginoptions)


---

# DefaultVendureComplexityEstimator


## defaultVendureComplexityEstimator​


[​](#defaultvendurecomplexityestimator)[@vendure/harden-plugin](https://www.npmjs.com/package/@vendure/harden-plugin)[query-complexity-plugin.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/harden-plugin/src/middleware/query-complexity-plugin.ts#L98)A complexity estimator which takes into account List and PaginatedList types and can
be further configured by providing a customComplexityFactors object.

When selecting PaginatedList types, the "take" argument is used to estimate a complexity
factor. If the "take" argument is omitted, a default factor of 1000 is applied.

```
function defaultVendureComplexityEstimator(customComplexityFactors: { [path: string]: number }, logFieldScores: boolean): void
```

Parameters

### customComplexityFactors​


[​](#customcomplexityfactors)
### logFieldScores​


[​](#logfieldscores)


---

# HardenPluginOptions


## HardenPluginOptions​


[​](#hardenpluginoptions)[@vendure/harden-plugin](https://www.npmjs.com/package/@vendure/harden-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/harden-plugin/src/types.ts#L10)Options that can be passed to the .init() static method of the HardenPlugin.

```
interface HardenPluginOptions {    maxQueryComplexity?: number;    queryComplexityEstimators?: ComplexityEstimator[];    logComplexityScore?: boolean;    customComplexityFactors?: {        [path: string]: number;    };    hideFieldSuggestions?: boolean;    apiMode?: 'dev' | 'prod';    skip?: (context: GraphQLRequestContext<any>) => Promise<boolean> | boolean;}
```

### maxQueryComplexity​


[​](#maxquerycomplexity)Defines the maximum permitted complexity score of a query. The complexity score is based
on the number of fields being selected as well as other factors like whether there are nested
lists.

A query which exceeds the maximum score will result in an error.

### queryComplexityEstimators​


[​](#querycomplexityestimators)An array of custom estimator functions for calculating the complexity of a query. By default,
the plugin will use the defaultVendureComplexityEstimator which is specifically
tuned to accurately estimate Vendure queries.

[defaultVendureComplexityEstimator](/reference/core-plugins/harden-plugin/default-vendure-complexity-estimator#defaultvendurecomplexityestimator)
### logComplexityScore​


[​](#logcomplexityscore)When set to true, the complexity score of each query will be logged at the Verbose
log level, and a breakdown of the calculation for each field will be logged at the Debug level.

This is very useful for tuning your complexity scores.

### customComplexityFactors​


[​](#customcomplexityfactors)This object allows you to tune the complexity weight of specific fields. For example,
if you have a custom stockLocations field defined on the ProductVariant type, and
you know that it is a particularly expensive operation to execute, you can increase
its complexity like this:

Example

```
HardenPlugin.init({  maxQueryComplexity: 650,  customComplexityFactors: {    'ProductVariant.stockLocations': 10  }}),
```

### hideFieldSuggestions​


[​](#hidefieldsuggestions)Graphql-js will make suggestions about the names of fields if an invalid field name is provided.
This would allow an attacker to find out the available fields by brute force even if introspection
is disabled.

Setting this option to true will prevent these suggestion error messages from being returned,
instead replacing the message with a generic "Invalid request" message.

### apiMode​


[​](#apimode)When set to 'prod', the plugin will disable dev-mode features of the GraphQL APIs:

- introspection
- GraphQL playground

### skip​


[​](#skip)Allows you to skip the complexity check for certain requests.

Example

```
HardenPlugin.init({  skip: (context) => context.request.http.headers['x-storefront-ssr-auth'] === 'some-secret-token'}),
```


---

# BullMQJobQueuePlugin


## BullMQJobQueuePlugin​


[​](#bullmqjobqueueplugin)[@vendure/job-queue-plugin](https://www.npmjs.com/package/@vendure/job-queue-plugin)[plugin.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/job-queue-plugin/src/bullmq/plugin.ts#L190)This plugin is a drop-in replacement of the DefaultJobQueuePlugin, which implements a push-based
job queue strategy built on top of the popular BullMQ library.

[BullMQ](https://github.com/taskforcesh/bullmq)
## Advantages over the DefaultJobQueuePlugin​


[​](#advantages-over-the-defaultjobqueueplugin)The advantage of this approach is that jobs are stored in Redis rather than in the database. For more complex
applications with many job queues and/or multiple worker instances, this can massively reduce the load on the
DB server. The reason for this is that the DefaultJobQueuePlugin uses polling to check for new jobs. By default
it will poll every 200ms. A typical Vendure instance uses at least 3 queues (handling emails, collections, search index),
so even with a single worker instance this results in 15 queries per second to the DB constantly. Adding more
custom queues and multiple worker instances can easily result in 50 or 100 queries per second. At this point
performance may be impacted.

Using this plugin, no polling is needed, as BullMQ will push jobs to the worker(s) as and when they are added
to the queue. This results in significantly more scalable performance characteristics, as well as lower latency
in processing jobs.

## Installation​


[​](#installation)Note: To use this plugin, you need to manually install the bullmq package:

```
npm install bullmq@^5.4.2
```

Note: The v1.x version of this plugin is designed to work with bullmq v1.x, etc.

Example

```
import { BullMQJobQueuePlugin } from '@vendure/job-queue-plugin/package/bullmq';const config: VendureConfig = {  // Add an instance of the plugin to the plugins array  plugins: [    // DefaultJobQueuePlugin should be removed from the plugins array    BullMQJobQueuePlugin.init({      connection: {        port: 6379      }    }),  ],};
```

### Running Redis locally​


[​](#running-redis-locally)To develop with this plugin, you'll need an instance of Redis to connect to. Here's a docker-compose config
that will set up Redis as well as Redis Commander,
which is a web-based UI for interacting with Redis:

[Redis](https://redis.io/)[Redis Commander](https://github.com/joeferner/redis-commander)
```
version: "3"services:  redis:    image: redis:7.4    hostname: redis    container_name: redis    ports:      - "6379:6379"  redis-commander:    container_name: redis-commander    hostname: redis-commander    image: rediscommander/redis-commander:latest    environment:      - REDIS_HOSTS=local:redis:6379    ports:      - "8085:8081"
```

## Concurrency​


[​](#concurrency)The default concurrency of a single worker is 3, i.e. up to 3 jobs will be processed at the same time.
You can change the concurrency in the workerOptions passed to the init() method:

Example

```
const config: VendureConfig = {  plugins: [    BullMQJobQueuePlugin.init({      workerOptions: {        concurrency: 10,      },    }),  ],};
```

## Removing old jobs​


[​](#removing-old-jobs)By default, BullMQ will keep completed jobs in the completed set and failed jobs in the failed set. Over time,
these sets can grow very large. Since Vendure v2.1, the default behaviour is to remove jobs from these sets after
30 days or after a maximum of 5,000 completed or failed jobs.

This can be configured using the removeOnComplete and removeOnFail options:

Example

```
const config: VendureConfig = {  plugins: [    BullMQJobQueuePlugin.init({      workerOptions: {        removeOnComplete: {          count: 500,        },        removeOnFail: {          age: 60 * 60 * 24 * 7, // 7 days          count: 1000,        },      }    }),  ],};
```

The count option specifies the maximum number of jobs to keep in the set, while the age option specifies the
maximum age of a job in seconds. If both options are specified, then the jobs kept will be the ones that satisfy
both properties.

## Job Priority​


[​](#job-priority)Some jobs are more important than others. For example, sending out a timely email after a customer places an order
is probably more important than a routine data import task. Sometimes you can get the situation where lower-priority
jobs are blocking higher-priority jobs.

Let's say you have a data import job that runs periodically and takes a long time to complete. If you have a high-priority
job that needs to be processed quickly, it could be stuck behind the data import job in the queue. A customer might
not get their confirmation email for 30 minutes while that data import job is processed!

To solve this problem, you can set the priority option on a job. Jobs with a higher priority will be processed before
jobs with a lower priority. By default, all jobs have a priority of 0 (which is the highest).

Learn more about how priority works in BullMQ in their documentation.

[documentation](https://docs.bullmq.io/guide/jobs/prioritized)You can set the priority by using the setJobOptions option (introduced in Vendure v3.2.0):

Example

```
const config: VendureConfig = {  plugins: [    BullMQJobQueuePlugin.init({      setJobOptions: (queueName, job) => {        let priority = 10;        switch (queueName) {          case 'super-critical-task':            priority = 0;            break;          case 'send-email':            priority = 5;            break;          default:            priority = 10;        }        return { priority };      }    }),  ],};
```

## Setting Redis Prefix​


[​](#setting-redis-prefix)By default, the underlying BullMQ library will use the default Redis key prefix of bull. This can be changed by setting the prefix option
in the queueOptions and workerOptions objects:

```
BullMQJobQueuePlugin.init({  workerOptions: {    prefix: 'my-prefix'  },  queueOptions: {    prefix: 'my-prefix'  }}),
```

```
class BullMQJobQueuePlugin {    static options: BullMQPluginOptions;    init(options: BullMQPluginOptions) => ;}
```

### options​


[​](#options)[BullMQPluginOptions](/reference/core-plugins/job-queue-plugin/bull-mqplugin-options#bullmqpluginoptions)
### init​


[​](#init)[BullMQPluginOptions](/reference/core-plugins/job-queue-plugin/bull-mqplugin-options#bullmqpluginoptions)Configures the plugin.


---

# BullMQJobQueueStrategy


## BullMQJobQueueStrategy​


[​](#bullmqjobqueuestrategy)[@vendure/job-queue-plugin](https://www.npmjs.com/package/@vendure/job-queue-plugin)[bullmq-job-queue-strategy.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/job-queue-plugin/src/bullmq/bullmq-job-queue-strategy.ts#L53)This JobQueueStrategy uses BullMQ to implement a push-based job queue
on top of Redis. It should not be used alone, but as part of the BullMQJobQueuePlugin.

[BullMQ](https://docs.bullmq.io/)[BullMQJobQueuePlugin](/reference/core-plugins/job-queue-plugin/bull-mqjob-queue-plugin#bullmqjobqueueplugin)Note: To use this strategy, you need to manually install the bullmq package:

```
npm install bullmq@^5.4.2
```

```
class BullMQJobQueueStrategy implements InspectableJobQueueStrategy {    init(injector: Injector) => Promise<void>;    destroy() => ;    add(job: Job<Data>) => Promise<Job<Data>>;    cancelJob(jobId: string) => Promise<Job | undefined>;    findMany(options?: JobListOptions) => Promise<PaginatedList<Job>>;    findManyById(ids: ID[]) => Promise<Job[]>;    findOne(id: ID) => Promise<Job | undefined>;    removeSettledJobs(queueNames?: string[], olderThan?: Date) => Promise<number>;    start(queueName: string, process: (job: Job<Data>) => Promise<any>) => Promise<void>;    stop(queueName: string, process: (job: Job<Data>) => Promise<any>) => Promise<void>;}
```

- Implements: InspectableJobQueueStrategy

### init​


[​](#init)
### destroy​


[​](#destroy)
### add​


[​](#add)
### cancelJob​


[​](#canceljob)
### findMany​


[​](#findmany)
### findManyById​


[​](#findmanybyid)
### findOne​


[​](#findone)
### removeSettledJobs​


[​](#removesettledjobs)
### start​


[​](#start)
### stop​


[​](#stop)


---

# BullMQPluginOptions


## BullMQPluginOptions​


[​](#bullmqpluginoptions)[@vendure/job-queue-plugin](https://www.npmjs.com/package/@vendure/job-queue-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/job-queue-plugin/src/bullmq/types.ts#L21)Configuration options for the BullMQJobQueuePlugin.

[BullMQJobQueuePlugin](/reference/core-plugins/job-queue-plugin/bull-mqjob-queue-plugin#bullmqjobqueueplugin)
```
interface BullMQPluginOptions {    connection?: ConnectionOptions;    queueOptions?: Omit<QueueOptions, 'connection'>;    workerOptions?: Omit<WorkerOptions, 'connection'>;    setRetries?: (queueName: string, job: Job) => number;    setBackoff?: (queueName: string, job: Job) => BackoffOptions | undefined;    setJobOptions?: (queueName: string, job: Job) => BullJobsOptions;}
```

### connection​


[​](#connection)Connection options which will be passed directly to BullMQ when
creating a new Queue, Worker and Scheduler instance.

If omitted, it will attempt to connect to Redis at 127.0.0.1:6379.

### queueOptions​


[​](#queueoptions)Additional options used when instantiating the BullMQ
Queue instance.
See the BullMQ QueueOptions docs

[BullMQ QueueOptions docs](https://github.com/taskforcesh/bullmq/blob/master/docs/gitbook/api/bullmq.queueoptions.md)
### workerOptions​


[​](#workeroptions)Additional options used when instantiating the BullMQ
Worker instance.
See the BullMQ WorkerOptions docs

[BullMQ WorkerOptions docs](https://github.com/taskforcesh/bullmq/blob/master/docs/gitbook/api/bullmq.workeroptions.md)
### setRetries​


[​](#setretries)When a job is added to the JobQueue using JobQueue.add(), the calling
code may specify the number of retries in case of failure. This option allows
you to override that number and specify your own number of retries based on
the job being added.

Example

```
setRetries: (queueName, job) => {  if (queueName === 'send-email') {    // Override the default number of retries    // for the 'send-email' job because we have    // a very unreliable email service.    return 10;  }  return job.retries;}
```

### setBackoff​


[​](#setbackoff)[BackoffOptions](/reference/core-plugins/job-queue-plugin/bull-mqplugin-options#backoffoptions)This allows you to specify the backoff settings when a failed job gets retried.
In other words, this determines how much time should pass before attempting to
process the failed job again. If the function returns undefined, the default
value of exponential/1000ms will be used.

Example

```
setBackoff: (queueName, job) => {  return {    type: 'exponential', // or 'fixed'    delay: 10000 // first retry after 10s, second retry after 20s, 40s,...  };}
```

### setJobOptions​


[​](#setjoboptions)This allows you to specify additional options for a job when it is added to the queue.
The object returned is the BullMQ JobsOptions
type, which includes control over settings such as delay, attempts, priority and much more.

[JobsOptions](https://api.docs.bullmq.io/types/v5.JobsOptions.html)This function is called every time a job is added to the queue, so you can return different options
based on the job being added.

Example

```
// Here we want to assign a higher priority to jobs in the 'critical' queuesetJobOptions: (queueName, job) => {  const priority = queueName === 'critical' ? 1 : 5;  return { priority };}
```

## BackoffOptions​


[​](#backoffoptions)[@vendure/job-queue-plugin](https://www.npmjs.com/package/@vendure/job-queue-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/job-queue-plugin/src/bullmq/types.ts#L122)Configuration for the backoff function when retrying failed jobs.

```
interface BackoffOptions {    type: 'exponential' | 'fixed';    delay: number;}
```

### type​


[​](#type)
### delay​


[​](#delay)


---

# PubSubJobQueueStrategy


## PubSubJobQueueStrategy​


[​](#pubsubjobqueuestrategy)[@vendure/job-queue-plugin](https://www.npmjs.com/package/@vendure/job-queue-plugin)[pub-sub-job-queue-strategy.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/job-queue-plugin/src/pub-sub/pub-sub-job-queue-strategy.ts#L29)This JobQueueStrategy uses Google Cloud Pub/Sub to implement a job queue for Vendure.
It should not be used alone, but as part of the PubSubPlugin.

[PubSubPlugin](/reference/core-plugins/job-queue-plugin/pub-sub-plugin#pubsubplugin)Note: To use this strategy, you need to manually install the @google-cloud/pubsub package:

```
npm install```ts title="Signature"class PubSubJobQueueStrategy extends InjectableJobQueueStrategy implements JobQueueStrategy {    init(injector: Injector) => ;    destroy() => ;    add(job: Job<Data>) => Promise<Job<Data>>;    start(queueName: string, process: (job: Job<Data>) => Promise<any>) => ;    stop(queueName: string, process: (job: Job<Data>) => Promise<any>) => ;}
```

- Extends: InjectableJobQueueStrategy
- Implements: JobQueueStrategy

Extends: InjectableJobQueueStrategy

Implements: JobQueueStrategy

### init​


[​](#init)
### destroy​


[​](#destroy)
### add​


[​](#add)
### start​


[​](#start)
### stop​


[​](#stop)


---

# PubSubPlugin


## PubSubPlugin​


[​](#pubsubplugin)[@vendure/job-queue-plugin](https://www.npmjs.com/package/@vendure/job-queue-plugin)[plugin.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/job-queue-plugin/src/pub-sub/plugin.ts#L22)This plugin uses Google Cloud Pub/Sub to implement a job queue strategy for Vendure.

## Installation​


[​](#installation)Note: To use this plugin, you need to manually install the @google-cloud/pubsub package:

```
npm install```ts title="Signature"class PubSubPlugin {    init(options: PubSubOptions) => Type<PubSubPlugin>;}
```

### init​


[​](#init)[PubSubPlugin](/reference/core-plugins/job-queue-plugin/pub-sub-plugin#pubsubplugin)


---

# BraintreePlugin


## BraintreePlugin​


[​](#braintreeplugin)[@vendure/payments-plugin](https://www.npmjs.com/package/@vendure/payments-plugin)[braintree.plugin.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/payments-plugin/src/braintree/braintree.plugin.ts#L241)This plugin enables payments to be processed by Braintree, a popular payment provider.

[Braintree](https://www.braintreepayments.com/)
## Requirements​


[​](#requirements)- You will need to create a Braintree sandbox account as outlined in https://developers.braintreepayments.com/start/overview.
- Then install braintree and @types/braintree from npm. This plugin was written with v3.x of the Braintree lib.
yarn add @vendure/payments-plugin braintreeyarn add -D @types/braintree
or
npm install @vendure/payments-plugin braintreenpm install -D @types/braintree

[https://developers.braintreepayments.com/start/overview](https://developers.braintreepayments.com/start/overview)
```
yarn add @vendure/payments-plugin braintreeyarn add -D @types/braintree
```

```
npm install @vendure/payments-plugin braintreenpm install -D @types/braintree
```

## Setup​


[​](#setup)- Add the plugin to your VendureConfig plugins array:
import { BraintreePlugin } from '@vendure/payments-plugin/package/braintree';import { Environment } from 'braintree';// ...plugins: [  BraintreePlugin.init({    environment: Environment.Sandbox,    // This allows saving customer payment    // methods with Braintree (see "vaulting"    // section below for details)    storeCustomersInBraintree: true,  }),]
- Create a new PaymentMethod in the Admin UI, and select "Braintree payments" as the handler.
- Fill in the Merchant ID, Public Key & Private Key from your Braintree sandbox account.

```
import { BraintreePlugin } from '@vendure/payments-plugin/package/braintree';import { Environment } from 'braintree';// ...plugins: [  BraintreePlugin.init({    environment: Environment.Sandbox,    // This allows saving customer payment    // methods with Braintree (see "vaulting"    // section below for details)    storeCustomersInBraintree: true,  }),]
```

## Storefront usage​


[​](#storefront-usage)The plugin is designed to work with the Braintree drop-in UI.
This is a library provided by Braintree which will handle the payment UI for you. You can install it in your storefront project
with:

[Braintree drop-in UI](https://developers.braintreepayments.com/guides/drop-in/overview/javascript/v3)
```
yarn add braintree-web-drop-in# ornpm install braintree-web-drop-in

```

The high-level workflow is:

- Generate a "client token" on the server by executing the generateBraintreeClientToken mutation which is exposed by this plugin.
- Use this client token to instantiate the Braintree Dropin UI.
- Listen for the "paymentMethodRequestable" event which emitted by the Dropin.
- Use the Dropin's requestPaymentMethod() method to get the required payment metadata.
- Pass that metadata to the addPaymentToOrder mutation. The metadata should be an object of type { nonce: string; }

Here is an example of how your storefront code will look. Note that this example is attempting to
be framework-agnostic, so you'll need to adapt it to fit to your framework of choice.

```
// The Braintree Dropin instancelet dropin: import('braintree-web-drop-in').Dropin;// Used to show/hide a "submit" button, which would be bound to the// `submitPayment()` method below.let showSubmitButton = false;// Used to display a "processing..." spinnerlet processing = false;//// This method would be invoked when the payment screen is mounted/created.//async function renderDropin(order: Order, clientToken: string) {  // Lazy load braintree dropin because it has a reference  // to `window` which breaks SSR  dropin = await import('braintree-web-drop-in').then((module) =>    module.default.create({      authorization: clientToken,      // This assumes a div in your view with the corresponding ID      container: '#dropin-container',      card: {        cardholderName: {            required: true,        },        overrides: {},      },      // Additional config is passed here depending on      // which payment methods you have enabled in your      // Braintree account.      paypal: {        flow: 'checkout',        amount: order.totalWithTax / 100,        currency: 'GBP',      },    }),  );  // If you are using the `storeCustomersInBraintree` option, then the  // customer might already have a stored payment method selected as  // soon as the dropin script loads. In this case, show the submit  // button immediately.  if (dropin.isPaymentMethodRequestable()) {    showSubmitButton = true;  }  dropin.on('paymentMethodRequestable', (payload) => {    if (payload.type === 'CreditCard') {      showSubmitButton = true;    }    if (payload.type === 'PayPalAccount') {      this.submitPayment();    }  });  dropin.on('noPaymentMethodRequestable', () => {    // Display an error  });}async function generateClientToken() {  const { generateBraintreeClientToken } = await graphQlClient.query(gql`    query GenerateBraintreeClientToken {      generateBraintreeClientToken    }  `);  return generateBraintreeClientToken;}async submitPayment() {  if (!dropin.isPaymentMethodRequestable()) {    return;  }  showSubmitButton = false;  processing = true;  const paymentResult = await dropin.requestPaymentMethod();  const { addPaymentToOrder } = await graphQlClient.query(gql`    mutation AddPayment($input: PaymentInput!) {      addPaymentToOrder(input: $input) {        ... on Order {          id          payments {            id            amount            errorMessage            method            state            transactionId            createdAt          }        }        ... on ErrorResult {          errorCode          message        }      }    }`, {      input: {        method: 'braintree', // The code of you Braintree PaymentMethod        metadata: paymentResult,      },    },  );  switch (addPaymentToOrder?.__typename) {      case 'Order':          // Adding payment succeeded!          break;      case 'OrderStateTransitionError':      case 'OrderPaymentStateError':      case 'PaymentDeclinedError':      case 'PaymentFailedError':        // Display an error to the customer        dropin.clearSelectedPaymentMethod();  }}
```

## Storing payment details (vaulting)​


[​](#storing-payment-details-vaulting)Braintree has a vault feature which allows the secure storage
of customer's payment information. Using the vault allows you to offer a faster checkout for repeat customers without needing to worry about
how to securely store payment details.

[vault feature](https://developer.paypal.com/braintree/articles/control-panel/vault/overview)To enable this feature, set the storeCustomersInBraintree option to true.

```
BraintreePlugin.init({  environment: Environment.Sandbox,  storeCustomersInBraintree: true,}),
```

Since v1.8, it is possible to override vaulting on a per-payment basis by passing includeCustomerId: false to the generateBraintreeClientToken
mutation:

```
const { generateBraintreeClientToken } = await graphQlClient.query(gql`  query GenerateBraintreeClientToken($includeCustomerId: Boolean) {    generateBraintreeClientToken(includeCustomerId: $includeCustomerId)  }`, { includeCustomerId: false });
```

as well as in the metadata of the addPaymentToOrder mutation:

```
const { addPaymentToOrder } = await graphQlClient.query(gql`  mutation AddPayment($input: PaymentInput!) {    addPaymentToOrder(input: $input) {      ...Order      ...ErrorResult    }  }`, {    input: {      method: 'braintree',      metadata: {        ...paymentResult,        includeCustomerId: false,      },    }  );
```

```
class BraintreePlugin {    static options: BraintreePluginOptions = {};    init(options: BraintreePluginOptions) => Type<BraintreePlugin>;}
```

### options​


[​](#options)[BraintreePluginOptions](/reference/core-plugins/payments-plugin/braintree-plugin#braintreepluginoptions)
### init​


[​](#init)[BraintreePluginOptions](/reference/core-plugins/payments-plugin/braintree-plugin#braintreepluginoptions)[BraintreePlugin](/reference/core-plugins/payments-plugin/braintree-plugin#braintreeplugin)
## BraintreePluginOptions​


[​](#braintreepluginoptions)[@vendure/payments-plugin](https://www.npmjs.com/package/@vendure/payments-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/payments-plugin/src/braintree/types.ts#L25)Options for the Braintree plugin.

```
interface BraintreePluginOptions {    environment?: Environment;    storeCustomersInBraintree?: boolean;    extractMetadata?: (transaction: Transaction) => PaymentMetadata;}
```

### environment​


[​](#environment)The Braintree environment being targeted, e.g. sandbox or production.

### storeCustomersInBraintree​


[​](#storecustomersinbraintree)If set to true, a Customer object
will be created in Braintree, which allows the secure storage ("vaulting") of previously-used payment methods.
This is done by adding a custom field to the Customer entity to store the Braintree customer ID,
so switching this on will require a database migration / synchronization.

[Customer](https://developer.paypal.com/braintree/docs/guides/customers)Since v1.8, it is possible to override vaulting on a per-payment basis by passing includeCustomerId: false to the
generateBraintreeClientToken mutation.

### extractMetadata​


[​](#extractmetadata)[Transaction](/reference/typescript-api/request/transaction-decorator#transaction)Allows you to configure exactly what information from the Braintree
Transaction object (which is returned by the
transaction.sale() method of the SDK) should be persisted to the resulting Payment entity metadata.

[Transaction object](https://developer.paypal.com/braintree/docs/reference/response/transaction#result-object)By default, the built-in extraction function will return a metadata object that looks like this:

Example

```
const metadata = {  "status": "settling",  "currencyIsoCode": "GBP",  "merchantAccountId": "my_account_id",  "cvvCheck": "Not Applicable",  "avsPostCodeCheck": "Not Applicable",  "avsStreetAddressCheck": "Not Applicable",  "processorAuthorizationCode": null,  "processorResponseText": "Approved",  // for Paypal payments  "paymentMethod": "paypal_account",  "paypalData": {    "payerEmail": "michael-buyer@paypalsandbox.com",    "paymentId": "PAYID-MLCXYNI74301746XK8807043",    "authorizationId": "3BU93594D85624939",    "payerStatus": "VERIFIED",    "sellerProtectionStatus": "ELIGIBLE",    "transactionFeeAmount": "0.54"  },  // for credit card payments  "paymentMethod": "credit_card",  "cardData": {    "cardType": "MasterCard",    "last4": "5454",    "expirationDate": "02/2023"  }  // publicly-available metadata that will be  // readable from the Shop API  "public": {    "cardData": {      "cardType": "MasterCard",      "last4": "5454",      "expirationDate": "02/2023"    },    "paypalData": {      "authorizationId": "3BU93594D85624939",    }  }}
```


---

# MolliePlugin


## MolliePlugin​


[​](#mollieplugin)[@vendure/payments-plugin](https://www.npmjs.com/package/@vendure/payments-plugin)[mollie.plugin.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/payments-plugin/src/mollie/mollie.plugin.ts#L195)Plugin to enable payments through the Mollie platform.
This plugin uses the Order API from Mollie, not the Payments API.

[Mollie platform](https://docs.mollie.com/)
## Requirements​


[​](#requirements)- You will need to create a Mollie account and get your apiKey in the dashboard.
- Install the Payments plugin and the Mollie client:
yarn add @vendure/payments-plugin @mollie/api-client
or
npm install @vendure/payments-plugin @mollie/api-client

You will need to create a Mollie account and get your apiKey in the dashboard.

Install the Payments plugin and the Mollie client:

yarn add @vendure/payments-plugin @mollie/api-client

or

npm install @vendure/payments-plugin @mollie/api-client

## Setup​


[​](#setup)- Add the plugin to your VendureConfig plugins array:
import { MolliePlugin } from '@vendure/payments-plugin/package/mollie';// ...plugins: [  MolliePlugin.init({ vendureHost: 'https://yourhost.io/' }),]
- Create a new PaymentMethod in the Admin UI, and select "Mollie payments" as the handler.
- Set your Mollie apiKey in the API Key field.
- Set the Fallback redirectUrl to the url that the customer should be redirected to after completing the payment.
You can override this url by passing the redirectUrl as an argument to the createMolliePaymentIntent mutation.

```
import { MolliePlugin } from '@vendure/payments-plugin/package/mollie';// ...plugins: [  MolliePlugin.init({ vendureHost: 'https://yourhost.io/' }),]
```

## Storefront usage​


[​](#storefront-usage)In your storefront you add a payment to an order using the createMolliePaymentIntent mutation. In this example, our Mollie
PaymentMethod was given the code "mollie-payment-method". The `redirectUrl``is the url that is used to redirect the end-user
back to your storefront after completing the payment.

```
mutation CreateMolliePaymentIntent {  createMolliePaymentIntent(input: {    redirectUrl: "https://storefront/order/1234XYZ" // Optional, the fallback redirect url set in the admin UI will be used if not provided    paymentMethodCode: "mollie-payment-method" // Optional, the first method with Mollie as handler will be used if not provided    molliePaymentMethodCode: "ideal", // Optional argument to skip the method selection in the hosted checkout    locale: "nl_NL", // Optional, the browser language will be used by Mollie if not provided    immediateCapture: true, // Optional, default is true, set to false if you expect the order fulfillment to take longer than 24 hours  }) {         ... on MolliePaymentIntent {              url          }         ... on MolliePaymentIntentError {              errorCode              message         }  }}
```

The response will contain
a redirectUrl, which can be used to redirect your customer to the Mollie
platform.

'molliePaymentMethodCode' is an optional parameter that can be passed to skip Mollie's hosted payment method selection screen
You can get available Mollie payment methods with the following query:

```
{ molliePaymentMethods(input: { paymentMethodCode: "mollie-payment-method" }) {   id   code   description   minimumAmount {     value     currency   }   maximumAmount {     value     currency   }   image {     size1x     size2x     svg   } }}
```

After completing payment on the Mollie platform,
the user is redirected to the redirect url that was provided in the createMolliePaymentIntent mutation, e.g. https://storefront/order/CH234X5

## Pay later methods​


[​](#pay-later-methods)Mollie supports pay-later methods like 'Klarna Pay Later'. Pay-later methods are captured immediately after payment.

If your order fulfillment time is longer than 24 hours You should pass immediateCapture=false to the createMolliePaymentIntent mutation.
This will transition your order to 'PaymentAuthorized' after the Mollie hosted checkout.
You need to manually capture the payment after the order is fulfilled, by settling existing payments, either via the admin UI or in custom code.

Make sure to capture a payment within 28 days, after that the payment will be automaticallreleased.
See the Mollie documentation
for more information.

[Mollie documentation](https://docs.mollie.com/docs/place-a-hold-for-a-payment#authorization-expiration-window)
## ArrangingAdditionalPayment state​


[​](#arrangingadditionalpayment-state)In some rare cases, a customer can add items to the active order, while a Mollie checkout is still open,
for example by opening your storefront in another browser tab.
This could result in an order being in ArrangingAdditionalPayment status after the customer finished payment.
You should check if there is still an active order with status ArrangingAdditionalPayment on your order confirmation page,
and if so, allow your customer to pay for the additional items by creating another Mollie payment.

```
class MolliePlugin {    static options: MolliePluginOptions;    init(options: MolliePluginOptions) => typeof MolliePlugin;}
```

### options​


[​](#options)[MolliePluginOptions](/reference/core-plugins/payments-plugin/mollie-plugin#molliepluginoptions)
### init​


[​](#init)[MolliePluginOptions](/reference/core-plugins/payments-plugin/mollie-plugin#molliepluginoptions)[MolliePlugin](/reference/core-plugins/payments-plugin/mollie-plugin#mollieplugin)Initialize the mollie payment plugin

## MolliePluginOptions​


[​](#molliepluginoptions)[@vendure/payments-plugin](https://www.npmjs.com/package/@vendure/payments-plugin)[mollie.plugin.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/payments-plugin/src/mollie/mollie.plugin.ts#L28)Configuration options for the Mollie payments plugin.

```
interface MolliePluginOptions {    vendureHost: string;    enabledPaymentMethodsParams?: (        injector: Injector,        ctx: RequestContext,        order: Order | null,    ) => AdditionalEnabledPaymentMethodsParams | Promise<AdditionalEnabledPaymentMethodsParams>;}
```

### vendureHost​


[​](#vendurehost)The host of your Vendure server, e.g. 'https://my-vendure.io'.
This is used by Mollie to send webhook events to the Vendure server

### enabledPaymentMethodsParams​


[​](#enabledpaymentmethodsparams)[Injector](/reference/typescript-api/common/injector#injector)[RequestContext](/reference/typescript-api/request/request-context#requestcontext)[Order](/reference/typescript-api/entities/order#order)Provide additional parameters to the Mollie enabled payment methods API call. By default,
the plugin will already pass the resource parameter.

For example, if you want to provide a locale and billingCountry for the API call, you can do so like this:

Note: The order argument is possibly null, this could happen when you fetch the available payment methods
before the order is created.

Example

```
import { VendureConfig } from '@vendure/core';import { MolliePlugin, getLocale } from '@vendure/payments-plugin/package/mollie';export const config: VendureConfig = {  // ...  plugins: [    MolliePlugin.init({      enabledPaymentMethodsParams: (injector, ctx, order) => {        const locale = order?.billingAddress?.countryCode            ? getLocale(order.billingAddress.countryCode, ctx.languageCode)            : undefined;        return {          locale,          billingCountry: order?.billingAddress?.countryCode,        },      }    }),  ],};
```


---

# StripePlugin


## StripePlugin​


[​](#stripeplugin)[@vendure/payments-plugin](https://www.npmjs.com/package/@vendure/payments-plugin)[stripe.plugin.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/payments-plugin/src/stripe/stripe.plugin.ts#L160)Plugin to enable payments through Stripe via the Payment Intents API.

[Stripe](https://stripe.com/docs)
## Requirements​


[​](#requirements)- You will need to create a Stripe account and get your secret key in the dashboard.
- Create a webhook endpoint in the Stripe dashboard (Developers -> Webhooks, "Add an endpoint") which listens to the payment_intent.succeeded
and payment_intent.payment_failed events. The URL should be https://my-server.com/payments/stripe, where
my-server.com is the host of your Vendure server. Note: for local development, you'll need to use
the Stripe CLI to test your webhook locally. See the local development section below.
- Get the signing secret for the newly created webhook.
- Install the Payments plugin and the Stripe Node library:
yarn add @vendure/payments-plugin stripe
or
npm install @vendure/payments-plugin stripe

You will need to create a Stripe account and get your secret key in the dashboard.

Create a webhook endpoint in the Stripe dashboard (Developers -> Webhooks, "Add an endpoint") which listens to the payment_intent.succeeded
and payment_intent.payment_failed events. The URL should be https://my-server.com/payments/stripe, where
my-server.com is the host of your Vendure server. Note: for local development, you'll need to use
the Stripe CLI to test your webhook locally. See the local development section below.

Get the signing secret for the newly created webhook.

Install the Payments plugin and the Stripe Node library:

yarn add @vendure/payments-plugin stripe

or

npm install @vendure/payments-plugin stripe

## Setup​


[​](#setup)- Add the plugin to your VendureConfig plugins array:
import { StripePlugin } from '@vendure/payments-plugin/package/stripe';// ...plugins: [  StripePlugin.init({    // This prevents different customers from using the same PaymentIntent    storeCustomersInStripe: true,  }),]
For all the plugin options, see the StripePluginOptions type.
- Create a new PaymentMethod in the Admin UI, and select "Stripe payments" as the handler.
- Set the webhook secret and API key in the PaymentMethod form.

```
import { StripePlugin } from '@vendure/payments-plugin/package/stripe';// ...plugins: [  StripePlugin.init({    // This prevents different customers from using the same PaymentIntent    storeCustomersInStripe: true,  }),]
```

[StripePluginOptions](/reference/core-plugins/payments-plugin/stripe-plugin#stripepluginoptions)
## Storefront usage​


[​](#storefront-usage)The plugin is designed to work with the Custom payment flow.
In this flow, Stripe provides libraries which handle the payment UI and confirmation for you. You can install it in your storefront project
with:

[Custom payment flow](https://stripe.com/docs/payments/accept-a-payment?platform=web&ui=elements)
```
yarn add @stripe/stripe-js# ornpm install @stripe/stripe-js

```

If you are using React, you should also consider installing @stripe/react-stripe-js, which is a wrapper around Stripe Elements.

The high-level workflow is:

- Create a "payment intent" on the server by executing the createStripePaymentIntent mutation which is exposed by this plugin.
- Use the returned client secret to instantiate the Stripe Payment Element:
import { Elements } from '@stripe/react-stripe-js';import { loadStripe, Stripe } from '@stripe/stripe-js';import { CheckoutForm } from './CheckoutForm';const stripePromise = getStripe('pk_test_....wr83u');type StripePaymentsProps = {  clientSecret: string;  orderCode: string;}export function StripePayments({ clientSecret, orderCode }: StripePaymentsProps) {  const options = {    // passing the client secret obtained from the server    clientSecret,  }  return (    <Elements stripe={stripePromise} options={options}>      <CheckoutForm orderCode={orderCode} />    </Elements>  );}
// CheckoutForm.tsximport { useStripe, useElements, PaymentElement } from '@stripe/react-stripe-js';import { FormEvent } from 'react';export const CheckoutForm = ({ orderCode }: { orderCode: string }) => {  const stripe = useStripe();  const elements = useElements();  const handleSubmit = async (event: FormEvent) => {    // We don't want to let default form submission happen here,    // which would refresh the page.    event.preventDefault();    if (!stripe || !elements) {      // Stripe.js has not yet loaded.      // Make sure to disable form submission until Stripe.js has loaded.      return;    }    const result = await stripe.confirmPayment({      //`Elements` instance that was used to create the Payment Element      elements,      confirmParams: {        return_url: location.origin + `/checkout/confirmation/${orderCode}`,      },    });    if (result.error) {      // Show error to your customer (for example, payment details incomplete)      console.log(result.error.message);    } else {      // Your customer will be redirected to your `return_url`. For some payment      // methods like iDEAL, your customer will be redirected to an intermediate      // site first to authorize the payment, then redirected to the `return_url`.    }  };  return (    <form onSubmit={handleSubmit}>      <PaymentElement />      <button disabled={!stripe}>Submit</button>    </form>  );};
- Once the form is submitted and Stripe processes the payment, the webhook takes care of updating the order without additional action
in the storefront. As in the code above, the customer will be redirected to /checkout/confirmation/${orderCode}.

```
import { Elements } from '@stripe/react-stripe-js';import { loadStripe, Stripe } from '@stripe/stripe-js';import { CheckoutForm } from './CheckoutForm';const stripePromise = getStripe('pk_test_....wr83u');type StripePaymentsProps = {  clientSecret: string;  orderCode: string;}export function StripePayments({ clientSecret, orderCode }: StripePaymentsProps) {  const options = {    // passing the client secret obtained from the server    clientSecret,  }  return (    <Elements stripe={stripePromise} options={options}>      <CheckoutForm orderCode={orderCode} />    </Elements>  );}
```

```
// CheckoutForm.tsximport { useStripe, useElements, PaymentElement } from '@stripe/react-stripe-js';import { FormEvent } from 'react';export const CheckoutForm = ({ orderCode }: { orderCode: string }) => {  const stripe = useStripe();  const elements = useElements();  const handleSubmit = async (event: FormEvent) => {    // We don't want to let default form submission happen here,    // which would refresh the page.    event.preventDefault();    if (!stripe || !elements) {      // Stripe.js has not yet loaded.      // Make sure to disable form submission until Stripe.js has loaded.      return;    }    const result = await stripe.confirmPayment({      //`Elements` instance that was used to create the Payment Element      elements,      confirmParams: {        return_url: location.origin + `/checkout/confirmation/${orderCode}`,      },    });    if (result.error) {      // Show error to your customer (for example, payment details incomplete)      console.log(result.error.message);    } else {      // Your customer will be redirected to your `return_url`. For some payment      // methods like iDEAL, your customer will be redirected to an intermediate      // site first to authorize the payment, then redirected to the `return_url`.    }  };  return (    <form onSubmit={handleSubmit}>      <PaymentElement />      <button disabled={!stripe}>Submit</button>    </form>  );};
```

A full working storefront example of the Stripe integration can be found in the
Remix Starter repo

[Remix Starter repo](https://github.com/vendure-ecommerce/storefront-remix-starter/tree/master/app/components/checkout/stripe)
## Local development​


[​](#local-development)- Download & install the Stripe CLI: https://stripe.com/docs/stripe-cli
- From your Stripe dashboard, go to Developers -> Webhooks and click "Add an endpoint" and follow the instructions
under "Test in a local environment".
- The Stripe CLI command will look like
stripe listen --forward-to localhost:3000/payments/stripe
- The Stripe CLI will create a webhook signing secret you can then use in your config of the StripePlugin.

[https://stripe.com/docs/stripe-cli](https://stripe.com/docs/stripe-cli)
```
stripe listen --forward-to localhost:3000/payments/stripe
```

```
class StripePlugin {    static options: StripePluginOptions;    init(options: StripePluginOptions) => Type<StripePlugin>;}
```

### options​


[​](#options)[StripePluginOptions](/reference/core-plugins/payments-plugin/stripe-plugin#stripepluginoptions)
### init​


[​](#init)[StripePluginOptions](/reference/core-plugins/payments-plugin/stripe-plugin#stripepluginoptions)[StripePlugin](/reference/core-plugins/payments-plugin/stripe-plugin#stripeplugin)Initialize the Stripe payment plugin

## StripePluginOptions​


[​](#stripepluginoptions)[@vendure/payments-plugin](https://www.npmjs.com/package/@vendure/payments-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/payments-plugin/src/stripe/types.ts#L29)Configuration options for the Stripe payments plugin.

```
interface StripePluginOptions {    storeCustomersInStripe?: boolean;    metadata?: (        injector: Injector,        ctx: RequestContext,        order: Order,    ) => Stripe.MetadataParam | Promise<Stripe.MetadataParam>;    paymentIntentCreateParams?: (        injector: Injector,        ctx: RequestContext,        order: Order,    ) => AdditionalPaymentIntentCreateParams | Promise<AdditionalPaymentIntentCreateParams>;    requestOptions?: (        injector: Injector,        ctx: RequestContext,        order: Order,    ) => AdditionalRequestOptions | Promise<AdditionalRequestOptions>;    customerCreateParams?: (        injector: Injector,        ctx: RequestContext,        order: Order,    ) => AdditionalCustomerCreateParams | Promise<AdditionalCustomerCreateParams>;    skipPaymentIntentsWithoutExpectedMetadata?: boolean;}
```

### storeCustomersInStripe​


[​](#storecustomersinstripe)If set to true, a Customer object will be created in Stripe - if
it doesn't already exist - for authenticated users, which prevents payment methods attached to other Customers
to be used with the same PaymentIntent. This is done by adding a custom field to the Customer entity to store
the Stripe customer ID, so switching this on will require a database migration / synchronization.

[Customer](https://stripe.com/docs/api/customers)
### metadata​


[​](#metadata)[Injector](/reference/typescript-api/common/injector#injector)[RequestContext](/reference/typescript-api/request/request-context#requestcontext)[Order](/reference/typescript-api/entities/order#order)Attach extra metadata to Stripe payment intent creation call.

Example

```
import { EntityHydrator, VendureConfig } from '@vendure/core';import { StripePlugin } from '@vendure/payments-plugin/package/stripe';export const config: VendureConfig = {  // ...  plugins: [    StripePlugin.init({      metadata: async (injector, ctx, order) => {        const hydrator = injector.get(EntityHydrator);        await hydrator.hydrate(ctx, order, { relations: ['customer'] });        return {          description: `Order #${order.code} for ${order.customer!.emailAddress}`        },      }    }),  ],};
```

Note: If the paymentIntentCreateParams is also used and returns a metadata key, then the values
returned by both functions will be merged.

### paymentIntentCreateParams​


[​](#paymentintentcreateparams)[Injector](/reference/typescript-api/common/injector#injector)[RequestContext](/reference/typescript-api/request/request-context#requestcontext)[Order](/reference/typescript-api/entities/order#order)Provide additional parameters to the Stripe payment intent creation. By default,
the plugin will already pass the amount, currency, customer and automatic_payment_methods: { enabled: true } parameters.

For example, if you want to provide a description for the payment intent, you can do so like this:

Example

```
import { VendureConfig } from '@vendure/core';import { StripePlugin } from '@vendure/payments-plugin/package/stripe';export const config: VendureConfig = {  // ...  plugins: [    StripePlugin.init({      paymentIntentCreateParams: (injector, ctx, order) => {        return {          description: `Order #${order.code} for ${order.customer?.emailAddress}`        },      }    }),  ],};
```

### requestOptions​


[​](#requestoptions)[Injector](/reference/typescript-api/common/injector#injector)[RequestContext](/reference/typescript-api/request/request-context#requestcontext)[Order](/reference/typescript-api/entities/order#order)Provide additional options to the Stripe payment intent creation. By default,
the plugin will already pass the idempotencyKey parameter.

For example, if you want to provide a stripeAccount for the payment intent, you can do so like this:

Example

```
import { VendureConfig } from '@vendure/core';import { StripePlugin } from '@vendure/payments-plugin/package/stripe';export const config: VendureConfig = {  // ...  plugins: [    StripePlugin.init({      requestOptions: (injector, ctx, order) => {        return {          stripeAccount: ctx.channel.seller?.customFields.connectedAccountId        },      }    }),  ],};
```

### customerCreateParams​


[​](#customercreateparams)[Injector](/reference/typescript-api/common/injector#injector)[RequestContext](/reference/typescript-api/request/request-context#requestcontext)[Order](/reference/typescript-api/entities/order#order)Provide additional parameters to the Stripe customer creation. By default,
the plugin will already pass the email and name parameters.

For example, if you want to provide an address for the customer:

Example

```
import { EntityHydrator, VendureConfig } from '@vendure/core';import { StripePlugin } from '@vendure/payments-plugin/package/stripe';export const config: VendureConfig = {  // ...  plugins: [    StripePlugin.init({      storeCustomersInStripe: true,      customerCreateParams: async (injector, ctx, order) => {        const entityHydrator = injector.get(EntityHydrator);        const customer = order.customer;        await entityHydrator.hydrate(ctx, customer, { relations: ['addresses'] });        const defaultBillingAddress = customer.addresses.find(a => a.defaultBillingAddress) ?? customer.addresses[0];        return {          address: {              line1: defaultBillingAddress.streetLine1 || order.shippingAddress?.streetLine1,              postal_code: defaultBillingAddress.postalCode || order.shippingAddress?.postalCode,              city: defaultBillingAddress.city || order.shippingAddress?.city,              state: defaultBillingAddress.province || order.shippingAddress?.province,              country: defaultBillingAddress.country.code || order.shippingAddress?.countryCode,          },        },      }    }),  ],};
```

### skipPaymentIntentsWithoutExpectedMetadata​


[​](#skippaymentintentswithoutexpectedmetadata)If your Stripe account also generates payment intents which are independent of Vendure orders, you can set this
to true to skip processing those payment intents.


---

# SentryPlugin


## SentryPlugin​


[​](#sentryplugin)[@vendure/sentry-plugin](https://www.npmjs.com/package/@vendure/sentry-plugin)[sentry-plugin.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/sentry-plugin/src/sentry-plugin.ts#L146)This plugin integrates the Sentry error tracking & performance monitoring
service with your Vendure server. In addition to capturing errors, it also provides built-in
support for tracing as well as
enriching your Sentry events with additional context about the request.

[Sentry](https://sentry.io)[tracing](https://docs.sentry.io/product/sentry-basics/concepts/tracing/)This documentation applies from v3.5.0 of the plugin, which works differently to previous
versions. Documentation for prior versions can
be found here.

[here](https://github.com/vendure-ecommerce/vendure/blob/1bb9cf8ca1584bce026ccc82f33f866b766ef47d/packages/sentry-plugin/src/sentry-plugin.ts)
## Pre-requisites​


[​](#pre-requisites)This plugin depends on access to Sentry, which can be self-hosted or used as a cloud service.

If using the hosted SaaS option, you must have a Sentry account and a project set up (sign up here). When setting up your project,
select the "Node.js" platform and no framework.

[sign up here](https://sentry.io/signup/)Once set up, you will be given a Data Source Name (DSN)
which you will need to provide to the plugin.

[Data Source Name (DSN)](https://docs.sentry.io/product/sentry-basics/concepts/dsn-explainer/)
## Installation​


[​](#installation)
```
npm install --save @vendure/sentry-plugin
```

## Environment Variables​


[​](#environment-variables)The following environment variables are used to control how the Sentry
integration behaves:

- SENTRY_DSN: (required) Sentry Data Source Name
- SENTRY_TRACES_SAMPLE_RATE: Number between 0 and 1
- SENTRY_PROFILES_SAMPLE_RATE: Number between 0 and 1
- SENTRY_ENABLE_LOGS: Boolean. Captures calls to the console API as logs in Sentry. Default false
- SENTRY_CAPTURE_LOG_LEVELS: 'debug' | 'info' | 'warn' | 'error' | 'log' | 'assert' | 'trace'

## Configuration​


[​](#configuration)Setting up the Sentry plugin requires two steps:

### Step 1: Preload the Sentry instrument file​


[​](#step-1-preload-the-sentry-instrument-file)Make sure the SENTRY_DSN environment variable is defined.

The Sentry SDK must be initialized before your application starts. This is done by preloading
the instrument file when starting your Vendure server:

```
node --import @vendure/sentry-plugin/instrument ./dist/index.js
```

Or if using TypeScript directly with tsx:

```
tsx --import @vendure/sentry-plugin/instrument ./src/index.ts
```

### Step 2: Add the SentryPlugin to your Vendure config​


[​](#step-2-add-the-sentryplugin-to-your-vendure-config)
```
import { VendureConfig } from '@vendure/core';import { SentryPlugin } from '@vendure/sentry-plugin';export const config: VendureConfig = {    // ...    plugins: [        // ...        SentryPlugin.init({            // Optional configuration            includeErrorTestMutation: true,        }),    ],};
```

## Tracing​


[​](#tracing)This plugin includes built-in support for tracing, which allows you to see the performance of your.
To enable tracing, preload the instrument file as described in Step 1.
This ensures that the Sentry SDK is initialized before any other code is executed.

[tracing](https://docs.sentry.io/product/sentry-basics/concepts/tracing/)[Step 1](#step-1-preload-the-sentry-instrument-file)You can also set the tracesSampleRate and profilesSampleRate options to control the sample rate for
tracing and profiling, with the following environment variables:

- SENTRY_TRACES_SAMPLE_RATE
- SENTRY_PROFILES_SAMPLE_RATE

The sample rate for tracing should be between 0 and 1. The sample rate for profiling should be between 0 and 1.

By default, both are set to undefined, which means that tracing and profiling are disabled.

## Instrumenting your own code​


[​](#instrumenting-your-own-code)You may want to add your own custom spans to your code. To do so, you can use the Sentry object
from the @sentry/node package. For example:

```
import * as Sentry from "@sentry/node";export class MyService {    async myMethod() {         Sentry.setContext('My Custom Context,{             key: 'value',         });    }}
```

## Error test mutation​


[​](#error-test-mutation)To test whether your Sentry configuration is working correctly, you can set the includeErrorTestMutation option to true. This will add a mutation to the Admin API
which will throw an error of the type specified in the errorType argument. For example:

```
mutation CreateTestError {    createTestError(errorType: DATABASE_ERROR)}
```

You should then be able to see the error in your Sentry dashboard (it may take a couple of minutes to appear).

```
class SentryPlugin {    static options: SentryPluginOptions = {} as any;    init(options?: SentryPluginOptions) => ;}
```

### options​


[​](#options)[SentryPluginOptions](/reference/core-plugins/sentry-plugin/sentry-plugin-options#sentrypluginoptions)
### init​


[​](#init)[SentryPluginOptions](/reference/core-plugins/sentry-plugin/sentry-plugin-options#sentrypluginoptions)


---

# SentryPluginOptions


## SentryPluginOptions​


[​](#sentrypluginoptions)[@vendure/sentry-plugin](https://www.npmjs.com/package/@vendure/sentry-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/sentry-plugin/src/types.ts#L7)Configuration options for the SentryPlugin.

[SentryPlugin](/reference/core-plugins/sentry-plugin/#sentryplugin)
```
interface SentryPluginOptions {    includeErrorTestMutation?: boolean;}
```

### includeErrorTestMutation​


[​](#includeerrortestmutation)Whether to include the error test mutation in the admin API.
When enabled, a createTestError mutation becomes available in
the Admin API, which can be used to create different types of error
to check that the integration is working correctly.


---

# SentryService


## SentryService​


[​](#sentryservice)[@vendure/sentry-plugin](https://www.npmjs.com/package/@vendure/sentry-plugin)[sentry.service.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/sentry-plugin/src/sentry.service.ts#L13)Service for capturing errors and messages to Sentry.

```
class SentryService {    constructor(options: SentryPluginOptions)    captureException(exception: Error) => ;    captureMessage(message: string, captureContext?: CaptureContext) => ;    startSpan(context: StartSpanOptions) => ;}
```

### constructor​


[​](#constructor)[SentryPluginOptions](/reference/core-plugins/sentry-plugin/sentry-plugin-options#sentrypluginoptions)
### captureException​


[​](#captureexception)
### captureMessage​


[​](#capturemessage)Captures a message

### startSpan​


[​](#startspan)Starts new span


---

# StellatePlugin


## StellatePlugin​


[​](#stellateplugin)[@vendure/stellate-plugin](https://www.npmjs.com/package/@vendure/stellate-plugin)[stellate-plugin.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/stellate-plugin/src/stellate-plugin.ts#L246)A plugin to integrate the Stellate GraphQL caching service with your Vendure server.
The main purpose of this plugin is to ensure that cached data gets correctly purged in
response to events inside Vendure. For example, changes to a Product's description should
purge any associated record for that Product in Stellate's cache.

[Stellate](https://stellate.co/)
## Pre-requisites​


[​](#pre-requisites)You will first need to set up a free Stellate account.

[set up a free Stellate account](https://stellate.co/signup)You will also need to generate an API token for the Stellate Purging API. For instructions on how to generate the token,
see the Stellate Purging API docs.

[Stellate Purging API docs](https://docs.stellate.co/docs/purging-api#authentication)
## Installation​


[​](#installation)
```
npm install @vendure/stellate-plugin
```

## Configuration​


[​](#configuration)The plugin is configured via the StellatePlugin.init() method. This method accepts an options object
which defines the Stellate service name and API token, as well as an array of PurgeRules which
define how the plugin will respond to Vendure events in order to trigger calls to the
Stellate Purging API.

[PurgeRule](/reference/core-plugins/stellate-plugin/purge-rule#purgerule)[Purging API](https://stellate.co/docs/graphql-edge-cache/purging-api)Example

```
import { StellatePlugin, defaultPurgeRules } from '@vendure/stellate-plugin';import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {   // ...   plugins: [       StellatePlugin.init({           // The Stellate service name, i.e. `<serviceName>.stellate.sh`           serviceName: 'my-service',           // The API token for the Stellate Purging API. See the "pre-requisites" section above.           apiToken: process.env.STELLATE_PURGE_API_TOKEN,           devMode: !isProd || process.env.STELLATE_DEBUG_MODE ? true : false,           debugLogging: process.env.STELLATE_DEBUG_MODE ? true : false,           purgeRules: [               ...defaultPurgeRules,               // custom purge rules can be added here           ],       }),   ],};
```

In your Stellate dashboard, you can use the following configuration example as a sensible default for a
Vendure application:

Example

```
import { Config } from "stellate";const config: Config = {  config: {    name: "my-vendure-server",    originUrl: "https://my-vendure-server.com/shop-api",    ignoreOriginCacheControl: true,    passThroughOnly: false,    scopes: {      SESSION_BOUND: "header:authorization|cookie:session",    },    headers: {      "access-control-expose-headers": "vendure-auth-token",    },    rootTypeNames: {      query: "Query",      mutation: "Mutation",    },    keyFields: {      types: {        SearchResult: ["productId"],        SearchResponseCacheIdentifier: ["collectionSlug"],      },    },    rules: [      {        types: [          "Product",          "Collection",          "ProductVariant",          "SearchResponse",        ],        maxAge: 900,        swr: 900,        description: "Cache Products & Collections",      },      {        types: ["Channel"],        maxAge: 9000,        swr: 9000,        description: "Cache active channel",      },      {        types: ["Order", "Customer", "User"],        maxAge: 0,        swr: 0,        description: "Do not cache user data",      },    ],  },};export default config;
```

## Storefront setup​


[​](#storefront-setup)In your storefront, you should point your GraphQL client to the Stellate GraphQL API endpoint, which is
https://<service-name>.stellate.sh.

Wherever you are using the search query (typically in product listing & search pages), you should also add the
cacheIdentifier field to the query. This will ensure that the Stellate cache is correctly purged when
a Product or Collection is updated.

Example

```
import { graphql } from '../generated/gql';export const searchProductsDocument = graphql(`    query SearchProducts($input: SearchInput!) {        search(input: $input) {            cacheIdentifier {                collectionSlug            }            items {               # ...            }        }    }}`);

```

## Custom PurgeRules​


[​](#custom-purgerules)The configuration above only accounts for caching of some of the built-in Vendure entity types. If you have
custom entity types, you may well want to add them to the Stellate cache. In this case, you'll also need a way to
purge those entities from the cache when they are updated. This is where the PurgeRule comes in.

[PurgeRule](/reference/core-plugins/stellate-plugin/purge-rule#purgerule)Let's imagine that you have built a simple CMS plugin for Vendure which exposes an Article entity in your Shop API, and
you have added this to your Stellate configuration:

Example

```
import { Config } from "stellate";const config: Config = {    config: {        // ...        rules: [            // ...            {                types: ["Article"],                maxAge: 900,                swr: 900,                description: "Cache Articles",            },        ],    },    // ...};export default config;
```

You can then add a custom PurgeRule to the StellatePlugin configuration:

[PurgeRule](/reference/core-plugins/stellate-plugin/purge-rule#purgerule)Example

```
import { StellatePlugin, defaultPurgeRules } from "@vendure/stellate-plugin";import { VendureConfig } from "@vendure/core";import { ArticleEvent } from "./plugins/cms/events/article-event";export const config: VendureConfig = {    // ...    plugins: [        StellatePlugin.init({            // ...            purgeRules: [                ...defaultPurgeRules,                new PurgeRule({                    eventType: ArticleEvent,                    handler: async ({ events, stellateService }) => {                        const articleIds = events.map((e) => e.article.id);                        stellateService.purge("Article", articleIds);                    },                }),            ],        }),    ],};
```

## DevMode & Debug Logging​


[​](#devmode--debug-logging)In development, you can set devMode: true, which will prevent any calls being made to the Stellate Purging API.

If you want to log the calls that would be made to the Stellate Purge API when in devMode, you can set debugLogging: true.
Note that debugLogging generates a lot of debug-level logging, so it is recommended to only enable this when needed.

Example

```
import { StellatePlugin, defaultPurgeRules } from '@vendure/stellate-plugin';import { VendureConfig } from '@vendure/core';export const config: VendureConfig = {   // ...   plugins: [       StellatePlugin.init({           // ...           devMode: !process.env.PRODUCTION,           debugLogging: process.env.STELLATE_DEBUG_MODE ? true : false,           purgeRules: [               ...defaultPurgeRules,           ],       }),   ],};
```

```
class StellatePlugin implements OnApplicationBootstrap {    static options: StellatePluginOptions;    init(options: StellatePluginOptions) => ;    constructor(options: StellatePluginOptions, eventBus: EventBus, stellateService: StellateService, moduleRef: ModuleRef)    onApplicationBootstrap() => ;}
```

- Implements: OnApplicationBootstrap

### options​


[​](#options)[StellatePluginOptions](/reference/core-plugins/stellate-plugin/stellate-plugin-options#stellatepluginoptions)
### init​


[​](#init)[StellatePluginOptions](/reference/core-plugins/stellate-plugin/stellate-plugin-options#stellatepluginoptions)
### constructor​


[​](#constructor)[StellatePluginOptions](/reference/core-plugins/stellate-plugin/stellate-plugin-options#stellatepluginoptions)[EventBus](/reference/typescript-api/events/event-bus#eventbus)[StellateService](/reference/core-plugins/stellate-plugin/stellate-service#stellateservice)
### onApplicationBootstrap​


[​](#onapplicationbootstrap)


---

# PurgeRule


## PurgeRule​


[​](#purgerule)[@vendure/stellate-plugin](https://www.npmjs.com/package/@vendure/stellate-plugin)[purge-rule.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/stellate-plugin/src/purge-rule.ts#L49)Defines a rule that listens for a particular VendureEvent and uses that to
make calls to the Stellate Purging API via
the provided StellateService instance.

[Stellate Purging API](https://docs.stellate.co/docs/purging-api)[StellateService](/reference/core-plugins/stellate-plugin/stellate-service#stellateservice)
```
class PurgeRule<Event extends VendureEvent = VendureEvent> {    eventType: Type<Event>    bufferTimeMs: number | undefined    handle(handlerArgs: { events: Event[]; stellateService: StellateService; injector: Injector }) => ;    constructor(config: PurgeRuleConfig<Event>)}
```

### eventType​


[​](#eventtype)
### bufferTimeMs​


[​](#buffertimems)
### handle​


[​](#handle)[StellateService](/reference/core-plugins/stellate-plugin/stellate-service#stellateservice)[Injector](/reference/typescript-api/common/injector#injector)
### constructor​


[​](#constructor)[PurgeRuleConfig](/reference/core-plugins/stellate-plugin/purge-rule#purgeruleconfig)
## PurgeRuleConfig​


[​](#purgeruleconfig)[@vendure/stellate-plugin](https://www.npmjs.com/package/@vendure/stellate-plugin)[purge-rule.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/stellate-plugin/src/purge-rule.ts#L13)Configures a PurgeRule.

[PurgeRule](/reference/core-plugins/stellate-plugin/purge-rule#purgerule)
```
interface PurgeRuleConfig<Event extends VendureEvent> {    eventType: Type<Event>;    bufferTime?: number;    handler: (handlerArgs: {        events: Event[];        stellateService: StellateService;        injector: Injector;    }) => void | Promise<void>;}
```

### eventType​


[​](#eventtype-1)Specifies which VendureEvent will trigger this purge rule.

### bufferTime​


[​](#buffertime)How long to buffer events for in milliseconds before executing the handler. This allows
us to efficiently batch calls to the Stellate Purge API.

### handler​


[​](#handler)[StellateService](/reference/core-plugins/stellate-plugin/stellate-service#stellateservice)[Injector](/reference/typescript-api/common/injector#injector)The function to invoke when the specified event is published. This function should use the
StellateService instance to call the Stellate Purge API.

[StellateService](/reference/core-plugins/stellate-plugin/stellate-service#stellateservice)


---

# StellatePluginOptions


## StellatePluginOptions​


[​](#stellatepluginoptions)[@vendure/stellate-plugin](https://www.npmjs.com/package/@vendure/stellate-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/stellate-plugin/src/types.ts#L9)Configuration options for the StellatePlugin.

```
interface StellatePluginOptions {    serviceName: string;    apiToken: string;    purgeRules: PurgeRule[];    defaultBufferTimeMs?: number;    devMode?: boolean;    debugLogging?: boolean;}
```

### serviceName​


[​](#servicename)The Stellate service name, i.e. <service-name>.stellate.sh

### apiToken​


[​](#apitoken)The Stellate Purging API token. For instructions on how to generate the token,
see the Stellate docs

[Stellate docs](https://docs.stellate.co/docs/purging-api#authentication)
### purgeRules​


[​](#purgerules)[PurgeRule](/reference/core-plugins/stellate-plugin/purge-rule#purgerule)An array of PurgeRule instances which are used to define how the plugin will
respond to Vendure events in order to trigger calls to the Stellate Purging API.

[PurgeRule](/reference/core-plugins/stellate-plugin/purge-rule#purgerule)
### defaultBufferTimeMs​


[​](#defaultbuffertimems)When events are published, the PurgeRules will buffer those events in order to efficiently
batch requests to the Stellate Purging API. You may wish to change the default, e.g. if you are
running in a serverless environment and cannot introduce pauses after the main request has completed.

### devMode​


[​](#devmode)When set to true, calls will not be made to the Stellate Purge API.

### debugLogging​


[​](#debuglogging)If set to true, the plugin will log the calls that would be made
to the Stellate Purge API. Note, this generates a
lot of debug-level logging.


---

# StellateService


## StellateService​


[​](#stellateservice)[@vendure/stellate-plugin](https://www.npmjs.com/package/@vendure/stellate-plugin)[stellate.service.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/stellate-plugin/src/service/stellate.service.ts#L23)The StellateService is used to purge the Stellate cache when certain events occur.

```
class StellateService {    constructor(options: StellatePluginOptions)    purgeProducts(products: Product[]) => ;    purgeProductVariants(productVariants: ProductVariant[]) => ;    purgeSearchResults(items: Array<ProductVariant | Product>) => ;    purgeAllOfType(type: CachedType) => ;    purgeCollections(collections: Collection[]) => ;    purgeSearchResponseCacheIdentifiers(collections: Collection[]) => ;    purge(type: CachedType, keys?: ID[], keyName:  = 'id') => ;}
```

### constructor​


[​](#constructor)[StellatePluginOptions](/reference/core-plugins/stellate-plugin/stellate-plugin-options#stellatepluginoptions)
### purgeProducts​


[​](#purgeproducts)[Product](/reference/typescript-api/entities/product#product)Purges the cache for the given Products.

### purgeProductVariants​


[​](#purgeproductvariants)[ProductVariant](/reference/typescript-api/entities/product-variant#productvariant)Purges the cache for the given ProductVariants.

### purgeSearchResults​


[​](#purgesearchresults)[ProductVariant](/reference/typescript-api/entities/product-variant#productvariant)[Product](/reference/typescript-api/entities/product#product)Purges the cache for SearchResults which contain the given Products or ProductVariants.

### purgeAllOfType​


[​](#purgealloftype)Purges the entire cache for the given type.

### purgeCollections​


[​](#purgecollections)[Collection](/reference/typescript-api/entities/collection#collection)Purges the cache for the given Collections.

### purgeSearchResponseCacheIdentifiers​


[​](#purgesearchresponsecacheidentifiers)[Collection](/reference/typescript-api/entities/collection#collection)Purges the cache of SearchResults for the given Collections based on slug.

### purge​


[​](#purge)[ID](/reference/typescript-api/common/id#id)Purges the cache for the given type and keys.


---

# TelemetryPlugin


## TelemetryPlugin​


[​](#telemetryplugin)[@vendure/telemetry-plugin](https://www.npmjs.com/package/@vendure/telemetry-plugin)[telemetry.plugin.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/telemetry-plugin/src/telemetry.plugin.ts#L107)The TelemetryPlugin is used to instrument the Vendure application and collect telemetry data using
OpenTelemetry.

[OpenTelemetry](https://opentelemetry.io/)
## Installation​


[​](#installation)
```
npm install @vendure/telemetry-plugin
```

For a complete guide to setting up and working with Open Telemetry, see
the Implementing Open Telemetry guide.

[Implementing Open Telemetry guide](/guides/how-to/telemetry/)
## Configuration​


[​](#configuration)The plugin is configured via the TelemetryPlugin.init() method. This method accepts an options object
which defines the OtelLogger options and method hooks.

Example

```
import { VendureConfig } from '@vendure/core';import { TelemetryPlugin, registerMethodHooks } from '@vendure/telemetry-plugin';export const config: VendureConfig = {  // ...  plugins: [    TelemetryPlugin.init({      loggerOptions: {        // Log to the console at the verbose level        logToConsole: LogLevel.Verbose,      },    }),  ],};
```

## Preloading the SDK​


[​](#preloading-the-sdk)In order to use the OpenTelemetry SDK, you must preload it before the Vendure server is started.
This is done by using the --require flag when starting the server with a custom preload script.

Create a file named instrumentation.ts in the root of your project and add the following code:

```
import { OTLPLogExporter } from '@opentelemetry/exporter-logs-otlp-proto';import { OTLPTraceExporter } from '@opentelemetry/exporter-trace-otlp-http';import { BatchLogRecordProcessor } from '@opentelemetry/sdk-logs';import { NodeSDK } from '@opentelemetry/sdk-node';import { BatchSpanProcessor } from '@opentelemetry/sdk-trace-base';import { getSdkConfiguration } from '@vendure/telemetry-plugin/preload';// In this example we are using Loki as the OTLP endpoint for loggingprocess.env.OTEL_EXPORTER_OTLP_ENDPOINT = 'http://localhost:3100/otlp';process.env.OTEL_LOGS_EXPORTER = 'otlp';process.env.OTEL_RESOURCE_ATTRIBUTES = 'service.name=vendure-dev-server';// We are using Jaeger as the OTLP endpoint for tracingconst traceExporter = new OTLPTraceExporter({    url: 'http://localhost:4318/v1/traces',});const logExporter = new OTLPLogExporter();// The getSdkConfiguration method returns a configuration object for the OpenTelemetry Node SDK.// It also performs other configuration tasks such as setting a special environment variable// to enable instrumentation in the Vendure core code.const config = getSdkConfiguration({    config: {        // Pass in any custom configuration options for the Node SDK here        spanProcessors: [new BatchSpanProcessor(traceExporter)],        logRecordProcessors: [new BatchLogRecordProcessor(logExporter)],    },});const sdk = new NodeSDK(config);sdk.start();
```

The server would then be started with the following command:

```
node --require ./dist/instrumentation.js ./dist/server.js
```

or for development with ts-node:

```
npx ts-node --require ./src/instrumentation.ts ./src/server.ts
```

```
class TelemetryPlugin {    static options: TelemetryPluginOptions = {};    constructor(methodHooksService: MethodHooksService, options: TelemetryPluginOptions)    init(options: TelemetryPluginOptions) => ;}
```

### options​


[​](#options)[TelemetryPluginOptions](/reference/core-plugins/telemetry-plugin/telemetry-plugin-options#telemetrypluginoptions)
### constructor​


[​](#constructor)[TelemetryPluginOptions](/reference/core-plugins/telemetry-plugin/telemetry-plugin-options#telemetrypluginoptions)
### init​


[​](#init)[TelemetryPluginOptions](/reference/core-plugins/telemetry-plugin/telemetry-plugin-options#telemetrypluginoptions)


---

# GetSdkConfiguration


## getSdkConfiguration​


[​](#getsdkconfiguration)[@vendure/telemetry-plugin](https://www.npmjs.com/package/@vendure/telemetry-plugin)[instrumentation.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/telemetry-plugin/src/instrumentation.ts#L89)Creates a configuration object for the OpenTelemetry Node SDK. This is used to set up a custom
preload script which must be run before the main Vendure server is loaded by means of the
Node.js --require flag.

Example

```
// instrumentation.tsimport { OTLPLogExporter } from '@opentelemetry/exporter-logs-otlp-proto';import { OTLPTraceExporter } from '@opentelemetry/exporter-trace-otlp-http';import { BatchLogRecordProcessor } from '@opentelemetry/sdk-logs';import { NodeSDK } from '@opentelemetry/sdk-node';import { BatchSpanProcessor } from '@opentelemetry/sdk-trace-base';import { getSdkConfiguration } from '@vendure/telemetry-plugin/preload';process.env.OTEL_EXPORTER_OTLP_ENDPOINT = 'http://localhost:3100/otlp';process.env.OTEL_LOGS_EXPORTER = 'otlp';process.env.OTEL_RESOURCE_ATTRIBUTES = 'service.name=vendure-dev-server';const traceExporter = new OTLPTraceExporter({    url: 'http://localhost:4318/v1/traces',});const logExporter = new OTLPLogExporter();const config = getSdkConfiguration({    config: {        spanProcessors: [new BatchSpanProcessor(traceExporter)],        logRecordProcessors: [new BatchLogRecordProcessor(logExporter)],    },});const sdk = new NodeSDK(config);sdk.start();
```

This would them be run as:

```
node --require ./dist/instrumentation.js ./dist/server.js
```

```
function getSdkConfiguration(options?: SdkConfigurationOptions): Partial<NodeSDKConfiguration>
```

Parameters

### options​


[​](#options)[SdkConfigurationOptions](/reference/core-plugins/telemetry-plugin/get-sdk-configuration#sdkconfigurationoptions)
## SdkConfigurationOptions​


[​](#sdkconfigurationoptions)[@vendure/telemetry-plugin](https://www.npmjs.com/package/@vendure/telemetry-plugin)[instrumentation.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/telemetry-plugin/src/instrumentation.ts#L27)Options for configuring the OpenTelemetry Node SDK.

```
interface SdkConfigurationOptions {    logToConsole?: boolean;    config: Partial<NodeSDKConfiguration>;}
```

### logToConsole​


[​](#logtoconsole)When set to true, the SDK will log spans to the console instead of sending them to an
exporter. This should just be used for debugging purposes.

### config​


[​](#config)The configuration object for the OpenTelemetry Node SDK.

---

# OtelLogger


## OtelLogger​


[​](#otellogger)[@vendure/telemetry-plugin](https://www.npmjs.com/package/@vendure/telemetry-plugin)[otel-logger.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/telemetry-plugin/src/config/otel-logger.ts#L46)A logger that emits logs to OpenTelemetry and optionally to the console.

```
class OtelLogger implements VendureLogger {    constructor(options: OtelLoggerOptions)    debug(message: string, context?: string) => void;    warn(message: string, context?: string) => void;    info(message: string, context?: string) => void;    error(message: string, context?: string) => void;    verbose(message: string, context?: string) => void;}
```

- Implements: VendureLogger

[VendureLogger](/reference/typescript-api/logger/vendure-logger#vendurelogger)
### constructor​


[​](#constructor)[OtelLoggerOptions](/reference/core-plugins/telemetry-plugin/otel-logger#otelloggeroptions)
### debug​


[​](#debug)
### warn​


[​](#warn)
### info​


[​](#info)
### error​


[​](#error)
### verbose​


[​](#verbose)
## OtelLoggerOptions​


[​](#otelloggeroptions)[@vendure/telemetry-plugin](https://www.npmjs.com/package/@vendure/telemetry-plugin)[otel-logger.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/telemetry-plugin/src/config/otel-logger.ts#L14)Options for the OtelLogger.

```
interface OtelLoggerOptions {    logToConsole?: LogLevel;}
```

### logToConsole​


[​](#logtoconsole)[LogLevel](/reference/typescript-api/logger/log-level#loglevel)If set to a LogLevel, the logger will also log to the console.
This can be useful for local development or debugging.

Example

```
import { LogLevel } from '@vendure/core';import { TelemetryPlugin } from '@vendure/telemetry-plugin';// ...TelemetryPlugin.init({  loggerOptions: {    logToConsole: LogLevel.Verbose,  },});
```

---

# RegisterMethodHooks


## registerMethodHooks​


[​](#registermethodhooks)[@vendure/telemetry-plugin](https://www.npmjs.com/package/@vendure/telemetry-plugin)[method-hooks.service.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/telemetry-plugin/src/service/method-hooks.service.ts#L60)Allows you to register hooks for a specific method of an instrumented class.
These hooks allow extra telemetry actions to be performed on the method.

They can then be passed to the TelemetryPlugin via the TelemetryPluginOptions.

[TelemetryPlugin](/reference/core-plugins/telemetry-plugin/#telemetryplugin)[TelemetryPluginOptions](/reference/core-plugins/telemetry-plugin/telemetry-plugin-options#telemetrypluginoptions)Example

```
const productServiceHooks = registerMethodHooks(ProductService, {    findOne: {        // This will be called before the method is executed        pre: ({ args: [ctx, productId], span }) => {            span.setAttribute('productId', productId);        },        // This will be called after the method is executed        post: ({ result, span }) => {            span.setAttribute('found', !!result);        },    },});
```

```
function registerMethodHooks<T>(target: Type<T>, hooks: MethodHooksForType<T>): MethodHookConfig<T>
```

Parameters

### target​


[​](#target)
### hooks​


[​](#hooks)


---

# TelemetryPluginOptions


## TelemetryPluginOptions​


[​](#telemetrypluginoptions)[@vendure/telemetry-plugin](https://www.npmjs.com/package/@vendure/telemetry-plugin)[types.ts](https://github.com/vendure-ecommerce/vendure/blob/master/packages/telemetry-plugin/src/types.ts#L18)Configuration options for the TelemetryPlugin.

```
interface TelemetryPluginOptions {    loggerOptions?: OtelLoggerOptions;    methodHooks?: Array<MethodHookConfig<any>>;}
```

### loggerOptions​


[​](#loggeroptions)[OtelLoggerOptions](/reference/core-plugins/telemetry-plugin/otel-logger#otelloggeroptions)The options for the OtelLogger.

For example, to also include logging to the console, you can use the following:

```
import { LogLevel } from '@vendure/core';import { TelemetryPlugin } from '@vendure/telemetry-plugin';TelemetryPlugin.init({    loggerOptions: {        console: LogLevel.Verbose,    },});
```

### methodHooks​


[​](#methodhooks)Status: Developer Preview

This API may change in a future release.

Method hooks allow you to add extra telemetry actions to specific methods.
To define hooks on a method, use the registerMethodHooks function.

[registerMethodHooks](/reference/core-plugins/telemetry-plugin/register-method-hooks#registermethodhooks)Example

```
import { TelemetryPlugin, registerMethodHooks } from '@vendure/telemetry-plugin';TelemetryPlugin.init({  methodHooks: [    registerMethodHooks(ProductService, {      // Define some hooks for the `findOne` method      findOne: {        // This will be called before the method is executed        pre: ({ args: [ctx, productId], span }) => {          span.setAttribute('productId', productId);        },        // This will be called after the method is executed        post: ({ result, span }) => {          span.setAttribute('found', !!result);        },      },    }),  ],});
```
