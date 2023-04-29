{nix-colors, pkgs, ...}: let
  theme = "mountain";

  lib = pkgs.lib;

  scheme = let
    base-scheme = nix-colors.colorSchemes.${theme};
  in {
    inherit (base-scheme)
      name
      slug
      author;

    colors = base-scheme.colors // {
      base01 = "161616";
      base02 = "1a1a1a";
    };
  };
in {
  colorScheme = scheme;
  nixpkgs.config.allowUnfree = true;

  theme.base16 = let
    toHexColor = inputString: let
      hex = with builtins; {
        r = substring 0 2 inputString;
        g = substring 2 2 inputString;
        b = substring 4 2 inputString;
      };
    in hex;
    colors = lib.mapAttrs (name: value: { hex = toHexColor value; }) scheme.colors;
  in { inherit colors; };

  imports = let
    nix-colors-lib = nix-colors.lib.contrib { inherit pkgs; };
    gtk-package = nix-colors-lib.gtkThemeFromScheme { inherit scheme; };
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {inherit pkgs;};
    nur-no-packages = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {};
  in lib.attrValues nur-no-packages.repos.rycee.hmModules ++ [
    nix-colors.homeManagerModules.default
    (import ./gtk.nix { inherit gtk-package pkgs scheme; })
    (import ./programs { inherit nur; })
    ./settings.nix
    ./xresources.nix
    ./shell.nix
  ];
}
