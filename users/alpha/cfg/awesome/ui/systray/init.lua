---@diagnostic disable: undefined-global
local awful = require 'awful'
local beautiful = require 'beautiful'
local gears = require 'gears'

local rubato = require 'modules.rubato'

local void = require 'ui.void'
local dimensions = require 'ui.systray.dimensions'
local content = require 'ui.systray.content'

require 'ui.systray.listener'

awful.screen.connect_for_each_screen(function (s)
	s.systray = {}

	local w = content(s)

	s.systray.popup = awful.popup {
		minimum_width = dimensions.width,
		minimum_height = 1,
		y = s.geometry.height - beautiful.bar_height - beautiful.useless_gap * 4,
		x = s.geometry.width - beautiful.useless_gap * 2 - dimensions.width - 127,
		ontop = true,
		visible = false,
		widget = void(true)
	}

	local self = s.systray.popup

	self.status = 'undefined'

	self.animate_height = rubato.timed { duration = 0.25 }

	self.animate_y = rubato.timed {
		duration = 0.25,
		pos = s.geometry.height - beautiful.bar_height - beautiful.useless_gap * 4
	}

	self.animate_height:subscribe(function (pos)
		if pos >= 1 then
			self.minimum_height = pos
		end

		if pos == dimensions.height and self.status == 'opening' then
			self:setup(w)
		elseif self.status == 'closing' then
			self:setup(void(false))
		end

		if pos == 0 and self.status == 'closing' then
			self.visible = false
			awesome.emit_signal('systray::opened', false)
		end
	end)

	self.animate_y:subscribe(function (pos)
		self.y = pos
	end)

	function s.systray.toggle()
		if self.visible then
			s.systray.hide()
		else
			s.systray.show()
		end
	end

	function s.systray.show()
		self.status = 'opening'
		self.visible = true
		self.animate_height.target = dimensions.height
		self.animate_y.target = s.geometry.height - beautiful.bar_height - beautiful.useless_gap * 4 - dimensions.height
		awesome.emit_signal('systray::opened', true)
	end

	function s.systray.hide()
		self.status = 'closing'
		self.animate_height.target = 0
		self.animate_y.target = s.geometry.height - beautiful.bar_height - beautiful.useless_gap * 4
	end
end)
