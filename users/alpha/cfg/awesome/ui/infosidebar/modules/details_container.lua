local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local dimensions = require("ui.infosidebar.dimensions")
local calendar = require("ui.infosidebar.modules.details.calendar")
local searchbox = require("ui.infosidebar.modules.details.searchbox")

local content = wibox.widget {
  calendar,
  searchbox,
  spacing = dimensions.spacing * 2,
  layout = wibox.layout.fixed.vertical,
}

local container = wibox.widget {
  {
    content,
    margins = dimensions.spacing * 2,
    widget = wibox.container.margin,
  },
  bg = beautiful.bg_lighter,
  widget = wibox.container.background,
  shape = function (cr, w, h)
    return gears.shape.partially_rounded_rect(cr, w, h, true, true, false, false, 12)
  end
}

return container
