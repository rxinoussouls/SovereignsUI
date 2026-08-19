local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local GuiService       = game:GetService("GuiService")
local Players          = game:GetService("Players")
local Stats            = game:GetService("Stats")
local RunService       = game:GetService("RunService")
local AssetService     = game:GetService("AssetService")
local TextService      = game:GetService("TextService")
local HttpService      = game:GetService("HttpService")
local Workspace        = game:GetService("Workspace")

local DEFAULT_LOGO = "rbxassetid://114345069590059"
local TWEEN = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local NOTIFICATION_TWEEN = TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local PROFILE_TWEEN = TweenInfo.new(0.32, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

-- ════════════════════════════════════════════════════════════════════════════
-- BUILT-IN ICON LIBRARY
-- ════════════════════════════════════════════════════════════════════════════
-- Verified real Lucide-icon Roblox asset ids, sourced from the widely-used
-- public Fluent UI library's icon pack (github.com/dawid-scripts/Fluent —
-- one of the most-installed Roblox UI libraries, so these ids are known to
-- resolve). Several keys below previously pointed at placeholder ids
-- (11111111111) or, worse, at the WRONG real icon (e.g. "grid" was
-- pointing at the settings-gear id, "combat"/"sword" was pointing at the
-- ✕ close icon) — those are corrected here, and formerly-shared ids that
-- should be distinct (music vs volume, file vs save, code vs terminal)
-- are now split apart.
local ICONS = {
    home            = "rbxassetid://10723407389", -- lucide-home
    dashboard       = "rbxassetid://10723424646", -- lucide-layout-dashboard
    search          = "rbxassetid://10734943674", -- lucide-search
    settings        = "rbxassetid://10734950309", -- lucide-settings
    gear            = "rbxassetid://10709810948", -- lucide-cog
    menu            = "rbxassetid://10734887784", -- lucide-menu
    list            = "rbxassetid://10723433811", -- lucide-list
    grid            = "rbxassetid://10723404936", -- lucide-grid
    sliders         = "rbxassetid://10734963400", -- lucide-sliders
    swords          = "rbxassetid://10734975692", -- lucide-swords
    sword           = "rbxassetid://10734975486", -- lucide-sword
    combat          = "rbxassetid://10734975692", -- lucide-swords
    shield          = "rbxassetid://10734951847", -- lucide-shield
    target          = "rbxassetid://10734977012", -- lucide-target
    crosshair       = "rbxassetid://10723377537", -- lucide-focus (closest available)
    aim             = "rbxassetid://10723377537", -- lucide-focus
    bolt            = "rbxassetid://10709774068", -- lucide-battery-charging (no lucide-zap in this pack)
    lightning       = "rbxassetid://10709774068",
    zap             = "rbxassetid://10709774068",
    fire            = "rbxassetid://10723376114", -- lucide-flame
    flame           = "rbxassetid://10723376114", -- lucide-flame
    star            = "rbxassetid://10734966248", -- lucide-star
    sparkle         = "rbxassetid://10747376349", -- lucide-wand-2
    player          = "rbxassetid://10747373176", -- lucide-user
    user            = "rbxassetid://10747373176", -- lucide-user
    person          = "rbxassetid://10747373176", -- lucide-user
    users           = "rbxassetid://10747373426", -- lucide-users
    team            = "rbxassetid://10747373426", -- lucide-users
    group           = "rbxassetid://10747373426", -- lucide-users
    eye             = "rbxassetid://10723346959", -- lucide-eye
    visible         = "rbxassetid://10723346959", -- lucide-eye
    visuals         = "rbxassetid://10723346959", -- lucide-eye
    render          = "rbxassetid://10723346959", -- lucide-eye
    esp             = "rbxassetid://10723346959", -- lucide-eye
    eyeoff          = "rbxassetid://10723346871", -- lucide-eye-off
    hidden          = "rbxassetid://10723346871", -- lucide-eye-off
    globe           = "rbxassetid://10723404337", -- lucide-globe
    world           = "rbxassetid://10723404337", -- lucide-globe
    compass         = "rbxassetid://10709811445", -- lucide-compass
    map             = "rbxassetid://10734886202", -- lucide-map
    move            = "rbxassetid://10734900011", -- lucide-move
    arrows          = "rbxassetid://10734900011", -- lucide-move
    heart           = "rbxassetid://10723406885", -- lucide-heart
    like            = "rbxassetid://10723406885", -- lucide-heart
    bell            = "rbxassetid://10709775704", -- lucide-bell
    notification    = "rbxassetid://10709775704", -- lucide-bell
    alert           = "rbxassetid://10709775704", -- lucide-bell
    info            = "rbxassetid://10723415903", -- lucide-info
    about           = "rbxassetid://10723415903", -- lucide-info
    help            = "rbxassetid://10723406988", -- lucide-help-circle
    warning         = "rbxassetid://10709753149", -- lucide-alert-triangle
    caution         = "rbxassetid://10709753149", -- lucide-alert-triangle
    check           = "rbxassetid://10709790644", -- lucide-check
    checkmark       = "rbxassetid://10709790644", -- lucide-check
    lock            = "rbxassetid://10723434711", -- lucide-lock
    unlock          = "rbxassetid://10747366027", -- lucide-unlock
    power           = "rbxassetid://10734930466", -- lucide-power
    toggle          = "rbxassetid://10734984834", -- lucide-toggle-left
    refresh         = "rbxassetid://10734933222", -- lucide-refresh-cw
    folder          = "rbxassetid://10723387563", -- lucide-folder
    file            = "rbxassetid://10723374641", -- lucide-file
    save            = "rbxassetid://10734941499", -- lucide-save
    download        = "rbxassetid://10723344270", -- lucide-download
    clipboard       = "rbxassetid://10709799288", -- lucide-clipboard
    chat            = "rbxassetid://10734888000", -- lucide-message-circle
    message         = "rbxassetid://10734888000", -- lucide-message-circle
    play            = "rbxassetid://10734923549", -- lucide-play
    music           = "rbxassetid://10734905958", -- lucide-music
    volume          = "rbxassetid://10747375679", -- lucide-volume-2
    camera          = "rbxassetid://10709789686", -- lucide-camera
    image           = "rbxassetid://10723415040", -- lucide-image
    clock           = "rbxassetid://10709805144", -- lucide-clock
    time            = "rbxassetid://10709805144", -- lucide-clock
    timer           = "rbxassetid://10734984606", -- lucide-timer
    wrench          = "rbxassetid://10747383470", -- lucide-wrench
    tool            = "rbxassetid://10747383470", -- lucide-wrench
    code            = "rbxassetid://10709810463", -- lucide-code
    terminal        = "rbxassetid://10734982144", -- lucide-terminal
    script          = "rbxassetid://10709810463", -- lucide-code
    bug             = "rbxassetid://10709782845", -- lucide-bug
    debug           = "rbxassetid://10709782845", -- lucide-bug
    layers          = "rbxassetid://10723424505", -- lucide-layers
    inventory       = "rbxassetid://10709769841", -- lucide-backpack
    backpack        = "rbxassetid://10709769841", -- lucide-backpack
    box             = "rbxassetid://10709782497", -- lucide-box
    package         = "rbxassetid://10734909540", -- lucide-package
    gift            = "rbxassetid://10723396402", -- lucide-gift
    crown           = "rbxassetid://10709818626", -- lucide-crown
    gem             = "rbxassetid://10723396000", -- lucide-gem
    coin            = "rbxassetid://10709811110", -- lucide-coins
    magic           = "rbxassetid://10747376349", -- lucide-wand-2
    wand            = "rbxassetid://10747376349", -- lucide-wand-2
    potion          = "rbxassetid://10734883986", -- lucide-flask-conical
    skull           = "rbxassetid://10734962068", -- lucide-skull
    death           = "rbxassetid://10734962068", -- lucide-skull
    gamepad         = "rbxassetid://10723395215", -- lucide-gamepad-2
    controller      = "rbxassetid://10723395215", -- lucide-gamepad-2
    teleport        = "rbxassetid://10734906744", -- lucide-navigation
    speed           = "rbxassetid://10723395708", -- lucide-gauge
    running         = "rbxassetid://10709752035", -- lucide-activity
    favorite        = "rbxassetid://10734966248", -- lucide-star
}

local NOTIFICATION_STYLES = {
    info    = { Name = "Info",    Color = Color3.fromRGB(118, 151, 194), Icon = "rbxassetid://10723415903" }, -- lucide-info
    success = { Name = "Success", Color = Color3.fromRGB(105, 166, 124), Icon = "rbxassetid://10709790387" }, -- lucide-check-circle-2
    warning = { Name = "Warning", Color = Color3.fromRGB(190, 154, 84),  Icon = "rbxassetid://10709753149" }, -- lucide-alert-triangle
    error   = { Name = "Error",   Color = Color3.fromRGB(190, 99, 99),   Icon = "rbxassetid://10747383819" }, -- lucide-x-circle
}

local C = {
    WindowBg     = Color3.fromRGB(20, 20, 20),
    CardBg       = Color3.fromRGB(24, 24, 24),
    Border       = Color3.fromRGB(35, 35, 35),
    Element      = Color3.fromRGB(31, 31, 31),
    ElementHover = Color3.fromRGB(38, 38, 38),
    Badge        = Color3.fromRGB(42, 42, 42),
    BadgeIdle    = Color3.fromRGB(34, 34, 34),
    NavActive    = Color3.fromRGB(30, 30, 30),
    NavHover     = Color3.fromRGB(26, 26, 26),
    PillActive   = Color3.fromRGB(36, 36, 36),
    White        = Color3.fromRGB(255, 255, 255),
    TextGray     = Color3.fromRGB(154, 154, 154),
    TextDim      = Color3.fromRGB(139, 139, 139),
    KnobOff      = Color3.fromRGB(85, 85, 85),
    KnobOn       = Color3.fromRGB(17, 17, 17),
    TrackBg      = Color3.fromRGB(43, 43, 43),
    Placeholder  = Color3.fromRGB(86, 86, 86),
    HotbarBg     = Color3.fromRGB(24, 24, 24),
    HotbarBorder = Color3.fromRGB(35, 35, 35),
    HotbarActive = Color3.fromRGB(31, 31, 31),
    HotbarHover  = Color3.fromRGB(38, 38, 38),
    HotbarDot    = Color3.fromRGB(220, 220, 220),
    Accent       = Color3.fromRGB(167, 200, 244),
    AccentDim    = Color3.fromRGB(26, 46, 74),
    AccentText   = Color3.fromRGB(10, 16, 26),
    KnobAccent   = Color3.fromRGB(16, 22, 32),
}

local THEMES = {
    Dark = table.clone(C),
    Light = {
        WindowBg     = Color3.fromRGB(245, 245, 245),
        CardBg       = Color3.fromRGB(249, 249, 249),
        Border       = Color3.fromRGB(218, 218, 218),
        Element      = Color3.fromRGB(235, 235, 235),
        ElementHover = Color3.fromRGB(229, 229, 229),
        Badge        = Color3.fromRGB(224, 224, 224),
        BadgeIdle    = Color3.fromRGB(232, 232, 232),
        NavActive    = Color3.fromRGB(238, 238, 238),
        NavHover     = Color3.fromRGB(242, 242, 242),
        PillActive   = Color3.fromRGB(226, 226, 226),
        White        = Color3.fromRGB(20, 20, 20),
        TextGray     = Color3.fromRGB(84, 84, 84),
        TextDim      = Color3.fromRGB(105, 105, 105),
        KnobOff      = Color3.fromRGB(150, 150, 150),
        KnobOn       = Color3.fromRGB(250, 250, 250),
        TrackBg      = Color3.fromRGB(210, 210, 210),
        Placeholder  = Color3.fromRGB(135, 135, 135),
        HotbarBg     = Color3.fromRGB(249, 249, 249),
        HotbarBorder = Color3.fromRGB(218, 218, 218),
        HotbarActive = Color3.fromRGB(235, 235, 235),
        HotbarHover  = Color3.fromRGB(229, 229, 229),
        HotbarDot    = Color3.fromRGB(60, 60, 60),
        Accent       = Color3.fromRGB(94, 148, 214),
        AccentDim    = Color3.fromRGB(198, 220, 248),
        AccentText   = Color3.fromRGB(255, 255, 255),
        KnobAccent   = Color3.fromRGB(255, 255, 255),
    },
    OLED = {
        WindowBg     = Color3.fromRGB(0, 0, 0),
        CardBg       = Color3.fromRGB(5, 5, 5),
        Border       = Color3.fromRGB(25, 25, 25),
        Element      = Color3.fromRGB(12, 12, 12),
        ElementHover = Color3.fromRGB(20, 20, 20),
        Badge        = Color3.fromRGB(28, 28, 28),
        BadgeIdle    = Color3.fromRGB(16, 16, 16),
        NavActive    = Color3.fromRGB(9, 9, 9),
        NavHover     = Color3.fromRGB(6, 6, 6),
        PillActive   = Color3.fromRGB(22, 22, 22),
        White        = Color3.fromRGB(255, 255, 255),
        TextGray     = Color3.fromRGB(165, 165, 165),
        TextDim      = Color3.fromRGB(125, 125, 125),
        KnobOff      = Color3.fromRGB(75, 75, 75),
        KnobOn       = Color3.fromRGB(3, 3, 3),
        TrackBg      = Color3.fromRGB(32, 32, 32),
        Placeholder  = Color3.fromRGB(90, 90, 90),
        HotbarBg     = Color3.fromRGB(5, 5, 5),
        HotbarBorder = Color3.fromRGB(25, 25, 25),
        HotbarActive = Color3.fromRGB(12, 12, 12),
        HotbarHover  = Color3.fromRGB(20, 20, 20),
        HotbarDot    = Color3.fromRGB(200, 200, 200),
        Accent       = Color3.fromRGB(178, 210, 250),
        AccentDim    = Color3.fromRGB(16, 32, 56),
        AccentText   = Color3.fromRGB(5, 9, 16),
        KnobAccent   = Color3.fromRGB(8, 12, 20),
    },
    -- Deep emerald green, premium and calm. Good fit for finance-style panels.
    Emerald = {
        WindowBg     = Color3.fromRGB(14, 18, 16),
        CardBg       = Color3.fromRGB(18, 22, 20),
        Border       = Color3.fromRGB(30, 38, 34),
        Element      = Color3.fromRGB(24, 30, 27),
        ElementHover = Color3.fromRGB(30, 38, 34),
        Badge        = Color3.fromRGB(36, 44, 40),
        BadgeIdle    = Color3.fromRGB(22, 28, 25),
        NavActive    = Color3.fromRGB(16, 20, 18),
        NavHover     = Color3.fromRGB(12, 16, 14),
        PillActive   = Color3.fromRGB(28, 36, 32),
        White        = Color3.fromRGB(255, 255, 255),
        TextGray     = Color3.fromRGB(150, 165, 158),
        TextDim      = Color3.fromRGB(120, 135, 128),
        KnobOff      = Color3.fromRGB(80, 95, 88),
        KnobOn       = Color3.fromRGB(10, 16, 14),
        TrackBg      = Color3.fromRGB(36, 46, 42),
        Placeholder  = Color3.fromRGB(85, 100, 93),
        HotbarBg     = Color3.fromRGB(18, 22, 20),
        HotbarBorder = Color3.fromRGB(30, 38, 34),
        HotbarActive = Color3.fromRGB(24, 30, 27),
        HotbarHover  = Color3.fromRGB(30, 38, 34),
        HotbarDot    = Color3.fromRGB(210, 225, 218),
        Accent       = Color3.fromRGB(52, 199, 143),
        AccentDim    = Color3.fromRGB(16, 46, 36),
        AccentText   = Color3.fromRGB(6, 20, 16),
        KnobAccent   = Color3.fromRGB(10, 28, 22),
    },
    -- Fresh natural green, brighter and warmer than Emerald.
    Plant = {
        WindowBg     = Color3.fromRGB(16, 20, 15),
        CardBg       = Color3.fromRGB(20, 25, 18),
        Border       = Color3.fromRGB(34, 42, 30),
        Element      = Color3.fromRGB(26, 32, 23),
        ElementHover = Color3.fromRGB(33, 40, 29),
        Badge        = Color3.fromRGB(40, 48, 35),
        BadgeIdle    = Color3.fromRGB(24, 30, 21),
        NavActive    = Color3.fromRGB(18, 22, 16),
        NavHover     = Color3.fromRGB(14, 18, 13),
        PillActive   = Color3.fromRGB(30, 38, 27),
        White        = Color3.fromRGB(255, 255, 255),
        TextGray     = Color3.fromRGB(160, 172, 150),
        TextDim      = Color3.fromRGB(128, 140, 118),
        KnobOff      = Color3.fromRGB(85, 98, 78),
        KnobOn       = Color3.fromRGB(10, 14, 9),
        TrackBg      = Color3.fromRGB(38, 48, 34),
        Placeholder  = Color3.fromRGB(90, 102, 80),
        HotbarBg     = Color3.fromRGB(20, 25, 18),
        HotbarBorder = Color3.fromRGB(34, 42, 30),
        HotbarActive = Color3.fromRGB(26, 32, 23),
        HotbarHover  = Color3.fromRGB(33, 40, 29),
        HotbarDot    = Color3.fromRGB(215, 228, 205),
        Accent       = Color3.fromRGB(120, 209, 120),
        AccentDim    = Color3.fromRGB(24, 52, 26),
        AccentText   = Color3.fromRGB(8, 20, 10),
        KnobAccent   = Color3.fromRGB(14, 30, 16),
    },
    -- Coding-inspired dark olive-grey base with a warm orange highlight.
    MonokaiPro = {
        WindowBg     = Color3.fromRGB(24, 26, 22),
        CardBg       = Color3.fromRGB(30, 32, 27),
        Border       = Color3.fromRGB(46, 48, 40),
        Element      = Color3.fromRGB(36, 38, 32),
        ElementHover = Color3.fromRGB(44, 46, 38),
        Badge        = Color3.fromRGB(52, 54, 44),
        BadgeIdle    = Color3.fromRGB(32, 34, 28),
        NavActive    = Color3.fromRGB(26, 28, 23),
        NavHover     = Color3.fromRGB(20, 22, 18),
        PillActive   = Color3.fromRGB(40, 42, 35),
        White        = Color3.fromRGB(255, 255, 255),
        TextGray     = Color3.fromRGB(170, 168, 150),
        TextDim      = Color3.fromRGB(135, 133, 118),
        KnobOff      = Color3.fromRGB(95, 92, 80),
        KnobOn       = Color3.fromRGB(14, 15, 12),
        TrackBg      = Color3.fromRGB(48, 50, 42),
        Placeholder  = Color3.fromRGB(100, 98, 85),
        HotbarBg     = Color3.fromRGB(30, 32, 27),
        HotbarBorder = Color3.fromRGB(46, 48, 40),
        HotbarActive = Color3.fromRGB(36, 38, 32),
        HotbarHover  = Color3.fromRGB(44, 46, 38),
        HotbarDot    = Color3.fromRGB(255, 216, 102),
        Accent       = Color3.fromRGB(252, 151, 105),
        AccentDim    = Color3.fromRGB(58, 34, 20),
        AccentText   = Color3.fromRGB(10, 6, 3),
        KnobAccent   = Color3.fromRGB(24, 15, 9),
    },
    -- Deep midnight navy/indigo. Professional and moody.
    Midnight = {
        WindowBg     = Color3.fromRGB(10, 14, 26),
        CardBg       = Color3.fromRGB(14, 18, 32),
        Border       = Color3.fromRGB(26, 32, 50),
        Element      = Color3.fromRGB(18, 24, 40),
        ElementHover = Color3.fromRGB(24, 30, 48),
        Badge        = Color3.fromRGB(30, 38, 56),
        BadgeIdle    = Color3.fromRGB(18, 24, 40),
        NavActive    = Color3.fromRGB(12, 16, 28),
        NavHover     = Color3.fromRGB(8, 12, 22),
        PillActive   = Color3.fromRGB(22, 28, 46),
        White        = Color3.fromRGB(255, 255, 255),
        TextGray     = Color3.fromRGB(150, 160, 185),
        TextDim      = Color3.fromRGB(110, 120, 145),
        KnobOff      = Color3.fromRGB(75, 85, 110),
        KnobOn       = Color3.fromRGB(8, 10, 18),
        TrackBg      = Color3.fromRGB(30, 38, 58),
        Placeholder  = Color3.fromRGB(85, 95, 120),
        HotbarBg     = Color3.fromRGB(14, 18, 32),
        HotbarBorder = Color3.fromRGB(26, 32, 50),
        HotbarActive = Color3.fromRGB(18, 24, 40),
        HotbarHover  = Color3.fromRGB(24, 30, 48),
        HotbarDot    = Color3.fromRGB(200, 215, 240),
        Accent       = Color3.fromRGB(110, 150, 240),
        AccentDim    = Color3.fromRGB(22, 30, 58),
        AccentText   = Color3.fromRGB(6, 10, 20),
        KnobAccent   = Color3.fromRGB(12, 18, 32),
    },
    -- Violet / lavender. Creative, premium, tech-forward.
    Violet = {
        WindowBg     = Color3.fromRGB(18, 14, 24),
        CardBg       = Color3.fromRGB(24, 18, 32),
        Border       = Color3.fromRGB(42, 32, 54),
        Element      = Color3.fromRGB(32, 24, 42),
        ElementHover = Color3.fromRGB(40, 30, 52),
        Badge        = Color3.fromRGB(48, 36, 62),
        BadgeIdle    = Color3.fromRGB(28, 21, 37),
        NavActive    = Color3.fromRGB(20, 15, 27),
        NavHover     = Color3.fromRGB(15, 11, 20),
        PillActive   = Color3.fromRGB(38, 28, 50),
        White        = Color3.fromRGB(255, 255, 255),
        TextGray     = Color3.fromRGB(175, 160, 185),
        TextDim      = Color3.fromRGB(138, 125, 148),
        KnobOff      = Color3.fromRGB(100, 88, 112),
        KnobOn       = Color3.fromRGB(12, 9, 16),
        TrackBg      = Color3.fromRGB(46, 36, 58),
        Placeholder  = Color3.fromRGB(105, 92, 118),
        HotbarBg     = Color3.fromRGB(24, 18, 32),
        HotbarBorder = Color3.fromRGB(42, 32, 54),
        HotbarActive = Color3.fromRGB(32, 24, 42),
        HotbarHover  = Color3.fromRGB(40, 30, 52),
        HotbarDot    = Color3.fromRGB(225, 210, 240),
        Accent       = Color3.fromRGB(176, 138, 240),
        AccentDim    = Color3.fromRGB(38, 26, 58),
        AccentText   = Color3.fromRGB(10, 7, 18),
        KnobAccent   = Color3.fromRGB(20, 14, 32),
    },
    -- Rose gold. Warm, soft, fashion-forward.
    Rose = {
        WindowBg     = Color3.fromRGB(24, 16, 18),
        CardBg       = Color3.fromRGB(30, 20, 23),
        Border       = Color3.fromRGB(52, 34, 38),
        Element      = Color3.fromRGB(40, 26, 29),
        ElementHover = Color3.fromRGB(49, 32, 36),
        Badge        = Color3.fromRGB(58, 38, 42),
        BadgeIdle    = Color3.fromRGB(34, 22, 25),
        NavActive    = Color3.fromRGB(24, 16, 18),
        NavHover     = Color3.fromRGB(18, 12, 14),
        PillActive   = Color3.fromRGB(46, 30, 34),
        White        = Color3.fromRGB(255, 255, 255),
        TextGray     = Color3.fromRGB(190, 165, 168),
        TextDim      = Color3.fromRGB(150, 130, 133),
        KnobOff      = Color3.fromRGB(110, 88, 90),
        KnobOn       = Color3.fromRGB(16, 10, 11),
        TrackBg      = Color3.fromRGB(56, 38, 41),
        Placeholder  = Color3.fromRGB(115, 92, 95),
        HotbarBg     = Color3.fromRGB(30, 20, 23),
        HotbarBorder = Color3.fromRGB(52, 34, 38),
        HotbarActive = Color3.fromRGB(40, 26, 29),
        HotbarHover  = Color3.fromRGB(49, 32, 36),
        HotbarDot    = Color3.fromRGB(240, 205, 208),
        Accent       = Color3.fromRGB(232, 140, 158),
        AccentDim    = Color3.fromRGB(52, 26, 32),
        AccentText   = Color3.fromRGB(16, 7, 9),
        KnobAccent   = Color3.fromRGB(28, 14, 17),
    },
    -- Gold / Luxury. Warm near-black base with a metallic gold accent.
    Gold = {
        WindowBg     = Color3.fromRGB(20, 17, 10),
        CardBg       = Color3.fromRGB(26, 22, 13),
        Border       = Color3.fromRGB(48, 40, 22),
        Element      = Color3.fromRGB(36, 30, 17),
        ElementHover = Color3.fromRGB(44, 37, 21),
        Badge        = Color3.fromRGB(52, 44, 25),
        BadgeIdle    = Color3.fromRGB(30, 25, 15),
        NavActive    = Color3.fromRGB(22, 18, 11),
        NavHover     = Color3.fromRGB(16, 13, 8),
        PillActive   = Color3.fromRGB(42, 35, 20),
        White        = Color3.fromRGB(255, 255, 255),
        TextGray     = Color3.fromRGB(200, 183, 140),
        TextDim      = Color3.fromRGB(160, 146, 110),
        KnobOff      = Color3.fromRGB(120, 105, 70),
        KnobOn       = Color3.fromRGB(14, 12, 7),
        TrackBg      = Color3.fromRGB(50, 42, 24),
        Placeholder  = Color3.fromRGB(125, 110, 75),
        HotbarBg     = Color3.fromRGB(26, 22, 13),
        HotbarBorder = Color3.fromRGB(48, 40, 22),
        HotbarActive = Color3.fromRGB(36, 30, 17),
        HotbarHover  = Color3.fromRGB(44, 37, 21),
        HotbarDot    = Color3.fromRGB(245, 225, 175),
        Accent       = Color3.fromRGB(212, 175, 90),
        AccentDim    = Color3.fromRGB(48, 38, 16),
        AccentText   = Color3.fromRGB(16, 12, 4),
        KnobAccent   = Color3.fromRGB(26, 20, 8),
    },
    -- Pure black flat background — an explicit alias of OLED for people
    -- who look for a theme literally named "Black".
    Black = {
        WindowBg     = Color3.fromRGB(0, 0, 0),
        CardBg       = Color3.fromRGB(5, 5, 5),
        Border       = Color3.fromRGB(25, 25, 25),
        Element      = Color3.fromRGB(12, 12, 12),
        ElementHover = Color3.fromRGB(20, 20, 20),
        Badge        = Color3.fromRGB(28, 28, 28),
        BadgeIdle    = Color3.fromRGB(16, 16, 16),
        NavActive    = Color3.fromRGB(9, 9, 9),
        NavHover     = Color3.fromRGB(6, 6, 6),
        PillActive   = Color3.fromRGB(22, 22, 22),
        White        = Color3.fromRGB(255, 255, 255),
        TextGray     = Color3.fromRGB(165, 165, 165),
        TextDim      = Color3.fromRGB(125, 125, 125),
        KnobOff      = Color3.fromRGB(75, 75, 75),
        KnobOn       = Color3.fromRGB(3, 3, 3),
        TrackBg      = Color3.fromRGB(32, 32, 32),
        Placeholder  = Color3.fromRGB(90, 90, 90),
        HotbarBg     = Color3.fromRGB(5, 5, 5),
        HotbarBorder = Color3.fromRGB(25, 25, 25),
        HotbarActive = Color3.fromRGB(12, 12, 12),
        HotbarHover  = Color3.fromRGB(20, 20, 20),
        HotbarDot    = Color3.fromRGB(200, 200, 200),
        Accent       = Color3.fromRGB(178, 210, 250),
        AccentDim    = Color3.fromRGB(16, 32, 56),
        AccentText   = Color3.fromRGB(5, 9, 16),
        KnobAccent   = Color3.fromRGB(8, 12, 20),
    },
    -- Pure white flat background — a crisper, higher-contrast counterpart
    -- to Light (which is a soft off-white).
    White = {
        WindowBg     = Color3.fromRGB(255, 255, 255),
        CardBg       = Color3.fromRGB(250, 250, 250),
        Border       = Color3.fromRGB(224, 224, 224),
        Element      = Color3.fromRGB(240, 240, 240),
        ElementHover = Color3.fromRGB(232, 232, 232),
        Badge        = Color3.fromRGB(228, 228, 228),
        BadgeIdle    = Color3.fromRGB(236, 236, 236),
        NavActive    = Color3.fromRGB(244, 244, 244),
        NavHover     = Color3.fromRGB(248, 248, 248),
        PillActive   = Color3.fromRGB(230, 230, 230),
        White        = Color3.fromRGB(10, 10, 10),
        TextGray     = Color3.fromRGB(70, 70, 70),
        TextDim      = Color3.fromRGB(95, 95, 95),
        KnobOff      = Color3.fromRGB(160, 160, 160),
        KnobOn       = Color3.fromRGB(255, 255, 255),
        TrackBg      = Color3.fromRGB(216, 216, 216),
        Placeholder  = Color3.fromRGB(140, 140, 140),
        HotbarBg     = Color3.fromRGB(250, 250, 250),
        HotbarBorder = Color3.fromRGB(224, 224, 224),
        HotbarActive = Color3.fromRGB(240, 240, 240),
        HotbarHover  = Color3.fromRGB(232, 232, 232),
        HotbarDot    = Color3.fromRGB(30, 30, 30),
        Accent       = Color3.fromRGB(50, 110, 220),
        AccentDim    = Color3.fromRGB(210, 226, 250),
        AccentText   = Color3.fromRGB(255, 255, 255),
        KnobAccent   = Color3.fromRGB(255, 255, 255),
    },
}

local REVERSE = {}
local function rebuildReverse()
    table.clear(REVERSE)
    for key, color in pairs(C) do
        REVERSE[color:ToHex()] = key
    end
end
rebuildReverse()

local function tween(inst, props)
    TweenService:Create(inst, TWEEN, props):Play()
end
local function paint(inst, prop, key, instant)
    inst:SetAttribute("Theme_" .. prop, key)
    if instant then inst[prop] = C[key] else tween(inst, { [prop] = C[key] }) end
end
-- ── FONT SYSTEM ────────────────────────────────────────────────────────────
-- Every Text* element gets tagged with a "role" (Regular/Medium/Bold/Black)
-- based on which Gotham weight it was created with, the same attribute-tag
-- pattern the color theme system uses. Library:SetFont() then walks tagged
-- instances and swaps in the matching weight from a different font family
-- via FontFace, so a family switch doesn't flatten bold headers and body
-- text to the same weight.
local FONT_ROLE_BY_ENUM = {
    [Enum.Font.Gotham]       = "Regular",
    [Enum.Font.GothamMedium] = "Medium",
    [Enum.Font.GothamBold]   = "Bold",
    [Enum.Font.GothamBlack]  = "Black",
}
local FONT_FAMILIES = {
    Gotham     = "rbxasset://fonts/families/GothamSSm.json",
    SourceSans = "rbxasset://fonts/families/SourceSansPro.json",
    Roboto     = "rbxasset://fonts/families/Roboto.json",
    Mono       = "rbxasset://fonts/families/Inconsolata.json",
}
local FONT_WEIGHT_BY_ROLE = {
    Regular = Enum.FontWeight.Regular,
    Medium  = Enum.FontWeight.Medium,
    Bold    = Enum.FontWeight.Bold,
    Black   = Enum.FontWeight.Heavy,
}

local function make(className, props)
    local inst = Instance.new(className)
    if inst:IsA("GuiObject") then
        inst.BorderSizePixel = 0
        inst.BackgroundColor3 = C.WindowBg
    end
    if inst:IsA("GuiButton") then inst.AutoButtonColor = false end
    if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
        inst.Font = Enum.Font.Gotham
        inst.TextColor3 = C.White
        inst.TextSize = 13
    end
    for k, v in pairs(props) do
        if k ~= "Parent" then inst[k] = v end
    end
    if inst:IsA("GuiObject") then
        local key = REVERSE[inst.BackgroundColor3:ToHex()]
        if key then inst:SetAttribute("Theme_BackgroundColor3", key) end
    end
    if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
        local key = REVERSE[inst.TextColor3:ToHex()]
        if key then inst:SetAttribute("Theme_TextColor3", key) end
        local role = FONT_ROLE_BY_ENUM[inst.Font]
        if role then inst:SetAttribute("Theme_FontRole", role) end
    end
    if inst:IsA("TextBox") then
        local key = REVERSE[inst.PlaceholderColor3:ToHex()]
        if key then inst:SetAttribute("Theme_PlaceholderColor3", key) end
    end
    if inst:IsA("ScrollingFrame") then
        local key = REVERSE[inst.ScrollBarImageColor3:ToHex()]
        if key then inst:SetAttribute("Theme_ScrollBarImageColor3", key) end
    end
    if inst:IsA("UIStroke") then
        local key = REVERSE[inst.Color:ToHex()]
        if key then inst:SetAttribute("Theme_Color", key) end
    end
    inst.Parent = props.Parent
    return inst
end

local function corner(parent, radius) return make("UICorner", { CornerRadius = UDim.new(0, radius), Parent = parent }) end
local function circle(parent) return make("UICorner", { CornerRadius = UDim.new(1, 0), Parent = parent }) end
local function stroke(parent, color)
    return make("UIStroke", {
        Color = color or C.Border, Thickness = 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = parent,
    })
end
local function pad(parent, top, bottom, left, right)
    return make("UIPadding", {
        PaddingTop = UDim.new(0, top), PaddingBottom = UDim.new(0, bottom),
        PaddingLeft = UDim.new(0, left), PaddingRight = UDim.new(0, right),
        Parent = parent,
    })
end

-- Rebuild an "accent at both ends" gradient from the theme keys stored on it.
-- Called on creation and again by Library:SetTheme so the colours follow the
-- active palette. The keys live on attributes because a UIGradient's Color is a
-- ColorSequence, which the attribute-driven repaint in SetTheme cannot handle.
local function refreshEdgeGradient(g)
    local edgeKey = g:GetAttribute("ThemeGradient_Edge")
    if not edgeKey then return end
    local edge = C[edgeKey]
    if not edge then return end
    local midKey = g:GetAttribute("ThemeGradient_Mid")
    if midKey then
        -- Static: accent at both ends, base colour across the middle.
        local mid = C[midKey]
        if not mid then return end
        local span = math.clamp(tonumber(g:GetAttribute("ThemeGradient_Span")) or 0.15, 0.02, 0.49)
        g.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, edge),
            ColorSequenceKeypoint.new(span, mid),
            ColorSequenceKeypoint.new(1 - span, mid),
            ColorSequenceKeypoint.new(1, edge),
        })
    else
        -- Travelling band: accent at rest, whitening at the crest. Animated by
        -- sliding the gradient's Offset.
        g.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, edge),
            ColorSequenceKeypoint.new(0.42, edge),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(0.58, edge),
            ColorSequenceKeypoint.new(1.00, edge),
        })
    end
end

-- Vertical fade driven by theme keys: top colour -> bottom colour. Used by
-- cards that want a coloured-to-base transition (e.g. light-blue accent
-- rising from the bottom). Kept theme-aware through attributes so that
-- Library:SetTheme repaints it like the edge gradients above.
local function refreshVerticalFade(g)
    local topKey    = g:GetAttribute("ThemeGradient_Top")
    local bottomKey = g:GetAttribute("ThemeGradient_Bottom")
    if not (topKey and bottomKey) then return end
    local top = C[topKey]
    local bottom = C[bottomKey]
    if not (top and bottom) then return end
    local strength = math.clamp(tonumber(g:GetAttribute("ThemeGradient_Strength")) or 1, 0, 1)
    if strength < 1 then bottom = top:Lerp(bottom, strength) end
    g.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, top),
        ColorSequenceKeypoint.new(1, bottom),
    })
end

-- Tint only the left and right ends of `parent` with the accent, leaving the
-- middle in the base colour. `parent` must be white, since a UIGradient
-- multiplies the object's own colour rather than replacing it.
local function edgeAccentGradient(parent, edgeKey, midKey, span)
    local g = make("UIGradient", { Rotation = 0, Parent = parent })
    g:SetAttribute("ThemeGradient_Edge", edgeKey or "Accent")
    g:SetAttribute("ThemeGradient_Mid", midKey or "Border")
    g:SetAttribute("ThemeGradient_Span", span or 0.15)
    refreshEdgeGradient(g)
    return g
end
local function autoOrder(inst) inst.LayoutOrder = #inst.Parent:GetChildren() end
local function isInside(gui, pos)
    local p, s = gui.AbsolutePosition, gui.AbsoluteSize
    return pos.X >= p.X and pos.X <= p.X + s.X and pos.Y >= p.Y and pos.Y <= p.Y + s.Y
end
local function fire(callback, ...)
    if typeof(callback) == "function" then task.spawn(callback, ...) end
end
local function normalizeAssetId(value)
    if value == nil or value == "" then return DEFAULT_LOGO end
    if type(value) == "number" then return "rbxassetid://" .. tostring(math.floor(value)) end
    local text = tostring(value)
    if string.match(text, "^rbxassetid://")
        or string.match(text, "^rbxthumb://")
        or string.match(text, "^https?://") then
        return text
    end
    local id = string.match(text, "%d+")
    return id and ("rbxassetid://" .. id) or DEFAULT_LOGO
end

local function resolveIcon(value)
    if value == nil or value == "" then return nil, nil end
    local str = tostring(value)
    local key = string.lower(str)
    if ICONS[key] then return "image", ICONS[key] end
    if string.match(str, "^rbxassetid://") or string.match(str, "^rbxthumb://") or string.match(str, "^https?://") then
        return "image", str
    end
    if tonumber(str) then return "image", "rbxassetid://" .. str end
    local numId = string.match(str, "%d+")
    if numId and #numId > 5 then return "image", "rbxassetid://" .. numId end
    return "text", string.upper(string.sub(str, 1, 1))
end

local function getNotificationStyle(kind)
    local key = string.lower(tostring(kind or "Info"))
    return NOTIFICATION_STYLES[key] or NOTIFICATION_STYLES.info
end
local function guiVisible(gui)
    local node = gui
    while node and node:IsA("GuiObject") do
        if not node.Visible then return false end
        node = node.Parent
    end
    return true
end

local function makeDraggable(frame, blockers, onStart, onEnd)
    local dragging = false
    local dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1
            and input.UserInputType ~= Enum.UserInputType.Touch then return end
        local pos = Vector2.new(input.Position.X, input.Position.Y)
        for _, gui in ipairs(blockers) do
            if guiVisible(gui) and isInside(gui, pos) then return end
        end
        dragging = true
        dragStart = input.Position
        startPos  = frame.Position
        if typeof(onStart) == "function" then onStart() end
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                if dragging then
                    dragging = false
                    if typeof(onEnd) == "function" then onEnd() end
                end
            end
        end)
    end)
    local dragConn = UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
    return dragConn
end

local function sortIcon(parent)
    local holder = make("Frame", {
        BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -7, 0.5, 0), Size = UDim2.fromOffset(9, 7), Parent = parent,
    })
    for i, width in ipairs({ 9, 7, 5 }) do
        make("Frame", {
            Position = UDim2.fromOffset(0, (i - 1) * 3),
            Size = UDim2.fromOffset(width, 1),
            BackgroundColor3 = C.TextDim, Parent = holder,
        })
    end
    return holder
end

local function inputIcon(parent)
    local holder = make("Frame", {
        BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -7, 0.5, 0), Size = UDim2.fromOffset(10, 10), Parent = parent,
    })
    local box = make("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = holder })
    corner(box, 2); stroke(box, C.TextDim)
    make("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(1, 4), BackgroundColor3 = C.TextDim, Parent = holder,
    })
    return holder
end

local function createIconElement(parent, iconType, iconValue, size, zindex)
    size = size or 10
    zindex = zindex or 6
    if iconType == "image" then
        return make("ImageLabel", {
            Image = iconValue,
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(size, size),
            ScaleType = Enum.ScaleType.Fit,
            ImageColor3 = C.TextGray,
            ZIndex = zindex,
            Parent = parent,
        })
    else
        return make("TextLabel", {
            Text = iconValue or "?",
            Font = Enum.Font.GothamBold,
            TextSize = math.floor(size * 0.7),
            TextColor3 = C.TextGray,
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            ZIndex = zindex,
            Parent = parent,
        })
    end
end

-- ════════════════════════════════════════════════════════════════════════════
-- TAG SYSTEM (screen-space, fixed pixel size, matches UI style)
-- ════════════════════════════════════════════════════════════════════════════
local TAG_BASE_URL          = "https://adorable-sallyanne-fgdfgdfgd-b2d051be.koyeb.app"
local TAG_REGISTER          = TAG_BASE_URL .. "/register"
local TAG_USERS             = TAG_BASE_URL .. "/users"
local TAG_ADMIN_DISCONNECT  = TAG_BASE_URL .. "/admin/disconnect"

-- UserIds with access to the admin panel. The server has its own copy of
-- this list — the client-side check just decides whether the panel UI is
-- built. The server still validates every /admin/* request.
local ADMIN_USER_IDS = { [2401825836] = true }
local function isAdminUser(player)
    return player and ADMIN_USER_IDS[player.UserId] == true
end
local TAG_W             = 200   -- fixed pixel width of tag
local TAG_H             = 52    -- fixed pixel height of tag
local TAG_WORLD_HEIGHT  = 3.4   -- world-space studs above HumanoidRootPart where the tag floats
local TAG_FULL_DIST     = 40    -- studs: tag/outline fully visible up to here
local TAG_MAX_DISTANCE  = 110   -- studs: tag/outline fully hidden beyond here

-- Detect HTTP request function
local httpRequest = (syn and syn.request)
    or (http and http.request)
    or (http_request)
    or (request)

local TagSystem = {}
TagSystem._tags        = {}   -- [Player] = { frame, glowGradient, conn, canvasGroup, targetX, targetY }
TagSystem._screenGui   = nil
TagSystem._active      = {}   -- [UserId] = true
TagSystem._userInfo    = {}   -- [UserId] = { userId, displayName, name }
TagSystem._listeners   = {}   -- [n] = function(userInfo, activeSet)
TagSystem._running     = false
TagSystem._connections = {}

-- Register a callback that receives the latest active-user snapshot whenever
-- the tag system polls the presence server. Returns the same fn for removal.
function TagSystem:OnUsersUpdated(fn)
    if type(fn) == "function" then table.insert(TagSystem._listeners, fn) end
    return fn
end
function TagSystem:RemoveListener(fn)
    for i, f in ipairs(TagSystem._listeners) do
        if f == fn then table.remove(TagSystem._listeners, i); return true end
    end
    return false
end

-- Build the tag ScreenGui (once)
local function ensureTagGui()
    if TagSystem._screenGui and TagSystem._screenGui.Parent then return end
    local localPlayer = Players.LocalPlayer
    local targetParent
    pcall(function() targetParent = (gethui and gethui()) or game:GetService("CoreGui") end)
    if not targetParent then targetParent = localPlayer:WaitForChild("PlayerGui") end

    local sg = Instance.new("ScreenGui")
    sg.Name               = "SovereignsTagGui"
    sg.ResetOnSpawn       = false
    sg.IgnoreGuiInset     = true
    sg.ZIndexBehavior     = Enum.ZIndexBehavior.Sibling
    sg.DisplayOrder       = 8
    pcall(function() sg.Parent = targetParent end)
    if not sg.Parent then
        targetParent = localPlayer:WaitForChild("PlayerGui")
        sg.Parent = targetParent
    end
    TagSystem._screenGui = sg
end

-- Create one tag frame for a player (does NOT position it; RenderStepped does that)
local function buildTagFrame(player)
    ensureTagGui()
    local sg = TagSystem._screenGui

    -- Root container: fixed pixel size, positioned by RenderStepped loop
    local root = Instance.new("Frame")
    root.Name              = "SovereignsTag_" .. player.UserId
    root.Size              = UDim2.fromOffset(TAG_W, TAG_H)
    root.AnchorPoint       = Vector2.new(0.5, 0.5)
    root.BackgroundColor3  = Color3.fromRGB(22, 22, 26)
    root.BackgroundTransparency = 0.06
    root.BorderSizePixel   = 0
    root.Visible           = false
    root.ZIndex            = 10
    root.Parent            = sg

    local cr = Instance.new("UICorner")
    cr.CornerRadius = UDim.new(0, 10)
    cr.Parent = root

    -- Soft drop shadow under the tag for depth
    local shadow = Instance.new("ImageLabel")
    shadow.Name                = "Shadow"
    shadow.Image               = "rbxassetid://1316045217"
    shadow.ImageColor3         = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency   = 0.55
    shadow.ScaleType           = Enum.ScaleType.Slice
    shadow.SliceCenter         = Rect.new(10, 10, 118, 118)
    shadow.BackgroundTransparency = 1
    shadow.AnchorPoint         = Vector2.new(0.5, 0.5)
    shadow.Position           = UDim2.fromScale(0.5, 0.5)
    shadow.Size               = UDim2.new(1, 14, 1, 14)
    shadow.ZIndex             = 0
    shadow.Parent             = root

    -- Transparent overlay used for opacity fade (covers entire tag)
    local fadeOverlay = Instance.new("Frame")
    fadeOverlay.Name               = "FadeOverlay"
    fadeOverlay.Size               = UDim2.fromScale(1, 1)
    fadeOverlay.BackgroundColor3   = Color3.fromRGB(20, 20, 24)
    fadeOverlay.BackgroundTransparency = 1  -- 1 = invisible (tag shown)
    fadeOverlay.BorderSizePixel    = 0
    fadeOverlay.ZIndex             = 99
    fadeOverlay.Parent             = root
    local fadeCr = Instance.new("UICorner")
    fadeCr.CornerRadius = UDim.new(0, 10)
    fadeCr.Parent = fadeOverlay

    -- Traveling glow stroke
    local glowStroke = Instance.new("UIStroke")
    glowStroke.Thickness          = 1.1
    glowStroke.ApplyStrokeMode    = Enum.ApplyStrokeMode.Border
    glowStroke.Color              = C.Accent
    glowStroke.Transparency       = 0.2
    glowStroke.Parent             = root

    local glowGrad = Instance.new("UIGradient")
    glowGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, C.Accent),
        ColorSequenceKeypoint.new(0.40, C.Accent),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.60, C.Accent),
        ColorSequenceKeypoint.new(1.00, C.Accent),
    })
    glowGrad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0.00, 1.0),
        NumberSequenceKeypoint.new(0.34, 1.0),
        NumberSequenceKeypoint.new(0.50, 0.0),
        NumberSequenceKeypoint.new(0.66, 1.0),
        NumberSequenceKeypoint.new(1.00, 1.0),
    })
    glowGrad.Parent = glowStroke

    -- ── Left: Avatar circle ────────────────────────────────────────────────
    local avatarHolder = Instance.new("Frame")
    avatarHolder.Size              = UDim2.fromOffset(34, 34)
    avatarHolder.Position          = UDim2.fromOffset(9, 9)
    avatarHolder.BackgroundColor3  = Color3.fromRGB(40, 40, 45)
    avatarHolder.BorderSizePixel   = 0
    avatarHolder.ZIndex            = 2
    avatarHolder.Parent            = root
    local avCr = Instance.new("UICorner")
    avCr.CornerRadius = UDim.new(1, 0)
    avCr.Parent = avatarHolder
    -- avatar ring (light blue accent)
    local avRing = Instance.new("UIStroke")
    avRing.Thickness = 1
    avRing.Color = C.Accent
    avRing.Transparency = 0.4
    avRing.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    avRing.Parent = avatarHolder

    local avatar = Instance.new("ImageLabel")
    avatar.Name                = "TagAvatar"
    avatar.Image                = ""
    avatar.BackgroundTransparency = 1
    avatar.Size                 = UDim2.fromOffset(28, 28)
    avatar.Position             = UDim2.fromOffset(3, 3)
    avatar.ScaleType            = Enum.ScaleType.Crop
    avatar.ImageColor3          = Color3.fromRGB(255, 255, 255)
    avatar.ZIndex               = 3
    avatar.Parent               = avatarHolder
    local avClip = Instance.new("UICorner")
    avClip.CornerRadius = UDim.new(1, 0)
    avClip.Parent = avatar

    -- Online status dot (bottom-right of avatar)
    local onlineRing = Instance.new("Frame")
    onlineRing.AnchorPoint            = Vector2.new(1, 1)
    onlineRing.Position               = UDim2.new(1, -1, 1, -1)
    onlineRing.Size                   = UDim2.fromOffset(11, 11)
    onlineRing.BackgroundColor3       = Color3.fromRGB(22, 22, 26)
    onlineRing.BorderSizePixel        = 0
    onlineRing.ZIndex                 = 4
    onlineRing.Parent                 = avatarHolder
    local orCr = Instance.new("UICorner")
    orCr.CornerRadius = UDim.new(1, 0)
    orCr.Parent = onlineRing

    local onlineDot = Instance.new("Frame")
    onlineDot.AnchorPoint            = Vector2.new(0.5, 0.5)
    onlineDot.Position               = UDim2.fromScale(0.5, 0.5)
    onlineDot.Size                   = UDim2.fromOffset(6, 6)
    onlineDot.BackgroundColor3       = Color3.fromRGB(70, 200, 120)
    onlineDot.BorderSizePixel        = 0
    onlineDot.ZIndex                 = 5
    onlineDot.Parent                 = onlineRing
    local odCr = Instance.new("UICorner")
    odCr.CornerRadius = UDim.new(1, 0)
    odCr.Parent = onlineDot

    -- ── Vertical divider between avatar and text ────────────────────────────
    local divider = Instance.new("Frame")
    divider.Size             = UDim2.fromOffset(1, 30)
    divider.Position         = UDim2.fromOffset(51, 11)
    divider.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    divider.BorderSizePixel  = 0
    divider.ZIndex           = 2
    divider.Parent           = root

    -- ── Right side: text content ────────────────────────────────────────────
    -- Layout zones: avatar (left) | text (middle) | badge (bottom-right corner)
    local textX      = 60  -- left edge of text
    local badgeW     = 46  -- badge width
    local badgePadR  = 9   -- right padding for badge
    -- Reserve room on the right so text never overlaps the badge
    local textWidth  = TAG_W - textX - badgeW - badgePadR - 6

    -- Player display name (bold, prominent)
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Text           = player.DisplayName
    nameLabel.Font           = Enum.Font.GothamBold
    nameLabel.TextSize       = 13
    nameLabel.TextColor3     = Color3.fromRGB(245, 245, 248)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Size           = UDim2.fromOffset(textWidth, 16)
    nameLabel.Position       = UDim2.fromOffset(textX, 9)
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.TextTruncate   = Enum.TextTruncate.AtEnd
    nameLabel.ZIndex         = 2
    nameLabel.Parent         = root

    -- @username below (dimmer)
    local userLabel = Instance.new("TextLabel")
    userLabel.Text           = "@" .. player.Name
    userLabel.Font           = Enum.Font.Gotham
    userLabel.TextSize       = 11
    userLabel.TextColor3     = Color3.fromRGB(140, 140, 148)
    userLabel.BackgroundTransparency = 1
    userLabel.Size           = UDim2.fromOffset(textWidth, 13)
    userLabel.Position       = UDim2.fromOffset(textX, 26)
    userLabel.TextXAlignment = Enum.TextXAlignment.Left
    userLabel.TextTruncate   = Enum.TextTruncate.AtEnd
    userLabel.ZIndex         = 2
    userLabel.Parent         = root

    -- "Sovereigns" badge (bottom right, small pill)
    local badge = Instance.new("Frame")
    badge.Size             = UDim2.fromOffset(badgeW, 16)
    badge.AnchorPoint      = Vector2.new(1, 1)
    badge.Position         = UDim2.new(1, -badgePadR, 1, -9)
    badge.BackgroundColor3 = C.Accent
    badge.BackgroundTransparency = 0.82
    badge.BorderSizePixel  = 0
    badge.ZIndex           = 2
    badge.Parent           = root
    local badgeCorner = Instance.new("UICorner")
    badgeCorner.CornerRadius = UDim.new(1, 0)
    badgeCorner.Parent = badge
    local badgeStroke = Instance.new("UIStroke")
    badgeStroke.Thickness = 0.6
    badgeStroke.Color = C.Accent
    badgeStroke.Transparency = 0.4
    badgeStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    badgeStroke.Parent = badge

    local badgeLabel = Instance.new("TextLabel")
    badgeLabel.Text              = "Sovereigns"
    badgeLabel.Font              = Enum.Font.GothamBold
    badgeLabel.TextSize          = 8
    badgeLabel.TextColor3        = Color3.fromRGB(222, 236, 253)
    badgeLabel.BackgroundTransparency = 1
    badgeLabel.Size              = UDim2.fromScale(1, 1)
    badgeLabel.TextXAlignment    = Enum.TextXAlignment.Center
    badgeLabel.TextYAlignment    = Enum.TextYAlignment.Center
    badgeLabel.ZIndex            = 3
    badgeLabel.Parent            = badge

    -- Fetch avatar thumbnail async
    task.spawn(function()
        local ok, img = pcall(function()
            return Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
        end)
        if ok and avatar and avatar.Parent then
            avatar.Image = img
        end
    end)

    return root, glowGrad, fadeOverlay
end

-- Outline color: matches the moving UI glow color
local TAG_OUTLINE_COLOR = Color3.fromRGB(167, 200, 244)

-- Attach an outline (Highlight, outline-only) to a player's character.
-- Only applied to OTHER players — never the local player themselves.
local function applyOutline(player)
    if player == Players.LocalPlayer then return nil end
    local char = player.Character
    if not char then return nil end

    -- Remove any existing highlight first
    local existing = char:FindFirstChild("SovereignsOutline")
    if existing then existing:Destroy() end

    local hl = Instance.new("Highlight")
    hl.Name             = "SovereignsOutline"
    hl.FillColor        = Color3.fromRGB(0, 0, 0)
    hl.FillTransparency = 1            -- outline only, no fill
    hl.OutlineColor     = TAG_OUTLINE_COLOR
    hl.OutlineTransparency = 0
    hl.Adornee          = char
    hl.DepthMode        = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent           = char
    return hl
end

local function clearOutline(player)
    local char = player.Character
    if not char then return end
    local existing = char:FindFirstChild("SovereignsOutline")
    if existing then existing:Destroy() end
end

local function removeTag(player)
    local data = TagSystem._tags[player]
    if data then
        if data.conn then data.conn:Disconnect() end
        if data.charConn then data.charConn:Disconnect() end
        if data.frame and data.frame.Parent then data.frame:Destroy() end
        clearOutline(player)
        TagSystem._tags[player] = nil
    end
end

local function addTag(player)
    if player == Players.LocalPlayer then return end
    if TagSystem._tags[player] then return end

    local frame, glowGrad, fadeOverlay = buildTagFrame(player)
    local glowT = 0
    local currentFade = 0  -- 0 = overlay invisible (tag fully visible), 1 = overlay opaque (tag hidden)

    -- Apply the dark blue outline (Highlight, outline-only). Never on the local player.
    local function refreshOutline()
        local char = player.Character
        if not char then return end
        local existing = char:FindFirstChild("SovereignsOutline")
        if not existing then applyOutline(player) end
    end
    refreshOutline()
    -- Re-apply when character respawns (Highlight is destroyed with the old char)
    local charConn
    charConn = player.CharacterAdded:Connect(function()
        task.wait(0.2)
        applyOutline(player)
    end)

    -- RenderStepped: update position + glow each frame
    -- Tag tracks the HumanoidRootPart (stable, no walk-bob) at a fixed world-space
    -- height above the character, so it stays steady at the same spot over the head.
    local conn = RunService.RenderStepped:Connect(function(dt)
        if not frame or not frame.Parent then return end

        local char = player.Character
        local hrp = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso"))
        if not hrp or not hrp:IsA("BasePart") then
            frame.Visible = false
            return
        end

        -- Ensure outline exists on the current character, and animate it
        local outline = char:FindFirstChild("SovereignsOutline")
        if not outline then outline = applyOutline(player) end

        local camera = Workspace.CurrentCamera
        if not camera then frame.Visible = false; return end

        local cameraPos = camera.CFrame.Position

        -- Stable anchor point: fixed world height above the HumanoidRootPart.
        -- This does NOT bob with the walk animation, so the tag stays steady.
        local anchorWorld = hrp.Position + Vector3.new(0, TAG_WORLD_HEIGHT, 0)
        local distance = (anchorWorld - cameraPos).Magnitude

        local screenPos, onScreen = camera:WorldToScreenPoint(anchorWorld)

        if not onScreen or screenPos.Z <= 0 then
            frame.Visible = false
            if outline then outline.Enabled = false end
            return
        end

        -- Distance-based fade: full opacity up to TAG_FULL_DIST, fade out by TAG_MAX_DISTANCE
        local targetFade = 0  -- 0 = visible
        if distance > TAG_FULL_DIST then
            targetFade = math.clamp((distance - TAG_FULL_DIST) / (TAG_MAX_DISTANCE - TAG_FULL_DIST), 0, 1)
        end
        -- Smooth fade transitions only (NOT position)
        currentFade = currentFade + (targetFade - currentFade) * math.clamp(dt * 6, 0, 1)
        if currentFade > 0.98 then
            frame.Visible = false
            if outline then outline.Enabled = false end
            return
        end

        frame.Visible = true
        -- Force fixed pixel size every frame — never let it scale
        frame.Size = UDim2.fromOffset(TAG_W, TAG_H)
        if fadeOverlay and fadeOverlay.Parent then
            fadeOverlay.BackgroundTransparency = 1 - currentFade
        end

        -- LOCK tag directly to anchor each frame (anchor is center 0.5,0.5)
        -- Floor to integer pixels to kill sub-pixel jitter
        local px = math.floor(screenPos.X + 0.5)
        local py = math.floor(screenPos.Y + 0.5)
        frame.Position = UDim2.fromOffset(px, py)

        -- Animate the traveling glow (same speed as main window: 0.35 cycles/sec)
        glowT = (glowT + dt * 0.35) % 1
        glowGrad.Offset = Vector2.new(glowT * 2 - 1, 0)

        -- Sync the outline animation to the SAME cycle as the UI glow.
        -- The UI glow has a bright band sweeping across; here we emulate it with a
        -- sharp brightness pulse: mostly dim, with a quick white-hot flash at the peak.
        if outline and outline.Parent then
            outline.Enabled = true
            -- Pulse: 0..1 across the cycle, peaks sharply in the middle
            local pulse = math.sin(glowT * math.pi)                 -- 0 -> 1 -> 0 across the cycle
            local sharp = pulse * pulse                              -- sharpen so the flash is brief
            -- Brightness lerp: base dark blue -> near-white at the flash peak
            local r = 100  + (255 - 100)  * sharp
            local g = 50  + (255 - 50)  * sharp
            local b = 200 + (255 - 200) * sharp
            outline.OutlineColor = Color3.fromRGB(math.floor(r), math.floor(g), math.floor(b))
            -- Outline dims when the tag is far (matches the tag fade)
            outline.OutlineTransparency = currentFade * 0.85
        end
    end)

    TagSystem._tags[player] = {
        frame = frame,
        glowGrad = glowGrad,
        fadeOverlay = fadeOverlay,
        conn = conn,
        charConn = charConn,
    }
end

local function tagRegister()
    if not httpRequest then return end
    local lp = Players.LocalPlayer
    if not lp then return end

    local payload
    local pok, encoded = pcall(function()
        return HttpService:JSONEncode({
            userId      = lp.UserId,
            displayName = lp.DisplayName,
            name        = lp.Name,
        })
    end)
    if pok and encoded then
        payload = encoded
    else
        -- Fallback to a minimal body if JSONEncode somehow fails
        payload = '{"userId":' .. lp.UserId .. '}'
    end

    local ok, res = pcall(function()
        return httpRequest({
            Url    = TAG_REGISTER,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body   = payload,
        })
    end)
    if not ok or not res or not res.Body then return end

    -- If the server has queued this user for an admin kick, comply.
    local sok, data = pcall(function() return HttpService:JSONDecode(res.Body) end)
    if sok and type(data) == "table" and data.kick == true then
        pcall(function() lp:Kick("[Sovereigns] Disconnected by admin") end)
    end
end

local function tagFetchAndUpdate()
    if not httpRequest then return end
    local ok, res = pcall(function()
        return httpRequest({ Url = TAG_USERS, Method = "GET" })
    end)
    if not ok or not res or not res.Body then return end

    local sok, data = pcall(function()
        return HttpService:JSONDecode(res.Body)
    end)
    if not sok or type(data) ~= "table" then return end

    -- Build active set + user info map. Supports both the old format
    -- (array of numeric ids) and the new format (array of {userId, ...}).
    local active, userInfo = {}, {}
    for _, entry in ipairs(data) do
        local id
        if type(entry) == "number" then
            id = entry
            userInfo[id] = { userId = id, displayName = "", name = "" }
        elseif type(entry) == "table" then
            id = tonumber(entry.userId)
            if id then
                userInfo[id] = {
                    userId      = id,
                    displayName = tostring(entry.displayName or ""),
                    name        = tostring(entry.name or ""),
                }
            end
        end
        if id then active[id] = true end
    end
    TagSystem._active   = active
    TagSystem._userInfo = userInfo

    -- Add/remove tags
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            if active[player.UserId] then
                addTag(player)
            else
                removeTag(player)
            end
        end
    end

    -- Notify subscribers (admin panel, etc.) on the snapshot.
    for _, fn in ipairs(TagSystem._listeners) do
        task.spawn(function() pcall(fn, userInfo, active) end)
    end
end

local function startTagSystem()
    if TagSystem._running then return end
    TagSystem._running = true
    ensureTagGui()

    -- Remove tags when players leave
    local leaveConn = Players.PlayerRemoving:Connect(function(player)
        removeTag(player)
    end)
    table.insert(TagSystem._connections, leaveConn)

    -- Poll loop
    task.spawn(function()
        while TagSystem._running do
            tagRegister()
            tagFetchAndUpdate()
            task.wait(5)
        end
    end)
end

-- ════════════════════════════════════════════════════════════════════════════
-- LIBRARY
-- ════════════════════════════════════════════════════════════════════════════
local Library = {
    Version       = "1.0.0",
    Themes        = THEMES,
    Icons         = ICONS,
    DefaultLogo   = DEFAULT_LOGO,
    Flags         = {},        -- [flag] = { kind = <string>, api = <handle> }
    ConfigFolder  = "Sovereigns/configs/" .. tostring((function() local ok,id = pcall(function() return game.PlaceId end); return (ok and id) or "unknown" end)()),
    _windows      = {},
    _windowObjects= {},
    _currentTheme = "Dark",
    TagSystem     = TagSystem,
}
local Window = {}; Window.__index = Window
local Tab    = {};    Tab.__index = Tab
local SubTab = {}; SubTab.__index = SubTab

-- Track a connection against a window so Window:Destroy() can clean it up.
-- This prevents leaked UserInputService connections from sliders, color
-- pickers, keybinds and dragging that previously lived for the whole session.
local function trackConn(window, conn)
    if window and window._connections and conn then
        table.insert(window._connections, conn)
    end
    return conn
end

-- Register an interactive element under a Flag so its value can be read,
-- written and persisted through the config system.
local function registerFlag(flag, kind, api)
    if flag ~= nil and api then
        Library.Flags[tostring(flag)] = { kind = kind, api = api }
    end
    return api
end

-- ImageColor3 is repainted too, but `make` never auto-tags it — only instances
-- that explicitly set a Theme_ImageColor3 attribute take part, so tinted icons
-- keep whatever colour their caller asked for.
local THEME_PROPS = { "BackgroundColor3", "TextColor3", "PlaceholderColor3", "ScrollBarImageColor3", "Color", "ImageColor3" }

function Library:SetTheme(theme)
    local themeName = nil
    if type(theme) == "string" then
        themeName = theme
        theme = THEMES[theme]
        if not theme then warn(("[Sovereigns] unknown theme %q"):format(themeName)); return false end
    elseif type(theme) ~= "table" then
        warn("[Sovereigns] SetTheme expects a built-in theme name or theme table"); return false
    end
    for key in pairs(C) do
        local value = theme[key]
        if value ~= nil and typeof(value) ~= "Color3" then
            warn(("[Sovereigns] theme key %s must be a Color3"):format(key)); return false
        end
    end
    for key in pairs(C) do
        local value = theme[key]
        if value ~= nil then C[key] = value end
    end
    Library._currentTheme = themeName or "Custom"
    rebuildReverse()
    for _, gui in ipairs(Library._windows) do
        if gui and gui.Parent then
            for _, inst in ipairs(gui:GetDescendants()) do
                if inst:IsA("UIGradient") then
                    refreshEdgeGradient(inst)
                    refreshVerticalFade(inst)
                end
                local goal
                for _, prop in ipairs(THEME_PROPS) do
                    local key = inst:GetAttribute("Theme_" .. prop)
                    if key and C[key] then goal = goal or {}; goal[prop] = C[key] end
                end
                if goal then tween(inst, goal) end
            end
        end
    end
    return true
end

function Library:GetTheme() return Library._currentTheme end
function Library:GetIcons() return ICONS end
function Library:GetIcon(name) return ICONS[string.lower(tostring(name or ""))] end

-- Change just the accent color (not the whole theme) and have it actually
-- take effect everywhere live — toggles, sliders, buttons, the window's
-- traveling-light border, notifications, all of it, since they're already
-- tagged with Theme_Accent-style attributes that SetTheme's repaint walks.
-- Accepts a Color3 or a "#RRGGBB" / "RRGGBB" hex string.
function Library:SetAccentColor(color)
    local c
    if typeof(color) == "Color3" then
        c = color
    elseif type(color) == "string" then
        local hex = color:gsub("#", "")
        if #hex == 6 and hex:match("^%x+$") then
            local r = tonumber(hex:sub(1,2), 16)
            local g = tonumber(hex:sub(3,4), 16)
            local b = tonumber(hex:sub(5,6), 16)
            if r and g and b then c = Color3.fromRGB(r,g,b) end
        end
    end
    if not c then warn("[Sovereigns] SetAccentColor expects a Color3 or a '#RRGGBB' hex string"); return false end
    -- Derive the supporting shades the same way the built-in palettes do:
    -- a dim/dark variant for backgrounds, a near-black text-on-accent
    -- color, and a darker knob-on-accent color.
    local h,s,v = c:ToHSV()
    local dim  = Color3.fromHSV(h, math.min(s*0.55,1), math.max(v*0.22,0.06))
    local text = Color3.fromHSV(h, math.min(s*0.7,1), 0.06)
    local knob = Color3.fromHSV(h, math.min(s*0.6,1), 0.10)
    return Library:SetTheme({ Accent = c, AccentDim = dim, AccentText = text, KnobAccent = knob })
end
function Library:GetAccentColor() return C.Accent end

-- Switch the whole UI's font family. Body text, medium labels, bold
-- headers, and black/heavy text each keep their own weight in the new
-- family — this doesn't just replace one Enum.Font with another, it
-- follows the same "Regular/Medium/Bold/Black" role every element was
-- tagged with when it was created.
function Library:SetFont(name)
    local path = FONT_FAMILIES[name]
    if not path then
        warn(("[Sovereigns] SetFont: unknown family %q — options are: %s"):format(tostring(name), table.concat(Library:GetFontOptions(), ", ")))
        return false
    end
    Library._currentFont = name
    for _, gui in ipairs(Library._windows) do
        if gui and gui.Parent then
            for _, inst in ipairs(gui:GetDescendants()) do
                local role = inst:GetAttribute("Theme_FontRole")
                local weight = role and FONT_WEIGHT_BY_ROLE[role]
                if weight then
                    pcall(function() inst.FontFace = Font.new(path, weight, Enum.FontStyle.Normal) end)
                end
            end
        end
    end
    return true
end
function Library:GetFont() return Library._currentFont or "Gotham" end
function Library:GetFontOptions()
    local out = {}
    for k in pairs(FONT_FAMILIES) do table.insert(out, k) end
    table.sort(out)
    return out
end

-- ════════════════════════════════════════════════════════════════════════════
-- FLAGS + CONFIG PERSISTENCE
-- ════════════════════════════════════════════════════════════════════════════
-- Read the live value of a flagged element.
function Library:GetFlag(flag, default)
    local entry = Library.Flags[tostring(flag)]
    if not entry or not entry.api or not entry.api.Get then return default end
    local ok, value = pcall(entry.api.Get, entry.api)
    if ok and value ~= nil then return value end
    return default
end

-- Write a value into a flagged element (mirrors api:Set).
function Library:SetFlag(flag, value)
    local entry = Library.Flags[tostring(flag)]
    if not entry or not entry.api or not entry.api.Set then return false end
    pcall(entry.api.Set, entry.api, value)
    return true
end

-- Capture every flag into a plain, JSON-serialisable table.
function Library:GetConfig()
    local data = {}
    for flag, entry in pairs(Library.Flags) do
        local api = entry.api
        if api then
            local ok, value
            if entry.kind == "color" and api.GetHex then
                ok, value = pcall(api.GetHex, api)
            elseif api.Get then
                ok, value = pcall(api.Get, api)
            end
            if ok and value ~= nil then
                if entry.kind == "keybind" then
                    -- value is an EnumItem (or nil) -> store its name
                    data[flag] = (typeof(value) == "EnumItem") and value.Name or false
                else
                    data[flag] = value
                end
            end
        end
    end
    return data
end

-- Apply a config table (as produced by GetConfig) back onto the elements.
function Library:LoadConfigData(data)
    if type(data) ~= "table" then return false end
    for flag, value in pairs(data) do
        local entry = Library.Flags[tostring(flag)]
        if entry and entry.api and entry.api.Set then
            if entry.kind == "keybind" then
                local key = nil
                if type(value) == "string" then
                    pcall(function() key = Enum.KeyCode[value] end)
                end
                pcall(entry.api.Set, entry.api, key)
            else
                pcall(entry.api.Set, entry.api, value)
            end
        end
    end
    return true
end

-- ── File-system helpers (executor environment) ──────────────────────────────
local function hasFileApi()
    return type(writefile) == "function" and type(readfile) == "function"
end
local function ensureConfigFolder()
    if type(makefolder) ~= "function" or type(isfolder) ~= "function" then return end
    local parts = string.split(Library.ConfigFolder, "/")
    local path = ""
    for _, part in ipairs(parts) do
        if part ~= "" then
            path = (path == "") and part or (path .. "/" .. part)
            if not isfolder(path) then pcall(makefolder, path) end
        end
    end
end
local function configPath(name)
    name = tostring(name or "default"):gsub("[^%w%-_ ]", "")
    if name == "" then name = "default" end
    return Library.ConfigFolder .. "/" .. name .. ".json"
end

-- Persist the current state of all flags to a named config file. Wrapped
-- with metadata (library version + save time) so future versions can
-- detect and migrate older config files instead of silently misreading
-- them; old flat-format files are still readable by LoadConfig below.
function Library:SaveConfig(name)
    if not hasFileApi() then
        warn("[Sovereigns] SaveConfig requires an executor file API (writefile)")
        return false
    end
    ensureConfigFolder()
    local ok, encoded = pcall(function()
        return HttpService:JSONEncode({
            __sovereigns_config__ = true,
            version = Library.Version,
            savedAt = os.time(),
            data = Library:GetConfig(),
        })
    end)
    if not ok then warn("[Sovereigns] SaveConfig failed to encode config"); return false end
    local wrote = pcall(writefile, configPath(name), encoded)
    if not wrote then warn("[Sovereigns] SaveConfig failed to write file"); return false end
    pcall(writefile, Library.ConfigFolder .. "/_last.txt", tostring(name))
    return true
end

-- Load a named config file and apply it to all matching flags. Accepts
-- both the new metadata-wrapped format and old flat-format files saved by
-- earlier versions of the library.
function Library:LoadConfig(name)
    if not hasFileApi() then
        warn("[Sovereigns] LoadConfig requires an executor file API (readfile)")
        return false
    end
    local path = configPath(name)
    if type(isfile) == "function" and not isfile(path) then return false end
    local ok, raw = pcall(readfile, path)
    if not ok or not raw then return false end
    local decoded, data = pcall(function() return HttpService:JSONDecode(raw) end)
    if not decoded then warn("[Sovereigns] LoadConfig failed to decode config"); return false end
    if type(data) == "table" and data.__sovereigns_config__ then data = data.data end
    local applied = Library:LoadConfigData(data)
    if applied then pcall(writefile, Library.ConfigFolder .. "/_last.txt", tostring(name)) end
    return applied
end

-- Name of the most recently saved/loaded config, if any. Lets a game
-- restore the player's last-used settings on the next launch via
-- Library:LoadLastConfig() without the caller needing to track it.
function Library:GetLastConfig()
    if type(readfile) ~= "function" then return nil end
    local path = Library.ConfigFolder .. "/_last.txt"
    if type(isfile) == "function" and not isfile(path) then return nil end
    local ok, raw = pcall(readfile, path)
    if ok and type(raw) == "string" and raw ~= "" then return raw end
    return nil
end

function Library:LoadLastConfig()
    local name = Library:GetLastConfig()
    if not name then return false end
    return Library:LoadConfig(name)
end

-- List saved config names (without extension).
function Library:ListConfigs()
    local out = {}
    if type(listfiles) ~= "function" then return out end
    ensureConfigFolder()
    local ok, files = pcall(listfiles, Library.ConfigFolder)
    if not ok or type(files) ~= "table" then return out end
    for _, file in ipairs(files) do
        local name = string.match(tostring(file), "([^/\\]+)%.json$")
        if name then table.insert(out, name) end
    end
    return out
end

-- Delete a saved config file.
function Library:DeleteConfig(name)
    if type(delfile) ~= "function" then return false end
    local path = configPath(name)
    if type(isfile) == "function" and not isfile(path) then return false end
    return (pcall(delfile, path))
end

function Library:Notify(opts)
    for index = #Library._windowObjects, 1, -1 do
        local window = Library._windowObjects[index]
        if window and window.ScreenGui and window.ScreenGui.Parent then
            return window:Notify(opts)
        end
    end
    warn("[Sovereigns] create a window before calling Library:Notify")
    return nil
end
function Library:Notification(opts) return self:Notify(opts) end

-- Ask the presence server to kick a user. The local player must be in the
-- server's admin list for this to succeed. Returns (ok, errorString).
function Library:AdminDisconnect(userId)
    if not httpRequest then return false, "no HTTP request function" end
    local lp = Players.LocalPlayer
    if not lp then return false, "no LocalPlayer" end
    userId = tonumber(userId)
    if not userId then return false, "invalid userId" end

    local pok, body = pcall(function()
        return HttpService:JSONEncode({ adminId = lp.UserId, userId = userId })
    end)
    if not pok or not body then return false, "encode failed" end

    local ok, res = pcall(function()
        return httpRequest({
            Url     = TAG_ADMIN_DISCONNECT,
            Method  = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body    = body,
        })
    end)
    if not ok or not res then return false, "request failed" end

    local status = tonumber(res.StatusCode) or 0
    if status >= 200 and status < 300 then return true end
    if status == 403 then return false, "not authorized" end
    return false, ("server returned " .. tostring(status))
end

-- Returns true if the local player is in the client-side admin list. The
-- server still validates every admin command; this is only used by the UI
-- to decide whether to render the admin panel.
function Library:IsAdmin()
    return isAdminUser(Players.LocalPlayer)
end

function Library:DestroyAll()
    local windows = table.clone(Library._windows)
    for _, screenGui in ipairs(windows) do if screenGui then screenGui:Destroy() end end
    table.clear(Library._windows)
    table.clear(Library._windowObjects or {})
    table.clear(Library.Flags)
end

-- ════════════════════════════════════════════════════════════════════════════
-- MUSIC PLAYER BUILDER (kept as its own function so its locals do not count
-- against CreateWindow's Luau local-register budget)
-- ════════════════════════════════════════════════════════════════════════════
local function buildMusicPlayer(cfg)
    local screenGui      = cfg.screenGui
    local profileWidth   = cfg.profileWidth
    local bottomMargin   = cfg.bottomMargin
    local panelGap       = cfg.panelGap
    local musicToggleBtn = cfg.toggleBtn
    local musicToggleIcon= cfg.toggleIcon
    local musicConns     = cfg.conns
    local opts           = cfg.opts or {}

    local CLOSE_RED      = Color3.fromRGB(190, 60, 60)
    local CLOSE_RED_HI   = Color3.fromRGB(212, 80, 80)
    local MIN_YELLOW     = Color3.fromRGB(255, 195, 0)
    local MIN_YELLOW_HI  = Color3.fromRGB(255, 211, 70)
    local MUSIC_FOLDER   = tostring(opts.MusicFolder or "SovereignsMusic")
    local musicWidth     = profileWidth
    local fullHeight     = 384
    local compactHeight  = 190
    local profilePanelH  = 382
    local musicOpenPos   = UDim2.new(1, -18, 1, -(bottomMargin + profilePanelH + panelGap))
    local musicClosedPos = UDim2.new(1, musicWidth + 28, 1, -(bottomMargin + profilePanelH + panelGap))
    local musicOpen      = false
    local minimized      = false

    -- 2D audio playback via SoundService
    local SoundService = game:GetService("SoundService")
    local musicSound   = Instance.new("Sound")
    musicSound.Name   = "SovereignsMusicPlayer"
    musicSound.Volume = 0.5
    musicSound.Looped = false
    pcall(function() musicSound.Parent = SoundService end)

    -- Filesystem / asset capabilities (guarded for non-executor environments)
    local fsList       = (typeof(listfiles) == "function") and listfiles or nil
    local fsIsFolder   = (typeof(isfolder) == "function") and isfolder or nil
    local fsMakeFolder = (typeof(makefolder) == "function") and makefolder or nil
    local assetLoader  = (typeof(getcustomasset) == "function" and getcustomasset)
        or (typeof(getsynasset) == "function" and getsynasset) or nil
    if fsMakeFolder and fsIsFolder and not fsIsFolder(MUSIC_FOLDER) then
        pcall(fsMakeFolder, MUSIC_FOLDER)
    end

    local tracks       = {}
    local currentIndex = 0
    local isPlaying    = false
    local function baseName(p)
        local n = string.match(tostring(p), "[^/\\]+$") or tostring(p)
        return (string.gsub(n, "%.[%w]+$", ""))
    end
    local function fmtTime(t)
        t = math.max(0, math.floor(t or 0))
        return string.format("%d:%02d", math.floor(t / 60), t % 60)
    end

    -- ── Panel shell (compact, matches the profile / performance panels) ─────
    -- Glass-style panel: translucent background + soft diagonal sheen + a
    -- glowing accent border, so it reads like a modern acrylic flyout.
    local musicPanel = make("CanvasGroup", { Name = "MusicPlayer", AnchorPoint = Vector2.new(1, 1), Position = musicClosedPos, Size = UDim2.fromOffset(musicWidth, fullHeight), BackgroundColor3 = C.CardBg, BackgroundTransparency = 0.1, GroupTransparency = 1, ClipsDescendants = true, ZIndex = 150, Parent = screenGui })
    corner(musicPanel, 14)
    local musicPanelGlow = stroke(musicPanel, C.Accent); musicPanelGlow.Transparency = 0.7; musicPanelGlow.Thickness = 1
    local musicSheen = make("Frame", { Name = "Sheen", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), ZIndex = 150, Parent = musicPanel })
    make("UIGradient", { Rotation = 110, Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.45, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255)),
    }), Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0.00, 0.90),
        NumberSequenceKeypoint.new(0.45, 0.97),
        NumberSequenceKeypoint.new(1.00, 1.00),
    }), Parent = musicSheen })

    -- Header
    make("TextLabel", { Text = "MUSIC PLAYER", Font = Enum.Font.GothamBold, TextSize = 13, TextColor3 = C.White, TextXAlignment = Enum.TextXAlignment.Left, BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 12), Size = UDim2.new(1, -70, 0, 18), ZIndex = 152, Parent = musicPanel })
    local subLabel = make("TextLabel", { Text = MUSIC_FOLDER, Font = Enum.Font.Gotham, TextSize = 10, TextColor3 = C.TextDim, TextXAlignment = Enum.TextXAlignment.Left, BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 30), Size = UDim2.new(1, -70, 0, 14), ZIndex = 152, Parent = musicPanel })
    make("Frame", { Position = UDim2.new(0, 16, 0, 48), Size = UDim2.new(1, -32, 0, 1), BackgroundColor3 = C.Border, ZIndex = 151, Parent = musicPanel })
    -- macOS-style traffic lights (minimize = yellow, close = red), matching the main window
    local controls = make("Frame", { AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -14, 0, 15), Size = UDim2.fromOffset(32, 13), BackgroundTransparency = 1, ZIndex = 152, Parent = musicPanel })
    local minimizeBtn = make("TextButton", { Text = "", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(0, 13, 0, 0), Size = UDim2.fromOffset(13, 13), BackgroundColor3 = MIN_YELLOW, ZIndex = 153, Parent = controls })
    circle(minimizeBtn)
    local musicCloseBtn = make("TextButton", { Text = "", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 0), Size = UDim2.fromOffset(13, 13), BackgroundColor3 = CLOSE_RED, ZIndex = 153, Parent = controls })
    circle(musicCloseBtn)

    -- Now playing (text only — no album-art tile)
    local npTitle = make("TextLabel", { Text = "Nothing playing", Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = C.White, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 58), Size = UDim2.new(1, -32, 0, 18), ZIndex = 152, Parent = musicPanel })
    local npSub = make("TextLabel", { Text = "Add audio to the " .. MUSIC_FOLDER .. " folder", Font = Enum.Font.GothamMedium, TextSize = 11, TextColor3 = C.TextGray, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 78), Size = UDim2.new(1, -32, 0, 15), ZIndex = 152, Parent = musicPanel })

    -- Progress
    local progBg = make("Frame", { Position = UDim2.fromOffset(16, 104), Size = UDim2.new(1, -32, 0, 5), BackgroundColor3 = C.TrackBg, ZIndex = 152, Parent = musicPanel })
    corner(progBg, 3)
    local progFill = make("Frame", { Size = UDim2.new(0, 0, 1, 0), BackgroundColor3 = C.Accent, ZIndex = 153, Parent = progBg })
    corner(progFill, 3)
    local progKnob = make("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.fromOffset(10, 10), BackgroundColor3 = C.KnobAccent, ZIndex = 154, Parent = progBg })
    circle(progKnob); stroke(progKnob, C.Accent, 2)
    local curTime = make("TextLabel", { Text = "0:00", Font = Enum.Font.GothamMedium, TextSize = 10, TextColor3 = C.TextDim, TextXAlignment = Enum.TextXAlignment.Left, BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 114), Size = UDim2.fromOffset(60, 12), ZIndex = 152, Parent = musicPanel })
    local totTime = make("TextLabel", { Text = "0:00", Font = Enum.Font.GothamMedium, TextSize = 10, TextColor3 = C.TextDim, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -16, 0, 114), Size = UDim2.fromOffset(60, 12), ZIndex = 152, Parent = musicPanel })

    -- Controls (image-based transport icons; rewind sized up to match skip's visual weight)
    local ICON_PREV = "rbxassetid://79890332995329"
    local ICON_PLAY = "rbxassetid://10269757325"
    local ICON_NEXT = "rbxassetid://15946567603"
    local ctl = make("Frame", { Position = UDim2.fromOffset(0, 132), Size = UDim2.new(1, 0, 0, 48), BackgroundTransparency = 1, ZIndex = 152, Parent = musicPanel })
    make("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 16), Parent = ctl })
    local function iconBtn(imgId, btnSize, imgSize, order)
        local b = make("TextButton", { Text = "", BackgroundTransparency = 1, Size = UDim2.fromOffset(btnSize, btnSize), LayoutOrder = order, ZIndex = 153, Parent = ctl })
        local img = make("ImageLabel", { Image = imgId, ImageColor3 = C.TextGray, BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(imgSize, imgSize), ScaleType = Enum.ScaleType.Fit, ZIndex = 154, Parent = b })
        b.MouseEnter:Connect(function() tween(img, { ImageColor3 = C.White }) end)
        b.MouseLeave:Connect(function() tween(img, { ImageColor3 = C.TextGray }) end)
        return b, img
    end
    local prevBtn = iconBtn(ICON_PREV, 40, 54, 1)
    -- play / pause (icon only, accent-tinted): play uses a texture, pause is two clean bars
    local playBtn = make("TextButton", { Text = "", BackgroundTransparency = 1, Size = UDim2.fromOffset(52, 52), LayoutOrder = 2, ZIndex = 153, Parent = ctl })
    local playImg = make("ImageLabel", { Image = ICON_PLAY, ImageColor3 = C.Accent, BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(34, 34), ScaleType = Enum.ScaleType.Fit, ZIndex = 154, Parent = playBtn })
    local pauseHolder = make("Frame", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(16, 18), Visible = false, ZIndex = 154, Parent = playBtn })
    local pb1 = make("Frame", { Size = UDim2.fromOffset(5, 18), Position = UDim2.fromOffset(1, 0), BackgroundColor3 = C.Accent, ZIndex = 155, Parent = pauseHolder }); corner(pb1, 2)
    local pb2 = make("Frame", { Size = UDim2.fromOffset(5, 18), Position = UDim2.fromOffset(10, 0), BackgroundColor3 = C.Accent, ZIndex = 155, Parent = pauseHolder }); corner(pb2, 2)
    local nextBtn = iconBtn(ICON_NEXT, 40, 30, 3)

    -- Volume
    local volRow = make("Frame", { Position = UDim2.fromOffset(16, 190), Size = UDim2.new(1, -32, 0, 16), BackgroundTransparency = 1, ZIndex = 152, Parent = musicPanel })
    make("TextLabel", { Text = "VOL", Font = Enum.Font.GothamBold, TextSize = 9, TextColor3 = C.TextDim, TextXAlignment = Enum.TextXAlignment.Left, BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 2), Size = UDim2.fromOffset(26, 12), ZIndex = 153, Parent = volRow })
    local volBg = make("Frame", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 30, 0.5, 0), Size = UDim2.new(1, -30, 0, 5), BackgroundColor3 = C.TrackBg, ZIndex = 152, Parent = volRow })
    corner(volBg, 3)
    local volFill = make("Frame", { Size = UDim2.new(0.5, 0, 1, 0), BackgroundColor3 = C.Accent, ZIndex = 153, Parent = volBg })
    corner(volFill, 3)
    local volKnob = make("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.fromOffset(10, 10), BackgroundColor3 = C.KnobAccent, ZIndex = 154, Parent = volBg })
    circle(volKnob); stroke(volKnob, C.Accent, 2)

    -- Playlist header (label + refresh)
    local plLabel = make("TextLabel", { Text = "PLAYLIST", Font = Enum.Font.GothamBold, TextSize = 10, TextColor3 = C.TextDim, TextXAlignment = Enum.TextXAlignment.Left, BackgroundTransparency = 1, Position = UDim2.fromOffset(18, 216), Size = UDim2.fromOffset(120, 14), ZIndex = 152, Parent = musicPanel })
    local refreshBtn = make("TextButton", { Text = "", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -16, 0, 223), Size = UDim2.fromOffset(22, 22), BackgroundColor3 = C.Element, ZIndex = 152, Parent = musicPanel })
    corner(refreshBtn, 7); stroke(refreshBtn, C.Border)
    local refreshIcon = make("ImageLabel", { Image = ICONS.refresh, ImageColor3 = C.TextGray, BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(13, 13), ZIndex = 153, Parent = refreshBtn })

    -- Playlist
    local list = make("ScrollingFrame", { Position = UDim2.fromOffset(16, 238), Size = UDim2.new(1, -32, 1, -254), BackgroundColor3 = C.WindowBg, ScrollBarThickness = 3, ScrollBarImageColor3 = C.Border, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ZIndex = 152, Parent = musicPanel })
    corner(list, 11); pad(list, 6, 6, 6, 6)
    make("UIListLayout", { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, Parent = list })
    local emptyLbl = make("TextLabel", { Text = "No tracks — drop audio files in the\n" .. MUSIC_FOLDER .. " folder, then hit refresh", Font = Enum.Font.GothamMedium, TextSize = 11, TextColor3 = C.TextDim, BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -20, 0, 40), ZIndex = 153, Parent = list })

    -- elements hidden when minimized
    local lowerEls = { volRow, plLabel, refreshBtn, list }

    -- ── Behaviour ─────────────────────────────────────────────────────────
    local rows = {}
    local refreshPlaylist, playIndex, updateNowPlaying

    function updateNowPlaying()
        local t = tracks[currentIndex]
        if t then
            npTitle.Text = t.name
            npSub.Text = isPlaying and "Now playing" or "Paused"
        else
            npTitle.Text = "Nothing playing"
            npSub.Text = (#tracks > 0) and "Select a track" or ("Add audio to the " .. MUSIC_FOLDER .. " folder")
        end
        playImg.Visible = not isPlaying
        pauseHolder.Visible = isPlaying
    end

    function refreshPlaylist()
        for _, r in pairs(rows) do r:Destroy() end
        table.clear(rows)
        emptyLbl.Visible = (#tracks == 0)
        for i, t in ipairs(tracks) do
            local active = (i == currentIndex)
            local row = make("TextButton", { Text = "", Size = UDim2.new(1, 0, 0, 38), BackgroundColor3 = active and C.ElementHover or C.Element, LayoutOrder = i, ZIndex = 153, Parent = list })
            corner(row, 9)
            if active then stroke(row, C.Accent, 1) end
            local num = make("Frame", { Position = UDim2.fromOffset(7, 6), Size = UDim2.fromOffset(26, 26), BackgroundColor3 = active and C.Accent or C.CardBg, ZIndex = 154, Parent = row })
            corner(num, 8)
            make("TextLabel", { Text = tostring(i), Font = Enum.Font.GothamBold, TextSize = 11, TextColor3 = active and C.AccentText or C.TextGray, BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 155, Parent = num })
            make("TextLabel", { Text = t.name, Font = Enum.Font.GothamMedium, TextSize = 12, TextColor3 = active and C.White or C.TextGray, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, BackgroundTransparency = 1, Position = UDim2.fromOffset(42, 0), Size = UDim2.new(1, -76, 1, 0), ZIndex = 154, Parent = row })
            local rm = make("TextButton", { Text = "", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(20, 20), BackgroundTransparency = 1, ZIndex = 155, Parent = row })
            local x1 = make("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(11, 2), BackgroundColor3 = C.TextDim, Rotation = 45, ZIndex = 156, Parent = rm })
            corner(x1, 1)
            local x2 = make("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(11, 2), BackgroundColor3 = C.TextDim, Rotation = -45, ZIndex = 156, Parent = rm })
            corner(x2, 1)
            row.MouseEnter:Connect(function() if not (currentIndex == i) then tween(row, { BackgroundColor3 = C.ElementHover }) end end)
            row.MouseLeave:Connect(function() if not (currentIndex == i) then tween(row, { BackgroundColor3 = C.Element }) end end)
            rm.MouseEnter:Connect(function() tween(x1, { BackgroundColor3 = C.White }); tween(x2, { BackgroundColor3 = C.White }) end)
            rm.MouseLeave:Connect(function() tween(x1, { BackgroundColor3 = C.TextDim }); tween(x2, { BackgroundColor3 = C.TextDim }) end)
            row.MouseButton1Click:Connect(function() playIndex(i) end)
            rm.MouseButton1Click:Connect(function()
                table.remove(tracks, i)
                if currentIndex == i then
                    pcall(function() musicSound:Stop() end); isPlaying = false; currentIndex = 0
                elseif currentIndex > i then currentIndex = currentIndex - 1 end
                updateNowPlaying(); refreshPlaylist()
            end)
            rows[i] = row
        end
    end

    function playIndex(i)
        if #tracks == 0 then return end
        if i < 1 then i = #tracks elseif i > #tracks then i = 1 end
        local t = tracks[i]
        if not t.id then
            if assetLoader then
                local ok, res = pcall(assetLoader, t.path)
                if ok and res then t.id = res end
            end
        end
        if not t.id then
            currentIndex = i; npTitle.Text = t.name
            npSub.Text = assetLoader and "Couldn't load file" or "Asset loader unavailable"
            isPlaying = false; updateNowPlaying(); refreshPlaylist(); return
        end
        currentIndex = i
        musicSound.SoundId = t.id
        musicSound.TimePosition = 0
        pcall(function() musicSound:Play() end)
        isPlaying = true
        updateNowPlaying(); refreshPlaylist()
    end

    local function togglePlay()
        if #tracks == 0 then return end
        if currentIndex == 0 then playIndex(1); return end
        if isPlaying then pcall(function() musicSound:Pause() end); isPlaying = false
        else pcall(function() musicSound:Resume() end); isPlaying = true end
        updateNowPlaying(); refreshPlaylist()
    end
    local function nextTrack()
        if #tracks == 0 then return end
        playIndex(currentIndex + 1)
    end
    local function prevTrack()
        if #tracks == 0 then return end
        if musicSound.TimePosition > 3 then musicSound.TimePosition = 0 else playIndex(currentIndex - 1) end
    end
    local function rescan()
        if not (fsList and fsIsFolder) then npSub.Text = "File API unavailable"; updateNowPlaying(); refreshPlaylist(); return end
        if fsMakeFolder and not fsIsFolder(MUSIC_FOLDER) then pcall(fsMakeFolder, MUSIC_FOLDER) end
        local prev = tracks[currentIndex]
        tracks = {}; currentIndex = 0
        if fsIsFolder(MUSIC_FOLDER) then
            local ok, files = pcall(fsList, MUSIC_FOLDER)
            if ok and files then
                for _, f in ipairs(files) do
                    local lf = string.lower(f)
                    if lf:sub(-4) == ".mp3" or lf:sub(-4) == ".ogg" or lf:sub(-4) == ".wav" or lf:sub(-5) == ".flac" then
                        table.insert(tracks, { name = baseName(f), path = f })
                        if prev and prev.path == f then currentIndex = #tracks end
                    end
                end
            end
        end
        updateNowPlaying(); refreshPlaylist()
    end

    -- Sliders
    local function setVol(f)
        f = math.clamp(f, 0, 1); musicSound.Volume = f
        volFill.Size = UDim2.new(f, 0, 1, 0); volKnob.Position = UDim2.new(f, 0, 0.5, 0)
    end
    setVol(0.5)
    local volDrag, seekDrag = false, false
    volBg.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then volDrag = true; setVol((i.Position.X - volBg.AbsolutePosition.X) / math.max(1, volBg.AbsoluteSize.X)) end end)
    volBg.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then volDrag = false end end)
    progBg.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then seekDrag = true end end)
    progBg.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            if seekDrag and musicSound.TimeLength > 0 then
                musicSound.TimePosition = math.clamp((i.Position.X - progBg.AbsolutePosition.X) / math.max(1, progBg.AbsoluteSize.X), 0, 1) * musicSound.TimeLength
            end
            seekDrag = false
        end
    end)
    table.insert(musicConns, UserInputService.InputChanged:Connect(function(i)
        if i.UserInputType ~= Enum.UserInputType.MouseMovement and i.UserInputType ~= Enum.UserInputType.Touch then return end
        if volDrag then setVol((i.Position.X - volBg.AbsolutePosition.X) / math.max(1, volBg.AbsoluteSize.X)) end
        if seekDrag then
            local f = math.clamp((i.Position.X - progBg.AbsolutePosition.X) / math.max(1, progBg.AbsoluteSize.X), 0, 1)
            progFill.Size = UDim2.new(f, 0, 1, 0); progKnob.Position = UDim2.new(f, 0, 0.5, 0)
        end
    end))

    -- Wire
    playBtn.MouseButton1Click:Connect(togglePlay)
    nextBtn.MouseButton1Click:Connect(nextTrack)
    prevBtn.MouseButton1Click:Connect(prevTrack)
    refreshBtn.MouseButton1Click:Connect(rescan)
    refreshBtn.MouseEnter:Connect(function() tween(refreshBtn, { BackgroundColor3 = C.ElementHover }); tween(refreshIcon, { ImageColor3 = C.White }) end)
    refreshBtn.MouseLeave:Connect(function() tween(refreshBtn, { BackgroundColor3 = C.Element }); tween(refreshIcon, { ImageColor3 = C.TextGray }) end)
    table.insert(musicConns, musicSound.Ended:Connect(function() nextTrack() end))
    table.insert(musicConns, RunService.RenderStepped:Connect(function()
        if not (musicPanel and musicPanel.Parent) or not musicOpen then return end
        local len = musicSound.TimeLength
        if isPlaying and len and len > 0 then
            if not seekDrag then
                local f = math.clamp(musicSound.TimePosition / len, 0, 1)
                progFill.Size = UDim2.new(f, 0, 1, 0); progKnob.Position = UDim2.new(f, 0, 0.5, 0)
            end
            curTime.Text = fmtTime(musicSound.TimePosition); totTime.Text = fmtTime(len)
        end
    end))
    table.insert(musicConns, { Disconnect = function() pcall(function() musicSound:Stop(); musicSound:Destroy() end) end })

    -- Minimize / close (macOS traffic lights)
    local function setMinimized(m)
        minimized = (m == true)
        for _, e in ipairs(lowerEls) do e.Visible = not minimized end
        TweenService:Create(musicPanel, PROFILE_TWEEN, { Size = UDim2.fromOffset(musicWidth, minimized and compactHeight or fullHeight) }):Play()
    end
    minimizeBtn.MouseEnter:Connect(function() tween(minimizeBtn, { BackgroundColor3 = MIN_YELLOW_HI }) end)
    minimizeBtn.MouseLeave:Connect(function() tween(minimizeBtn, { BackgroundColor3 = MIN_YELLOW }) end)
    minimizeBtn.MouseButton1Click:Connect(function() setMinimized(not minimized) end)
    musicCloseBtn.MouseEnter:Connect(function() tween(musicCloseBtn, { BackgroundColor3 = CLOSE_RED_HI }) end)
    musicCloseBtn.MouseLeave:Connect(function() tween(musicCloseBtn, { BackgroundColor3 = CLOSE_RED }) end)

    local function setMusicVisible(v, instant)
        musicOpen = (v == true)
        local tp = musicOpen and musicOpenPos or musicClosedPos
        local tr = musicOpen and 0 or 1
        if instant then
            musicPanel.Position = tp; musicPanel.GroupTransparency = tr
        else
            TweenService:Create(musicPanel, PROFILE_TWEEN, { Position = tp, GroupTransparency = tr }):Play()
        end
        if musicToggleBtn then musicToggleBtn.BackgroundColor3 = musicOpen and C.PillActive or C.Element end
        if musicToggleIcon then musicToggleIcon.ImageColor3 = musicOpen and C.Accent or C.TextGray end
        if musicOpen and #tracks == 0 then rescan() end
    end
    local function toggleMusic() setMusicVisible(not musicOpen) end
    local function closeMusic(instant) setMusicVisible(false, instant) end
    musicCloseBtn.MouseButton1Click:Connect(function() setMusicVisible(false) end)

    if musicToggleBtn then
        musicToggleBtn.MouseEnter:Connect(function() if not musicOpen then tween(musicToggleBtn, { BackgroundColor3 = C.ElementHover }) end end)
        musicToggleBtn.MouseLeave:Connect(function() tween(musicToggleBtn, { BackgroundColor3 = musicOpen and C.PillActive or C.Element }) end)
    end

    rescan(); updateNowPlaying()
    return toggleMusic, closeMusic
end

function Library:CreateWindow(opts)
    opts = opts or {}

    -- Auto-start the tag system
    startTagSystem()

    local logoAsset      = normalizeAssetId(opts.Logo or DEFAULT_LOGO)
    -- Zoom factor applied to the logo inside its clipping holder. The default
    -- asset is mostly transparent padding, so it needs a healthy zoom to read;
    -- a caller-supplied logo is assumed to be already cropped.
    local logoZoom       = math.clamp(tonumber(opts.LogoZoom) or (logoAsset == DEFAULT_LOGO and 2.4 or 1), 1, 6)
    local windowSize     = opts.Size or UDim2.fromOffset(700, 490)
    local windowPosition = opts.Position or UDim2.fromScale(0.5, 0.5)
    local guiName        = opts.GuiName or "Sovereigns"

    -- Mobile detection (auto, or forced via opts.Mobile = true/false)
    local isMobile = (opts.Mobile == true)
        or (opts.Mobile ~= false and UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled)

    local HOTBAR_HEIGHT  = 36
    local HOTBAR_GAP     = 14

    local targetParent
    if typeof(opts.Parent) == "Instance" then
        targetParent = opts.Parent
    else
        pcall(function() targetParent = (gethui and gethui()) or game:GetService("CoreGui") end)
        if not targetParent then targetParent = Players.LocalPlayer:WaitForChild("PlayerGui") end
    end

    local function removeExistingGui(parent)
        if opts.ReplaceExisting == false or not parent then return end
        for _, child in ipairs(parent:GetChildren()) do
            if child:IsA("ScreenGui") and child.Name == guiName then child:Destroy() end
        end
    end

    removeExistingGui(targetParent)

    local screenGui = make("ScreenGui", {
        Name = guiName, ResetOnSpawn = false, IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = opts.DisplayOrder or 10,
    })
    local parented = pcall(function() screenGui.Parent = targetParent end)
    if not parented then
        targetParent = Players.LocalPlayer:WaitForChild("PlayerGui")
        removeExistingGui(targetParent)
        screenGui.Parent = targetParent
    end
    table.insert(Library._windows, screenGui)

    local containerW = windowSize.X.Offset
    local containerH = windowSize.Y.Offset + HOTBAR_GAP + HOTBAR_HEIGHT

    local container = make("Frame", {
        Name = "SovereignsContainer",
        Size = UDim2.fromOffset(containerW, containerH),
        Position = windowPosition,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        ZIndex = 2,
        Parent = screenGui,
    })
    local containerScale = make("UIScale", { Scale = 1, Parent = container })

    -- ── LOADING SCREEN (slam-in intro, themed with the accent colour) ─────
    local loadingEnabled      = opts.LoadingAnimation ~= false
    local loadingDuration     = math.clamp(tonumber(opts.LoadingDuration) or 2.65, 1.5, 8)
    local loadingText         = tostring(opts.LoadingText or opts.Name or "Sovereigns")
    local loadingSub          = tostring(opts.LoadingSubtitle or "HUB")
    local loadingFooter       = tostring(opts.LoadingFooter or "Sovereigns")
    local overlayTransparency = math.clamp(tonumber(opts.LoadingOverlayTransparency) or 0.35, 0, 0.9)

    -- accent palette derived from the active theme
    local ACC       = C.Accent
    local ACC_DARK  = C.AccentDim or Color3.fromRGB(20, 38, 64)
    local ACC_LIGHT = Color3.fromRGB(255, 255, 255)

    local loadingComplete       = not loadingEnabled
    local loadingMotionComplete = not loadingEnabled
    local loadingLayer, loadingContent, loadingLogoScale, loadingTitleScale, loadingProgressFill
    local loadingBlur, loadingSound

    if loadingEnabled then
        loadingLayer = make("CanvasGroup", {
            Name = "StartupLoader", Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1,
            GroupTransparency = 0, ZIndex = 500, Parent = screenGui,
        })

        if opts.LoadingBlur ~= false then
            loadingBlur = Instance.new("BlurEffect")
            loadingBlur.Size = 0
            pcall(function() loadingBlur.Parent = game:GetService("Lighting") end)
        end

        if opts.LoadingSound then
            loadingSound = Instance.new("Sound")
            loadingSound.SoundId = normalizeAssetId(opts.LoadingSound)
            loadingSound.Volume = 0
            loadingSound.Looped = false
            loadingSound.TimePosition = tonumber(opts.LoadingSoundStart) or 0
            pcall(function() loadingSound.Parent = SoundService end)
        end

        local function sideLabel(anchorX)
            local lbl = make("TextLabel", {
                Size = UDim2.fromOffset(260, 54), Position = UDim2.new(anchorX, 0, 0.5, -27),
                AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1,
                Text = loadingText, Font = Enum.Font.GothamBlack, TextScaled = true,
                TextColor3 = C.White, TextStrokeColor3 = Color3.fromRGB(0, 0, 0), TextStrokeTransparency = 0.45,
                TextTransparency = 1, ZIndex = 508, Parent = loadingLayer,
            })
            make("UIGradient", { Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, ACC_DARK),
                ColorSequenceKeypoint.new(0.5, ACC_LIGHT),
                ColorSequenceKeypoint.new(1, ACC_DARK),
            }), Parent = lbl })
            return lbl
        end
        local leftLbl  = sideLabel(0.18)
        local rightLbl = sideLabel(0.82)

        local mainWrap = make("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(80, 36),
            Position = UDim2.new(0.5, 0, 0.5, -20), BackgroundTransparency = 1, ZIndex = 510, Parent = loadingLayer,
        })
        local tag = make("TextLabel", {
            Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = loadingText,
            Font = Enum.Font.GothamBlack, TextScaled = true, TextColor3 = C.White,
            TextStrokeColor3 = Color3.fromRGB(0, 0, 0), TextStrokeTransparency = 0.3,
            TextXAlignment = Enum.TextXAlignment.Center, TextTransparency = 1, ZIndex = 510, Parent = mainWrap,
        })
        local tagGrad = make("UIGradient", { Rotation = 0, Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, ACC_DARK),
            ColorSequenceKeypoint.new(0.35, ACC),
            ColorSequenceKeypoint.new(0.5, ACC_LIGHT),
            ColorSequenceKeypoint.new(0.65, ACC),
            ColorSequenceKeypoint.new(1, ACC_DARK),
        }), Parent = tag })

        local line = make("Frame", {
            Size = UDim2.fromOffset(0, 2), Position = UDim2.new(0.5, 0, 0.5, 60), AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = ACC, BackgroundTransparency = 1, ZIndex = 510, Parent = loadingLayer,
        })
        make("UIGradient", { Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 1),
        }), Parent = line })

        local sub = make("TextLabel", {
            Size = UDim2.fromOffset(400, 22), Position = UDim2.new(0.5, 0, 0.5, 82), AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1, Text = loadingSub, Font = Enum.Font.GothamBold, TextSize = 16,
            TextColor3 = ACC_LIGHT, TextStrokeColor3 = Color3.fromRGB(0, 0, 0), TextStrokeTransparency = 0.5,
            TextXAlignment = Enum.TextXAlignment.Center, TextTransparency = 1, ZIndex = 510, Parent = loadingLayer,
        })
        local footer = make("TextLabel", {
            Size = UDim2.fromOffset(400, 16), Position = UDim2.new(0.5, 0, 0.5, 112), AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1, Text = loadingFooter, Font = Enum.Font.GothamMedium, TextSize = 11,
            TextColor3 = Color3.fromRGB(200, 150, 90), TextStrokeColor3 = Color3.fromRGB(0, 0, 0), TextStrokeTransparency = 0.6,
            TextXAlignment = Enum.TextXAlignment.Center, TextTransparency = 1, ZIndex = 510, Parent = loadingLayer,
        })

        task.spawn(function()
            if loadingBlur then TweenService:Create(loadingBlur, TweenInfo.new(0.4, Enum.EasingStyle.Quad), { Size = 10 }):Play() end
            if loadingSound then
                pcall(function() loadingSound:Play() end)
                TweenService:Create(loadingSound, TweenInfo.new(0.5), { Volume = math.clamp(tonumber(opts.LoadingSoundVolume) or 0.45, 0, 1) }):Play()
            end
            TweenService:Create(loadingLayer, TweenInfo.new(0.34, Enum.EasingStyle.Quad), { BackgroundTransparency = overlayTransparency }):Play()
            TweenService:Create(leftLbl, TweenInfo.new(0.25, Enum.EasingStyle.Quad), { TextTransparency = 0 }):Play()
            task.wait(0.16)
            TweenService:Create(rightLbl, TweenInfo.new(0.25, Enum.EasingStyle.Quad), { TextTransparency = 0 }):Play()
            task.wait(math.clamp(loadingDuration * 0.4, 0.5, 2.0))
            if not loadingLayer.Parent then return end
            local slideInfo = TweenInfo.new(0.32, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
            TweenService:Create(leftLbl, slideInfo, { Position = UDim2.new(0.5, 0, 0.5, -27) }):Play()
            TweenService:Create(rightLbl, slideInfo, { Position = UDim2.new(0.5, 0, 0.5, -27) }):Play()
            task.wait(0.32)
            leftLbl.Visible = false; rightLbl.Visible = false
            tag.TextTransparency = 0
            TweenService:Create(mainWrap, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(820, 140) }):Play()
            task.wait(0.26)
            line.BackgroundTransparency = 0
            TweenService:Create(line, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(380, 2) }):Play()
            TweenService:Create(sub, TweenInfo.new(0.4, Enum.EasingStyle.Quad), { TextTransparency = 0 }):Play()
            task.wait(0.16)
            TweenService:Create(footer, TweenInfo.new(0.35, Enum.EasingStyle.Quad), { TextTransparency = 0.1 }):Play()
            task.spawn(function()
                local off = -0.5
                while loadingLayer.Parent and not loadingComplete and tag.Parent do
                    off = off + 0.009; if off > 1.5 then off = -0.5 end
                    tagGrad.Offset = Vector2.new(off, 0)
                    task.wait()
                end
            end)
            task.wait(math.clamp(loadingDuration * 0.5, 0.4, 2.5))
            loadingMotionComplete = true
        end)
    end

    -- ── MAIN WINDOW ───────────────────────────────────────────────────────
    -- Soft drop shadow behind the window. Roblox Frames can't blur
    -- natively; two oversized, low-opacity layers give a soft falloff
    -- without the "rings" a fake blur gets when stacked three or more
    -- deep — one wide, faint outer pass and one closer, slightly darker
    -- pass right against the window edge.
    -- Tracked in `shadowFrames` so setMinimized()/setUIVisible() can hide
    -- these along with the window instead of leaving them stranded on screen.
    local shadowFrames = {}
    local shadowCenterX = windowSize.X.Offset / 2
    local shadowCenterY = windowSize.Y.Offset / 2
    for i, layer in ipairs({
        { grow = 34, alpha = 0.93 },
        { grow = 10, alpha = 0.82 },
    }) do
        local shadow = make("Frame", {
            Name = "Shadow" .. i,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromOffset(shadowCenterX, shadowCenterY + 5),
            Size = UDim2.fromOffset(windowSize.X.Offset + layer.grow, windowSize.Y.Offset + layer.grow),
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = layer.alpha,
            Visible = not loadingEnabled,
            ZIndex = 1,
            Parent = container,
        })
        corner(shadow, 12 + layer.grow / 3)
        table.insert(shadowFrames, shadow)
    end

    local main = make("Frame", {
        Name = "Main", Size = windowSize,
        Position = UDim2.fromOffset(0, 0),
        BackgroundColor3 = C.WindowBg, ClipsDescendants = true,
        Visible = not loadingEnabled, ZIndex = 2, Parent = container,
    })
    corner(main, 12); stroke(main, C.Border)
    -- A second, wider, near-transparent white ring just outside the normal
    -- border — reads as a soft glass edge catching light, rather than a
    -- hard outline.
    local glassRing = make("UIStroke", { Color = Color3.fromRGB(255,255,255), Thickness = 2.5, Transparency = 0.94, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = main })
    glassRing.LineJoinMode = Enum.LineJoinMode.Round

    -- Subtle top-to-bottom depth gradient. Kept as a translucent overlay
    -- (rather than recoloring `main` itself) so anything elsewhere that
    -- still assumes a flat WindowBg colour keeps matching it exactly.
    local mainDepth = make("Frame", {
        Name = "DepthGradient", Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.94,
        Parent = main,
    })
    corner(mainDepth, 12)
    local mainDepthGrad = make("UIGradient", { Rotation = 90, Parent = mainDepth })
    mainDepthGrad:SetAttribute("ThemeGradient_Top", "CardBg")
    mainDepthGrad:SetAttribute("ThemeGradient_Bottom", "WindowBg")
    mainDepthGrad:SetAttribute("ThemeGradient_Strength", 1)
    refreshVerticalFade(mainDepthGrad)

    -- Animated traveling outline
    local mainGlowStroke = make("UIStroke", {
        Color = C.Accent,
        Thickness = 1.6,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Transparency = 0,
        Parent = main,
    })
    local mainGlowGradient = make("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, C.Accent),
            ColorSequenceKeypoint.new(0.42, C.Accent),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(0.58, C.Accent),
            ColorSequenceKeypoint.new(1.00, C.Accent),
        }),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0.00, 1.0),
            NumberSequenceKeypoint.new(0.36, 1.0),
            NumberSequenceKeypoint.new(0.50, 0.0),
            NumberSequenceKeypoint.new(0.64, 1.0),
            NumberSequenceKeypoint.new(1.00, 1.0),
        }),
        Parent = mainGlowStroke,
    })
    mainGlowGradient:SetAttribute("ThemeGradient_Edge", "Accent")
    local mainRevealScale = make("UIScale", { Scale = loadingEnabled and 0.965 or 1, Parent = main })
    -- Assigned further down, once the sidebar watermark exists. Driving the logo
    -- outline from this same loop keeps it in phase with the window glow.
    local logoGlowGradient
    local brandShimmerGradient
    local glowT = 0
    local glowConn
    glowConn = RunService.RenderStepped:Connect(function(dt)
        if not main or not main.Parent then
            if glowConn then glowConn:Disconnect(); glowConn = nil end
            return
        end
        glowT = (glowT + dt * 0.35) % 1
        local offset = Vector2.new(glowT * 2 - 1, 0)
        mainGlowGradient.Offset = offset
        if logoGlowGradient then logoGlowGradient.Offset = offset end
        if brandShimmerGradient then brandShimmerGradient.Offset = offset end
    end)

    -- ── HOTBAR ────────────────────────────────────────────────────────────
    local hotbar = make("Frame", {
        Name = "TabHotbar",
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, windowSize.Y.Offset + HOTBAR_GAP),
        Size = UDim2.fromOffset(0, HOTBAR_HEIGHT),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = C.HotbarBg,
        BackgroundTransparency = 0.14,
        ClipsDescendants = false,
        Visible = not loadingEnabled,
        ZIndex = 3, Parent = container,
    })
    corner(hotbar, 11)
    -- Soft diagonal glass sheen, same recipe as the player card / music
    -- panel: a white overlay with a gradient transparency ramp.
    local hotbarSheen = make("Frame", { Name = "Sheen", Size = UDim2.fromScale(1,1), BackgroundColor3 = Color3.fromRGB(255,255,255), ZIndex = 3, Parent = hotbar })
    corner(hotbarSheen, 11)
    make("UIGradient", { Rotation = 100, Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(0.45, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255,255,255)),
    }), Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0.00, 0.90),
        NumberSequenceKeypoint.new(0.45, 0.97),
        NumberSequenceKeypoint.new(1.00, 1.00),
    }), Parent = hotbarSheen })
    hotbarSheen.ZIndex = 3
    -- Border is white and driven entirely by the gradient below: accent at the
    -- left and right ends, normal border colour through the middle. The
    -- Theme_Color tag has to go, otherwise SetTheme would repaint the white
    -- base and dim the whole gradient (it multiplies, it does not replace).
    local hotbarStroke = make("UIStroke", {
        Color = Color3.fromRGB(255, 255, 255), Thickness = 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = hotbar,
    })
    hotbarStroke:SetAttribute("Theme_Color", nil)
    edgeAccentGradient(hotbarStroke, "Accent", "HotbarBorder", 0.15)
    pad(hotbar, 5, 5, 10, 10)

    local hotbarInner = make("Frame", {
        Name = "HotbarInner",
        Size = UDim2.new(0, 0, 1, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1, ZIndex = 4, Parent = hotbar,
    })
    make("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 4), Parent = hotbarInner,
    })

    local minimized = false
    local mainTopButtons = {}
    local burgerButton
    local burgerScale
    local islandExpandThenSettle
    local windowRef
    local noDrag = {}
    table.insert(noDrag, hotbar)

    local mainScale = make("UIScale", { Scale = 1, Parent = main })

    local function setMinimized(o)
        local was = minimized
        minimized = o == true
        for _, b in ipairs(mainTopButtons) do if b and b.Parent then b.Visible = not minimized end end
        for _, s in ipairs(shadowFrames) do if s and s.Parent then s.Visible = not minimized end end
        if windowRef then windowRef._minimized = minimized end
        if minimized then
            -- Morph the window down into the island: shrink `main` toward
            -- its top edge, then reveal the island and pop it in with a
            -- slight overshoot — same spirit as a Dynamic Island expanding
            -- from/collapsing into a small pill.
            hotbar.Visible = false
            TweenService:Create(mainScale, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Scale = 0.85 }):Play()
            task.delay(0.16, function()
                if main and main.Parent then main.Visible = false; mainScale.Scale = 1 end
                if burgerButton and burgerButton.Parent then
                    burgerButton.Visible = true
                    if islandExpandThenSettle then islandExpandThenSettle()
                    else burgerScale.Scale = 0.5; TweenService:Create(burgerScale, TweenInfo.new(0.42, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play() end
                end
            end)
        elseif was then
            -- Morph the island back up into the full window.
            if burgerButton and burgerButton.Parent then
                TweenService:Create(burgerScale, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Scale = 0.5 }):Play()
                task.delay(0.14, function() burgerButton.Visible = false; burgerScale.Scale = 1 end)
            end
            main.Visible = true; hotbar.Visible = true
            mainScale.Scale = 0.9
            TweenService:Create(mainScale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
        end
    end

    local controls = make("Frame", {
        Name = "CornerControls", AnchorPoint = Vector2.new(1,0),
        Position = UDim2.new(1,-6,0,8), Size = UDim2.fromOffset(36,16),
        BackgroundTransparency = 1, ZIndex = 10, Parent = main,
    })
    local closeBtn = make("TextButton", {
        Text = "", Font = Enum.Font.GothamBold, TextSize = 1, TextColor3 = C.White,
        AnchorPoint = Vector2.new(1,0), Position = UDim2.new(1,0,0,0),
        Size = UDim2.fromOffset(14,14), BackgroundColor3 = Color3.fromRGB(210,70,70),
        ZIndex = 12, Parent = controls,
    })
    closeBtn.AutoButtonColor = false; circle(closeBtn); closeBtn.BorderSizePixel = 0
    local closeGlow = stroke(closeBtn, Color3.fromRGB(255,120,120)); closeGlow.Thickness = 2; closeGlow.Transparency = 1
    local closeScale = make("UIScale",{Scale=1,Parent=closeBtn})
    local minimizeBtn = make("TextButton", {
        Text = "", Font = Enum.Font.GothamBold, TextSize = 1, TextColor3 = C.White,
        AnchorPoint = Vector2.new(1,0), Position = UDim2.new(0,12,0,0),
        Size = UDim2.fromOffset(14,14), BackgroundColor3 = Color3.fromRGB(255,200,20),
        ZIndex = 12, Parent = controls,
    })
    minimizeBtn.AutoButtonColor = false; circle(minimizeBtn); minimizeBtn.BorderSizePixel = 0
    local minGlow = stroke(minimizeBtn, Color3.fromRGB(255,225,110)); minGlow.Thickness = 2; minGlow.Transparency = 1
    local minScale = make("UIScale",{Scale=1,Parent=minimizeBtn})
    table.insert(mainTopButtons, closeBtn); table.insert(mainTopButtons, minimizeBtn)
    table.insert(noDrag, closeBtn); table.insert(noDrag, minimizeBtn)
    -- Scale pop + glow ring on hover — no glyph icons, just the color chip
    -- brightening and lifting slightly, like a plain macOS-style dot.
    closeBtn.MouseEnter:Connect(function() TweenService:Create(closeScale,TWEEN,{Scale=1.18}):Play(); tween(closeGlow,{Transparency=0.35}) end)
    closeBtn.MouseLeave:Connect(function() TweenService:Create(closeScale,TWEEN,{Scale=1}):Play(); tween(closeGlow,{Transparency=1}) end)
    minimizeBtn.MouseEnter:Connect(function() TweenService:Create(minScale,TWEEN,{Scale=1.18}):Play(); tween(minGlow,{Transparency=0.35}) end)
    minimizeBtn.MouseLeave:Connect(function() TweenService:Create(minScale,TWEEN,{Scale=1}):Play(); tween(minGlow,{Transparency=1}) end)

    -- ── "Dynamic Island" minimized state ────────────────────────────────
    -- A theme-synced capsule docked at top-center of the screen, following
    -- the reference's 3-stage behavior: pops open EXPANDED with a status
    -- line right when minimized, contracts down to a normal logo-only
    -- pill shortly after, then shrinks further to a tiny idle sliver if
    -- left alone — expanding back on hover/click. Uses real theme colors
    -- (CardBg/ElementHover) so `make()`'s auto-tagging picks it up for
    -- live repaints when SetTheme runs, same as everything else themed.
    local ISLAND_EXPANDED = UDim2.fromOffset(230, 44)
    local ISLAND_NORMAL   = UDim2.fromOffset(90, 34)
    local ISLAND_IDLE     = UDim2.fromOffset(48, 20)
    local ISLAND_IDLE_DELAY = 6 -- seconds of no interaction before it shrinks to idle

    burgerButton = make("TextButton", {
        Name = "Island", Text = "", AutoButtonColor = false,
        AnchorPoint = Vector2.new(0.5,0), Position = UDim2.new(0.5,0,0,10),
        Size = ISLAND_NORMAL, BackgroundColor3 = C.CardBg,
        ClipsDescendants = true,
        Visible = false, ZIndex = 11, Parent = screenGui,
    })
    corner(burgerButton, 17)
    burgerScale = make("UIScale", { Scale = 1, Parent = burgerButton })
    local islandGlow = stroke(burgerButton, C.Accent); islandGlow.Thickness = 1.2; islandGlow.Transparency = 0.55

    -- Fixed "camera" reference on the right edge — a plain dark lens, not
    -- an animated accent-colored dot, matching a real Dynamic Island.
    local islandCamera = make("Frame", { AnchorPoint=Vector2.new(1,0.5), Position=UDim2.new(1,-11,0.5,0), Size=UDim2.fromOffset(9,9), BackgroundColor3=Color3.fromRGB(8,8,10), ZIndex=13, Parent=burgerButton })
    circle(islandCamera)
    stroke(islandCamera, Color3.fromRGB(42,42,48)).Thickness = 1
    local camGlint = make("Frame", { AnchorPoint=Vector2.new(0.5,0.5), Position=UDim2.new(0.36,0,0.36,0), Size=UDim2.fromOffset(2,2), BackgroundColor3=Color3.fromRGB(75,75,85), ZIndex=14, Parent=islandCamera })
    circle(camGlint)

    local islandLogo = make("ImageLabel",{Name="IslandLogo",Image=logoAsset,BackgroundTransparency=1,AnchorPoint=Vector2.new(0,0.5),Position=UDim2.fromOffset(10,17),Size=UDim2.fromOffset(30,30),ZIndex=13,ScaleType=Enum.ScaleType.Fit,Parent=burgerButton})
    local islandTitle = make("TextLabel",{Name="IslandTitle",Text=(opts.Name or "Settings").." minimized",Font=Enum.Font.GothamBold,TextSize=12,TextColor3=C.White,TextTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,BackgroundTransparency=1,Position=UDim2.fromOffset(48,7),Size=UDim2.new(1,-70,0,15),ZIndex=13,Parent=burgerButton})
    local islandSub = make("TextLabel",{Name="IslandSub",Text="Tap to reopen",Font=Enum.Font.Gotham,TextSize=10,TextColor3=C.TextDim,TextTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,BackgroundTransparency=1,Position=UDim2.fromOffset(48,22),Size=UDim2.new(1,-70,0,13),ZIndex=13,Parent=burgerButton})

    -- Slow breathing pulse on the glow so the island reads as "alive"
    -- while sitting minimized.
    local islandBreatheConn
    islandBreatheConn = RunService.RenderStepped:Connect(function()
        if not burgerButton or not burgerButton.Parent then if islandBreatheConn then islandBreatheConn:Disconnect() end return end
        if not burgerButton.Visible then return end
        islandGlow.Transparency = 0.55 + math.sin(os.clock()*2.2)*0.2
    end)

    local islandStage = "normal" -- "expanded" | "normal" | "idle"
    local islandLastInteract = os.clock()
    local islandWatchdogRunning = false
    local ISL_TWEEN = TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    local ISL_TWEEN_IN = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

    local function islandGoNormal(instant)
        islandStage = "normal"
        local ti = instant and TweenInfo.new(0.001) or ISL_TWEEN
        TweenService:Create(burgerButton, ti, { Size = ISLAND_NORMAL }):Play()
        TweenService:Create(islandLogo, ti, { Position = UDim2.fromOffset(10,17) }):Play()
        tween(islandTitle, { TextTransparency = 1 }); tween(islandSub, { TextTransparency = 1 })
    end
    local function islandGoIdle()
        if islandStage ~= "normal" then return end
        islandStage = "idle"
        TweenService:Create(burgerButton, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { Size = ISLAND_IDLE }):Play()
        tween(islandLogo, { ImageTransparency = 1 })
    end
    local function islandWatchdog()
        if islandWatchdogRunning then return end
        islandWatchdogRunning = true
        task.spawn(function()
            while burgerButton and burgerButton.Parent and burgerButton.Visible do
                task.wait(0.5)
                if islandStage == "normal" and (os.clock() - islandLastInteract) > ISLAND_IDLE_DELAY then
                    islandGoIdle()
                end
            end
            islandWatchdogRunning = false
        end)
    end
    local function islandWake()
        islandLastInteract = os.clock()
        if islandStage == "idle" then
            islandStage = "normal"
            TweenService:Create(burgerButton, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = ISLAND_NORMAL }):Play()
            islandLogo.ImageTransparency = 0
        end
    end
    -- Called from setMinimized(): pop open EXPANDED with a status line,
    -- hold briefly, then contract to the normal logo-only pill and start
    -- the idle watchdog.
    islandExpandThenSettle = function()
        islandStage = "expanded"; islandLastInteract = os.clock()
        burgerButton.Size = UDim2.fromOffset(48,34)
        islandLogo.Position = UDim2.fromOffset(9,17)
        TweenService:Create(burgerButton, ISL_TWEEN, { Size = ISLAND_EXPANDED }):Play()
        tween(islandTitle, { TextTransparency = 0 }); tween(islandSub, { TextTransparency = 0 })
        task.delay(1.6, function()
            if not burgerButton or not burgerButton.Parent or not burgerButton.Visible then return end
            islandGoNormal(false)
            islandLastInteract = os.clock()
            islandWatchdog()
        end)
    end

    burgerButton.MouseEnter:Connect(function()
        islandWake()
        TweenService:Create(burgerScale, TWEEN, { Scale = 1.08 }):Play()
        tween(burgerButton, { BackgroundColor3 = C.ElementHover })
    end)
    burgerButton.MouseLeave:Connect(function()
        TweenService:Create(burgerScale, TWEEN, { Scale = 1 }):Play()
        tween(burgerButton, { BackgroundColor3 = C.CardBg })
    end)

    burgerButton.MouseButton1Click:Connect(function() islandWake(); setMinimized(false) end)
    closeBtn.MouseButton1Click:Connect(function()
        if windowRef and windowRef.Destroy then windowRef:Destroy()
        else if screenGui then screenGui:Destroy() end end
    end)
    minimizeBtn.MouseButton1Click:Connect(function() setMinimized(true) end)
    local onDragStart, onDragEnd
    local dragConn = makeDraggable(container, noDrag,
        function() if onDragStart then onDragStart() end end,
        function() if onDragEnd then onDragEnd() end end)

    -- ── SIDEBAR ───────────────────────────────────────────────────────────
    local sidebar = make("Frame", { Size=UDim2.new(0,190,1,0), BackgroundTransparency=1, Parent=main })
    local brand = make("Frame", { Name="Brand", Position=UDim2.fromOffset(12,12), Size=UDim2.new(1,-24,0,64), BackgroundColor3=C.White, Parent=sidebar })
    corner(brand,10); stroke(brand,C.Border)
    -- Smooth light-blue to gray transition over the whole card, blue at the
    -- bottom. The blue is muted (Strength < 1 blends it back toward the gray)
    -- so it stays a subtle tint. The frame must be white because a UIGradient
    -- multiplies the object's own colour instead of replacing it; the actual
    -- colours live on the gradient, so it still follows theme changes.
    brand:SetAttribute("Theme_BackgroundColor3", nil)
    local brandGrad = make("UIGradient", { Rotation = 90, Parent = brand })
    brandGrad:SetAttribute("ThemeGradient_Top", "CardBg")
    brandGrad:SetAttribute("ThemeGradient_Bottom", "Accent")
    brandGrad:SetAttribute("ThemeGradient_Strength", 0.5)
    refreshVerticalFade(brandGrad)
    -- Blue-white shimmer: a soft whitish band sweeps across the card along the
    -- bottom-left to top-right diagonal, in phase with the window glow (same
    -- cycle, same offset). Sits at ZIndex 0 so the logo and text stay crisp.
    local brandShimmer = make("Frame", {
        Name = "Shimmer", Size = UDim2.fromScale(1, 1), ZIndex = 0,
        BackgroundColor3 = Color3.fromRGB(210, 225, 255), Parent = brand,
    })
    corner(brandShimmer, 10)
    brandShimmerGradient = make("UIGradient", {
        Rotation = 45,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, C.Accent),
            ColorSequenceKeypoint.new(0.42, C.Accent),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(0.58, C.Accent),
            ColorSequenceKeypoint.new(1.00, C.Accent),
        }),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0.00, 1.0),
            NumberSequenceKeypoint.new(0.38, 1.0),
            NumberSequenceKeypoint.new(0.50, 0.55),
            NumberSequenceKeypoint.new(0.62, 1.0),
            NumberSequenceKeypoint.new(1.00, 1.0),
        }),
        Parent = brandShimmer,
    })
    brandShimmerGradient:SetAttribute("ThemeGradient_Edge", "Accent")
    -- The logo holder clips, and the image inside is scaled up by `logoZoom`.
    -- This exists because the default logo asset has a lot of transparent
    -- padding — with ScaleType.Fit the visible mark would only fill ~35% of
    -- the box. Custom logos are usually tightly cropped, so they get no zoom
    -- unless the caller opts in via `LogoZoom`.
    local logoHolder = make("Frame", { Position=UDim2.fromOffset(9,9), Size=UDim2.fromOffset(46,46), BackgroundTransparency=1, ClipsDescendants=true, Parent=brand })
    local brandLogo = make("ImageLabel",{Name="Logo",Image=logoAsset,BackgroundTransparency=1,AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromScale(logoZoom,logoZoom),ScaleType=Enum.ScaleType.Fit,Parent=logoHolder})
    make("TextLabel",{Text=opts.Name or "Sovereigns",Font=Enum.Font.GothamBold,TextSize=13,TextColor3=C.White,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,BackgroundTransparency=1,Position=UDim2.fromOffset(64,16),Size=UDim2.new(1,-72,0,17),Parent=brand})
    make("TextLabel",{Text=opts.BrandSubtitle or ("Sovereigns v"..Library.Version),Font=Enum.Font.GothamMedium,TextSize=9,TextColor3=C.TextDim,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,BackgroundTransparency=1,Position=UDim2.fromOffset(64,35),Size=UDim2.new(1,-72,0,13),Parent=brand})

    -- Player mini-card (fills the sidebar and gives identity at a glance).
    -- Light "glass" treatment: a translucent background plus a soft diagonal
    -- sheen and a glowing accent border, instead of a flat opaque card.
    local lp = Players.LocalPlayer
    local pcard = make("Frame",{Name="PlayerCard",Position=UDim2.fromOffset(12,88),Size=UDim2.new(1,-24,0,52),BackgroundColor3=C.CardBg,BackgroundTransparency=0.12,Parent=sidebar})
    corner(pcard,10)
    local pcardGlow = stroke(pcard,C.Accent); pcardGlow.Transparency=0.72; pcardGlow.Thickness=1
    local pcardSheen = make("Frame",{Size=UDim2.fromScale(1,1),BackgroundColor3=Color3.fromRGB(255,255,255),ZIndex=0,Parent=pcard}); corner(pcardSheen,10)
    make("UIGradient",{Rotation=115,Color=ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(0.45, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255,255,255)),
    }),Transparency=NumberSequence.new({
        NumberSequenceKeypoint.new(0.00, 0.90),
        NumberSequenceKeypoint.new(0.45, 0.97),
        NumberSequenceKeypoint.new(1.00, 1.00),
    }),Parent=pcardSheen})
    local avH = make("Frame",{Position=UDim2.fromOffset(8,8),Size=UDim2.fromOffset(36,36),BackgroundColor3=C.Element,Parent=pcard}); corner(avH,8)
    local avImg = make("ImageLabel",{Image="rbxthumb://type=AvatarHeadShot&id="..lp.UserId.."&w=150&h=150",BackgroundTransparency=1,Size=UDim2.fromScale(1,1),ScaleType=Enum.ScaleType.Crop,Parent=avH}); corner(avImg,8)
    local avRing = stroke(avH,C.Accent); avRing.Transparency=0.4
    make("TextLabel",{Text=lp.DisplayName,Font=Enum.Font.GothamBold,TextSize=12,TextColor3=C.White,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,BackgroundTransparency=1,Position=UDim2.fromOffset(52,10),Size=UDim2.new(1,-60,0,15),Parent=pcard})
    make("TextLabel",{Text="@"..lp.Name,Font=Enum.Font.Gotham,TextSize=10,TextColor3=C.TextDim,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,BackgroundTransparency=1,Position=UDim2.fromOffset(52,28),Size=UDim2.new(1,-60,0,13),Parent=pcard})

    -- Faint centered logo watermark fills the otherwise empty sidebar space
    local watermarkHolder = make("Frame",{Name="Watermark",BackgroundTransparency=1,ClipsDescendants=true,AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,0.5,24),Size=UDim2.fromOffset(156,156),ZIndex=0,Parent=sidebar})

    -- ── Travelling outline around the logo silhouette ─────────────────────
    -- UIStroke cannot trace an image's alpha (ApplyStrokeMode only covers text
    -- or the rectangular border), so the outline is the union of copies of the
    -- logo pushed outward in a ring. They sit inside a CanvasGroup, which
    -- flattens the overlaps into one solid silhouette — stacking them directly
    -- would compound their alpha into a muddy halo. An opaque
    -- background-coloured copy on top then cuts the interior away, leaving only
    -- the rim, and a travelling gradient band runs light along it in phase with
    -- the window outline.
    local logoGlowOn = opts.LogoGlow ~= false
    local outlineGroup
    if logoGlowOn then
        -- The CanvasGroup is what keeps this from looking like a halo, so if the
        -- class is unavailable the effect is dropped rather than degraded.
        local built, group = pcall(function()
            return make("CanvasGroup", {
                Name = "OutlineGroup", BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1), ZIndex = 1, Parent = watermarkHolder,
            })
        end)
        if built and group then outlineGroup = group else logoGlowOn = false end
    end

    if logoGlowOn then
        local RING_STEPS = 16     -- at a 2.5px push this keeps the rim gap-free
        local RING_PUSH  = 2.5    -- outline thickness in pixels
        for i = 1, RING_STEPS do
            local ang = (i - 1) / RING_STEPS * math.pi * 2
            make("ImageLabel", {
                Name = "RingStep" .. i, Image = logoAsset,
                BackgroundTransparency = 1, ImageTransparency = 0,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, math.cos(ang) * RING_PUSH, 0.5, math.sin(ang) * RING_PUSH),
                Size = UDim2.fromScale(logoZoom, logoZoom),
                ScaleType = Enum.ScaleType.Fit, Parent = outlineGroup,
            })
        end
        -- Colour and fade both come from the gradient, so the rim is accent at
        -- rest and whitens at the crest of the band.
        logoGlowGradient = make("UIGradient", {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0.00, C.Accent),
                ColorSequenceKeypoint.new(0.42, C.Accent),
                ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(0.58, C.Accent),
                ColorSequenceKeypoint.new(1.00, C.Accent),
            }),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0.00, 0.88),
                NumberSequenceKeypoint.new(0.40, 0.88),
                NumberSequenceKeypoint.new(0.50, 0.10),
                NumberSequenceKeypoint.new(0.60, 0.88),
                NumberSequenceKeypoint.new(1.00, 0.88),
            }),
            Parent = outlineGroup,
        })
        logoGlowGradient:SetAttribute("ThemeGradient_Edge", "Accent")

        -- Sits outside the CanvasGroup so the travelling gradient cannot tint it
        -- and make the logo interior show up against the background.
        local watermarkMask = make("ImageLabel", {
            Name = "WatermarkMask", Image = logoAsset, BackgroundTransparency = 1,
            ImageColor3 = C.WindowBg, ImageTransparency = 0,
            AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(logoZoom, logoZoom),
            ScaleType = Enum.ScaleType.Fit, ZIndex = 2, Parent = watermarkHolder,
        })
        watermarkMask:SetAttribute("Theme_ImageColor3", "WindowBg")
    end

    local watermark = make("ImageLabel",{Name="WatermarkImage",Image=logoAsset,BackgroundTransparency=1,ImageTransparency=0.9,AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromScale(logoZoom,logoZoom),ScaleType=Enum.ScaleType.Fit,ZIndex=3,Parent=watermarkHolder})

    local statusDot = make("Frame",{AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,16,1,-19),Size=UDim2.fromOffset(6,6),BackgroundColor3=NOTIFICATION_STYLES.success.Color,Parent=sidebar})
    circle(statusDot)
    make("TextLabel",{Text=opts.StatusText or "Sovereigns is ready",Font=Enum.Font.GothamMedium,TextSize=10,TextColor3=C.TextDim,TextXAlignment=Enum.TextXAlignment.Left,BackgroundTransparency=1,Position=UDim2.new(0,28,1,-27),Size=UDim2.new(1,-40,0,16),Parent=sidebar})
    local divLine=make("Frame",{Position=UDim2.fromOffset(190,0),Size=UDim2.new(0,1,1,0),BackgroundColor3=C.Accent,Parent=main})
    make("UIGradient",{Rotation=90,Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.5,0.5),NumberSequenceKeypoint.new(1,1)}),Parent=divLine})
    local content = make("Frame",{Position=UDim2.fromOffset(191,0),Size=UDim2.new(1,-191,1,0),BackgroundTransparency=1,Parent=main})

    -- ── DRAG FADE: smoothly hide inner content while dragging the window ──
    -- The window frame (background + border + traveling glow) stays visible;
    -- everything inside (sidebar, divider, content, corner controls) fades out.
    local DRAG_FADE_TWEEN = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local fadeRoots = { controls, sidebar, divLine, content }
    local fadeOrig  = {}        -- [inst] = { [prop] = originalValue }
    local innerHidden = false
    local FADE_PROPS = {
        { prop = "BackgroundTransparency",     test = function(d) return d:IsA("GuiObject") end },
        { prop = "TextTransparency",           test = function(d) return d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") end },
        { prop = "ImageTransparency",          test = function(d) return d:IsA("ImageLabel") or d:IsA("ImageButton") end },
        { prop = "ScrollBarImageTransparency", test = function(d) return d:IsA("ScrollingFrame") end },
        { prop = "Transparency",               test = function(d) return d:IsA("UIStroke") end },
    }
    local function eachFadeInst(fn)
        for _, root in ipairs(fadeRoots) do
            if root and root.Parent then
                fn(root)
                for _, d in ipairs(root:GetDescendants()) do fn(d) end
            end
        end
    end
    local function setInnerHidden(hide)
        if hide == innerHidden then return end
        innerHidden = hide
        eachFadeInst(function(d)
            for _, entry in ipairs(FADE_PROPS) do
                if entry.test(d) then
                    local prop = entry.prop
                    if hide then
                        local cur = d[prop]
                        if cur < 1 then
                            fadeOrig[d] = fadeOrig[d] or {}
                            if fadeOrig[d][prop] == nil then fadeOrig[d][prop] = cur end
                            TweenService:Create(d, DRAG_FADE_TWEEN, { [prop] = 1 }):Play()
                        end
                    else
                        local o = fadeOrig[d]
                        if o and o[prop] ~= nil then
                            TweenService:Create(d, DRAG_FADE_TWEEN, { [prop] = o[prop] }):Play()
                        end
                    end
                end
            end
        end)
    end
    onDragStart = function() setInnerHidden(true) end
    onDragEnd   = function() setInnerHidden(false) end

    -- ── NOTIFICATIONS ─────────────────────────────────────────────────────
    local notificationHolder = make("Frame",{
        Name="Notifications",AnchorPoint=Vector2.new(1,1),
        Position=UDim2.new(1,-16,1,-16),Size=UDim2.new(0,320,1,-32),
        BackgroundTransparency=1,ZIndex=200,Parent=screenGui,
    })
    make("UIListLayout",{FillDirection=Enum.FillDirection.Vertical,HorizontalAlignment=Enum.HorizontalAlignment.Right,VerticalAlignment=Enum.VerticalAlignment.Bottom,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,8),Parent=notificationHolder})

    -- ── PROFILE + PERFORMANCE ─────────────────────────────────────────────
    local localPlayer      = Players.LocalPlayer
    local profileKey       = typeof(opts.ProfileKey)=="EnumItem" and opts.ProfileKey or Enum.KeyCode.K
    local toggleKey        = (opts.ToggleKey==false) and nil or (typeof(opts.ToggleKey)=="EnumItem" and opts.ToggleKey or Enum.KeyCode.RightShift)
    local profileWidth     = math.max(280, tonumber(opts.ProfileWidth) or 312)
    local bottomMargin     = math.max(10,  tonumber(opts.ProfileBottomMargin) or 18)
    local profileOpenPos   = UDim2.new(1,-18,1,-bottomMargin)
    local profileClosedPos = UDim2.new(1,profileWidth+28,1,-bottomMargin)
    local profileOpen      = false

    -- Music player (built below) — forward declared so the header toggle
    -- button and setProfileVisible can reference them.
    local toggleMusic            -- assigned when the music panel is built
    local closeMusic             -- assigned when the music panel is built
    local musicConns    = {}     -- connections appended to windowRef._connections

    local profilePanel = make("CanvasGroup",{Name="UserProfile",AnchorPoint=Vector2.new(1,1),Position=profileClosedPos,Size=UDim2.fromOffset(profileWidth,382),BackgroundColor3=C.CardBg,GroupTransparency=1,ClipsDescendants=true,ZIndex=150,Parent=screenGui})
    corner(profilePanel,14)
    local profileHeader=make("Frame",{Position=UDim2.fromOffset(0,0),Size=UDim2.new(1,0,0,65),BackgroundTransparency=1,ZIndex=151,Parent=profilePanel})
    make("TextLabel",{Text=opts.ProfileTitle or "PLAYER PROFILE",Font=Enum.Font.GothamBold,TextSize=13,TextColor3=C.White,TextXAlignment=Enum.TextXAlignment.Left,BackgroundTransparency=1,Position=UDim2.fromOffset(18,13),Size=UDim2.new(1,-36,0,18),ZIndex=152,Parent=profileHeader})
    make("TextLabel",{Text="Live session overview",Font=Enum.Font.Gotham,TextSize=10,TextColor3=C.TextDim,TextXAlignment=Enum.TextXAlignment.Left,BackgroundTransparency=1,Position=UDim2.fromOffset(18,34),Size=UDim2.new(1,-36,0,15),ZIndex=152,Parent=profileHeader})
    make("Frame",{Position=UDim2.new(0,18,1,-1),Size=UDim2.new(1,-36,0,1),BackgroundColor3=C.Border,ZIndex=151,Parent=profileHeader})
    -- Music player toggle (sits to the right of the PLAYER PROFILE title)
    local musicToggleBtn=make("TextButton",{Name="MusicToggle",Text="",AutoButtonColor=false,AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-16,0,14),Size=UDim2.fromOffset(34,34),BackgroundColor3=C.Element,ZIndex=153,Parent=profileHeader})
    corner(musicToggleBtn,9);stroke(musicToggleBtn,C.Border)
    local musicToggleIcon=make("ImageLabel",{Image=ICONS.music,BackgroundTransparency=1,AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(16,16),ImageColor3=C.TextGray,ZIndex=154,Parent=musicToggleBtn})
    musicToggleBtn.MouseButton1Click:Connect(function() if toggleMusic then toggleMusic() end end)
    local identityCard=make("Frame",{Position=UDim2.fromOffset(16,82),Size=UDim2.new(1,-32,0,116),BackgroundColor3=C.Element,ZIndex=151,Parent=profilePanel})
    corner(identityCard,11);stroke(identityCard,C.Border)
    local avatarHolder=make("Frame",{AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,14,0.5,0),Size=UDim2.fromOffset(76,76),BackgroundColor3=C.Badge,ZIndex=152,Parent=identityCard})
    circle(avatarHolder);stroke(avatarHolder,C.Border)
    local avatar=make("ImageLabel",{Name="Avatar",Image="",BackgroundTransparency=1,Position=UDim2.fromOffset(4,4),Size=UDim2.new(1,-8,1,-8),ScaleType=Enum.ScaleType.Crop,ZIndex=153,Parent=avatarHolder})
    circle(avatar)
    local onlineRing=make("Frame",{AnchorPoint=Vector2.new(1,1),Position=UDim2.new(1,0,1,0),Size=UDim2.fromOffset(18,18),BackgroundColor3=C.Element,ZIndex=154,Parent=avatarHolder})
    circle(onlineRing)
    local onlineDot=make("Frame",{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(10,10),BackgroundColor3=NOTIFICATION_STYLES.success.Color,ZIndex=155,Parent=onlineRing})
    circle(onlineDot)
    make("TextLabel",{Text=localPlayer and localPlayer.DisplayName or "Player",Font=Enum.Font.GothamBold,TextSize=17,TextColor3=C.White,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,BackgroundTransparency=1,Position=UDim2.fromOffset(105,22),Size=UDim2.new(1,-119,0,23),ZIndex=152,Parent=identityCard})
    make("TextLabel",{Text=localPlayer and ("@"..localPlayer.Name) or "@unknown",Font=Enum.Font.GothamMedium,TextSize=11,TextColor3=C.TextDim,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,BackgroundTransparency=1,Position=UDim2.fromOffset(105,47),Size=UDim2.new(1,-119,0,16),ZIndex=152,Parent=identityCard})
    local connectedBadge=make("Frame",{Position=UDim2.fromOffset(105,74),Size=UDim2.fromOffset(92,24),BackgroundColor3=C.BadgeIdle,ZIndex=152,Parent=identityCard})
    corner(connectedBadge,7)
    local connectedDot=make("Frame",{AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,9,0.5,0),Size=UDim2.fromOffset(6,6),BackgroundColor3=NOTIFICATION_STYLES.success.Color,ZIndex=153,Parent=connectedBadge})
    circle(connectedDot)
    make("TextLabel",{Text="CONNECTED",Font=Enum.Font.GothamBold,TextSize=8,TextColor3=C.TextGray,TextXAlignment=Enum.TextXAlignment.Left,BackgroundTransparency=1,Position=UDim2.fromOffset(22,0),Size=UDim2.new(1,-27,1,0),ZIndex=153,Parent=connectedBadge})
    make("TextLabel",{Text="ACCOUNT DETAILS",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.TextDim,TextXAlignment=Enum.TextXAlignment.Left,BackgroundTransparency=1,Position=UDim2.fromOffset(18,216),Size=UDim2.new(1,-36,0,16),ZIndex=152,Parent=profilePanel})
    local details=make("Frame",{Position=UDim2.fromOffset(16,240),Size=UDim2.new(1,-32,0,126),BackgroundColor3=C.Element,ZIndex=151,Parent=profilePanel})
    corner(details,11);stroke(details,C.Border)
    local function addProfileDetail(index,labelText,valueText)
        local y=(index-1)*42
        local row=make("Frame",{Position=UDim2.fromOffset(0,y),Size=UDim2.new(1,0,0,42),BackgroundTransparency=1,ZIndex=152,Parent=details})
        make("TextLabel",{Text=labelText,Font=Enum.Font.GothamMedium,TextSize=10,TextColor3=C.TextDim,TextXAlignment=Enum.TextXAlignment.Left,BackgroundTransparency=1,Position=UDim2.fromOffset(16,0),Size=UDim2.new(0.46,-16,1,0),ZIndex=153,Parent=row})
        local vl=make("TextLabel",{Text=valueText,Font=Enum.Font.GothamMedium,TextSize=11,TextColor3=C.White,TextXAlignment=Enum.TextXAlignment.Right,TextTruncate=Enum.TextTruncate.AtEnd,BackgroundTransparency=1,Position=UDim2.new(0.46,0,0,0),Size=UDim2.new(0.54,-16,1,0),ZIndex=153,Parent=row})
        if index<3 then make("Frame",{Position=UDim2.new(0,16,1,-1),Size=UDim2.new(1,-32,0,1),BackgroundColor3=C.Border,ZIndex=153,Parent=row}) end
        return vl
    end
    addProfileDetail(1,"USER ID",   localPlayer and tostring(localPlayer.UserId) or "N/A")
    addProfileDetail(2,"ACCOUNT AGE",localPlayer and (tostring(localPlayer.AccountAge).." days") or "N/A")
    local pingLabel=addProfileDetail(3,"PING","-- ms")

    local performanceWidth     = math.max(236,tonumber(opts.PerformanceWidth) or 266)
    local performanceHeight    = math.max(260,tonumber(opts.PerformanceHeight) or 294)
    local panelGap             = math.max(8,  tonumber(opts.ProfilePanelGap) or 12)
    local performanceOpenPos   = UDim2.new(1,-(18+profileWidth+panelGap),1,-bottomMargin)
    local performanceClosedPos = UDim2.new(1,performanceWidth+36,1,-bottomMargin)

    local performancePanel=make("CanvasGroup",{Name="LivePerformance",AnchorPoint=Vector2.new(1,1),Position=performanceClosedPos,Size=UDim2.fromOffset(performanceWidth,performanceHeight),BackgroundColor3=C.CardBg,GroupTransparency=1,ClipsDescendants=true,ZIndex=149,Parent=screenGui})
    corner(performancePanel,14)
    local performanceHeader=make("Frame",{Size=UDim2.new(1,0,0,56),BackgroundTransparency=1,ZIndex=150,Parent=performancePanel})
    make("TextLabel",{Text=opts.PerformanceTitle or "LIVE PERFORMANCE",Font=Enum.Font.GothamBold,TextSize=12,TextColor3=C.White,TextXAlignment=Enum.TextXAlignment.Left,BackgroundTransparency=1,Position=UDim2.fromOffset(16,11),Size=UDim2.new(1,-94,0,17),ZIndex=151,Parent=performanceHeader})
    make("TextLabel",{Text="Real-time frame tracker",Font=Enum.Font.Gotham,TextSize=9,TextColor3=C.TextDim,TextXAlignment=Enum.TextXAlignment.Left,BackgroundTransparency=1,Position=UDim2.fromOffset(16,31),Size=UDim2.new(1,-94,0,13),ZIndex=151,Parent=performanceHeader})
    local liveBadge=make("Frame",{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-14,0,14),Size=UDim2.fromOffset(58,20),BackgroundColor3=C.BadgeIdle,ZIndex=151,Parent=performanceHeader})
    corner(liveBadge,6)
    local liveDot=make("Frame",{AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,8,0.5,0),Size=UDim2.fromOffset(5,5),BackgroundColor3=NOTIFICATION_STYLES.success.Color,ZIndex=152,Parent=liveBadge})
    circle(liveDot)
    make("TextLabel",{Text="LIVE",Font=Enum.Font.GothamBold,TextSize=8,TextColor3=C.TextGray,TextXAlignment=Enum.TextXAlignment.Left,BackgroundTransparency=1,Position=UDim2.fromOffset(19,0),Size=UDim2.new(1,-23,1,0),ZIndex=152,Parent=liveBadge})
    local fpsSummary=make("Frame",{Position=UDim2.fromOffset(14,58),Size=UDim2.new(1,-28,0,56),BackgroundColor3=C.Element,ZIndex=150,Parent=performancePanel})
    corner(fpsSummary,10);stroke(fpsSummary,C.Border)
    make("TextLabel",{Text="FPS",Font=Enum.Font.GothamBold,TextSize=8,TextColor3=C.TextDim,TextXAlignment=Enum.TextXAlignment.Left,BackgroundTransparency=1,Position=UDim2.fromOffset(12,8),Size=UDim2.new(0.5,-12,0,11),ZIndex=151,Parent=fpsSummary})
    local currentFpsLabel=make("TextLabel",{Text="--",Font=Enum.Font.GothamBold,TextSize=23,TextColor3=C.White,TextXAlignment=Enum.TextXAlignment.Left,BackgroundTransparency=1,Position=UDim2.fromOffset(12,21),Size=UDim2.new(0.5,-12,0,28),ZIndex=151,Parent=fpsSummary})
    make("TextLabel",{Text="FRAME TIME",Font=Enum.Font.GothamBold,TextSize=8,TextColor3=C.TextDim,TextXAlignment=Enum.TextXAlignment.Right,BackgroundTransparency=1,Position=UDim2.new(0.5,0,0,8),Size=UDim2.new(0.5,-12,0,11),ZIndex=151,Parent=fpsSummary})
    local frameTimeLabel=make("TextLabel",{Text="-- ms",Font=Enum.Font.GothamMedium,TextSize=12,TextColor3=C.White,TextXAlignment=Enum.TextXAlignment.Right,BackgroundTransparency=1,Position=UDim2.new(0.5,0,0,26),Size=UDim2.new(0.5,-12,0,18),ZIndex=151,Parent=fpsSummary})
    make("TextLabel",{Text="FRAME HISTORY",Font=Enum.Font.GothamBold,TextSize=9,TextColor3=C.TextDim,TextXAlignment=Enum.TextXAlignment.Left,BackgroundTransparency=1,Position=UDim2.fromOffset(16,126),Size=UDim2.new(1,-32,0,13),ZIndex=150,Parent=performancePanel})
    local graphCard=make("Frame",{Position=UDim2.fromOffset(14,145),Size=UDim2.new(1,-28,0,82),BackgroundColor3=C.Element,ClipsDescendants=true,ZIndex=150,Parent=performancePanel})
    corner(graphCard,10);stroke(graphCard,C.Border)
    local graphPlot=make("Frame",{Position=UDim2.fromOffset(10,9),Size=UDim2.new(1,-20,1,-18),BackgroundTransparency=1,ClipsDescendants=true,ZIndex=151,Parent=graphCard})
    for i=1,2 do make("Frame",{Position=UDim2.new(0,0,i/3,0),Size=UDim2.new(1,0,0,1),BackgroundColor3=C.Border,BackgroundTransparency=0.35,ZIndex=151,Parent=graphPlot}) end
    local maxFpsSamples=48; local fpsSamples={}
    local graphPixelSize=Vector2.new(math.max(2,math.floor(performanceWidth-48)),64)
    local graphImage=make("ImageLabel",{Name="ContinuousFpsLine",BackgroundTransparency=1,Position=UDim2.fromOffset(0,0),Size=UDim2.fromScale(1,1),ScaleType=Enum.ScaleType.Stretch,ResampleMode=Enum.ResamplerMode.Default,ZIndex=153,Parent=graphPlot})
    local fpsEditableImage=nil; local graphSegments={}; local editableImageReady=false; local supportsAA=true
    local function ensureFallback()
        if #graphSegments>0 then return end; graphImage.Visible=false
        for i=1,maxFpsSamples-1 do
            local seg=make("Frame",{Name="FL"..i,AnchorPoint=Vector2.new(0,0.5),Position=UDim2.fromOffset(0,0),Size=UDim2.fromOffset(0,1),BackgroundColor3=C.White,BorderSizePixel=0,Visible=false,ZIndex=153,Parent=graphPlot})
            graphSegments[i]=seg
        end
    end
    do
        local ok,ed=pcall(function()
            local img=AssetService:CreateEditableImage({Size=graphPixelSize})
            graphImage.ImageContent=Content.fromObject(img); return img
        end)
        if ok and ed then fpsEditableImage=ed; editableImageReady=true else ensureFallback() end
    end
    local function clearEG()
        if not editableImageReady or not fpsEditableImage then return false end
        local ok=pcall(function() fpsEditableImage:DrawRectangle(Vector2.zero,graphPixelSize,Color3.new(0,0,0),1,Enum.ImageCombineType.Overwrite) end)
        if not ok then editableImageReady=false; ensureFallback() end; return ok
    end
    local function drawEGL(a,b)
        if not editableImageReady or not fpsEditableImage then return false end
        if supportsAA then
            local ok=pcall(function() fpsEditableImage:DrawLine(a,b,C.White,0,Enum.ImageCombineType.Overwrite,Enum.AntiAliasing.Enabled) end)
            if ok then return true end; supportsAA=false
        end
        local ok=pcall(function() fpsEditableImage:DrawLine(a,b,C.White,0,Enum.ImageCombineType.Overwrite) end)
        if not ok then editableImageReady=false; ensureFallback() end; return ok
    end
    local statsStrip=make("Frame",{Position=UDim2.fromOffset(14,237),Size=UDim2.new(1,-28,0,43),BackgroundColor3=C.Element,ZIndex=150,Parent=performancePanel})
    corner(statsStrip,10);stroke(statsStrip,C.Border)
    local statValueLabels={}
    for i,sn in ipairs({"AVG","LOW","HIGH"}) do
        local sc=make("Frame",{Position=UDim2.new((i-1)/3,0,0,0),Size=UDim2.new(1/3,0,1,0),BackgroundTransparency=1,ZIndex=151,Parent=statsStrip})
        make("TextLabel",{Text=sn,Font=Enum.Font.GothamBold,TextSize=8,TextColor3=C.TextDim,TextXAlignment=Enum.TextXAlignment.Center,BackgroundTransparency=1,Position=UDim2.fromOffset(0,5),Size=UDim2.new(1,0,0,10),ZIndex=152,Parent=sc})
        statValueLabels[i]=make("TextLabel",{Text="--",Font=Enum.Font.GothamMedium,TextSize=10,TextColor3=C.White,TextXAlignment=Enum.TextXAlignment.Center,BackgroundTransparency=1,Position=UDim2.fromOffset(0,19),Size=UDim2.new(1,0,0,15),ZIndex=152,Parent=sc})
    end
    local function redrawFpsGraph()
        local sc=#fpsSamples; local ps=graphPlot.AbsoluteSize
        if sc<2 or ps.X<=1 or ps.Y<=1 then
            if editableImageReady then clearEG() end
            for _,s in ipairs(graphSegments) do s.Visible=false end; return
        end
        local gm=60; for _,v in ipairs(fpsSamples) do gm=math.max(gm,v) end
        gm=math.max(30,math.ceil(gm/30)*30); local den=math.max(sc-1,1)
        if editableImageReady and clearEG() then
            local W=graphPixelSize.X; local H=graphPixelSize.Y
            local uW=math.max(1,W-2); local uH=math.max(1,H-6)
            for i=1,sc-1 do
                local pA=Vector2.new(1+((i-1)/den)*uW, 3+(1-math.clamp(fpsSamples[i]/gm,0,1))*uH)
                local pB=Vector2.new(1+(i/den)*uW,     3+(1-math.clamp(fpsSamples[i+1]/gm,0,1))*uH)
                if not drawEGL(pA,pB) then break end
            end
            if editableImageReady then return end
        end
        local uH=math.max(1,ps.Y-8)
        for i,seg in ipairs(graphSegments) do
            if i<sc then
                local x1=((i-1)/den)*ps.X; local x2=(i/den)*ps.X
                local y1=4+(1-math.clamp(fpsSamples[i]/gm,0,1))*uH
                local y2=4+(1-math.clamp(fpsSamples[i+1]/gm,0,1))*uH
                local dx=x2-x1; local dy=y2-y1; local len=math.sqrt(dx*dx+dy*dy)
                seg.Position=UDim2.fromOffset(x1,y1); seg.Size=UDim2.fromOffset(len+2,1)
                seg.Rotation=math.deg(math.atan2(dy,dx)); seg.Visible=true
            else seg.Visible=false end
        end
    end
    local function pushFpsSample(fps)
        fps=math.max(0,fps); table.insert(fpsSamples,fps)
        if #fpsSamples>maxFpsSamples then table.remove(fpsSamples,1) end
        local tot=0; local lo=math.huge; local hi=0
        for _,v in ipairs(fpsSamples) do tot=tot+v; lo=math.min(lo,v); hi=math.max(hi,v) end
        local avg=#fpsSamples>0 and tot/#fpsSamples or 0
        local ft=fps>0 and (1000/fps) or 0
        currentFpsLabel.Text=tostring(math.floor(fps+0.5))
        frameTimeLabel.Text=string.format("%.1f ms",ft)
        statValueLabels[1].Text=tostring(math.floor(avg+0.5))
        statValueLabels[2].Text=tostring(math.floor(lo+0.5))
        statValueLabels[3].Text=tostring(math.floor(hi+0.5))
        redrawFpsGraph()
    end
    toggleMusic, closeMusic = buildMusicPlayer({
        screenGui = screenGui, profileWidth = profileWidth, bottomMargin = bottomMargin,
        panelGap = panelGap, toggleBtn = musicToggleBtn, toggleIcon = musicToggleIcon,
        conns = musicConns, opts = opts,
    })

    -- ── ADMIN PANEL (only built for users in ADMIN_USER_IDS) ──────────────
    -- Slides in from the bottom-left whenever the profile panel opens.
    -- Lists every active client reported by the presence server, with a
    -- Disconnect button that queues that user for a server-side kick.
    local adminPanel             -- nil for non-admin users
    local adminListener          -- TagSystem listener, cleaned up on destroy
    local setAdminVisible        -- forward declare; called by setProfileVisible
    local adminEnabled = isAdminUser(localPlayer)

    if adminEnabled then
        local adminWidth        = math.max(280, tonumber(opts.AdminPanelWidth) or 332)
        local adminHeight       = math.max(280, tonumber(opts.AdminPanelHeight) or 416)
        local adminOpenPos      = UDim2.new(0, 18, 1, -bottomMargin)
        local adminClosedPos    = UDim2.new(0, -(adminWidth + 28), 1, -bottomMargin)

        adminPanel = make("CanvasGroup", {
            Name = "AdminPanel", AnchorPoint = Vector2.new(0, 1),
            Position = adminClosedPos, Size = UDim2.fromOffset(adminWidth, adminHeight),
            BackgroundColor3 = C.CardBg, GroupTransparency = 1,
            ClipsDescendants = true, ZIndex = 150, Parent = screenGui,
        })
        corner(adminPanel, 14)

        -- Header
        local adminHeader = make("Frame", { Size = UDim2.new(1, 0, 0, 65), BackgroundTransparency = 1, ZIndex = 151, Parent = adminPanel })
        make("TextLabel", {
            Text = "ADMIN PANEL", Font = Enum.Font.GothamBold, TextSize = 13,
            TextColor3 = C.White, TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1, Position = UDim2.fromOffset(18, 13),
            Size = UDim2.new(1, -100, 0, 18), ZIndex = 152, Parent = adminHeader,
        })
        make("TextLabel", {
            Text = "Active client management", Font = Enum.Font.Gotham, TextSize = 10,
            TextColor3 = C.TextDim, TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1, Position = UDim2.fromOffset(18, 34),
            Size = UDim2.new(1, -100, 0, 15), ZIndex = 152, Parent = adminHeader,
        })
        make("Frame", {
            Position = UDim2.new(0, 18, 1, -1), Size = UDim2.new(1, -36, 0, 1),
            BackgroundColor3 = C.Border, ZIndex = 151, Parent = adminHeader,
        })

        -- LIVE badge (top-right, mirrors the performance panel style)
        local liveBadge = make("Frame", {
            AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -16, 0, 14),
            Size = UDim2.fromOffset(64, 20), BackgroundColor3 = C.BadgeIdle,
            ZIndex = 152, Parent = adminHeader,
        })
        corner(liveBadge, 6)
        local liveDot = make("Frame", {
            AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 9, 0.5, 0),
            Size = UDim2.fromOffset(5, 5), BackgroundColor3 = NOTIFICATION_STYLES.success.Color,
            ZIndex = 153, Parent = liveBadge,
        })
        circle(liveDot)
        make("TextLabel", {
            Text = "LIVE", Font = Enum.Font.GothamBold, TextSize = 8,
            TextColor3 = C.TextGray, TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1, Position = UDim2.fromOffset(20, 0),
            Size = UDim2.new(1, -24, 1, 0), ZIndex = 153, Parent = liveBadge,
        })

        -- Summary card: count on the left, admin UID on the right
        local summaryCard = make("Frame", {
            Position = UDim2.fromOffset(16, 75), Size = UDim2.new(1, -32, 0, 56),
            BackgroundColor3 = C.Element, ZIndex = 151, Parent = adminPanel,
        })
        corner(summaryCard, 11); stroke(summaryCard, C.Border)
        make("TextLabel", {
            Text = "ACTIVE CLIENTS", Font = Enum.Font.GothamBold, TextSize = 8,
            TextColor3 = C.TextDim, TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1, Position = UDim2.fromOffset(12, 8),
            Size = UDim2.new(0.5, -12, 0, 11), ZIndex = 152, Parent = summaryCard,
        })
        local activeCountLabel = make("TextLabel", {
            Text = "0", Font = Enum.Font.GothamBold, TextSize = 23,
            TextColor3 = C.White, TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1, Position = UDim2.fromOffset(12, 21),
            Size = UDim2.new(0.5, -12, 0, 28), ZIndex = 152, Parent = summaryCard,
        })
        make("TextLabel", {
            Text = "ADMIN UID", Font = Enum.Font.GothamBold, TextSize = 8,
            TextColor3 = C.TextDim, TextXAlignment = Enum.TextXAlignment.Right,
            BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0, 8),
            Size = UDim2.new(0.5, -12, 0, 11), ZIndex = 152, Parent = summaryCard,
        })
        make("TextLabel", {
            Text = localPlayer and tostring(localPlayer.UserId) or "N/A",
            Font = Enum.Font.GothamMedium, TextSize = 12, TextColor3 = C.White,
            TextXAlignment = Enum.TextXAlignment.Right, BackgroundTransparency = 1,
            Position = UDim2.new(0.5, 0, 0, 26),
            Size = UDim2.new(0.5, -12, 0, 18), ZIndex = 152, Parent = summaryCard,
        })

        -- List header + refresh button
        make("TextLabel", {
            Text = "CLIENT LIST", Font = Enum.Font.GothamBold, TextSize = 10,
            TextColor3 = C.TextDim, TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1, Position = UDim2.fromOffset(18, 142),
            Size = UDim2.fromOffset(140, 14), ZIndex = 151, Parent = adminPanel,
        })
        local refreshAdminBtn = make("TextButton", {
            Text = "", AutoButtonColor = false, AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -16, 0, 149), Size = UDim2.fromOffset(22, 22),
            BackgroundColor3 = C.Element, ZIndex = 151, Parent = adminPanel,
        })
        corner(refreshAdminBtn, 7); stroke(refreshAdminBtn, C.Border)
        local refreshAdminIcon = make("ImageLabel", {
            Image = ICONS.refresh, ImageColor3 = C.TextGray, BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(13, 13), ZIndex = 152, Parent = refreshAdminBtn,
        })
        refreshAdminBtn.MouseEnter:Connect(function()
            tween(refreshAdminBtn, { BackgroundColor3 = C.ElementHover })
            tween(refreshAdminIcon, { ImageColor3 = C.White })
        end)
        refreshAdminBtn.MouseLeave:Connect(function()
            tween(refreshAdminBtn, { BackgroundColor3 = C.Element })
            tween(refreshAdminIcon, { ImageColor3 = C.TextGray })
        end)
        table.insert(noDrag, refreshAdminBtn)

        -- Scrolling list container + empty-state label (sibling so the
        -- UIListLayout doesn't move it around when the list is empty).
        local listFrame = make("ScrollingFrame", {
            Position = UDim2.fromOffset(16, 168),
            Size = UDim2.new(1, -32, 1, -184),
            BackgroundColor3 = C.Element, BorderSizePixel = 0,
            ScrollBarThickness = 3, ScrollBarImageColor3 = C.Border,
            CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            ZIndex = 151, Parent = adminPanel,
        })
        corner(listFrame, 11); stroke(listFrame, C.Border); pad(listFrame, 6, 6, 6, 6)
        make("UIListLayout", { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, Parent = listFrame })
        table.insert(noDrag, listFrame)

        local emptyLabel = make("TextLabel", {
            Text = "No active clients", Font = Enum.Font.GothamMedium, TextSize = 11,
            TextColor3 = C.TextDim, TextXAlignment = Enum.TextXAlignment.Center,
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0, 168 + ((adminHeight - 184) / 2)),
            Size = UDim2.fromOffset(adminWidth - 64, 22),
            ZIndex = 152, Parent = adminPanel,
        })

        local adminRows = {}  -- userId -> row Frame

        local function buildRow(info, order)
            local userId = info.userId
            local isSelf = (localPlayer and userId == localPlayer.UserId) or false
            local displayName = (info.displayName ~= nil and info.displayName ~= "")
                and info.displayName or ("User " .. tostring(userId))
            local handle = (info.name ~= nil and info.name ~= "") and ("@" .. info.name) or "@unknown"

            local row = make("Frame", {
                Size = UDim2.new(1, 0, 0, 50), BackgroundColor3 = C.WindowBg,
                LayoutOrder = order, ZIndex = 152, Parent = listFrame,
            })
            corner(row, 9); stroke(row, C.Border)

            -- Avatar
            local avH = make("Frame", {
                Position = UDim2.fromOffset(7, 7), Size = UDim2.fromOffset(36, 36),
                BackgroundColor3 = C.Element, ZIndex = 153, Parent = row,
            })
            corner(avH, 8)
            local avImg = make("ImageLabel", {
                Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(userId) .. "&w=150&h=150",
                BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1),
                ScaleType = Enum.ScaleType.Crop, ZIndex = 154, Parent = avH,
            })
            corner(avImg, 8)
            if isSelf then
                local ring = stroke(avH, C.Accent); ring.Transparency = 0.3
            end

            -- Reserve space on the right for the action (84px button or 60px badge)
            local actionW = isSelf and 60 or 84
            local textRight = actionW + 18

            make("TextLabel", {
                Text = isSelf and (displayName .. "  (you)") or displayName,
                Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = C.White,
                TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
                BackgroundTransparency = 1, Position = UDim2.fromOffset(51, 6),
                Size = UDim2.new(1, -(51 + textRight), 0, 14),
                ZIndex = 153, Parent = row,
            })
            make("TextLabel", {
                Text = handle, Font = Enum.Font.Gotham, TextSize = 10,
                TextColor3 = C.TextDim, TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd, BackgroundTransparency = 1,
                Position = UDim2.fromOffset(51, 21),
                Size = UDim2.new(1, -(51 + textRight), 0, 12),
                ZIndex = 153, Parent = row,
            })
            make("TextLabel", {
                Text = "ID " .. tostring(userId),
                Font = Enum.Font.GothamMedium, TextSize = 9,
                TextColor3 = C.TextDim, TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1, Position = UDim2.fromOffset(51, 34),
                Size = UDim2.new(1, -(51 + textRight), 0, 11),
                ZIndex = 153, Parent = row,
            })

            if isSelf then
                local selfBadge = make("Frame", {
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -8, 0.5, 0),
                    Size = UDim2.fromOffset(54, 22),
                    BackgroundColor3 = C.Badge, ZIndex = 153, Parent = row,
                })
                corner(selfBadge, 6)
                make("TextLabel", {
                    Text = "YOU", Font = Enum.Font.GothamBold, TextSize = 9,
                    TextColor3 = C.Accent, TextXAlignment = Enum.TextXAlignment.Center,
                    BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1),
                    ZIndex = 154, Parent = selfBadge,
                })
            else
                local CLOSE_RED    = Color3.fromRGB(190, 60, 60)
                local CLOSE_RED_HI = Color3.fromRGB(212, 80, 80)
                local dcBtn = make("TextButton", {
                    Text = "DISCONNECT", Font = Enum.Font.GothamBold, TextSize = 10,
                    TextColor3 = Color3.fromRGB(255, 255, 255), AutoButtonColor = false,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -8, 0.5, 0),
                    Size = UDim2.fromOffset(78, 24),
                    BackgroundColor3 = CLOSE_RED, ZIndex = 153, Parent = row,
                })
                corner(dcBtn, 6)
                dcBtn.MouseEnter:Connect(function() tween(dcBtn, { BackgroundColor3 = CLOSE_RED_HI }) end)
                dcBtn.MouseLeave:Connect(function() tween(dcBtn, { BackgroundColor3 = CLOSE_RED }) end)
                dcBtn.MouseButton1Click:Connect(function()
                    if dcBtn:GetAttribute("Busy") then return end
                    dcBtn:SetAttribute("Busy", true)
                    dcBtn.Text = "..."
                    task.spawn(function()
                        local ok, err = Library:AdminDisconnect(userId)
                        if ok then
                            if windowRef and windowRef.Notify then
                                windowRef:Notify({
                                    Title = "Admin",
                                    Content = "Disconnect queued: " .. displayName,
                                    Type = "warning", Duration = 4,
                                })
                            end
                            -- Optimistically drop the row; the next poll
                            -- will reconcile anyway.
                            if row and row.Parent then row:Destroy() end
                            adminRows[userId] = nil
                        else
                            dcBtn.Text = "DISCONNECT"
                            dcBtn:SetAttribute("Busy", nil)
                            if windowRef and windowRef.Notify then
                                windowRef:Notify({
                                    Title = "Admin",
                                    Content = "Disconnect failed: " .. tostring(err),
                                    Type = "error", Duration = 5,
                                })
                            end
                        end
                    end)
                end)
                table.insert(noDrag, dcBtn)
            end
            return row
        end

        local function refreshAdminList(userInfos)
            -- Clear existing rows
            for uid, r in pairs(adminRows) do
                if r and r.Parent then r:Destroy() end
            end
            table.clear(adminRows)

            userInfos = userInfos or TagSystem._userInfo or {}
            -- Ensure the local admin always shows up, even if the latest
            -- /users response hasn't echoed back our own /register yet.
            local merged = {}
            for id, info in pairs(userInfos) do merged[id] = info end
            if localPlayer and not merged[localPlayer.UserId] then
                merged[localPlayer.UserId] = {
                    userId      = localPlayer.UserId,
                    displayName = localPlayer.DisplayName,
                    name        = localPlayer.Name,
                }
            end

            local sorted = {}
            for _, info in pairs(merged) do table.insert(sorted, info) end
            table.sort(sorted, function(a, b)
                -- Pin "you" to the top, then alphabetical by display name
                local aSelf = localPlayer and a.userId == localPlayer.UserId
                local bSelf = localPlayer and b.userId == localPlayer.UserId
                if aSelf ~= bSelf then return aSelf end
                local an = string.lower(tostring(a.displayName or ""))
                local bn = string.lower(tostring(b.displayName or ""))
                if an ~= bn then return an < bn end
                return a.userId < b.userId
            end)

            for i, info in ipairs(sorted) do
                local row = buildRow(info, i)
                adminRows[info.userId] = row
            end
            activeCountLabel.Text = tostring(#sorted)
            emptyLabel.Visible = (#sorted == 0)
        end

        refreshAdminBtn.MouseButton1Click:Connect(function()
            tween(refreshAdminIcon, { Rotation = refreshAdminIcon.Rotation + 360 })
            task.spawn(function()
                tagFetchAndUpdate()
                pcall(refreshAdminList, TagSystem._userInfo)
            end)
        end)

        -- Subscribe to live updates from the tag system poll loop.
        adminListener = TagSystem:OnUsersUpdated(function(userInfos)
            if not adminPanel or not adminPanel.Parent then return end
            task.spawn(function() pcall(refreshAdminList, userInfos) end)
        end)

        -- Initial render with whatever data we already have.
        refreshAdminList(TagSystem._userInfo)

        -- Trigger an immediate fetch in the background so the list populates
        -- without waiting for the next 5s poll tick.
        task.spawn(function() pcall(tagFetchAndUpdate) end)

        function setAdminVisible(open, instant)
            local pos = open and adminOpenPos or adminClosedPos
            local tr  = open and 0 or 1
            if instant then
                adminPanel.Position = pos
                adminPanel.GroupTransparency = tr
            else
                TweenService:Create(adminPanel, PROFILE_TWEEN, { Position = pos, GroupTransparency = tr }):Play()
            end
        end
    end

    local function setProfileVisible(visible,instant)
        profileOpen=visible==true
        if not profileOpen and closeMusic then closeMusic(instant) end
        local tp=profileOpen and profileOpenPos or profileClosedPos
        local ep=profileOpen and performanceOpenPos or performanceClosedPos
        local tr=profileOpen and 0 or 1
        if instant then
            profilePanel.Position=tp; profilePanel.GroupTransparency=tr
            performancePanel.Position=ep; performancePanel.GroupTransparency=tr
        else
            TweenService:Create(profilePanel,PROFILE_TWEEN,{Position=tp,GroupTransparency=tr}):Play()
            TweenService:Create(performancePanel,PROFILE_TWEEN,{Position=ep,GroupTransparency=tr}):Play()
        end
        if setAdminVisible then setAdminVisible(profileOpen, instant) end
        if windowRef then windowRef._profileOpen=profileOpen end; return profileOpen
    end
    if localPlayer then
        task.spawn(function()
            local ok,img=pcall(function() return Players:GetUserThumbnailAsync(localPlayer.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size420x420) end)
            if ok and avatar and avatar.Parent then avatar.Image=img end
        end)
    end
    task.spawn(function()
        while screenGui and screenGui.Parent do
            local txt="N/A"
            local ok,val=pcall(function() return Stats.Network.ServerStatsItem["Data Ping"]:GetValue() end)
            if ok and type(val)=="number" then txt=tostring(math.floor(val+0.5)).." ms" end
            if pingLabel and pingLabel.Parent then pingLabel.Text=txt end; task.wait(1)
        end
    end)

    windowRef = setmetatable({
        ScreenGui=screenGui, Main=main, Container=container, Logo=brandLogo, Watermark=watermark,
        _logoAsset=logoAsset, _hotbar=hotbar, _hotbarInner=hotbarInner, _content=content,
        _notificationHolder=notificationHolder, _notificationOrder=0,
        _profilePanel=profilePanel, _performancePanel=performancePanel,
        _fpsEditableImage=fpsEditableImage, _profileKey=profileKey,
        _profileOpen=profileOpen, _setProfileVisible=setProfileVisible,
        _connections={}, _noDrag=noDrag, _tabs={}, _activeTab=nil,
        _containerScale=containerScale, _uiVisible=true, _toggleKey=toggleKey,
        _loadingBlur=loadingBlur, _destroyed=false,
    }, Window)
    windowRef.Notify=function(s,m) return Window.Notify(windowRef,s==windowRef and m or s) end
    windowRef.Notification=windowRef.Notify
    if dragConn then table.insert(windowRef._connections, dragConn) end
    for _,c in ipairs(musicConns) do table.insert(windowRef._connections, c) end

    -- Clean up the admin panel's TagSystem listener on Window:Destroy()
    if adminListener then
        table.insert(windowRef._connections, {
            Disconnect = function() TagSystem:RemoveListener(adminListener) end,
        })
    end

    -- ── PERSISTENCE GUARD ─────────────────────────────────────────────────
    -- Some games / anti-cheats strip GUIs (from CoreGui or PlayerGui) when the
    -- character respawns, which made the whole window — and the minimized
    -- burger button in the top corner — vanish on death. Re-parent the window
    -- back to a safe host whenever it gets detached, so it never disappears.
    -- The burger button lives under screenGui too, so it returns with it.
    local function resolveHost()
        local host
        if typeof(opts.Parent) == "Instance" then
            host = opts.Parent
        else
            pcall(function() host = (gethui and gethui()) or game:GetService("CoreGui") end)
        end
        if not host then host = Players.LocalPlayer:WaitForChild("PlayerGui") end
        return host
    end
    local guardConn
    guardConn = screenGui.AncestryChanged:Connect(function(_, parent)
        -- parent == nil means it was detached from the DataModel (e.g. on death),
        -- not an intentional Destroy (which sets windowRef._destroyed).
        if parent ~= nil then return end
        if windowRef and windowRef._destroyed then return end
        task.defer(function()
            if windowRef and windowRef._destroyed then return end
            if screenGui.Parent ~= nil then return end
            pcall(function() screenGui.Parent = resolveHost() end)
        end)
    end)
    table.insert(windowRef._connections, guardConn)

    local ffc=0; local fe=0
    local fpsConn=RunService.RenderStepped:Connect(function(dt)
        if not screenGui or not screenGui.Parent then return end
        ffc=ffc+1; fe=fe+dt
        if fe>=0.25 then pushFpsSample(ffc/fe); ffc=0; fe=0 end
    end)
    table.insert(windowRef._connections,fpsConn)
    local pkConn=UserInputService.InputBegan:Connect(function(input,gp)
        if not loadingComplete or gp or UserInputService:GetFocusedTextBox() then return end
        if input.KeyCode==profileKey and Library._windowObjects[#Library._windowObjects]==windowRef then
            windowRef:ToggleProfile()
        end
    end)
    table.insert(windowRef._connections,pkConn)
    if toggleKey then
        local tkConn=UserInputService.InputBegan:Connect(function(input,gp)
            if not loadingComplete or gp or UserInputService:GetFocusedTextBox() then return end
            if input.KeyCode==toggleKey then windowRef:ToggleUI() end
        end)
        table.insert(windowRef._connections,tkConn)
    end

    -- ── MOBILE / RESPONSIVE SCALING ──────────────────────────────────────
    -- The side panels live directly under the ScreenGui (not the container),
    -- so each gets its own UIScale that we drive together with the container.
    local function ensureScale(inst)
        if not inst then return nil end
        local us = inst:FindFirstChildOfClass("UIScale")
        if not us then us = make("UIScale", { Scale = 1, Parent = inst }) end
        return us
    end
    local musicPanel = screenGui:FindFirstChild("MusicPlayer")
    local scaleList = {}
    for _, inst in ipairs({ profilePanel, performancePanel, musicPanel, burgerButton, adminPanel }) do
        local us = ensureScale(inst); if us then table.insert(scaleList, us) end
    end
    local userScale = tonumber(opts.Scale) or 1
    local function applyResponsiveScale()
        local cam = Workspace.CurrentCamera
        local vp = (cam and cam.ViewportSize) or Vector2.new(1280, 720)
        local s = 1
        if isMobile then
            local sx = (vp.X * 0.96) / math.max(1, containerW)
            local sy = (vp.Y * 0.90) / math.max(1, containerH)
            s = math.clamp(math.min(sx, sy, 1), 0.4, 1)
        end
        s = s * userScale
        containerScale.Scale = s
        for _, us in ipairs(scaleList) do us.Scale = s end
    end
    applyResponsiveScale()
    do
        local cam = Workspace.CurrentCamera
        if cam then
            table.insert(windowRef._connections, cam:GetPropertyChangedSignal("ViewportSize"):Connect(applyResponsiveScale))
        end
    end

    -- ── UI VISIBILITY TOGGLE (keyboard-free; drives the floating button) ──
    local uiHidden = false
    local function setUIVisible(v)
        v = (v ~= false)
        uiHidden = not v
        container.Visible = v
        hotbar.Visible = v and not minimized
        if burgerButton then burgerButton.Visible = v and minimized end
        windowRef._uiVisible = v
        return v
    end
    windowRef._setUIVisible = setUIVisible

    -- On mobile there is no toggle key, so add a draggable floating button.
    if isMobile then
        local fab = make("TextButton", {
            Name = "SovereignsMobileToggle", Text = "", AutoButtonColor = false,
            AnchorPoint = Vector2.new(0, 0), Position = UDim2.fromOffset(14, 14),
            Size = UDim2.fromOffset(46, 46), BackgroundColor3 = C.CardBg,
            ZIndex = 60, Parent = screenGui,
        })
        corner(fab, 12); stroke(fab, C.Border)
        make("ImageLabel", { Image = logoAsset, BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(26, 26), ScaleType = Enum.ScaleType.Fit, ZIndex = 61, Parent = fab })
        local fabDrag = makeDraggable(fab, {})
        if fabDrag then table.insert(windowRef._connections, fabDrag) end
        -- distinguish a tap (toggle) from a drag (move) using a movement threshold
        local downPos
        fab.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                downPos = input.Position
            end
        end)
        fab.InputEnded:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) and downPos then
                local moved = (input.Position - downPos).Magnitude
                downPos = nil
                if moved < 8 then setUIVisible(uiHidden) end
            end
        end)
    end

    table.insert(Library._windowObjects,windowRef)
    if opts.Visible==false then screenGui.Enabled=false end

    if loadingEnabled and loadingLayer then
        task.defer(function()
            while not loadingMotionComplete and screenGui.Parent do RunService.Heartbeat:Wait() end
            if not screenGui.Parent or not loadingLayer.Parent then return end
            main.Visible=true; hotbar.Visible=true
            for _,s in ipairs(shadowFrames) do if s and s.Parent then s.Visible=true end end
            TweenService:Create(mainRevealScale,TweenInfo.new(0.46,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Scale=1}):Play()
            local fo=TweenService:Create(loadingLayer,TweenInfo.new(0.48,Enum.EasingStyle.Quart,Enum.EasingDirection.InOut),{GroupTransparency=1})
            local ce=loadingContent and TweenService:Create(loadingContent,TweenInfo.new(0.46,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{Position=UDim2.new(0.5,0,0.5,-18),GroupTransparency=1})
            local le=loadingLogoScale and TweenService:Create(loadingLogoScale,TweenInfo.new(0.42,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{Scale=0.84})
            local te=loadingTitleScale and TweenService:Create(loadingTitleScale,TweenInfo.new(0.42,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{Scale=0.95})
            local pe
            if loadingProgressFill and loadingProgressFill.Parent then
                loadingProgressFill.AnchorPoint=Vector2.new(0.5,0.5); loadingProgressFill.Position=UDim2.fromScale(0.5,0.5)
                pe=TweenService:Create(loadingProgressFill,TweenInfo.new(0.3,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{Size=UDim2.new(0,0,1,0)})
            end
            fo:Play(); if ce then ce:Play() end; if le then le:Play() end; if te then te:Play() end; if pe then pe:Play() end
            if loadingBlur then TweenService:Create(loadingBlur,TweenInfo.new(0.48,Enum.EasingStyle.Quart,Enum.EasingDirection.InOut),{Size=0}):Play() end
            if loadingSound then TweenService:Create(loadingSound,TweenInfo.new(0.5),{Volume=0}):Play() end
            fo.Completed:Wait()
            if loadingLayer and loadingLayer.Parent then loadingLayer:Destroy() end
            pcall(function() if loadingBlur then loadingBlur:Destroy() end end)
            pcall(function() if loadingSound then loadingSound:Stop(); loadingSound:Destroy() end end)
            if not screenGui.Parent then return end; loadingComplete=true
        end)
    end

    return windowRef
end

-- ════════════════════════════════════════════════════════════════════════════
-- WINDOW METHODS
-- ════════════════════════════════════════════════════════════════════════════
function Window:SetVisible(v) self.ScreenGui.Enabled = v==true end
function Window:Toggle() self.ScreenGui.Enabled = not self.ScreenGui.Enabled; return self.ScreenGui.Enabled end
function Window:SetUIVisible(v)
    if self._setUIVisible then return self._setUIVisible(v==true) end
    self.ScreenGui.Enabled = v==true; return v==true
end
function Window:ToggleUI() return self:SetUIVisible(not self._uiVisible) end
function Window:SetProfileVisible(v)
    if not self._setProfileVisible then return false end
    self._profileOpen=self._setProfileVisible(v==true); return self._profileOpen
end
function Window:ToggleProfile() return self:SetProfileVisible(not self._profileOpen) end
function Window:SetLogo(id)
    self._logoAsset=normalizeAssetId(id)
    if self.Logo then self.Logo.Image=self._logoAsset end
    if self.Watermark then self.Watermark.Image=self._logoAsset end
    return self._logoAsset
end

function Window:Notify(opts)
    if type(opts)=="string" then opts={Content=opts} end; opts=opts or {}
    local holder=self._notificationHolder; if not holder or not holder.Parent then return nil end
    local style=getNotificationStyle(opts.Type)
    local dur=tonumber(opts.Duration); if dur==nil then dur=4 end; dur=math.max(dur,0)
    self._notificationOrder=self._notificationOrder+1
    local title=tostring(opts.Title or style.Name)
    local body =tostring(opts.Content or opts.Description or opts.Message or "Notification")
    local createdAt=os.time()
    local slot=make("Frame",{Name="NotificationSlot",Size=UDim2.new(1,0,0,66),BackgroundTransparency=1,LayoutOrder=self._notificationOrder,ZIndex=200,Parent=holder})
    -- Pill-rounded, glassy card matching the reference design: flat CardBg
    -- (always matches whatever theme is active) + a light translucency,
    -- severity colour used only for the icon chip, glow ring and rail —
    -- never blended across the whole background.
    local card=make("CanvasGroup",{Name=style.Name.."Notification",AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,24,0,0),Size=UDim2.fromScale(1,1),BackgroundColor3=C.CardBg,BackgroundTransparency=0.06,GroupTransparency=1,ClipsDescendants=true,ZIndex=201,Parent=slot})
    corner(card,16)
    local cardGlow=make("UIStroke",{Color=style.Color,Thickness=1.1,Transparency=0.4,ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=card})
    -- Slow shimmer sweep in the severity colour along the border, same
    -- traveling-light technique used elsewhere in the library.
    local shimmerGrad=make("UIGradient",{
        Rotation=45,
        Color=ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, style.Color),
            ColorSequenceKeypoint.new(0.42, style.Color),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(0.58, style.Color),
            ColorSequenceKeypoint.new(1.00, style.Color),
        }),
        Transparency=NumberSequence.new({
            NumberSequenceKeypoint.new(0.00, 1.0),
            NumberSequenceKeypoint.new(0.38, 1.0),
            NumberSequenceKeypoint.new(0.50, 0.75),
            NumberSequenceKeypoint.new(0.62, 1.0),
            NumberSequenceKeypoint.new(1.00, 1.0),
        }),
        Parent=cardGlow,
    })
    local nGlowT=0
    local shimmerConn=RunService.RenderStepped:Connect(function(dt)
        if not card or not card.Parent then if shimmerConn then shimmerConn:Disconnect() end return end
        nGlowT=(nGlowT+dt*0.35)%1
        shimmerGrad.Offset=Vector2.new(nGlowT*2-1,0)
    end)
    -- Square, rounded icon chip with a glowing ring — the focal point,
    -- same layout language as the reference toast design.
    local iconHolder=make("Frame",{Position=UDim2.fromOffset(14,17),Size=UDim2.fromOffset(32,32),BackgroundColor3=style.Color,BackgroundTransparency=0.82,ZIndex=202,Parent=card})
    corner(iconHolder,10)
    local iconRing=stroke(iconHolder,style.Color); iconRing.Transparency=0.35; iconRing.Thickness=1.2
    make("ImageLabel",{Image=style.Icon or ICONS.alert,ImageColor3=style.Color,BackgroundTransparency=1,AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(16,16),ScaleType=Enum.ScaleType.Fit,ZIndex=203,Parent=iconHolder})
    make("TextLabel",{Text=title,Font=Enum.Font.GothamBold,TextSize=13,TextColor3=C.White,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,BackgroundTransparency=1,Position=UDim2.fromOffset(57,12),Size=UDim2.new(1,-96,0,16),ZIndex=202,Parent=card})
    make("TextLabel",{Text=body,Font=Enum.Font.Gotham,TextSize=11,TextColor3=C.TextGray,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top,TextWrapped=true,BackgroundTransparency=1,Position=UDim2.fromOffset(57,31),Size=UDim2.new(1,-70,0,26),ZIndex=202,Parent=card})
    -- "now" / "2m ago" style relative timestamp, refreshed once a second.
    local timeLabel=make("TextLabel",{Text="now",Font=Enum.Font.Gotham,TextSize=10,TextColor3=C.TextDim,TextXAlignment=Enum.TextXAlignment.Right,BackgroundTransparency=1,AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-30,0,12),Size=UDim2.fromOffset(50,14),ZIndex=202,Parent=card})
    local timeConn
    timeConn=task.spawn(function()
        while card and card.Parent do
            local secs=os.time()-createdAt
            if secs<5 then timeLabel.Text="now"
            elseif secs<60 then timeLabel.Text=secs.."s ago"
            elseif secs<3600 then timeLabel.Text=math.floor(secs/60).."m ago"
            else timeLabel.Text=math.floor(secs/3600).."h ago" end
            task.wait(1)
        end
    end)
    -- Small circular close button, subtle grey chip that brightens on hover.
    local xb=make("TextButton",{Text="×",Font=Enum.Font.GothamBold,TextSize=13,TextColor3=C.TextDim,AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-8,0,8),Size=UDim2.fromOffset(18,18),BackgroundColor3=C.Element,ZIndex=204,Parent=card})
    circle(xb)
    -- Progress rail along the bottom edge, drains over the notification's
    -- lifetime so the person can see how long they have before it closes.
    local rail
    if dur>0 then
        local railTrack=make("Frame",{AnchorPoint=Vector2.new(0,1),Position=UDim2.new(0,12,1,-6),Size=UDim2.new(1,-24,0,2),BackgroundColor3=C.Border,ZIndex=202,Parent=card})
        corner(railTrack,1)
        rail=make("Frame",{Size=UDim2.fromScale(1,1),BackgroundColor3=style.Color,ZIndex=203,Parent=railTrack})
        corner(rail,1)
    end
    local closed=false; local handle={}
    local function close(reason)
        if closed then return end; closed=true
        TweenService:Create(card,NOTIFICATION_TWEEN,{Position=UDim2.new(1,24,0,0),GroupTransparency=1}):Play()
        task.delay(0.2,function() if slot and slot.Parent then slot:Destroy() end end)
        fire(opts.Callback or opts.OnClose,reason or "closed")
    end
    function handle:Close() close("manual") end
    function handle:IsOpen() return not closed end
    xb.MouseEnter:Connect(function() tween(xb,{TextColor3=C.White,BackgroundColor3=C.ElementHover}) end)
    xb.MouseLeave:Connect(function() tween(xb,{TextColor3=C.TextDim,BackgroundColor3=C.Element}) end)
    xb.MouseButton1Click:Connect(function() close("manual") end)
    TweenService:Create(card,NOTIFICATION_TWEEN,{Position=UDim2.new(1,0,0,0),GroupTransparency=0}):Play()
    if dur>0 then
        if rail then TweenService:Create(rail,TweenInfo.new(dur,Enum.EasingStyle.Linear),{Size=UDim2.fromScale(0,1)}):Play() end
        task.delay(dur,function() close("timeout") end)
    end
    return handle
end

function Window:Destroy()
    if self._destroyed then return end
    self._destroyed = true
    -- Stop every tracked connection first (music sound, input listeners,
    -- drag handlers, admin/tag listeners, viewport-resize hooks, etc.) so
    -- nothing keeps running in the background once the GUI is gone.
    for _,c in ipairs(self._connections or {}) do pcall(function() c:Disconnect() end) end
    table.clear(self._connections or {})
    if self._fpsEditableImage then pcall(function() self._fpsEditableImage:Destroy() end); self._fpsEditableImage=nil end
    -- Safety net: if the window is destroyed mid-loading-animation, the
    -- Lighting blur it applied wouldn't otherwise get cleaned up.
    if self._loadingBlur then pcall(function() self._loadingBlur:Destroy() end); self._loadingBlur=nil end
    local i=table.find(Library._windows,self.ScreenGui); if i then table.remove(Library._windows,i) end
    local j=table.find(Library._windowObjects,self);     if j then table.remove(Library._windowObjects,j) end
    if self.ScreenGui then self.ScreenGui:Destroy() end
end

-- ════════════════════════════════════════════════════════════════════════════
-- TAB SYSTEM
-- ════════════════════════════════════════════════════════════════════════════
function Window:_selectTab(tab)
    if self._activeTab==tab then return end
    local prev=self._activeTab; self._activeTab=tab
    if prev then
        prev._page.Visible=false
        tween(prev._hBtn,{BackgroundColor3=C.HotbarBg})
        tween(prev._hLabel,{TextColor3=C.TextGray})
        if prev._hDot then tween(prev._hDot,{BackgroundTransparency=1}) end
        if prev._hGlowStroke then tween(prev._hGlowStroke,{Transparency=1}) end
        if prev._hIconElement then
            if prev._hIconElement:IsA("ImageLabel") then tween(prev._hIconElement,{ImageColor3=C.TextGray})
            elseif prev._hIconElement:IsA("TextLabel") then tween(prev._hIconElement,{TextColor3=C.TextGray}) end
        end
    end
    tab._page.Visible=true
    tween(tab._hBtn,{BackgroundColor3=C.HotbarActive})
    tween(tab._hLabel,{TextColor3=C.White})
    if tab._hDot then tween(tab._hDot,{BackgroundTransparency=0}) end
    if tab._hGlowStroke then tween(tab._hGlowStroke,{Transparency=0.25}) end
    if tab._hScale then
        TweenService:Create(tab._hScale,TweenInfo.new(0.22,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Scale=1.0}):Play()
    end
    if tab._hIconElement then
        if tab._hIconElement:IsA("ImageLabel") then tween(tab._hIconElement,{ImageColor3=C.White})
        elseif tab._hIconElement:IsA("TextLabel") then tween(tab._hIconElement,{TextColor3=C.White}) end
    end
end

function Window:AddTab(opts)
    if type(opts)=="string" then opts={Name=opts} end
    opts=opts or {}
    local name=opts.Name or "Tab"
    local iconInput = opts.Icon
    local win=self

    local iconType, iconValue = resolveIcon(iconInput)
    if not iconType then
        local autoKey = string.lower(name)
        if ICONS[autoKey] then iconType="image"; iconValue=ICONS[autoKey]
        else iconType="text"; iconValue=string.upper(string.sub(name,1,1)) end
    end

    local hBtn=make("TextButton",{
        Text="", AutomaticSize=Enum.AutomaticSize.X,
        Size=UDim2.new(0,0,1,0),
        BackgroundColor3=C.HotbarBg,
        ZIndex=5, Parent=self._hotbarInner,
    })
    hBtn.LayoutOrder=#self._hotbarInner:GetChildren()
    corner(hBtn,7); pad(hBtn,0,0,12,12)
    table.insert(win._noDrag,hBtn)
    local hBtnScale=make("UIScale",{Scale=1,Parent=hBtn})
    -- Traveling-light border, same technique as the main window's outline,
    -- shown only while this tab is the active one.
    local hGlowStroke=make("UIStroke",{Color=C.Accent,Thickness=1.3,Transparency=1,ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=hBtn})
    local hGlowGradient=make("UIGradient",{Color=ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, C.Accent),
        ColorSequenceKeypoint.new(0.42, C.Accent),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(0.58, C.Accent),
        ColorSequenceKeypoint.new(1.00, C.Accent),
    }),Transparency=NumberSequence.new({
        NumberSequenceKeypoint.new(0.00, 1.0),
        NumberSequenceKeypoint.new(0.36, 1.0),
        NumberSequenceKeypoint.new(0.50, 0.0),
        NumberSequenceKeypoint.new(0.64, 1.0),
        NumberSequenceKeypoint.new(1.00, 1.0),
    }),Parent=hGlowStroke})
    hGlowGradient:SetAttribute("ThemeGradient_Edge","Accent")
    local hGlowConn
    hGlowConn=RunService.RenderStepped:Connect(function()
        if not hBtn or not hBtn.Parent then if hGlowConn then hGlowConn:Disconnect() end return end
        local t=(os.clock()*0.35)%1
        hGlowGradient.Offset=Vector2.new(t*2-1,0)
    end)

    local hRow=make("Frame",{BackgroundTransparency=1,AutomaticSize=Enum.AutomaticSize.X,Size=UDim2.new(0,0,1,0),ZIndex=5,Parent=hBtn})
    make("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,VerticalAlignment=Enum.VerticalAlignment.Center,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,6),Parent=hRow})

    local iconBadge=make("Frame",{Size=UDim2.fromOffset(20,20),BackgroundTransparency=1,LayoutOrder=1,ZIndex=6,Parent=hRow})
    local hIconElement = createIconElement(iconBadge, iconType, iconValue, 18, 7)

    local hLabel=make("TextLabel",{
        Text=name,Font=Enum.Font.GothamMedium,TextSize=12,
        TextColor3=C.TextGray,BackgroundTransparency=1,
        AutomaticSize=Enum.AutomaticSize.X,
        Size=UDim2.new(0,0,1,0),LayoutOrder=2,ZIndex=6,Parent=hRow,
    })

    local hDot=make("Frame",{
        AnchorPoint=Vector2.new(0.5,0), Position=UDim2.new(0.5,0,1,4),
        Size=UDim2.fromOffset(4,4), BackgroundColor3=C.Accent,
        BackgroundTransparency=1, ZIndex=6, Parent=hBtn,
    })
    circle(hDot)

    local page=make("Frame",{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Visible=false,Parent=self._content})
    local header=make("Frame",{Size=UDim2.new(1,0,0,88),BackgroundTransparency=1,Parent=page})

    local headerBadge=make("Frame",{Size=UDim2.fromOffset(32,32),Position=UDim2.fromOffset(14,14),BackgroundTransparency=1,Parent=header})
    local headerIconElement = createIconElement(headerBadge, iconType, iconValue, 26, 3)
    if headerIconElement:IsA("ImageLabel") then headerIconElement.ImageColor3=C.White
    elseif headerIconElement:IsA("TextLabel") then headerIconElement.TextColor3=C.White end

    make("TextLabel",{Text=name,Font=Enum.Font.GothamBold,TextSize=14,TextColor3=C.White,TextXAlignment=Enum.TextXAlignment.Left,BackgroundTransparency=1,Position=UDim2.fromOffset(54,17),Size=UDim2.new(1,-70,0,14),Parent=header})
    make("TextLabel",{Text=opts.Subtitle or "",Font=Enum.Font.Gotham,TextSize=11,TextColor3=C.TextDim,TextXAlignment=Enum.TextXAlignment.Left,BackgroundTransparency=1,Position=UDim2.fromOffset(54,33),Size=UDim2.new(1,-70,0,12),Parent=header})
    local pillBar=make("Frame",{Position=UDim2.fromOffset(16,54),Size=UDim2.new(1,-32,0,24),BackgroundTransparency=1,ClipsDescendants=true,Parent=header})
    local pillScrollLeft=make("TextButton",{Text="‹",Font=Enum.Font.GothamBold,TextSize=18,TextColor3=C.TextGray,Size=UDim2.fromOffset(20,24),BackgroundColor3=C.WindowBg,Visible=false,Parent=pillBar})
    corner(pillScrollLeft,6); table.insert(win._noDrag,pillScrollLeft)
    local pillScroll=make("ScrollingFrame",{Position=UDim2.fromOffset(24,0),Size=UDim2.new(1,-48,1,0),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=0,ScrollingDirection=Enum.ScrollingDirection.X,AutomaticCanvasSize=Enum.AutomaticSize.X,CanvasSize=UDim2.new(),ClipsDescendants=true,Parent=pillBar})
    table.insert(win._noDrag,pillScroll)
    local pillRow=make("Frame",{AutomaticSize=Enum.AutomaticSize.X,Size=UDim2.new(0,0,1,0),BackgroundTransparency=1,Parent=pillScroll})
    make("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,8),Parent=pillRow})
    local pillScrollRight=make("TextButton",{Text="›",Font=Enum.Font.GothamBold,TextSize=18,TextColor3=C.TextGray,AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,0,0,0),Size=UDim2.fromOffset(20,24),BackgroundColor3=C.WindowBg,Visible=false,Parent=pillBar})
    corner(pillScrollRight,6); table.insert(win._noDrag,pillScrollRight)
    make("Frame",{Position=UDim2.new(0,0,1,-1),Size=UDim2.new(1,0,0,1),BackgroundColor3=C.Border,Parent=header})
    local pagesHolder=make("Frame",{Position=UDim2.fromOffset(0,88),Size=UDim2.new(1,0,1,-88),BackgroundTransparency=1,Parent=page})

    local tab=setmetatable({
        _window=win,
        _hBtn=hBtn,_hLabel=hLabel,_hDot=hDot,_hIconElement=hIconElement,_hGlowStroke=hGlowStroke,_hScale=hBtnScale,
        _page=page,_pillBar=pillBar,_pillScroll=pillScroll,_pillRow=pillRow,
        _pillScrollLeft=pillScrollLeft,_pillScrollRight=pillScrollRight,
        _pagesHolder=pagesHolder,
        _subTabs={},_activeSub=nil,
    },Tab)
    tab:_setupPillScroll()

    hBtn.MouseButton1Click:Connect(function() win:_selectTab(tab) end)
    hBtn.MouseEnter:Connect(function()
        if win._activeTab~=tab then tween(hBtn,{BackgroundColor3=C.HotbarHover}) end
        TweenService:Create(hBtnScale,TWEEN,{Scale=1.04}):Play()
    end)
    hBtn.MouseLeave:Connect(function()
        tween(hBtn,{BackgroundColor3=win._activeTab==tab and C.HotbarActive or C.HotbarBg})
        TweenService:Create(hBtnScale,TWEEN,{Scale=1}):Play()
    end)
    hBtn.MouseButton1Down:Connect(function()
        TweenService:Create(hBtnScale,TweenInfo.new(0.08,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=0.94}):Play()
    end)
    hBtn.MouseButton1Up:Connect(function()
        TweenService:Create(hBtnScale,TWEEN,{Scale=1.04}):Play()
    end)

    table.insert(self._tabs,tab)
    if not self._activeTab then self:_selectTab(tab) end
    return tab
end

-- ════════════════════════════════════════════════════════════════════════════
-- SUBTAB + ELEMENTS
-- ════════════════════════════════════════════════════════════════════════════
local PILL_SCROLL_STEP = 72

function Tab:_updatePillScroll()
    local scroll = self._pillScroll
    if not scroll then return end
    task.defer(function()
        if not scroll.Parent then return end
        local maxX = math.max(0, scroll.AbsoluteCanvasSize.X - scroll.AbsoluteWindowSize.X)
        local canScroll = maxX > 2
        if self._pillScrollLeft then
            self._pillScrollLeft.Visible = canScroll
            paint(self._pillScrollLeft, "TextColor3", scroll.CanvasPosition.X > 2 and "White" or "TextDim", true)
        end
        if self._pillScrollRight then
            self._pillScrollRight.Visible = canScroll
            paint(self._pillScrollRight, "TextColor3", scroll.CanvasPosition.X < maxX - 2 and "White" or "TextDim", true)
        end
        if not canScroll then
            scroll.CanvasPosition = Vector2.new(0, 0)
        end
    end)
end

function Tab:_scrollPillBy(delta)
    local scroll = self._pillScroll
    if not scroll then return end
    local maxX = math.max(0, scroll.AbsoluteCanvasSize.X - scroll.AbsoluteWindowSize.X)
    scroll.CanvasPosition = Vector2.new(math.clamp(scroll.CanvasPosition.X + delta, 0, maxX), 0)
    self:_updatePillScroll()
end

function Tab:_scrollPillIntoView(pill)
    local scroll = self._pillScroll
    if not scroll or not pill or not pill.Parent then return end
    task.defer(function()
        if not pill.Parent or not scroll.Parent then return end
        local maxX = math.max(0, scroll.AbsoluteCanvasSize.X - scroll.AbsoluteWindowSize.X)
        local relLeft = pill.AbsolutePosition.X - scroll.AbsolutePosition.X + scroll.CanvasPosition.X
        local relRight = relLeft + pill.AbsoluteSize.X
        local viewLeft = scroll.CanvasPosition.X
        local viewRight = viewLeft + scroll.AbsoluteWindowSize.X
        local nextX = scroll.CanvasPosition.X
        if relLeft < viewLeft + 4 then
            nextX = relLeft - 8
        elseif relRight > viewRight - 4 then
            nextX = relRight - scroll.AbsoluteWindowSize.X + 8
        end
        scroll.CanvasPosition = Vector2.new(math.clamp(nextX, 0, maxX), 0)
        self:_updatePillScroll()
    end)
end

function Tab:_setupPillScroll()
    local scroll = self._pillScroll
    local left = self._pillScrollLeft
    local right = self._pillScrollRight
    if not scroll then return end

    if left then
        left.MouseButton1Click:Connect(function() self:_scrollPillBy(-PILL_SCROLL_STEP) end)
        left.MouseEnter:Connect(function() tween(left, {BackgroundColor3=C.NavHover}) end)
        left.MouseLeave:Connect(function() tween(left, {BackgroundColor3=C.WindowBg}) end)
    end
    if right then
        right.MouseButton1Click:Connect(function() self:_scrollPillBy(PILL_SCROLL_STEP) end)
        right.MouseEnter:Connect(function() tween(right, {BackgroundColor3=C.NavHover}) end)
        right.MouseLeave:Connect(function() tween(right, {BackgroundColor3=C.WindowBg}) end)
    end

    scroll:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function() self:_updatePillScroll() end)
    scroll:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() self:_updatePillScroll() end)
    scroll:GetPropertyChangedSignal("CanvasPosition"):Connect(function() self:_updatePillScroll() end)

    trackConn(self._window, UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseWheel then return end
        if not scroll.Visible or not self._page.Visible then return end
        local mouse = UserInputService:GetMouseLocation()
        local inset = GuiService:GetGuiInset()
        local pos = Vector2.new(mouse.X - inset.X, mouse.Y - inset.Y)
        local sPos, sSize = scroll.AbsolutePosition, scroll.AbsoluteSize
        if pos.X >= sPos.X and pos.X <= sPos.X + sSize.X and pos.Y >= sPos.Y and pos.Y <= sPos.Y + sSize.Y then
            self:_scrollPillBy(-input.Position.Z * PILL_SCROLL_STEP * 0.5)
        end
    end))
end

function Tab:_selectSub(sub)
    if self._activeSub==sub then return end
    local prev=self._activeSub; self._activeSub=sub
    if prev then prev._page.Visible=false; paint(prev._pill,"BackgroundColor3","WindowBg"); paint(prev._pill,"TextColor3","TextGray") end
    sub._page.Visible=true; paint(sub._pill,"BackgroundColor3","PillActive"); paint(sub._pill,"TextColor3","White")
    self:_scrollPillIntoView(sub._pill)
end

function Tab:AddSubTab(name)
    name=tostring(name or "General"); local tab=self
    local pill=make("TextButton",{Text=name,Font=Enum.Font.GothamMedium,TextSize=12,TextColor3=C.TextGray,BackgroundColor3=C.WindowBg,Size=UDim2.new(0,0,0,24),AutomaticSize=Enum.AutomaticSize.X,Parent=self._pillRow})
    autoOrder(pill);corner(pill,6);pad(pill,0,0,12,12)
    table.insert(tab._window._noDrag,pill)
    local page=make("ScrollingFrame",{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Visible=false,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,ScrollingDirection=Enum.ScrollingDirection.Y,ScrollBarThickness=2,ScrollBarImageColor3=C.Border,Parent=self._pagesHolder})
    pad(page,12,16,16,16)
    table.insert(tab._window._noDrag,page)
    local card=make("Frame",{Size=UDim2.new(1,-32,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundColor3=C.CardBg,Parent=page})
    corner(card,14);stroke(card);pad(card,18,18,20,20)
    make("UIListLayout",{FillDirection=Enum.FillDirection.Vertical,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,10),Parent=card})
    local sub=setmetatable({_tab=tab,_window=tab._window,_pill=pill,_page=page,_card=card},SubTab)
    pill.MouseButton1Click:Connect(function() tab:_selectSub(sub) end)
    pill.MouseEnter:Connect(function() if tab._activeSub~=sub then tween(pill,{BackgroundColor3=C.NavHover}) end end)
    pill.MouseLeave:Connect(function() tween(pill,{BackgroundColor3=tab._activeSub==sub and C.PillActive or C.WindowBg}) end)
    table.insert(self._subTabs,sub)
    if not self._activeSub then self:_selectSub(sub) end
    self:_updatePillScroll()
    return sub
end

local function newRow(card,h)
    local r=make("Frame",{Size=UDim2.new(1,0,0,h),BackgroundTransparency=1,Parent=card}); autoOrder(r); return r
end
local function rowLabels(row,name,desc,rr)
    rr=rr or 0
    make("TextLabel",{Text=name,Font=Enum.Font.GothamMedium,TextSize=13,TextColor3=C.White,TextXAlignment=Enum.TextXAlignment.Left,BackgroundTransparency=1,Position=UDim2.fromOffset(0,0),Size=desc and UDim2.new(1,-rr,0,14) or UDim2.new(1,-rr,1,0),Parent=row})
    if desc then make("TextLabel",{Text=desc,Font=Enum.Font.Gotham,TextSize=11,TextColor3=C.TextDim,TextXAlignment=Enum.TextXAlignment.Left,BackgroundTransparency=1,Position=UDim2.fromOffset(0,16),Size=UDim2.new(1,-rr,0,12),Parent=row}) end
end

function SubTab:AddToggle(opts)
    opts=opts or {}; local value=opts.Default==true
    local row=newRow(self._card,30); rowLabels(row,opts.Name or "Toggle",opts.Description,44)
    local pill=make("TextButton",{Text="",Size=UDim2.fromOffset(38,20),AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,0,0.5,0),BackgroundColor3=C.Badge,Parent=row})
    circle(pill)
    -- Blue accent outline around the pill toggle: bright when on, dim when
    -- off, with a soft outer halo for depth (theme-aware via stroke)
    local pillOutline=stroke(pill,C.Accent); pillOutline.Thickness=1.2
    local pillHalo=stroke(pill,C.Accent); pillHalo.Thickness=4; pillHalo.Transparency=0.88
    local knob=make("Frame",{Size=UDim2.fromOffset(16,16),AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,2,0.5,0),BackgroundColor3=C.KnobOff,Parent=pill})
    circle(knob)
    local knobScale=make("UIScale",{Scale=1,Parent=knob})
    local BOUNCE=TweenInfo.new(0.28,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
    local function render(a)
        local kp=value and UDim2.new(0,20,0.5,0) or UDim2.new(0,2,0.5,0)
        paint(pill,"BackgroundColor3",value and "Accent" or "Badge",not a)
        paint(knob,"BackgroundColor3",value and "KnobAccent" or "KnobOff",not a)
        if a then
            tween(pillOutline,{Transparency=value and 0.15 or 0.55})
            tween(pillHalo,{Transparency=value and 0.75 or 0.9})
            TweenService:Create(knob,BOUNCE,{Position=kp}):Play()
            -- Quick squash-and-stretch pop on the knob for extra tactile feel
            knobScale.Scale=0.8
            TweenService:Create(knobScale,BOUNCE,{Scale=1}):Play()
        else
            pillOutline.Transparency=value and 0.15 or 0.55
            pillHalo.Transparency=value and 0.75 or 0.9
            knob.Position=kp
        end
    end
    local function set(v) v=v==true; if v==value then return end; value=v; render(true); fire(opts.Callback,value) end
    pill.MouseButton1Click:Connect(function() set(not value) end)
    pill.MouseEnter:Connect(function() tween(pillHalo,{Transparency=value and 0.6 or 0.8}) end)
    pill.MouseLeave:Connect(function() tween(pillHalo,{Transparency=value and 0.75 or 0.9}) end)
    render(false)
    return registerFlag(opts.Flag, "toggle", {Set=function(_,v) set(v) end, Get=function() return value end})
end

function SubTab:AddButton(opts)
    opts=opts or {}
    local primary=opts.Primary==true or opts.Style=="primary"
    local btn=make("TextButton",{Text=opts.Name or "Button",Font=Enum.Font.GothamMedium,TextSize=12,TextColor3=primary and C.AccentText or C.TextGray,Size=UDim2.new(1,0,0,28),BackgroundColor3=primary and C.Accent or C.Element,Parent=self._card})
    autoOrder(btn);corner(btn,8)
    if primary then btn.Font=Enum.Font.GothamBold end
    local btnScale=make("UIScale",{Scale=1,Parent=btn})
    local btnGlow=make("UIStroke",{Color=C.Accent,Thickness=1,Transparency=1,ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=btn})
    btn.MouseEnter:Connect(function()
        if primary then tween(btn,{BackgroundTransparency=0.14}) else tween(btn,{BackgroundColor3=C.ElementHover}) end
        TweenService:Create(btnScale,TWEEN,{Scale=1.02}):Play()
        TweenService:Create(btnGlow,TWEEN,{Transparency=primary and 0.6 or 0.35}):Play()
    end)
    btn.MouseLeave:Connect(function()
        if primary then tween(btn,{BackgroundTransparency=0}) else tween(btn,{BackgroundColor3=C.Element}) end
        TweenService:Create(btnScale,TWEEN,{Scale=1}):Play()
        TweenService:Create(btnGlow,TWEEN,{Transparency=1}):Play()
    end)
    btn.MouseButton1Click:Connect(function() fire(opts.Callback) end)
    return btn
end

function SubTab:AddSection(opts)
    if type(opts)=="string" then opts={Name=opts} end; opts=opts or {}
    local row=make("Frame",{Size=UDim2.new(1,0,0,22),BackgroundTransparency=1,Parent=self._card}); autoOrder(row)
    local tick=make("Frame",{AnchorPoint=Vector2.new(0,1),Position=UDim2.new(0,0,1,-4),Size=UDim2.fromOffset(3,11),BackgroundColor3=C.Accent,Parent=row}); corner(tick,2)
    make("TextLabel",{Text=string.upper(tostring(opts.Name or "Section")),Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.TextGray,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Bottom,BackgroundTransparency=1,Position=UDim2.fromOffset(9,0),Size=UDim2.new(1,-9,1,-3),Parent=row})
    make("Frame",{Position=UDim2.new(0,0,1,-1),Size=UDim2.new(1,0,0,1),BackgroundColor3=C.Border,Parent=row})
    local accentUnderline=make("Frame",{Position=UDim2.new(0,0,1,-1),Size=UDim2.fromOffset(28,1),BackgroundColor3=C.Accent,Parent=row})
    return row
end

function SubTab:AddDivider()
    local row=make("Frame",{Size=UDim2.new(1,0,0,9),BackgroundTransparency=1,Parent=self._card}); autoOrder(row)
    make("Frame",{AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,0,0.5,0),Size=UDim2.new(1,0,0,1),BackgroundColor3=C.Border,Parent=row})
    return row
end

function SubTab:AddLabel(opts)
    if type(opts)=="string" then opts={Text=opts} end; opts=opts or {}
    local lbl=make("TextLabel",{Text=tostring(opts.Text or "Label"),Font=Enum.Font.GothamMedium,TextSize=13,TextColor3=C.White,TextXAlignment=Enum.TextXAlignment.Left,BackgroundTransparency=1,Size=UDim2.new(1,0,0,16),Parent=self._card})
    autoOrder(lbl)
    return {Set=function(_,t) lbl.Text=tostring(t) end, Get=function() return lbl.Text end, Instance=lbl}
end

function SubTab:AddParagraph(opts)
    opts=opts or {}
    local card=make("Frame",{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,Parent=self._card}); autoOrder(card)
    make("UIListLayout",{FillDirection=Enum.FillDirection.Vertical,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,3),Parent=card})
    if opts.Title then
        make("TextLabel",{Text=tostring(opts.Title),Font=Enum.Font.GothamMedium,TextSize=13,TextColor3=C.White,TextXAlignment=Enum.TextXAlignment.Left,BackgroundTransparency=1,Size=UDim2.new(1,0,0,16),LayoutOrder=1,Parent=card})
    end
    local body=make("TextLabel",{Text=tostring(opts.Text or opts.Content or ""),Font=Enum.Font.Gotham,TextSize=11,TextColor3=C.TextDim,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top,TextWrapped=true,AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,Size=UDim2.new(1,0,0,0),LayoutOrder=2,Parent=card})
    return {Set=function(_,t) body.Text=tostring(t) end, Get=function() return body.Text end, Instance=body}
end

function SubTab:AddKeybind(opts)
    opts=opts or {}
    local key=opts.Default
    if typeof(key)~="EnumItem" then key=nil end
    local row=newRow(self._card,30); rowLabels(row,opts.Name or "Keybind",opts.Description,80)
    local btn=make("TextButton",{Text=key and key.Name or "None",Font=Enum.Font.GothamMedium,TextSize=11,TextColor3=C.TextGray,Size=UDim2.fromOffset(70,22),AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,0,0.5,0),BackgroundColor3=C.Element,Parent=row})
    corner(btn,8)
    local listening=false; local conn
    local function setKey(k)
        if k~=nil and typeof(k)~="EnumItem" then return end
        key=k; btn.Text=key and key.Name or "None"; fire(opts.Callback,key)
    end
    local function stopListening()
        listening=false
        if conn then conn:Disconnect(); conn=nil end
        btn.Text=key and key.Name or "None"
        tween(btn,{BackgroundColor3=C.Element,TextColor3=C.TextGray})
    end
    btn.MouseEnter:Connect(function() if not listening then tween(btn,{BackgroundColor3=C.ElementHover}) end end)
    btn.MouseLeave:Connect(function() if not listening then tween(btn,{BackgroundColor3=C.Element}) end end)
    btn.MouseButton1Click:Connect(function()
        if listening then stopListening(); return end
        listening=true; btn.Text="..."; tween(btn,{BackgroundColor3=C.PillActive,TextColor3=C.White})
        conn=UserInputService.InputBegan:Connect(function(input,gp)
            if gp then return end
            if input.UserInputType==Enum.UserInputType.Keyboard then
                if input.KeyCode==Enum.KeyCode.Escape then setKey(nil) else setKey(input.KeyCode) end
                stopListening()
            elseif input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.MouseButton2 then
                stopListening()
            end
        end)
    end)
    local pressConn=UserInputService.InputBegan:Connect(function(input,gp)
        if gp or listening or not key then return end
        if UserInputService:GetFocusedTextBox() then return end
        if input.KeyCode==key then fire(opts.OnPress or opts.Pressed,key) end
    end)
    table.insert(self._window._noDrag,btn)
    trackConn(self._window, pressConn)
    return registerFlag(opts.Flag, "keybind", {Set=function(_,k) setKey(k) end, Get=function() return key end, _connections={pressConn}})
end

function SubTab:AddInput(opts)
    opts=opts or {}
    local row=newRow(self._card,30); rowLabels(row,opts.Name or "Input",opts.Description,120)
    local holder=make("Frame",{Size=UDim2.fromOffset(110,22),AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,0,0.5,0),BackgroundColor3=C.Element,Parent=row})
    corner(holder,8)
    local box=make("TextBox",{Text=opts.Default or "",PlaceholderText=opts.Placeholder or "...",PlaceholderColor3=C.Placeholder,Font=Enum.Font.Gotham,TextSize=12,TextColor3=C.TextGray,TextXAlignment=Enum.TextXAlignment.Left,BackgroundTransparency=1,ClearTextOnFocus=false,ClipsDescendants=true,Position=UDim2.fromOffset(8,0),Size=UDim2.new(1,-30,1,0),Parent=holder})
    inputIcon(holder)
    box.FocusLost:Connect(function(ep) fire(opts.Callback,box.Text,ep) end)
    return registerFlag(opts.Flag, "input", {Set=function(_,t) box.Text=tostring(t) end, Get=function() return box.Text end})
end

-- A complete, drop-in config manager: name box + Save / Load / Delete /
-- Refresh, a live list of what's already saved, and a "Load Last" button
-- that pulls whatever config the player used most recently. Everything
-- routes through Library:SaveConfig / LoadConfig / ListConfigs /
-- DeleteConfig, so it always matches whatever flags exist in this window.
function SubTab:AddConfigManager(opts)
    opts=opts or {}
    self:AddSection(opts.Name or "Config")

    local nameRow=newRow(self._card,30); rowLabels(nameRow,"Config Name",opts.Description or "Used for save / load / delete",0)
    local holder=make("Frame",{Size=UDim2.fromOffset(170,22),AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,0,0.5,0),BackgroundColor3=C.Element,Parent=nameRow})
    corner(holder,8)
    local box=make("TextBox",{Text="",PlaceholderText=opts.Placeholder or "default",PlaceholderColor3=C.Placeholder,Font=Enum.Font.Gotham,TextSize=12,TextColor3=C.TextGray,TextXAlignment=Enum.TextXAlignment.Left,BackgroundTransparency=1,ClearTextOnFocus=false,ClipsDescendants=true,Position=UDim2.fromOffset(8,0),Size=UDim2.new(1,-16,1,0),Parent=holder})
    inputIcon(holder)

    local btnRow=make("Frame",{Size=UDim2.new(1,0,0,28),BackgroundTransparency=1,Parent=self._card}); autoOrder(btnRow)
    make("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,8),Parent=btnRow})
    local function miniBtn(text,primary)
        local b=make("TextButton",{Text=text,Font=primary and Enum.Font.GothamBold or Enum.Font.GothamMedium,TextSize=11,TextColor3=primary and C.AccentText or C.TextGray,AutomaticSize=Enum.AutomaticSize.X,Size=UDim2.new(0,0,1,0),BackgroundColor3=primary and C.Accent or C.Element,Parent=btnRow})
        corner(b,8); pad(b,0,0,12,12)
        local scale=make("UIScale",{Scale=1,Parent=b})
        b.MouseEnter:Connect(function() if primary then tween(b,{BackgroundTransparency=0.14}) else tween(b,{BackgroundColor3=C.ElementHover}) end; TweenService:Create(scale,TWEEN,{Scale=1.04}):Play() end)
        b.MouseLeave:Connect(function() if primary then tween(b,{BackgroundTransparency=0}) else tween(b,{BackgroundColor3=C.Element}) end; TweenService:Create(scale,TWEEN,{Scale=1}):Play() end)
        return b
    end
    local saveBtn=miniBtn("Save",true)
    local loadBtn=miniBtn("Load")
    local loadLastBtn=miniBtn("Load Last")
    local deleteBtn=miniBtn("Delete")
    local refreshBtn=miniBtn("Refresh")

    local list=self:AddParagraph({Title="Saved Configs", Text="Loading..."})

    local function nameOrDefault()
        local n=box.Text; if n=="" then n="default" end; return n
    end
    local function refreshList()
        local ok, names = pcall(function() return Library:ListConfigs() end)
        if not ok or type(names)~="table" or #names==0 then
            list:Set("No configs saved yet.")
            return
        end
        table.sort(names)
        list:Set(table.concat(names, ", "))
    end

    saveBtn.MouseButton1Click:Connect(function()
        local n=nameOrDefault()
        local ok=Library:SaveConfig(n)
        Library:Notify({Title="Config", Content=ok and ("Saved '"..n.."'.") or "Save failed — check the executor's file API.", Style=ok and "success" or "error"})
        if ok then refreshList() end
    end)
    loadBtn.MouseButton1Click:Connect(function()
        local n=nameOrDefault()
        local ok=Library:LoadConfig(n)
        Library:Notify({Title="Config", Content=ok and ("Loaded '"..n.."'.") or ("Couldn't find or load '"..n.."'."), Style=ok and "success" or "warning"})
    end)
    loadLastBtn.MouseButton1Click:Connect(function()
        local last=Library:GetLastConfig()
        if not last then
            Library:Notify({Title="Config", Content="No config has been used yet.", Style="info"})
            return
        end
        local ok=Library:LoadConfig(last)
        Library:Notify({Title="Config", Content=ok and ("Loaded last config '"..last.."'.") or "Failed to load the last config.", Style=ok and "success" or "error"})
    end)
    deleteBtn.MouseButton1Click:Connect(function()
        local n=nameOrDefault()
        local ok=Library:DeleteConfig(n)
        Library:Notify({Title="Config", Content=ok and ("Deleted '"..n.."'.") or ("Couldn't delete '"..n.."'."), Style=ok and "success" or "warning"})
        if ok then refreshList() end
    end)
    refreshBtn.MouseButton1Click:Connect(refreshList)

    refreshList()
    return {RefreshList=refreshList}
end

function SubTab:AddDropdown(opts)
    opts=opts or {}
    local options=opts.Options or {}; local value=opts.Default or options[1] or ""
    local maxVisible=math.max(1,math.floor(opts.MaxVisible or 5)); local searchable=opts.Searchable==true
    local IH=22; local IP=2; local SH=26; local LW=160
    local row=newRow(self._card,30); rowLabels(row,opts.Name or "Dropdown",opts.Description,130)
    local btn=make("TextButton",{Text="",Size=UDim2.fromOffset(120,22),AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,0,0.5,0),BackgroundColor3=C.Element,Parent=row})
    corner(btn,8)
    local vl=make("TextLabel",{Text=tostring(value),Font=Enum.Font.Gotham,TextSize=12,TextColor3=C.TextGray,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,BackgroundTransparency=1,Position=UDim2.fromOffset(8,0),Size=UDim2.new(1,-26,1,0),Parent=btn})
    sortIcon(btn)
    local win=self._window; local sp=self._page; local tp=self._tab._page
    local list=make("Frame",{Visible=false,Active=true,Position=UDim2.fromOffset(0,0),Size=UDim2.new(0,LW,0,0),BackgroundColor3=C.Element,BackgroundTransparency=0.08,ClipsDescendants=true,ZIndex=100,Parent=win.ScreenGui})
    corner(list,10);local listGlow=stroke(list,C.Accent);listGlow.Transparency=0.55;listGlow.Thickness=1; table.insert(win._noDrag,list)
    local sb; local fq=""
    if searchable then
        local sh=make("Frame",{Position=UDim2.fromOffset(4,4),Size=UDim2.new(1,-8,0,SH-4),BackgroundColor3=C.WindowBg,ZIndex=101,Parent=list}); corner(sh,4)
        sb=make("TextBox",{Text="",PlaceholderText="Search...",PlaceholderColor3=C.Placeholder,Font=Enum.Font.Gotham,TextSize=11,TextColor3=C.White,TextXAlignment=Enum.TextXAlignment.Left,BackgroundTransparency=1,ClearTextOnFocus=false,Position=UDim2.fromOffset(8,0),Size=UDim2.new(1,-16,1,0),ZIndex=102,Parent=sh})
    end
    local sf=make("ScrollingFrame",{Position=UDim2.fromOffset(0,searchable and SH or 0),Size=UDim2.new(1,0,1,searchable and -SH or 0),BackgroundTransparency=1,BorderSizePixel=0,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,ScrollingDirection=Enum.ScrollingDirection.Y,ScrollBarThickness=3,ScrollBarImageColor3=C.Border,ZIndex=101,Parent=list})
    pad(sf,4,4,4,4)
    make("UIListLayout",{FillDirection=Enum.FillDirection.Vertical,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,IP),Parent=sf})
    local open=false; local cg=0; local oc={}; local co=options; local ob={}
    local function repo()
        local inset=GuiService:GetGuiInset(); local p,s=btn.AbsolutePosition,btn.AbsoluteSize
        list.Position=UDim2.fromOffset(p.X+inset.X+s.X-LW,p.Y+inset.Y+s.Y+4)
    end
    local function calcH()
        local fc=0; for _,o in ipairs(co) do if fq=="" or string.find(string.lower(tostring(o)),string.lower(fq),1,true) then fc=fc+1 end end
        local vc=math.min(math.max(fc,1),maxVisible)
        return vc*IH+math.max(vc-1,0)*IP+8+(searchable and SH or 0)
    end
    local function closeDD()
        if not open then return end; open=false; cg=cg+1
        for _,c in ipairs(oc) do c:Disconnect() end; table.clear(oc)
        tween(list,{Size=UDim2.new(0,LW,0,0)})
        local g=cg; task.delay(0.16,function() if g==cg and not open then list.Visible=false end end)
    end
    local function rebuild()
        for _,b in ipairs(ob) do if b and b.Parent then b:Destroy() end end; table.clear(ob)
        for _,o in ipairs(co) do
            local os=tostring(o)
            if fq=="" or string.find(string.lower(os),string.lower(fq),1,true) then
                local isSel=(o==value)
                local ob2=make("TextButton",{Text="",Size=UDim2.new(1,-8,0,IH),BackgroundColor3=isSel and C.Accent or C.Element,BackgroundTransparency=isSel and 0.82 or 0,Parent=sf})
                autoOrder(ob2);corner(ob2,4)
                make("TextLabel",{Text=os,Font=isSel and Enum.Font.GothamBold or Enum.Font.Gotham,TextSize=12,TextColor3=isSel and C.White or C.TextGray,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,BackgroundTransparency=1,Position=UDim2.fromOffset(8,0),Size=UDim2.new(1,-24,1,0),Parent=ob2})
                if isSel then
                    make("TextLabel",{Text="✓",Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.Accent,BackgroundTransparency=1,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-6,0.5,0),Size=UDim2.fromOffset(14,14),Parent=ob2})
                end
                ob2.MouseEnter:Connect(function() if not isSel then tween(ob2,{BackgroundColor3=C.ElementHover}) end end)
                ob2.MouseLeave:Connect(function() if not isSel then tween(ob2,{BackgroundColor3=C.Element}) end end)
                ob2.MouseButton1Click:Connect(function() value=o; vl.Text=os; closeDD(); rebuild(); fire(opts.Callback,o) end)
                table.insert(ob,ob2)
            end
        end
    end
    if sb then sb:GetPropertyChangedSignal("Text"):Connect(function() fq=sb.Text; rebuild(); if open then tween(list,{Size=UDim2.new(0,LW,0,calcH())}) end end) end
    rebuild()
    local function setOpen(o)
        if open==o then return end
        if o then
            open=true; cg=cg+1; repo(); list.Visible=true; tween(list,{Size=UDim2.new(0,LW,0,calcH())})
            table.insert(oc,btn:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
                local bp,bs=btn.AbsolutePosition,btn.AbsoluteSize; local pp,ps=sp.AbsolutePosition,sp.AbsoluteSize
                if bp.Y+bs.Y<pp.Y or bp.Y>pp.Y+ps.Y then closeDD() else repo() end
            end))
            table.insert(oc,sp:GetPropertyChangedSignal("Visible"):Connect(function() if not sp.Visible then closeDD() end end))
            table.insert(oc,tp:GetPropertyChangedSignal("Visible"):Connect(function() if not tp.Visible then closeDD() end end))
            table.insert(oc,UserInputService.InputBegan:Connect(function(input)
                if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
                    local pos=Vector2.new(input.Position.X,input.Position.Y)
                    if not isInside(btn,pos) and not isInside(list,pos) then closeDD() end
                end
            end))
        else closeDD() end
    end
    btn.MouseButton1Click:Connect(function() setOpen(not open) end)
    btn.MouseEnter:Connect(function() tween(btn,{BackgroundColor3=C.ElementHover}) end)
    btn.MouseLeave:Connect(function() tween(btn,{BackgroundColor3=C.Element}) end)
    return registerFlag(opts.Flag, "dropdown", {
        Set=function(_,o) value=o; vl.Text=tostring(o) end, Get=function() return value end,
        SetOptions=function(_,no)
            co=no or {}; local se=false
            for _,o in ipairs(co) do if o==value then se=true; break end end
            if not se and co[1] then value=co[1]; vl.Text=tostring(value) end
            rebuild(); if open then tween(list,{Size=UDim2.new(0,LW,0,calcH())}) end
        end,
        Refresh=function() rebuild() end,
    })
end

function SubTab:AddMultiDropdown(opts)
    opts=opts or {}
    local options=opts.Options or {}
    local maxVisible=math.max(1,math.floor(opts.MaxVisible or 5)); local searchable=opts.Searchable==true
    local IH=22; local IP=2; local SH=26; local LW=160
    local selected={}
    if type(opts.Default)=="table" then for _,o in ipairs(opts.Default) do selected[o]=true end end
    local row=newRow(self._card,30); rowLabels(row,opts.Name or "Dropdown",opts.Description,130)
    local btn=make("TextButton",{Text="",Size=UDim2.fromOffset(120,22),AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,0,0.5,0),BackgroundColor3=C.Element,Parent=row})
    corner(btn,8)
    local vl=make("TextLabel",{Text="None",Font=Enum.Font.Gotham,TextSize=12,TextColor3=C.TextGray,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,BackgroundTransparency=1,Position=UDim2.fromOffset(8,0),Size=UDim2.new(1,-26,1,0),Parent=btn})
    sortIcon(btn)
    local win=self._window; local sp=self._page; local tp=self._tab._page
    local list=make("Frame",{Visible=false,Active=true,Position=UDim2.fromOffset(0,0),Size=UDim2.new(0,LW,0,0),BackgroundColor3=C.Element,BackgroundTransparency=0.08,ClipsDescendants=true,ZIndex=100,Parent=win.ScreenGui})
    corner(list,10);local listGlow=stroke(list,C.Accent);listGlow.Transparency=0.55;listGlow.Thickness=1; table.insert(win._noDrag,list)
    local sb; local fq=""
    if searchable then
        local sh=make("Frame",{Position=UDim2.fromOffset(4,4),Size=UDim2.new(1,-8,0,SH-4),BackgroundColor3=C.WindowBg,ZIndex=101,Parent=list}); corner(sh,4)
        sb=make("TextBox",{Text="",PlaceholderText="Search...",PlaceholderColor3=C.Placeholder,Font=Enum.Font.Gotham,TextSize=11,TextColor3=C.White,TextXAlignment=Enum.TextXAlignment.Left,BackgroundTransparency=1,ClearTextOnFocus=false,Position=UDim2.fromOffset(8,0),Size=UDim2.new(1,-16,1,0),ZIndex=102,Parent=sh})
    end
    local sf=make("ScrollingFrame",{Position=UDim2.fromOffset(0,searchable and SH or 0),Size=UDim2.new(1,0,1,searchable and -SH or 0),BackgroundTransparency=1,BorderSizePixel=0,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,ScrollingDirection=Enum.ScrollingDirection.Y,ScrollBarThickness=3,ScrollBarImageColor3=C.Border,ZIndex=101,Parent=list})
    pad(sf,4,4,4,4)
    make("UIListLayout",{FillDirection=Enum.FillDirection.Vertical,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,IP),Parent=sf})
    local open=false; local cg=0; local oc={}; local co=options; local ob={}
    local function selectedList()
        local out={}
        for _,o in ipairs(co) do if selected[o] then table.insert(out,o) end end
        return out
    end
    local function updateSummary()
        local sel=selectedList()
        if #sel==0 then vl.Text="None"
        elseif #sel<=2 then vl.Text=table.concat(sel,", ")
        else vl.Text=sel[1]..", +"..(#sel-1).." more" end
    end
    local function repo()
        local inset=GuiService:GetGuiInset(); local p,s=btn.AbsolutePosition,btn.AbsoluteSize
        list.Position=UDim2.fromOffset(p.X+inset.X+s.X-LW,p.Y+inset.Y+s.Y+4)
    end
    local function calcH()
        local fc=0; for _,o in ipairs(co) do if fq=="" or string.find(string.lower(tostring(o)),string.lower(fq),1,true) then fc=fc+1 end end
        local vc=math.min(math.max(fc,1),maxVisible)
        return vc*IH+math.max(vc-1,0)*IP+8+(searchable and SH or 0)
    end
    local function closeDD()
        if not open then return end; open=false; cg=cg+1
        for _,c in ipairs(oc) do c:Disconnect() end; table.clear(oc)
        tween(list,{Size=UDim2.new(0,LW,0,0)})
        local g=cg; task.delay(0.16,function() if g==cg and not open then list.Visible=false end end)
    end
    local function rebuild()
        for _,b in ipairs(ob) do if b and b.Parent then b:Destroy() end end; table.clear(ob)
        for _,o in ipairs(co) do
            local os=tostring(o)
            if fq=="" or string.find(string.lower(os),string.lower(fq),1,true) then
                local isSel=selected[o]==true
                local ob2=make("TextButton",{Text="",Size=UDim2.new(1,-8,0,IH),BackgroundColor3=isSel and C.Accent or C.Element,BackgroundTransparency=isSel and 0.82 or 0,Parent=sf})
                autoOrder(ob2);corner(ob2,4)
                local box=make("Frame",{AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,8,0.5,0),Size=UDim2.fromOffset(13,13),BackgroundColor3=isSel and C.Accent or C.Badge,Parent=ob2})
                corner(box,4)
                local boxScale=make("UIScale",{Scale=1,Parent=box})
                local check=make("TextLabel",{Text="✓",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.AccentText,BackgroundTransparency=1,Size=UDim2.fromScale(1,1),Visible=isSel,Parent=box})
                make("TextLabel",{Text=os,Font=isSel and Enum.Font.GothamBold or Enum.Font.Gotham,TextSize=12,TextColor3=isSel and C.White or C.TextGray,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,BackgroundTransparency=1,Position=UDim2.fromOffset(27,0),Size=UDim2.new(1,-33,1,0),Parent=ob2})
                ob2.MouseEnter:Connect(function() if not selected[o] then tween(ob2,{BackgroundColor3=C.ElementHover}) end end)
                ob2.MouseLeave:Connect(function() if not selected[o] then tween(ob2,{BackgroundColor3=C.Element}) end end)
                ob2.MouseButton1Click:Connect(function()
                    selected[o]=not selected[o] or nil
                    local nowSel=selected[o]==true
                    tween(ob2,{BackgroundColor3=nowSel and C.Accent or C.Element,BackgroundTransparency=nowSel and 0.82 or 0})
                    tween(box,{BackgroundColor3=nowSel and C.Accent or C.Badge})
                    check.Visible=nowSel
                    boxScale.Scale=0.7; TweenService:Create(boxScale,TweenInfo.new(0.22,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Scale=1}):Play()
                    updateSummary(); fire(opts.Callback,selectedList())
                end)
                table.insert(ob,ob2)
            end
        end
    end
    if sb then sb:GetPropertyChangedSignal("Text"):Connect(function() fq=sb.Text; rebuild(); if open then tween(list,{Size=UDim2.new(0,LW,0,calcH())}) end end) end
    rebuild(); updateSummary()
    local function setOpen(o)
        if open==o then return end
        if o then
            open=true; cg=cg+1; repo(); list.Visible=true; tween(list,{Size=UDim2.new(0,LW,0,calcH())})
            table.insert(oc,btn:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
                local bp,bs=btn.AbsolutePosition,btn.AbsoluteSize; local pp,ps=sp.AbsolutePosition,sp.AbsoluteSize
                if bp.Y+bs.Y<pp.Y or bp.Y>pp.Y+ps.Y then closeDD() else repo() end
            end))
            table.insert(oc,sp:GetPropertyChangedSignal("Visible"):Connect(function() if not sp.Visible then closeDD() end end))
            table.insert(oc,tp:GetPropertyChangedSignal("Visible"):Connect(function() if not tp.Visible then closeDD() end end))
            table.insert(oc,UserInputService.InputBegan:Connect(function(input)
                if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
                    local pos=Vector2.new(input.Position.X,input.Position.Y)
                    if not isInside(btn,pos) and not isInside(list,pos) then closeDD() end
                end
            end))
        else closeDD() end
    end
    btn.MouseButton1Click:Connect(function() setOpen(not open) end)
    btn.MouseEnter:Connect(function() tween(btn,{BackgroundColor3=C.ElementHover}) end)
    btn.MouseLeave:Connect(function() tween(btn,{BackgroundColor3=C.Element}) end)
    return registerFlag(opts.Flag, "multidropdown", {
        Set=function(_,sel)
            table.clear(selected)
            if type(sel)=="table" then for _,o in ipairs(sel) do selected[o]=true end end
            rebuild(); updateSummary()
        end,
        Get=function() return selectedList() end,
        SetOptions=function(_,no)
            co=no or {}
            for o in pairs(selected) do
                local still=false
                for _,n in ipairs(co) do if n==o then still=true; break end end
                if not still then selected[o]=nil end
            end
            rebuild(); updateSummary(); if open then tween(list,{Size=UDim2.new(0,LW,0,calcH())}) end
        end,
        Refresh=function() rebuild(); updateSummary() end,
    })
end

-- ════════════════════════════════════════════════════════════════════════════
-- COLOR HELPERS
-- ════════════════════════════════════════════════════════════════════════════
local function colorToHex(c)
    return string.format("#%02X%02X%02X",
        math.floor(c.R*255+0.5), math.floor(c.G*255+0.5), math.floor(c.B*255+0.5))
end
local function hexToColor(hex)
    hex = tostring(hex or ""):gsub("#","")
    if #hex ~= 6 then return nil end
    local r = tonumber(hex:sub(1,2),16)
    local g = tonumber(hex:sub(3,4),16)
    local b = tonumber(hex:sub(5,6),16)
    if not (r and g and b) then return nil end
    return Color3.fromRGB(r,g,b)
end

function SubTab:AddSlider(opts)
    opts=opts or {}
    local mn=opts.Min or 0; local mx=opts.Max or 100; local sf=opts.Suffix or ""
    local value=math.clamp(opts.Default or mn,mn,mx)
    local row=newRow(self._card,32)
    make("TextLabel",{Text=opts.Name or "Slider",Font=Enum.Font.GothamMedium,TextSize=13,TextColor3=C.White,TextXAlignment=Enum.TextXAlignment.Left,BackgroundTransparency=1,Position=UDim2.fromOffset(0,0),Size=UDim2.new(0.6,0,0,14),Parent=row})
    local vl=make("TextLabel",{Text=tostring(value)..sf,Font=Enum.Font.Gotham,TextSize=11,TextColor3=C.TextDim,TextXAlignment=Enum.TextXAlignment.Right,BackgroundTransparency=1,Position=UDim2.fromOffset(0,1),Size=UDim2.new(1,0,0,13),Parent=row})
    local track=make("Frame",{Position=UDim2.fromOffset(0,24),Size=UDim2.new(1,0,0,4),BackgroundColor3=C.TrackBg,Parent=row}); circle(track)
    local fill=make("Frame",{Size=UDim2.new(0,0,1,0),BackgroundColor3=C.Accent,Parent=track}); circle(fill)
    local fillGlow=make("UIStroke",{Color=C.Accent,Thickness=2,Transparency=1,ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=fill})
    local knob=make("Frame",{Size=UDim2.fromOffset(12,12),AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0,0,0.5,0),BackgroundColor3=C.White,ZIndex=2,Parent=track}); circle(knob); stroke(knob,C.Accent)
    local knobScale=make("UIScale",{Scale=1,Parent=knob})
    local hit=make("TextButton",{Text="",BackgroundTransparency=1,Position=UDim2.new(0,-6,0,16),Size=UDim2.new(1,12,0,20),Parent=row})
    local function apply(v,a,fc)
        value=math.clamp(math.floor(v+0.5),mn,mx)
        local pct=mx>mn and (value-mn)/(mx-mn) or 0; vl.Text=tostring(value)..sf
        if a then tween(fill,{Size=UDim2.new(pct,0,1,0)}); tween(knob,{Position=UDim2.new(pct,0,0.5,0)})
        else fill.Size=UDim2.new(pct,0,1,0); knob.Position=UDim2.new(pct,0,0.5,0) end
        if fc then fire(opts.Callback,value) end
    end
    local function fromX(x) return mn+(mx-mn)*math.clamp((x-track.AbsolutePosition.X)/math.max(track.AbsoluteSize.X,1),0,1) end
    local dragging=false
    local DRAG_TWEEN=TweenInfo.new(0.14,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
    hit.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            dragging=true; apply(fromX(i.Position.X),true,true)
            TweenService:Create(knobScale,DRAG_TWEEN,{Scale=1.35}):Play()
            TweenService:Create(fillGlow,DRAG_TWEEN,{Transparency=0.5}):Play()
        end
    end)
    trackConn(self._window, UserInputService.InputChanged:Connect(function(i) if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then apply(fromX(i.Position.X),true,true) end end))
    trackConn(self._window, UserInputService.InputEnded:Connect(function(i)
        if dragging and (i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch) then
            dragging=false
            TweenService:Create(knobScale,DRAG_TWEEN,{Scale=1}):Play()
            TweenService:Create(fillGlow,DRAG_TWEEN,{Transparency=1}):Play()
        end
    end))
    apply(value,false,false)
    return registerFlag(opts.Flag, "slider", {Set=function(_,v) apply(v,true,true) end, Get=function() return value end})
end

local function hsvToColor(h,s,v) return Color3.fromHSV(h,s,v) end
local function colorToHSV(c) return c:ToHSV() end

function SubTab:AddColorPicker(opts)
    opts=opts or {}
    local value = (typeof(opts.Default)=="Color3" and opts.Default) or hexToColor(opts.Default) or Color3.fromRGB(255,255,255)
    local h,s,v = colorToHSV(value)
    local row=newRow(self._card,30); rowLabels(row,opts.Name or "Color",opts.Description,44)

    local swatch=make("TextButton",{Text="",Size=UDim2.fromOffset(34,18),AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,0,0.5,0),BackgroundColor3=value,Parent=row})
    corner(swatch,5);stroke(swatch,C.Border)

    local win=self._window; local sp=self._page; local tp=self._tab._page
    local PW=200
    local panel=make("Frame",{Visible=false,Active=true,Size=UDim2.fromOffset(PW,0),BackgroundColor3=C.Element,BackgroundTransparency=0.08,ClipsDescendants=true,ZIndex=100,Parent=win.ScreenGui})
    corner(panel,10);local panelGlow=stroke(panel,C.Accent);panelGlow.Transparency=0.55;panelGlow.Thickness=1; table.insert(win._noDrag,panel)
    local inner=make("Frame",{Position=UDim2.fromOffset(0,0),Size=UDim2.fromOffset(PW,168),BackgroundTransparency=1,ZIndex=101,Parent=panel})
    pad(inner,10,10,10,10)

    local svBox=make("Frame",{Position=UDim2.fromOffset(0,0),Size=UDim2.new(1,0,0,110),BackgroundColor3=hsvToColor(h,1,1),ZIndex=101,Parent=inner})
    corner(svBox,4)
    make("UIGradient",{Color=ColorSequence.new(Color3.new(1,1,1),hsvToColor(h,1,1)),Parent=svBox})
    local svBlack=make("Frame",{Size=UDim2.fromScale(1,1),BackgroundColor3=Color3.new(0,0,0),ZIndex=102,Parent=svBox}); corner(svBlack,4)
    make("UIGradient",{Rotation=90,Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(1,0)}),Parent=svBlack})
    local svCursor=make("Frame",{AnchorPoint=Vector2.new(0.5,0.5),Size=UDim2.fromOffset(8,8),BackgroundColor3=Color3.new(1,1,1),ZIndex=103,Parent=svBox}); circle(svCursor); stroke(svCursor,Color3.new(0,0,0))
    local svHit=make("TextButton",{Text="",BackgroundTransparency=1,Size=UDim2.fromScale(1,1),ZIndex=104,Parent=svBox})

    local hueBox=make("Frame",{Position=UDim2.fromOffset(0,118),Size=UDim2.new(1,0,0,12),BackgroundColor3=Color3.new(1,1,1),ZIndex=101,Parent=inner})
    corner(hueBox,4)
    make("UIGradient",{Color=ColorSequence.new({
        ColorSequenceKeypoint.new(0.00,Color3.fromRGB(255,0,0)),
        ColorSequenceKeypoint.new(0.17,Color3.fromRGB(255,255,0)),
        ColorSequenceKeypoint.new(0.33,Color3.fromRGB(0,255,0)),
        ColorSequenceKeypoint.new(0.50,Color3.fromRGB(0,255,255)),
        ColorSequenceKeypoint.new(0.67,Color3.fromRGB(0,0,255)),
        ColorSequenceKeypoint.new(0.83,Color3.fromRGB(255,0,255)),
        ColorSequenceKeypoint.new(1.00,Color3.fromRGB(255,0,0)),
    }),Parent=hueBox})
    local hueCursor=make("Frame",{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0,0,0.5,0),Size=UDim2.fromOffset(4,16),BackgroundColor3=Color3.new(1,1,1),ZIndex=103,Parent=hueBox}); corner(hueCursor,2); stroke(hueCursor,Color3.new(0,0,0))
    local hueHit=make("TextButton",{Text="",BackgroundTransparency=1,Position=UDim2.fromOffset(0,-4),Size=UDim2.new(1,0,0,20),ZIndex=104,Parent=hueBox})

    local hexHolder=make("Frame",{Position=UDim2.fromOffset(0,140),Size=UDim2.new(1,0,0,22),BackgroundColor3=C.WindowBg,ZIndex=101,Parent=inner}); corner(hexHolder,5)
    local hexBox=make("TextBox",{Text=colorToHex(value),PlaceholderText="#FFFFFF",PlaceholderColor3=C.Placeholder,Font=Enum.Font.Gotham,TextSize=11,TextColor3=C.White,TextXAlignment=Enum.TextXAlignment.Center,BackgroundTransparency=1,ClearTextOnFocus=false,Size=UDim2.fromScale(1,1),ZIndex=102,Parent=hexHolder})

    local function applyVisuals(a)
        local hueColor=hsvToColor(h,1,1)
        if a then tween(swatch,{BackgroundColor3=value}) else swatch.BackgroundColor3=value end
        svBox.BackgroundColor3=hueColor
        for _,g in ipairs(svBox:GetChildren()) do if g:IsA("UIGradient") and g.Parent==svBox then g.Color=ColorSequence.new(Color3.new(1,1,1),hueColor) end end
        svCursor.Position=UDim2.new(s,0,1-v,0)
        svCursor.BackgroundColor3 = v>0.5 and Color3.new(0,0,0) or Color3.new(1,1,1)
        hueCursor.Position=UDim2.new(h,0,0.5,0)
        hexBox.Text=colorToHex(value)
    end
    local function recompute(fc,a)
        value=hsvToColor(h,s,v); applyVisuals(a)
        if fc then fire(opts.Callback,value) end
    end

    local svDragging=false; local hueDragging=false
    local function svFrom(px,py)
        local p,sz=svBox.AbsolutePosition,svBox.AbsoluteSize
        s=math.clamp((px-p.X)/math.max(sz.X,1),0,1)
        v=1-math.clamp((py-p.Y)/math.max(sz.Y,1),0,1)
    end
    local function hueFrom(px)
        local p,sz=hueBox.AbsolutePosition,hueBox.AbsoluteSize
        h=math.clamp((px-p.X)/math.max(sz.X,1),0,1)
    end
    svHit.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then svDragging=true; svFrom(i.Position.X,i.Position.Y); recompute(true,false) end end)
    hueHit.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then hueDragging=true; hueFrom(i.Position.X); recompute(true,false) end end)
    local moveConn=UserInputService.InputChanged:Connect(function(i)
        if i.UserInputType~=Enum.UserInputType.MouseMovement and i.UserInputType~=Enum.UserInputType.Touch then return end
        if svDragging then svFrom(i.Position.X,i.Position.Y); recompute(true,false)
        elseif hueDragging then hueFrom(i.Position.X); recompute(true,false) end
    end)
    local endConn=UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then svDragging=false; hueDragging=false end
    end)
    hexBox.FocusLost:Connect(function()
        local c=hexToColor(hexBox.Text)
        if c then value=c; h,s,v=colorToHSV(c); recompute(true,true) else hexBox.Text=colorToHex(value) end
    end)

    local open=false; local cg=0; local oc={}
    local function repo()
        local inset=GuiService:GetGuiInset(); local p,sz=swatch.AbsolutePosition,swatch.AbsoluteSize
        panel.Position=UDim2.fromOffset(p.X+inset.X+sz.X-PW,p.Y+inset.Y+sz.Y+4)
    end
    local function closePanel()
        if not open then return end; open=false; cg=cg+1
        for _,c in ipairs(oc) do c:Disconnect() end; table.clear(oc)
        tween(panel,{Size=UDim2.fromOffset(PW,0)})
        local g=cg; task.delay(0.16,function() if g==cg and not open then panel.Visible=false end end)
    end
    local function setOpen(o)
        if open==o then return end
        if o then
            open=true; cg=cg+1; repo(); panel.Visible=true; tween(panel,{Size=UDim2.fromOffset(PW,168)})
            table.insert(oc,swatch:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
                local bp,bs=swatch.AbsolutePosition,swatch.AbsoluteSize; local pp,ps=sp.AbsolutePosition,sp.AbsoluteSize
                if bp.Y+bs.Y<pp.Y or bp.Y>pp.Y+ps.Y then closePanel() else repo() end
            end))
            table.insert(oc,sp:GetPropertyChangedSignal("Visible"):Connect(function() if not sp.Visible then closePanel() end end))
            table.insert(oc,tp:GetPropertyChangedSignal("Visible"):Connect(function() if not tp.Visible then closePanel() end end))
            table.insert(oc,UserInputService.InputBegan:Connect(function(input)
                if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
                    local pos=Vector2.new(input.Position.X,input.Position.Y)
                    if not isInside(swatch,pos) and not isInside(panel,pos) then closePanel() end
                end
            end))
        else closePanel() end
    end
    swatch.MouseButton1Click:Connect(function() setOpen(not open) end)
    swatch.MouseEnter:Connect(function() tween(swatch,{BackgroundColor3=value}) end)
    recompute(false,false)
    trackConn(self._window, moveConn)
    trackConn(self._window, endConn)
    return registerFlag(opts.Flag, "color", {
        Set=function(_,c)
            c=(typeof(c)=="Color3" and c) or hexToColor(c)
            if not c then return end
            value=c; h,s,v=colorToHSV(c); recompute(false,true)
        end,
        Get=function() return value end,
        GetHex=function() return colorToHex(value) end,
        _connections={moveConn,endConn},
    })
end

return Library
