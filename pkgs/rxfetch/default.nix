{ stdenv, pkgs, src, lib, ... }:

stdenv.mkDerivation rec {
  name = "rxfetch";
  pname = name;
  version = "latest";

  inherit src;

  patches = [
    ./patches/uptime.patch
    ./patches/pkgs.patch
    ./patches/song-field.patch
  ];

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/fonts
    cp -r ./rxfetch $out/bin
    cp -r ./ttf-material-design-icons/* $out/share/fonts
  '';

  meta = {
    description = "A custom system info fetching tool";
    homepage = "https://github.com/Mangeshrex/rxfetch";
    platforms = lib.platforms.unix;
    maintainers = with lib.maintainers; [ mangeshrex ];
  };
}
