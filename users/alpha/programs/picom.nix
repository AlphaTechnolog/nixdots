{...}: {
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = false;

    shadow = true;
    shadowOffsets = [(-10) (-10)];
    shadowOpacity = 0.35;
    shadowExclude = [
      "name = 'Notification'"
      "class_g = 'Conky'"
      "class_g ?= 'Notify-osd'"
      "class_g = 'Cairo-clock'"
      "_GTK_FRAME_EXTENTS@:c"
    ];

    fade = true;
    fadeDelta = 4;
    fadeSteps = [0.025 0.025];
    fadeExclude = [];

    activeOpacity = 1.0;
    inactiveOpacity = 1.0;
    menuOpacity = 1.0;
    opacityRules = ["70:class_g = 'splash'"];

    wintypes = {
      tooltip = {
        fade = true;
        shadow = true;
        focus = true;
        full-shadow = true;
      };
      dock = {shadow = false;};
      dnd = {shadow = false;};
      popup_menu = {opacity = 1;};
      dropdown_menu = {opacity = 1;};
      desktop = {full-shadow = false;};
      normal = {full-shadow = false;};
    };

    settings = {
      shadow-radius = 10;
      shadow-color = "#000000";
      shadow-ignore-shaped = false;

      frame-opacity = 1.0;
      inactive-opacity-override = false;
      focus-exclude = [
        "class_g = 'Peek'"
        "class_g = 'Cairo-clock'"
      ];

      corner-radius = 12;
      rounded-corners-exclude = [
        "window_type = 'dock'"
        "_NET_WM_STATE@:32a *= '_NET_WM_STATE_MAXIMIZED_VERT'"
        "_NET_WM_STATE@:32a *= '_NET_WM_STATE_MAXIMIZED_HORZ'"
      ];

      blur-method = "dual_kawase";
      blur-kernel = "11x11gaussian";
      blur-deviation = 3.0;
      blur-strength = 8;
      blur-background = false;
      blur-background-frame = true;
      blur-background-fixed = true;
      blur-background-exclude = [
        "class_g = 'slop'"
        "class_g = 'firefox'"
        "class_g = 'eww-bubbly'"
        "class_g = 'eww-keystrokes'"
        "_GTK_FRAME_EXTENTS@:c"
        "window_type = 'desktop'"
        "window_type = 'menu'"
      ];

      mark-wmwin-focused = true;
      mark-ovredir-focused = true;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      detect-transient = true;
      detect-client-leader = true;
      glx-no-stencil = true;
      use-damage = true;
      transparent-clipping = false;
      log-level = "warn";
    };
  };
}