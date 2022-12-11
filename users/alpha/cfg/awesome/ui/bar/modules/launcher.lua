local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local awful = require("awful")

local image = wibox.widget {
  image = beautiful.launcher_icon,
  halign = "center",
  valign = "center",
  forced_height = 16,
  forced_width = 16,
  widget = wibox.widget.imagebox,
}

local container = wibox.widget {
  {
    image,
    top = 4,
    bottom = 4,
    left = 8,
    right = 8,
    widget = wibox.container.margin,
  },
  bg = beautiful.black,
  shape = helpers.mkroundedrect(),
  widget = wibox.container.background,
}

local transition = helpers.add_hover(container, beautiful.black, beautiful.dimblack)

container:add_button(awful.button({}, 1, function ()
  transition.off()
  awful.spawn("rofi -show drun")
end))

return wibox.widget {
  container,
  top = 6,
  bottom = 6,
  widget = wibox.container.margin,
}