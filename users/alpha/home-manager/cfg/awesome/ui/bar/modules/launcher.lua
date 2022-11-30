local wibox = require 'wibox'
local beautiful = require 'beautiful'
local helpers = require 'helpers'
local awful = require 'awful'

local launcher = wibox.widget {
	{
		{
			image = beautiful.nixos_icon,
			forced_height = 20,
			forced_width = 20,
			halign = 'center',
			valign = 'center',
			widget = wibox.widget.imagebox,
		},
		top = 10,
		bottom = 10,
		left = 2,
		right = 2,
		widget = wibox.container.margin,
	},
	bg = beautiful.bg_normal,
	shape = helpers.mkroundedrect(),
	widget = wibox.container.background,
}

local transition = helpers.add_hover(launcher, beautiful.bg_normal, beautiful.black)

launcher:add_button(awful.button({}, 1, function ()
	transition.off()
  LauncherObject:toggle()
end))

return wibox.widget {
	launcher,
	top = 2,
	widget = wibox.container.margin,
}
