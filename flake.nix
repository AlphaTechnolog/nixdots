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

    st = {
      url = github:AlphaTechnolog/st;
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

    lunarvim = {
      url = "github:AlphaTechnolog/LunarVim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-f2k, luaFormatter, ... }@inputs:
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
            st = pkgs.callPackage ./pkgs/st.nix {
              src = st;
              conf = import ./users/alpha/programs/st/config.nix;
            };
          } // (with nixpkgs-f2k.packages.${system}; {
            awesome = awesome-git;
            picom = picom-git;
          }) // {
            luaFormatter-src = luaFormatter;
            rxfetch-bin = pkgs.callPackage ./pkgs/rxfetch { src = inputs.rxfetch; };
            lunarvim-src = inputs.lunarvim;
            lunarvim-wrapper = pkgs.writeScriptBin "lvim" ''
              #!${pkgs.bash}/bin/bash
              exec -a lvim nvim -u "$HOME/.local/share/lunarvim/lvim/init.lua" "$@"
            '';
            sf-mono-liga-bin = pkgs.callPackage ./pkgs/sfmono-nf.nix {
              src = inputs.sf-mono-liga-src;
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
