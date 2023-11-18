local Decay = require "decay.main"

local M = {}

-- just a shortcut for normal `module.setup()`
-- calling which is quite standard in the nvim plugins ecosystem.
function M.setup(...)
  local decay = Decay(...)
  return decay:setup()
end

return M
