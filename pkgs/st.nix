{ lib, stdenv, fetchurl, src, pkg-config, fontconfig, freetype, libX11, libXft
, harfbuzz, gd, glib, ncurses, writeText, conf ? null, patches ? [ ]
, extraLibs ? [ ], nixosTests }:

stdenv.mkDerivation rec {
  name = "st-snazzy";
  pname = name;
  version = "0.8.5";

  inherit src patches;

  configFile =
    lib.optionalString (conf != null) (writeText "config.def.h" conf);

  postPatch = lib.optionalString (conf != null) "cp ${configFile} config.def.h"
    + lib.optionalString stdenv.isDarwin ''
      substituteInPlace config.mk --replace "-lrt" ""
    '';

  strictDeps = true;

  makeFlags = [ "PKG_CONFIG=${stdenv.cc.targetPrefix}pkg-config" ];

  nativeBuildInputs = [ pkg-config ncurses fontconfig freetype ];
  buildInputs = [ libX11 libXft harfbuzz gd glib ] ++ extraLibs;

  preInstall = ''
    export TERMINFO=$out/share/terminfo
  '';

  installFlags = [ "PREFIX=$(out)" ];

  passthru.tests.test = nixosTests.terminal-emulators.st;

  meta = with lib; {
    homepage = "https://github.com/AlphaTechnolog/st";
    description = "snazzy terminal (suckless + lightweight)";
    license = licenses.mit;
    maintainers = with maintainers; [ alphatechnolog ];
    platforms = platforms.unix;
  };
}
