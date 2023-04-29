{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs;
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    nix-colors.url = github:misterio77/nix-colors;

    nvchad = {
      url = "github:NvChad/NvChad";
      flake = false;
    };

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    overlays = import ./overlays { inherit inputs pkgs system; };
  in {
    nixosConfigurations.reborn = import ./hosts/reborn {
      inherit
        nixpkgs
        home-manager
        system
        pkgs
        inputs
        overlays;
    };
  };
}
