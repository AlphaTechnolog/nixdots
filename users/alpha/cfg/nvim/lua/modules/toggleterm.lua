local present, toggleterm = pcall(require, 'toggleterm')
local colors = require("pkgs.theme.core").get_palette()

local keymap = function (mode, map, cmd)
  vim.api.nvim_set_keymap(mode, map, cmd, { noremap = true, silent = true })
end

if not present then
  return
end

toggleterm.setup {
  shade_terminals = false,
  autochdir = true,
  persist_mode = false,
  highlights = {
    FloatBorder = {
      guifg = colors.brightblack,
      guibg = colors.background
    },
  },
  size = function (term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.45
    end
  end,
}

keymap('n', '<space>th', '<cmd>ToggleTerm direction=horizontal<cr>')
keymap('n', '<space>tv', '<cmd>ToggleTerm direction=vertical<cr>')
keymap('n', '<space>tf', '<cmd>ToggleTerm direction=float<cr>')

-- set keymaps for terminal mode (took from documentation)
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<space>q', [[<C-\><C-n><cmd>q!<cr>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
