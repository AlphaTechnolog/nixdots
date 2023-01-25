local present, trans = pcall(require, 'transparent')

if not present then
  return
end

local extra_groups = {
  "NvimTreeNormal",
  "NvimTreeEndOfBuffer",
  "NvimTreeNormalNC",
  "NvimTreeVertSplit",
  "NvimTreeCursorLine",
  "CursorLine",
  "VertSplit",
  "MsgArea",
  "TelescopeNormal",
  "TelescopeBorder",
  "lualine_c_normal"
}

trans.setup({
  enable = true,
  extra_groups = extra_groups,
})
