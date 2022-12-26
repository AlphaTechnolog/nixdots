local api = vim.api

api.nvim_set_keymap("n", "<space>zn", ":TZNarrow<CR>", {})
api.nvim_set_keymap("v", "<space>zn", ":'<,'>TZNarrow<CR>", {})
api.nvim_set_keymap("n", "<space>zf", ":TZFocus<CR>", {})
api.nvim_set_keymap("n", "<space>zm", ":TZMinimalist<CR>", {})
api.nvim_set_keymap("n", "<space>za", ":TZAtaraxis<CR>", {})

-- or
local truezen = require('true-zen')
local keymap = vim.keymap

keymap.set('n', '<space>zn', function()
  local first = 0
  local last = vim.api.nvim_buf_line_count(0)
  truezen.narrow(first, last)
end, { noremap = true })
keymap.set('v', '<space>zn', function()
  local first = vim.fn.line('v')
  local last = vim.fn.line('.')
  truezen.narrow(first, last)
end, { noremap = true })
keymap.set('n', '<space>zf', truezen.focus, { noremap = true })
keymap.set('n', '<space>zm', truezen.minimalist, { noremap = true })
keymap.set('n', '<space>za', truezen.ataraxis, { noremap = true })
