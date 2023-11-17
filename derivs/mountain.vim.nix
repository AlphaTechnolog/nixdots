{ pkgs, ... }: with pkgs.vimUtils; buildVimPlugin rec {
  pname = "mountain.vim";
  name = pname;
  src = ../extras/mountain.nvim/.;
}