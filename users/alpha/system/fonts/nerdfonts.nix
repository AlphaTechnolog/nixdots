{ pkgs }:

with pkgs; nerdfonts.override {
  fonts = [
    "Iosevka"
    "JetBrainsMono"
    "IBMPlexMono"
    "Mononoki"
    "Monofur"
    "CascadiaCode"
    "Hack"
  ];
}
