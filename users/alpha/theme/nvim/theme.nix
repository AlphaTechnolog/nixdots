{ colors }:

with colors; ''
local M = {}

function M.get_palette()
  return {
    background = "${bg}",
    contrast = '${bg-darker}',
    statusline_bg = '${bg-contrast}',
    lighter = '${bg-lighter}',
    foreground = "${fg}",
    cursorline = '${bg-lighter}',
    comments = '${grey}',
    cursor = "${fg}",
    black = "${black}",
    red = "${red}",
    green = "${green}",
    yellow = "${yellow}",
    blue = "${blue}",
    magenta = "${magenta}",
    cyan = "${cyan}",
    white = "${white}",
    brightblack = "${grey}",
    brightred = "${red}",
    brightgreen = "${green}",
    brightyellow = "${yellow}",
    brightblue = "${blue}",
    brightmagenta = "${magenta}",
    brightcyan = "${cyan}",
    brightwhite = "${white}",
		accent = "${blue}",
  }
end

return M
''