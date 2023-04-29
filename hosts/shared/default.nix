{
  hostname,
  home-manager,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    (import ./configuration.nix { inherit pkgs hostname; })
    (import ./pkgs.nix { inherit pkgs; })
    (import ./home-manager.nix { inherit home-manager inputs pkgs; })
  ];
}
