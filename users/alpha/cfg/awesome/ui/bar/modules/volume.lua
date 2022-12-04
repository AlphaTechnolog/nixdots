local wibox = require 'wibox'
local awful = require 'awful'
local beautiful = require 'beautiful'
local helpers = require 'helpers'

local volume = wibox.widget.textbox()

volume.font = beautiful.icons_font .. ' 14'
volume.markup = ''

local tooltip = helpers.make_popup_tooltip('Toggle Muted', function (d)
	return awful.placement.bottom_right(d, {
		margins = {
			bottom = beautiful.bar_height + beautiful.useless_gap * 3,
			right = beautiful.useless_gap * 18
		}
	})
end)

tooltip.attach_to_object(volume)

volume:add_button(awful.button({}, 1, function ()
	VolumeSignal.toggle_muted()
end))

---@diagnostic disable-next-line: undefined-global
awesome.connect_signal('volume::muted', function (is_muted)
	volume:set_markup_silently(is_muted and '' or '')
end)

return volume
