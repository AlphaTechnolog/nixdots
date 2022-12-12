local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")

local dimensions = require("ui.infosidebar.dimensions")
local content = require("ui.infosidebar.content")

local rubato = require("modules.rubato")

require("ui.infosidebar.listener")

awful.screen.connect_for_each_screen(function (s)
  s.infosidebar = {}

  s.infosidebar.popup = awful.popup {
    minimum_width = dimensions.width,
    x = s.geometry.x - beautiful.useless_gap * 2  - dimensions.width,
    y = s.geometry.y + beautiful.bar_height + beautiful.useless_gap * 4,
    ontop = true,
    visible = false,
    widget = content,
  }

  local self = s.infosidebar.popup

  function s.infosidebar.toggle ()
    if self.visible then
      s.infosidebar.hide()
    else
      s.infosidebar.show()
    end
  end

  self.animate = rubato.timed {
    duration = 0.45,
    pos = s.geometry.x - beautiful.useless_gap * 2  - dimensions.width
  }

  self.status = 'undefined'

  self.animate:subscribe(function (v)
    self.x = v
    if self.x == s.geometry.x - beautiful.useless_gap * 2 - dimensions.width and self.status == 'closing' then
      self.visible = false
    end
  end)

  function s.infosidebar.show ()
    self.status = 'opening'
    self.visible = true
    self.animate.target = s.geometry.x + beautiful.useless_gap * 2
  end

  function s.infosidebar.hide ()
    self.status = 'closing'
    self.animate.target = s.geometry.x - beautiful.useless_gap * 2 - dimensions.width 
  end
end)
