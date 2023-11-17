{ pkgs, inputs, ... }: let
  cutefetch = pkgs.callPackage ../../derivs/cutefetch.nix {
    src = inputs.cutefetch-source;
  };
in {
  environment.systemPackages = with pkgs; [
    wget
    git
    cutefetch
    firefox
  ];
}
