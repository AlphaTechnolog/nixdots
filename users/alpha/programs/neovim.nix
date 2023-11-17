{ pkgs, ... }: {
  home.packages = with pkgs; [
    neovim
    unzip
    sumneko-lua-language-server
    clang
    clang-tools
  ];

  home.activation.installNvChad = let
    git = "${pkgs.git}/bin/git";
    config-source = "https://github.com/nvchad/nvchad.git";
    dest = "~/.config/nvim";
  in ''
    if ! test -d ${dest}; then
      mkdir -pv ${dest}
      ${git} clone ${config-source} ${dest} --depth=1
      chown -R $(whoami):wheel ${dest}
    fi
  '';
}
