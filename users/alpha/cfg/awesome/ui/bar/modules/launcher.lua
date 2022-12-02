local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local awful = require("awful")

local launcher = wibox.widget {
  widget = wibox.widget.imagebox,
  forced_height = 16,
  forced_width = 16,
  halign = "center",
  valign = "center",
  image = beautiful.nixos_icon,
}

local container = wibox.widget {
  {
    launcher,
    margins = 4,
    widget = wibox.container.margin,
  },
  shape = helpers.mkroundedrect(),
  widget = wibox.container.background,
}

helpers.add_hover(container, beautiful.bg_normal, beautiful.black)

container:add_button(awful.button({}, 1, function ()
  LauncherObject:toggle()
end))

return wibox.container.margin(
  container,
  6, 0, 4, 4
)
