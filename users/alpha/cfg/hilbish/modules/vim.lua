local bait = require("bait")
local ansikit = require("ansikit")
local util = require("util")

local modes = {
  insert = "lineCursor",
  another = "blockCursor"
}

-- turn on vim mode
hilbish.inputMode("vim")

-- load cursors
bait.catch("hilbish.vimMode", function (mode)
  ansikit.cursorStyle(ansikit[modes[
    util.has_key(modes, mode) and mode or "another"
  ]])
end)
