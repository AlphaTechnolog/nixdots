{ pkgs }:

with pkgs;

vscode-with-extensions.override {
  vscodeExtensions = with vscode-extensions; [
    bbenoist.nix
  ] ++ vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "decay";
      publisher = "decaycs";
      version = "1.0.4";
      sha256 = "sha256-ZxiTdMkl7LtoomGdVFCIKUGLpgwk7Nb4g9EwS842wp4=";
    }
    {
      name = "material-icon-theme";
      publisher = "pkief";
      version = "4.22.0";
      sha256 = "sha256-U9P9BcuZi+SUcvTg/fC2SkjGRD4CvgJEc1i+Ft2OOUc=";
    }
    {
      name = "prettier-vscode";
      publisher = "esbenp";
      version = "9.10.3";
      sha265 = "sha256-BTuTTElPYRtbzQvUC3iMYlj7NDkGSDa/IppOGBXjfUM=";
    }
  ];
}
