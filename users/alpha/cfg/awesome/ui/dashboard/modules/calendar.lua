local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")

local dimensions = require("ui.infosidebar.dimensions")

local calendar = wibox.widget {
  date = os.date('*t'),
  font = beautiful.font_name .. ' 10',
  spacing = 2,
  widget = wibox.widget.calendar.month,
  fn_embed = function (widget, flag, date)
    local font = beautiful.font_name .. ' ' .. tostring(tonumber(beautiful.font_size) - 1)

    widget.font = font

    local focus_widget = wibox.widget {
      text = date.day,
      font = font,
      align = 'center',
      widget = wibox.widget.textbox,
    }

    local torender = flag == 'focus' and focus_widget or widget

    if flag == 'header' then
      torender.font = beautiful.font_name .. " 11"
    end

    local colors = {
      header = beautiful.blue,
      focus = beautiful.aqua,
      weekday = beautiful.cyan
    }

    local color = colors[flag] or beautiful.fg_normal

    return wibox.widget {
      {
        torender,
        margins = dimensions.spacing,
        widget = wibox.container.margin,
      },
      bg = flag == 'focus' and beautiful.dimblack or beautiful.bg_lighter,
      fg = color,
      widget = wibox.container.background,
      shape = flag == 'focus' and gears.shape.circle or helpers.mkroundedrect(12),
    }
  end
}

local container = wibox.widget {
  {
    calendar,
    halign = "center",
    valign = 'center',
    layout = wibox.container.place,
  },
  bg = beautiful.bg_lighter,
  shape = helpers.mkroundedrect(12),
  widget = wibox.container.background,
}

return container
