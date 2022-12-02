local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")

local sep = require("ui.bar.modules.sep")

local launcher = require("ui.bar.modules.launcher")
local workspaces = require("ui.bar.modules.workspaces")
local stats = require("ui.bar.modules.stats")
local dock = require("ui.bar.modules.dock")
local dashboard_toggler = require("ui.bar.modules.dashboard_toggler")
local clock = require("ui.bar.modules.clock")
local tray = require("ui.bar.modules.tray")
local layoutbox = require("ui.bar.modules.layoutbox")

screen.connect_signal("request::desktop_decoration", function (s)
	local tags = {'1', '2', '3', '4', '5', '6'}

	awful.tag(tags, s, awful.layout.layouts[1])

	local bar = wibox {
		type = 'dock',
		x = s.geometry.x,
    y = s.geometry.y,
		height = beautiful.bar_height,
		width = s.geometry.width,
		ontop = false,
		visible = true,
	}

  bar:setup {
    {
      {
        launcher,
        workspaces(s),
        sep,
        stats,
        spacing = 4,
        layout = wibox.layout.fixed.horizontal,
      },
      nil,
      {
        dashboard_toggler,
        clock,
        sep,
        tray(s),
        sep,
        layoutbox(s),
        spacing = 4,
        layout = wibox.layout.fixed.horizontal,
      },
      layout = wibox.layout.align.horizontal,
    },
    {
      dock(s),
      halign = "center",
      valign = "center",
      layout = wibox.container.place,
    },
    layout = wibox.layout.stack,
  }

	bar:struts { top = beautiful.bar_height }
end)
