local wibox = require 'wibox'
local beautiful = require 'beautiful'
local helpers = require 'helpers'
local awful = require 'awful'
local gears = require 'gears'

local screenshot = require 'modules.screenshot'

local dimensions = require 'ui.dashboard.dimensions'
local sliders = require 'ui.dashboard.modules.settings.sliders'

local full_scr = wibox.widget {
  {
    {
      markup = '',
      font = beautiful.nerd_font .. ' 56',
      align = 'center',
      valign = 'center',
      widget = wibox.widget.textbox,
    },
    left = dimensions.spacing * 3,
    right = dimensions.spacing * 3,
    widget = wibox.container.margin,
  },
  bg = beautiful.bg_lighter,
  shape = helpers.mkroundedrect(14),
  widget = wibox.container.background,
}

helpers.add_hover(full_scr, beautiful.bg_lighter, beautiful.dimblack)

full_scr:add_button(awful.button({}, 1, function ()
  screenshot.full { notify = true }
end))

local area_scr = wibox.widget {
  {
    {
      markup = '',
      font = beautiful.nerd_font .. ' 56',
      align = 'center',
      valign = 'center',
      widget = wibox.widget.textbox,
    },
    left = dimensions.spacing * 3,
    right = dimensions.spacing * 3,
    widget = wibox.container.margin,
  },
  bg = beautiful.bg_lighter,
  shape = helpers.mkroundedrect(14),
  widget = wibox.container.background,
}

helpers.add_hover(area_scr, beautiful.bg_lighter, beautiful.dimblack)

area_scr:add_button(awful.button({}, 1, function ()
  screenshot.area { notify = true }
end))

local username = wibox.widget.textbox()

username.font = beautiful.font_name .. ' ' .. tostring(tonumber(beautiful.font_size) + 8)
username.align = 'center'
username.markup = 'Hey! Bye? Now?'

local reload = wibox.widget {
  {
    {
      markup = helpers.get_colorized_markup('勒', beautiful.magenta),
      font = beautiful.nerd_font .. ' 22',
      align = 'center',
      valign = 'center',
      widget = wibox.widget.textbox,
    },
    left = 11,
    right = 11,
    widget = wibox.container.margin,
  },
  bg = beautiful.dimblack,
  shape = helpers.mkroundedrect(),
  widget = wibox.container.background,
}

helpers.add_hover(reload, beautiful.dimblack, beautiful.light_black)

reload:add_button(awful.button({}, 1, function ()
  awful.spawn('systemctl reboot')
end))

local poweroff = wibox.widget {
  {
    {
      markup = helpers.get_colorized_markup('⏻', beautiful.red),
      font = beautiful.nerd_font .. ' 20',
      align = 'center',
      valign = 'center',
      widget = wibox.widget.textbox,
    },
    left = 11,
    right = 11,
    widget = wibox.container.margin,
  },
  bg = beautiful.dimblack,
  shape = helpers.mkroundedrect(),
  widget = wibox.container.background,
}

helpers.add_hover(poweroff, beautiful.dimblack, beautiful.light_black)

poweroff:add_button(awful.button({}, 1, function ()
  awful.spawn('systemctl poweroff')
end))

local info = wibox.widget {
  {
    nil,
    {
      {
        {
          image = beautiful.pfp,
          halign = 'center',
          valign = 'center',
          forced_height = 94,
          forced_width = 94,
          clip_shape = gears.shape.circle,
          widget = wibox.widget.imagebox,
        },
        username,
        spacing = dimensions.spacing,
        layout = wibox.layout.fixed.vertical,
      },
      top = dimensions.spacing,
      bottom = dimensions.spacing,
      left = dimensions.spacing * 6,
      right = dimensions.spacing * 6,
      widget = wibox.container.margin,
    },
    {
      {
        {
          {
            {
              reload,
              poweroff,
              spacing = 6,
              layout = wibox.layout.fixed.horizontal,
            },
            right = 6,
            widget = wibox.container.margin,
          },
          valign = 'center',
          halign = 'right',
          layout = wibox.container.place,
        },
        top = 6,
        bottom = 6,
        widget = wibox.container.margin,
      },
      bg = beautiful.black,
      widget = wibox.container.background,
    },
    layout = wibox.layout.align.vertical,
  },
  bg = beautiful.bg_lighter,
  shape = helpers.mkroundedrect(),
  widget = wibox.container.background
}

local core = wibox.widget {
  {
    {
      full_scr,
      area_scr,
      spacing = dimensions.spacing,
      layout = wibox.layout.flex.vertical,
    },
    info,
    spacing = dimensions.spacing,
    layout = wibox.layout.fixed.horizontal,
  },
  {
    sliders,
    left = dimensions.spacing,
    widget = wibox.container.margin
  },
  layout = wibox.layout.align.horizontal
}

return core
