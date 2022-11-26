local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local dimensions = require("ui.dashboard.dimensions")

local rubato = require("modules.rubato")

require 'ui.dashboard.listener'

awful.screen.connect_for_each_screen(function (s)
  s.dashboard = {}

  s.dashboard.popup = wibox {
    screen = s,
    visible = false,
    ontop = true,
    x = s.geometry.x - beautiful.useless_gap * 2 - dimensions.width,
    y = s.geometry.y + (s.geometry.height - beautiful.useless_gap * 2 - dimensions.height),
    width = dimensions.width,
    height = dimensions.height,
    bg = beautiful.bg_normal,
    fg = beautiful.fg_normal,
    opacity = 0
  }

  local self = s.dashboard.popup

  local content = require 'ui.dashboard.content'

  self:setup({ widget = wibox.widget.textbox })

  self.transition_animation = rubato.timed {
    duration = 0.45,
    override_dt = true,
    rate = 60,
    pos = 0
  }

  self.transition_animation:subscribe(function (op)
    self.opacity = op
  end)

  self.transition_animation.target = 0

  self.animate = rubato.timed {
    duration = 0.45,
    override_dt = true,
    rate = 60,
    pos = s.geometry.x - beautiful.useless_gap * 2 - dimensions.width,
  }

  self.status = 'undefined'

  self.animate:subscribe(function (pos)
    self.x = pos

    if pos == s.geometry.x + beautiful.bar_width + beautiful.useless_gap * 2 and self.status == 'opening' then
      self:setup(content)
    elseif self.status == 'closing' then
      self:setup { widget = wibox.widget.textbox }
    end

    if pos == s.geometry.x - beautiful.useless_gap * 2 - dimensions.width and self.status == 'closing' then
      self.visible = false
    end
  end)

  function s.dashboard.toggle()
    if self.visible then
      s.dashboard.close()
    else
      s.dashboard.open()
    end
  end

  function s.dashboard.open()
    self.status = 'opening'
    self.visible = true
    self.animate.target = s.geometry.x + beautiful.bar_width + beautiful.useless_gap * 2
    self.transition_animation.target = 1
  end

  function s.dashboard.close()
    self.status = 'closing'
    self.transition_animation.target = 0
    self.animate.target = s.geometry.x - dimensions.width - beautiful.useless_gap * 2
  end
end)
