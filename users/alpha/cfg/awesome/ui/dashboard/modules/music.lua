local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")
local awful = require("awful")

local rubato = require("modules.rubato")
local bling = require("modules.bling")

local playerctl = bling.signal.playerctl.lib()

-- player chip
local player_chip = wibox.widget {
	{
		{
			{
				markup = '',
				font = beautiful.nerd_font .. ' 10',
				valign = 'center',
				widget = wibox.widget.textbox,
			},
			{
				{
					id = 'playername',
					markup = nil,
					align = 'center',
					valign = 'center',
					widget = wibox.widget.textbox,
				},
				left = 7,
				widget = wibox.container.margin,
			},
			nil,
			layout = wibox.layout.align.horizontal,
		},
		top = 1,
		bottom = 1,
		left = 12,
		right = 12,
		widget = wibox.container.margin,
	},
	bg = beautiful.green,
	fg = beautiful.bg_normal,
	shape = gears.shape.rounded_bar,
	widget = wibox.container.background,
	forced_width = 19,
	opacity = 0.50,
	visible = false,
	set_player = function (self, name)
		self:get_children_by_id('playername')[1].markup = name
	end
}

local chip_reveal = rubato.timed {
	duration = 0.25,
	pos = 19
}

local chip_opacity = rubato.timed {
	duration = 0.25,
	pos = 0.50,
}

chip_reveal:subscribe(function (position)
	player_chip.forced_width = position
end)

chip_opacity:subscribe(function (op)
	player_chip.opacity = op
end)

player_chip:connect_signal('mouse::enter', function ()
	chip_reveal.target = 82
	chip_opacity.target = 1
end)

player_chip:connect_signal('mouse::leave', function ()
	chip_reveal.target = 19
	chip_opacity.target = 0.50
end)

playerctl:connect_signal('metadata', function (_, _, _, _, _, _, name)
	player_chip.visible = true
	player_chip.player = name
end)

playerctl:connect_signal('no_players', function ()
	player_chip.visible = false
end)

-- picture
local picture = wibox.widget {
	image = beautiful.fallback_music,
	clip_shape = helpers.mkroundedrect(),
	forced_width = 64,
	forced_height = 64,
	valign = 'center',
	halign = 'center',
	widget = wibox.widget.imagebox,
}

playerctl:connect_signal('metadata', function (_, _, _, p)
	picture:set_image(gears.surface.load_uncached(p))
end)

playerctl:connect_signal('no_players', function ()
	picture:set_image(gears.surface.load_uncached(beautiful.fallback_music))
end)

-- metadata
local title = wibox.widget.textbox()

title.markup = '<b>Not playing yet</b>'
title.font = beautiful.font_name .. ' ' .. tostring(tonumber(beautiful.font_size) + 1)

local artist = wibox.widget.textbox()

artist.markup = 'No artist detected'

playerctl:connect_signal('metadata', function (_, t, a)
	if t and t ~= '' then
		title:set_markup_silently('<b>' .. t .. '</b>')
	end
	if a and a ~= '' then
		artist:set_markup_silently('By ' .. a)
	end
end)

playerctl:connect_signal('no_players', function ()
	title:set_markup_silently('<b>Not playing yet</b>')
	artist:set_markup_silently('No artist detected')
end)

-- progress slider
local progress = wibox.widget {
	bar_shape = gears.shape.rounded_bar,
	bar_height = 6,
	bar_color = beautiful.dimblack,
	bar_active_color = beautiful.blue,
	forced_height = 6,
	handle_width = 0,
	value = 0,
	widget = wibox.widget.slider,
}

local by_update = false

progress:connect_signal('property::value', function (_, value)
	if by_update then
		by_update = false
		return
	end

	playerctl:set_position(value)
end)

playerctl:connect_signal('position', function (_, interval_sec, length_sec)
	by_update = true
	progress.maximum = length_sec
	progress.value = interval_sec
end)

-- controls
local previous = wibox.widget {
	{
		markup = '',
		align = 'center',
		valign = 'center',
		widget = wibox.widget.textbox,
	},
	forced_height = 24,
	forced_width = 24,
	shape = gears.shape.circle,
	bg = beautiful.bg_lighter,
	widget = wibox.container.background,
}

helpers.add_hover(previous, beautiful.bg_lighter, beautiful.dimblack)

previous:add_button(awful.button({}, 1, function ()
	playerctl:previous()
end))

local pause = wibox.widget {
	{
		id = 'icon_role',
		markup = '',
		font = beautiful.font_name .. ' ' .. tostring(tonumber(beautiful.font_size) + 6),
		align = 'center',
		valign = 'center',
		widget = wibox.widget.textbox,
	},
	forced_height = 24,
	forced_width = 24,
	shape = gears.shape.circle,
	bg = beautiful.bg_lighter,
	widget = wibox.container.background,
	set_icon = function (self, v)
		self:get_children_by_id('icon_role')[1].markup = v
	end,
	set_font = function (self, f)
		self:get_children_by_id('icon_role')[1].font = f
	end
}

helpers.add_hover(pause, beautiful.bg_lighter, beautiful.dimblack)

pause:add_button(awful.button({}, 1, function ()
	playerctl:play_pause()
end))

playerctl:connect_signal('playback_status', function (_, playing)
	pause.icon = playing and '' or ''

	if playing then
		pause.font = beautiful.font_name .. ' ' .. tostring(tonumber(beautiful.font_size) + 2)
	else
		pause.font = beautiful.font_name .. ' ' .. tostring(tonumber(beautiful.font_size) + 6)
	end
end)

playerctl:connect_signal('no_players', function ()
	pause.icon = ''
end)

local next = wibox.widget {
	{
		markup = '',
		align = 'center',
		valign = 'center',
		widget = wibox.widget.textbox,
	},
	forced_height = 24,
	forced_width = 24,
	shape = gears.shape.circle,
	bg = beautiful.bg_lighter,
	widget = wibox.container.background,
}

helpers.add_hover(next, beautiful.bg_lighter, beautiful.dimblack)

next:add_button(awful.button({}, 1, function ()
	playerctl:next()
end))

local music_player = wibox.widget {
	{
		{
			nil,
			{
				picture,
				{
					{
						{
							{
								title,
								artist,
								spacing = 5,
								layout = wibox.layout.fixed.vertical,
							},
							halign = 'left',
							valign = 'center',
							layout = wibox.container.place,
						},
						{
							player_chip,
							halign = 'right',
							valign = 'top',
							layout = wibox.container.place,
						},
						layout = wibox.layout.stack,
					},
					left = 15,
					widget = wibox.container.margin,
				},
				nil,
				layout = wibox.layout.align.horizontal,
			},
			{
				{
					nil,
					progress,
					{
						{
							previous,
							pause,
							next,
							spacing = 4,
							widget = wibox.layout.fixed.horizontal,
						},
						left = 4,
						widget = wibox.container.margin,
					},
					layout = wibox.layout.align.horizontal,
				},
				top = 7,
				widget = wibox.container.margin,
			},
			layout = wibox.layout.align.vertical,
		},
		margins = 12,
		widget = wibox.container.margin,
	},
	shape = helpers.mkroundedrect(),
	bg = beautiful.bg_lighter,
	widget = wibox.container.background,
}

return music_player
