local keymap = function (mode, map, cmd)
  vim.api.nvim_set_keymap(mode, map, cmd, { noremap = true, silent = true })
end

local ks = { 'jk', 'kj', 'jj', 'kk' }

for _, k in ipairs(ks) do
  keymap('i', k, '<esc>')
end

keymap('n', '<C-s>', "<cmd>w!<cr>")
keymap('n', '<space>fs', "<cmd>w!<cr>")
keymap('n', '<C-q>', '<cmd>q!<cr>')

local nks = {'h', 'j', 'k', 'l'}

for _, nk in ipairs(nks) do
  keymap('n', '<C-' .. nk .. '>', '<C-w>' .. nk)
end

keymap('n', '<space>x', '<cmd>bd!<cr>')
keymap('n', '<C-b>', '<cmd>bd!<cr>')

keymap('n', '<Tab>', '<cmd>bn!<cr>')
keymap('n', '<S-Tab>', '<cmd>bn!<cr>')
