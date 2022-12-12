local wibox = require("wibox")
local beautiful = require("beautiful")

local time = require("ui.infosidebar.modules.time")
local details_container = require("ui.infosidebar.modules.details_container")
local dimensions = require("ui.infosidebar.dimensions")

return {
  {
    time,
    margins = dimensions.spacing,
    widget = wibox.container.margin,
  },
  details_container,
  layout = wibox.layout.align.vertical,
}
