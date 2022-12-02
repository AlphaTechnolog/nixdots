local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")

local toggler = wibox.widget {
  {
    {
      markup = helpers.get_colorized_markup("", beautiful.blue),
      font = beautiful.nerd_font .. " 16",
      widget = wibox.widget.textbox,
    },
    top = 2,
    bottom = 2,
    left = 6,
    right = 6,
    widget = wibox.container.margin,
  },
  shape = helpers.mkroundedrect(4),
  widget = wibox.container.background,
}

helpers.add_hover(toggler, beautiful.bg_normal, beautiful.black)

local container = wibox.widget {
  toggler,
  margins = 6,
  widget = wibox.container.margin,
}

return container
