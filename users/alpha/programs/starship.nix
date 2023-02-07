{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "[](fg:white)$username[](fg:white) [in](fg:purple) $directory$nix_shell$git_branch\n$battery$character";

      username = {
        style_user = "bg:white fg:black";
        style_root = "bg:white fg:black bold";
        format = "[$user]($style)";
        disabled = false;
        show_always = true;
      };

      nix_shell = {
        format = "[via](fg:purple) [$symbol$state( \\($name\\))]($style) ";
        symbol = "❄️";
      };

      git_branch = {
        format = "[on](fg:purple) [$symbol](fg:red)[$branch(:$remote_branch)]($style) ";
        symbol = " ";
        style = "bold cyan";
      };
    };
  };
}