{ pkgs }:

{
  xdg.configFile."fish/config.fish".text = let
    wrapper = pkgs.writeScript "command-not-found" ''
      #!${pkgs.bash}/bin/bash
      source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
      command_not_found_handle "$@"
    '';
  in ''
    starship init fish | source
    set fish_greeting
    set fish_color_command brgreen
    set fish_color_param brwhite
    set fish_color_quote bryellow
    set PATH "$PATH:$HOME/.local/bin"

    function __fish_command_not_found_handler --on-event fish_command_not_found
      ${wrapper} $argv
    end
  '';
}
