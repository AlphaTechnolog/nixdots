local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")
local gfs = require("gears.filesystem")

local dimensions = require("ui.dashboard.dimensions")

local name = wibox.widget.textbox()

awful.spawn.easy_async_with_shell("whoami", function (whoami)
  name.markup = helpers.capitalize(whoami:gsub("\n", ""))
end)

local os = wibox.widget.textbox()
local osname = [[bash -c "cat /etc/os-release | grep 'PRETTY_NAME' | sed 's/=//g' | sed 's/\"//g' | sed 's/PRETTY_NAME//g'"]]

awful.spawn.easy_async(osname, function (pretty_osname)
  os.markup = pretty_osname:gsub("\n", "")
end)

local kernel = wibox.widget.textbox()

awful.spawn.easy_async_with_shell("uname -r", function (stdout)
  kernel.markup = stdout:gsub("\n", "")
end)

local uptime = wibox.widget.textbox()

local function update_uptime ()
  awful.spawn.easy_async(gfs.get_configuration_dir() .. "scripts/uptime.sh", function (processed_uptime)
    uptime.markup = processed_uptime:gsub("\n", "")
  end)
end

gears.timer {
  timeout = 120,
  call_now = true,
  autostart = true,
  callback = update_uptime
}

local profile = wibox.widget {
  {
    {
      {
        image = beautiful.pfp,
        halign = 'center',
        valign = 'center',
        forced_height = 64,
        forced_width = 64,
        clip_shape = helpers.mkroundedrect(7),
        widget = wibox.widget.imagebox,
      },
      {
        {
          name,
          os,
          kernel,
          uptime,
          layout = wibox.layout.flex.vertical,
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
  shape = helpers.mkroundedrect(7),
  widget = wibox.container.background
}

return profile
