local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")

local dimensions = require("ui.dashboard.dimensions")

local hour = wibox.widget {
  markup = '<b>00:00 AM</b>',
  font = beautiful.font_name .. ' 42',
  align = 'center',
  widget = wibox.widget.textbox,
}

local function update_hour ()
  hour.markup = "<b>" .. os.date("%I:%M %p") .. "</b>"
end

gears.timer {
  timeout = 30,
  call_now = true,
  autostart = true,
  callback = update_hour
}

local day = wibox.widget {
  markup = 'Loading...',
  align = 'center',
  widget = wibox.widget.textbox,
}

local function update_day ()
  day.markup = os.date("%A %B %d")
end

gears.timer {
  timeout = 240,
  call_now = true,
  callback = update_day,
  autostart = true,
}

local date = wibox.widget {
  {
    {
      hour,
      day,
      spacing = dimensions.spacing / 2.5,
      layout = wibox.layout.fixed.vertical,
    },
    margins = dimensions.spacing * 2,
    widget = wibox.container.margin,
  },
  bg = beautiful.bg_lighter,
  shape = helpers.mkroundedrect(7),
  widget = wibox.container.background,
}

return date
