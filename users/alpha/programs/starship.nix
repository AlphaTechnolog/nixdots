{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = ''
        [](blue)[  ](bg:blue fg:black)[](bg:black fg:blue)$directory[](black) $git_branch$nix_shell
        $character
      '';
      directory = {
        format = "[ $path ]($style)";
        style = "bg:black";
        truncate_to_repo = false;
      };
      git_branch = {
        style = "bold yellow";
      };
      character = {
        success_symbol = "[](bold green)";
        error_symbol = "[](bold red)";
      };
      nix_shell = {
        symbol = "[](bold blue) ";
      };
    };
  };
}
