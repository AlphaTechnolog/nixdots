-- theme is based on the decay one
local theme = require("pkgs.theme")

theme.setup {
  style = 'normal',
  nvim_tree = {
    contrast = true,
  },
  cmp = {
    block_kind = true
  },
  italics = {
    code = false,
    comments = false,
  }
}
