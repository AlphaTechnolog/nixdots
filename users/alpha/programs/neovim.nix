{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    colorscheme = "mountain";
    extraPlugins = let
      mountain = pkgs.callPackage ../../../derivs/mountain.vim.nix {};
    in [mountain]; 
    options = {
      termguicolors = true;
      number = true;
      showmode = false;
      cmdheight = 0;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      mouse = "a";
      clipboard = "unnamedplus";
      laststatus = 0;
    };
    plugins = {
      treesitter = {
        enable = true;
        indent = true;
        ensureInstalled = [
          "c" "cpp" "lua"
          "javascript" "typescript"
          "tsx" "bash" "python"
          "rust" "html" "css"
        ];
      };
    };
  };
}
