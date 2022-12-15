local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local gears = require("gears")
local awful = require("awful")

local rubato = require("modules.rubato")

local tabs_layout = wibox.layout.fixed.horizontal()

tabs_layout.spacing = 1

-- index defines which part (right or left) should be rounded
-- it's also the "id" of the tab.
local mktab = function (label, index)
  local shape = function (cr, w, h)
    return gears.shape.partially_rounded_rect(
      cr, w, h,
      index == 0, -- top left if it's 0
      index == 1, -- top right if it's 1
      index == 1, -- bottom right if it's 1
      index == 0, -- bottom left if it's 0
      7
    )
  end

  local w = wibox.widget {
    {
      {
        markup = label,
        align = 'center',
        valign = 'center',
        widget = wibox.widget.textbox,
      },
      top = 6,
      bottom = 6,
      widget = wibox.container.margin,
    },
    bg = beautiful.black,
    shape = shape,
    forced_width = 70,
    widget = wibox.container.background,
  }

  local bg_transition = helpers.apply_transition {
    element = w,
    prop = 'bg',
    bg = beautiful.black,
    hbg = beautiful.dimblack,
  }

  awesome.connect_signal('dashboard::tabs::set_active', function (active_index)
    if active_index == index then
      bg_transition.on()
    else
      bg_transition.off()
    end
  end)

  w:add_button(awful.button({}, 1, function ()
    awesome.emit_signal('dashboard::tabs::set_active', index)
  end))

  return w
end

local info_tab = mktab('Info', 0)
local settings_tab = mktab('Settings', 1)

awesome.emit_signal('dashboard::tabs::set_active', 0)

tabs_layout:add(info_tab)
tabs_layout:add(settings_tab)

local tabs = wibox.widget {
  tabs_layout,
  valign = 'center',
  halign = 'center',
  widget = wibox.container.place,
}

-- @index 0
local info = require "ui.dashboard.modules.info"
local settings = require "ui.dashboard.modules.settings"

local content = wibox.layout.flex.horizontal()

local update_content = function(new_widget)
  local change_opacity = rubato.timed { duration = 0.45 }

  change_opacity:subscribe(function (val)
    content.opacity = val
  end)

  change_opacity.target = 0
  content:reset()
  content:add(new_widget)
  change_opacity.target = 1
end

update_content(info)

-- set the right widget for the content
awesome.connect_signal("dashboard::tabs::set_active", function (active_index)
  local active_widget = content.children[1]
  local old_index = active_widget == info and 0 or 1

  if old_index ~= active_index then
    update_content(active_index == 0 and info or settings)
  end
end)

-- widgets getter
return function ()
  return tabs, content
end
