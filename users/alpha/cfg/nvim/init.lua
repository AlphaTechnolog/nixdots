vim.defer_fn(function ()
  pcall(require, "impatient")
end, 0)

require("config.options")
require("config.autocmds")
require("config.keymaps")
require("config.theme")

local executed = require("check_packer")

if not executed then
  require("config.plugins")
  require("modules")
end
