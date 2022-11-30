local awful = require 'awful'
local wibox = require 'wibox'
local beautiful = require 'beautiful'
local gears = require 'gears'
local helpers = require 'helpers'

local icon_theme = require 'modules.bling.helpers.icon_theme'

local theme = icon_theme()

local function mkdock (s)
	return awful.widget.tasklist {
		screen = s,
		filter = awful.widget.tasklist.filter.allscreen,
		buttons = awful.button({}, 1, function (c)
			if c.active then
				c.minimized = true
				return
			end

			c:activate {
				context = 'through_dock',
				switch_to_tag = true
			}
		end),
		source = function ()
			local ret = {}

			for _, t in ipairs(s.tags) do
				gears.table.merge(ret, t:clients())
			end

			return ret
		end,
		layout = {
			spacing = 4,
			layout = wibox.layout.fixed.vertical,
		},
		widget_template = {
			{
				{
					id = 'clienticon_role',
					halign = 'center',
					valign = 'center',
					forced_width = 20,
					forced_height = 20,
					widget = wibox.widget.imagebox,
				},
				margins = 6,
				widget = wibox.container.margin,
			},
			id = 'bgrole',
			bg = beautiful.bg_normal,
			shape = helpers.mkroundedrect(),
			widget = wibox.container.background,
			create_callback = function (self, c)
				local function extract_icon ()
					if c.class then
            -- exceptions
						if string.lower(c.class) == 'st' then
							return theme:get_icon_path(string.lower(c.class))
            elseif string.lower(c.class) == 'telegram-desktop' or string.lower(c.class) == 'telegramdesktop' then
              return theme:get_icon_path('telegram')
						end
					end

					return theme:get_client_icon_path(c)
				end

				local clienticon = self:get_children_by_id('clienticon_role')[1]
				local icon = extract_icon()

				if icon then
					clienticon.image = icon
				end

				local bg_e = self:get_children_by_id('bgrole')[1]

				self.transition = helpers.apply_transition {
					element = bg_e,
					prop = 'bg',
					bg = beautiful.bg_normal,
					hbg = beautiful.black
				}

				self.update = function (cl)
					if cl.active then
						self.transition.on()
					else
						self.transition.off()
					end
				end

				self.update(c)

        -- enable bling's tasklist preview
        self:connect_signal('mouse::enter', function ()
          awesome.emit_signal('bling::task_preview::visibility', s, true, c)
        end)
        self:connect_signal('mouse::leave', function ()
          awesome.emit_signal('bling::task_preview::visibility', s, false, c)
        end)
			end,
			update_callback = function (self, c)
				self.update(c)
			end
		}
	}
end

local function get (s)
	local dock = mkdock(s)

	return wibox.widget {
		dock,
		left = 5,
		right = 5,
		widget = wibox.container.margin,
	}
end

return get
