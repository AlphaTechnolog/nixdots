local awful = require 'awful'
local beautiful = require 'beautiful'
local wibox = require 'wibox'

local launcher = require 'ui.bar.modules.launcher'
local taglist = require 'ui.bar.modules.taglist'
local dock = require 'ui.bar.modules.dock'
local clock = require 'ui.bar.modules.clock'
local launchers = require 'ui.bar.modules.launchers'
local layoutbox = require 'ui.bar.modules.layoutbox'

local function container (s)
	return {
		{
			{
				{
					launcher,
					taglist(s),
					spacing = 4,
					layout = wibox.layout.fixed.vertical,
				},
				nil,
				{
					launchers,
					clock,
					{
						layoutbox(s),
						bottom = 0,
						widget = wibox.container.margin,
					},
					spacing = 4,
					layout = wibox.layout.fixed.vertical,
				},
				layout = wibox.layout.align.vertical,
			},
			{
				dock(s),
				valign = 'center',
				layout = wibox.container.place,
			},
			layout = wibox.layout.stack,
		},
		margins = 6,
		widget = wibox.container.margin,
	}
end

---@diagnostic disable-next-line: undefined-global
screen.connect_signal('request::desktop_decoration', function (s)
	local tags = {'1', '2', '3', '4', '5', '6'}

	awful.tag(tags, s, awful.layout.layouts[1])

	local bar = awful.popup {
		type = 'dock',
		x = s.geometry.x,
		y = s.geometry.y,
		minimum_width = beautiful.bar_width,
		minimum_height = s.geometry.height,
		ontop = false,
		visible = true,
		widget = container(s)
	}

	bar:struts { left = beautiful.bar_width }
end)
