{ pkgs, ... }: {
  home.packages = with pkgs; [
    spotify
    gh
    nodejs
    mongodb-compass
    postman
    xfce.thunar
  ];
}