{pkgs}: {
  # enable starship inside bash interactive session (useful when using nix-shell).
  programs.bash.promptInit = ''
    eval "$(${pkgs.starship}/bin/starship init bash)"
  '';

  # setting default shell to fish
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
}