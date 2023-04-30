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
    xclip
    inotify-tools
    cinnamon.nemo
  ];
}
