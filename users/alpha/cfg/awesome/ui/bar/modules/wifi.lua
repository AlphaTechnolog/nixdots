local wibox = require 'wibox'
local awful = require 'awful'
local beautiful = require 'beautiful'
local helpers = require 'helpers'

local network = wibox.widget.textbox()

network.font = beautiful.icons_font .. ' 13'
network.markup = ''

local tooltip = helpers.make_popup_tooltip('Toggle Wi-Fi', function (d)
	return awful.placement.bottom_right(d, {
		margins = {
			bottom = beautiful.bar_height + beautiful.useless_gap * 3,
			right = beautiful.useless_gap * 22,
		}
	})
end)

tooltip.attach_to_object(network)

network:add_button(awful.button({}, 1, function ()
	NetworkSignal.toggle(true)
end))

---@diagnostic disable-next-line: undefined-global
awesome.connect_signal('network::connected', function (is_connected)
	network:set_markup_silently(is_connected and '' or '')
end)

-- solve some alignment issues
return {
	network,
	bottom = 2,
	widget = wibox.container.margin,
}
