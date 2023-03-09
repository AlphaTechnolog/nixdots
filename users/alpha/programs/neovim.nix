{ pkgs }: {
  home.packages = with pkgs; [
    neovim
    nodejs
  ];
}
