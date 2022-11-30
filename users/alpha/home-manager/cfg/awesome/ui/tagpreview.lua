local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local bling = require "modules.bling"

bling.widget.tag_preview.enable {
  show_client_content = true,
  scale = 0.25,
  honor_padding = false,
  honor_workarea = false,
  placement_fn = function (c)
    awful.placement.top_left(c, {
      margins = {
        left = beautiful.bar_width + beautiful.useless_gap * 2,
        top = beautiful.useless_gap * 2,
      }
    })
  end,
  background_widget = wibox.widget {
    image = beautiful.wallpaper,
    horizontal_fit_policy = "fit",
    vertical_fit_policy = "fit",
    widget = wibox.widget.imagebox,
  }
}
