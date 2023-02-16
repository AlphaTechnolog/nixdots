{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$username$directory ";
      directory = {
        format = "[ $path ]($style)";
        style = "bg:black";
      };
      username = {
        disabled = false;
        format = "[ $user ]($style)";
        show_always = true;
        style_root = "bg:green fg:black bold";
        style_user = "bg:green fg:black";
      };
    };
  };
}
