{
  home.activation.installPfp = let
    username = "AlphaTechnolog";
  in ''
    if ! test -f ~/.face.png; then
      wget https://github.com/${username}.png
      mv ./${username}.png ~/.face.png
    fi
  '';
}