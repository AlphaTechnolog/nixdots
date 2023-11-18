{ pkgs, ... }: with pkgs.vimUtils; buildVimPlugin rec {
  pname = "decay.nvim";
  name = pname;
  src = ../extras/decay.nvim/.;
}