---@diagnostic disable:undefined-global

local awful = require("awful")

client.connect_signal('request::manage', function (c)
  if not c.maximized then
    awful.placement.centered(c, {
      honor_workarea = true
    })
  end
end)
