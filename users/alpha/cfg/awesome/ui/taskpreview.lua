local awful = require "awful"
local beautiful = require "beautiful"
local wibox = require "wibox"
local bling = require "modules.bling"

local dimensions = {
  height = 300,
  width = 300
}

bling.widget.task_preview.enable {
  height = dimensions.height,
  width = dimensions.width,
  placement_fn = function (c)
    ((awful.placement.left(c, { margins = {
      left = beautiful.bar_width + beautiful.useless_gap * 2
    }})) + awful.placement.center_vertical)(c)
  end,
  widget_structure = {
    {
      {
        {
          id = 'icon_role',
          widget = awful.widget.clienticon,
        },
        {
          id = 'name_role',
          widget = wibox.widget.textbox,
        },
        layout = wibox.layout.flex.horizontal,
      },
      widget = wibox.container.margin,
      margins = 5,
    },
    {
      id = 'image_role',
      resize = true,
      valign = 'center',
      halign = 'center',
      widget = wibox.widget.imagebox,
    },
    layout = wibox.layout.fixed.vertical,
  }
}
