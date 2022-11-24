local present, telescope = pcall(require, 'telescope')

if not present then
	return
end

local keymap = require 'keymaps'

keymap.make('n', '<C-p>', keymap.cmd 'Telescope find_files')
keymap.make('n', '<space>ff', keymap.cmd 'Telescope find_files')
keymap.make('n', '<space>fg', keymap.cmd 'Telescope live_grep')
