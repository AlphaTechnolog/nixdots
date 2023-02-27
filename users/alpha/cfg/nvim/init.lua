vim = vim

local capi = { vim = vim }

capi.vim.cmd([[ packadd packer.nvim ]])

local packer = require("packer")

packer.init({
	git = {
		clone_timeout = 10000,
	},
})

packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use("decaycs/decay.nvim")
	use("nvim-treesitter/nvim-treesitter")
end)

local decay = require("decay")
local ntreesitter = require("nvim-treesitter.configs")

capi.vim.opt.tabstop = 2
capi.vim.opt.shiftwidth = 2
capi.vim.opt.expandtab = true
capi.vim.opt.laststatus = 0
capi.vim.opt.cmdheight = 0

decay.setup({
	style = "dark",
	nvim_tree = {
		contrast = true,
	},
	italics = {
		comments = true,
		code = true,
	},
})

ntreesitter.setup({
	ensure_installed = { "javascript", "typescript", "lua" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
	indent = {
		enable = true,
	},
})
