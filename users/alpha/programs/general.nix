{ pkgs, ... }: {
  home.packages = with pkgs; let
    colortest = pkgs.callPackage ../../../derivs/colortest.nix {};
  in [
    pavucontrol
    colortest
  ];
}
