---@diagnostic disable: undefined-global
local awful = require "awful"
local bling = require "modules.bling"

local function set_layouts()
    tag.connect_signal("request::default_layouts", function ()
        awful.layout.append_default_layouts {
            awful.layout.suit.tile,
            awful.layout.suit.floating,
            awful.layout.suit.max,
            bling.layout.mstab,
            bling.layout.centered
        }
    end)
end

set_layouts()
