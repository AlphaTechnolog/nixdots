{ pkgs, ... }: {
  home.packages = [pkgs.ripgrep];
  programs.nixvim = {
    enable = true;
    extraPlugins = let
      mountain = pkgs.callPackage ../../../derivs/mountain.vim.nix {};
      decay = pkgs.callPackage ../../../derivs/decay.nvim.nix {};
    in [mountain decay];
    extraConfigLua = ''
      vim.cmd [[ autocmd VimLeave * set guicursor=n:hor10 ]]
      require("decay").setup {
        options = {
          scheme = "rustic",
        }
      }
    '';
    options = {
      termguicolors = true;
      number = true;
      wrap = false;
      guicursor = "i:hor10";
      showmode = false;
      cmdheight = 0;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      mouse = "a";
      clipboard = "unnamedplus";
      laststatus = 0;
    };
    keymaps = [
      {
        action = "<cmd>NvimTreeToggle<cr>";
        key = "<C-n>";
        options = {
          silent = true;
          noremap = true;
        };
      }
    ] ++ (let
      shortcuts = ["jk" "kj" "jj" "kk"];
      mapped-shortcuts = map (key: {
        action = "<esc>";
        mode = "i";
        inherit key;
        options = {
          silent = true;
          noremap = true;
        };
      }) shortcuts;
    in mapped-shortcuts) ++ (let
      navkeys = ["h" "j" "k" "l"];
      mapped-shortcuts = map (key: {
        action = "<C-w>${key}";
        key = "<C-${key}>";
        options = {
          silent = true;
          noremap = true;
        };
      }) navkeys;
    in mapped-shortcuts);
    plugins = {
      nvim-autopairs.enable = true;
      nvim-tree = {
        enable = true;
        disableNetrw = true;
      };
      telescope = {
        enable = true;
        keymaps = {
          "<space>ff" = "find_files";
          "<space>fg" = "live_grep";
        };
      };
      treesitter = {
        enable = true;
        indent = true;
        ensureInstalled = [
          "c" "cpp" "lua" "nix"
          "javascript" "typescript"
          "tsx" "bash" "python"
          "rust" "html" "css"
        ];
      };
    };
  };
}
