local awful = require("awful")
local helpers = require("helpers")
local wibox = require("wibox")
local beautiful = require("beautiful")

local function mklayoutbox(s)
  local layoutbox = awful.widget.layoutbox { screen = s }

  layoutbox._layoutbox_tooltip:remove_from_object(layoutbox)

  local container = wibox.widget {
    {
      layoutbox,
      margins = 4,
      widget = wibox.container.margin,
    },
    shape = helpers.mkroundedrect(4),
    widget = wibox.container.background,
  }

  helpers.add_hover(container, beautiful.bg_normal, beautiful.black)

  helpers.add_buttons(container, {
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)
  })

  return container
end

return function (s)
  local layoutbox = mklayoutbox(s)

  return wibox.widget {
    layoutbox,
    margins = 4,
    widget = wibox.container.margin,
  }
end
