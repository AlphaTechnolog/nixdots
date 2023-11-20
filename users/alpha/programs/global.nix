{ pkgs, ... }: {
  home.packages = with pkgs; [
    spotify
    gh
    feh
    nodejs
    brightnessctl
    light
    xclip
    inotify-tools
    cargo
    rustc
    rust-analyzer
    cinnamon.nemo
  ];
}
