local awful = require("awful")

local _ = function ()
  return awful.screen.focused()
end

awesome.connect_signal("infosidebar::toggle", function ()
  _().infosidebar.toggle()
end)
