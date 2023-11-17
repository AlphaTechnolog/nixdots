{ inputs, pkgs, system, ... }: with inputs; [
  nixpkgs-2fk.overlays.default
  (
    final: _: let
      inherit (final) system;
    in (with nixpkgs-2fk.packages.${system}; {
      awesome = awesome-git;
      picom = picom-git;
    })
  )
]
