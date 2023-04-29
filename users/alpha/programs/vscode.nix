{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "theme-vitesse";
        publisher = "antfu";
        version = "0.6.4";
        sha256 = "sha256-6nIzHJsLsIG3O6p97Q+YdDKxHj7r+pEwiq0UbJ/vlf4=";
      }
      {
        name = "icons-carbon";
        publisher = "antfu";
        version = "0.2.6";
        sha256 = "sha256-R8eHLuebfgHaKtHPKBaaYybotluuH9WrUBpgyuIVOxc=";
      }
      {
        name = "nix";
        publisher = "bbenoist";
        version = "1.0.1";
        sha256 = "sha256-qwxqOGublQeVP2qrLF94ndX/Be9oZOn+ZMCFX1yyoH0=";
      }
      {
        name = "symbols";
        publisher = "miguelsolorio";
        version = "0.0.9";
        sha256 = "sha256-Sk+rhBDR4/3g63Db62FIjFICGVY3sI60VxZXOKDc4zM=";
      }
      {
        name = "color-highlight";
        publisher = "naumovs";
        version = "2.5.0";
        sha256 = "sha256-dYMDV84LEGXUjt/fbsSy3BVM5SsBHcPaDDll8KjPIWY=";
      }
    ];
    userSettings = {
      terminal.integrated.fontSize = 16;
      "[python]".editor.tabSize = 4;
      "[php]".editor.tabSize = 4;
      editor = {
        fontFamily = "monospace";
        fontSize = 18;
        fontLigatures = true;
        lineHeight = 28;
        smoothScrolling = true;
        cursorSmoothCaretAnimation = "on";
        tabSize = 2;
      };
      workbench = {
        colorTheme = "Vitesse Dark";
        iconTheme = "symbols";
        productIconTheme = "icons-carbon";
      };
      window = {
        dialogStyle = "custom";
        titleBarStyle = "custom";
        menuBarVisibility = "toggle";
      };
    };
  };
}
