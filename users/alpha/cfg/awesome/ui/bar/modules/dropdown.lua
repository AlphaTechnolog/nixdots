---@diagnostic disable: undefined-global
local wibox = require 'wibox'
local awful = require 'awful'
local beautiful = require 'beautiful'
local helpers = require 'helpers'

local up = wibox.widget.textbox()

up.font = beautiful.icons_font .. ' 14'
up.markup = ''

local tooltip = helpers.make_popup_tooltip('Toggle systray', function (d)
	return awful.placement.bottom_right(d, {
		margins = {
			bottom = beautiful.useless_gap * 3 + beautiful.bar_height,
			right = beautiful.useless_gap * 30,
		}
	})
end)

up:connect_signal('mouse::enter', function ()
	if not awful.screen.focused().systray.popup.visible then
		tooltip.popup.visible = true
	end
end)

up:connect_signal('mouse::leave', function ()
	tooltip.popup.visible = false
end)

up:add_button(awful.button({}, 1, function ()
	awesome.emit_signal('systray::toggle')
end))

awesome.connect_signal('systray::opened', function (is_opened)
	up:set_markup_silently(is_opened and '' or '')
	if is_opened then
		tooltip.popup.visible = false
	end
end)

return up
