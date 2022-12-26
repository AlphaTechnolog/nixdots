local wibox = require 'wibox'
local helpers = require 'helpers'
local gears = require 'gears'
local awful = require 'awful'
local beautiful = require 'beautiful'

local clear_notification = wibox.widget {
  {
    markup = '',
    font = beautiful.nerd_font .. ' 20',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox,
  },
  forced_height = 32,
  forced_width = 32,
  bg = beautiful.dimblack,
  shape = gears.shape.circle,
  widget = wibox.container.background
}

helpers.add_hover(clear_notification, beautiful.dimblack, beautiful.light_black)

clear_notification:add_button(awful.button({}, 1, function ()
  awesome.emit_signal('dashboard::clear_notifications')
end))

local header = wibox.widget {
  {
    markup = '<b>Notification center</b>',
    font = beautiful.font_name .. ' 18',
    widget = wibox.widget.textbox,
  },
  {
    clear_notification,
    halign = 'right',
    valign = 'center',
    layout = wibox.container.place,
  },
  layout = wibox.layout.stack,
}

return header
