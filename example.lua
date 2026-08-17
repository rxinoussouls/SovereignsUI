--[[
    SovereignsUI — Example
    A general game "Settings" menu: General, Gameplay, Display, Audio,
    Keybinds, and About — the standard tab layout most games ship with.

    Run with:
        loadstring(game:HttpGet("https://sovereigns-ui.vercel.app/example.lua"))()
--]]

local Library = loadstring(game:HttpGet("https://sovereigns-ui.vercel.app/main.lua"))()

-- ── Window ──────────────────────────────────────────────────────────────
local Window = Library:CreateWindow({
    Name     = "Settings",
    Size     = UDim2.fromOffset(700, 490),
    Position = UDim2.fromScale(0.5, 0.5),
    GuiName  = "SovereignsSettingsExample",
})

-- ── Tabs ────────────────────────────────────────────────────────────────
local GeneralTab  = Window:AddTab({ Name = "General",  Icon = "home" })
local Basics      = GeneralTab:AddSubTab("Basics")

local GameplayTab = Window:AddTab({ Name = "Gameplay", Icon = "sliders" })
local Gameplay    = GameplayTab:AddSubTab("Gameplay")

local DisplayTab  = Window:AddTab({ Name = "Display",  Icon = "eye" })
local Display     = DisplayTab:AddSubTab("Display")

local AudioTab    = Window:AddTab({ Name = "Audio",    Icon = "volume" })
local Audio       = AudioTab:AddSubTab("Audio")

local KeybindsTab = Window:AddTab({ Name = "Keybinds", Icon = "gamepad" })
local Keybinds    = KeybindsTab:AddSubTab("Keybinds")

local AboutTab    = Window:AddTab({ Name = "About",    Icon = "info" })
local About       = AboutTab:AddSubTab("About")

-- ── General: Basics ─────────────────────────────────────────────────────
Basics:AddSection("Startup")

Basics:AddToggle({
    Name = "Show Tips on Launch", Default = true, Flag = "showTips",
    Callback = function(value) print("Show tips:", value) end,
})

Basics:AddDropdown({
    Name = "Language", Options = { "English", "\u0e44\u0e17\u0e22", "\u65e5\u672c\u8a9e" }, Default = "English",
    Callback = function(value) print("Language:", value) end,
})

Basics:AddButton({
    Name = "Reset All Settings",
    Callback = function()
        Library:Notify({ Title = "Settings", Content = "All settings reset to default.", Style = "warning" })
    end,
})

-- ── Gameplay ────────────────────────────────────────────────────────────
Gameplay:AddSection("Difficulty")

Gameplay:AddDropdown({
    Name = "Difficulty", Options = { "Easy", "Normal", "Hard" }, Default = "Normal",
    Callback = function(value) print("Difficulty:", value) end,
})

Gameplay:AddToggle({
    Name = "Auto-Sprint", Default = false, Flag = "autoSprint",
    Callback = function(value) print("Auto-sprint:", value) end,
})

Gameplay:AddSlider({
    Name = "Camera Sensitivity", Min = 1, Max = 10, Default = 5, Flag = "camSensitivity",
    Callback = function(value) print("Sensitivity:", value) end,
})

Gameplay:AddToggle({
    Name = "Camera Shake", Default = true, Flag = "camShake",
    Callback = function(value) print("Camera shake:", value) end,
})

-- ── Display ─────────────────────────────────────────────────────────────
Display:AddSection("Interface")

Display:AddSlider({
    Name = "UI Scale", Min = 80, Max = 120, Default = 100, Flag = "uiScale",
    Callback = function(value) print("UI scale:", value) end,
})

Display:AddToggle({
    Name = "Show FPS Counter", Default = false, Flag = "showFps",
    Callback = function(value) print("FPS counter:", value) end,
})

Display:AddDropdown({
    Name = "Theme", Options = {
        "Dark", "Light", "OLED", "Emerald", "Plant",
        "MonokaiPro", "Midnight", "Violet", "Rose", "Gold",
    }, Default = "Dark",
    Callback = function(theme) Library:SetTheme(theme) end,
})

Display:AddColorPicker({
    Name = "Accent Color", Default = Color3.fromRGB(167, 200, 244),
    Callback = function(color) print("Accent:", color) end,
})

-- ── Audio ───────────────────────────────────────────────────────────────
Audio:AddSection("Volume")

Audio:AddSlider({ Name = "Master Volume", Min = 0, Max = 100, Default = 80, Flag = "masterVol" })
Audio:AddSlider({ Name = "Music Volume",  Min = 0, Max = 100, Default = 60, Flag = "musicVol" })
Audio:AddSlider({ Name = "SFX Volume",    Min = 0, Max = 100, Default = 90, Flag = "sfxVol" })

Audio:AddToggle({
    Name = "Mute When Unfocused", Default = true, Flag = "muteUnfocused",
})

-- ── Keybinds ────────────────────────────────────────────────────────────
Keybinds:AddSection("Controls")

Keybinds:AddKeybind({
    Name = "Toggle Menu", Default = Enum.KeyCode.RightShift,
    Callback = function(key) print("Menu key:", key.Name) end,
})

Keybinds:AddKeybind({
    Name = "Sprint", Default = Enum.KeyCode.LeftShift,
    Callback = function(key) print("Sprint key:", key.Name) end,
})

Keybinds:AddKeybind({
    Name = "Interact", Default = Enum.KeyCode.E,
    Callback = function(key) print("Interact key:", key.Name) end,
})

-- ── About ───────────────────────────────────────────────────────────────
About:AddSection("Info")

About:AddParagraph({
    Title = "SovereignsUI",
    Text  = "A single-file Roblox UI library. This example demonstrates a "
        .. "typical game settings layout using every element type.",
})

About:AddInput({ Name = "Config Name", Placeholder = "my-config", Flag = "configName" })

About:AddButton({
    Name = "Save Config", Primary = true,
    Callback = function()
        local name = Library:GetFlag("configName")
        if name == "" or name == nil then
            Library:Notify({ Title = "Config", Content = "Type a name first.", Style = "warning" })
            return
        end
        Library:SaveConfig(name)
        Library:Notify({ Title = "Config", Content = "Saved '" .. name .. "'.", Style = "success" })
    end,
})

About:AddButton({
    Name = "Load Config",
    Callback = function()
        local name = Library:GetFlag("configName")
        if name == "" or name == nil then return end
        Library:LoadConfig(name)
        Library:Notify({ Title = "Config", Content = "Loaded '" .. name .. "'.", Style = "info" })
    end,
})

-- ── Startup notification ───────────────────────────────────────────────
Library:Notify({
    Title = "Settings", Content = "Menu loaded successfully.",
    Style = "success", Duration = 3,
})
