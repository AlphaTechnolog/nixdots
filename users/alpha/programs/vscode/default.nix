{ pkgs }:

{
  home.packages = with pkgs; [
    luaFormatter
  ];

  programs.vscode = {
    enable = true;
    userSettings = {
      "workbench.colorTheme" = "Dark Decay Theme";
      "workbench.iconTheme" = "material-icon-theme";
      "editor.bracketPairColorization.enabled" = false;
      "editor.fontFamily" = "Liga SFMono Nerd Font";
      "editor.fontLigatures" = true;
      "editor.cursorStyle" = "line-thin";
      "editor.fontSize" = 14;
      "editor.lineHeight" = 24;
      "window.menuBarVisibility" = "toggle";
      "vscode-lua-format.binaryPath" = "${pkgs.luaFormatter}/bin/lua-format";
    };
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      esbenp.prettier-vscode
      naumovs.color-highlight
      svelte.svelte-vscode
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
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
      {
        name = "vscode-lua-format";
        publisher = "koihik";
        version = "1.3.8";
        sha256 = "sha256-ACdjiy+Rj2wmxvSojaJmtCwyryWWB+OA/9hBEMJi39g=";
      }
    ];
  };
}