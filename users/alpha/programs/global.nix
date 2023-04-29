{ pkgs, ... }: {
  home.packages = with pkgs; [
    spotify
    gh
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
