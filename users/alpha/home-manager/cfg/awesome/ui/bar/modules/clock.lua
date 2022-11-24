local wibox = require 'wibox'
local beautiful = require 'beautiful'
local gears = require 'gears'

local function atext ()
	local t = wibox.widget.textbox()

	t.align = 'center'

	return t
end

local hours, mins = atext(), atext()

local hours_c = wibox.widget {
	hours,
	fg = beautiful.magenta,
	widget = wibox.widget.background
}

local function update_hours ()
	hours.markup = os.date("%H")
end

local function update_mins ()
	mins.markup = os.date("%M")
end

gears.timer {
	timeout = 1000,
	call_now = true,
	autostart = true,
	callback = function ()
		update_hours()
		update_mins()
	end,
}

return wibox.widget {
	hours_c,
	mins,
	spacing = 3,
	layout = wibox.layout.fixed.vertical,
}
