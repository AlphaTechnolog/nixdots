{ pkgs }:

let
  nfonts = pkgs.callPackage ./nerdfonts.nix { inherit pkgs; };
in {
  home.file.".local/share/fonts".source = ./assets;

  home.packages = [
    nfonts
  ];
}
