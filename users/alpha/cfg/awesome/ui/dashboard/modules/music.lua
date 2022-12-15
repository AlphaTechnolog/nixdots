local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")

local bling = require("modules.bling")
local dimensions = require("ui.dashboard.dimensions")

local playerctl = bling.signal.playerctl.lib()

local image = wibox.widget {
  image = beautiful.fallback_music,
  valign = 'center',
  halign = 'center',
  clip_shape = helpers.mkroundedrect(),
  forced_height = 64,
  forced_width = 64,
  widget = wibox.widget.imagebox,
}

local title = wibox.widget {
  markup = '<b>Not playing</b>',
  font = beautiful.font_name .. ' 14',
  widget = wibox.widget.textbox,
}

local artist = wibox.widget {
  markup = 'No artist',
  widget = wibox.widget.textbox
}

local function mkbutton (label, onclick)
  local icon = wibox.widget {
    markup = label,
    font = beautiful.nerd_font .. ' 15',
    widget = wibox.widget.textbox,
  }

  local w = wibox.widget {
    {
      icon,
      top = 1,
      bottom = 1,
      left = 9,
      right = 9,
      widget = wibox.container.margin,
    },
    bg = beautiful.bg_lighter,
    shape = helpers.mkroundedrect(),
    widget = wibox.container.background,
  }

  helpers.add_hover(w, beautiful.bg_lighter, beautiful.black)

  w = wibox.widget {
    w,
    halign = 'center',
    valign = 'center',
    widget = wibox.container.place,
    set_icon = function (self, new_icon)
      icon.markup = new_icon
    end
  }

  w:add_button(awful.button({}, 1, function ()
    if onclick then
      onclick()
    end
  end))

  return w
end

local prevbutton = mkbutton('玲', function ()
  playerctl:previous()
end)

local pausebutton = mkbutton('契', function ()
  playerctl:play_pause()
end)

local nextbutton = mkbutton('怜', function ()
  playerctl:next()
end)

playerctl:connect_signal('playback_status', function (_, playing)
  pausebutton.icon = playing and '' or '契'
end)

playerctl:connect_signal('metadata', function (_, gtitle, gartist, album_path)
  image:set_image(gears.surface.load_uncached(album_path))  
  title:set_markup_silently("<b>" .. helpers.limit_by_length(gtitle, 17, true) .. "</b>")
  artist:set_markup_silently(gartist)
end)

playerctl:connect_signal('no_players', function ()
  pausebutton.icon = '契'
  image:set_image(gears.surface.load_uncached(beautiful.fallback_music))
  title:set_markup_silently('<b>Not playing</b>')
  artist:set_markup_silently('No artist')
end)

local info = wibox.widget {
  {
    {
      image,
      {
        {
          {
            title,
            artist,
            layout = wibox.layout.fixed.vertical,
          },
          halign = 'left',
          valign = 'center',
          layout = wibox.container.place,
        },
        left = dimensions.spacing,
        widget = wibox.container.margin,
      },
      layout = wibox.layout.align.horizontal,
    },
    margins = dimensions.spacing,
    widget = wibox.container.margin,
  },
  bg = beautiful.bg_lighter,
  shape = helpers.mkroundedrect(),
  widget = wibox.container.background,
}

local controls = wibox.widget {
  {
    {
      prevbutton,
      pausebutton,
      nextbutton,
      spacing = dimensions.spacing * 0.5,
      layout = wibox.layout.flex.vertical,
    },
    margins = dimensions.spacing,
    widget = wibox.container.margin,
  },
  bg = beautiful.bg_lighter,
  shape = helpers.mkroundedrect(),
  widget = wibox.container.background
}

return wibox.widget {
  nil,
  info,
  {
    controls,
    left = dimensions.spacing,
    widget = wibox.container.margin,
  },
  layout = wibox.layout.align.horizontal,
}
