{ pkgs, lib, inputs, ... }: {

  home.packages = with pkgs; [
    swaylock
    wlogout
    rofi
    rofi-bluetooth
    inputs.hyprland-plugins.packages.${pkgs.system}.grimblast
    swaynotificationcenter
    waybar
    jq
  ];

  programs.swaylock = { enable = true; };

  programs.hyprlock.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;

    plugins = [ ];

    settings = {
      "$mod" = "SUPER";
      "$menu" = "rofi";

      exec-once = "waybar; ";

      blurls = "waybar";

      input = { kb_layout = "fr"; };
      bind = [
        "$mod, return, exec, kitty"
        "$mod, D, exec, $menu -show drun"
        "$mod, W, exec, $menu -show window"
        "$mod, Q, killactive"
        "$mod, F, fullscreen"
        "$mod, V, togglefloating"
        "$mod, S, exec, spotify"
        "$mod, T, exec, thunderbird"
        "$mod, L, exec, hyprlock"
        "$mod, escape, exec, wlogout"
        "$mod, H, exec, $menu -show keys"

        # Switch workspaces with mainMod + [0-9]
        "$mod, ampersand, workspace, 1"
        "$mod, eacute, workspace, 2"
        "$mod, quotedbl, workspace, 3"
        "$mod, apostrophe, workspace, 4"
        "$mod, parenleft, workspace, 5"
        "$mod, minus, workspace, 6"
        "$mod, egrave, workspace, 7"
        "$mod, underscore, workspace, 8"
        "$mod, ccedilla, workspace, 9"
        "$mod, agrave, workspace, 0"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mod SHIFT, ampersand, movetoworkspace, 1"
        "$mod SHIFT, eacute, movetoworkspace, 2"
        "$mod SHIFT, quotedbl, movetoworkspace, 3"
        "$mod SHIFT, apostrophe, movetoworkspace, 4"
        "$mod SHIFT, parenleft, movetoworkspace, 5"
        "$mod SHIFT, minus, movetoworkspace, 6"
        "$mod SHIFT, egrave, movetoworkspace, 7"
        "$mod SHIFT, underscore, movetoworkspace, 8"
        "$mod SHIFT, ccedilla, movetoworkspace, 9"
        "$mod SHIFT, agrave, movetoworkspace, 0"

        # Screenshots
        "$mod, print, exec, grimblast copy active"
        "$mod SHIFT, print, exec, grimblast copy area"
        "$mod ALT, print, exec, grimblast copy output"
        "$mod CTRL, print, exec, grimblast copy screen"

        # Backlight
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        " , XF86KbdBrightnessUp, exec, brightnessctl -d asus::kbd_backlight set +1"
        " , XF86KbdBrightnessDown, exec, brightnessctl -d asus::kbd_backlight set 1-"

        # Audio control
        " , XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        " , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        " , XF86AudioMute, exec, wpctl set mute @DEFAULT_SINK@ toggle"
      ];
      bindm = [
        # move/resize windows
        " $mod, mouse:272, movewindow"
        " $mod, mouse:273, resizewindow"
      ];
    };

  };
  home.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    # GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = 1;
  };
}
