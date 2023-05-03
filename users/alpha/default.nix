{nix-colors, pkgs, ...}: let
  lib = pkgs.lib;

  scheme = {
    slug = "ashes";
    name = "ashes";
    author = "ashes";
    colors = {
      base00 = "1c2023";
      base01 = "272b2e";
      base02 = "303437";
      base03 = "44484b";
      base04 = "adb3ba";
      base05 = "c7ccd1";
      base06 = "dfe2e5";
      base07 = "f3f4f5";
      base08 = "c7ae95";
      base09 = "c7c795";
      base0A = "aec795";
      base0B = "95c7ae";
      base0C = "95aec7";
      base0D = "ae95c7";
      base0E = "c795ae";
      base0F = "c79595";
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
