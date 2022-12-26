local wibox = require("wibox")

local dimensions = require("ui.dashboard.dimensions")
local date = require("ui.dashboard.modules.date")
local profile = require("ui.dashboard.modules.profile")
local music = require("ui.dashboard.modules.music")
local calendar = require("ui.dashboard.modules.calendar")

local notifcenter = require("ui.dashboard.modules.notifcenter")

local info = wibox.widget {
  {
    date,
    profile,
    music,
    calendar,
    spacing = dimensions.spacing,
    layout = wibox.layout.fixed.vertical,
  },
  notifcenter,
  spacing = dimensions.spacing,
  layout = wibox.layout.flex.horizontal,
}

return info
