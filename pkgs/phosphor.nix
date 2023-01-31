{ lib, stdenv, fetchzip, pkgs }:

stdenv.mkDerivation rec {
  pname = "phosphor-icons";
  version = "latest";

  src = fetchzip {
    url = "https://github.com/phosphor-icons/homepage/releases/download/v1.4.0/phosphor-icons.zip";
    sha256 = "Jhk5yiGHEygFF7oruVpwQXXLjlj1enpv9a9pK2ptZ6w=";
    stripRoot = false;
  };

  installPhase = ''
    mkdir -p $out/share/fonts
    cp -r $src/"Icon Font"/Font/Phosphor.ttf $out/share/fonts
  '';

  meta = {
    description = "Phosphor icons";
    homepage = "https://github.com/phosphor-icons/homepage";
    maintainers = [lib.maintainers.phosphor-icons];
  };
}