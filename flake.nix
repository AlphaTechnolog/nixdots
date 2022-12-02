{
  description = "My NixOS Configuration Files! home-manager + flakes + nix = power!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    nur.url = github:nix-community/NUR;
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-f2k, ... }@inputs:
    let
      system = "x86_64-linux";

      config = {
        system = system;
        allowUnfree = true;
      };

      lib = nixpkgs.lib;

      overlays = with inputs; [
        (final: _:
          let inherit (final) system;
          in
          {
            neovim-nightly = neovim.packages."${system}".neovim;
          } // (with nixpkgs-f2k.packages.${system}; {
            awesome = awesome-git;
            picom = picom-git;
          })
        )
        neovim-nightly.overlay
        nixpkgs-f2k.overlays.default
        nur.overlay
      ];
    in {
      nixosConfigurations = {
        ultra = import ./hosts/ultra {
          inherit config nixpkgs overlays inputs system home-manager;
        };
      };
    };
}
