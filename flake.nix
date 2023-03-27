{
  description = "My NixOS Configuration Files! home-manager + flakes + nix = power!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    nur.url = github:nix-community/NUR;

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = github:hyprwm/Hyprland;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };

    luaFormatter = {
      type = "git";
      url = "https://github.com/Koihik/LuaFormatter.git";
      submodules = true;
      flake = false;
    };

    rxfetch = {
      url = "github:Mangeshrex/rxfetch";
      flake = false;
    };

    wallset = {
      url = "github:terroo/wallset";
      flake = false;
    };

    patched-fonts = {
      url = github:40huo/Patched-Fonts;
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixpkgs-f2k,
    luaFormatter,
    hyprland,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    pkgs = nixpkgs.legacyPackages.${system};

    config = {
      system = system;
      allowUnfree = true;
    };

    lib = nixpkgs.lib;

    overlays = with inputs; [
      (
        final: _: let
          inherit (final) system;
        in
          (with nixpkgs-f2k.packages.${system}; {
            awesome = awesome-git;
            picom = picom-git;
          })
          // {
            luaFormatter-src = luaFormatter;
            rxfetch-bin = pkgs.callPackage ./pkgs/rxfetch {src = rxfetch;};
            wallset = pkgs.callPackage ./pkgs/wallset {src = wallset;};

            patched-fonts = pkgs.callPackage ./pkgs/patched-fonts.nix {
              src = patched-fonts;
            };

            sf-mono-liga-bin = pkgs.callPackage ./pkgs/sfmono-nf.nix {
              src = sf-mono-liga-src;
            };
          }
      )
      (final: prev: {
        phosphor-icons = prev.callPackage ./pkgs/phosphor.nix {};
        luaFormatter = prev.callPackage ./pkgs/luaFormatter.nix {
          src = prev.luaFormatter-src;
          version = "999-master";
        };
      })
      nixpkgs-f2k.overlays.default
      nur.overlay
    ];
  in {
    nixosConfigurations.ultra = import ./hosts/ultra {
      inherit
        nixpkgs
        config
        overlays
        inputs
        system
        hyprland
        home-manager
        ;
    };
  };
}
