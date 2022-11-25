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
  ];
}
