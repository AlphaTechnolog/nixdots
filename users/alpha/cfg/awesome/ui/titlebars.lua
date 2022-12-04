---@diagnostic disable: undefined-global
local wibox = require 'wibox'
local awful = require 'awful'
local helpers = require 'helpers'
local gears = require 'gears'
local beautiful = require 'beautiful'

local dpi = beautiful.xresources.apply_dpi

local function make_button(label, onclick)
	return function (c)
		local button = wibox.widget {
			{
				{
					markup = label,
					font = beautiful.icons_font .. ' 10',
					valign = 'center',
					align = 'center',
					widget = wibox.widget.textbox,
				},
				right = 1,
				widget = wibox.container.margin,
			},
			forced_height = 24,
			forced_width = 25,
			bg = beautiful.black,
			fg = beautiful.fg_normal,
			shape = gears.shape.circle,
			widget = wibox.container.background,
		}

		local transition = helpers.add_hover(button, beautiful.dimblack, beautiful.light_black)

		button:add_button(awful.button({}, 1, function ()
			transition.off()
			if onclick then
				onclick(c)
			end
		end))

		return button
	end
end

local minimize_button = make_button('', function (c)
	gears.timer.delayed_call(function ()
		c.minimized = not c.minimized
	end)
end)

local maximize_button = make_button('', function (c)
	c.maximized = not c.maximized
end)

local close_button = make_button('', function (c)
	c:kill()
end)

client.connect_signal('request::titlebars', function (c)
	if c.requests_no_titlebar then
		return
	end

	local buttons = {
		awful.button({}, 1, function ()
			c:emit_signal('request::activate', 'titlebar', { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function ()
			c:emit_signal('request::activate', 'titlebar', { raise = true })
			awful.mouse.client.resize(c)
		end)
	}

	local titlebar = awful.titlebar(c, {
		size = 40,
		position = 'top'
	})

	local buttons_loader = wibox.widget {
		layout = wibox.layout.fixed.horizontal,
		buttons = buttons
	}

	local title = awful.titlebar.widget.titlewidget(c)

	title.align = 'center'
	title.valign = 'center'
	title.buttons = buttons

	titlebar:setup {
		buttons_loader,
		title,
		{
			{
				close_button(c),
				spacing = dpi(7),
				layout = wibox.layout.fixed.horizontal,
			},
			right = dpi(12),
			widget = wibox.container.margin,
		},
		layout = wibox.layout.align.horizontal,
	}
end)
