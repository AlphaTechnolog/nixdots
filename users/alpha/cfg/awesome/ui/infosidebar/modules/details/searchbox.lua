local wibox = require("wibox")
local helpers = require("helpers")
local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")

local dimensions = require("ui.infosidebar.dimensions")

local icon = wibox.widget.textbox()
local placeholder = wibox.widget.textbox()

icon.font = beautiful.nerd_font .. " 20"
icon.markup = helpers.get_colorized_markup("", beautiful.blue)

local reset = function ()
  placeholder.markup = helpers.get_colorized_markup("Launch App...", beautiful.light_black)
end

reset()

local get_input = function ()
  awful.prompt.run {
    prompt = "",
    text = "",
    bg_cursor = beautiful.blue,
    textbox = placeholder,
    hooks = {
      {{}, "Escape", reset}
    },
    done_callback = reset,
    completion_callback = awful.completion.shell,
    exe_callback = function (prog)
      if not prog or #prog == 0 then
        return
      end
      awful.spawn(prog)
    end
  }
end

local searchbox = wibox.widget {
  {
    {
      icon,
      placeholder,
      spacing = dimensions.spacing,
      layout = wibox.layout.fixed.horizontal,
    },
    top = 0,
    bottom = 0,
    left = 15,
    right = 15,
    widget = wibox.container.margin,
  },
  bg = beautiful.black,
  shape = gears.shape.rounded_bar,
  forced_width = 274,
  widget = wibox.container.background,
}

helpers.add_hover(searchbox, beautiful.black, beautiful.dimblack)

searchbox:add_button(awful.button({}, 1, function ()
  get_input()
end))

return wibox.widget {
  searchbox,
  halign = "center",
  layout = wibox.container.place,
}
