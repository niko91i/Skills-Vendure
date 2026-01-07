# Vendure Dashboard - Composants UI

> Généré automatiquement le 2025-10-27 08:05:00
> Source : https://storybook.vendure.io

## 📋 Table des Matières

- [Accordion](#accordion) (1 exemples)
- [Alert](#alert) (1 exemples)
- [AlertDialog](#alertdialog) (1 exemples)
- [AspectRatio](#aspectratio) (1 exemples)
- [Badge](#badge) (1 exemples)
- [Breadcrumb](#breadcrumb) (1 exemples)
- [Button](#button) (1 exemples)
- [Calendar](#calendar) (1 exemples)
- [Card](#card) (1 exemples)
- [Carousel](#carousel) (1 exemples)
- [Checkbox](#checkbox) (1 exemples)
- [Collapsible](#collapsible) (1 exemples)
- [Command](#command) (1 exemples)
- [ContextMenu](#contextmenu) (1 exemples)
- [Dialog](#dialog) (1 exemples)
- [Drawer](#drawer) (1 exemples)
- [DropdownMenu](#dropdownmenu) (1 exemples)
- [HoverCard](#hovercard) (1 exemples)
- [Input](#input) (1 exemples)
- [InputOTP](#inputotp) (1 exemples)
- [Label](#label) (1 exemples)
- [Menubar](#menubar) (1 exemples)
- [NavigationMenu](#navigationmenu) (1 exemples)
- [Pagination](#pagination) (1 exemples)
- [PasswordInput](#passwordinput) (1 exemples)
- [Popover](#popover) (1 exemples)
- [Progress](#progress) (1 exemples)
- [RadioGroup](#radiogroup) (1 exemples)
- [ResizablePanelGroup](#resizablepanelgroup) (1 exemples)
- [ScrollArea](#scrollarea) (1 exemples)
- [Select](#select) (1 exemples)
- [Separator](#separator) (1 exemples)
- [Sheet](#sheet) (1 exemples)
- [Skeleton](#skeleton) (1 exemples)
- [Slider](#slider) (1 exemples)
- [Switch](#switch) (1 exemples)
- [Table](#table) (1 exemples)
- [Tabs](#tabs) (1 exemples)
- [Textarea](#textarea) (1 exemples)
- [Toggle](#toggle) (1 exemples)
- [ToggleGroup](#togglegroup) (1 exemples)
- [Tooltip](#tooltip) (1 exemples)

---

## 🚀 Import Rapide

```tsx
import {
  Accordion,
  Alert,
  AlertDialog,
  AspectRatio,
  Badge,
  Breadcrumb,
  Button,
  Calendar,
  Card,
  Carousel,
  Checkbox,
  Collapsible,
  Command,
  ContextMenu,
  Dialog,
  Drawer,
  DropdownMenu,
  HoverCard,
  Input,
  InputOTP,
  Label,
  Menubar,
  NavigationMenu,
  Pagination,
  PasswordInput,
  Popover,
  Progress,
  RadioGroup,
  ResizablePanelGroup,
  ScrollArea,
  Select,
  Separator,
  Sheet,
  Skeleton,
  Slider,
  Switch,
  Table,
  Tabs,
  Textarea,
  Toggle,
  ToggleGroup,
  Tooltip,
} from '@vendure/dashboard';
```

---

## Accordion

**Import** : `import { Accordion } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-accordion--docs](https://storybook.vendure.io/?path=/docs/ui-accordion--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <Accordion type="single" collapsible className="w-[400px]">
            <AccordionItem value="item-1">
                <AccordionTrigger>Item 1</AccordionTrigger>
                <AccordionContent>Content for item 1</AccordionContent>
            </AccordionItem>
            <AccordionItem value="item-2">
                <AccordionTrigger>Item 2</AccordionTrigger>
                <AccordionContent>Content for item 2</AccordionContent>
            </AccordionItem>
            <AccordionItem value="item-3">
                <AccordionTrigger>Item 3</AccordionTrigger>
                <AccordionContent>Content for item 3</AccordionContent>
            </AccordionItem>
        </Accordion>
}
```

---

## Alert

**Import** : `import { Alert } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-alert--docs](https://storybook.vendure.io/?path=/docs/ui-alert--docs)

### Exemples (1)

#### 1. Default

```tsx
<Alert
  className="w-[400px]"
  variant="default"
>
  <CircleAlert className="h-4 w-4" />
  <AlertTitle>
    Heads up!
  </AlertTitle>
  <AlertDescription>
    You can add components to your app using the cli.
  </AlertDescription>
</Alert>
```

---

## AlertDialog

**Import** : `import { AlertDialog } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-alert-dialog--docs](https://storybook.vendure.io/?path=/docs/ui-alert-dialog--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <AlertDialog>
            <AlertDialogTrigger asChild>
                <Button variant="destructive">Delete Item</Button>
            </AlertDialogTrigger>
            <AlertDialogContent>
                <AlertDialogHeader>
                    <AlertDialogTitle>Are you absolutely sure?</AlertDialogTitle>
                    <AlertDialogDescription>
                        This action cannot be undone. This will permanently delete your item.
                    </AlertDialogDescription>
                </AlertDialogHeader>
                <AlertDialogFooter>
                    <AlertDialogCancel>Cancel</AlertDialogCancel>
                    <AlertDialogAction>Continue</AlertDialogAction>
                </AlertDialogFooter>
            </AlertDialogContent>
        </AlertDialog>
}
```

---

## AspectRatio

**Import** : `import { AspectRatio } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-aspect-ratio--docs](https://storybook.vendure.io/?path=/docs/ui-aspect-ratio--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <div className="w-[400px]">
            <AspectRatio ratio={16 / 9}>
                <img src="https://images.unsplash.com/photo-1588345921523-c2dcdb7f1dcd?w=800&dpr=2&q=80" alt="Photo" className="rounded-md object-cover w-full h-full" />
            </AspectRatio>
        </div>
}
```

---

## Badge

**Import** : `import { Badge } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-badge--docs](https://storybook.vendure.io/?path=/docs/ui-badge--docs)

### Exemples (1)

#### 1. Default

```tsx
<Badge variant="default">
  Badge
</Badge>
```

---

## Breadcrumb

**Import** : `import { Breadcrumb } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-breadcrumb--docs](https://storybook.vendure.io/?path=/docs/ui-breadcrumb--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <Breadcrumb>
            <BreadcrumbList>
                <BreadcrumbItem>
                    <BreadcrumbLink href="/">Home</BreadcrumbLink>
                </BreadcrumbItem>
                <BreadcrumbSeparator />
                <BreadcrumbItem>
                    <BreadcrumbLink href="/products">Products</BreadcrumbLink>
                </BreadcrumbItem>
                <BreadcrumbSeparator />
                <BreadcrumbItem>
                    <BreadcrumbPage>Current Page</BreadcrumbPage>
                </BreadcrumbItem>
            </BreadcrumbList>
        </Breadcrumb>
}
```

---

## Button

**Import** : `import { Button } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-button--docs](https://storybook.vendure.io/?path=/docs/ui-button--docs)

### Exemples (1)

#### 1. Default

```tsx
<Button
  size="default"
  variant="default"
>
  Button
</Button>
```

---

## Calendar

A custom calendar component built on top of react-day-picker.

**Import** : `import { Calendar } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-calendar--docs](https://storybook.vendure.io/?path=/docs/ui-calendar--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => {
    const [date, setDate] = useState<Date | undefined>(new Date());
    return <Calendar mode="single" selected={date} onSelect={setDate} className="rounded-md border" />;
  }
}
```

---

## Card

**Import** : `import { Card } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-card--docs](https://storybook.vendure.io/?path=/docs/ui-card--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <Card className="w-[350px]">
            <CardHeader>
                <CardTitle>Card Title</CardTitle>
                <CardDescription>Card description goes here</CardDescription>
            </CardHeader>
            <CardContent>
                <p>Card content goes here</p>
            </CardContent>
        </Card>
}
```

---

## Carousel

**Import** : `import { Carousel } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-carousel--docs](https://storybook.vendure.io/?path=/docs/ui-carousel--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <Carousel className="w-full max-w-xs">
            <CarouselContent>
                {Array.from({
        length: 5
      }).map((_, index) => <CarouselItem key={index}>
                        <div className="p-1">
                            <div className="flex aspect-square items-center justify-center p-6 border rounded-lg">
                                <span className="text-4xl font-semibold">{index + 1}</span>
                            </div>
                        </div>
                    </CarouselItem>)}
            </CarouselContent>
            <CarouselPrevious />
            <CarouselNext />
        </Carousel>
}
```

---

## Checkbox

**Import** : `import { Checkbox } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-checkbox--docs](https://storybook.vendure.io/?path=/docs/ui-checkbox--docs)

### Exemples (1)

#### 1. Default

```tsx
<Checkbox
/>
```

---

## Collapsible

**Import** : `import { Collapsible } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-collapsible--docs](https://storybook.vendure.io/?path=/docs/ui-collapsible--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => {
    const [isOpen, setIsOpen] = useState(false);
    return <Collapsible open={isOpen} onOpenChange={setIsOpen} className="w-[350px] space-y-2">
                <div className="flex items-center justify-between space-x-4 px-4">
                    <h4 className="text-sm font-semibold">@peduarte starred 3 repositories</h4>
                    <CollapsibleTrigger asChild>
                        <Button variant="ghost" size="sm">
                            {isOpen ? 'Hide' : 'Show'}
                        </Button>
                    </CollapsibleTrigger>
                </div>
                <div className="rounded-md border px-4 py-3 font-mono text-sm">@radix-ui/primitives</div>
                <CollapsibleContent className="space-y-2">
                    <div className="rounded-md border px-4 py-3 font-mono text-sm">@radix-ui/colors</div>
                    <div className="rounded-md border px-4 py-3 font-mono text-sm">@stitches/react</div>
                </CollapsibleContent>
            </Collapsible>;
  }
}
```

---

## Command

**Import** : `import { Command } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-command--docs](https://storybook.vendure.io/?path=/docs/ui-command--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <Command className="rounded-lg border shadow-md w-[400px]">
            <CommandInput placeholder="Type a command or search..." />
            <CommandList>
                <CommandEmpty>No results found.</CommandEmpty>
                <CommandGroup heading="Suggestions">
                    <CommandItem>Calendar</CommandItem>
                    <CommandItem>Search Emoji</CommandItem>
                    <CommandItem>Calculator</CommandItem>
                </CommandGroup>
                <CommandSeparator />
                <CommandGroup heading="Settings">
                    <CommandItem>Profile</CommandItem>
                    <CommandItem>Billing</CommandItem>
                    <CommandItem>Settings</CommandItem>
                </CommandGroup>
            </CommandList>
        </Command>
}
```

---

## ContextMenu

**Import** : `import { ContextMenu } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-context-menu--docs](https://storybook.vendure.io/?path=/docs/ui-context-menu--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <ContextMenu>
            <ContextMenuTrigger className="flex h-[150px] w-[300px] items-center justify-center rounded-md border border-dashed text-sm">
                Right click here
            </ContextMenuTrigger>
            <ContextMenuContent>
                <ContextMenuItem>Back</ContextMenuItem>
                <ContextMenuItem>Forward</ContextMenuItem>
                <ContextMenuItem>Reload</ContextMenuItem>
                <ContextMenuSeparator />
                <ContextMenuItem>Save Page As...</ContextMenuItem>
                <ContextMenuItem>Print...</ContextMenuItem>
            </ContextMenuContent>
        </ContextMenu>
}
```

---

## Dialog

**Import** : `import { Dialog } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-dialog--docs](https://storybook.vendure.io/?path=/docs/ui-dialog--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => {
    const [open, setOpen] = useState(false);
    return <Dialog open={open} onOpenChange={setOpen}>
                <DialogTrigger asChild>
                    <Button>Open Dialog</Button>
                </DialogTrigger>
                <DialogContent>
                    <DialogHeader>
                        <DialogTitle>Dialog Title</DialogTitle>
                        <DialogDescription>
                            This is a dialog description. You can add any content here.
                        </DialogDescription>
                    </DialogHeader>
                    <div className="py-4">Dialog content goes here</div>
                    <DialogFooter>
                        <Button variant="outline" onClick={() => setOpen(false)}>
                            Cancel
                        </Button>
                        <Button onClick={() => setOpen(false)}>Confirm</Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>;
  }
}
```

---

## Drawer

**Import** : `import { Drawer } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-drawer--docs](https://storybook.vendure.io/?path=/docs/ui-drawer--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <Drawer>
            <DrawerTrigger asChild>
                <Button>Open Drawer</Button>
            </DrawerTrigger>
            <DrawerContent>
                <DrawerHeader>
                    <DrawerTitle>Drawer Title</DrawerTitle>
                    <DrawerDescription>This is a drawer description</DrawerDescription>
                </DrawerHeader>
                <div className="p-4">
                    <p>Drawer content goes here</p>
                </div>
                <DrawerFooter>
                    <Button>Submit</Button>
                    <DrawerClose asChild>
                        <Button variant="outline">Cancel</Button>
                    </DrawerClose>
                </DrawerFooter>
            </DrawerContent>
        </Drawer>
}
```

---

## DropdownMenu

**Import** : `import { DropdownMenu } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-dropdown-menu--docs](https://storybook.vendure.io/?path=/docs/ui-dropdown-menu--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <DropdownMenu>
            <DropdownMenuTrigger asChild>
                <Button>Open Menu</Button>
            </DropdownMenuTrigger>
            <DropdownMenuContent>
                <DropdownMenuLabel>My Account</DropdownMenuLabel>
                <DropdownMenuSeparator />
                <DropdownMenuItem>Profile</DropdownMenuItem>
                <DropdownMenuItem>Settings</DropdownMenuItem>
                <DropdownMenuItem>Team</DropdownMenuItem>
                <DropdownMenuSeparator />
                <DropdownMenuItem>Log out</DropdownMenuItem>
            </DropdownMenuContent>
        </DropdownMenu>
}
```

---

## HoverCard

**Import** : `import { HoverCard } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-hover-card--docs](https://storybook.vendure.io/?path=/docs/ui-hover-card--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <HoverCard>
            <HoverCardTrigger asChild>
                <Button variant="link">@username</Button>
            </HoverCardTrigger>
            <HoverCardContent className="w-80">
                <div className="flex justify-between space-x-4">
                    <div className="space-y-1">
                        <h4 className="text-sm font-semibold">@username</h4>
                        <p className="text-sm">
                            The React Framework – created and maintained by @vercel.
                        </p>
                        <div className="flex items-center pt-2">
                            <span className="text-xs text-muted-foreground">Joined December 2021</span>
                        </div>
                    </div>
                </div>
            </HoverCardContent>
        </HoverCard>
}
```

---

## Input

**Import** : `import { Input } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-input--docs](https://storybook.vendure.io/?path=/docs/ui-input--docs)

### Exemples (1)

#### 1. Default

```tsx
<Input
  className="w-[300px]"
  placeholder="Enter text..."
  type="text"
/>
```

---

## InputOTP

**Import** : `import { InputOTP } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-input-otp--docs](https://storybook.vendure.io/?path=/docs/ui-input-otp--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <InputOTP maxLength={6} pattern={REGEXP_ONLY_DIGITS_AND_CHARS}>
            <InputOTPGroup>
                <InputOTPSlot index={0} />
                <InputOTPSlot index={1} />
                <InputOTPSlot index={2} />
                <InputOTPSlot index={3} />
                <InputOTPSlot index={4} />
                <InputOTPSlot index={5} />
            </InputOTPGroup>
        </InputOTP>
}
```

---

## Label

**Import** : `import { Label } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-label--docs](https://storybook.vendure.io/?path=/docs/ui-label--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <div className="flex items-center space-x-2">
            <Checkbox id="terms" />
            <Label htmlFor="terms">Accept terms and conditions</Label>
        </div>
}
```

---

## Menubar

**Import** : `import { Menubar } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-menubar--docs](https://storybook.vendure.io/?path=/docs/ui-menubar--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <Menubar>
            <MenubarMenu>
                <MenubarTrigger>File</MenubarTrigger>
                <MenubarContent>
                    <MenubarItem>New Tab</MenubarItem>
                    <MenubarItem>New Window</MenubarItem>
                    <MenubarSeparator />
                    <MenubarItem>Share</MenubarItem>
                    <MenubarSeparator />
                    <MenubarItem>Print</MenubarItem>
                </MenubarContent>
            </MenubarMenu>
            <MenubarMenu>
                <MenubarTrigger>Edit</MenubarTrigger>
                <MenubarContent>
                    <MenubarItem>Undo</MenubarItem>
                    <MenubarItem>Redo</MenubarItem>
                </MenubarContent>
            </MenubarMenu>
            <MenubarMenu>
                <MenubarTrigger>View</MenubarTrigger>
                <MenubarContent>
                    <MenubarItem>Zoom In</MenubarItem>
                    <MenubarItem>Zoom Out</MenubarItem>
                </MenubarContent>
            </MenubarMenu>
        </Menubar>
}
```

---

## NavigationMenu

**Import** : `import { NavigationMenu } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-navigation-menu--docs](https://storybook.vendure.io/?path=/docs/ui-navigation-menu--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <NavigationMenu>
            <NavigationMenuList>
                <NavigationMenuItem>
                    <NavigationMenuTrigger>Getting started</NavigationMenuTrigger>
                    <NavigationMenuContent>
                        <div className="grid gap-3 p-6 w-[400px]">
                            <NavigationMenuLink className="block p-3 rounded-md hover:bg-accent">
                                <div className="font-medium">Introduction</div>
                                <div className="text-sm text-muted-foreground">
                                    Re-usable components built using Radix UI and Tailwind CSS.
                                </div>
                            </NavigationMenuLink>
                            <NavigationMenuLink className="block p-3 rounded-md hover:bg-accent">
                                <div className="font-medium">Installation</div>
                                <div className="text-sm text-muted-foreground">
                                    How to install dependencies and structure your app.
                                </div>
                            </NavigationMenuLink>
                        </div>
                    </NavigationMenuContent>
                </NavigationMenuItem>
                <NavigationMenuItem>
                    <NavigationMenuLink href="/docs" className="px-4 py-2">
                        Documentation
                    </NavigationMenuLink>
                </NavigationMenuItem>
            </NavigationMenuList>
        </NavigationMenu>
}
```

---

## Pagination

**Import** : `import { Pagination } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-pagination--docs](https://storybook.vendure.io/?path=/docs/ui-pagination--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <Pagination>
            <PaginationContent>
                <PaginationItem>
                    <PaginationPrevious href="#" />
                </PaginationItem>
                <PaginationItem>
                    <PaginationLink href="#">1</PaginationLink>
                </PaginationItem>
                <PaginationItem>
                    <PaginationLink href="#" isActive>
                        2
                    </PaginationLink>
                </PaginationItem>
                <PaginationItem>
                    <PaginationLink href="#">3</PaginationLink>
                </PaginationItem>
                <PaginationItem>
                    <PaginationEllipsis />
                </PaginationItem>
                <PaginationItem>
                    <PaginationNext href="#" />
                </PaginationItem>
            </PaginationContent>
        </Pagination>
}
```

---

## PasswordInput

**Import** : `import { PasswordInput } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-password-input--docs](https://storybook.vendure.io/?path=/docs/ui-password-input--docs)

### Exemples (1)

#### 1. Default

```tsx
<PasswordInput
  className="w-[300px]"
  placeholder="Enter password..."
/>
```

---

## Popover

**Import** : `import { Popover } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-popover--docs](https://storybook.vendure.io/?path=/docs/ui-popover--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <Popover>
            <PopoverTrigger asChild>
                <Button variant="outline">Open popover</Button>
            </PopoverTrigger>
            <PopoverContent className="w-80">
                <div className="grid gap-4">
                    <div className="space-y-2">
                        <h4 className="font-medium leading-none">Dimensions</h4>
                        <p className="text-sm text-muted-foreground">Set the dimensions for the layer.</p>
                    </div>
                </div>
            </PopoverContent>
        </Popover>
}
```

---

## Progress

**Import** : `import { Progress } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-progress--docs](https://storybook.vendure.io/?path=/docs/ui-progress--docs)

### Exemples (1)

#### 1. Default

```tsx
<Progress
  className="w-[300px]"
  value={60}
/>
```

---

## RadioGroup

**Import** : `import { RadioGroup } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-radio-group--docs](https://storybook.vendure.io/?path=/docs/ui-radio-group--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <RadioGroup defaultValue="option-one">
            <div className="flex items-center space-x-2">
                <RadioGroupItem value="option-one" id="option-one" />
                <Label htmlFor="option-one">Option One</Label>
            </div>
            <div className="flex items-center space-x-2">
                <RadioGroupItem value="option-two" id="option-two" />
                <Label htmlFor="option-two">Option Two</Label>
            </div>
            <div className="flex items-center space-x-2">
                <RadioGroupItem value="option-three" id="option-three" />
                <Label htmlFor="option-three">Option Three</Label>
            </div>
        </RadioGroup>
}
```

---

## ResizablePanelGroup

**Import** : `import { ResizablePanelGroup } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-resizable--docs](https://storybook.vendure.io/?path=/docs/ui-resizable--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <ResizablePanelGroup direction="horizontal" className="w-[600px] h-[200px] rounded-lg border">
            <ResizablePanel defaultSize={50}>
                <div className="flex h-full items-center justify-center p-6">
                    <span className="font-semibold">Left Panel</span>
                </div>
            </ResizablePanel>
            <ResizableHandle />
            <ResizablePanel defaultSize={50}>
                <div className="flex h-full items-center justify-center p-6">
                    <span className="font-semibold">Right Panel</span>
                </div>
            </ResizablePanel>
        </ResizablePanelGroup>
}
```

---

## ScrollArea

**Import** : `import { ScrollArea } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-scroll-area--docs](https://storybook.vendure.io/?path=/docs/ui-scroll-area--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <ScrollArea className="h-72 w-48 rounded-md border">
            <div className="p-4">
                <h4 className="mb-4 text-sm font-medium leading-none">Tags</h4>
                {Array.from({
        length: 50
      }).map((_, i) => <div key={i}>
                        <div className="text-sm">Tag {i + 1}</div>
                        <Separator className="my-2" />
                    </div>)}
            </div>
        </ScrollArea>
}
```

---

## Select

**Import** : `import { Select } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-select--docs](https://storybook.vendure.io/?path=/docs/ui-select--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <Select defaultValue="option1">
            <SelectTrigger className="w-[200px]">
                <SelectValue placeholder="Select an option" />
            </SelectTrigger>
            <SelectContent>
                <SelectItem value="option1">Option 1</SelectItem>
                <SelectItem value="option2">Option 2</SelectItem>
                <SelectItem value="option3">Option 3</SelectItem>
                <SelectItem value="option4">Option 4</SelectItem>
            </SelectContent>
        </Select>
}
```

---

## Separator

**Import** : `import { Separator } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-separator--docs](https://storybook.vendure.io/?path=/docs/ui-separator--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <div className="w-[300px]">
            <div className="space-y-1">
                <h4 className="text-sm font-medium leading-none">Radix Primitives</h4>
                <p className="text-sm text-muted-foreground">
                    An open-source UI component library.
                </p>
            </div>
            <Separator className="my-4" />
            <div className="flex h-5 items-center space-x-4 text-sm">
                <div>Blog</div>
                <Separator orientation="vertical" />
                <div>Docs</div>
                <Separator orientation="vertical" />
                <div>Source</div>
            </div>
        </div>
}
```

---

## Sheet

**Import** : `import { Sheet } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-sheet--docs](https://storybook.vendure.io/?path=/docs/ui-sheet--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <Sheet>
            <SheetTrigger asChild>
                <Button>Open Sheet</Button>
            </SheetTrigger>
            <SheetContent>
                <SheetHeader>
                    <SheetTitle>Edit profile</SheetTitle>
                    <SheetDescription>
                        Make changes to your profile here. Click save when you're done.
                    </SheetDescription>
                </SheetHeader>
                <div className="grid gap-4 py-4">
                    <p>Sheet content goes here</p>
                </div>
                <SheetFooter>
                    <SheetClose asChild>
                        <Button type="submit">Save changes</Button>
                    </SheetClose>
                </SheetFooter>
            </SheetContent>
        </Sheet>
}
```

---

## Skeleton

**Import** : `import { Skeleton } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-skeleton--docs](https://storybook.vendure.io/?path=/docs/ui-skeleton--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <div className="flex items-center space-x-4">
            <Skeleton className="h-12 w-12 rounded-full" />
            <div className="space-y-2">
                <Skeleton className="h-4 w-[250px]" />
                <Skeleton className="h-4 w-[200px]" />
            </div>
        </div>
}
```

---

## Slider

**Import** : `import { Slider } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-slider--docs](https://storybook.vendure.io/?path=/docs/ui-slider--docs)

### Exemples (1)

#### 1. Default

```tsx
<Slider
  className="w-[300px]"
  defaultValue={[
    50
  ]}
  max={100}
  step={1}
/>
```

---

## Switch

**Import** : `import { Switch } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-switch--docs](https://storybook.vendure.io/?path=/docs/ui-switch--docs)

### Exemples (1)

#### 1. Default

```tsx
<Switch
/>
```

---

## Table

**Import** : `import { Table } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-table--docs](https://storybook.vendure.io/?path=/docs/ui-table--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <Table className="w-[500px]">
            <TableHeader>
                <TableRow>
                    <TableHead>Name</TableHead>
                    <TableHead>Email</TableHead>
                    <TableHead>Role</TableHead>
                </TableRow>
            </TableHeader>
            <TableBody>
                <TableRow>
                    <TableCell>John Doe</TableCell>
                    <TableCell>john@example.com</TableCell>
                    <TableCell>Admin</TableCell>
                </TableRow>
                <TableRow>
                    <TableCell>Jane Smith</TableCell>
                    <TableCell>jane@example.com</TableCell>
                    <TableCell>User</TableCell>
                </TableRow>
                <TableRow>
                    <TableCell>Bob Johnson</TableCell>
                    <TableCell>bob@example.com</TableCell>
                    <TableCell>User</TableCell>
                </TableRow>
            </TableBody>
        </Table>
}
```

---

## Tabs

**Import** : `import { Tabs } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-tabs--docs](https://storybook.vendure.io/?path=/docs/ui-tabs--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <Tabs defaultValue="tab1" className="w-[400px]">
            <TabsList>
                <TabsTrigger value="tab1">Tab 1</TabsTrigger>
                <TabsTrigger value="tab2">Tab 2</TabsTrigger>
                <TabsTrigger value="tab3">Tab 3</TabsTrigger>
            </TabsList>
            <TabsContent value="tab1">Content for Tab 1</TabsContent>
            <TabsContent value="tab2">Content for Tab 2</TabsContent>
            <TabsContent value="tab3">Content for Tab 3</TabsContent>
        </Tabs>
}
```

---

## Textarea

**Import** : `import { Textarea } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-textarea--docs](https://storybook.vendure.io/?path=/docs/ui-textarea--docs)

### Exemples (1)

#### 1. Default

```tsx
<Textarea
  className="w-[400px]"
  placeholder="Type your message here..."
/>
```

---

## Toggle

**Import** : `import { Toggle } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-toggle--docs](https://storybook.vendure.io/?path=/docs/ui-toggle--docs)

### Exemples (1)

#### 1. Default

```tsx
<Toggle
  size="default"
  variant="default"
>
  <Bold className="h-4 w-4" />
</Toggle>
```

---

## ToggleGroup

**Import** : `import { ToggleGroup } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-toggle-group--docs](https://storybook.vendure.io/?path=/docs/ui-toggle-group--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <ToggleGroup type="multiple">
            <ToggleGroupItem value="bold" aria-label="Toggle bold">
                <Bold className="h-4 w-4" />
            </ToggleGroupItem>
            <ToggleGroupItem value="italic" aria-label="Toggle italic">
                <Italic className="h-4 w-4" />
            </ToggleGroupItem>
            <ToggleGroupItem value="underline" aria-label="Toggle underline">
                <Underline className="h-4 w-4" />
            </ToggleGroupItem>
        </ToggleGroup>
}
```

---

## Tooltip

**Import** : `import { Tooltip } from '@vendure/dashboard';`

**Storybook** : [https://storybook.vendure.io/?path=/docs/ui-tooltip--docs](https://storybook.vendure.io/?path=/docs/ui-tooltip--docs)

### Exemples (1)

#### 1. Default

```tsx
{
  render: () => <TooltipProvider>
            <Tooltip>
                <TooltipTrigger asChild>
                    <Button>Hover me</Button>
                </TooltipTrigger>
                <TooltipContent>
                    <p>This is a tooltip</p>
                </TooltipContent>
            </Tooltip>
        </TooltipProvider>
}
```

---

## 📚 Ressources

- [Storybook Vendure](https://storybook.vendure.io)
- [Documentation Vendure](https://docs.vendure.io)
