{nix-colors, pkgs, ...}: let
  theme = "mountain";

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

  imports = let
    nix-colors-lib = nix-colors.lib.contrib { inherit pkgs; };
    gtk-package = nix-colors-lib.gtkThemeFromScheme { inherit scheme; };
  in [
    nix-colors.homeManagerModules.default
    (import ./gtk.nix { inherit gtk-package pkgs scheme; })
    ./settings.nix
    ./xresources.nix
    ./shell.nix
    ./programs
  ];
}
