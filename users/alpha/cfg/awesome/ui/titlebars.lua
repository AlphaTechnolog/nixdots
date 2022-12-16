local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")

local mkbutton = function (color, onclick)
  return function (c)
    local button = wibox.widget {
      wibox.widget.textbox(),
      forced_width = 14,
      forced_height = 14,
      bg = color,
      shape = gears.shape.circle,
      widget = wibox.container.background,
    }

    local color_transition = helpers.apply_transition {
      element = button,
      prop = 'bg',
      bg = color,
      hbg = beautiful.black,
    }

    client.connect_signal("property::active", function ()
      if c.active then
        color_transition.off()
      else
        color_transition.on()
      end
    end)

    button:add_button(awful.button({}, 1, function ()
      if onclick then
        onclick(c)
      end
    end))

    return button
  end
end

local close = mkbutton(beautiful.red, function (c)
  c:kill()
end)

local maximize = mkbutton(beautiful.yellow, function (c)
  c.maximized = not c.maximized
end)

local minimize = mkbutton(beautiful.green, function (c)
  gears.timer.delayed_call(function ()
    c.minimized = true
  end)
end)

client.connect_signal("request::titlebars", function (c)
  if c.requests_no_titlebar then
    return
  end

  local titlebar = awful.titlebar(c, {
    position = "top",
    size = 39,
  })

  local controls_layout = wibox.layout.fixed.horizontal()

  controls_layout.spacing = 6

  controls_layout:add(close(c))
  controls_layout:add(maximize(c))
  controls_layout:add(minimize(c))

  local buttons = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    buttons = {
      awful.button({ }, 1, function()
        c:activate { context = "titlebar", action = "mouse_move"  }
      end),
      awful.button({ }, 3, function()
        c:activate { context = "titlebar", action = "mouse_resize"}
      end),
    }
  }

  titlebar:setup {
    {
      controls_layout,
      left = 14,
      widget = wibox.container.margin,
    },
    buttons,
    buttons,
    layout = wibox.layout.align.horizontal
  }
end)
