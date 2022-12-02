local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")

local sep = wibox.widget {
  {
    markup = helpers.get_colorized_markup("|", beautiful.light_black),
    widget = wibox.widget.textbox,
  },
  top = 4,
  bottom = 6,
  widget = wibox.container.margin,
}

return sep
