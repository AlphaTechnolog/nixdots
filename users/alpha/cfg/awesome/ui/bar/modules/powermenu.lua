local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local awful = require("awful")

local icon = wibox.widget.textbox()

icon.font = beautiful.nerd_font .. " 19"
icon.markup = helpers.get_colorized_markup("⏻", beautiful.red)

local button = wibox.widget {
  {
    icon,
    top = 4,
    bottom = 4,
    left = 8,
    right = 8,
    widget = wibox.container.margin,
  },
  bg = beautiful.bg_normal,
  shape = helpers.mkroundedrect(),
  widget = wibox.container.background,
}

helpers.add_hover(button, beautiful.bg_normal, beautiful.black)

button:add_button(awful.button({}, 1, function ()
  require 'naughty'.notify { title = 'needs to be implemented' }
end))

return wibox.widget {
  button,
  top = 6,
  bottom = 6,
  widget = wibox.container.margin,
}