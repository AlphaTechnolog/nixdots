local wibox = require 'wibox'
local beautiful = require 'beautiful'
local dpi = beautiful.xresources.apply_dpi

local pfp = require 'ui.bar.modules.pfp'
local dock = require 'ui.bar.modules.dock'
local dropdown = require 'ui.bar.modules.dropdown'
local airplane = require 'ui.bar.modules.airplane'
local network = require 'ui.bar.modules.wifi'
local volume = require 'ui.bar.modules.volume'
local date = require 'ui.bar.modules.date'

return function (s)
    return {
        {
            {
                pfp,
                nil,
                {
                    dropdown,
                    airplane,
                    network,
                    volume,
                    date,
                    spacing = dpi(8),
                    layout = wibox.layout.fixed.horizontal,
                },
                layout = wibox.layout.align.horizontal,
            },
            left = beautiful.useless_gap * 2,
            right = beautiful.useless_gap * 2,
            widget = wibox.container.margin,
        },
        {
            dock(s),
            halign = 'center',
            layout = wibox.container.place,
        },
        layout = wibox.layout.stack,
    }
end
