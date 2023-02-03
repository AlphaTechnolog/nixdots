---@diagnostic disable: lowercase-global

vim = vim
lvim = lvim

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.guifont = 'monospace:h12'

lvim.log.level = "info"

local formatters = require "lvim.lsp.null-ls.formatters"

formatters.setup { { command = "stylua" } }

lvim.format_on_save = {
  enabled = true,
  pattern = "*.lua",
  timeout = 1000,
}

lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.insert_mode["jk"] = "<esc>"

lvim.colorscheme = "oxocarbon"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

lvim.builtin.treesitter.auto_install = true

lvim.plugins = {
  "nyoom-engineering/oxocarbon.nvim"
}
