vim.cmd [[ packadd packer.nvim ]]

require 'packer'.startup(function (use)
	use 'wbthomason/packer.nvim'
	use 'decaycs/decay.nvim'
	use 'nvim-lualine/lualine.nvim'
	use 'nvim-tree/nvim-web-devicons'
	use 'nvim-tree/nvim-tree.lua'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-treesitter/nvim-treesitter'
	use 'norcalli/nvim-colorizer.lua'
	use 'windwp/nvim-autopairs'
	use 'moll/vim-bbye'

	-- lsp
	use {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
		"onsails/lspkind.nvim",
		"glepnir/lspsaga.nvim"
	}
end)

require 'plugins.configs'
