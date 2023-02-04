{ pkgs }:

let
  lvim-desktop = pkgs.makeDesktopItem {
    name = "Neovide + LunarVim";
    desktopName = "LunarVim";
    exec = "${pkgs.neovide}/bin/neovide --neovim-bin ${pkgs.lunarvim-wrapper}/bin/lvim";
    icon = "neovide";
    comment = "Open neovide with lunarvim";
  };

  neovide-lvim = pkgs.writeScriptBin "nvide-lvim" ''
    #!${pkgs.bash}/bin/bash
    ${pkgs.neovide}/bin/neovide --neovim-bin ${pkgs.lunarvim-wrapper}/bin/lvim
  '';
in {
  home.packages = with pkgs; [
    neovide
    neovide-lvim
    lvim-desktop
  ];
}
