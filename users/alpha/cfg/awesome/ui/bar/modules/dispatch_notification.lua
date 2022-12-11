local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local awful = require("awful")

local icon = wibox.widget {
  markup = helpers.get_colorized_markup("", beautiful.blue),
  font = beautiful.nerd_font .. " 19",
  widget = wibox.widget.textbox,
}

local button = wibox.widget {
  {
    icon,
    top = 4,
    bottom = 4,
    left = 8,
    right = 8,
    widget = wibox.container.margin,
  },
  shape = helpers.mkroundedrect(),
  bg = beautiful.bg_normal,
  widget = wibox.container.background,
}

helpers.add_hover(button, beautiful.bg_normal, beautiful.dimblack)

button:add_button(awful.button({}, 1, function ()
  require 'naughty'.notify { title = 'needs to be implemented' }
end))

return wibox.widget {
  button,
  top = 6,
  bottom = 6,
  widget = wibox.container.margin,
}