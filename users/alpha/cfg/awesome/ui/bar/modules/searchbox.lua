local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local awful = require("awful")

local icon = wibox.widget.textbox()
local placeholder = wibox.widget.textbox()

icon.font = beautiful.nerd_font .. ' 20'
icon.markup = helpers.get_colorized_markup('', beautiful.grey)

-- to make a large input by default
placeholder.markup = helpers.get_colorized_markup('Launch...                          ', beautiful.grey)

local reset = function ()
  placeholder.markup = helpers.get_colorized_markup('Launch...                          ', beautiful.grey)
end

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
    exe_callback = function (prog)
      if not prog or #prog == 0 then
        return
      end
      awful.spawn(prog)
    end
  }
end

local input = wibox.widget {
  {
    {
      icon,
      placeholder,
      spacing = 8,
      layout = wibox.layout.fixed.horizontal,
    },
    top = 4,
    bottom = 4,
    left = 12,
    right = 16,
    widget = wibox.container.margin,
  },
  bg = beautiful.black,
  shape = helpers.mkroundedrect(),
  widget = wibox.container.background,
}

helpers.add_hover(input, beautiful.black, beautiful.dimblack)

awesome.connect_signal("bar::searchbox::get_input", get_input)

input:add_button(awful.button({}, 1, function ()
  awesome.emit_signal("bar::searchbox::get_input")
end))

return wibox.widget {
  input,
  top = 6,
  bottom = 6,
  widget = wibox.container.margin,
}