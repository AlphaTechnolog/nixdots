---@diagnostic disable: undefined-global
local wibox = require 'wibox'
local beautiful = require 'beautiful'
local gears = require 'gears'
local awful = require 'awful'
local helpers = require 'helpers'

local airplane_signal = require 'signal.airplane'
local bluetooth_signal = require 'signal.bluetooth'
local redshift_signal = require 'signal.redshift'
local mic_signal = require 'signal.mic'

local function make_base_widget (icon, title)
  return wibox.widget {
    {
      {
        {
          {
            id = 'icon_role',
            markup = icon,
            valign = 'center',
            font = beautiful.nerd_font .. ' 24',
            widget = wibox.widget.textbox,
          },
          left = 16,
          widget = wibox.container.margin,
        },
        {
					id = 'title_role',
          markup = title,
          valign = 'center',
          widget = wibox.widget.textbox,
        },
        spacing = 12,
        layout = wibox.layout.fixed.horizontal,
      },
			margins = 2,
      widget = wibox.container.margin,
    },
    shape = gears.shape.rounded_bar,
    bg = beautiful.bg_lighter,
    fg = beautiful.fg_normal,
    widget = wibox.container.background,
    set_icon = function (self, new_icon)
      self:get_children_by_id('icon_role')[1].markup = new_icon
    end,
		set_txt = function (self, new_label)
			self:get_children_by_id('title_role')[1].markup = new_label
		end,
    set_active = function (self, status)
      if not self.animation then
        self.animation = helpers.apply_transition {
          element = self,
          prop = 'bg',
          bg = beautiful.bg_lighter,
          hbg = beautiful.blue
        }
      end

      if status then
        self.animation.on()
        self.fg = beautiful.bg_normal
      else
        self.animation.off()
        self.fg = beautiful.fg_normal
      end
    end
  }
end

local network = make_base_widget('', 'Wi-Fi')

network:add_button(awful.button({}, 1, function ()
  NetworkSignal.toggle()
end))

awesome.connect_signal('network::connected', function (is_connected)
  network.icon = is_connected and '' or '睊'
  network.active = is_connected
	if not is_connected then
		network.txt = 'Wi-Fi'
	end
end)

awesome.connect_signal('network::ssid', function (ssid)
	network.txt = ssid
end)

local volume = make_base_widget('', 'Volume')

volume:add_button(awful.button({}, 1, function ()
	VolumeSignal.toggle_muted()
end))

awesome.connect_signal('volume::muted', function (is_muted)
	volume.icon = is_muted and '婢' or ''
	volume.active = not is_muted
end)

local mic = make_base_widget('', 'Mic')

mic:add_button(awful.button({}, 1, function ()
	mic_signal.toggle()
end))

awesome.connect_signal('mic::active', function (is_enabled)
	mic.icon = is_enabled and '' or ''
	mic.active = is_enabled
end)

local airplane = make_base_widget('', 'Airplane')

airplane:add_button(awful.button({}, 1, function ()
	airplane_signal.toggle()
end))

awesome.connect_signal('airplane::enabled', function (is_enabled)
	airplane.icon = is_enabled and '' or ''
	airplane.active = is_enabled
end)

local bluetooth = make_base_widget('', 'Bluetooth')

bluetooth:add_button(awful.button({}, 1, function ()
	bluetooth_signal.toggle()
end))

awesome.connect_signal('bluetooth::enabled', function (is_enabled)
	bluetooth.icon = is_enabled and '' or ''
	bluetooth.active = is_enabled
end)

local redshift = make_base_widget('', 'Blue Light')

redshift:add_button(awful.button({}, 1, function ()
	redshift_signal.toggle()
end))

awesome.connect_signal('redshift::active', function (is_active)
	redshift.icon = is_active and '' or ''
	redshift.active = is_active
end)

local first_row = wibox.widget {
  network,
  volume,
  bluetooth,
  spacing = 10,
  layout = wibox.layout.fixed.vertical,
}

local last_row = wibox.widget {
	airplane,
	mic,
	redshift,
	spacing = 10,
	layout = wibox.layout.fixed.vertical,
}

local container = wibox.widget {
  first_row,
  last_row,
  spacing = 10,
  layout = wibox.layout.flex.horizontal,
}

return container
