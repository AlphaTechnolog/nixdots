{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs;
    nixpkgs-2fk.url = github:moni-dz/nixpkgs-f2k;

    # source code for some packages
    sf-mono-liga-src = {
      url = github:shaunsingh/SFMono-Nerd-Font-Ligaturized;
      flake = false;
    };
    cutefetch-source = {
      url = github:alphatechnolog/cutefetch;
      flake = false;
    };
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... } @inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    overlays = import ./overlays { inherit pkgs system inputs; };
  in {
    nixosConfigurations.workstation = import ./hosts/workstation {
      inherit
        nixpkgs
        home-manager
        system
        pkgs
        overlays
        inputs;
    };
  };
}
