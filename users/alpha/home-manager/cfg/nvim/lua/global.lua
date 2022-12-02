local opt = vim.opt

opt.termguicolors = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.showmode = false
opt.clipboard = 'unnamedplus'
opt.laststatus = 3
opt.cursorline = true
opt.wrap = true
opt.guifont = { "BlexMono Nerd Font", ":h8" }

opt.shortmess = opt.shortmess + {
  c = true, -- Do not show completion messages in command line
  F = true, -- Do not show file info when editing a file, in the command line
  W = true, -- Do not show "written" in command line when writing
  I = true, -- Do not show intro message when starting Vim
}
