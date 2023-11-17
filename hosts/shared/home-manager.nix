{ home-manager, pkgs, inputs, ... }: {
  imports = [
    home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.alpha.imports = [../../users/alpha];
      };
    }
  ];
}
