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
        adpyke.codesnap
        bbenoist.nix
        christian-kohler.path-intellisense
        dbaeumer.vscode-eslint
        eamodio.gitlens
        esbenp.prettier-vscode
        formulahendry.code-runner
        github.copilot
        golang.go
        ibm.output-colorizer
        kamadorueda.alejandra
        matklad.rust-analyzer
        ms-azuretools.vscode-docker
        ms-python.python
        ms-python.vscode-pylance
        ms-vscode.cpptools
        ms-vscode-remote.remote-ssh
        naumovs.color-highlight
        vscodevim.vim
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
          version = "1.0.8";
          sha256 = "sha256-VowhClGGRL81/VrGE9NgGU1uzYMnRoLx+eqpFss3pUk=";
        }
        {
          name = "Material-theme";
          publisher = "zhuangtongfa";
          version = "3.15.6";
          sha256 = "sha256-LViiHGDJjtQwz5O6ZZrAApi2F1rISZvcggCl8Y3nzTA=";
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
        find.addExtraSpaceOnTop = false;
        fontFamily = "'monospace', monospace";
        fontLigatures = true;
        fontSize = 16;
        lineHeight = 18;
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
        cursorBlinking = "expand";
        cursorSmoothCaretAnimation = "on";

        bracketPairColorization = {
          enabled = false;
          independentColorPoolPerBracketType = false;
        };

        codeActionsOnSave.source = {
          organizeImports = true;
          fixAll.eslint = true;
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
        cursorStyle = "line";
        cursorWidth = 2;
        fontFamily = "'monospace'";
        fontSize = 14;
      };

      Lua.misc.executablePath = "${pkgs.sumneko-lua-language-server}/bin/lua-language-server";

      window = {
        menuBarVisibility = "toggle";
        nativeTabs = true;
        titleBarStyle = "native";
        zoomLevel = 0;
      };

      workbench = {
        colorTheme = "Decayce Theme";
        iconTheme = "material-icon-theme";
        productIconTheme = "material-product-icons";
      };

      oneDarkPro = {
        vivid = true;
        italic = true;
      };

      vim = {
        useSystemClipboard = true;
        insertModeKeyBindingsNonRecursive = [
          {
            before = ["j" "k"];
            after = ["<esc>"];
          }
          {
            before = ["k" "j"];
            after = ["<esc>"];
          }
          {
            before = ["j" "j"];
            after = ["<esc>"];
          }
          {
            before = ["k" "k"];
            after = ["<esc>"];
          }
        ];
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
