local wibox = require 'wibox'

local header = require 'ui.dashboard.modules.notifcenter.header'
local body = require 'ui.dashboard.modules.notifcenter.body'

local dimensions = require 'ui.dashboard.dimensions'

local notifcenter = wibox.widget {
  header,
  {
    body,
    top = dimensions.spacing,
    widget = wibox.container.margin,
  },
  layout = wibox.layout.align.vertical,
}

return notifcenter
