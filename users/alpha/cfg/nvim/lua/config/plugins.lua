vim.cmd [[ packadd! packer.nvim ]]

local define_plugs = function (use)
  use "wbthomason/packer.nvim"
  use "nvim-treesitter/nvim-treesitter"
  use "nvim-lualine/lualine.nvim"
  use "norcalli/nvim-colorizer.lua"
  use "windwp/nvim-autopairs"
  use "akinsho/bufferline.nvim"

  use {
    "nvim-tree/nvim-tree.lua",
    requires = { "nvim-tree/nvim-web-devicons" }
  }
  use {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" }
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
