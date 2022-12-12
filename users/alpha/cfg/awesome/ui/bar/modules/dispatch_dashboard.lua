local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local awful = require("awful")

local icon = wibox.widget {
  markup = "",
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

helpers.add_hover(button, beautiful.bg_normal, beautiful.black)

button:add_button(awful.button({}, 1, function ()
  awesome.emit_signal("dashboard::toggle")
end))

return wibox.widget {
  button,
  top = 6,
  bottom = 6,
  widget = wibox.container.margin,
}
