{ pkgs }:

let
  phosphor = pkgs.callPackage ../../../pkgs/phosphor.nix {};
in {
  home.file.".local/share/fonts".source = ./assets;
  home.packages = [ phosphor ];
}
