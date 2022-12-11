local wibox = require("wibox")
local awful = require("awful")
local helpers = require("helpers")
local gears = require("gears")
local beautiful = require("beautiful")

local layout = wibox.layout.fixed.horizontal()

layout.spacing = 12

layout.spacing_widget = wibox.widget {
  markup = helpers.get_colorized_markup("|", beautiful.light_black),
  align = "center",
  widget = wibox.widget.textbox,
}

local clock = wibox.widget.textbox()

local update_clock = function ()
  clock.markup = os.date("%I:%M %p")
end

gears.timer {
  timeout = 30,
  call_now = true,
  autostart = true,
  callback = update_clock
}

layout:add(clock)

return function (s)
  local lb = awful.widget.layoutbox {
    screen = s,
    forced_height = 16,
    forced_width = 16,
  }

  lb._layoutbox_tooltip:remove_from_object(lb)

  local layoutbox = wibox.widget {
    lb,
    valign = "center",
    layout = wibox.container.place,
  }

  layout:add(layoutbox)

  local container = wibox.widget {
    {
      layout,
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

  return wibox.widget {
    container,
    top = 6,
    bottom = 6,
    widget = wibox.container.margin,
  }
end