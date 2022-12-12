local wibox = require("wibox")

local launcher = require("ui.bar.modules.launcher")
local searchbox = require("ui.bar.modules.searchbox")
local dispatch_infosidebar = require("ui.bar.modules.dispatch_infosidebar")
local workspaces = require("ui.bar.modules.workspaces")
local dispatch_dashboard = require("ui.bar.modules.dispatch_dashboard")
local infobox = require("ui.bar.modules.infobox")
local powermenu = require("ui.bar.modules.powermenu")

return function (s)
  return {
    {
      {
        {
          launcher,
          searchbox,
          dispatch_infosidebar,
          spacing = 6,
          layout = wibox.layout.fixed.horizontal,
        },
        left = 6,
        widget = wibox.container.margin,
      },
      nil,
      {
        {
          dispatch_dashboard,
          infobox(s),
          powermenu,
          spacing = 6,
          layout = wibox.layout.fixed.horizontal,
        },
        right = 6,
        widget = wibox.container.margin,
      },
      layout = wibox.layout.align.horizontal,
    },
    {
      workspaces(s),
      halign = 'center',
      valign = 'center',
      layout = wibox.container.place,
    },
    layout = wibox.layout.stack,
  }
end
