{pkgs}: {
  imports = [
    ./foot.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    kooha # screen recording, some tooling.
    (pkgs.callPackage ../../../../pkgs/swww {})
  ];

  xdg.configFile."hypr/wallpaper.png".source = ../wallpaper.png;

  wayland.windowManager.hyprland = let
    colors = import ../../theme/raw-colors.nix {};
  in
    with colors; {
      enable = true;
      extraConfig = let
        xkblayouttoggler = pkgs.writeScriptBin "xkblayouttoggler" ''
          #!${pkgs.bash}/bin/bash

          # This script supposes that you use something like this in your hyprland
          # config
          # input {
          #   kb_layout us,es
          # }

          CACHE_FILE=~/.cache/xkblayouttoggler
          DEVICE="at-translated-set-2-keyboard"

          if ! test -f "$CACHE_FILE"; then
            echo "us" > "$CACHE_FILE"
          fi

          CURRENT_LAYOUT=$(cat "$CACHE_FILE")

          if [[ "$1" == "restore" ]]; then
            if [ "$CURRENT_LAYOUT" = "us" ]; then
              hyprctl switchxkblayout $DEVICE 0 # english
            else
              hyprctl switchxkblayout $DEVICE 1 # spanish
            fi
            exit 0
          fi

          if [ "$CURRENT_LAYOUT" = "us" ]; then
            hyprctl switchxkblayout $DEVICE 1 # spanish
            echo "es" > "$CACHE_FILE"
          else
            hyprctl switchxkblayout $DEVICE 0 # english
            echo "us" > "$CACHE_FILE"
          fi
        '';
      in ''
        monitor = eDP-1,1920x1080@144,0x0,1

        exec-once = ${xkblayouttoggler}/bin/xkblayouttoggler restore
        exec-once = sh -c "swww init ; swww img ~/.config/hypr/wallpaper.png"

        general {
          gaps_in = 5
          gaps_out = 7
          border_size = 1
          col.active_border = rgb(${bg-lighter})
          col.inactive_border = rgb(${bg-contrast})
          layout = dwindle
        }

        decoration {
          rounding = 8
          blur = true
          blur_size = 12
          blur_passes = 2
          blur_new_optimizations = true
          drop_shadow = true
          shadow_range = 14
          shadow_render_power = 8
          col.shadow = rgb(${bg-darker})
        }

        animations {
          enabled = true
        }

        gestures {
          workspace_swipe = true
        }

        input {
          kb_layout = us,es
          kb_options = grp:alt_shift_toggle
          touchpad {
            natural_scroll = true
          }
        }

        $mainMod = SUPER

        bind = $mainMod, Return, exec, foot
        bind = $mainMod, W, killactive,
        bind = $mainMod SHIFT, Q, exit,
        bind = $mainMod, F, togglefloating,
        bind = $mainMod SHIFT, Return, exec, rofi -show drun
        bind = $mainMod, J, togglesplit,

        bind = $mainMod, SPACE, exec, ${xkblayouttoggler}/bin/xkblayouttoggler

        bind = $mainMod, h, movefocus, l
        bind = $mainMod, l, movefocus, r
        bind = $mainMod, k, movefocus, u
        bind = $mainMod, j, movefocus, d

        bind = $mainMod, 1, workspace, 1
        bind = $mainMod, 2, workspace, 2
        bind = $mainMod, 3, workspace, 3
        bind = $mainMod, 4, workspace, 4
        bind = $mainMod, 5, workspace, 5
        bind = $mainMod, 6, workspace, 6

        bind = $mainMod SHIFT, 1, movetoworkspace, 1
        bind = $mainMod SHIFT, 2, movetoworkspace, 2
        bind = $mainMod SHIFT, 3, movetoworkspace, 3
        bind = $mainMod SHIFT, 4, movetoworkspace, 4
        bind = $mainMod SHIFT, 5, movetoworkspace, 5
        bind = $mainMod SHIFT, 6, movetoworkspace, 6

        # Scroll through existing workspaces with mainMod + scroll
        bind = $mainMod, mouse_down, workspace, e+1
        bind = $mainMod, mouse_up, workspace, e-1

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod, mouse:273, resizewindow
      '';
    };
}
