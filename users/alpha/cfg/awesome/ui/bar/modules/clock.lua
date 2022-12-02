local gears = require("gears")
local wibox = require("wibox")

local clock = wibox.widget.textbox()

local function update_clock ()
  clock.markup = os.date("%I:%M %p")
end

gears.timer {
  timeout = 1000,
  call_now = true,
  autostart = true,
  callback = update_clock
}

return clock
