local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")

local rubato = require("modules.rubato")
local dimensions = require("ui.dashboard.dimensions")
local content = require("ui.dashboard.content")

require("ui.dashboard.listener")

awful.screen.connect_for_each_screen(function (s)
  s.dashboard = {}

  s.dashboard.popup = wibox {
    x = s.geometry.x + (s.geometry.width - ((s.geometry.width / 2) + (dimensions.width / 2))),
    y = s.geometry.y - dimensions.height - beautiful.useless_gap * 4,
    width = dimensions.width,
    height = dimensions.height,
    ontop = true,
    visible = false
  }

  local self = s.dashboard.popup

  local void = {
    markup = '',
    widget = wibox.widget.textbox
  }

  self:setup(void)

  self.animate = rubato.timed {
    duration = 0.45,
    pos = s.geometry.y - dimensions.height - beautiful.useless_gap * 4
  }

  self.status = 'undefined'

  self.animate:subscribe(function (pos)
    if self.status == 'closing' and pos == s.geometry.y + beautiful.useless_gap * 4 + beautiful.bar_height then
      self:setup(void)
    elseif self.status == 'opening' and pos == s.geometry.y + beautiful.useless_gap * 4 + beautiful.bar_height then
      self:setup(content)
    end
    if self.status == 'closing' and pos == s.geometry.y - dimensions.height - beautiful.useless_gap * 4 then
      self.visible = false
    end
    self.y = pos
  end)

  function s.dashboard.toggle ()
    if self.visible then
      s.dashboard.hide()
    else
      s.dashboard.show()
    end
  end

  function s.dashboard.show ()
    self.visible = true
    self.status = 'opening'
    self.animate.target = s.geometry.y + beautiful.useless_gap * 4 + beautiful.bar_height
  end

  function s.dashboard.hide ()
    self.status = 'closing'
    self.animate.target = s.geometry.y - dimensions.height - beautiful.useless_gap * 4
  end
end)
