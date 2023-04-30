{scheme}: {
  home.file.".themes/openbox-theme/openbox-3/themerc".text = with scheme.colors; ''
    !! Global
    *.text.justify: center
    window.handle.width: 0
    window.client.padding.width: 0
    window.client.padding.height: 0
    border.Width: 0
    padding.width: 8

    !! Menu
    menu.title.text.justify: center
    menu.overlap.x: -20
    menu.overlap: 0
    menu.border.color: #${base01}
    menu.border.width: 2
    menu.title.text.justify: center
    menu.title.bg: flat solid
    menu.title.bg.color: #${base00}
    menu.title.text.color: #${base06}
    menu.items.bg: flat solid
    menu.items.bg.color: #${base00}
    menu.items.text.color: #${base06}
    menu.items.disabled.text.color: #${base06}
    menu.items.active.bg: flat solid
    menu.items.active.bg.color:  #${base02}
    menu.items.active.text.color: #${base06}
    menu.separator.padding.height: 10
    menu.separator.padding.width: 5

    !! Active Windows
    window.active.title.bg: flat solid
    window.active.title.bg.color: #${base00}
    window.active.label.bg: parentrelative
    window.active.label.text.color: #${base06}
    window.active.button.*.bg: parentrelative
    window.active.button.iconify.*.image.color: #${base0A}
    window.active.button.max.*.image.color: #${base0B}
    window.active.button.close.*.image.color: #${base0E}

    !! Inactive Windows
    window.inactive.title.bg: flat solid
    window.inactive.title.bg.color: #${base01}
    window.inactive.label.bg: parentrelative
    window.inactive.label.text.color: #${base06}
    window.inactive.button.*.bg: parentrelative
    window.inactive.button.*.image.color:  #${base02}
  '';
}