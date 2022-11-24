local awful = require 'awful'
local wibox = require 'wibox'
local beautiful = require 'beautiful'
local gears = require 'gears'
local helpers = require 'helpers'

local function close_button (c)
	local b = wibox.widget {
		{
			{
				markup = '',
				font = beautiful.nerd_font .. ' 13',
				widget = wibox.widget.textbox,
			},
			top = 4,
			bottom = 4,
			left = 9,
			right = 9,
			widget = wibox.container.margin,
		},
		shape = gears.shape.circle,
		bg = beautiful.black,
		widget = wibox.container.background
	}

	helpers.add_hover(b, beautiful.black, beautiful.dimblack)

	b:add_button(awful.button({}, 1, function ()
		c:kill()
	end))

	return b
end

client.connect_signal('request::titlebars', function (c)
	if c.requests_no_titlebar then
		return
	end

	local titlebar = awful.titlebar(c, {
		position = 'top',
		size = 40,
	})

	local titlebars_buttons = {
		awful.button({}, 1, function ()
			c:activate {
				context = 'titlebar',
				action = 'mouse_move',
			}
		end),
		awful.button({}, 3, function ()
			c:activate {
				context = 'titlebar',
				action = 'mouse_resize',
			}
		end)
	}

	local buttons_loader = {
		layout = wibox.layout.fixed.horizontal,
		buttons = titlebars_buttons,
	}

	titlebar:setup {
		{
			awful.titlebar.widget.titlewidget(c),
			left = 14,
			widget = wibox.container.margin,
			buttons = titlebars_buttons,
		},
		buttons_loader,
		{
			{
				{
					close_button(c),
					margins = 8,
					widget = wibox.container.margin,
				},
				layout = wibox.layout.fixed.horizontal,
			},
			right = 4,
			widget = wibox.container.margin,
		},
		layout = wibox.layout.align.horizontal,
	}
end)
