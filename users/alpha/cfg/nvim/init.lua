require("config.options")
require("config.keymaps")
require("config.theme")

local executed = require("check_packer")

if not executed then
  require("config.plugins")
  require("modules")
end
