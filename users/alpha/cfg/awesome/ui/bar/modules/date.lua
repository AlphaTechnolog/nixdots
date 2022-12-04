local wibox = require 'wibox'
local gears = require 'gears'

local date = wibox.widget.textbox()

local function update_date()
	date:set_markup_silently(os.date("%D - %I:%M %p"))
end

gears.timer {
	timeout = 30,
	call_now = true,
	autostart = true,
	callback = function ()
		update_date()
	end
}

return date
