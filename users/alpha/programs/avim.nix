{pkgs}: let
  avim = pkgs.writeScriptBin "avim" ''
    #!${pkgs.bash}/bin/bash
    ${pkgs.neovide}/bin/neovide ''${@}
  '';

  avim-desktop = pkgs.makeDesktopItem {
    name = "avim";
    desktopName = "Avim";
    exec = "avim";
    icon = "nvim";
    terminal = false;
  };
in {
  home.packages = [
    avim
    avim-desktop
  ];
}