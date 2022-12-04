local wibox = require 'wibox'
local beautiful = require 'beautiful'
local awful = require 'awful'
local helpers = require 'helpers'

local airplane_signal = require 'signal.airplane'

local airplane = wibox.widget.textbox()

airplane.font = beautiful.icons_font .. ' 14'
airplane.markup = ''

local tooltip = helpers.make_popup_tooltip('Toggle Airplane Mode', function (d)
	return awful.placement.bottom_right(d, {
		margins = {
			bottom = beautiful.bar_height + beautiful.useless_gap * 3,
			right = beautiful.useless_gap * 22,
		}
	})
end)

tooltip.attach_to_object(airplane)

airplane:add_button(awful.button({}, 1, function ()
	airplane_signal.toggle()
end))

awesome.connect_signal('airplane::enabled', function (is_enabled)
	airplane:set_markup_silently(is_enabled and '' or '')
end)

return airplane
