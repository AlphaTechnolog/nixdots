{ pkgs, ... }: {
  home.packages = with pkgs; [
    spotify
    firefox
    gh
    nodejs
    mongodb-compass
    postman
    xfce.thunar
  ];
}