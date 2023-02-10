{
  config,
  pkgs,
  ...
}: {
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
        pkief.material-product-icons
        pkief.material-icon-theme
        streetsidesoftware.code-spell-checker
        sumneko.lua
        usernamehw.errorlens
        vadimcn.vscode-lldb
        oderwat.indent-rainbow
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
        cursorWidth = 2;
        find.addExtraSpaceOnTop = false;
        fontFamily = "'monospace', monospace";
        fontSize = 16;
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
        smoothScrolling = true;
        suggest.showStatusBar = true;
        suggestSelection = "first";

        bracketPairColorization = {
          enabled = false;
          independentColorPoolPerBracketType = true;
        };

        codeActionsOnSave.source = {
          organizeImports = true;
          fixAll.eslint = true;
        };

        guides = {
          bracketPairs = true;
          indentation = true;
        };
      };

      explorer = {
        confirmDragAndDrop = false;
        confirmDelete = true;
      };

      files = {
        autoSave = "afterDelay";
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
        fontSize = 16;
        smoothScrolling = true;
      };

      window = {
        menuBarVisibility = "toggle";
        nativeTabs = true;
        titleBarStyle = "native";
        zoomLevel = 0;
      };

      workbench = {
        colorTheme = "Tokyo Night";
        iconTheme = "material-icon-theme";
        list.smoothScrolling = true;
        panel.defaultLocation = "right";
        productIconTheme = "material-product-icons";
        smoothScrolling = true;
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
