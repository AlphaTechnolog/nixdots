local core = require("pkgs.theme.core")
local colors = core.get_palette()

local M = {}

function M.mklualinetheme ()
  local custom = {}

  custom.normal = {
    a = { fg = colors.blue, bg = colors.background },
    b = { bg = colors.lighter, fg = colors.foreground },
    c = { bg = colors.background, fg = colors.background },
  }

  custom.insert = {
    a = { fg = colors.green, bg = colors.background },
    b = { bg = colors.lighter, fg = colors.foreground },
  }

  custom.command = {
    a = { fg = colors.red, bg = colors.background },
    b = { bg = colors.lighter, fg = colors.foreground },
  }

  custom.visual = {
    a = { fg = colors.cyan, bg = colors.background },
    b = { bg = colors.lighter, fg = colors.foreground },
  }

  custom.replace = {
    a = { fg = colors.red, bg = colors.background },
    b = { bg = colors.lighter, fg = colors.foreground },
  }

  custom.inactive = {
    a = { fg = colors.background, bg = colors.background },
    b = { bg = colors.lighter, fg = colors.foreground },
    c = { bg = colors.background, fg = colors.foreground },
  }

  return custom
end

return M
