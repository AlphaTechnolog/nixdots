vim.cmd [[ packadd! packer.nvim ]]

local define_plugs = function (use)
  use "wbthomason/packer.nvim"
  use "nvim-treesitter/nvim-treesitter"
  use "nvim-lualine/lualine.nvim"
  use "norcalli/nvim-colorizer.lua"
  use "windwp/nvim-autopairs"
  use "akinsho/bufferline.nvim"
  use "lewis6991/impatient.nvim"
  use "akinsho/toggleterm.nvim"
  use "folke/tokyonight.nvim"
  use "rcarriga/nvim-notify"

  use {
    "nvim-tree/nvim-tree.lua",
    requires = { "nvim-tree/nvim-web-devicons" }
  }
  use {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" }
  }

  -- configuration of lsp things
  use {
    "onsails/lspkind.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip"
  }
end

return require("packer").startup({define_plugs, config = {
  git = {
    depth = 1,
    clone_timeout = -1,
  },
  display = {
    open_fn = function ()
      return require("packer.util").float({
        border = "single"
      })
    end
  }
}})
