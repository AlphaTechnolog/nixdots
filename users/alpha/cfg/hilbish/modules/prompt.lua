local promptua = require("promptua")

promptua.setConfig {
  prompt = {
    icon = " ",
    success = "",
    fail = "  "
  }
}

promptua.setTheme {
  { provider = "command.execTime", style = "yellow" },
  { provider = "prompt.icon", style = "blue" },
  { provider = "dir.path", style = "cyan", separator = "" },
  { provider = "git.branch", style = "magenta", separator = "", icon = "  " },
  { provider = "git.dirty", style = "white", separator = "", format = " @style@icon", icon = ""},
  { provider = "prompt.failSuccess", style = "yellow" }
}

promptua.init()
