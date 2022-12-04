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

local function ins (params)
  table.insert(sections['lualine_' .. params.sec], params.cmp)
end

local function wtext (txt)
  return function ()
    return txt
  end
end

ins {
  sec = 'a',
  cmp = {
    wtext(''),
    padding = { right = 0 },
  }
}

ins {
  sec = 'a',
  cmp = {
    'mode',
    fmt = string.lower
  }
}

ins {
  sec = 'b',
  cmp = {
    'location',
    padding = { right = 0 },
    color = { fg = colors.brightblack, bg = colors.background }
  }
}

ins {
  sec = 'x',
  cmp = {
    'branch',
    padding = { right = 1 },
    color = { fg = colors.magenta, bg = colors.background }
  },
}

ins {
  sec = 'z',
  cmp = {
    'filename',
    padding = { right = 0, left = 0 },
    color = { fg = colors.brightblack, bg = colors.background }
  },
}

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
