{
  programs.home-manager.enable = true;
  home = rec {
    username = "alpha";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };
}
