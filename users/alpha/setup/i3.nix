{
  lib,
  pkgs,
}: let
  mod = "Mod4";
in {
  imports = [
    (import ./polybar.nix)
  ];

  home.packages = with pkgs; [
    feh
  ];

  home.file.".background-image".source = ./wallpaper.png;

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;
      fonts = {
        names = ["Inter"];
        style = "Medium";
        size = 11.0;
      };
      bars = [];
      colors = let
        colors = import ../theme/colors.nix {};
      in
        with colors; {
          background = bg;
          focused = {
            border = black;
            background = bg;
            text = fg;
            indicator = black;
            childBorder = black;
          };
          focusedInactive = {
            border = bg-lighter;
            background = bg;
            text = fg;
            indicator = bg-lighter;
            childBorder = bg-lighter;
          };
          unfocused = {
            border = bg-lighter;
            background = bg;
            text = fg;
            indicator = bg-lighter;
            childBorder = bg-lighter;
          };
          urgent = {
            border = bg;
            background = bg;
            text = red;
            indicator = bg;
            childBorder = bg;
          };
          placeholder = {
            border = bg;
            background = bg;
            text = grey;
            indicator = bg;
            childBorder = bg;
          };
        };
      window = {
        border = 1;
        titlebar = false;
      };
      gaps.inner = 8;
      keybindings = lib.mkOptionDefault {
        "${mod}+s" = "exec sh -c '${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png'";
        "${mod}+Shift+Return" = "exec ${pkgs.rofi}/bin/rofi -show drun";
        "${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${mod}+w" = "kill";

        # Focus
        "${mod}+j" = "focus left";
        "${mod}+k" = "focus down";
        "${mod}+l" = "focus up";
        "${mod}+semicolon" = "focus right";

        # Move
        "${mod}+Shift+j" = "move left";
        "${mod}+Shift+k" = "move down";
        "${mod}+Shift+l" = "move up";
        "${mod}+Shift+semicolon" = "move right";
      };
    };
  };
}
