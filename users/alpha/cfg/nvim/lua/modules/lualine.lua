local present, lualine = pcall(require, 'lualine')
local theme = require("pkgs.theme.lualine")

if not present then
  return
end

local chars = {'a', 'b', 'c', 'x', 'y', 'z'}

local function default ()
  local ret = {}
  for _, char in ipairs(chars) do
    ret['lualine_' .. char] = {}
  end

  return ret
end

local function sections ()
  local base = default()

  base.lualine_a = {
    {
      'mode',
      fmt = function (str)
        return str:sub(1, 1):upper()
      end,
      separator = { left = '', right = '' }
    },
  }

  return base
end

lualine.setup({
  options = {
    theme = theme.mklualinetheme(),
    globalstatus = true
  },
  inactive_sections = sections(),
  sections = sections()
})
