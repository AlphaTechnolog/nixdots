local wibox = require 'wibox'
local beautiful = require 'beautiful'
local dpi = beautiful.xresources.apply_dpi

return function (s)
	return {
		{
			{
				{
					widget = wibox.widget.systray,
					horizontal = false,
					screen = s,
					base_size = 16,
				},
				layout = wibox.layout.fixed.horizontal,
			},
			margins = dpi(12),
			widget = wibox.container.margin,
		},
		bg = beautiful.bg_normal,
		fg = beautiful.fg_normal,
		widget = wibox.container.background,
	}
end
