<picture>
    <source srcset="docs/banner-dark.png" media="(prefers-color-scheme: dark)">
    <source srcset="docs/banner-light.png" media="(prefers-color-scheme: light)">
    <img src="docs/banner-light.png" alt="SovereignsUI Banner">
</picture>

![Lint](https://github.com/rxinoussouls/SovereignsUI/actions/workflows/lint.yml/badge.svg)
![Stars](https://img.shields.io/github/stars/rxinoussouls/SovereignsUI?style=flat-square)
![Last Commit](https://img.shields.io/github/last-commit/rxinoussouls/SovereignsUI?style=flat-square)
![License](https://img.shields.io/github/license/rxinoussouls/SovereignsUI?style=flat-square)

> [!WARNING]
> SovereignsUI is currently in **Beta**. This project is under active development —
> bugs, breaking changes, and unstable features may occur. Please report issues
> you run into.

A single-file Roblox UI library — windows, tabs, sub-tabs, toggles, sliders,
dropdowns, keybinds, a color picker, notifications, theming, and a built-in
config save/load system.

## Install

```luau
loadstring(game:HttpGet("https://sovereigns-ui.vercel.app/main.lua"))()
```

## Quick start

```luau
local Library = loadstring(game:HttpGet("https://sovereigns-ui.vercel.app/main.lua"))()

local Window = Library:CreateWindow({
    Name = "My Menu",
    Size = UDim2.fromOffset(700, 490),
    Theme = "Black",
    Accent = "#8B5CF6",
    Font = "Gotham",
})

local Tab = Window:AddTab({ Name = "Main", Icon = "home" })
local General = Tab:AddSubTab("General")

General:AddToggle({
    Name = "Enable Feature",
    Default = false,
    Flag = "enableFeature",
    Callback = function(value) print("toggled:", value) end,
})
```

## Features

- Window / Tab / SubTab navigation with icons
- Elements: Toggle, Button, Slider, Dropdown, MultiDropdown, ColorPicker,
  Keybind, Input, Label, Paragraph, Section, Divider
- `Library.Flags` — get/set every element's value by name
- Config system: `Library:SaveConfig`, `LoadConfig`, `ListConfigs`, `DeleteConfig`
- Built-in themes (`Dark`, `Light`, `OLED`, `White`, `Black`) plus custom theme tables
- Notification system with `info` / `success` / `warning` / `error` styles, stacked bottom-right
- Liquid-glass window, Dynamic Island minimize state, animated toggles and sliders
- Accent colors from `Color3`, Hex, RGB strings, or RGB tables
- Runtime font selection through `Library:SetFont()` and `Library.Fonts`

## Customizing

Colors, spacing, and animation timing live in the `C` and `TWEEN` tables near
the top of `main.lua`. Themes can be changed at runtime:

```luau
Library:SetTheme("White")
Library:SetAccent("#8B5CF6")
Library:SetAccent({ r = 34, g = 197, b = 94 })
Library:SetFont("SourceSans")
```

Available font keys are `Gotham`, `SourceSans`, `Arial`, `Code`, `Fantasy`,
`SciFi`, `Cartoon`, and `Arcade`. Icons are keyed by name in the `ICONS` table.
For Lucide icons, upload the SVG/PNG to Roblox first, then register the resulting
asset ID:

```luau
Library:RegisterIcon("sparkles", "rbxassetid://1234567890")
```

Roblox ImageLabels cannot render a Lucide website URL directly, so the upload
step is required for executor compatibility.

## Hosting

This repo is deployed on Vercel with `Cache-Control: no-store` (see
`vercel.json`), so every push to `main` is live immediately with no CDN
caching delay.

## License

MIT — see [LICENSE](./LICENSE).
