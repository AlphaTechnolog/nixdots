{ pkgs }:

{
  programs.chromium = {
    enable = true;
    package = pkgs.google-chrome;
    commandLineArgs = [ "--force-dark-mode" ];  # don't  wanna work for some reason that i don't rly understand :/
  };
}