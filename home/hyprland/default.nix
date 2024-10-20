{
  pkgs,
  inputs,
  lib,
  ...
}:
let
  hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
in
# hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland.overrideAttrs (old: {
#   patches = [ ./patches/patch.txt ];
# });
{
  xdg.portal = {
    enable = true;
    configPackages = [ hyprland ];
    extraPortals = with pkgs; [
      inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };
  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprland;
    xwayland.enable = true;
    settings = {
      animation = [
        "windowsIn, 1,2,windowIn, slide bottom"
        "windowsOut,1,2,windowOut, slide bottom"
        "windowsMove,1,2,windowMove, slide"
        "workspaces, 1, 3, workspace, slide"
      ];
      bezier = [
        "windowIn, 0.27,0.1,0,1"
        "windowOut, 1,0,0.73,0.9"
        "windowMove, 0.3,0,0.7,1"
        "workspace, 0.53,0.02,0.69,1"
      ];
      blurls = [ "top-bar" ];
      # general = {
      #   border_size = 2;
      #   gaps_in = 3;
      #   gaps_out = 7;

      # };
      decoration = {
        rounding = 10;
        active_opacity = 0.9;
        inactive_opacity = 0.8;
        fullscreen_opacity = 1;
        blur = {
          enabled = true;
          size = 8;
          passes = 2;
          new_optimizations = true;
          ignore_opacity = true;
        };
      };
      general = {
        border_size = 0;
        gaps_in = 4;
        gaps_out = 7;
      };
      "$mod" = "SUPER";
      "$menu" = "walker";
      "exec-once" = [
        "hyprpanel &"
        "/nix/store/$(ls -la /nix/store | grep 'mate-polkit' | grep '4096' | awk '{print $9}' | sed -n '$p')/libexec/polkit-mate-authentication-agent-1 & "
        "wl-paste --type text --watch cliphist store #Stores only text data&"
        "wl-paste --type image --watch cliphist store #Stores only image data &"
        "rog-control-center &"
      ];
      source = [
        "./monitors.conf"
        "./workspaces.conf"
        "./hyprland_test.conf"
      ];
      env = [
        "HYPRCURSOR_THEME, rose-pine-cursor"
        "HYPRCURSOR_SIZE, 28"
      ];
      debug.disable_logs = false;
      bind = [
        "$mod, Return, exec,kitty"
        "$mod, D,exec, $menu"
        "$mod, F, fullscreen,"
        "$mod, Q, killactive, "
        "$mod, E, exec, thunar"
        "$mod, W, exec, $menu"
        "$mod, B, exec, librewolf"
        "$mod SHIFT, V, togglefloating, "
        "SUPER, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        # "$mod, P, cycleprev"
        # "$mod, J, cyclenext"
        "$mod SHIFT, L, exec, loginctl lock-session"
        "$mod, S, exec, spotify"
        "$mod, T, exec, thunderbird"
        "$mod, escape, exec, wlogout"

        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, J, movefocus, u"
        "$mod, K, movefocus, d"

        "$mod, ampersand, workspace, 1"
        "$mod, eacute, workspace, 2"
        "$mod, quotedbl, workspace, 3"
        "$mod, apostrophe, workspace, 4"
        "$mod, parenleft, workspace, 5"
        "$mod, minus, workspace, 6"
        "$mod, egrave, workspace, 7"
        "$mod, underscore, workspace, 8"
        "$mod, ccedilla, workspace, 9"
        "$mod, agrave, workspace, 10"

        "$mod SHIFT, ampersand, movetoworkspace, 1"
        "$mod SHIFT, eacute, movetoworkspace, 2"
        "$mod SHIFT, quotedbl, movetoworkspace, 3"
        "$mod SHIFT, apostrophe, movetoworkspace, 4"
        "$mod SHIFT, parenleft, movetoworkspace, 5"
        "$mod SHIFT, minus, movetoworkspace, 6"
        "$mod SHIFT, egrave, movetoworkspace, 7"
        "$mod SHIFT, underscore, movetoworkspace, 8"
        "$mod SHIFT, ccedilla, movetoworkspace, 9"
        "$mod SHIFT, agrave, movetoworkspace, 10"

        ''$mod , print, exec, grimblast --freeze save area - | satty -f -''
        ''$mod SHIFT, print, exec, grimblast --freeze save active screen - | satty -f -''
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];
      binde = [
        " , XF86MonBrightnessUp, exec, brightnessctl set +5%"
        " , XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];
      bindle = [
        " , XF86KbdBrightnessUp, exec, brightnessctl -d asus::kbd_backlight set +1"
        " , XF86KbdBrightnessDown, exec, brightnessctl -d asus::kbd_backlight set 1-"

        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl prev"
      ];
      cursor = {
        no_hardware_cursors = true;
      };

      input = {
        kb_layout = "fr";
      };

      windowrulev2 = [
        "float, class:^(xdg-desktop-portal)"
        "idleinhibit, class:(steam_app)"
        "float, class:^(satty)$"
        "float, title:^.*Bitwarden.*$"
        "opacity 0.9 override 0.8 override 0.95 override,class:^(kitty)$"
      ];
      layerrule = [ "blur, top-bar" ];
    };
  };

  services.hyprpaper = {
    enable = true;
    package = inputs.hyprpaper.packages.${pkgs.system}.hyprpaper;
    settings = {
      ipc = "on";
      splash = true;
      splash_offset = 2.0;
      preload = [ "/home/ciflire/nixFlake/home/hyprland/wallpapers/landscapes/forrest.png" ];
      # preload = [ "/home/ciflire/nixFlake/home/hyprland/wallpapers/2825710.gif" ];

      wallpaper = [ ",/home/ciflire/nixFlake/home/hyprland/wallpapers/landscapes/forrest.png" ];

    };
  };
  services.hypridle = {
    enable = true;
    package = inputs.hypridle.packages.${pkgs.system}.hypridle;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || ${inputs.hyprlock.packages.${pkgs.system}.hyprlock}/bin/hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "${hyprland}/bin/hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 150;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 120;
          on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -sd asus::kbd_backlight set 0";
          on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -rd asus::kbd_backlight";
        }
        {
          timeout = 120;
          on-timeout = "${hyprland}/bin/hyprctl dispatch dpms off";
          on-resume = "${hyprland}/bin/hyprctl dispatch dpms on";
        }
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
  services.arrpc.enable = true;
  programs.hyprlock = {
    enable = true;
    package = inputs.hyprlock.packages.${pkgs.system}.hyprlock;
    settings = {
      general = {
        disable_loading_bar = false;
        grace = 0;
        hide_cursor = true;
      };
      background = {
        path = "/home/ciflire/nixFlake/home/hyprland/wallpapers/landscapes/forrest.png";
        blur_passes = 3;
        blur_size = 8;
      };
      input-field = {
        size = "200, 50";
        position = "0, -80";
        monitor = "";
        dots_center = true;
        fade_on_empty = false;
        font_color = "rgb(202, 211, 245)";
        inner_color = "rgb(91, 96, 120)";
        outer_color = "rgb(24, 25, 38)";
        outline_thickness = 5;
        placeholder_text = "\'Password...\' ";
        shadow_passes = 2;
      };
    };
  };

  programs.rofi = {
    enable = true;
    font = lib.mkForce "MonoLisa 10";
    location = "center";
    package = pkgs.rofi-wayland;
    terminal = "kitty";
  };

  home.packages = with pkgs; [
    brightnessctl
    killall
    inotify-tools
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    hyprpicker
    cliphist
    nwg-displays
    wlr-randr
    libnotify
    blueman
    networkmanagerapplet
    nm-tray
    xfce.thunar # file manager

    mate.mate-polkit

    inputs.hyprpaper.packages.${pkgs.system}.hyprpaper
    inputs.hypridle.packages.${pkgs.system}.hypridle
    inputs.hyprsunset.packages.${pkgs.system}.default
    inputs.hyprsysteminfo.packages.${pkgs.system}.default

    # screenshots
    grimblast
    satty

    opentabletdriver
    xournalpp

    osu-lazer-bin

    qt5ct

    playerctl

    inputs.hyprpanel.packages.${pkgs.system}.default
    pywal
  ];
}
