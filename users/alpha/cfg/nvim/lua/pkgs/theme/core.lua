package.path = package.path .. ';' .. os.getenv("HOME") .. '/.config/nvim-colors.lua'

return require("nvim-colors")