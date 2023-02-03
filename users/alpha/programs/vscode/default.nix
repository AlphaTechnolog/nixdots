{ config, pkgs }:

{
  home.packages = with pkgs; [
    luaFormatter
  ];

  programs.vscode = {
    enable = true;
    userSettings = {
      "workbench.colorTheme" = "Ayu Mirage Bordered";
      "workbench.iconTheme" = "material-icon-theme";
      "editor.bracketPairColorization.enabled" = false;
      "editor.fontFamily" = "monospace";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 16;
      "terminal.integrated.fontSize" = 16;
      "editor.cursorWidth" = 3;
      "editor.defaultFormatter" = "Koihik.vscode-lua-format";
      "php.validate.executablePath" = "${pkgs.php82}/bin/php";
      "vscode-lua-format.binaryPath" = "${pkgs.luaFormatter}/bin/lua-format";
      "vscode-lua-format.configPath" = "${config.xdg.configHome}/LuaFormatter.cfg";
      "window.menuBarVisibility" = "toggle";
      "editor.tabSize" = 2;
      "[python]"."editor.tabSize" = 4;
      "editor.inlineSuggest.enabled" = true;
      "vim.useSystemClipboard" = true;
      "vim.insertModeKeyBindingsNonRecursive" = [
        {
          before = [ "j" "k" ];
          after = [ "<esc>" ];
        }
      ];
    };
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      esbenp.prettier-vscode
      naumovs.color-highlight
      svelte.svelte-vscode
      ms-vsliveshare.vsliveshare
      github.copilot
      vscodevim.vim
      sumneko.lua
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "ayu";
        publisher = "teabyii";
        version = "1.0.5";   
        sha256 = "sha256-+IFqgWliKr+qjBLmQlzF44XNbN7Br5a119v9WAnZOu4=";
      }
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
      {
        name = "tokyo-night";
        publisher = "enkia";
        version = "0.9.4";
        sha256 = "sha256-pKokB6446SR6LsTHyJtQ+FEA07A0W9UAI+byqtGeMGw=";
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
