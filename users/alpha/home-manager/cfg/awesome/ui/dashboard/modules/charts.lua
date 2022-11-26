---@diagnostic disable: undefined-global
local wibox = require 'wibox'
local beautiful = require 'beautiful'
local helpers = require 'helpers'
local xresources = require 'beautiful.xresources'

local dpi = xresources.apply_dpi

require 'signal.cpu'
require 'signal.ram'

local layout = wibox.layout.flex.horizontal()

layout.spacing = 12

local function mkchart(header, icon)
	return wibox.widget {
		{
			{
				{
					{
						{
							markup = header,
							widget = wibox.widget.textbox,
						},
						fg = beautiful.light_black,
						widget = wibox.container.background,
					},
					left = beautiful.useless_gap * 2,
					widget = wibox.container.margin,
				},
				{
					{
						{
							{
								{
									{
										markup = icon,
										font = beautiful.nerd_font .. ' 34',
										widget = wibox.widget.textbox,
									},
									direction = 'south',
									widget = wibox.container.rotate,
								},
								halign = 'center',
								valign = 'center',
								layout = wibox.container.place,
							},
							id = 'chart',
							value = 0,
							max_value = 1,
							min_value = 0,
							forced_height = 124,
							forced_width = 124,
							widget = wibox.container.radialprogressbar,
							border_color = beautiful.dimblack,
							color = beautiful.blue,
							border_width = dpi(10),
						},
						direction = 'south',
						widget = wibox.container.rotate,
					},
					halign = 'center',
					layout = wibox.container.place,
				},
				nil,
				layout = wibox.layout.align.vertical,
			},
			margins = beautiful.useless_gap * 2,
			widget = wibox.container.margin,
		},
		shape = helpers.mkroundedrect(14),
		bg = beautiful.bg_contrast,
		widget = wibox.container.background,
		set_chart_value = function (self, value)
			self:get_children_by_id('chart')[1].value = value
		end
	}
end

local cpu = mkchart('CPU', '')
local ram = mkchart('RAM', '')

awesome.connect_signal('cpu::percent', function (percent)
	-- cpu chart could break sometimes, idk why, but throws some errors
	-- sometimes, so, i'll handle errors lol.
	local function get_percent()
		return percent / 100
	end

	if pcall(get_percent) then
		cpu.chart_value = get_percent()
	end
end)

awesome.connect_signal('ram::used', function (used)
	ram.chart_value = used / 100
end)

layout:add(cpu)
layout:add(ram)

local container = wibox.widget {
	layout,
	top = 10,
	bottom = 10,
	widget = wibox.container.margin,
}

return container
