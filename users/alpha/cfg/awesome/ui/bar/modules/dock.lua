local wibox = require("wibox")
local helpers = require("helpers")
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

local icon_theme = require("modules.bling.helpers.icon_theme")

local theme = icon_theme()

local function active_shape (cr, w, h)
  return gears.shape.partially_rounded_rect(cr, w, h, false, false, true, true, 4)
end

local function mktasklist(s)
  return awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.allscreen,
    layout = {
      spacing = 4,
      layout = wibox.layout.fixed.horizontal,
    },
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
    widget_template = {
      {
        id = "indicator_role",
        forced_height = 1,
        forced_width = 12,
        bg = beautiful.blue,
        shape = gears.shape.rectangle,
        widget = wibox.container.background,
      },
      {
        {
          {
            id = "clienticon",
            forced_height = 20,
            forced_width = 20,
            halign = "center",
            widget = wibox.widget.imagebox,
          },
          top = 3,
          bottom = 3,
          left = 1,
          right = 1,
          widget = wibox.container.margin,
        },
        id = "custom_bg_role",
        shape = helpers.mkroundedrect(4),
        widget = wibox.container.background,
      },
      layout = wibox.layout.fixed.vertical,
      create_callback = function (self, c)
        local bg = self:get_children_by_id("custom_bg_role")[1]
        local ci = self:get_children_by_id("clienticon")[1]
        local indicator = self:get_children_by_id("indicator_role")[1]

        local color_transition = helpers.apply_transition {
          element = indicator,
          prop = 'bg',
          bg = beautiful.bg_normal,
          hbg = beautiful.blue
        }

        self.update = function (cl)
          if cl.active then
            color_transition.on()
            bg.shape = active_shape
          else
            color_transition.off()
            bg.shape = helpers.mkroundedrect(4)
          end
        end

        self.update(c)

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

        local icon = extract_icon()

        if icon then
          ci.image = icon
        end

        helpers.add_hover(bg, beautiful.bg_normal, beautiful.black)
      end,
      update_callback = function (self, c)
        self.update(c)
      end
    }
  }
end

return function (s)
  local tasklist = mktasklist(s)

  return wibox.widget {
    tasklist,
    top = 4,
    bottom = 4,
    left = 4,
    widget = wibox.container.margin,
  }
end
