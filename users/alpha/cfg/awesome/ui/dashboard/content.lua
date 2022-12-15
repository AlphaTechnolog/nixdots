local wibox = require("wibox")

local tabbed = require("ui.dashboard.modules.tabbed")
local dimensions = require("ui.dashboard.dimensions")

local tabs, content = tabbed()

return {
  {
    tabs,
    {
      content,
      top = dimensions.spacing,
      widget = wibox.container.margin,
    },
    nil,
    layout = wibox.layout.align.vertical,
  },
  margins = dimensions.spacing,
  widget = wibox.container.margin,
}
