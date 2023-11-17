{ pkgs }: {
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  programs.bash.promptInit = ''
    eval "$(${pkgs.starship}/bin/starship init bash)"
  '';
}
