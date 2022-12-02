{ builtins }:

{
  programs.wezterm = {
    enable = true;
    extraConfig = import ./settings.nix { inherit builtins; };
  };
}
