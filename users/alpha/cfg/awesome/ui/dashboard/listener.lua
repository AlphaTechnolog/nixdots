local awful = require("awful")

local _ = function ()
  return awful.screen.focused().dashboard
end

awesome.connect_signal("dashboard::toggle", function ()
  _().toggle()
end)
