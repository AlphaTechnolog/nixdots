local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local awful = require("awful")

local icon = wibox.widget.textbox()

icon.font = beautiful.nerd_font .. ' 18'
icon.markup = ''

local button = wibox.widget {
  {
    icon,
    top = 4,
    bottom = 4,
    left = 9,
    right = 9,
    widget = wibox.container.margin,
  },
  bg = beautiful.black,
  shape = helpers.mkroundedrect(),
  widget = wibox.container.background,
}

helpers.add_hover(button, beautiful.black, beautiful.dimblack)

button:add_button(awful.button({}, 1, function ()
  require 'naughty'.notify { title = 'needs to be implemented' }
end))

return wibox.widget {
  button,
  top = 6,
  bottom = 6,
  widget = wibox.container.margin,
}