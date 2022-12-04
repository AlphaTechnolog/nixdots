vim.cmd [[ packadd! packer.nvim ]]

return require("packer").startup(function (use)
  use "wbthomason/packer.nvim"
  use "nvim-treesitter/nvim-treesitter"
  use "nvim-lualine/lualine.nvim"
  use "norcalli/nvim-colorizer.lua"
  use "windwp/nvim-autopairs"

  use {
    "nvim-tree/nvim-tree.lua",
    requires = { "nvim-tree/nvim-web-devicons" }
  }
  use {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" }
  }
end)
