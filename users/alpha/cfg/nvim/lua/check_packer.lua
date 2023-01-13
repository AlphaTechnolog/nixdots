-- thanks to NvChad code, which served as reference to this file
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local colors = require("pkgs.theme.core").get_palette()

local executed = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  executed = true

  print("Cloning packer....")

  vim.fn.system {
    "git", "clone", "--depth", "1",
    "https://github.com/wbthomason/packer.nvim", install_path
  }

  vim.cmd("packadd packer.nvim")

  require("config.plugins")

  vim.cmd("PackerSync")

  vim.api.nvim_create_autocmd("User", {
    pattern = "PackerComplete",
    callback = function ()
      vim.cmd "bw"
      -- vim.cmd "bw | silent! MasonInstallAll" -- close packer window and install mason.nvim things
      require("modules")
    end,
  })
end

return executed
