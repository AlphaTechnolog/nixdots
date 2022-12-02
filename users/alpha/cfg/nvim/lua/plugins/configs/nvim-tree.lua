local present, ntree = pcall(require, 'nvim-tree')
local keymap = require 'keymaps'

if not present then
	return
end

vim.g.loaded_netrw = 1
vim.g.laoded_netrwPlugin = 1

ntree.setup {
	auto_reload_on_write = true,
	create_in_closed_folder = false,
	disable_netrw = true,
	reload_on_bufenter = true,
	respect_buf_cwd = true,
	view = {
		adaptive_size = true,
		hide_root_folder = true,
	},
	renderer = {
		indent_width = 2,
		full_name = false,
		highlight_git = true,
		highlight_opened_files = 'none',
	},
	git = {
		enable = true,
		ignore = false,
		show_on_dirs = true,
		timeout = 400,
	},
	actions = {
		use_system_clipboard = true,
	}
}

keymap.make('n', '<C-n>', keymap.cmd('NvimTreeToggle'))
