-- vim.cmd [[ autocmd VimLeave * set guicursor=n:ver10 ]]

vim.api.nvim_create_autocmd('BufEnter', {
  command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
  nested = true,
})

vim.api.nvim_create_autocmd('BufEnter', {
  command = "if bufname() != 'NvimTree_' . tabpagenr() | NvimTreeClose | endif",
  nested = true,
})
