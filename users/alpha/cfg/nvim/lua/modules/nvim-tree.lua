local present, ntree = pcall(require, 'nvim-tree')

if not present then
  return
end

ntree.setup {}

vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>NvimTreeToggle<cr>', { noremap = true, silent = true })

vim.api.nvim_create_autocmd('BufEnter', {
  command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
  nested = true,
})

vim.api.nvim_create_autocmd('BufEnter', {
  command = "if bufname() != 'NvimTree_' . tabpagenr() | NvimTreeClose | endif",
  nested = true,
})
