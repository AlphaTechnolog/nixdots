{ pkgs }:

let
  decayce-gtk = pkgs.callPackage ../../../pkgs/decayce-gtk.nix {};
in {
  home.file.".icons/default".source = "${pkgs.phinger-cursors}/share/icons/phinger-cursors";
  home.packages = [decayce-gtk];

  home.sessionVariables = {
    GTK_THEME = "Decayce";
    XCURSOR_SIZE = "24";
  };

  gtk = {
    enable = true;

    iconTheme = with pkgs; {
      name = "Papirus-Dark";
      package = papirus-icon-theme;
    };

    cursorTheme = with pkgs; {
      name = "phinger-cursors";
      package = phinger-cursors;
    };

    theme.name = "Decayce";

    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;

    gtk3.extraConfig = {
      gtk-decoration-layout = "menu:";
      gtk-application-prefer-dark-theme = true;
    };
  };
}