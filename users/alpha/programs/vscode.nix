{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      rust-lang.rust-analyzer
      bbenoist.nix
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "python";
        publisher = "ms-python";
        version = "2023.6.1";
        sha256 = "sha256-aLsk9sm+bBjiB2fRLPgw85U2MakBh5QSve6OVLxJyjY=";
      }
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
      "[python]".editor.tabSize = 4;
      "[php]".editor.tabSize = 4;
      "[java]".editor.tabSize = 4;
      "[rust]".editor.tabSize = 4;
      "[c]".editor.tabSize = 4;
      "[cpp]".editor.tabSize = 4;
      "symbols.hidesExplorerArrows" = false;
      terminal.integrated.fontSize = 12;
      html.autoCreateQuotes = false;
      editor = {
        fontFamily = "monospace";
        fontWeight = "bold";
        fontSize = 13;
        fontLigatures = true;
        tabSize = 2;
        bracketPairColorization.enabled = false;
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
