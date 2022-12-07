# took reference from rxyhn's dotfiles.
{ pkgs, ... }:

let
  enable_animations = "yes";
  colors = import ../../theme/raw-colors.nix {};
in {
  home.packages = with pkgs; [
    wf-recorder
    wl-clipboard
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    swaybg
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    extraConfig = import ./config.nix {
      inherit enable_animations colors;
    };
  };

  xdg.configFile.".wallpaper.png".source = ./assets/wallpaper.png;
}
