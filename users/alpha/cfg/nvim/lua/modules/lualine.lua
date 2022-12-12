local present, lualine = pcall(require, "lualine")
local theme = require("pkgs.theme.lualine")
local colors = require("pkgs.theme.core").get_palette()

if not present then
  return
end

local sections = {}

local secs = {'a', 'b', 'c', 'x', 'y', 'z'}

for _, sec in ipairs(secs) do
  sections['lualine_' .. sec] = {}
end

local function ins (sec, cmp)
  table.insert(sections['lualine_' .. sec], cmp)
end

local function wtext (txt)
  return function ()
    return txt
  end
end

local function simple(name)
  return { name }
end

ins('x', {
  'mode',
  fmt = function (s)
    return s:sub(1, 1)
  end
})

ins('y', {
  'filetype',
  icon_only = true,
  padding = { right = 0, left = 1 }
})

ins('y', simple('filename'))

ins('y', {
  'branch',
  padding = { left = 1 },
  color = { bg = colors.statusline_bg, fg = colors.magenta }
})

lualine.setup {
  options = {
    theme = theme.mklualinetheme(),
    component_separators = { left = nil, right = nil },
    section_separators = { left = nil, right = nil },
  },
  sections = sections,
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  }
}
