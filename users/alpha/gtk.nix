{pkgs, gtk-package, scheme}: let
  google-dot-cursor = pkgs.callPackage ../../derivs/google-dot-cursor.nix {};
in {
  home.file.".icons/default".source = "${google-dot-cursor}/share/icons/GoogleDot-White";

  home.sessionVariables = {
    XCURSOR_SIZE = "24";
  };

  gtk = {
    enable = true;

    theme = {
      name = scheme.slug;
      package = gtk-package;
    };

    iconTheme = with pkgs; {
      name = "Papirus-Dark";
      package = papirus-icon-theme;
    };

    cursorTheme = {
      name = "GoogleDot-White";
      package = google-dot-cursor;
    };

    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;

    gtk3.extraConfig = {
      gtk-decoration-layout = "menu:";
      gtk-application-prefer-dark-theme = true;
    };
  };
}