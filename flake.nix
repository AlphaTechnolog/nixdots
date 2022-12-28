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

    hyprland = {
      url = github:hyprwm/Hyprland;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-f2k, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = nixpkgs.legacyPackages.${system};

      config = {
        system = system;
        allowUnfree = true;
      };

      lib = nixpkgs.lib;

      overlays = with inputs; [
        (final: _:
          let
            inherit (final) system;
          in {
            neovim-nightly = neovim.packages."${system}".neovim;
          } // (with nixpkgs-f2k.packages.${system}; {
            awesome = awesome-git;
            picom = picom-git;
          }) // {
            sf-mono-liga-bin = pkgs.callPackage ./pkgs/sfmono-nf.nix {
              src = inputs.sf-mono-liga-src;
            };
          }
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
        fancy = import ./hosts/fancy {
          inherit config nixpkgs overlays inputs system home-manager;
          hyprland = inputs.hyprland;
        };
      };
    };
}
