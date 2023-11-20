# TODO: Add more general overlays at the array which is blank
{ pkgs, system, inputs, ... }: []
  ++ (import ./nixpkgs-2fk.nix { inherit pkgs inputs system; })
  ++ (import ./apple-cursor.nix { inherit inputs; })
  ++ (import ./materia-theme.nix { inherit inputs; })
