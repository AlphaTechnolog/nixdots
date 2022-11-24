local wibox = require 'wibox'
local awful = require 'awful'
local beautiful = require 'beautiful'
local helpers = require 'helpers'

local layout = wibox.layout.fixed.vertical()

layout.spacing = 4

local container = wibox.widget {
	layout,
	halign = 'center',
	layout = wibox.container.place,
}

local function itext(txt)
	local t = wibox.widget.textbox()

	t.markup = txt
	t.font = beautiful.nerd_font .. ' 18'

	local container = wibox.widget {
		{
			{
				t,
				halign = 'center',
				layout = wibox.container.place,
			},
			left = 10,
			right = 10,
			widget = wibox.container.margin,
		},
		bg = beautiful.bg_normal,
		shape = helpers.mkroundedrect(),
		widget = wibox.container.background
	}

	helpers.add_hover(container, beautiful.bg_normal, beautiful.black)

	return container
end

local function sbutton (cb)
	return awful.button({}, 1, function ()
		cb()
	end)
end

local dashboard = itext('舘')

layout:add(dashboard)

local notifications = itext('')

layout:add(notifications)

return container
