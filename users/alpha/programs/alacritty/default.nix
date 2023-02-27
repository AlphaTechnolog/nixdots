{
  pkgs,
  colors,
  ...
}: let
  setfont = import ./setfont.nix {};
  theme = import ./theming.nix {inherit colors;};
in {
  home.activation."installAlacrittyPaddingsSettings" = ''
    if ! test -d $HOME/.config/alacritty; then
      mkdir -p $HOME/.config/alacritty
    fi

    if ! test -f $HOME/.config/alacritty/padding.yaml; then
      ln -sf /etc/nixos/users/alpha/programs/alacritty/padding.yaml $HOME/.config/alacritty/padding.yaml
      chmod +w $HOME/.config/alacritty/padding.yaml
      chown $USER:$USER $HOME/.config/alacritty/padding.yaml
    fi
  '';

  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        "~/.config/alacritty/padding.yaml"
      ];
      colors = theme;
      mouse.hide_when_typing = true;
      font =
        setfont "monospace"
        // {
          size = 14;
        }
        // {
          offset.y = 2;
          glyph_offset.y = 2;
        };
      cursor = {
        style = {
          shape = "Beam";
          blinking = "on";
        };
      };
    };
  };
}
