local hilbish = require("hilbish")
local util = require("util")

-- turn greeting and motd off
util.merge_table(hilbish.opts, {
  greeting = false,
  motd = false
})
