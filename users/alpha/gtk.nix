{ pkgs, ... }: let
  cursor-theme = "macOS-BigSur";
  materia-theme = with pkgs; callPackage ../../derivs/materia-theme.nix {
    src = materia-theme-src;
  };
  apple-cursor = with pkgs; callPackage ../../derivs/apple-cursor.nix {
    src = apple-cursor-src;
  };
in {
  home.file.".icons/default".source = "${apple-cursor}/share/icons/${cursor-theme}/";
  gtk = with pkgs; {
    enable = true;
    theme = {
      name = "Materia-dark";
      package = materia-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = papirus-icon-theme;
    };
    cursorTheme = {
      name = cursor-theme;
      package = apple-cursor;
    };
  };
}
