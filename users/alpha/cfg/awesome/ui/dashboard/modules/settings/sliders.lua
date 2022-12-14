local wibox = require 'wibox'
local beautiful = require 'beautiful'
local gears = require 'gears'
local helpers = require 'helpers'

local dimensions = require 'ui.dashboard.dimensions'

local brightness_signal = require 'signal.brightness'

local function mkslider(icon)
  return wibox.widget {
    {
      {
        id = 'slider_role',
        value = 100,
        handle_color = beautiful.blue,
        handle_width = 44,
        bar_border_width = 0,
        bar_active_color = beautiful.blue,
        bar_color = beautiful.blue .. '4D', -- 30% of transparency
        bar_shape = helpers.mkroundedrect(12),
        widget = wibox.widget.slider,
        bar_height = 44,
        forced_height = 44,
        forced_width = 230,
        handle_shape = function (cr, w, h)
          return gears.shape.partially_rounded_rect(cr, w, h, false, true, true, false, 12)
        end,
      },
      {
        {
          {
            id = 'icon_role',
            markup = icon,
            font = beautiful.nerd_font .. ' 20',
            align = 'center',
            valign = 'bottom',
            widget = wibox.widget.textbox,
          },
          direction = 'west',
          widget = wibox.container.rotate,
        },
        fg = beautiful.bg_normal,
        widget = wibox.container.background,
      },
      layout = wibox.layout.stack,
    },
    direction = 'east',
    widget = wibox.container.rotate,
    get_slider = function (self)
      return self:get_children_by_id('slider_role')[1]
    end,
    set_value = function (self, val)
      self.slider.value = val
    end,
    set_icon = function (self, new_icon)
      self:get_children_by_id('icon_role')[1].markup = new_icon
    end
  }
end

local volume = mkslider('')

volume.slider:connect_signal('property::value', function (_, value)
  VolumeSignal.set(value, false)
end)

awesome.connect_signal('volume::value', function (volval)
  volume.value = volval
end)

awesome.connect_signal('volume::muted', function (muted)
  volume.icon = muted
    and '婢'
    or ''
end)

local brightness = mkslider('')

brightness.slider:connect_signal('property::value', function (_, value)
  brightness_signal.set(value)
end)

awesome.connect_signal('brightness::value', function (br_value)
  brightness.value = br_value
end)

local container = wibox.widget {
  {
    volume,
    brightness,
    spacing = dimensions.spacing * 2,
    layout = wibox.layout.fixed.horizontal,
  },
  halign = 'center',
  valign = 'bottom',
  layout = wibox.container.place,
}

return container
