{pkgs}: let
  google-dot-cursor = pkgs.callPackage ../../../pkgs/google-dot-cursor.nix {};
in {
  home.file.".icons/default".source = "${google-dot-cursor}/share/icons/GoogleDot-White";
  home.packages = [pkgs.decay-gtk];

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

    cursorTheme = {
      name = "GoogleDot-White";
      package = google-dot-cursor;
    };

    theme.name = "Decayce";

    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;

    gtk3.extraConfig = {
      gtk-decoration-layout = "menu:";
      gtk-application-prefer-dark-theme = true;
    };
  };
}
