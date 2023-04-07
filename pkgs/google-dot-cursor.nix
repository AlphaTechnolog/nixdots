{
  stdenv,
  fetchzip,
  ...
}:
stdenv.mkDerivation rec {
  pname = "google-dot-cursor";
  name = pname;
  version = "latest";

  src = fetchzip {
    url = "https://github.com/ful1e5/Google_Cursor/releases/download/v2.0.0/GoogleDot-White.tar.gz";
    sha256 = "sha256-eT/Zy6O6TBD6G8q/dg+9rNYDHutLLxEY1lvLDP90b+g=";
  };

  installPhase = ''
    mkdir -p $out/share/icons/GoogleDot-White
    cp -r * $out/share/icons/GoogleDot-White
  '';
}
