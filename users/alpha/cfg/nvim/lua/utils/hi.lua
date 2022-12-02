local M = {}

function M.color(group, index)
  local guicolors = vim.go.termguicolors
  local hl = vim.api.nvim_get_hl_by_name(group, guicolors)
  if hl[index] then
    return guicolors and string.format('#%06x', hl[index]) or hl[index]
  end
  local defaults = {
    gui = '#000000',
    cterm = 255,
  }

  return guicolors and defaults.gui or defaults.cterm
end

function M.get_bg(group)
  return M.color(group, 'background')
end

function M.get_fg(group)
  return M.color(group, 'foreground')
end

function M.override (group, properties)
    vim.api.nvim_set_hl(0, group, properties)
end

return M
