local wibox = require 'wibox'
local beautiful = require 'beautiful'
local helpers = require 'helpers'
local naughty = require 'naughty'
local gears = require 'gears'
local awful = require 'awful'

local dimensions = require 'ui.dashboard.dimensions'

local layout = wibox.layout.fixed.vertical()

layout.spacing = dimensions.spacing

awesome.connect_signal('dashboard::clear_notifications', function ()
  layout:reset()
end)

local mknotifcard = function (n)
  local widget = wibox.widget {
    {
      {
        {
          {
            id = 'icon_role',
            visible = false,
            forced_height = 32,
            forced_width = 32,
            valign = 'center',
            clip_shape = gears.shape.circle,
            widget = wibox.widget.imagebox,
          },
          {
            id = 'app_name_role',
            font = beautiful.font_name .. ' ' .. tostring(tonumber(beautiful.font_size) + 2),
            widget = wibox.widget.textbox,
          },
          spacing = dimensions.spacing,
          layout = wibox.layout.fixed.horizontal,
        },
        {
          {
            {
              id = 'title_role',
              widget = wibox.widget.textbox,
            },
            {
              id = 'body_role',
              widget = wibox.widget.textbox
            },
            layout = wibox.layout.fixed.vertical,
          },
          top = dimensions.spacing,
          bottom = dimensions.spacing,
          widget = wibox.container.margin,
        },
        nil,
        layout = wibox.layout.align.vertical,
      },
      margins = dimensions.spacing,
      widget = wibox.container.margin,
    },
    bg = beautiful.bg_lighter,
    shape = helpers.mkroundedrect(),
    widget = wibox.container.background,
    set_app_name = function (self, appname)
      self:get_children_by_id('app_name_role')[1].markup = '<b>' .. appname .. '</b>'
    end,
    set_title = function (self, title)
      local wt = self:get_children_by_id('title_role')[1]
      if not title then
        wt.visible = false
      else
        wt.markup = '<b>' .. title .. '</b>'
      end
    end,
    set_body = function (self, body)
      local wb = self:get_children_by_id('body_role')[1]
      if not body then
        wb.visible = false
      else
        wb.markup = body
      end
    end,
    set_icon = function (self, icon)
      local wi = self:get_children_by_id('icon_role')[1]
      if icon then
        wi.visible = true
        wi.image = icon
      end
    end
  }

  -- hydratate widget
  widget.app_name = n.app_name or 'Unknown App'
  widget.icon = n.icon or nil
  widget.title = n.title or nil
  widget.body = n.text or nil

  return widget
end

naughty.connect_signal('request::display', function (n)
  layout:insert(1, mknotifcard(n))
end)

local add_button_event = function(widget)
	widget:buttons(gears.table.join(
		awful.button({}, 4, nil, function()
			if #widget.children == 1 then
				return
			end
			widget:insert(1, widget.children[#widget.children])
			widget:remove(#widget.children)
		end),
		awful.button({}, 5, nil, function()
			if #widget.children == 1 then
				return
			end
			widget:insert(#widget.children + 1, widget.children[1])
			widget:remove(1)
		end)
	))
end

add_button_event(layout)

return layout
