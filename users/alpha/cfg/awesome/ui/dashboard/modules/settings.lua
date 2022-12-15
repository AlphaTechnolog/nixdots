local wibox = require("wibox")

local settings = wibox.widget {
  markup = 'settings',
  valign = 'center',
  align = 'center',
  widget = wibox.widget.textbox
}

return settings
