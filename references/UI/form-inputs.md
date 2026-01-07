# Vendure Dashboard - Composants Form Inputs

> Généré automatiquement le 2025-10-27 08:00:46
> Source : https://storybook.vendure.io

## 📋 Table des Matières

- [AffixedInput](#affixedinput) (6 exemples)
- [BooleanInput](#booleaninput) (4 exemples)
- [CheckboxInput](#checkboxinput) (3 exemples)
- [DatetimeInput](#datetimeinput) (4 exemples)
- [MoneyInput](#moneyinput) (4 exemples)
- [NumberInput](#numberinput) (5 exemples)
- [PasswordFormInput](#passwordforminput) (3 exemples)
- [RichTextInput](#richtextinput) (5 exemples)
- [SlugInput](#sluginput) (6 exemples)
- [TextInput](#textinput) (3 exemples)
- [TextareaInput](#textareainput) (3 exemples)

---

## 🚀 Import Rapide

```tsx
import {
  AffixedInput,
  BooleanInput,
  CheckboxInput,
  DatetimeInput,
  MoneyInput,
  NumberInput,
  PasswordFormInput,
  RichTextInput,
  SlugInput,
  TextInput,
  TextareaInput,
} from '@vendure/dashboard';
```

---

## AffixedInput

**Import** : `import { AffixedInput } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/form-inputs-affixedinput--docs](https://storybook.vendure.io/?path=/docs/form-inputs-affixedinput--docs)

### Exemples (6)

#### 1. Default

```tsx
<AffixedInput
    {...field}
    type="number"
    suffix="%"
    value={field.value}
    onChange={e => field.onChange(e.target.valueAsNumber)}
/>
```

#### 2. Playground

```tsx
<AffixedInput
    {...field}
    type="number"
    suffix="%"
    value={field.value}
    onChange={e => field.onChange(e.target.valueAsNumber)}
/>
```

#### 3. With Icon Prefix

```tsx
<AffixedInput
    {...field}
    type="number"
    suffix="%"
    value={field.value}
    onChange={e => field.onChange(e.target.valueAsNumber)}
/>
```

#### 4. With Suffix

```tsx
<AffixedInput
    {...field}
    type="number"
    suffix="%"
    value={field.value}
    onChange={e => field.onChange(e.target.valueAsNumber)}
/>
```

#### 5. Disabled

```tsx
<AffixedInput
    {...field}
    type="number"
    suffix="%"
    value={field.value}
    onChange={e => field.onChange(e.target.valueAsNumber)}
/>
```

#### 6. Number With Steps

```tsx
<AffixedInput
    {...field}
    type="number"
    suffix="%"
    value={field.value}
    onChange={e => field.onChange(e.target.valueAsNumber)}
/>
```

---

## BooleanInput

Displays a boolean value as a switch toggle.

**Import** : `import { BooleanInput } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/form-inputs-booleaninput--docs](https://storybook.vendure.io/?path=/docs/form-inputs-booleaninput--docs)

### Exemples (4)

#### 1. Default

```tsx
<div className="flex items-center gap-2">
  <BooleanInput
    ref={function ZAe(){}}
    name="playground"
    onBlur={function ZAe(){}}
    onChange={function ZAe(){}}
  />
  <label className="text-sm font-medium">
    Enable notifications
  </label>
</div>
```

#### 2. Playground

```tsx
<div className="flex items-center gap-2">
  <BooleanInput
    ref={function ZAe(){}}
    name="playground"
    onBlur={function ZAe(){}}
    onChange={function ZAe(){}}
  />
  <label className="text-sm font-medium">
    Enable notifications
  </label>
</div>
```

#### 3. Product Settings

```tsx
{
  render: () => {
    const {
      register
    } = useForm();
    return <div className="w-[350px] space-y-3">
                <div className="flex items-center justify-between">
                    <div>
                        <label className="text-sm font-medium">Product enabled</label>
                        <p className="text-xs text-muted-foreground">
                            Make this product visible in the catalog
                        </p>
                    </div>
                    <BooleanInput {...register('enabled')} />
                </div>
                <div className="flex items-center justify-between">
                    <div>
                        <label className="text-sm font-medium">Featured</label>
                        <p className="text-xs text-muted-foreground">Show on homepage</p>
                    </div>
                    <BooleanInput {...register('featured')} />
                </div>
                <div className="flex items-center justify-between">
                    <div>
                        <label className="text-sm font-medium">Track inventory</label>
                        <p className="text-xs text-muted-foreground">Monitor stock levels</p>
                    </div>
                    <BooleanInput {...register('trackInventory')} />
                </div>
                <div className="flex items-center justify-between">
                    <div>
                        <label className="text-sm font-medium">Allow backorder</label>
                        <p className="text-xs text-muted-foreground">Accept orders when out of stock</p>
                    </div>
                    <BooleanInput {...register('allowBackorder')} />
                </div>
            </div>;
  }
}
```

#### 4. String Values

```tsx
{
  render: () => {
    const {
      register
    } = useForm();
    return <div className="space-y-4">
                <div className="flex items-center gap-2">
                    <BooleanInput {...register('trueValue')} />
                    <label className="text-sm font-medium">String value: "true"</label>
                </div>

                <div className="flex items-center gap-2">
                    <BooleanInput {...register('falseValue')} />
                    <label className="text-sm font-medium">String value: "false"</label>
                </div>

                <div className="text-sm text-muted-foreground">
                    Demonstrates handling of string "true"/"false" values
                </div>
            </div>;
  }
}
```

---

## CheckboxInput

Displays a boolean value as a checkbox.

**Import** : `import { CheckboxInput } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/form-inputs-checkboxinput--docs](https://storybook.vendure.io/?path=/docs/form-inputs-checkboxinput--docs)

### Exemples (3)

#### 1. Default

```tsx
<div className="flex items-center gap-2">
  <CheckboxInput
    ref={function ZAe(){}}
    name="playground"
    onBlur={function ZAe(){}}
    onChange={function ZAe(){}}
  />
  <label className="text-sm font-medium">
    Accept terms and conditions
  </label>
</div>
```

#### 2. Playground

```tsx
<div className="flex items-center gap-2">
  <CheckboxInput
    ref={function ZAe(){}}
    name="playground"
    onBlur={function ZAe(){}}
    onChange={function ZAe(){}}
  />
  <label className="text-sm font-medium">
    Accept terms and conditions
  </label>
</div>
```

#### 3. Multiple Checkboxes

```tsx
{
  render: () => {
    const {
      register
    } = useForm();
    return <div className="space-y-3">
                <div className="flex items-center gap-2">
                    <CheckboxInput {...register('notifications')} />
                    <label className="text-sm font-medium">Email notifications</label>
                </div>
                <div className="flex items-center gap-2">
                    <CheckboxInput {...register('marketing')} />
                    <label className="text-sm font-medium">Marketing emails</label>
                </div>
                <div className="flex items-center gap-2">
                    <CheckboxInput {...register('updates')} />
                    <label className="text-sm font-medium">Product updates</label>
                </div>
            </div>;
  }
}
```

---

## DatetimeInput

**Import** : `import { DatetimeInput } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/form-inputs-datetimeinput--docs](https://storybook.vendure.io/?path=/docs/form-inputs-datetimeinput--docs)

### Exemples (4)

#### 1. Default

```tsx
<div className="w-[400px]">
  <DateTimeInput
    ref={function ZAe(){}}
    name="playground"
    onBlur={function ZAe(){}}
    onChange={function ZAe(){}}
    value="2024-06-15T12:30:00.000Z"
  />
</div>
```

#### 2. Playground

```tsx
<div className="w-[400px]">
  <DateTimeInput
    ref={function ZAe(){}}
    name="playground"
    onBlur={function ZAe(){}}
    onChange={function ZAe(){}}
    value="2024-06-15T12:30:00.000Z"
  />
</div>
```

#### 3. Future Date

```tsx
{
  render: () => {
    const {
      register
    } = useForm();
    const field = register('future');
    return <div className="w-[400px]">
                <DateTimeInput {...field} />
            </div>;
  }
}
```

#### 4. Clearable Value

```tsx
{
  render: () => {
    const {
      register
    } = useForm();
    const field = register('clearable');
    return <div className="w-[400px]">
                <DateTimeInput {...field} />
            </div>;
  }
}
```

---

## MoneyInput

A component for displaying a money value. The currency can be specified, but otherwise will be taken from the active channel's default currency.

**Import** : `import { MoneyInput } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/form-inputs-moneyinput--docs](https://storybook.vendure.io/?path=/docs/form-inputs-moneyinput--docs)

### Exemples (4)

#### 1. Default

```tsx
<div className="w-[300px]">
  <MoneyInput
    ref={function ZAe(){}}
    currency="USD"
    name="playground"
    onBlur={function ZAe(){}}
    onChange={function ZAe(){}}
    value={9999}
  />
</div>
```

#### 2. Playground

```tsx
<div className="w-[300px]">
  <MoneyInput
    ref={function ZAe(){}}
    currency="USD"
    name="playground"
    onBlur={function ZAe(){}}
    onChange={function ZAe(){}}
    value={9999}
  />
</div>
```

#### 3. Different Currencies

```tsx
<div className="w-[300px] space-y-4">
  <div className="space-y-2">
    <label className="text-sm font-medium">
      USD
    </label>
    <MoneyInput
      ref={function ZAe(){}}
      currency="USD"
      name="usd"
      onBlur={function ZAe(){}}
      onChange={function ZAe(){}}
      value={9999}
    />
  </div>
  <div className="space-y-2">
    <label className="text-sm font-medium">
      EUR
    </label>
    <MoneyInput
      ref={function ZAe(){}}
      currency="EUR"
      name="eur"
      onBlur={function ZAe(){}}
      onChange={function ZAe(){}}
      value={9999}
    />
  </div>
  <div className="space-y-2">
    <label className="text-sm font-medium">
      GBP
    </label>
    <MoneyInput
      ref={function ZAe(){}}
      currency="GBP"
      name="gbp"
      onBlur={function ZAe(){}}
      onChange={function ZAe(){}}
      value={9999}
    />
  </div>
  <div className="space-y-2">
    <label className="text-sm font-medium">
      JPY
    </label>
    <MoneyInput
      ref={function ZAe(){}}
      currency="JPY"
      name="jpy"
      onBlur={function ZAe(){}}
      onChange={function ZAe(){}}
      value={9999}
    />
  </div>
</div>
```

#### 4. Large Amount

```tsx
{
  render: () => {
    const {
      register
    } = useForm();
    const field = register('large');
    return <div className="w-[300px]">
                <MoneyInput {...field} currency="USD" value={123} />
            </div>;
  }
}
```

---

## NumberInput

A component for displaying a numeric value.

**Import** : `import { NumberInput } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/form-inputs-numberinput--docs](https://storybook.vendure.io/?path=/docs/form-inputs-numberinput--docs)

### Exemples (5)

#### 1. Default

```tsx
<div className="w-[300px]">
  <NumberInput
    ref={function ZAe(){}}
    max={100}
    min={0}
    name="playground"
    onBlur={function ZAe(){}}
    onChange={function ZAe(){}}
    step={1}
    value={42}
  />
</div>
```

#### 2. Playground

```tsx
<div className="w-[300px]">
  <NumberInput
    ref={function ZAe(){}}
    max={100}
    min={0}
    name="playground"
    onBlur={function ZAe(){}}
    onChange={function ZAe(){}}
    step={1}
    value={42}
  />
</div>
```

#### 3. Float

```tsx
{
  render: () => {
    const {
      register
    } = useForm();
    const field = register('float');
    return <div className="w-[300px] space-y-2">
                <NumberInput {...field} step={0.01} fieldDef={{
        type: 'float'
      }} />
                <div className="text-sm text-muted-foreground">
                    <div>Floating point with step 0.01</div>
                </div>
            </div>;
  }
}
```

#### 4. With Prefix And Suffix

```tsx
{
  render: () => {
    const {
      register
    } = useForm();
    const field = register('withAffix');
    return <div className="w-[300px] space-y-2">
                <NumberInput {...field} fieldDef={{
        ui: {
          prefix: '$',
          suffix: 'USD'
        }
      }} step={10} />
                <div className="text-sm text-muted-foreground">
                    Demonstrates fieldDef.ui.prefix and fieldDef.ui.suffix
                </div>
            </div>;
  }
}
```

#### 5. Null Value

```tsx
{
  render: () => {
    const {
      register
    } = useForm();
    const field = register('nullValue');
    return <div className="w-[300px] space-y-2">
                <NumberInput {...field} />
                <div className="text-sm text-muted-foreground">
                    <div className="mt-1 text-xs">When input is cleared, value becomes null</div>
                </div>
            </div>;
  }
}
```

---

## PasswordFormInput

A component for displaying a password input.

**Import** : `import { PasswordFormInput } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/form-inputs-passwordforminput--docs](https://storybook.vendure.io/?path=/docs/form-inputs-passwordforminput--docs)

### Exemples (3)

#### 1. Default

```tsx
<div className="w-[300px]">
  <PasswordFormInput
    ref={function ZAe(){}}
    name="password"
    onBlur={function ZAe(){}}
    onChange={function ZAe(){}}
    value="secret123"
  />
</div>
```

#### 2. Playground

```tsx
<div className="w-[300px]">
  <PasswordFormInput
    ref={function ZAe(){}}
    name="password"
    onBlur={function ZAe(){}}
    onChange={function ZAe(){}}
    value="secret123"
  />
</div>
```

#### 3. Change Password

```tsx
{
  render: () => {
    const {
      register
    } = useForm();
    return <div className="w-[300px] space-y-4">
                <div className="space-y-2">
                    <label className="text-sm font-medium">Current Password</label>
                    <PasswordFormInput {...register('currentPassword')} />
                </div>
                <div className="space-y-2">
                    <label className="text-sm font-medium">New Password</label>
                    <PasswordFormInput {...register('newPassword')} />
                </div>
                <div className="space-y-2">
                    <label className="text-sm font-medium">Confirm New Password</label>
                    <PasswordFormInput {...register('confirmPassword')} />
                </div>
            </div>;
  }
}
```

---

## RichTextInput

A component for displaying a rich text editor. Internally uses ProseMirror (rich text editor) under the hood.

**Import** : `import { RichTextInput } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/form-inputs-richtextinput--docs](https://storybook.vendure.io/?path=/docs/form-inputs-richtextinput--docs)

### Exemples (5)

#### 1. Default

```tsx
<div className="w-[600px]">
  <RichTextInput
    ref={function ZAe(){}}
    name="content"
    onBlur={function ZAe(){}}
    onChange={function ZAe(){}}
    value="<p>Edit this <strong>rich text</strong> content!</p>"
  />
</div>
```

#### 2. Playground

```tsx
<div className="w-[600px]">
  <RichTextInput
    ref={function ZAe(){}}
    name="content"
    onBlur={function ZAe(){}}
    onChange={function ZAe(){}}
    value="<p>Edit this <strong>rich text</strong> content!</p>"
  />
</div>
```

#### 3. Empty Editor

```tsx
{
  render: () => {
    const {
      register
    } = useForm();
    const field = register('empty');
    return <div className="w-[600px]">
                <RichTextInput {...field} />
            </div>;
  }
}
```

#### 4. With Complex Content

```tsx
{
  render: () => {
    const {
      register
    } = useForm();
    const field = register('complex');
    return <div className="w-[600px]">
                <RichTextInput {...field} value={`
                        <h2>Product Description</h2>
                        <p>This is a <strong>high-quality</strong> product with the following features:</p>
                        <ul>
                            <li>Feature one with <em>emphasis</em></li>
                            <li>Feature two with a <a href="https://example.com">link</a></li>
                            <li>Feature three</li>
                        </ul>
                        <blockquote>
                            <p>Customer testimonial goes here</p>
                        </blockquote>
                    `} />
            </div>;
  }
}
```

#### 5. Readonly Mode

```tsx
{
  render: () => {
    const {
      register
    } = useForm();
    const field = register('readonly');
    return <div className="w-[600px]">
                <RichTextInput {...field} value="<p>This content is <strong>readonly</strong> and cannot be edited.</p>" fieldDef={{
        readonly: true
      }} />
            </div>;
  }
}
```

---

## SlugInput

**Import** : `import { SlugInput } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/form-inputs-sluginput--docs](https://storybook.vendure.io/?path=/docs/form-inputs-sluginput--docs)

### Exemples (6)

#### 1. Default

```tsx
// In a TranslatableFormFieldWrapper context with translatable field
<SlugInput
    {...field}
    entityName="Product"
    fieldName="slug"
    watchFieldName="name" // Automatically resolves to "translations.X.name"
    entityId={productId}
/>

// In a TranslatableFormFieldWrapper context with non-translatable field
<SlugInput
    {...field}
    entityName="Product"
    fieldName="slug"
    watchFieldName="enabled" // Uses "enabled" directly (base entity field)
    entityId={productId}
/>

// For non-translatable entities
<SlugInput
    {...field}
    entityName="Channel"
    fieldName="code"
    watchFieldName="name" // Uses "name" directly
    entityId={channelId}
/>
```

#### 2. Auto Generating

```tsx
// In a TranslatableFormFieldWrapper context with translatable field
<SlugInput
    {...field}
    entityName="Product"
    fieldName="slug"
    watchFieldName="name" // Automatically resolves to "translations.X.name"
    entityId={productId}
/>

// In a TranslatableFormFieldWrapper context with non-translatable field
<SlugInput
    {...field}
    entityName="Product"
    fieldName="slug"
    watchFieldName="enabled" // Uses "enabled" directly (base entity field)
    entityId={productId}
/>

// For non-translatable entities
<SlugInput
    {...field}
    entityName="Channel"
    fieldName="code"
    watchFieldName="name" // Uses "name" directly
    entityId={channelId}
/>
```

#### 3. With Existing Value

```tsx
// In a TranslatableFormFieldWrapper context with translatable field
<SlugInput
    {...field}
    entityName="Product"
    fieldName="slug"
    watchFieldName="name" // Automatically resolves to "translations.X.name"
    entityId={productId}
/>

// In a TranslatableFormFieldWrapper context with non-translatable field
<SlugInput
    {...field}
    entityName="Product"
    fieldName="slug"
    watchFieldName="enabled" // Uses "enabled" directly (base entity field)
    entityId={productId}
/>

// For non-translatable entities
<SlugInput
    {...field}
    entityName="Channel"
    fieldName="code"
    watchFieldName="name" // Uses "name" directly
    entityId={channelId}
/>
```

#### 4. Manual Editing

```tsx
// In a TranslatableFormFieldWrapper context with translatable field
<SlugInput
    {...field}
    entityName="Product"
    fieldName="slug"
    watchFieldName="name" // Automatically resolves to "translations.X.name"
    entityId={productId}
/>

// In a TranslatableFormFieldWrapper context with non-translatable field
<SlugInput
    {...field}
    entityName="Product"
    fieldName="slug"
    watchFieldName="enabled" // Uses "enabled" directly (base entity field)
    entityId={productId}
/>

// For non-translatable entities
<SlugInput
    {...field}
    entityName="Channel"
    fieldName="code"
    watchFieldName="name" // Uses "name" directly
    entityId={channelId}
/>
```

#### 5. Start In Editable Mode

```tsx
// In a TranslatableFormFieldWrapper context with translatable field
<SlugInput
    {...field}
    entityName="Product"
    fieldName="slug"
    watchFieldName="name" // Automatically resolves to "translations.X.name"
    entityId={productId}
/>

// In a TranslatableFormFieldWrapper context with non-translatable field
<SlugInput
    {...field}
    entityName="Product"
    fieldName="slug"
    watchFieldName="enabled" // Uses "enabled" directly (base entity field)
    entityId={productId}
/>

// For non-translatable entities
<SlugInput
    {...field}
    entityName="Channel"
    fieldName="code"
    watchFieldName="name" // Uses "name" directly
    entityId={channelId}
/>
```

#### 6. Readonly

```tsx
// In a TranslatableFormFieldWrapper context with translatable field
<SlugInput
    {...field}
    entityName="Product"
    fieldName="slug"
    watchFieldName="name" // Automatically resolves to "translations.X.name"
    entityId={productId}
/>

// In a TranslatableFormFieldWrapper context with non-translatable field
<SlugInput
    {...field}
    entityName="Product"
    fieldName="slug"
    watchFieldName="enabled" // Uses "enabled" directly (base entity field)
    entityId={productId}
/>

// For non-translatable entities
<SlugInput
    {...field}
    entityName="Channel"
    fieldName="code"
    watchFieldName="name" // Uses "name" directly
    entityId={channelId}
/>
```

---

## TextInput

A component for displaying a text input.

**Import** : `import { TextInput } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/form-inputs-textinput--docs](https://storybook.vendure.io/?path=/docs/form-inputs-textinput--docs)

### Exemples (3)

#### 1. Default

```tsx
<Fne
  ref={function ZAe(){}}
  name="text"
  onBlur={function ZAe(){}}
  onChange={function ZAe(){}}
  placeholder="Enter text"
  value="Edit me!"
/>
```

#### 2. Playground

```tsx
<Fne
  ref={function ZAe(){}}
  name="text"
  onBlur={function ZAe(){}}
  onChange={function ZAe(){}}
  placeholder="Enter text"
  value="Edit me!"
/>
```

#### 3. Long Text

```tsx
{
  render: () => {
    const {
      register
    } = useForm();
    const field = register('longText');
    return <TextInput {...field} />;
  }
}
```

---

## TextareaInput

A component for displaying a textarea input.

**Import** : `import { TextareaInput } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/form-inputs-textareainput--docs](https://storybook.vendure.io/?path=/docs/form-inputs-textareainput--docs)

### Exemples (3)

#### 1. Default

```tsx
<div className="w-[500px]">
  <TextareaInput
    ref={function ZAe(){}}
    name="playground"
    onBlur={function ZAe(){}}
    onChange={function ZAe(){}}
    value="Edit this text!
Multiple lines supported."
  />
</div>
```

#### 2. Playground

```tsx
<div className="w-[500px]">
  <TextareaInput
    ref={function ZAe(){}}
    name="playground"
    onBlur={function ZAe(){}}
    onChange={function ZAe(){}}
    value="Edit this text!
Multiple lines supported."
  />
</div>
```

#### 3. Long Text

```tsx
{
  render: () => {
    const {
      register
    } = useForm();
    const field = register('longText');
    return <div className="w-[500px]">
                <TextareaInput {...field} />
            </div>;
  }
}
```

---

## 📚 Ressources

- [Storybook Vendure](https://storybook.vendure.io)
- [Documentation Vendure](https://docs.vendure.io)
