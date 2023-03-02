{
  home.activation.installAwesomeWMConfig = ''
    if [ ! -d "$HOME/.config/awesome" ]; then
      ln -s "/etc/nixos/users/$USER/cfg/awesome" "$HOME/.config/awesome"
      chmod -R +w "$HOME/.config/awesome"
    fi
  '';
}
