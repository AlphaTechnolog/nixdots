local hilbish = require("hilbish")
local promptua = require("promptua")

local function get_cwd ()
  local base_cwd = hilbish.cwd()
  local user_dir = "/home/" .. hilbish.user

  local cwd = base_cwd:gsub(user_dir, "~"), _

  return cwd
end

promptua.setConfig {
  prompt = {
    icon = " ",
    success = "",
    fail = "  "
  }
}

promptua.setTheme {
  { provider = "prompt.icon", style = "blue" },
  { provider = get_cwd, style = "cyan", separator = "" },
  { provider = "git.branch", style = "magenta", separator = "", icon = "  " },
  { provider = "git.dirty", style = "white", separator = "", format = " @style@icon", icon = ""},
  { provider = "prompt.failSuccess", style = "yellow" }
}

promptua.init()
