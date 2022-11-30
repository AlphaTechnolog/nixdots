local awful = require 'awful'
local gears = require 'gears'
local wibox = require 'wibox'
local helpers = require 'helpers'
local beautiful = require 'beautiful'

local function original_layoutbox (s)
	local layoutbox = awful.widget.layoutbox {
		screen = s,
		forced_height = 16,
		forced_width = 16,
	}

	layoutbox._layoutbox_tooltip:remove_from_object(layoutbox)

	return layoutbox
end

local function container (s)
	local e = wibox.widget {
		{
			{
				original_layoutbox(s),
				halign = 'center',
				layout = wibox.container.place,
			},
			top = 12,
			bottom = 12,
			left = 5,
			right = 5,
			widget = wibox.container.margin,
		},
		shape = helpers.mkroundedrect(),
		bg = beautiful.bg_normal,
		widget = wibox.container.background
	}

	helpers.add_hover(e, beautiful.bg_normal, beautiful.black)

  helpers.add_buttons(e, {
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)
  })

	return e
end

return container
