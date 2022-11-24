local wibox = require 'wibox'
local gears = require 'gears'
local awful = require 'awful'
local beautiful = require 'beautiful'
local helpers = require 'helpers'

local rubato = require 'modules.rubato'

local function get_taglist (s)
	return awful.widget.taglist {
		screen = s,
		filter = awful.widget.taglist.filter.all,
		layout = {
			spacing = 10,
			layout = wibox.layout.fixed.vertical,
		},
		buttons = {
            awful.button({}, 1, function (t)
                t:view_only()
            end),
            awful.button({}, 4, function (t)
                awful.tag.viewprev(t.screen)
            end),
            awful.button({}, 5, function (t)
                awful.tag.viewnext(t.screen)
            end)
        },
		widget_template = {
			{
				id = 'bg_role',
				shape = gears.shape.rounded_bar,
				bg = beautiful.dimblack,
				forced_height = 8,
				forced_width = 8,
				widget = wibox.container.background,
			},
			halign = 'center',
			layout = wibox.container.place,
			create_callback = function (self, tag)
				local bg = self:get_children_by_id('bg_role')[1]

				self.animate = rubato.timed { duration = 0.25 }

				self.animate:subscribe(function (pos)
					bg.forced_height = pos
				end)

				self.blue_transition = helpers.apply_transition {
					element = bg,
					prop = 'bg',
					bg = beautiful.dimblack,
					hbg = beautiful.blue
				}

				self.update = function ()
					if tag.selected then
						self.animate.target = 18
						self.blue_transition.on()
					elseif #tag:clients() > 0 then
						self.animate.target = 14
						self.blue_transition.off()
					else
						self.animate.target = 8
						self.blue_transition.off()
					end
				end

				self.update()
			end,
			update_callback = function (self)
				self.update()
			end
		}
}
end

local function main (s)
	local bg = wibox.widget {
		{
			get_taglist(s),
			top = 14,
			bottom = 14,
			widget = wibox.container.margin,
		},
		bg = beautiful.bg_lighter,
		shape = gears.shape.rounded_bar,
		widget = wibox.container.background,
	}

	helpers.add_hover(bg, beautiful.bg_lighter, beautiful.black)

	local container = wibox.widget {
		bg,
		left = 4,
		right = 4,
		widget = wibox.container.margin,
	}

	return container
end

return main
