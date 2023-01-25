{
  # copy lite-xl files with read and write permissions
  home.activation.installLiteXLConfig = ''
    if ! test -d "$HOME/.config/lite-xl"; then
      ln -s /etc/nixos/users/alpha/programs/lite-xl/config $HOME/.config/lite-xl
      chmod -R +w $HOME/.config/lite-xl
    fi
  '';
}
