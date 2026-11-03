-- Share the registered toolbar bitmap with the KevD dashboard.
local system = system
local headerBridge = loadfile("SCRIPTS:/rfsuite/widgets/dashboard/themes/kevd/header_bridge.lua")
if headerBridge then
    system = setmetatable({registerTheme = headerBridge().registerTheme}, {__index = system})
end

-- Installed by Theme Studio for Ethos. Ethos 26.x.
local function init()
system.registerTheme({
    key = "PUIMA",
    name = " Pu RFs",
        -- studio-preview: previews/pu-rfs.png
    roundButtons = true,
    focusStyle = "outline",
    borderWidth = 4,
    darkMode = false,
    colors = {
        lcd.RGB(24, 16, 16),       -- PRIMARY_COLOR (Black)
        lcd.RGB(201, 195, 189),    -- SECONDARY_BGCOLOR (Soft Navy #678BC1)
        lcd.RGB(32, 176, 212),      -- HIGHLIGHT_COLOR (Mostly desaturated dark blue  #55677c)
        lcd.RGB(173, 230, 165),       -- HIGHLIGHT_INVERT_COLOR ( Chilean Fire #F97904)
        lcd.RGB(245, 164, 125),     -- DISABLE_COLOR (sweet line #F0C667)
        lcd.RGB(255, 255, 255),    -- PRIMARY_BGCOLOR (White #ffffff)
        lcd.GREY(0x60),            -- OVERLAY_COLOR
        lcd.RGB(250, 39, 0),    -- SECONDARY_color (Glossy Coral #FA8567)
        lcd.RGB(53, 121, 248), -- SAFE_COLOR (white)
        lcd.RGB(240, 193, 165),    -- PAGE_BGCOLOR (Light Sky Blue #B2E4FF)
        lcd.RGB(0x8B, 0x00, 0x15), -- ERROR_COLOR (system critical: red)
        lcd.RGB(0x00, 0xFF, 0xCC), -- ACTIVE_COLOR (cyan n�on)
        lcd.RGB(0xC4, 0xAE, 0xFF), -- INACTIVE_COLOR (lavande)
        lcd.RGB(0xFF, 0x00, 0xCC), -- BUTTON_BORDER_ACTIVE_COLOR (magenta n�on)
        lcd.RGB(250, 39, 0),      -- BUTTON_BORDER_COLOR (Mostly desaturated dark blue #55677c)
        lcd.RGB(0x8A, 0x43, 0x00), -- WARNING_COLOR (system warning: amber)
        lcd.RGB(0, 0, 0),          -- SAFE_CONTRASTING_COLOR
        BLACK,                     -- TOPLCD_BGCOLOR (XE/S)
        },
        toolbarLogo ="none",
        toolbarBackground = lcd.loadBitmap("header-pu-rfs.png")
    })

system.registerTheme({
    key = "yello",
    name = "Yelo Rfs",
        -- studio-preview: previews/yelo-rfs.png
    roundButtons = true,
    focusStyle = "invert",
    borderWidth = 4,
    darkMode = false,
    colors = {
        lcd.RGB(24, 16, 16),       -- PRIMARY_COLOR (Black)
        lcd.RGB(224, 224, 228),    -- SECONDARY_BGCOLOR (Soft Navy #678BC1)
        lcd.RGB(32, 176, 212),      -- HIGHLIGHT_COLOR (Mostly desaturated dark blue  #55677c)
        lcd.RGB(24, 16, 16),       -- HIGHLIGHT_INVERT_COLOR ( Chilean Fire #F97904)
        lcd.RGB(101, 121, 153),     -- DISABLE_COLOR (sweet line #F0C667)
        lcd.RGB(244, 211, 56),     -- PRIMARY_BGCOLOR (Light Sky Blue #678bc1)
        lcd.GREY(0x60),            -- OVERLAY_COLOR
        lcd.RGB(227, 39, 39),      -- SECONDARY_color (Glossy Coral #FA8567)88, 109, 226
        lcd.RGB(32, 176, 212), -- SAFE_COLOR (white)
        lcd.RGB(43, 189, 97),    -- PAGE_BGCOLOR (Light Sky Blue #B2E4FF)
        lcd.RGB(0x8B, 0x00, 0x15), -- ERROR_COLOR (system critical: red)
        lcd.RGB(0x00, 0xFF, 0xCC), -- ACTIVE_COLOR (cyan n�on)
        lcd.RGB(0xC4, 0xAE, 0xFF), -- INACTIVE_COLOR (lavande)
        lcd.RGB(255, 0, 0),      -- BUTTON_BORDER_ACTIVE_COLOR (Top bar batt icon
        lcd.RGB(227, 39, 39),      -- BUTTON_BORDER_COLOR (Mostly desaturated dark blue #55677c)
        lcd.RGB(0x8A, 0x43, 0x00), -- WARNING_COLOR (system warning: amber)
        lcd.RGB(0, 0, 0),          -- SAFE_CONTRASTING_COLOR
        BLACK,                     -- TOPLCD_BGCOLOR (XE/S)
        },
        toolbarLogo ="none",
        toolbarBackground = lcd.loadBitmap("header-yelo-rfs.png")
    })

system.registerTheme({
        key = "SilvFlm",
        name = "Silver Flame",
        -- studio-preview: previews/silver-flame.png
        darkMode = false,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0x20, 0x28, 0x2D), -- PRIMARY_COLOR: charcoal lettering
            lcd.RGB(0xD7, 0xDE, 0xDF), -- SECONDARY_BGCOLOR: brushed silver
            lcd.RGB(0xFF, 0x4B, 0x19), -- HIGHLIGHT_COLOR: orange-red stripe
            lcd.RGB(0x17, 0x1E, 0x22), -- HIGHLIGHT_CONTRASTING_COLOR: charcoal on orange
            lcd.RGB(0x7C, 0x89, 0x8F), -- DISABLE_COLOR: muted steel
            lcd.RGB(0xEF, 0xF2, 0xF0), -- PRIMARY_BGCOLOR: pearl silver
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0x24, 0x5E, 0x91), -- SECONDARY_COLOR: blue accent text
            lcd.RGB(0xDD, 0xF4, 0xE1), -- SAFE_COLOR (normal battery fill; contrasting text and outline)
            lcd.RGB(0xFA, 0xFB, 0xF9), -- PAGE_BGCOLOR: soft white
            lcd.RGB(0xA5, 0x10, 0x25), -- ERROR_COLOR: critical crimson
            lcd.RGB(0x00, 0x6D, 0xB5), -- ACTIVE_COLOR: vivid blue
            lcd.RGB(0x66, 0x74, 0x7C), -- INACTIVE_COLOR: slate grey
            lcd.RGB(0x00, 0x7F, 0xC3), -- BUTTON_BORDER_ACTIVE_COLOR (battery outline; contrasts with header)
            lcd.RGB(0x4F, 0x8F, 0xB8), -- BUTTON_BORDER_COLOR: steel blue
            lcd.RGB(0x86, 0x42, 0x00), -- WARNING_COLOR: dark amber
            lcd.RGB(0x17, 0x1E, 0x22), -- SAFE_CONTRASTING_COLOR: charcoal on lime
            lcd.RGB(0xEF, 0xF2, 0xF0), -- TOPLCD_BGCOLOR: pearl silver
        },
        toolbarBackground = lcd.loadBitmap("header-silver-flame.png"),
        toolbarLogo = "none",

    })

system.registerTheme({
        key = "VlvOrbt",
        name = "Velvet Orbit",
        -- studio-preview: previews/velvet-orbit.png
        darkMode = true,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0xF7, 0xEB, 0xFF), -- PRIMARY_COLOR: lilac white
            lcd.RGB(0x36, 0x27, 0x45), -- SECONDARY_BGCOLOR: velvet plum
            lcd.RGB(0xD0, 0xAF, 0xFF), -- HIGHLIGHT_COLOR: luminous lilac
            lcd.RGB(0x23, 0x12, 0x33), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x83, 0x70, 0x91), -- DISABLE_COLOR
            lcd.RGB(0x20, 0x16, 0x2B), -- PRIMARY_BGCOLOR: aubergine
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0xEF, 0xB4, 0xD0), -- SECONDARY_COLOR: dusty rose
            lcd.RGB(0x32, 0x6B, 0x91), -- SAFE_COLOR (normal battery fill; contrasting text and outline)
            lcd.RGB(0x12, 0x0C, 0x1B), -- PAGE_BGCOLOR: deep violet
            lcd.RGB(0xFF, 0x7C, 0x87), -- ERROR_COLOR
            lcd.RGB(0xD0, 0xAF, 0xFF), -- ACTIVE_COLOR
            lcd.RGB(0xAD, 0x96, 0xBC), -- INACTIVE_COLOR
            lcd.RGB(0xF2, 0xAA, 0xCF), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0x70, 0x50, 0x89), -- BUTTON_BORDER_COLOR
            lcd.RGB(0xFF, 0xD0, 0x7D), -- WARNING_COLOR
            lcd.RGB(0x20, 0x2C, 0x12), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0x12, 0x0C, 0x1B), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-velvet-orbit.png"),
        toolbarLogo = "none",

    })

system.registerTheme({
        key = "SolarIk",
        name = "Solar Ink",
        -- studio-preview: previews/solar-ink.png
        darkMode = false,
        roundButtons = false,
        focusStyle = "invert",
        borderWidth = 4,
        colors = {
            lcd.RGB(0x14, 0x14, 0x00), -- PRIMARY_COLOR
            lcd.RGB(0xFF, 0xF0, 0x9A), -- SECONDARY_BGCOLOR
            lcd.RGB(0x14, 0x14, 0x00), -- HIGHLIGHT_COLOR
            lcd.RGB(0xFF, 0xF7, 0xCE), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x6E, 0x65, 0x0C), -- DISABLE_COLOR
            lcd.RGB(0xFF, 0xF9, 0xD9), -- PRIMARY_BGCOLOR
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0x49, 0x38, 0x00), -- SECONDARY_COLOR
            lcd.RGB(0x8E, 0xD9, 0x9C), -- SAFE_COLOR (normal battery fill; contrasting text and outline)
            lcd.RGB(0xFF, 0xFE, 0xF0), -- PAGE_BGCOLOR
            lcd.RGB(0x8E, 0x08, 0x20), -- ERROR_COLOR
            lcd.RGB(0x14, 0x14, 0x00), -- ACTIVE_COLOR
            lcd.RGB(0x51, 0x4A, 0x14), -- INACTIVE_COLOR
            lcd.RGB(0x14, 0x14, 0x00), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0x62, 0x54, 0x00), -- BUTTON_BORDER_COLOR
            lcd.RGB(0x66, 0x38, 0x00), -- WARNING_COLOR
            lcd.RGB(0xFF, 0xFF, 0xFF), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0xFF, 0xF0, 0x9A), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-solar-ink.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        key = "ArctRdr",
        name = "Arctic Radar",
        -- studio-preview: previews/arctic-radar.png
        darkMode = true,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 4,
        colors = {
            lcd.RGB(0xED, 0xFF, 0xFF), -- PRIMARY_COLOR
            lcd.RGB(0x10, 0x2A, 0x36), -- SECONDARY_BGCOLOR
            lcd.RGB(0x70, 0xF3, 0xFF), -- HIGHLIGHT_COLOR
            lcd.RGB(0x00, 0x15, 0x1B), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x7D, 0x9A, 0xA5), -- DISABLE_COLOR
            lcd.RGB(0x04, 0x10, 0x19), -- PRIMARY_BGCOLOR
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0xB8, 0xE5, 0xF0), -- SECONDARY_COLOR
            lcd.RGB(0x38, 0x77, 0xA2), -- SAFE_COLOR (normal battery fill; contrasting text and outline)
            lcd.RGB(0x01, 0x08, 0x0D), -- PAGE_BGCOLOR
            lcd.RGB(0xFF, 0xAD, 0xB8), -- ERROR_COLOR
            lcd.RGB(0x70, 0xF3, 0xFF), -- ACTIVE_COLOR
            lcd.RGB(0xA0, 0xC0, 0xCA), -- INACTIVE_COLOR
            lcd.RGB(0x70, 0xF3, 0xFF), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0x64, 0x8A, 0x99), -- BUTTON_BORDER_COLOR
            lcd.RGB(0xFF, 0xD8, 0xA1), -- WARNING_COLOR
            lcd.RGB(0x13, 0x20, 0x00), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0x04, 0x10, 0x19), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-arctic-radar.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        key = "FourRnb",
        name = "4 Color Rainbow",
        -- studio-preview: previews/4-color-rainbow.png
        darkMode = true,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0xFF, 0xFF, 0xFF), -- PRIMARY_COLOR
            lcd.RGB(0x20, 0x1A, 0x72), -- SECONDARY_BGCOLOR
            lcd.RGB(0xF2, 0xDE, 0x18), -- HIGHLIGHT_COLOR
            lcd.RGB(0x1C, 0x19, 0x40), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x95, 0x89, 0xB0), -- DISABLE_COLOR
            lcd.RGB(0x10, 0x10, 0x44), -- PRIMARY_BGCOLOR
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0xFF, 0xF2, 0x8C), -- SECONDARY_COLOR
            lcd.RGB(0x3A, 0x7B, 0xA7), -- SAFE_COLOR (normal battery fill; contrasting text and outline)
            lcd.RGB(0x09, 0x09, 0x2D), -- PAGE_BGCOLOR
            lcd.RGB(0xFF, 0xA4, 0xAC), -- ERROR_COLOR
            lcd.RGB(0x62, 0xE8, 0x62), -- ACTIVE_COLOR
            lcd.RGB(0xB9, 0xAD, 0xCF), -- INACTIVE_COLOR
            lcd.RGB(0xF2, 0xDE, 0x18), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0x20, 0xBC, 0x20), -- BUTTON_BORDER_COLOR
            lcd.RGB(0xFF, 0xD0, 0x80), -- WARNING_COLOR
            lcd.RGB(0x10, 0x2C, 0x1A), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0x10, 0x10, 0x44), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-4-color-rainbow.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        key = "RCP01",
        name = "RC Pilot Rangoli",
        -- studio-preview: previews/rc-pilot-rangoli.png
        darkMode = true,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0xFF, 0xF8, 0xEB), -- PRIMARY_COLOR
            lcd.RGB(0x30, 0x20, 0x5A), -- SECONDARY_BGCOLOR
            lcd.RGB(0xF7, 0xC3, 0x13), -- HIGHLIGHT_COLOR
            lcd.RGB(0x21, 0x10, 0x37), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x9D, 0x8E, 0xB7), -- DISABLE_COLOR
            lcd.RGB(0x17, 0x0D, 0x39), -- PRIMARY_BGCOLOR
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0xFF, 0xC9, 0xEB), -- SECONDARY_COLOR
            lcd.RGB(0x36, 0x73, 0x9C), -- SAFE_COLOR (normal battery fill; contrasting text and outline)
            lcd.RGB(0x10, 0x10, 0x2B), -- PAGE_BGCOLOR
            lcd.RGB(0xFF, 0xAD, 0xB5), -- ERROR_COLOR
            lcd.RGB(0xED, 0x0B, 0x8E), -- ACTIVE_COLOR
            lcd.RGB(0xC2, 0xC5, 0xD5), -- INACTIVE_COLOR
            lcd.RGB(0xF7, 0xC3, 0x13), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0xA5, 0x00, 0xC5), -- BUTTON_BORDER_COLOR
            lcd.RGB(0xFF, 0xD1, 0x8B), -- WARNING_COLOR
            lcd.RGB(0x10, 0x26, 0x19), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0x17, 0x0D, 0x39), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-rc-pilot-rangoli.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        key = "RCP02",
        name = "RC Pilot Electric",
        -- studio-preview: previews/rc-pilot-electric.png
        darkMode = true,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0xFF, 0xFF, 0xFF), -- PRIMARY_COLOR
            lcd.RGB(0x14, 0x26, 0x5A), -- SECONDARY_BGCOLOR
            lcd.RGB(0x00, 0xCE, 0xD1), -- HIGHLIGHT_COLOR
            lcd.RGB(0x06, 0x1C, 0x29), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x93, 0x9F, 0xC0), -- DISABLE_COLOR
            lcd.RGB(0x09, 0x14, 0x35), -- PRIMARY_BGCOLOR
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0xB8, 0xF4, 0xFF), -- SECONDARY_COLOR
            lcd.RGB(0x31, 0x67, 0x8C), -- SAFE_COLOR (normal battery fill; contrasting text and outline)
            lcd.RGB(0x05, 0x0B, 0x22), -- PAGE_BGCOLOR
            lcd.RGB(0xFF, 0xAD, 0xB5), -- ERROR_COLOR
            lcd.RGB(0xFF, 0xFF, 0x00), -- ACTIVE_COLOR
            lcd.RGB(0xC2, 0xC5, 0xD5), -- INACTIVE_COLOR
            lcd.RGB(0x00, 0xCE, 0xD1), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0xD0, 0x00, 0xF5), -- BUTTON_BORDER_COLOR
            lcd.RGB(0xFF, 0xD1, 0x8B), -- WARNING_COLOR
            lcd.RGB(0x10, 0x26, 0x19), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0x09, 0x14, 0x35), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-rc-pilot-electric.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        key = "RCP03",
        name = "RC Pilot Steel",
        -- studio-preview: previews/rc-pilot-steel.png
        darkMode = true,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0xFF, 0xFF, 0xFF), -- PRIMARY_COLOR
            lcd.RGB(0x40, 0x51, 0x8C), -- SECONDARY_BGCOLOR
            lcd.RGB(0xB6, 0x9D, 0x4F), -- HIGHLIGHT_COLOR
            lcd.RGB(0x17, 0x1C, 0x2B), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0xA0, 0xA7, 0xBD), -- DISABLE_COLOR
            lcd.RGB(0x24, 0x26, 0x2D), -- PRIMARY_BGCOLOR
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0xE6, 0xD4, 0x9A), -- SECONDARY_COLOR
            lcd.RGB(0x27, 0x53, 0x71), -- SAFE_COLOR (normal battery fill; contrasting text and outline)
            lcd.RGB(0x18, 0x1B, 0x22), -- PAGE_BGCOLOR
            lcd.RGB(0xFF, 0xAD, 0xB5), -- ERROR_COLOR
            lcd.RGB(0xC5, 0xC5, 0xC5), -- ACTIVE_COLOR
            lcd.RGB(0xC2, 0xC5, 0xD5), -- INACTIVE_COLOR
            lcd.RGB(0xB6, 0x9D, 0x4F), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0xB6, 0x9D, 0x4F), -- BUTTON_BORDER_COLOR
            lcd.RGB(0xFF, 0xD1, 0x8B), -- WARNING_COLOR
            lcd.RGB(0x10, 0x26, 0x19), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0x24, 0x26, 0x2D), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-rc-pilot-steel.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        key = "RCP04",
        name = "RC Pilot Rustic",
        -- studio-preview: previews/rc-pilot-rustic.png
        darkMode = true,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0xFF, 0xF5, 0xE8), -- PRIMARY_COLOR
            lcd.RGB(0x49, 0x47, 0x73), -- SECONDARY_BGCOLOR
            lcd.RGB(0xCF, 0xB5, 0x9D), -- HIGHLIGHT_COLOR
            lcd.RGB(0x2B, 0x19, 0x14), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0xB8, 0xA1, 0x9B), -- DISABLE_COLOR
            lcd.RGB(0x33, 0x20, 0x19), -- PRIMARY_BGCOLOR
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0xEA, 0xD5, 0xC5), -- SECONDARY_COLOR
            lcd.RGB(0x31, 0x67, 0x8C), -- SAFE_COLOR (normal battery fill; contrasting text and outline)
            lcd.RGB(0x24, 0x15, 0x11), -- PAGE_BGCOLOR
            lcd.RGB(0xFF, 0xAD, 0xB5), -- ERROR_COLOR
            lcd.RGB(0xCF, 0xB5, 0x9D), -- ACTIVE_COLOR
            lcd.RGB(0xC2, 0xC5, 0xD5), -- INACTIVE_COLOR
            lcd.RGB(0xCF, 0xB5, 0x9D), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0x85, 0x5B, 0x4B), -- BUTTON_BORDER_COLOR
            lcd.RGB(0xFF, 0xD1, 0x8B), -- WARNING_COLOR
            lcd.RGB(0x10, 0x26, 0x19), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0x33, 0x20, 0x19), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-rc-pilot-rustic.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        key = "RCP05",
        name = "RC Pilot Rainbow",
        -- studio-preview: previews/rc-pilot-rainbow.png
        darkMode = true,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0xFF, 0xFF, 0xFF), -- PRIMARY_COLOR
            lcd.RGB(0x24, 0x20, 0x78), -- SECONDARY_BGCOLOR
            lcd.RGB(0xF2, 0xDE, 0x18), -- HIGHLIGHT_COLOR
            lcd.RGB(0x17, 0x14, 0x3E), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x93, 0x9F, 0xC0), -- DISABLE_COLOR
            lcd.RGB(0x10, 0x10, 0x3D), -- PRIMARY_BGCOLOR
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0xFF, 0xF2, 0xA0), -- SECONDARY_COLOR
            lcd.RGB(0x3A, 0x7B, 0xA7), -- SAFE_COLOR (normal battery fill; contrasting text and outline)
            lcd.RGB(0x08, 0x08, 0x24), -- PAGE_BGCOLOR
            lcd.RGB(0xFF, 0xAD, 0xB5), -- ERROR_COLOR
            lcd.RGB(0x65, 0xEB, 0x65), -- ACTIVE_COLOR
            lcd.RGB(0xC2, 0xC5, 0xD5), -- INACTIVE_COLOR
            lcd.RGB(0xF2, 0xDE, 0x18), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0xFF, 0x30, 0x25), -- BUTTON_BORDER_COLOR
            lcd.RGB(0xFF, 0xD1, 0x8B), -- WARNING_COLOR
            lcd.RGB(0x10, 0x26, 0x19), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0x10, 0x10, 0x3D), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-rc-pilot-rainbow.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        key = "RCP06",
        name = "RC Pilot Arctic",
        -- studio-preview: previews/rc-pilot-arctic.png
        darkMode = true,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0xF5, 0xF5, 0xF5), -- PRIMARY_COLOR
            lcd.RGB(0x30, 0x3F, 0x7C), -- SECONDARY_BGCOLOR
            lcd.RGB(0xC5, 0xC9, 0xEF), -- HIGHLIGHT_COLOR
            lcd.RGB(0x21, 0x19, 0x4D), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x94, 0x9B, 0xC3), -- DISABLE_COLOR
            lcd.RGB(0x21, 0x19, 0x4D), -- PRIMARY_BGCOLOR
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0xDD, 0xE1, 0xFF), -- SECONDARY_COLOR
            lcd.RGB(0x37, 0x75, 0x9F), -- SAFE_COLOR (normal battery fill; contrasting text and outline)
            lcd.RGB(0x15, 0x10, 0x31), -- PAGE_BGCOLOR
            lcd.RGB(0xFF, 0xAD, 0xB5), -- ERROR_COLOR
            lcd.RGB(0xC5, 0xC9, 0xEF), -- ACTIVE_COLOR
            lcd.RGB(0xC2, 0xC5, 0xD5), -- INACTIVE_COLOR
            lcd.RGB(0xC5, 0xC9, 0xEF), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0x7E, 0x83, 0xAF), -- BUTTON_BORDER_COLOR
            lcd.RGB(0xFF, 0xD1, 0x8B), -- WARNING_COLOR
            lcd.RGB(0x10, 0x26, 0x19), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0x21, 0x19, 0x4D), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-rc-pilot-arctic.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        key = "RCP07",
        name = "RC Pilot Heritage",
        -- studio-preview: previews/rc-pilot-heritage.png
        darkMode = false,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0x30, 0x23, 0x1E), -- PRIMARY_COLOR
            lcd.RGB(0xDD, 0xC5, 0xB7), -- SECONDARY_BGCOLOR
            lcd.RGB(0x37, 0x59, 0x7D), -- HIGHLIGHT_COLOR
            lcd.RGB(0xFF, 0xFF, 0xFF), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x88, 0x7B, 0x70), -- DISABLE_COLOR
            lcd.RGB(0xE8, 0xD4, 0xC9), -- PRIMARY_BGCOLOR
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0x80, 0x2A, 0x1E), -- SECONDARY_COLOR
            lcd.RGB(0x8E, 0xD9, 0x9C), -- SAFE_COLOR (normal battery fill; contrasting text and outline)
            lcd.RGB(0xF6, 0xEA, 0xE2), -- PAGE_BGCOLOR
            lcd.RGB(0x9C, 0x19, 0x2B), -- ERROR_COLOR
            lcd.RGB(0x31, 0x57, 0x3D), -- ACTIVE_COLOR
            lcd.RGB(0x5C, 0x60, 0x6D), -- INACTIVE_COLOR
            lcd.RGB(0x37, 0x59, 0x7D), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0xBC, 0x6D, 0x1B), -- BUTTON_BORDER_COLOR
            lcd.RGB(0x75, 0x40, 0x00), -- WARNING_COLOR
            lcd.RGB(0xFF, 0xFF, 0xFF), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0xE8, 0xD4, 0xC9), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-rc-pilot-heritage.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        key = "RCP08",
        name = "RC Pilot Steel Day",
        -- studio-preview: previews/rc-pilot-steel-day.png
        darkMode = false,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0x29, 0x2C, 0x35), -- PRIMARY_COLOR
            lcd.RGB(0xC5, 0xC5, 0xC5), -- SECONDARY_BGCOLOR
            lcd.RGB(0x40, 0x51, 0x8C), -- HIGHLIGHT_COLOR
            lcd.RGB(0xFF, 0xFF, 0xFF), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x77, 0x7B, 0x88), -- DISABLE_COLOR
            lcd.RGB(0xEE, 0xF0, 0xF3), -- PRIMARY_BGCOLOR
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0x5D, 0x4B, 0x15), -- SECONDARY_COLOR
            lcd.RGB(0x8E, 0xD9, 0x9C), -- SAFE_COLOR (normal battery fill; contrasting text and outline)
            lcd.RGB(0xFA, 0xFA, 0xFB), -- PAGE_BGCOLOR
            lcd.RGB(0x9C, 0x19, 0x2B), -- ERROR_COLOR
            lcd.RGB(0x40, 0x51, 0x8C), -- ACTIVE_COLOR
            lcd.RGB(0x5C, 0x60, 0x6D), -- INACTIVE_COLOR
            lcd.RGB(0x40, 0x51, 0x8C), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0xB6, 0x9D, 0x4F), -- BUTTON_BORDER_COLOR
            lcd.RGB(0x75, 0x40, 0x00), -- WARNING_COLOR
            lcd.RGB(0xFF, 0xFF, 0xFF), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0xEE, 0xF0, 0xF3), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-rc-pilot-steel-day.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        key = "STR7DK",
        name = "XL Stratos 700 Dark",
        -- studio-preview: previews/xl-stratos-700-dark.png
        darkMode = true,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0xF4, 0xF6, 0xF8), -- PRIMARY_COLOR
            lcd.RGB(0x3D, 0x43, 0x4B), -- SECONDARY_BGCOLOR
            lcd.RGB(0xFF, 0x92, 0x9F), -- HIGHLIGHT_COLOR
            lcd.RGB(0x35, 0x20, 0x28), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x93, 0x9D, 0xAA), -- DISABLE_COLOR
            lcd.RGB(0x27, 0x2B, 0x30), -- PRIMARY_BGCOLOR (matches header and page)
            lcd.RGB(0x55, 0x5D, 0x68), -- OVERLAY_COLOR
            lcd.RGB(0xFF, 0xBD, 0xC5), -- SECONDARY_COLOR
            lcd.RGB(0x37, 0x75, 0x9F), -- SAFE_COLOR (normal battery fill; contrasting text and outline)
            lcd.RGB(0x27, 0x2B, 0x30), -- PAGE_BGCOLOR
            lcd.RGB(0xFF, 0x9A, 0xAA), -- ERROR_COLOR
            lcd.RGB(0xFF, 0x92, 0x9F), -- ACTIVE_COLOR
            lcd.RGB(0xB3, 0xBD, 0xC9), -- INACTIVE_COLOR
            lcd.RGB(0xE5, 0xEA, 0xF0), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0x87, 0x93, 0xA2), -- BUTTON_BORDER_COLOR
            lcd.RGB(0xFF, 0xD0, 0x8A), -- WARNING_COLOR
            lcd.RGB(0x23, 0x55, 0x3A), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0x2E, 0x33, 0x39), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-xl-stratos-700-dark.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        key = "STR200",
        name = "XL Stratos 200",
        -- studio-preview: previews/xl-stratos-200.png
        darkMode = false,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0x35, 0x41, 0x50), -- PRIMARY_COLOR
            lcd.RGB(0xDD, 0xE1, 0xE7), -- SECONDARY_BGCOLOR
            lcd.RGB(0xB5, 0x00, 0x64), -- HIGHLIGHT_COLOR
            lcd.RGB(0xFF, 0xFF, 0xFF), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x7C, 0x85, 0x93), -- DISABLE_COLOR
            lcd.RGB(0xF4, 0xF5, 0xF7), -- PRIMARY_BGCOLOR
            lcd.RGB(0x82, 0x8D, 0x9B), -- OVERLAY_COLOR
            lcd.RGB(0xB5, 0x00, 0x64), -- SECONDARY_COLOR
            lcd.RGB(0x8E, 0xD9, 0x9C), -- SAFE_COLOR
            lcd.RGB(0xF4, 0xF5, 0xF7), -- PAGE_BGCOLOR
            lcd.RGB(0xAE, 0x20, 0x38), -- ERROR_COLOR
            lcd.RGB(0x68, 0x63, 0x00), -- ACTIVE_COLOR
            lcd.RGB(0x65, 0x72, 0x82), -- INACTIVE_COLOR
            lcd.RGB(0x8B, 0x00, 0x4D), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0x56, 0x64, 0x77), -- BUTTON_BORDER_COLOR
            lcd.RGB(0x85, 0x4D, 0x0B), -- WARNING_COLOR
            lcd.RGB(0x23, 0x55, 0x3A), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0xF4, 0xF5, 0xF7), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-xl-stratos-200.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        key = "ST2DRK",
        name = "XL Stratos 200 Dark",
        -- studio-preview: previews/xl-stratos-200-dark.png
        darkMode = true,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0xF4, 0xF6, 0xF8), -- PRIMARY_COLOR
            lcd.RGB(0x3D, 0x43, 0x4B), -- SECONDARY_BGCOLOR
            lcd.RGB(0xF2, 0xFF, 0x38), -- HIGHLIGHT_COLOR
            lcd.RGB(0x30, 0x31, 0x26), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x93, 0x9D, 0xAA), -- DISABLE_COLOR
            lcd.RGB(0x27, 0x2B, 0x30), -- PRIMARY_BGCOLOR
            lcd.RGB(0x55, 0x5D, 0x68), -- OVERLAY_COLOR
            lcd.RGB(0xFF, 0x8F, 0xC8), -- SECONDARY_COLOR
            lcd.RGB(0x2F, 0x63, 0x87), -- SAFE_COLOR (normal battery fill; contrasting text and outline)
            lcd.RGB(0x27, 0x2B, 0x30), -- PAGE_BGCOLOR
            lcd.RGB(0xFF, 0x9A, 0xAA), -- ERROR_COLOR
            lcd.RGB(0xFF, 0x8F, 0xC8), -- ACTIVE_COLOR
            lcd.RGB(0xB3, 0xBD, 0xC9), -- INACTIVE_COLOR
            lcd.RGB(0xE5, 0xEA, 0xF0), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0x87, 0x93, 0xA2), -- BUTTON_BORDER_COLOR
            lcd.RGB(0xFF, 0xD0, 0x8A), -- WARNING_COLOR
            lcd.RGB(0x23, 0x55, 0x3A), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0x27, 0x2B, 0x30), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-xl-stratos-200-dark.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        key = "SABPUM",
        name = "SAB IL Piuma",
        -- studio-preview: previews/sab-il-piuma.png
        darkMode = false,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0x30, 0x42, 0x53), -- PRIMARY_COLOR
            lcd.RGB(0xDC, 0xE2, 0xE9), -- SECONDARY_BGCOLOR
            lcd.RGB(0x13, 0x5B, 0xA4), -- HIGHLIGHT_COLOR
            lcd.RGB(0xFF, 0xFF, 0xFF), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x78, 0x84, 0x93), -- DISABLE_COLOR
            lcd.RGB(0xEE, 0xF1, 0xF4), -- PRIMARY_BGCOLOR
            lcd.RGB(0x82, 0x8D, 0x9B), -- OVERLAY_COLOR
            lcd.RGB(0x13, 0x5B, 0xA4), -- SECONDARY_COLOR
            lcd.RGB(0x8E, 0xD9, 0x9C), -- SAFE_COLOR
            lcd.RGB(0xEE, 0xF1, 0xF4), -- PAGE_BGCOLOR
            lcd.RGB(0xAE, 0x20, 0x38), -- ERROR_COLOR
            lcd.RGB(0x13, 0x5B, 0xA4), -- ACTIVE_COLOR
            lcd.RGB(0x65, 0x72, 0x82), -- INACTIVE_COLOR
            lcd.RGB(0x15, 0x4D, 0x80), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0x56, 0x64, 0x77), -- BUTTON_BORDER_COLOR
            lcd.RGB(0x85, 0x4D, 0x0B), -- WARNING_COLOR
            lcd.RGB(0x1F, 0x3D, 0x2B), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0xEE, 0xF1, 0xF4), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-sab-il-piuma.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        key = "SABPMD",
        name = "SAB IL Piuma Dark",
        -- studio-preview: previews/sab-il-piuma-dark.png
        darkMode = true,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0xF1, 0xF5, 0xFA), -- PRIMARY_COLOR
            lcd.RGB(0x3A, 0x45, 0x52), -- SECONDARY_BGCOLOR
            lcd.RGB(0xFF, 0x8A, 0x24), -- HIGHLIGHT_COLOR
            lcd.RGB(0x29, 0x2D, 0x33), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x98, 0xA5, 0xB5), -- DISABLE_COLOR
            lcd.RGB(0x29, 0x2F, 0x37), -- PRIMARY_BGCOLOR
            lcd.RGB(0x55, 0x61, 0x6F), -- OVERLAY_COLOR
            lcd.RGB(0x9B, 0xCA, 0xFF), -- SECONDARY_COLOR
            lcd.RGB(0x35, 0x6F, 0x97), -- SAFE_COLOR (normal battery fill; contrasting text and outline)
            lcd.RGB(0x29, 0x2F, 0x37), -- PAGE_BGCOLOR
            lcd.RGB(0xFF, 0x9A, 0xAA), -- ERROR_COLOR
            lcd.RGB(0x9B, 0xCA, 0xFF), -- ACTIVE_COLOR
            lcd.RGB(0xB3, 0xBD, 0xC9), -- INACTIVE_COLOR
            lcd.RGB(0xE8, 0xEE, 0xF5), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0x87, 0x97, 0xAA), -- BUTTON_BORDER_COLOR
            lcd.RGB(0xFF, 0xD0, 0x8A), -- WARNING_COLOR
            lcd.RGB(0x1F, 0x3D, 0x2B), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0x29, 0x2F, 0x37), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-sab-il-piuma-dark.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        key = "AMnCD",
        name = "AMain Carbon Dark",
        -- studio-preview: previews/amain-carbon-dark.png
        -- studio-branding: AMain
        darkMode = true,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0xF7, 0xFA, 0xFC), -- PRIMARY_COLOR
            lcd.RGB(0x29, 0x37, 0x44), -- SECONDARY_BGCOLOR
            lcd.RGB(0xFF, 0x68, 0x1B), -- HIGHLIGHT_COLOR
            lcd.RGB(0x17, 0x2A, 0x35), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x87, 0x99, 0xAA), -- DISABLE_COLOR
            lcd.RGB(0x13, 0x1C, 0x25), -- PRIMARY_BGCOLOR
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0xF8, 0x74, 0x18), -- SECONDARY_COLOR
            lcd.RGB(0x32, 0x6C, 0x96), -- SAFE_COLOR
            lcd.RGB(0x13, 0x1C, 0x25), -- PAGE_BGCOLOR
            lcd.RGB(0xB7, 0x3D, 0x4B), -- ERROR_COLOR
            lcd.RGB(0xFF, 0x68, 0x1B), -- ACTIVE_COLOR
            lcd.RGB(0x91, 0xA4, 0xB7), -- INACTIVE_COLOR
            lcd.RGB(0xF8, 0x74, 0x18), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0xF8, 0x74, 0x18), -- BUTTON_BORDER_COLOR
            lcd.RGB(0x98, 0x60, 0x00), -- WARNING_COLOR
            lcd.RGB(0xF7, 0xFA, 0xFC), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0x13, 0x1C, 0x25), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-amain-carbon-dark.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        key = "AMnBD",
        name = "AMain Cobalt Dark",
        -- studio-preview: previews/amain-cobalt-dark.png
        -- studio-branding: AMain
        darkMode = true,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0xFF, 0xFF, 0xFF), -- PRIMARY_COLOR
            lcd.RGB(0x18, 0x3C, 0x68), -- SECONDARY_BGCOLOR
            lcd.RGB(0xFF, 0x77, 0x1F), -- HIGHLIGHT_COLOR
            lcd.RGB(0x10, 0x29, 0x40), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x8B, 0xA8, 0xC9), -- DISABLE_COLOR
            lcd.RGB(0x09, 0x1D, 0x3B), -- PRIMARY_BGCOLOR
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0xF8, 0x74, 0x18), -- SECONDARY_COLOR
            lcd.RGB(0x2F, 0x63, 0x87), -- SAFE_COLOR
            lcd.RGB(0x09, 0x1D, 0x3B), -- PAGE_BGCOLOR
            lcd.RGB(0xB7, 0x3D, 0x4B), -- ERROR_COLOR
            lcd.RGB(0x47, 0x9D, 0xFF), -- ACTIVE_COLOR
            lcd.RGB(0x9A, 0xB6, 0xD8), -- INACTIVE_COLOR
            lcd.RGB(0xF8, 0x74, 0x18), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0xF8, 0x74, 0x18), -- BUTTON_BORDER_COLOR
            lcd.RGB(0x98, 0x60, 0x00), -- WARNING_COLOR
            lcd.RGB(0xFF, 0xFF, 0xFF), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0x09, 0x1D, 0x3B), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-amain-cobalt-dark.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        key = "AMnOL",
        name = "AMain Orange Light",
        -- studio-preview: previews/amain-orange-light.png
        -- studio-branding: AMain
        darkMode = false,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0x17, 0x2A, 0x35), -- PRIMARY_COLOR
            lcd.RGB(0xDC, 0xE3, 0xE8), -- SECONDARY_BGCOLOR
            lcd.RGB(0xFF, 0x68, 0x1B), -- HIGHLIGHT_COLOR
            lcd.RGB(0x17, 0x2A, 0x35), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x73, 0x81, 0x8C), -- DISABLE_COLOR
            lcd.RGB(0xF1, 0xF4, 0xF6), -- PRIMARY_BGCOLOR
            lcd.RGB(0x67, 0x78, 0x86), -- OVERLAY_COLOR
            lcd.RGB(0xF8, 0x74, 0x18), -- SECONDARY_COLOR
            lcd.RGB(0xA2, 0xD2, 0xF0), -- SAFE_COLOR
            lcd.RGB(0xF1, 0xF4, 0xF6), -- PAGE_BGCOLOR
            lcd.RGB(0xF5, 0x8C, 0x91), -- ERROR_COLOR
            lcd.RGB(0xD9, 0x4A, 0x00), -- ACTIVE_COLOR
            lcd.RGB(0x65, 0x76, 0x87), -- INACTIVE_COLOR
            lcd.RGB(0xF8, 0x74, 0x18), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0xF8, 0x74, 0x18), -- BUTTON_BORDER_COLOR
            lcd.RGB(0xF2, 0xBA, 0x59), -- WARNING_COLOR
            lcd.RGB(0x17, 0x2A, 0x35), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0xF1, 0xF4, 0xF6), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-amain-orange-light.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        key = "AMnBL",
        name = "AMain Blue Light",
        -- studio-preview: previews/amain-blue-light.png
        -- studio-branding: AMain
        darkMode = false,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0x10, 0x29, 0x40), -- PRIMARY_COLOR
            lcd.RGB(0xD4, 0xE5, 0xF5), -- SECONDARY_BGCOLOR
            lcd.RGB(0x07, 0x56, 0xAC), -- HIGHLIGHT_COLOR
            lcd.RGB(0xFF, 0xFF, 0xFF), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x6E, 0x88, 0xA0), -- DISABLE_COLOR
            lcd.RGB(0xF4, 0xF9, 0xFE), -- PRIMARY_BGCOLOR
            lcd.RGB(0x66, 0x84, 0xA0), -- OVERLAY_COLOR
            lcd.RGB(0xF8, 0x74, 0x18), -- SECONDARY_COLOR
            lcd.RGB(0xAD, 0xD9, 0xF5), -- SAFE_COLOR
            lcd.RGB(0xF4, 0xF9, 0xFE), -- PAGE_BGCOLOR
            lcd.RGB(0xF5, 0x8C, 0x91), -- ERROR_COLOR
            lcd.RGB(0x07, 0x56, 0xAC), -- ACTIVE_COLOR
            lcd.RGB(0x5D, 0x77, 0x93), -- INACTIVE_COLOR
            lcd.RGB(0xF8, 0x74, 0x18), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0xF8, 0x74, 0x18), -- BUTTON_BORDER_COLOR
            lcd.RGB(0xF2, 0xBA, 0x59), -- WARNING_COLOR
            lcd.RGB(0x10, 0x29, 0x40), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0xF4, 0xF9, 0xFE), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-amain-blue-light.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        -- studio-branding: Flyingeek

        key = "FGd8009",
        name = "Amethyst",
        roundButtons = true,
        focusStyle = "invert",
        colors = {
            lcd.RGB(0xF0, 0xE6, 0xFF), -- PRIMARY_COLOR (violet white)
            lcd.RGB(0x2D, 0x16, 0x54), -- SECONDARY_BGCOLOR (dark violet panel)
            lcd.RGB(0xBF, 0x00, 0xFF), -- HIGHLIGHT_COLOR (vivid electric violet)
            lcd.RGB(0x0D, 0x02, 0x21), -- HIGHLIGHT_CONTRASTING_COLOR (very dark violet)
            lcd.RGB(0x6B, 0x4D, 0x8A), -- DISABLE_COLOR (desaturated violet)
            lcd.RGB(0x0D, 0x02, 0x21), -- PRIMARY_BGCOLOR (near-black violet background)
            COLOR_BLACK,               -- OVERLAY_COLOR
            lcd.RGB(0xC4, 0xAE, 0xFF), -- SECONDARY_COLOR (lavender)
            lcd.RGB(0x00, 0xFF, 0xCC), -- SAFE_COLOR (neon cyan)
            lcd.RGB(0x1A, 0x0A, 0x38), -- PAGE_BGCOLOR (dark violet page)
            lcd.RGB(0xFF, 0x2D, 0x55), -- ERROR_COLOR (vivid pink-red)
            lcd.RGB(0x00, 0xFF, 0xCC), -- ACTIVE_COLOR (neon cyan)
            lcd.RGB(0xC4, 0xAE, 0xFF), -- INACTIVE_COLOR (lavender)
            lcd.RGB(0xFF, 0x00, 0xCC), -- BUTTON_BORDER_ACTIVE_COLOR (neon magenta)
            lcd.RGB(0x3D, 0x20, 0x60), -- BUTTON_BORDER_COLOR (dark violet)
            lcd.RGB(0xFF, 0x95, 0x00), -- WARNING_COLOR (vivid amber — 9.4:1 on PRIMARY, 7.5:1 on SECONDARY)
            COLOR_BLACK,               -- SAFE_CONTRASTING_COLOR
            COLOR_BLACK,               -- TOPLCD_BGCOLOR (XE/S)
        },
        --toolbarLogo = "none",
        toolbarBackground = lcd.loadBitmap("fgd8009-toolbar-amethyst.png")
    })

system.registerTheme({
        key = "PolTwlt",
        name = "Polaroid Twilight",
        darkMode = true,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0xFF, 0xFA, 0xE9), -- PRIMARY_COLOR
            lcd.RGB(0x58, 0x4C, 0x9E), -- SECONDARY_BGCOLOR: palette violet
            lcd.RGB(0xDC, 0x78, 0xD9), -- HIGHLIGHT_COLOR: orchid
            lcd.RGB(0x27, 0x1B, 0x3F), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0xA1, 0x92, 0xB8), -- DISABLE_COLOR
            lcd.RGB(0x30, 0x27, 0x50), -- PRIMARY_BGCOLOR: deep violet
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0xEE, 0xE1, 0xA2), -- SECONDARY_COLOR: cream
            lcd.RGB(0xAD, 0xE6, 0xB2), -- SAFE_COLOR
            lcd.RGB(0x24, 0x1D, 0x3B), -- PAGE_BGCOLOR
            lcd.RGB(0xFF, 0xA2, 0xA5), -- ERROR_COLOR: readable coral
            lcd.RGB(0xE3, 0xAA, 0x50), -- ACTIVE_COLOR: honey
            lcd.RGB(0xBD, 0xAC, 0xCC), -- INACTIVE_COLOR
            lcd.RGB(0xDC, 0x78, 0xD9), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0xCB, 0x5C, 0x5D), -- BUTTON_BORDER_COLOR: muted coral
            lcd.RGB(0xFF, 0xCF, 0x7D), -- WARNING_COLOR
            lcd.RGB(0x18, 0x2B, 0x1B), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0x30, 0x27, 0x50), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-polaroid-twilight.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        key = "SunDusk",
        name = "Sunflare Dusk",
        darkMode = true,
        roundButtons = false,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0xFF, 0xFA, 0xDE), -- PRIMARY_COLOR
            lcd.RGB(0x11, 0x11, 0x94), -- SECONDARY_BGCOLOR: ultramarine
            lcd.RGB(0xE4, 0xB9, 0x00), -- HIGHLIGHT_COLOR: gold
            lcd.RGB(0x10, 0x13, 0x42), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x8B, 0x94, 0xC7), -- DISABLE_COLOR
            lcd.RGB(0x12, 0x1A, 0x50), -- PRIMARY_BGCOLOR
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0xF3, 0xE7, 0x85), -- SECONDARY_COLOR: pale yellow
            lcd.RGB(0x9D, 0xEB, 0xAE), -- SAFE_COLOR
            lcd.RGB(0x0B, 0x10, 0x35), -- PAGE_BGCOLOR
            lcd.RGB(0xFF, 0xA1, 0xA8), -- ERROR_COLOR
            lcd.RGB(0xEA, 0x5A, 0x00), -- ACTIVE_COLOR: orange
            lcd.RGB(0xA5, 0xB5, 0xDA), -- INACTIVE_COLOR
            lcd.RGB(0xE4, 0xB9, 0x00), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0x2A, 0x70, 0xCE), -- BUTTON_BORDER_COLOR: blue
            lcd.RGB(0xFF, 0xC0, 0x75), -- WARNING_COLOR
            lcd.RGB(0x12, 0x2D, 0x1A), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0x12, 0x1A, 0x50), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-sunflare-dusk.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        key = "ElecFre",
        name = "Electric Freedom",
        darkMode = true,
        roundButtons = false,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0xFF, 0xFF, 0xFF), -- PRIMARY_COLOR
            lcd.RGB(0x14, 0x24, 0x5A), -- SECONDARY_BGCOLOR
            lcd.RGB(0x00, 0xCE, 0xD1), -- HIGHLIGHT_COLOR
            lcd.RGB(0x06, 0x1C, 0x29), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x95, 0x89, 0xB0), -- DISABLE_COLOR
            lcd.RGB(0x0A, 0x13, 0x38), -- PRIMARY_BGCOLOR
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0x7D, 0xEA, 0xF0), -- SECONDARY_COLOR
            lcd.RGB(0x9E, 0xE5, 0xAE), -- SAFE_COLOR
            lcd.RGB(0x06, 0x0C, 0x26), -- PAGE_BGCOLOR
            lcd.RGB(0xFF, 0xA4, 0xAC), -- ERROR_COLOR
            lcd.RGB(0xFF, 0xFF, 0x00), -- ACTIVE_COLOR
            lcd.RGB(0xB9, 0xAD, 0xCF), -- INACTIVE_COLOR
            lcd.RGB(0x00, 0xCE, 0xD1), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0xD0, 0x00, 0xF5), -- BUTTON_BORDER_COLOR
            lcd.RGB(0xFF, 0xD0, 0x80), -- WARNING_COLOR
            lcd.RGB(0x10, 0x2C, 0x1A), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0x0A, 0x13, 0x38), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-electric-freedom.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        key = "Neonish",
        name = "Neonish",
        darkMode = true,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0xFF, 0xF9, 0xFF), -- PRIMARY_COLOR
            lcd.RGB(0x33, 0x18, 0x87), -- SECONDARY_BGCOLOR
            lcd.RGB(0x1B, 0xBF, 0xE1), -- HIGHLIGHT_COLOR
            lcd.RGB(0x10, 0x1B, 0x36), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x95, 0x89, 0xB0), -- DISABLE_COLOR
            lcd.RGB(0x20, 0x10, 0x48), -- PRIMARY_BGCOLOR
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0xFF, 0xE2, 0x5D), -- SECONDARY_COLOR
            lcd.RGB(0x9E, 0xE5, 0xAE), -- SAFE_COLOR
            lcd.RGB(0x14, 0x0A, 0x32), -- PAGE_BGCOLOR
            lcd.RGB(0xFF, 0xA4, 0xAC), -- ERROR_COLOR
            lcd.RGB(0xF4, 0x55, 0xB4), -- ACTIVE_COLOR
            lcd.RGB(0xB9, 0xAD, 0xCF), -- INACTIVE_COLOR
            lcd.RGB(0x1B, 0xBF, 0xE1), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0x67, 0x48, 0xC2), -- BUTTON_BORDER_COLOR
            lcd.RGB(0xFF, 0xD0, 0x80), -- WARNING_COLOR
            lcd.RGB(0x10, 0x2C, 0x1A), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0x20, 0x10, 0x48), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-neonish.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        key = "DiwaliC",
        name = "Diwali Celebration",
        darkMode = true,
        roundButtons = false,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0xFF, 0xFF, 0xFF), -- PRIMARY_COLOR
            lcd.RGB(0x47, 0x11, 0x67), -- SECONDARY_BGCOLOR
            lcd.RGB(0xF1, 0xDF, 0x00), -- HIGHLIGHT_COLOR
            lcd.RGB(0x28, 0x11, 0x3B), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x95, 0x89, 0xB0), -- DISABLE_COLOR
            lcd.RGB(0x21, 0x0A, 0x3D), -- PRIMARY_BGCOLOR
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0xFF, 0xB5, 0xDD), -- SECONDARY_COLOR
            lcd.RGB(0x9E, 0xE5, 0xAE), -- SAFE_COLOR
            lcd.RGB(0x16, 0x05, 0x2B), -- PAGE_BGCOLOR
            lcd.RGB(0xFF, 0xA4, 0xAC), -- ERROR_COLOR
            lcd.RGB(0xFF, 0x79, 0xBE), -- ACTIVE_COLOR
            lcd.RGB(0xB9, 0xAD, 0xCF), -- INACTIVE_COLOR
            lcd.RGB(0xF1, 0xDF, 0x00), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0xF1, 0x2F, 0x94), -- BUTTON_BORDER_COLOR
            lcd.RGB(0xFF, 0xD0, 0x80), -- WARNING_COLOR
            lcd.RGB(0x10, 0x2C, 0x1A), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0x21, 0x0A, 0x3D), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-diwali-celebration.png"),
        toolbarLogo = "none",
    })

system.registerTheme({
        -- studio-branding: Flyingeek

        key = "FG1a89c",
        name = "Alucard",
        roundButtons = true,
        focusStyle = "invert",
        colors = {
            lcd.RGB(0x1F, 0x1F, 0x1F), -- PRIMARY_COLOR
            lcd.RGB(0xCE, 0xCC, 0xC0), -- SECONDARY_BGCOLOR
            lcd.RGB(100, 74, 201),     -- HIGHLIGHT_COLOR (#644AC9)
            lcd.RGB(0xFF, 0xFF, 0xF5), -- HIGHLIGHT_CONTRASTING_COLOR
            lcd.RGB(0x87, 0x7F, 0x5E), -- DISABLE_COLOR
            lcd.RGB(0xFF, 0xFF, 0xF5), -- PRIMARY_BGCOLOR
            lcd.GREY(0x60),            -- OVERLAY_COLOR
            lcd.RGB(0x3E, 0x3A, 0x2B), -- SECONDARY_COLOR
            lcd.RGB(0x08, 0x91, 0x08), -- SAFE_COLOR
            lcd.RGB(0xEA, 0xEA, 0xE0), -- PAGE_BGCOLOR
            lcd.RGB(0xCB, 0x3A, 0x2A), -- ERROR_COLOR
            lcd.RGB(0x08, 0x91, 0x08), -- ACTIVE_COLOR
            lcd.RGB(0x3E, 0x3A, 0x2B), -- INACTIVE_COLOR
            lcd.RGB(0x81, 0x5C, 0xD6), -- BUTTON_BORDER_ACTIVE_COLOR xCF
            lcd.RGB(0xBC, 0xBA, 0xB3), -- BUTTON_BORDER_COLOR
            lcd.RGB(0xA3, 0x95, 0x14), -- WARNING_COLOR
            lcd.RGB(0xFF, 0xFF, 0xF5), -- SAFE_CONTRASTING_COLOR
            COLOR_WHITE,               -- TOPLCD_BGCOLOR (XE/S)
        },
        --toolbarLogo = "none",
        toolbarBackground = lcd.loadBitmap("fg1a89c-toolbar-alucard-plain.png"),
        -- alternatively, if you want the dracula mascot, use this line instead:
        --toolbarBackground = lcd.loadBitmap("toolbar-alucard-logo.png"),
    })

system.registerTheme({
        -- studio-branding: Flyingeek

        key = "FG7a54e",
        name = "Grove",
        roundButtons = true,
        focusStyle = "invert",
        colors = {
            lcd.RGB(0xE8, 0xF5, 0xEE), -- PRIMARY_COLOR (near-white green)
            lcd.RGB(0x1C, 0x40, 0x28), -- SECONDARY_BGCOLOR (forest panels — lum ~3.4× PRIMARY_BGCOLOR)
            lcd.RGB(0xA8, 0xE6, 0x3A), -- HIGHLIGHT_COLOR (vivid spring green)
            lcd.RGB(0x06, 0x1A, 0x0E), -- HIGHLIGHT_CONTRASTING_COLOR (dark on vivid green)
            lcd.RGB(0x54, 0x7A, 0x64), -- DISABLE_COLOR (muted sage — 2.2:1 on PAGE, 3.6:1 on canvas)
            lcd.RGB(0x0F, 0x22, 0x1A), -- PRIMARY_BGCOLOR (deep forest canvas — lum ~0.011)
            COLOR_BLACK,               -- OVERLAY_COLOR
            lcd.RGB(0x8C, 0xC4, 0xA0), -- SECONDARY_COLOR (medium sage)
            lcd.RGB(0x50, 0xFA, 0x7B), -- SAFE_COLOR (lime green)
            lcd.RGB(0x0E, 0x4A, 0x3D), -- PAGE_BGCOLOR (#0E4A3D — rich forest green)
            lcd.RGB(0xFF, 0x22, 0x44), -- ERROR_COLOR (crimson — #FF2244, 4.5:1 on forest green)
            lcd.RGB(0x22, 0xD6, 0x6A), -- ACTIVE_COLOR (vivid spring green)
            lcd.RGB(0x70, 0x9C, 0x7A), -- INACTIVE_COLOR (muted sage — 3.3:1 on PAGE)
            lcd.RGB(0x22, 0xD6, 0x6A), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0x21, 0x5B, 0x39), -- BUTTON_BORDER_COLOR
            lcd.RGB(0xF4, 0xA0, 0x35), -- WARNING_COLOR (amber — caution, was ERROR_COLOR)
            lcd.RGB(0x06, 0x1A, 0x0E), -- SAFE_CONTRASTING_COLOR
            COLOR_BLACK,               -- TOPLCD_BGCOLOR (XE/S)
        },
        --toolbarLogo = "none",
        toolbarBackground = lcd.loadBitmap("fg7a54e-toolbar-grove.png"),
    })

system.registerTheme({
        -- studio-branding: Flyingeek

        key = "FG63707",
        name = "Dracula Moebius Red",
        roundButtons = true,
        focusStyle = "invert",
        colors = {
            lcd.RGB(0xF8, 0xF8, 0xF2), -- PRIMARY_COLOR
            lcd.RGB(0x42, 0x44, 0x50), -- SECONDARY_BGCOLOR
            lcd.RGB(255, 170, 153),    -- HIGHLIGHT_COLOR (189, 147, 249)(#BD93F9) or (255, 170, 153)(#FFAA99)
            lcd.RGB(0x19, 0x1A, 0x21), -- HIGHLIGHT_CONTRASTING_COLOR
            lcd.RGB(0xA9, 0x70, 0x79), -- DISABLE_COLOR
            lcd.RGB(0x2C, 0x21, 0x22), -- PRIMARY_BGCOLOR
            COLOR_BLACK,               -- OVERLAY_COLOR
            lcd.RGB(0xb8, 0xc3, 0xe4), -- SECONDARY_COLOR
            lcd.RGB(0x69, 0xFF, 0x94), -- SAFE_COLOR
            lcd.RGB(0x5E, 0x13, 0x17), -- PAGE_BGCOLOR
            lcd.RGB(0xDE, 0x57, 0x35), -- ERROR_COLOR
            lcd.RGB(0x69, 0xFF, 0x94), -- ACTIVE_COLOR
            lcd.RGB(0xb8, 0xc3, 0xe4), -- INACTIVE_COLOR 0xFF, 0x80, 0xBF
            lcd.RGB(0x81, 0x5C, 0xD6), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0x50, 0x52, 0x61), -- BUTTON_BORDER_COLOR
            lcd.RGB(0xA3, 0x95, 0x14), -- WARNING_COLOR
            lcd.RGB(0x19, 0x1A, 0x21), -- SAFE_CONTRASTING_COLOR
            COLOR_BLACK,               -- TOPLCD_BGCOLOR (XE/S)
        },
        --toolbarLogo = "none",
        toolbarBackground = lcd.loadBitmap("fg63707-toolbar-moebius-plain.png")
        -- alternatively, if you want the dracula mascot, use this line instead:
        --toolbarBackground = lcd.loadBitmap("toolbar-moebius-logo.png"),
    })
end
return { init = init }
