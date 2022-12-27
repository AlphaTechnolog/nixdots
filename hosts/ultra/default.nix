{ config, nixpkgs, overlays, inputs, home-manager, system, ... }:

with nixpkgs;

lib.nixosSystem rec {
  inherit system;

  modules = [
    ./configuration.nix

    {
      nixpkgs = {
        inherit overlays config;
      };
    }

    home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = false;
      home-manager.useUserPackages = true;
      home-manager.users.alpha = {
        imports = [
          ../../users/alpha/home.nix
          ../../users/alpha/programs/helix
        ];
      };
    }
  ];
}
