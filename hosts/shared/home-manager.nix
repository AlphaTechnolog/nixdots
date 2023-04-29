{ home-manager, pkgs, inputs, ... }: {
  imports = [
    home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit (inputs) nix-colors; };
        users.alpha.imports = [
          (import ../../users/alpha {
            inherit pkgs;
            inherit (inputs) nix-colors;
          })
        ];
      };
    }
  ];
}
