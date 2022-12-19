{ pkgs }:

with pkgs;

vscode-with-extensions.override {
  vscodeExtensions = with vscode-extensions; [
    bbenoist.nix
    esbenp.prettier-vscode
    naumovs.color-highlight
    svelte.svelte-vscode
  ] ++ vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "volar";
      publisher = "vue";
      version = "1.0.12";
      sha256 = "sha256-D9E3KRUOlNVXH4oMv1W0+/mbqO8Se7+6E2F5P/KvCro=";
    }
    {
      name = "vscode-typescript-vue-plugin";
      publisher = "vue";
      version = "1.0.12";
      sha256 = "sha256-WiL+gc9+U861ubLlY/acR+ZcrFT7TdIDR0K1XNNidX8=";
    }
    {
      name = "decay";
      publisher = "decaycs";
      version = "1.0.5";
      sha256 = "sha256-UKPGopCNY0A4J+E9Egu1lhM7woDW+4lNOs3L1CfQq+0=";
    }
    {
      name = "material-icon-theme";
      publisher = "pkief";
      version = "4.22.0";
      sha256 = "sha256-U9P9BcuZi+SUcvTg/fC2SkjGRD4CvgJEc1i+Ft2OOUc=";
    }
  ];
}
