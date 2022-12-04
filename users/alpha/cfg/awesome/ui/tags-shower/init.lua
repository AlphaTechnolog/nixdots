---@diagnostic disable: undefined-global
local awful = require 'awful'
local wibox = require 'wibox'
local beautiful = require 'beautiful'
local gears = require 'gears'

local get_content = require 'ui.tags-shower.content'
local dimensions = require 'ui.tags-shower.dimensions'

awful.screen.connect_for_each_screen(function (s)
    s.tag_shower = {}

    s.tag_shower.popup = wibox {
        ontop = true,
        x = (s.geometry.width / 2) - (dimensions.width / 2),
        y = (s.geometry.height / 2) - (dimensions.height / 2),
        width = dimensions.width,
        height = dimensions.height,
        visible = false,
        screen = s,
        fg = beautiful.fg_normal,
        bg = beautiful.bg_normal,
    }

    local self = s.tag_shower.popup

    local content = get_content(s)

    self:setup(content)

    function s.tag_shower.toggle()
        if self.visible then
            s.tag_shower.hide()
        else
            s.tag_shower.open()
        end
    end

    function s.tag_shower.open()
        self.visible = true
    end

    function s.tag_shower.hide()
        self.visible = false
    end

    -- dynamic opening/closing
    local timer = nil
    local can_close = true

    tag.connect_signal('property::selected', function ()
        if timer ~= nil then
            timer:stop()
            timer = nil
        end

        s.tag_shower.open()

        timer = gears.timer {
            timeout = 0.8,
            call_now = false,
            autostart = true,
            single_shot = true,
            callback = function ()
                if can_close then
                    s.tag_shower.hide()
                end
                timer = nil
            end
        }
    end)

    self:connect_signal('mouse::enter', function ()
        can_close = false
    end)

    self:connect_signal('mouse::leave', function ()
        timer = nil
        can_close = true
        gears.timer {
            timeout = 0.8,
            call_now = false,
            autostart = true,
            single_shot = true,
            callback = function ()
                if can_close then
                    s.tag_shower.hide()
                end
            end
        }
    end)
end)
