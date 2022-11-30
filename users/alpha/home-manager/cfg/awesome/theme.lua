local xresources = require("beautiful.xresources")
local gears = require "gears"
local gfs = require("gears.filesystem")

local dpi = xresources.apply_dpi

-- paths
local themes_path = gfs.get_themes_dir()
local assets_path = gfs.get_configuration_dir() .. "assets/"

-- assets
local icons_path = assets_path .. "icons/"
local shapes_path = assets_path .. "shapes/"
local titlebar_assets_path = assets_path .. "titlebar/"

local theme = {}

-- fonts
theme.font_name = 'Product Sans'
theme.nerd_font = 'Iosekva NF'
theme.font_size = '10'
theme.font = theme.font_name .. ' ' .. theme.font_size

-- base colors
theme.black = '#151720'
theme.dimblack = '#1a1c25'
theme.light_black = '#262831'
theme.grey = '#666891'
theme.red = '#dd6777'
theme.yellow = '#ecd3a0'
theme.magenta = '#c296eb'
theme.green = '#90ceaa'
theme.blue = '#86aaec'
theme.cyan = '#93cee9'
theme.aqua = '#7bd9e6'

-- backgrounds
theme.bg_darker     = "#0b0d16"
theme.bg_normal     = "#0d0f18"
theme.bg_contrast   = "#0f111a"
theme.bg_lighter    = "#11131c"

-- elements bg
theme.bg_focus      = theme.bg_normal
theme.bg_urgent     = theme.red
theme.bg_minimize   = theme.bg_normal
theme.bg_systray    = theme.bg_normal

-- foregrounds
theme.fg_normal     = "#a5b6cf"
theme.fg_focus      = theme.fg_nromal
theme.fg_urgent     = theme.fg_normal
theme.fg_minimize   = theme.fg_normal

-- some actions bg colors
theme.actions = {
    bg = theme.bg_normal,
    contrast = theme.bg_contrast,
    lighter = theme.bg_lighter,
    fg = theme.fg_normal,
}

-- bar
theme.bar_width = 54

-- gaps and borders
theme.useless_gap         = dpi(8)
theme.border_width        = dpi(0)
theme.border_color_normal = theme.bg_normal
theme.border_color_active = theme.bg_normal
theme.border_color_marked = theme.bg_normal
theme.border_radius = dpi(10)

-- tasklist
theme.tasklist_plain_task_name = true
theme.tasklist_bg = theme.bg_normal
theme.tasklist_bg_focus = theme.dimblack
theme.tasklist_bg_urgent = theme.red .. '4D' -- 30% of transparency

-- systray
theme.systray_icon_spacing = dpi(12)
theme.systray_max_rows = 7

-- menu
theme.menu_font = theme.font
theme.menu_submenu_icon = gears.color.recolor_image(shapes_path .. "triangle.png", theme.fg_normal)
theme.menu_height = dpi(40)
theme.menu_width = dpi(180)
theme.menu_bg_focus = theme.bg_lighter

-- titlebar
theme.titlebar_bg = theme.bg_contrast
theme.titlebar_bg_focus = theme.bg_darker
theme.titlebar_fg = theme.fg_normal

-- wallpaper
theme.wallpaper = assets_path .. "wallpaper.jpg"

-- layouts
theme.layout_fairh = gears.color.recolor_image(themes_path.."default/layouts/fairhw.png", theme.fg_normal)
theme.layout_fairv = gears.color.recolor_image(themes_path.."default/layouts/fairvw.png", theme.fg_normal)
theme.layout_floating  = gears.color.recolor_image(themes_path.."default/layouts/floatingw.png", theme.fg_normal)
theme.layout_magnifier = gears.color.recolor_image(themes_path.."default/layouts/magnifierw.png", theme.fg_normal)
theme.layout_max = gears.color.recolor_image(themes_path.."default/layouts/maxw.png", theme.fg_normal)
theme.layout_fullscreen = gears.color.recolor_image(themes_path.."default/layouts/fullscreenw.png", theme.fg_normal)
theme.layout_tilebottom = gears.color.recolor_image(themes_path.."default/layouts/tilebottomw.png", theme.fg_normal)
theme.layout_tileleft   = gears.color.recolor_image(themes_path.."default/layouts/tileleftw.png", theme.fg_normal)
theme.layout_tile = gears.color.recolor_image(themes_path.."default/layouts/tilew.png", theme.fg_normal)
theme.layout_tiletop = gears.color.recolor_image(themes_path.."default/layouts/tiletopw.png", theme.fg_normal)
theme.layout_spiral  = gears.color.recolor_image(themes_path.."default/layouts/spiralw.png", theme.fg_normal)
theme.layout_dwindle = gears.color.recolor_image(themes_path.."default/layouts/dwindlew.png", theme.fg_normal)
theme.layout_cornernw = gears.color.recolor_image(themes_path.."default/layouts/cornernww.png", theme.fg_normal)
theme.layout_cornerne = gears.color.recolor_image(themes_path.."default/layouts/cornernew.png", theme.fg_normal)
theme.layout_cornersw = gears.color.recolor_image(themes_path.."default/layouts/cornersww.png", theme.fg_normal)
theme.layout_cornerse = gears.color.recolor_image(themes_path.."default/layouts/cornersew.png", theme.fg_normal)

-- icons
theme.nixos_icon = assets_path .. 'nixos.png'
theme.menu_icon = gears.color.recolor_image(icons_path .. "menu.svg", theme.fg_normal)
theme.hints_icon = gears.color.recolor_image(icons_path .. "hints.svg", theme.blue)
theme.powerbutton_icon = gears.color.recolor_image(icons_path .. "poweroff.svg", theme.red)
theme.poweroff_icon = icons_path .. 'poweroff.svg'

theme.volume_on = gears.color.recolor_image(icons_path .. 'volume-on.svg', theme.fg_normal)
theme.volume_muted = gears.color.recolor_image(icons_path .. 'volume-muted.svg', theme.fg_normal)

theme.network_connected = ''
theme.network_disconnected = '睊'

-- pfp
theme.pfp = assets_path .. 'pfp.png'

-- fallback music
theme.fallback_music = assets_path .. 'fallback-music.png'

-- fallback notification icon
theme.fallback_notif_icon = gears.color.recolor_image(icons_path .. 'hints.svg', theme.blue)

-- disable icon theme
theme.icon_theme = nil

-- task preview
theme.task_preview_widget_border_radius = dpi(7)
theme.task_preview_widget_bg = theme.bg_normal
theme.task_preview_widget_border_color = theme.bg_normal
theme.task_preview_widget_border_width = 0
theme.task_preview_widget_margin = dpi(10)

-- tag preview
theme.tag_preview_widget_border_radius = dpi(7)
theme.tag_preview_client_border_radius = dpi(7)
theme.tag_preview_client_opacity = 0.5
theme.tag_preview_client_bg = theme.bg_lighter
theme.tag_preview_client_border_color = theme.blue
theme.tag_preview_client_border_width = 1
theme.tag_preview_widget_bg = theme.bg_normal
theme.tag_preview_widget_border_color = theme.bg_normal
theme.tag_preview_widget_border_width = 0
theme.tag_preview_widget_margin = dpi(7)

-- tooltip
theme.tooltip_bg = theme.bg_normal
theme.tooltip_fg = theme.fg_normal

-- tabbed

-- For tabbed only
theme.tabbed_spawn_in_tab = true  -- whether a new client should spawn into the focused tabbing container

-- For tabbar in general
theme.tabbar_ontop  = false
theme.tabbar_radius = dpi(7)                -- border radius of the tabbar
theme.tabbar_style = "modern"         -- style of the tabbar ("default", "boxes" or "modern")
theme.tabbar_font = theme.font_name          -- font of the tabbar
theme.tabbar_size = 40                 -- size of the tabbar
theme.tabbar_position = "bottom"          -- position of the tabbar
theme.tabbar_bg_normal = theme.bg_normal     -- background color of the focused client on the tabbar
theme.tabbar_fg_normal = theme.fg_normal     -- foreground color of the focused client on the tabbar
theme.tabbar_bg_focus  = theme.bg_lighter    -- background color of unfocused clients on the tabbar
theme.tabbar_fg_focus  = theme.fg_normal     -- foreground color of unfocused clients on the tabbar
theme.tabbar_bg_focus_inactive = nil   -- background color of the focused client on the tabbar when inactive
theme.tabbar_fg_focus_inactive = nil   -- foreground color of the focused client on the tabbar when inactive
theme.tabbar_bg_normal_inactive = nil  -- background color of unfocused clients on the tabbar when inactive
theme.tabbar_fg_normal_inactive = nil  -- foreground color of unfocused clients on the tabbar when inactive
theme.tabbar_disable = false           -- disable the tab bar entirely

-- the following variables are currently only for the "modern" tabbar style
theme.tabbar_color_close = theme.red -- chnges the color of the close button
theme.tabbar_color_min   = theme.yellow -- chnges the color of the minimize button
theme.tabbar_color_float = theme.green -- chnges the color of the float button

return theme
