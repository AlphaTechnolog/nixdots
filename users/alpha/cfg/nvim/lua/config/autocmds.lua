-- ensure it's using block cursor when exiting neovim
vim.cmd [[ autocmd VimLeave * set guicursor=n:block ]]
