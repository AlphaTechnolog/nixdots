local opt = vim.opt

opt.number = false
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.termguicolors = true
opt.showmode = false
opt.clipboard = 'unnamedplus'
opt.laststatus = 0
opt.cursorline = false
opt.wrap = false
opt.guifont = { "monospace", ":h13" }
opt.cmdheight = 0
opt.completeopt = "menu,menuone,noselect"
opt.mouse = 'a'
opt.guicursor = 'i:block' -- use block cursor for insert mode

opt.shortmess = opt.shortmess + {
  c = true, -- Do not show completion messages in command line
  F = true, -- Do not show file info when editing a file, in the command line
  W = true, -- Do not show "written" in command line when writing
  I = true, -- Do not show intro message when starting Vim
}
