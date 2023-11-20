{
  nixpkgs,
  home-manager,
  pkgs,
  system,
  overlays,
  inputs,
  ...
}: nixpkgs.lib.nixosSystem rec {
  inherit system;

  modules = let
    lib = pkgs.lib;
    hostname = "workstation";
  in [
    {
      nixpkgs = {
        inherit overlays;
        config = {
          allowUnfree = true;
          pulseaudio = true;
        };
      };
    }
    (import ../shared { inherit hostname home-manager inputs pkgs; })
    (import ./configuration.nix { inherit pkgs inputs; })
    (import ./fonts.nix { inherit pkgs inputs; })
    (import ./docker.nix { inherit pkgs; })
    (import ./graphical-env.nix { inherit pkgs lib; })
    (import ./python.nix { inherit pkgs; })
    (import ./shell.nix { inherit pkgs; })
    (import ./security.nix)
  ];
}