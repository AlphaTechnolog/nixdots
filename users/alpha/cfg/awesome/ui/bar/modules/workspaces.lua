local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local awful = require("awful")

local icon_theme = require("modules.bling.helpers.icon_theme")
local theme = icon_theme()

local extract_icon = function (c)
  -- exceptions (add support for simple terminal and many mores).
  if c.class then
    if string.lower(c.class) == 'st' then
      return theme:get_icon_path(string.lower(c.class))
    end
  end

  -- has support for some others apps like spotify
  return theme:get_client_icon_path(c)
end

local mktag = function (tag)
  local content_layout = wibox.layout.fixed.horizontal()

  content_layout:add(wibox.widget {
    markup = tostring(tag.name),
    widget = wibox.widget.textbox,
  })

  local clients_layout = wibox.layout.fixed.horizontal()
  local margin_widget = wibox.container.margin()

  clients_layout.spacing = 6
  margin_widget.left = 0

  content_layout:add(margin_widget)
  content_layout:add(clients_layout)

  local update_clients = function ()
    clients_layout:reset()
    margin_widget.left = 0

    if #tag:clients() > 0 then
      margin_widget.left = 6
      for _, c in ipairs(tag:clients()) do
        clients_layout:add(wibox.widget {
          image = c.icon or extract_icon(c),
          valign = "center",
          forced_height = 16,
          forced_width = 16,
          widget = wibox.widget.imagebox,
        })
      end
    end
  end

  update_clients()

  client.connect_signal("request::manage", update_clients)
  client.connect_signal("request::unmanage", update_clients)
  client.connect_signal("tagged", update_clients)
  client.connect_signal("untagged", update_clients)

  local container = wibox.widget {
    {
      content_layout,
      top = 4,
      bottom = 4,
      left = 8,
      right = 8,
      widget = wibox.container.margin,
    },
    bg = beautiful.bg_lighter,
    shape = helpers.mkroundedrect(),
    widget = wibox.container.background
  }

  container:add_button(awful.button({}, 1, function ()
    tag:view_only()
  end))

  local active_transition = helpers.apply_transition {
    element = container,
    prop = 'bg',
    bg = beautiful.bg_lighter,
    hbg = beautiful.dimblack,
  }

  local update_tag_status = function ()
    if tag.selected then
      active_transition.on()
    else
      active_transition.off()
    end
  end

  update_tag_status()

  tag:connect_signal('property::selected', update_tag_status)

  return container
end

return function (s)
  local layout = wibox.layout.fixed.horizontal()

  layout.spacing = 6

  for _, tag in ipairs(s.tags) do
    layout:add(mktag(tag))
  end

  return layout
end