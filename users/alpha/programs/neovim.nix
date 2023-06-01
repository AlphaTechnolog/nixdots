{pkgs, ...}: {
  # installing dev tools
  home.packages = with pkgs; [
    neovim
    unzip
    sumneko-lua-language-server
    clang
    clang-tools
  ];

  # installing nvim config if needed
  home.activation.installNvchad = ''
    if ! test -d ~/.config/nvim; then
      mkdir -p ~/.config/nvim
      git clone https://github.com/alphatechnolog/nvim ~/.config/nvim
      chown -R $(whoami):wheel ~/.config/nvim
      chown -R $(whoami):wheel ~/.config/nvim/*
      chmod -R 777 ~/.config/nvim ~/.config/nvim/*
    fi
  '';
}
