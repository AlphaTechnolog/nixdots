local wibox = require 'wibox'
local gears = require 'gears'
local beautiful = require 'beautiful'
local helpers = require 'helpers'

local slider = wibox.widget {
  bar_shape = gears.shape.rounded_bar,
  bar_active_color = beautiful.blue,
  bar_color = beautiful.bg_lighter,
  bar_height = 32,
  forced_height = 32,
  forced_width = 120,
  handle_width = 32,
  handle_color = beautiful.blue,
  handle_border_width = 0,
  handle_shape = gears.shape.circle,
  value = 100,
  widget = wibox.widget.slider,
}

slider:connect_signal('property::value', function (_, v)
  VolumeSignal.set(v)
end)

local label = wibox.widget.textbox()

label.valign = 'center'
label.font = beautiful.nerd_font .. ' 24'

awesome.connect_signal('volume::value', function (value)
  slider.value = value
end)

awesome.connect_signal('volume::muted', function (is_muted)
  label:set_markup_silently(helpers.get_colorized_markup(
    not is_muted and '' or '婢',
    beautiful.bg_normal
  ))
end)

local container = wibox.widget {
  slider,
  {
    {
      label,
      left = 16,
      widget = wibox.container.margin,
    },
    halign = 'left',
    valign = 'center',
    layout = wibox.container.place,
  },
  layout = wibox.layout.stack,
}

return container
