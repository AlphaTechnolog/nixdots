{nix-colors, pkgs, ...}: let
  lib = pkgs.lib;

  scheme = {
    slug = "decay";
    name = "decay";
    author = "decay";
    colors = {
      base00 = "0d0f13";
      base01 = "161a21";
      base02 = "1f242e";
      base03 = "394254";
      base04 = "b6beca";
      base05 = "c7ccd1";
      base06 = "dfe2e5";
      base07 = "f3f4f5";
      base08 = "f1747b";
      base09 = "ffd1a6";
      base0A = "ffd9a0";
      base0B = "96d1f8";
      base0C = "7bcea0";
      base0D = "75a2dd";
      base0E = "e498e7";
      base0F = "c898e7";
    };
  };
in {
  colorScheme = scheme;

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  theme.base16 = let
    toHexColor = inputString: let
      hex = with builtins; {
        r = substring 0 2 inputString;
        g = substring 2 2 inputString;
        b = substring 4 2 inputString;
      };
    in hex;
    colors = lib.mapAttrs (name: value:
      if (builtins.substring 0 4 name) != "base" then null
      else { hex = toHexColor value; }
    ) scheme.colors;
  in { inherit colors; };

  imports = let
    nix-colors-lib = nix-colors.lib.contrib { inherit pkgs; };
    gtk-package = nix-colors-lib.gtkThemeFromScheme { inherit scheme; };
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {inherit pkgs;};
    nur-no-packages = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {};
  in lib.attrValues nur-no-packages.repos.rycee.hmModules ++ [
    nix-colors.homeManagerModules.default
    (import ./gtk.nix { inherit gtk-package pkgs scheme; })
    (import ./programs { inherit nur pkgs; })
    (import ./xorg/openbox { inherit pkgs scheme; })
    ./settings.nix
    ./xresources.nix
    ./shell.nix
    ./face.nix
  ];
}
