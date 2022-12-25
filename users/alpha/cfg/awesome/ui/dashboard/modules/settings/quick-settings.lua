local wibox = require 'wibox'
local helpers = require 'helpers'
local beautiful = require 'beautiful'
local awful = require 'awful'
local gears = require 'gears'

local airplane_signal = require 'signal.airplane'
local bluetooth_signal = require 'signal.bluetooth'
local redshift_signal = require 'signal.redshift'
local network_signal = require 'signal.network'

local dimensions = require 'ui.dashboard.dimensions'

local TOGGLE = 'TOGGLE_ACTION'

local mkquicksetting = function (label, icon, onclick, iconsize)
  if not iconsize then
    iconsize = 26
  end

  iconsize = tostring(iconsize)

  local widget = wibox.widget {
    {
      {
        {
          id = 'action_icon',
          markup = icon,
          font = beautiful.nerd_font .. ' ' .. iconsize,
          align = 'center',
          valign = 'center',
          widget = wibox.widget.textbox,
        },
        id = 'action_button',
        shape = gears.shape.circle,
        forced_width = 48,
        forced_height = 48,
        bg = beautiful.light_black,
        widget = wibox.container.background,
      },
      valign = 'center',
      halign = 'center',
      layout = wibox.container.place,
    },
    {
      {
        {
          {
            markup = '<b>' .. label .. '</b>',
            valign = 'center',
            widget = wibox.widget.textbox,
          },
          {
            id = 'status_label',
            markup = 'Off',
            valign = 'center',
            widget = wibox.widget.textbox,
          },
          spacing = dimensions.spacing / 2,
          layout = wibox.layout.fixed.vertical,
        },
        valign = 'center',
        halign = 'left',
        layout = wibox.container.place,
      },
      left = dimensions.spacing,
      widget = wibox.container.margin,
    },
    layout = wibox.layout.align.horizontal,
    get_icon = function (self)
      return self:get_children_by_id('action_icon')[1]
    end,
    set_active = function (self, active)
      local icon = self:get_children_by_id('action_icon')[1]
      local button = self:get_children_by_id('action_button')[1]
      local status_label = self:get_children_by_id('status_label')[1]

      if active then
        button.bg = beautiful.blue
        button.fg = beautiful.bg_normal
        status_label.markup = 'On'
      else
        button.bg = beautiful.light_black
        button.fg = beautiful.fg_normal
        status_label.markup = 'Off'
      end
    end
  }

  widget.is_active = false

  local button = widget:get_children_by_id('action_button')[1]

  button:add_button(awful.button({}, 1, function ()
    if onclick then
      onclick(function (a)
        local value = a
        if value == TOGGLE then
          value = not widget.is_active
        end

        widget.is_active = value
        widget.active = value
      end)
    end
  end))

  return widget
end

local airplane = mkquicksetting('Airplane Mode', '', function (set_active)
  airplane_signal.toggle()
  set_active(TOGGLE)
end)

awesome.connect_signal('airplane::enabled', function (is_enabled)
  airplane.active = is_enabled
  airplane.icon.markup = is_enabled and '' or ''
end)

local bluetooth = mkquicksetting('Bluetooth', '', function (set_active)
  bluetooth_signal.toggle()
  set_active(TOGGLE)
end, 22)

awesome.connect_signal('bluetooth::enabled', function (is_enabled)
  bluetooth.active = is_enabled
  bluetooth.icon.markup = is_enabled and '' or ''
end)

local redshift = mkquicksetting('Blue Light', '', function (set_active)
  redshift_signal.toggle()
  set_active(TOGGLE)
end)

awesome.connect_signal('redshift::active', function (is_active)
  redshift.active = is_active
  redshift.icon.markup = is_active and '' or ''
end)

local network = mkquicksetting('Wi-Fi', '睊', function (set_active)
  network_signal.toggle()
  set_active(TOGGLE)
end)

awesome.connect_signal('network::connected', function (is_connected)
  network.active = is_connected
  network.icon.markup = is_connected and '' or '睊'
end)

local volume = mkquicksetting('Volume', '', function (set_active)
  VolumeSignal.toggle_muted()
  set_active(TOGGLE)
end)

awesome.connect_signal('volume::muted', function (is_muted)
  volume.active = not is_muted
  volume.icon.markup = is_muted and '婢' or ''
end)

local quick_settings = wibox.widget {
  helpers.contained(dimensions.spacing, wibox.widget {
    airplane,
    bluetooth,
    redshift,
    spacing = dimensions.spacing / 2,
    layout = wibox.layout.flex.vertical,
  }),
  {
    helpers.contained(dimensions.spacing, network),
    helpers.contained(dimensions.spacing, volume),
    spacing = dimensions.spacing,
    layout = wibox.layout.flex.vertical,
  },
  spacing = dimensions.spacing,
  layout = wibox.layout.flex.horizontal,
}

return quick_settings
