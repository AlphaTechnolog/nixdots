{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$username [in](fg:purple) $directory$nix_shell$git_branch$git_state$git_status\n$battery$character";

      username = {
        style_user = "bg:cyan fg:black";
        style_root = "bg:cyan fg:black bold";
        format = "[  ](bg:blue fg:black)[ $user ]($style)";
        disabled = false;
        show_always = true;
      };

      nix_shell = {
        format = "[via](fg:purple) [$symbol$state( \\($name\\))]($style) ";
        symbol = "❄️ ";
      };

      git_branch = {
        format = "[on](fg:purple) [$symbol](fg:red)[$branch(:$remote_branch)]($style) ";
        symbol = " ";
        style = "bold cyan";
      };
    };
  };
}
