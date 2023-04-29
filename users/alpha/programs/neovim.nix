{pkgs, ...}: {
  # unzip needed for some tools.
  home.packages = [pkgs.neovim pkgs.unzip];
  home.activation.installNvchad = ''
    if ! test -d ~/.config/nvim; then
      mkdir -p ~/.config/nvim
      cp -r ${pkgs.nvchad-source}/* ~/.config/nvim
      chown -R $(whoami):wheel ~/.config/nvim
      chown -R $(whoami):wheel ~/.config/nvim/*
      chmod -R 777 ~/.config/nvim ~/.config/nvim/*
    fi
  '';
}