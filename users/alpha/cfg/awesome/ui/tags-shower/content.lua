local awful = require 'awful'
local wibox = require 'wibox'
local gears = require 'gears'
local beautiful = require 'beautiful'

local rubato = require 'modules.rubato'

return function (s)
    local taglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        style = {
            shape = gears.shape.rounded_bar,
        },
        layout = {
            spacing = beautiful.useless_gap * 2,
            layout = wibox.layout.fixed.horizontal,
        },
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
        widget_template = {
            {
                widget = wibox.widget.textbox,
            },
            id = 'background_role',
            forced_height = 8,
            forced_width = 14,
            shape = gears.shape.rounded_bar,
            widget = wibox.container.background,
            create_callback = function (self, tag)
                self.animate = rubato.timed {
                    duration = 0.15,
                    rate = 120
                }

                self.animate:subscribe(function (v)
                    self:get_children_by_id('background_role')[1].forced_width = v
                end)

                self.update = function ()
                    if tag.selected then
                        self.animate.target = 20
                    elseif #tag:clients() > 0 then
                        self.animate.target = 12
                    else
                        self.animate.target = 9
                    end
                end

                self.update()
            end,
            update_callback = function (self)
                self.update()
            end,
        }
    }

    return {
        taglist,
        halign = 'center',
        valign = 'center',
        layout = wibox.container.place,
    }
end
