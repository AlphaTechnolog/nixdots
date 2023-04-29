{
  # let home manager install and manage itself.
  programs.home-manager.enable = true;

  # home configuration, this to let home manager know a little more about
  # the current system configuration.
  home = rec {
    username = "alpha";
    homeDirectory = "/home/${username}";
    stateVersion = "22.05";
  };
}
