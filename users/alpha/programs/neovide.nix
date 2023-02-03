{ pkgs }:

let
  lvim-desktop = pkgs.makeDesktopItem {
    name = "Neovide + LunarVim";
    desktopName = "LunarVim";
    exec = "${pkgs.neovide}/bin/neovide --neovim-bin ${pkgs.lunarvim-wrapper}/bin/lvim";
    icon = "neovide";
    comment = "Open neovide with lunarvim";
  };
in {
  home.packages = with pkgs; [
    neovide
    lvim-desktop
  ];
}