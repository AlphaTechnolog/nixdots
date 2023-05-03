{ pkgs, ... }: {
  home.packages = with pkgs; [
    spotify
    gh
    feh
    nodejs
    mongodb-compass
    postman
    brightnessctl
    light
    emacs
    google-chrome
    xclip
    inotify-tools
    cinnamon.nemo
  ];
}
