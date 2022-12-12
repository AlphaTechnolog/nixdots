local present, ntree = pcall(require, 'nvim-tree')

if not present then
  return
end

ntree.setup {}

vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>NvimTreeToggle<cr>', { noremap = true, silent = true })
