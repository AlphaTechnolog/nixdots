# installs my pfp at github inside of ~/.face.png
# if it does not exists.

{ pkgs }: {
  home.activation.installPfp = let
    username = "AlphaTechnolog";
  in ''
    if ! test -f ~/.face.png; then
      ${pkgs.wget}/bin/wget https://github.com/${username}.png
      mv ./${username}.png ~/.face.png
    fi
  '';
}
