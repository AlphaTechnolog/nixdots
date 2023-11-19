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
      lsp = {
        enable = true;
        servers = {
          tsserver.enable = true;
          clangd.enable = true;
          bashls.enable = true;
          cssls.enable = true;
          html.enable = true;
          jsonls.enable = true;
          lua-ls.enable = true;
          rust-analyzer.enable = true;
          pyright.enable = true;
          volar.enable = true;
          tailwindcss.enable = true;
        };
      };
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lua.enable = true;
      cmp_luasnip.enable = true;
      luasnip.enable = true;
      nvim-cmp = let
        luasnip = "local luasnip = require 'luasnip'";
        has_words_before = ''
          local function has_words_before()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
          end
        '';
      in {
        enable = true;
        preselect = "Item";
        sources = let
          srcs = map (name: {
            inherit name;
          }) ["nvim_lsp" "luasnip" "path" "buffer"];
        in srcs;
        mapping = {
          "<cr>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = {
            modes = ["i" "s"];
            action = ''
              function (fallback)
                ${luasnip}
                ${has_words_before}

                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                elseif has_words_before() then
                  cmp.complete()
                else
                  fallback()
                end
              end
            '';
          };
          "<S-Tab>" = {
            modes = ["i" "s"];
            action = ''
              function (callback)
                ${luasnip}
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end
            '';
          };
        };
      };
    };
  };
}
