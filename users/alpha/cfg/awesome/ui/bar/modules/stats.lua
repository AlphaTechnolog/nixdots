local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")

require 'signal.ram'
require 'signal.cpu'

local memory_chart = wibox.widget {
  {
    markup = helpers.get_colorized_markup('', beautiful.magenta),
    font = beautiful.nerd_font .. ' 12',
    valign = 'center',
    align = 'center',
    widget = wibox.widget.textbox,
  },
  max_value = 100,
  thickness = 2,
  values = {0, 100},
  colors = {beautiful.magenta, beautiful.dimblack},
  start_angle = 11,
  widget = wibox.container.arcchart,
}

awesome.connect_signal('ram::used', function (used_ram)
  memory_chart.values = {used_ram, 100 - used_ram}
end)

local cpu_chart = wibox.widget {
  {
    markup = helpers.get_colorized_markup('', beautiful.yellow),
    font = beautiful.nerd_font .. ' 12',
    valign = 'center',
    align = 'center',
    widget = wibox.widget.textbox,
  },
  max_value = 100,
  thickness = 2,
  values = {0, 100},
  colors = {beautiful.yellow, beautiful.dimblack},
  start_angle = 11,
  widget = wibox.container.arcchart,
}

awesome.connect_signal('cpu::percent', function (used_cpu)
  cpu_chart.values = {used_cpu, 100 - used_cpu}
end)

local container = wibox.widget {
  {
    memory_chart,
    cpu_chart,
    spacing = 10,
    layout = wibox.layout.fixed.horizontal,
  },
  margins = 5,
  widget = wibox.container.margin,
}

return container
