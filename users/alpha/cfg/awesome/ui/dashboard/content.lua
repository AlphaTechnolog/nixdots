local wibox = require 'wibox'
local beautiful = require 'beautiful'

local volume = require 'ui.dashboard.modules.volume-slider'
local music_player = require 'ui.dashboard.modules.music'
local actions = require 'ui.dashboard.modules.actions'
local charts = require 'ui.dashboard.modules.charts'
local footer = require 'ui.dashboard.modules.footer'

return {
  {
    {
      volume,
      music_player,
      actions,
      spacing = 10,
      layout = wibox.layout.fixed.vertical,
    },
    charts,
    footer,
    layout = wibox.layout.align.vertical,
  },
  margins = 10,
  widget = wibox.container.margin,
}
