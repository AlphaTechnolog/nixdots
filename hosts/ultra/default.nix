{
  config,
  nixpkgs,
  overlays,
  inputs,
  home-manager,
  system,
  hyprland,
  ...
}:

nixpkgs.lib.nixosSystem rec {
  inherit system;
  modules = [
    hyprland.nixosModules.default

    ./hyprland.nix
    ./configuration.nix

    {
      nixpkgs = {
        inherit overlays config;
      };
    }

    home-manager.nixosModules.home-manager

    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.alpha = {
        imports = [
          hyprland.homeManagerModules.default
          ../../users/alpha/home.nix
        ];
      };
    }
  ];
}
