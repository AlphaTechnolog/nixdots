{
  programs.discocss = {
    enable = true;
    discordAlias = true;
    css = builtins.readFile ./custom.css;
  };
}