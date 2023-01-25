-- libraries
local core = require "core"
local style = require "core.style"

-- helper function to make font setting more easier
local function monaco(fs)
  return renderer.font.load(USERDIR .. '/fonts/Monaco Nerd Font Complete.ttf', fs * SCALE)
end

-- setting fonts
style.font = monaco(10)
style.code_font = monaco(12)

-- load theme
core.reload_module('colors.dark-decay')

