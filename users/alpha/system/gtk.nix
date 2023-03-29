{pkgs}: {
  home.file.".icons/default".source = "${pkgs.apple-cursor}/share/icons/macOS-Monterey";
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

    cursorTheme = with pkgs; {
      name = "macOS-Monterey";
      package = apple-cursor;
    };

    theme.name = "Decayce";

    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;

    gtk3.extraConfig = {
      gtk-decoration-layout = "menu:";
      gtk-application-prefer-dark-theme = true;
    };
  };
}
