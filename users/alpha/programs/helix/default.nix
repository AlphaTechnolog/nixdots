{
  config,
  pkgs,
  ...
}:

let
  theme = import ./theme.nix;
in {
  programs.helix = {
    enable = true;
    settings = {
      theme = "custom";
      keys.normal = {
        "{" = "goto_prev_paragraph";
        "}" = "goto_next_paragraph";
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
        "C-d" = ["half_page_down" "align_view_center"];
        "C-u" = ["half_page_up" "align_view_center"];
        "C-q" = ":bc";
        space.u = {
          f = ":format"; # format using LSP formatter
          w = ":set whitespace.render all";
          W = ":set whitespace.render none";
        };
      };
      keys.select = {
        "%" = "match_brackets";
      };
      editor = {
        color-modes = true;
        cursorline = true;
        idle-timeout = 1;
        line-number = "relative";
        scrolloff = 5;
        bufferline = "never";
        true-color = true;
        lsp.display-messages = true;
        indent-guides = {
          render = true;
        };
        gutters = ["diagnostics" "line-numbers" "spacer" "diff"];
        statusline = {
          separator = "|";
          left = ["mode" "selections" "spinner" "file-name" "total-line-numbers"];
          center = [];
          right = ["diagnostics" "file-encoding" "file-line-ending" "file-type" "position-percentage" "position"];
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };

        whitespace.characters = {
          space = "·";
          nbsp = "⍽";
          tab = "→";
          newline = "⤶";
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "block";
        };
      };
    };

    # loading custom theme
    themes.custom = theme;

    languages = with pkgs; [
      {
        name = "css";
        auto-format = true;
      }
      {
        name = "go";
        auto-format = true;
        language-server = {
          command = "${gopls}/bin/gopls";
        };
        formatter = {
          command = "${go}/bin/gofmt";
        };
      }
      {
        name = "javascript";
        auto-format = true;
        language-server = {
          command = "${nodePackages.typescript-language-server}/bin/typescript-language-server";
          args = ["--stdio"];
        };
      }
      {
        name = "lua";
        auto-format = false;
        indent = {
          tab-width = 4;
          unit = "    ";
        };
      }
      {
        name = "rust";
        auto-format = true;
        language-server = {
          command = "${rust-analyzer}/bin/rust-analyzer";
        };
        formatter = {
          command = "${rustfmt}/bin/rustfmt";
        };
      }
      {
        name = "typescript";
        auto-format = true;
        language-server = {
          command = "${nodePackages.typescript-language-server}/bin/typescript-language-server";
          args = ["--stdio"];
        };
        formatter = {
          command = "${nodePackages.prettier}/bin/prettier";
        };
      }
    ];
  };

  home.packages = with pkgs; [
    # Dev tools
    alejandra
    asmfmt
    black
    ccls
    cargo
    delve
    elixir_ls
    gawk
    go
    gocode-gomod
    gomodifytags
    gopkgs
    gopls
    gotests
    go-outline
    go-tools
    java-language-server
    kotlin-language-server
    ktlint
    lldb
    nodejs
    rust-analyzer
    rustfmt
    rnix-lsp
    selene
    shellcheck
    shfmt
    solc
    sumneko-lua-language-server
    texlab
    uncrustify
    zls
    nodePackages.jsonlint
    nodePackages.jsonlint
    nodePackages.node2nix
    nodePackages.prettier
    nodePackages.pyright
    nodePackages.stylelint
    nodePackages.typescript-language-server
    nodePackages.vls
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
    nodePackages.yarn
  ];
}
