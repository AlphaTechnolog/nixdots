---@diagnostic disable: undefined-global
local awful = require 'awful'

local function _()
  return awful.screen.focused().dashboard
end

awesome.connect_signal('dashboard::toggle', function ()
  _().toggle()
end)
