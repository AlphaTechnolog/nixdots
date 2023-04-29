{ fetchPypi, pkgs, lib, ... }:

with pkgs.python3Packages; buildPythonPackage rec {
  pname = "material-color-utilities-python";
  version = "0.1.5";
  doCheck = false;
  propagatedBuildInputs = [
    pillow
    regex
    setuptools
  ];
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-PG8C585wWViFRHve83z3b9NijHyV+iGY2BdMJpyVH64=";
  };
}