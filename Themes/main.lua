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

        toolbarBackground = lcd.loadBitmap("header-kvnd.png"),
        toolbarLogo = "none",
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
        toolbarBackground = lcd.loadBitmap("header-teal.png"),
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
        toolbarBackground = lcd.loadBitmap("header-pu-rfs.png")
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

        toolbarBackground = lcd.loadBitmap("header-ocean.png"),
        toolbarLogo = "none",
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
        toolbarBackground = lcd.loadBitmap("header-blu-rfs.png")
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
        toolbarBackground = lcd.loadBitmap("header-yelo-rfs.png")
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
        toolbarBackground = lcd.loadBitmap("header-cyberpunk.png"),
        toolbarLogo = "none",

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
        toolbarBackground = lcd.loadBitmap("header-silver-flame.png"),
        toolbarLogo = "none",

    })

    -- Porcelain Tide: sea-glass panels, inky teal type and a cobalt focus.
    system.registerTheme({
        key = "PorcTde",
        name = "Porcelain Tide",
        darkMode = false,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0x16, 0x32, 0x3D), -- PRIMARY_COLOR: marine ink
            lcd.RGB(0xD5, 0xE8, 0xE7), -- SECONDARY_BGCOLOR: sea glass
            lcd.RGB(0x21, 0x59, 0xB5), -- HIGHLIGHT_COLOR: cobalt
            lcd.RGB(0xFF, 0xFF, 0xFF), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x78, 0x8D, 0x94), -- DISABLE_COLOR
            lcd.RGB(0xF1, 0xF8, 0xF6), -- PRIMARY_BGCOLOR: porcelain
            lcd.RGB(0x16, 0x32, 0x3D), -- OVERLAY_COLOR
            lcd.RGB(0x27, 0x63, 0x6B), -- SECONDARY_COLOR: deep teal
            lcd.RGB(0x20, 0x73, 0x4D), -- SAFE_COLOR
            lcd.RGB(0xFF, 0xFD, 0xF7), -- PAGE_BGCOLOR: shell white
            lcd.RGB(0xAA, 0x23, 0x35), -- ERROR_COLOR
            lcd.RGB(0x21, 0x59, 0xB5), -- ACTIVE_COLOR
            lcd.RGB(0x5D, 0x75, 0x7D), -- INACTIVE_COLOR
            lcd.RGB(0x21, 0x59, 0xB5), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0x8A, 0xB0, 0xB3), -- BUTTON_BORDER_COLOR
            lcd.RGB(0x85, 0x4B, 0x08), -- WARNING_COLOR
            lcd.RGB(0xFF, 0xFF, 0xFF), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0xF1, 0xF8, 0xF6), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-porcelain-tide.png"),
        toolbarLogo = "none",

    })

    -- Apricot Atelier: warm paper and peach with a mulberry selection.
    system.registerTheme({
        key = "AprAtlr",
        name = "Apricot Atelier",
        darkMode = false,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0x3D, 0x2A, 0x30), -- PRIMARY_COLOR: espresso plum
            lcd.RGB(0xF3, 0xD9, 0xC8), -- SECONDARY_BGCOLOR: apricot cream
            lcd.RGB(0x87, 0x36, 0x64), -- HIGHLIGHT_COLOR: mulberry
            lcd.RGB(0xFF, 0xF9, 0xEF), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0xA0, 0x89, 0x80), -- DISABLE_COLOR
            lcd.RGB(0xFF, 0xF4, 0xE7), -- PRIMARY_BGCOLOR: warm paper
            lcd.RGB(0x3D, 0x2A, 0x30), -- OVERLAY_COLOR
            lcd.RGB(0x79, 0x45, 0x3B), -- SECONDARY_COLOR: terracotta ink
            lcd.RGB(0x2C, 0x70, 0x4D), -- SAFE_COLOR
            lcd.RGB(0xFF, 0xFB, 0xF4), -- PAGE_BGCOLOR: ivory
            lcd.RGB(0xAB, 0x1E, 0x32), -- ERROR_COLOR
            lcd.RGB(0x87, 0x36, 0x64), -- ACTIVE_COLOR
            lcd.RGB(0x83, 0x6A, 0x65), -- INACTIVE_COLOR
            lcd.RGB(0x87, 0x36, 0x64), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0xC0, 0x97, 0x85), -- BUTTON_BORDER_COLOR
            lcd.RGB(0x86, 0x49, 0x06), -- WARNING_COLOR
            lcd.RGB(0xFF, 0xFF, 0xFF), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0xFF, 0xF4, 0xE7), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-apricot-atelier.png"),
        toolbarLogo = "none",

    })

    -- Alpine Linen: limestone and sage, with crisp forest-green controls.
    system.registerTheme({
        key = "AlpLinn",
        name = "Alpine Linen",
        darkMode = false,
        roundButtons = false,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0x28, 0x36, 0x2C), -- PRIMARY_COLOR: pine charcoal
            lcd.RGB(0xDD, 0xE5, 0xD3), -- SECONDARY_BGCOLOR: pale sage
            lcd.RGB(0x2D, 0x63, 0x49), -- HIGHLIGHT_COLOR: forest green
            lcd.RGB(0xFF, 0xFD, 0xEE), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x8C, 0x93, 0x80), -- DISABLE_COLOR
            lcd.RGB(0xF4, 0xF2, 0xE6), -- PRIMARY_BGCOLOR: natural linen
            lcd.RGB(0x28, 0x36, 0x2C), -- OVERLAY_COLOR
            lcd.RGB(0x65, 0x59, 0x30), -- SECONDARY_COLOR: olive bronze
            lcd.RGB(0x2D, 0x63, 0x49), -- SAFE_COLOR
            lcd.RGB(0xFF, 0xFD, 0xF3), -- PAGE_BGCOLOR: limestone
            lcd.RGB(0xA4, 0x28, 0x31), -- ERROR_COLOR
            lcd.RGB(0x2D, 0x63, 0x49), -- ACTIVE_COLOR
            lcd.RGB(0x6B, 0x75, 0x63), -- INACTIVE_COLOR
            lcd.RGB(0x2D, 0x63, 0x49), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0x9C, 0xAC, 0x8F), -- BUTTON_BORDER_COLOR
            lcd.RGB(0x80, 0x4C, 0x06), -- WARNING_COLOR
            lcd.RGB(0xFF, 0xFD, 0xEE), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0xF4, 0xF2, 0xE6), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-alpine-linen.png"),
        toolbarLogo = "none",

    })

    -- Ember Obsidian: warm graphite, glowing copper and restrained gold.
    system.registerTheme({
        key = "EmbrObs",
        name = "Ember Obsidian",
        darkMode = true,
        roundButtons = false,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0xFF, 0xF0, 0xDD), -- PRIMARY_COLOR: candle white
            lcd.RGB(0x36, 0x2A, 0x25), -- SECONDARY_BGCOLOR: warm graphite
            lcd.RGB(0xFF, 0xA0, 0x62), -- HIGHLIGHT_COLOR: glowing copper
            lcd.RGB(0x22, 0x16, 0x10), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x7F, 0x70, 0x65), -- DISABLE_COLOR
            lcd.RGB(0x1C, 0x19, 0x17), -- PRIMARY_BGCOLOR: obsidian
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0xDC, 0xBC, 0x91), -- SECONDARY_COLOR: pale gold
            lcd.RGB(0x94, 0xDA, 0xA0), -- SAFE_COLOR
            lcd.RGB(0x11, 0x0F, 0x0E), -- PAGE_BGCOLOR: charcoal black
            lcd.RGB(0xFF, 0x72, 0x78), -- ERROR_COLOR
            lcd.RGB(0xFF, 0xA0, 0x62), -- ACTIVE_COLOR
            lcd.RGB(0xAA, 0x97, 0x88), -- INACTIVE_COLOR
            lcd.RGB(0xFF, 0xA0, 0x62), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0x71, 0x50, 0x3E), -- BUTTON_BORDER_COLOR
            lcd.RGB(0xFF, 0xD1, 0x66), -- WARNING_COLOR
            lcd.RGB(0x12, 0x25, 0x18), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0x11, 0x0F, 0x0E), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-ember-obsidian.png"),
        toolbarLogo = "none",

    })

    -- Aurora Noir: blackened spruce, luminous jade and glacial blue.
    system.registerTheme({
        key = "AurNoir",
        name = "Aurora Noir",
        darkMode = true,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 3,
        colors = {
            lcd.RGB(0xE1, 0xFA, 0xF2), -- PRIMARY_COLOR: frost white
            lcd.RGB(0x19, 0x35, 0x32), -- SECONDARY_BGCOLOR: spruce panels
            lcd.RGB(0x72, 0xEC, 0xBB), -- HIGHLIGHT_COLOR: aurora jade
            lcd.RGB(0x07, 0x21, 0x1B), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x58, 0x7B, 0x74), -- DISABLE_COLOR
            lcd.RGB(0x0C, 0x20, 0x1E), -- PRIMARY_BGCOLOR: blackened spruce
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0xA3, 0xD8, 0xED), -- SECONDARY_COLOR: glacial blue
            lcd.RGB(0xA6, 0xE8, 0x81), -- SAFE_COLOR
            lcd.RGB(0x06, 0x13, 0x13), -- PAGE_BGCOLOR: polar night
            lcd.RGB(0xFF, 0x7B, 0x86), -- ERROR_COLOR
            lcd.RGB(0x72, 0xEC, 0xBB), -- ACTIVE_COLOR
            lcd.RGB(0x8B, 0xB1, 0xA9), -- INACTIVE_COLOR
            lcd.RGB(0x88, 0xCD, 0xF5), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0x3D, 0x6F, 0x67), -- BUTTON_BORDER_COLOR
            lcd.RGB(0xFF, 0xCD, 0x71), -- WARNING_COLOR
            lcd.RGB(0x12, 0x27, 0x14), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0x06, 0x13, 0x13), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-aurora-noir.png"),
        toolbarLogo = "none",

    })

    -- Velvet Orbit: aubergine, lilac and rose with a luminous lime status.
    system.registerTheme({
        key = "VlvOrbt",
        name = "Velvet Orbit",
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
            lcd.RGB(0xB9, 0xE6, 0x80), -- SAFE_COLOR
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

    -- Solar Ink: Sunlit yellow, carbon lettering and bold black controls.
    system.registerTheme({
        key = "SolarIk",
        name = "Solar Ink",
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
            lcd.RGB(0x17, 0x4C, 0x25), -- SAFE_COLOR
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

    -- Glacier Signal: Polar white, ice-blue panels and deep naval blue, with burnt-orange status accents.
    system.registerTheme({
        key = "GlacSig",
        name = "Glacier Signal",
        darkMode = false,
        roundButtons = false,
        focusStyle = "invert",
        borderWidth = 4,
        colors = {
            lcd.RGB(0x07, 0x1D, 0x38), -- PRIMARY_COLOR
            lcd.RGB(0xD7, 0xED, 0xFF), -- SECONDARY_BGCOLOR
            lcd.RGB(0x00, 0x3B, 0x78), -- HIGHLIGHT_COLOR
            lcd.RGB(0xFF, 0xFF, 0xFF), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x62, 0x70, 0x80), -- DISABLE_COLOR
            lcd.RGB(0xF5, 0xFA, 0xFF), -- PRIMARY_BGCOLOR
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0x17, 0x34, 0x51), -- SECONDARY_COLOR
            lcd.RGB(0x14, 0x50, 0x2A), -- SAFE_COLOR
            lcd.RGB(0xFF, 0xFF, 0xFF), -- PAGE_BGCOLOR
            lcd.RGB(0x93, 0x0E, 0x22), -- ERROR_COLOR
            lcd.RGB(0x00, 0x3B, 0x78), -- ACTIVE_COLOR
            lcd.RGB(0x34, 0x4C, 0x61), -- INACTIVE_COLOR
            lcd.RGB(0x00, 0x3B, 0x78), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0x4C, 0x63, 0x79), -- BUTTON_BORDER_COLOR
            lcd.RGB(0x80, 0x34, 0x00), -- WARNING_COLOR
            lcd.RGB(0xFF, 0xFF, 0xFF), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0xD7, 0xED, 0xFF), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-glacier-signal.png"),
        toolbarLogo = "none",
    })

    -- Cherry Press: Fresh newsprint and cherry-blossom panels with heavy burgundy selections.
    system.registerTheme({
        key = "ChryPrs",
        name = "Cherry Press",
        darkMode = false,
        roundButtons = true,
        focusStyle = "invert",
        borderWidth = 4,
        colors = {
            lcd.RGB(0x2A, 0x08, 0x18), -- PRIMARY_COLOR
            lcd.RGB(0xFF, 0xDD, 0xE8), -- SECONDARY_BGCOLOR
            lcd.RGB(0x80, 0x0B, 0x39), -- HIGHLIGHT_COLOR
            lcd.RGB(0xFF, 0xFF, 0xFF), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x84, 0x61, 0x6F), -- DISABLE_COLOR
            lcd.RGB(0xFF, 0xF7, 0xFA), -- PRIMARY_BGCOLOR
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0x54, 0x20, 0x36), -- SECONDARY_COLOR
            lcd.RGB(0x20, 0x49, 0x25), -- SAFE_COLOR
            lcd.RGB(0xFF, 0xFF, 0xFF), -- PAGE_BGCOLOR
            lcd.RGB(0x92, 0x0B, 0x16), -- ERROR_COLOR
            lcd.RGB(0x80, 0x0B, 0x39), -- ACTIVE_COLOR
            lcd.RGB(0x63, 0x34, 0x47), -- INACTIVE_COLOR
            lcd.RGB(0x80, 0x0B, 0x39), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0x8A, 0x48, 0x62), -- BUTTON_BORDER_COLOR
            lcd.RGB(0x70, 0x33, 0x00), -- WARNING_COLOR
            lcd.RGB(0xFF, 0xFF, 0xFF), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0xFF, 0xDD, 0xE8), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-cherry-press.png"),
        toolbarLogo = "none",
    })

    -- Lime Voltage: Acid-lime panels, chalk-white pages and indigo controls inspired by racing instruments.
    system.registerTheme({
        key = "LimeVlt",
        name = "Lime Voltage",
        darkMode = false,
        roundButtons = false,
        focusStyle = "invert",
        borderWidth = 4,
        colors = {
            lcd.RGB(0x11, 0x20, 0x00), -- PRIMARY_COLOR
            lcd.RGB(0xE3, 0xF5, 0xAB), -- SECONDARY_BGCOLOR
            lcd.RGB(0x20, 0x31, 0x78), -- HIGHLIGHT_COLOR
            lcd.RGB(0xFF, 0xFF, 0xFF), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x61, 0x70, 0x3C), -- DISABLE_COLOR
            lcd.RGB(0xF7, 0xFC, 0xE9), -- PRIMARY_BGCOLOR
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0x28, 0x3C, 0x13), -- SECONDARY_COLOR
            lcd.RGB(0x16, 0x4A, 0x28), -- SAFE_COLOR
            lcd.RGB(0xFF, 0xFF, 0xFF), -- PAGE_BGCOLOR
            lcd.RGB(0x92, 0x0C, 0x24), -- ERROR_COLOR
            lcd.RGB(0x20, 0x31, 0x78), -- ACTIVE_COLOR
            lcd.RGB(0x3D, 0x50, 0x24), -- INACTIVE_COLOR
            lcd.RGB(0x20, 0x31, 0x78), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0x54, 0x65, 0x2D), -- BUTTON_BORDER_COLOR
            lcd.RGB(0x66, 0x38, 0x00), -- WARNING_COLOR
            lcd.RGB(0xFF, 0xFF, 0xFF), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0xE3, 0xF5, 0xAB), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-lime-voltage.png"),
        toolbarLogo = "none",
    })

    -- Carbon Beacon: Pitch black and graphite with beacon-yellow focus and white-hot lettering.
    system.registerTheme({
        key = "CarbBcn",
        name = "Carbon Beacon",
        darkMode = true,
        roundButtons = false,
        focusStyle = "invert",
        borderWidth = 4,
        colors = {
            lcd.RGB(0xFF, 0xFF, 0xFF), -- PRIMARY_COLOR
            lcd.RGB(0x24, 0x24, 0x24), -- SECONDARY_BGCOLOR
            lcd.RGB(0xFF, 0xE0, 0x52), -- HIGHLIGHT_COLOR
            lcd.RGB(0x10, 0x10, 0x10), -- HIGHLIGHT_INVERT_COLOR
            lcd.RGB(0x8D, 0x8D, 0x8D), -- DISABLE_COLOR
            lcd.RGB(0x08, 0x08, 0x08), -- PRIMARY_BGCOLOR
            lcd.RGB(0x00, 0x00, 0x00), -- OVERLAY_COLOR
            lcd.RGB(0xEB, 0xE2, 0xC5), -- SECONDARY_COLOR
            lcd.RGB(0xA7, 0xFF, 0x91), -- SAFE_COLOR
            lcd.RGB(0x00, 0x00, 0x00), -- PAGE_BGCOLOR
            lcd.RGB(0xFF, 0x9F, 0xA7), -- ERROR_COLOR
            lcd.RGB(0xFF, 0xE0, 0x52), -- ACTIVE_COLOR
            lcd.RGB(0xB8, 0xB8, 0xB8), -- INACTIVE_COLOR
            lcd.RGB(0xFF, 0xE0, 0x52), -- BUTTON_BORDER_ACTIVE_COLOR
            lcd.RGB(0x8B, 0x8B, 0x8B), -- BUTTON_BORDER_COLOR
            lcd.RGB(0xFF, 0xD1, 0x96), -- WARNING_COLOR
            lcd.RGB(0x10, 0x1B, 0x0C), -- SAFE_CONTRASTING_COLOR
            lcd.RGB(0x08, 0x08, 0x08), -- TOPLCD_BGCOLOR
        },
        toolbarBackground = lcd.loadBitmap("header-carbon-beacon.png"),
        toolbarLogo = "none",
    })

    -- Arctic Radar: A deep polar cockpit with luminous cyan controls and lime radar status.
    system.registerTheme({
        key = "ArctRdr",
        name = "Arctic Radar",
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
            lcd.RGB(0xC4, 0xFF, 0x87), -- SAFE_COLOR
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

end

return {
    init = init
}
