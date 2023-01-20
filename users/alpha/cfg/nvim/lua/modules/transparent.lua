local present, trans = pcall(require, 'transparent')

if not present then
  return
end

local chars = {'a', 'b', 'c', 'x', 'y', 'x'}
local modes = {'normal', 'insert', 'command', 'visual', 'replace', 'inactive'}

local lualine_highlights = {}

for _, char in ipairs(chars) do
  for _, mode in ipairs(modes) do
    table.insert(lualine_highlights, "lualine_" .. mode .. "_" .. char)
  end
end

local extra_groups = {
  "StatusLine",
  "StatusLineNC",
  "NvimTreeNormal",
  "NvimTreeEndOfBuffer",
  "NvimTreeNormalNC",
  "NvimTreeVertSplit",
  "NvimTreeCursorLine",
  "CursorLine",
  "VertSplit",
  "MsgArea",
  "TelescopeNormal",
  "TelescopeBorder"
}

for _, item in ipairs(lualine_highlights) do
  table.insert(extra_groups, item)
end

trans.setup({
  enable = true,
  extra_groups = extra_groups,
})
