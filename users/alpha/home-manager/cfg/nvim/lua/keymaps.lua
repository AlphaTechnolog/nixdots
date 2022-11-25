local keymap_cmd = function (query)
	return '<cmd>' .. query .. '<cr>'
end

local keymap_lua = function (fnc)
	return '<cmd>lua ' .. fnc .. '()<cr>'
end

local keymap = function (mode, keymap, cmd, options)
	if not options then
		options = { noremap = true, silent = true }
	end

	vim.api.nvim_set_keymap(mode, keymap, cmd, options)
end

local function insert_keybinds ()
	local keys = {'jk', 'jj', 'kj', 'kk'}

	for _, key in ipairs(keys) do
		keymap('i', key, '<esc>')
	end
end

local function save_keybinds ()
	keymap('n', '<C-s>', ':w!<cr>')
	keymap('n', '<C-q>', ':wq!<cr>')
  keymap('n', '<space>fs', ':w!<cr>')
end

local function buffer_keybinds ()
	keymap('n', '<Tab>', ':bn!<cr>')
	keymap('n', '<S-Tab>', ':bp!<cr>')
	keymap('n', '<space>x', ':Bdelete!<cr>')
end

local function navigation_keybinds ()
	local navigation_keys = {'h', 'j', 'k', 'l'}

	for _, key in ipairs(navigation_keys) do
		keymap('n', '<C-' .. key .. '>', '<C-w>' .. key)
	end
end

local function main ()
	insert_keybinds()
	save_keybinds()
	buffer_keybinds()
	navigation_keybinds()
end

local for_lsp = function (b, m, k, a)
	vim.keymap.set(m, k, a, {
		silent = true,
		noremap = true,
		buffer = b
	})
end

local bulk_lsp = function (bufnr, dict)
	for mode, keymaps_dict in pairs(dict) do
		for keymap, cmd in pairs(keymaps_dict) do
			for_lsp(bufnr, mode, keymap, cmd)
		end
	end
end

return {
	cmd = keymap_cmd,
	lua = keymap_lua,
	make = keymap,
	main = main,
	for_lsp = for_lsp,
	bulk_lsp = bulk_lsp
}
