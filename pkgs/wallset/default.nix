{ stdenv, src, pkgs, ... }: stdenv.mkDerivation rec {
  pname = "wallset";
  version = "latest";

  inherit src;

  propagatedUserEnvPkgs = with pkgs; [
    ffmpeg
    feh
    file
    imagemagick
    xorg.xrandr
    xdg-utils
    bash
  ];

  patches = [
    ./patches/hd-patch.diff  # makes video look hd instead of blurry and ugly as how default it's
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r ./wallset $out/bin/wallset
    chmod +x $out/bin/wallset
  '';

  meta = {
    description = "A simple animated wallpapers setter";
    homepage = "https://github.com/terroo/wallset";
  };
}
