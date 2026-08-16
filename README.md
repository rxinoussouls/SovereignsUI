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
- Built-in themes (`Dark`, `Light`, `OLED`) plus custom theme tables
- Notification system with `info` / `success` / `warning` / `error` styles

## Customizing

Colors, spacing, and animation timing live in the `C` and `TWEEN` tables near
the top of `main.lua`. Icons are keyed by name in the `ICONS` table — pass any
of those keys, or a raw `rbxassetid://...`, to `Icon = ...` on tabs.

## Hosting

This repo is deployed on Vercel with `Cache-Control: no-store` (see
`vercel.json`), so every push to `main` is live immediately with no CDN
caching delay.

## License

MIT — see [LICENSE](./LICENSE).
