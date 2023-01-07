{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      set fish_color_command brgreen
      set fish_color_param brwhite
      set fish_color_quote bryellow
    '';
  };
}