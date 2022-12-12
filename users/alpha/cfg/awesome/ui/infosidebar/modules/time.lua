local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local dimensions = require("ui.infosidebar.dimensions")
local time_spacing = dimensions.spacing * 2

local hour_widgets = {}

hour_widgets.hour = wibox.widget.textbox()
hour_widgets.mins = wibox.widget.textbox()

hour_widgets.hour.font = beautiful.font_name .. " 40"
hour_widgets.mins.font = beautiful.font_name .. " 40"

gears.timer {
  timeout = 30, -- just to make sure ok!
  call_now = true,
  autostart = true,
  callback = function ()
    hour_widgets.hour.markup = "<b>" .. os.date("%H") .. "</b>"
    hour_widgets.mins.markup = "<b>" .. os.date("%M") .. "</b>"
  end,
}

local mkdot = function (color)
  return wibox.widget {
    wibox.widget.textbox(),
    forced_width = 14,
    forced_height = 14,
    bg = color,
    shape = gears.shape.circle,
    widget = wibox.container.background,
  }
end

hour_widgets.sep = wibox.widget {
  mkdot(beautiful.blue),
  mkdot(beautiful.cyan),
  mkdot(beautiful.aqua),
  spacing = spacing,
  layout = wibox.layout.flex.vertical,
}

local hour = wibox.widget {
  hour_widgets.hour,
  {
    hour_widgets.sep,
    left = dimensions.spacing * 2,
    right = dimensions.spacing * 2,
    widget = wibox.container.margin,
  },
  hour_widgets.mins,
  layout = wibox.layout.align.horizontal,
}

local date = wibox.widget.textbox()

date.align = "center"

local update_date = function ()
  date.markup = "<b>" .. os.date("%A %B %d") .. "</b>"
end

gears.timer {
  timeout = 1200,
  call_now = true,
  autostart = true,
  callback = update_date
}

local time = wibox.widget {
  {
    {
      hour,
      date,
      spacing = dimensions.spacing * 2,
      layout = wibox.layout.fixed.vertical,
    },
    halign = "center",
    layout = wibox.container.place,
  },
  top = time_spacing,
  bottom = time_spacing,
  widget = wibox.container.margin,
}

return time
