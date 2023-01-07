{ config, pkgs }:

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
      "editor.fontFamily" = "monospace";
      "editor.fontLigatures" = true;
      "editor.cursorStyle" = "line-thin";
      "editor.fontSize" = 16;
      "editor.defaultFormatter" = "Koihik.vscode-lua-format";
      "vscode-lua-format.binaryPath" = "${pkgs.luaFormatter}/bin/lua-format";
      "vscode-lua-format.configPath" = "${config.xdg.configHome}/LuaFormatter.cfg";
      "window.menuBarVisibility" = "toggle";
      "[lua]"."editor.tabSize" = 2;
    };
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      esbenp.prettier-vscode
      naumovs.color-highlight
      svelte.svelte-vscode
      ms-vsliveshare.vsliveshare
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
        version = "1.0.6";
        sha256 = "sha256-Jtxj6LmHgF7UNaXtXxHkq881BbuPtIJGxR7kdhKr0Uo=";
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

  xdg.configFile."LuaFormatter.cfg".text = ''
    indent_width: 2
    use_tab: false
    keep_simple_control_block_one_line: false
    keep_simple_function_one_line: false
    single_quote_to_double_quote: true
    chop_down_table: true
    chop_down_kv_table: true
  '';
}
