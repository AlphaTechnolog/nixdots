local present, telescope = pcall(require, "telescope")

if not present then
  return
end

telescope.setup()

local function keymap(mode, keymap, cmd)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap(mode, keymap, cmd, opts)
end

local maps = {
  ["<space>ff"] = "<cmd>Telescope find_files<cr>",
  ["<C-p>"] = "<cmd>Telescope find_files<cr>"
}

for key, cmd in pairs(maps) do
  keymap("n", key, cmd)
end
