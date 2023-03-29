{ pkgs }: {
  home.file.".tmux.conf".source = ./config.conf;

  home.packages = [
    pkgs.tmux
  ];
}
