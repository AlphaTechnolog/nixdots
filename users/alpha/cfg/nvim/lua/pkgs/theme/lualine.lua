local core = require("pkgs.theme.core")
local colors = core.get_palette()

local M = {}

function M.mklualinetheme ()
  local custom = {}

  custom.normal = {
    a = { bg = colors.blue, fg = colors.background },
    x = { bg = colors.blue, fg = colors.background },
    b = { bg = colors.lighter, fg = colors.foreground },
    c = { bg = colors.background, fg = colors.background },
  }

  custom.insert = {
    a = { bg = colors.green, fg = colors.background },
    x = { bg = colors.green, fg = colors.background },
    b = { bg = colors.lighter, fg = colors.foreground },
  }

  custom.command = {
    a = { bg = colors.red, fg = colors.background },
    x = { bg = colors.red, fg = colors.background },
    b = { bg = colors.lighter, fg = colors.foreground },
  }

  custom.visual = {
    a = { bg = colors.cyan, fg = colors.background },
    x = { bg = colors.cyan, fg = colors.background },
    b = { bg = colors.lighter, fg = colors.foreground },
  }

  custom.replace = {
    a = { bg = colors.red, fg = colors.background },
    x = { bg = colors.red, fg = colors.background },
    b = { bg = colors.lighter, fg = colors.foreground },
  }

  custom.inactive = {
    a = { bg = colors.background, fg = colors.background },
    x = { bg = colors.background, fg = colors.background },
    b = { bg = colors.lighter, fg = colors.foreground },
    c = { bg = colors.background, fg = colors.foreground },
  }

  return custom
end

return M
