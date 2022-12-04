local wibox = require 'wibox'
local gears = require 'gears'
local beautiful = require 'beautiful'

local pfp = wibox.widget {
	clip_shape = gears.shape.circle,
	forced_width = 32,
	forced_height = 32,
	image = beautiful.pfp,
	widget = wibox.widget.imagebox,
}

local container = wibox.widget {
	{
		pfp,
		valign = 'center',
		layout = wibox.container.place,
	},
	top = beautiful.useless_gap,
	bottom = beautiful.useless_gap,
	widget = wibox.container.margin,
}

return container
