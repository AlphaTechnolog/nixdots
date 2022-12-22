local hilbish = require("hilbish")
local util = require("util")

util.process_table(hilbish.alias, {
  ls = "exa --icons",
  la = "ls -la",
  tree = "exa --tree",
  vim = "nvim",
  vi = "nvim",
  cat = "bat",
})
