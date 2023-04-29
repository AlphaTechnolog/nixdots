{
  home.activation.removeTitlebarsXfce = ''
    if ! test -d ~/.themes/vacui; then
      mkdir -p ~/.themes/vacui/xfwm4
      touch ~/.themes/vacui/xfwm4/themerc
    fi
  '';
}
