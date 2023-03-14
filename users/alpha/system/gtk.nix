{pkgs}: {
  home.file.".icons/default".source = "${pkgs.apple-cursor}/share/icons/macOS-Monterey";
  home.packages = with pkgs; [catppuccin-gtk];

  home.sessionVariables = {
    GTK_THEME = "Catppuccin-Frappe-Standard-Blue-Dark";
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

    theme.name = "Catppuccin-Frappe-Standard-Blue-Dark";

    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;

    gtk3.extraConfig = {
      gtk-decoration-layout = "menu:";
      gtk-application-prefer-dark-theme = true;
    };
  };
}
