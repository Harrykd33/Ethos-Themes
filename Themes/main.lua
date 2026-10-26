-- Ethos 26.x palette: ERROR_COLOR slot 11, WARNING_COLOR slot 16,
-- SAFE_CONTRASTING_COLOR slot 17, TOPLCD_BGCOLOR slot 18.
local function init()
    system.registerTheme({
        key = "KvnD",
        name = "KvnD",
        roundButtons = true,
        focusStyle = "invert",
        colors = {
        lcd.RGB(0xFF, 0xFF, 0xFF), -- PRIMARY_COLOR (Ultra-crisp stark white text)
        lcd.RGB(28,15,68),         -- SECONDARY_BGCOLOR (Clean slate grey for panels)
        lcd.RGB(0xAA, 0x66, 0xFF), -- HIGHLIGHT_COLOR (Vibrant, high-voltage electric violet)
        lcd.RGB(0x0C, 0x0D, 0x12), -- HIGHLIGHT_INVERT_COLOR (Inverted deep ink black)
        lcd.RGB(0x52, 0x5A, 0x7A), -- DISABLE_COLOR (Sleek low-opacity steel blue)
        lcd.RGB(28,15,68),         -- PRIMARY_BGCOLOR (Rich OLED midnight-grey background)
        BLACK,                     -- OVERLAY_COLOR
        lcd.RGB(0xFF, 0xFF, 0xFF), -- SECONDARY_COLOR (Ice blue-grey accent text)
        lcd.RGB(0x00, 0xFF, 0xA3), -- SAFE_COLOR (Hyper-neon spring green)
        lcd.RGB(0x18, 0x1A, 0x20), -- PAGE_BGCOLOR (Subtle dark backing layout)
        lcd.RGB(0xFF, 0x5A, 0x68), -- ERROR_COLOR (system critical: red)
        lcd.RGB(0x00, 0xFF, 0xA3), -- ACTIVE_COLOR (Hyper-neon spring green)
        lcd.RGB(0xA2, 0xAC, 0xC7), -- INACTIVE_COLOR (Muted silver-blue)
        lcd.RGB(0xCC, 0x00, 0xFF), -- BUTTON_BORDER_ACTIVE_COLOR (Neon violet-magenta trim)
        lcd.RGB(0x23, 0x25, 0x31), -- BUTTON_BORDER_COLOR (Clean, defined dark edge)
        lcd.RGB(0xFF, 0xB3, 0x47), -- WARNING_COLOR (system warning: amber)
        lcd.RGB(0, 0, 0),          -- SAFE_CONTRASTING_COLOR
        BLACK                      -- TOPLCD_BGCOLOR (XE/S models)
        },
        --toolbarLogo = "none",
        toolbarBackground = "dark",
    })
    system.registerTheme({
        key = "Teal",
        name = "Teal RFs",
        roundButtons = true,
        focusStyle = "outline",
        borderWidth = 4,
        darkMode = false,
        colors = {
            lcd.RGB(0x1F, 0x1F, 0x1F), -- PRIMARY_COLOR
            lcd.RGB(118, 145, 137),    -- SECONDARY_BGCOLOR
            lcd.RGB(32, 176, 212),      -- HIGHLIGHT_COLOR (#644AC9)
            lcd.RGB(0xFF, 0xFF, 0xF5), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(161, 63, 53),      -- DISABLE_COLOR
            lcd.RGB(0xBD, 0xE6, 0xD6), -- PRIMARY_BGCOLOR
            lcd.GREY(0x60),            -- OVERLAY_COLOR
            lcd.RGB(255, 34, 10),      -- SECONDARY_COLOR
            lcd.RGB(65, 217, 30), -- SAFE_COLOR
            lcd.RGB(242, 240, 232),    -- PAGE_BGCOLOR
            lcd.RGB(0x8B, 0x00, 0x15), -- ERROR_COLOR (system critical: red)
            lcd.RGB(0x08, 0x91, 0x08), -- ACTIVE_COLOR
            lcd.RGB(0x3E, 0x3A, 0x2B), -- INACTIVE_COLOR
            lcd.RGB(0x81, 0x5C, 0xD6), -- BUTTON_BORDER_ACTIVE_COLOR xCF
            lcd.RGB(118, 145, 137),    -- BUTTON_BORDER_COLOR
            lcd.RGB(0x8A, 0x43, 0x00), -- WARNING_COLOR (system warning: amber)
            lcd.RGB(0, 0, 0),          -- SAFE_CONTRASTING_COLOR
            WHITE,                     -- TOPLCD_BGCOLOR (XE/S)
        },
        toolbarLogo = "none",
        toolbarBackground = lcd.loadBitmap("teal1.5.png"),
    })
   system.registerTheme({
    key = "PUIMA",
    name = " Pu RFs",
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
        toolbarBackground = lcd.loadBitmap("purfs.png")
    })
    system.registerTheme({
        key = "Ocean",
        name = "Ocean",
        roundButtons = true,
        focusStyle = "invert",
        darkMode = true,
        colors = {
            lcd.RGB(0xD8, 0xE8, 0xFF), -- PRIMARY_COLOR (blanc glac�)
            lcd.RGB(0x2C, 0x44, 0x68), -- SECONDARY_BGCOLOR (acier bleu panel � lum ~3.4x PRIMARY)
            lcd.RGB(0x44, 0x88, 0xFF), -- HIGHLIGHT_COLOR (bleu royal vif)
            lcd.RGB(0xE8, 0xF4, 0xFF), -- HIGHLIGHT_INVERT_COLOR (blanc sur bleu)
            lcd.RGB(0x24, 0x36, 0x50), -- DISABLE_COLOR (bleu ardoise �teint)
            lcd.RGB(0x18, 0x20, 0x40), -- PRIMARY_BGCOLOR (bleu nuit � lum ~0.016 = Dracula)
            BLACK,                     -- OVERLAY_COLOR
            lcd.RGB(0x88, 0xBB, 0xDD), -- SECONDARY_COLOR (bleu ciel lisible)
            lcd.RGB(0x84, 0xC3, 0x0F), -- SAFE_COLOR (vert ethos)
            lcd.RGB(0x0E, 0x18, 0x30), -- PAGE_BGCOLOR (plus sombre que PRIMARY)
            lcd.RGB(0xFF, 0x5A, 0x68), -- ERROR_COLOR (system critical: red)
            lcd.RGB(0x44, 0x88, 0xFF), -- ACTIVE_COLOR (bleu royal)
            lcd.RGB(0x2A, 0x50, 0x80), -- INACTIVE_COLOR (bleu terne)
            lcd.RGB(0x44, 0x88, 0xFF), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0x2C, 0x44, 0x68), -- BUTTON_BORDER_COLOR
            lcd.RGB(0xFF, 0xB3, 0x47), -- WARNING_COLOR (system warning: amber)
            lcd.RGB(0, 0, 0),          -- SAFE_CONTRASTING_COLOR
            BLACK,                     -- TOPLCD_BGCOLOR (XE/S)
        },
        --toolbarLogo = "none",
        toolbarBackground = lcd.loadBitmap("toolbar-ocean.png")
    })
    system.registerTheme({
    key = "Bluv2",
    name = "Blu Rfs",
    roundButtons = true,
    focusStyle = "invert",
    borderWidth = 4,
    darkMode = false,
    colors = {
        lcd.RGB(24, 16, 16),       -- PRIMARY_COLOR (Black)
        lcd.RGB(103, 139, 193),    -- SECONDARY_BGCOLOR (Soft Navy #678BC1)
        lcd.RGB(249, 121, 4),      -- HIGHLIGHT_COLOR (Mostly desaturated dark blue  #55677c)
        lcd.RGB(24, 16, 16),       -- HIGHLIGHT_INVERT_COLOR ( Chilean Fire #F97904)
        lcd.RGB(191, 123, 53),     -- DISABLE_COLOR (sweet line #F0C667)
        lcd.RGB(88, 178, 226),     -- PRIMARY_BGCOLOR (Light Sky Blue #678bc1)
        lcd.GREY(0x60),            -- OVERLAY_COLOR
        lcd.RGB(49, 80, 214),      -- SECONDARY_color (Glossy Coral #FA8567)88, 109, 226
        lcd.RGB(0x00, 0xFF, 0xCC), -- SAFE_COLOR (white)
        lcd.RGB(178, 228, 255),    -- PAGE_BGCOLOR (Light Sky Blue #B2E4FF)
        lcd.RGB(0x8B, 0x00, 0x15), -- ERROR_COLOR (system critical: red)
        lcd.RGB(0x00, 0xFF, 0xCC), -- ACTIVE_COLOR (cyan n�on)
        lcd.RGB(0xC4, 0xAE, 0xFF), -- INACTIVE_COLOR (lavande)
        lcd.RGB(49, 80, 214),      -- BUTTON_BORDER_ACTIVE_COLOR (Top bar batt icon
        lcd.RGB(49, 80, 214),      -- BUTTON_BORDER_COLOR (Mostly desaturated dark blue #55677c)
        lcd.RGB(0x8A, 0x43, 0x00), -- WARNING_COLOR (system warning: amber)
        lcd.RGB(0, 0, 0),          -- SAFE_CONTRASTING_COLOR
        BLACK,                     -- TOPLCD_BGCOLOR (XE/S)
        },
        toolbarLogo ="none",
        toolbarBackground = lcd.loadBitmap("blueslogo1.png")
    }) 
     system.registerTheme({
    key = "yello",
    name = "Yelo Rfs",
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
        toolbarBackground = lcd.loadBitmap("yelo.png")
    }) 
    -- Cyberpunk: neon accents on deep indigo, with independent alert colors.
    system.registerTheme({
        key = "CyberPn",
        name = "Cyberpunk",
        darkMode = true,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0xEA, 0xF6, 0xFF), -- PRIMARY_COLOR: cool white
            lcd.RGB(0x21, 0x1B, 0x38), -- SECONDARY_BGCOLOR: plum panels
            lcd.RGB(0x00, 0xE5, 0xFF), -- HIGHLIGHT_COLOR: neon cyan
            lcd.RGB(0x08, 0x0B, 0x16), -- HIGHLIGHT_CONTRASTING_COLOR: ink
            lcd.RGB(0x68, 0x64, 0x80), -- DISABLE_COLOR: muted violet
            lcd.RGB(0x0D, 0x10, 0x20), -- PRIMARY_BGCOLOR: midnight indigo
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0xC4, 0xB5, 0xF4), -- SECONDARY_COLOR: pale lavender
            lcd.RGB(0x52, 0xFF, 0xA8), -- SAFE_COLOR: mint green
            lcd.RGB(0x08, 0x0B, 0x16), -- PAGE_BGCOLOR: deep ink
            lcd.RGB(0xFF, 0x5B, 0x64), -- ERROR_COLOR: critical red
            lcd.RGB(0x00, 0xE5, 0xFF), -- ACTIVE_COLOR: neon cyan
            lcd.RGB(0x83, 0x80, 0xA0), -- INACTIVE_COLOR: slate violet
            lcd.RGB(0xFF, 0x4F, 0xD8), -- BUTTON_BORDER_ACTIVE_COLOR: neon magenta
            lcd.RGB(0x48, 0x35, 0x67), -- BUTTON_BORDER_COLOR: purple trim
            lcd.RGB(0xFF, 0xC2, 0x47), -- WARNING_COLOR: amber
            lcd.RGB(0x08, 0x0B, 0x16), -- SAFE_CONTRASTING_COLOR: ink on mint
            lcd.RGB(0x08, 0x0B, 0x16), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = "dark",
        toolbarLogo = "dark",
    })

    -- Silver Flame: light silver, charcoal, orange-red and blue from the reference.
    system.registerTheme({
        key = "SilvFlm",
        name = "Silver Flame",
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
            lcd.RGB(0x35, 0xD6, 0x4B), -- SAFE_COLOR: vibrant lime green
            lcd.RGB(0xFA, 0xFB, 0xF9), -- PAGE_BGCOLOR: soft white
            lcd.RGB(0xA5, 0x10, 0x25), -- ERROR_COLOR: critical crimson
            lcd.RGB(0x00, 0x6D, 0xB5), -- ACTIVE_COLOR: vivid blue
            lcd.RGB(0x66, 0x74, 0x7C), -- INACTIVE_COLOR: slate grey
            lcd.RGB(0x00, 0x8F, 0xDB), -- BUTTON_BORDER_ACTIVE_COLOR: electric blue
            lcd.RGB(0x4F, 0x8F, 0xB8), -- BUTTON_BORDER_COLOR: steel blue
            lcd.RGB(0x86, 0x42, 0x00), -- WARNING_COLOR: dark amber
            lcd.RGB(0x17, 0x1E, 0x22), -- SAFE_CONTRASTING_COLOR: charcoal on lime
            lcd.RGB(0xEF, 0xF2, 0xF0), -- TOPLCD_BGCOLOR: pearl silver
        },
        toolbarBackground = "light",
        toolbarLogo = "light",
    })

end

return {
    init = init
}
