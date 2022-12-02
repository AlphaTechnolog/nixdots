local wibox = require("wibox")

local mktray = function (s)
  return wibox.widget.systray {
    screen = s,
    forced_height = 14,
    forced_width = 14,
    horizontal = true
  }
end

return function (s)
  return wibox.widget {
    mktray(s),
    margins = 6,
    widget = wibox.container.margin,
  }
end
