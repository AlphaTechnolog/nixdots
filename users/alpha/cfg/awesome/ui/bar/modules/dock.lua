local wibox = require 'wibox'
local beautiful = require 'beautiful'
local awful = require 'awful'
local gears = require 'gears'
local helpers = require 'helpers'

local rubato = require 'modules.rubato'
local icon_theme = require 'modules.bling.helpers.icon_theme'

local theme = icon_theme()

local launcher = wibox.widget {
    {
        {
            image = beautiful.launcher_icon,
            valign = 'center',
            halign = 'center',
            forced_height = 26,
            forced_width = 26,
            widget = wibox.widget.imagebox,
        },
        margins = 4,
        widget = wibox.container.margin,
    },
    shape = helpers.mkroundedrect(6),
    bg = beautiful.bg_normal,
    widget = wibox.container.background,
}

local transition = helpers.add_hover(launcher, beautiful.bg_normal, beautiful.black)

launcher:add_button(awful.button({}, 1, function ()
    -- should launch the dashboard idk
    transition.off()
    awful.spawn('rofi -show drun')
end))

local tasklist = function (s)
    return awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.allscreen,
        buttons = awful.button({}, 1, function (c)
            if not c.active then
                c:activate {
                    context = 'through_dock',
                    switch_to_tag = true,
                }
            else
                c.minimized = true
            end
        end),
        source = function ()
            local ret = {}

            for _, t in ipairs(s.tags) do
                gears.table.merge(ret, t:clients())
            end

            return ret
        end,
        layout = {
            spacing = beautiful.useless_gap * 2,
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            nil,
            {
                {
                    {
                        id = 'clienticon_role',
                        valign = 'center',
                        halign = 'center',
                        forced_height = 26,
                        forced_width = 26,
                        widget = wibox.widget.imagebox,
                    },
                    margins = 4,
                    widget = wibox.container.margin,
                },
                id = 'bg_role',
                widget = wibox.container.background,
                shape = helpers.mkroundedrect(6)
            },
            {
                {
                    wibox.widget.textbox(),
                    id = 'active_role',
                    bg = beautiful.bg_normal,
                    forced_height = 4,
                    forced_width = 0,
                    shape = gears.shape.rounded_bar,
                    widget = wibox.container.background,
                },
                halign = 'center',
                layout = wibox.container.place,
            },
            layout = wibox.layout.align.vertical,
            create_callback = function (self, c)
                local function extract_icon()
                    -- custom icon for st
                    if c.class then
                        if string.lower(c.class) == 'st' then
                            return theme:get_icon_path(string.lower(c.class))
                        end
                    end

                    return theme:get_client_icon_path(c)
                end

                self:get_children_by_id('clienticon_role')[1].image = extract_icon()

                self.container_background = self:get_children_by_id('bg_role')[1]
                self.active_element = self:get_children_by_id('active_role')[1]

                helpers.add_hover(self.container_background, beautiful.bg_normal, beautiful.dimblack)

                self.active_color_transition = helpers.apply_transition {
                    element = self.active_element,
                    prop = 'bg',
                    bg = beautiful.bg_normal,
                    hbg = beautiful.blue
                }

                self.active_size_transition = rubato.timed { duration = 0.25 }

                self.active_size_transition:subscribe(function (v)
                    self.active_element.forced_width = v
                end)

                self.update = function (cl)
                    if cl.active then
                        self.active_color_transition.on()
                        self.active_size_transition.target = 16
                    else
                        self.active_color_transition.off()
                        self.active_size_transition.target = 0
                    end
                end

                self.update(c)
            end,
            update_callback = function (self, c)
                self.update(c)
            end
        }
    }
end

return function (s)
    return wibox.widget {
        {
            {
                launcher,
                bottom = 4,
                widget = wibox.container.margin,
            },
            tasklist(s),
            spacing = beautiful.useless_gap * 2,
            layout = wibox.layout.fixed.horizontal,
        },
        top = 4,
        left = 4,
        right = 4,
        widget = wibox.container.margin,
    }
end
