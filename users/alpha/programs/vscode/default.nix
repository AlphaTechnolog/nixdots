{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    stylua
    sumneko-lua-language-server
    gopls
  ];

  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    extensions = with pkgs.vscode-extensions;
      [
        bbenoist.nix
        christian-kohler.path-intellisense
        dbaeumer.vscode-eslint
        eamodio.gitlens
        catppuccin.catppuccin-vsc
        esbenp.prettier-vscode
        github.copilot
        golang.go
        ibm.output-colorizer
        kamadorueda.alejandra
        matklad.rust-analyzer
        ms-azuretools.vscode-docker
        ms-vscode.cpptools
        ms-vscode-remote.remote-ssh
        naumovs.color-highlight
        pkief.material-product-icons
        pkief.material-icon-theme
        streetsidesoftware.code-spell-checker
        sumneko.lua
        usernamehw.errorlens
        vadimcn.vscode-lldb
        xaver.clang-format
        yzhang.markdown-all-in-one
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "stylua";
          publisher = "johnnymorganz";
          version = "1.4.0";
          sha256 = "sha256-0hdjyQbBbo4NblG6VH339sN/oPQEGDtGjJSyHdM4JCM=";
        }
        {
          name = "tokyo-night";
          publisher = "enkia";
          version = "0.9.4";
          sha256 = "sha256-pKokB6446SR6LsTHyJtQ+FEA07A0W9UAI+byqtGeMGw=";
        }
        {
          name = "vs-code-prettier-eslint";
          publisher = "rvest";
          version = "5.0.4";
          sha256 = "sha256-aLEAuFQQTxyFSfr7dXaYpm11UyBuDwBNa0SBCMJAVRI=";
        }
        {
          name = "decay";
          publisher = "decaycs";
          version = "1.0.9";
          sha256 = "sha256-TwDq8K757CTFEBBBGbP5eOC5nMrQzgf/XYIHi9UCAkU=";
        }
        {
          name = "Material-theme";
          publisher = "zhuangtongfa";
          version = "3.15.6";
          sha256 = "sha256-LViiHGDJjtQwz5O6ZZrAApi2F1rISZvcggCl8Y3nzTA=";
        }
        {
          name = "ayu";
          publisher = "teabyii";
          version = "1.0.5";
          sha256 = "sha256-+IFqgWliKr+qjBLmQlzF44XNbN7Br5a119v9WAnZOu4=";
        }
      ];

    userSettings = {
      breadcrumbs.enabled = false;
      emmet.useInlineCompletions = true;
      github.copilot.enable."*" = true;
      security.workspace.trust.enabled = false;
      security.workspace.trust.untrustedFiles = "open";

      "[c]".editor.defaultFormatter = "xaver.clang-format";
      "[cpp]".editor.defaultFormatter = "xaver.clang-format";
      "[css]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[html]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[javascript]".editor.defaultFormatter = "rvest.vs-code-prettier-eslint";
      "[json]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[jsonc]".editor.defaultFormatter = "rvest.vs-code-prettier-eslint";
      "[lua]".editor.defaultFormatter = "johnnymorganz.stylua";
      stylua.styluaPath = "${pkgs.stylua}/bin/stylua";
      "[nix]".editor.defaultFormatter = "kamadorueda.alejandra";
      "[rust]".editor.defaultFormatter = "rust-lang.rust-analyzer";
      "[scss]".editor.defaultFormatter = "sibiraj-s.vscode-scss-formatter";
      "[typescript]".editor.defaultFormatter = "rvest.vs-code-prettier-eslint";

      editor = {
        cursorSmoothCaretAnimation = "on";
        find.addExtraSpaceOnTop = false;
        fontFamily = "'monospace', monospace";
        fontLigatures = true;
        fontSize = 19;
        lineHeight = 24;
        formatOnSave = true;
        inlayHints.enabled = "off";
        inlineSuggest.enabled = true;
        largeFileOptimizations = false;
        lineNumbers = "on";
        linkedEditing = true;
        maxTokenizationLineLength = 60000;
        minimap.enabled = false;
        overviewRulerBorder = false;
        quickSuggestions.strings = true;
        renderWhitespace = "none";
        renderLineHighlight = "all";
        suggest.showStatusBar = true;
        suggestSelection = "first";
        cursorStyle = "line-thin";
        cursorBlinking = "expand";

        bracketPairColorization = {
          enabled = false;
          independentColorPoolPerBracketType = false;
        };

        guides = {
          bracketPairs = false;
          indentation = true;
        };
      };

      explorer = {
        confirmDragAndDrop = false;
        confirmDelete = true;
      };

      files = {
        eol = "\n";
        insertFinalNewline = true;
        trimTrailingWhitespace = true;

        exclude = {
          "**/.classpath" = true;
          "**/.direnv" = true;
          "**/.factorypath" = true;
          "**/.git" = true;
          "**/.project" = true;
          "**/.settings" = true;
        };
      };

      git = {
        autofetch = true;
        confirmSync = false;
        enableSmartCommit = true;
      };

      terminal.integrated = {
        cursorBlinking = true;
        cursorStyle = "line-thin";
        cursorWidth = 1;
        fontFamily = "'monospace'";
        fontSize = 16;
      };

      Lua.misc.executablePath = "${pkgs.sumneko-lua-language-server}/bin/lua-language-server";

      window = {
        menuBarVisibility = "toggle";
        nativeTabs = true;
        titleBarStyle = "custom";
        zoomLevel = 0;
      };

      workbench = {
        colorTheme = "One Dark Pro Darker";
        iconTheme = "material-icon-theme";
        productIconTheme = "material-product-icons";
      };

      oneDarkPro = {
        vivid = true;
        italic = true;
      };
    };
  };

  xdg.configFile.".stylua.toml".text = ''
    column_width = 120
    line_endings = "Unix"
    indent_type = "Spaces"
    indent_width = 2
    quote_style = "AutoPreferDouble"
    call_parentheses = "Always"
    collapse_simple_statement = "Always"
  '';
}
