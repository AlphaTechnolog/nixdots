local awful = require 'awful'
local beautiful = require 'beautiful'

local content = require 'ui.bar.content'

---@diagnostic disable-next-line: undefined-global
screen.connect_signal('request::desktop_decoration', function (s)
    awful.tag(
        {'1', '2', '3', '4', '5', '6'},
        s, awful.layout.layouts[1]
    )

	local bar = awful.popup {
    type = 'dock',
		x = s.geometry.x,
		y = s.geometry.y + (s.geometry.height - beautiful.bar_height),
		minimum_width = s.geometry.width,
		minimum_height = beautiful.bar_height,
		ontop = false,
		visible = true,
		widget = content(s)
	}

	bar:struts { bottom = beautiful.bar_height }
end)
