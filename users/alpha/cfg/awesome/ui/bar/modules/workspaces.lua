local wibox = require("wibox")
local awful = require("awful")
local helpers = require("helpers")
local beautiful = require("beautiful")

local function mktaglist(s)
  return awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
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
    layout = {
      spacing = 4,
      layout = wibox.layout.fixed.horizontal,
    },
    widget_template = {
      id = 'custom_bg_role',
      forced_width = 14,
      forced_height = 5,
      shape = helpers.mkroundedrect(1),
      widget = wibox.container.background,
      create_callback = function (self, tag)
        local bg = self:get_children_by_id("custom_bg_role")[1]

        self.update = function ()
          if tag.selected then
            bg.bg = beautiful.blue
          elseif #tag:clients() > 0 then
            bg.bg = beautiful.light_black
          else
            bg.bg = beautiful.black
          end
        end

        self.update()
      end,
      update_callback = function (self)
        if self.update then
          self.update()
        end
      end
    }
  }
end

return function (s)
  local taglist = mktaglist(s)

  return wibox.widget {
    {
      taglist,
      valign = 'center',
      layout = wibox.container.place,
    },
    top = 6,
    bottom = 6,
    left = 4,
    widget = wibox.container.margin,
  }
end
