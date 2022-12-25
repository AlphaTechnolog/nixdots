local wibox = require 'wibox'
local helpers = require 'helpers'
local beautiful = require 'beautiful'

local dimensions = require 'ui.dashboard.dimensions'
local quick_settings = require 'ui.dashboard.modules.settings.quick-settings'
local core = require 'ui.dashboard.modules.settings.core'
local charts = require 'ui.dashboard.modules.settings.charts'

local settings = wibox.widget {
  quick_settings,
  core,
  {
    charts,
    valign = 'center',
    layout = wibox.container.place,
  },
  spacing = dimensions.spacing,
  layout = wibox.layout.flex.vertical,
}

return settings
