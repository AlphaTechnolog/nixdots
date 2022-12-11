local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local content = require("ui.bar.content")

---@diagnostic disable-next-line: undefined-global
screen.connect_signal('request::desktop_decoration', function (s)
  awful.tag(
    {'1', '2', '3', '4', '5', '6'},
    s, awful.layout.layouts[1]
  )

  local bar = wibox {
    x = s.geometry.x + beautiful.useless_gap * 2,
    y = s.geometry.y + beautiful.useless_gap * 2,
    width = s.geometry.width - beautiful.useless_gap * 4,
    height = beautiful.bar_height,
    ontop = false,
    visible = true,
  }

  bar:setup(content(s))

  bar:struts {
    top = beautiful.bar_height + beautiful.useless_gap * 2
  }
end)
