local hilbish = require("hilbish")
local util = require("util")

util.process_table(hilbish.alias, {
  ls = "exa --icons",
  la = "ls -la",
  tree = "ls --tree",
  vim = "nvim",
  vi = "nvim",
  cat = "bat",
  reset = "exec hilbish -S -l" -- replaces current shell into a new one
})
