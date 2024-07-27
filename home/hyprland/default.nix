{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  xdg.portal = {
    enable = true;
    configPackages = [ inputs.hyprland.packages.${pkgs.system}.hyprland ];
    extraPortals = with pkgs; [
      inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
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
        "ags &"
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
        "$mod, D,exec, $menu --modules applications"
        "$mod, F, fullscreen,"
        "$mod, Q, killactive, "
        "$mod, N, exec, thunar"
        "$mod, W, exec, $menu --modules hyprland"
        "$mod, B, exec, nvidia-offload librewolf"
        "$mod SHIFT, V, togglefloating, "
        "SUPER, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "$mod, P, pseudo, # dwindle"
        "$mod, J, togglesplit, # dwindle"
        "$mod SHIFT, L, exec, loginctl lock-session"
        "$mod, S, exec, spotify"
        "$mod, T, exec, nvidia-offload thunderbird"
        "$mod, escape, exec, wlogout"

        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, J, movefocus, u"
        "$mod, K, movefocus, d"

        "$mod, Ampersand, workspace, 1"
        "$mod, Eacute, workspace, 2"
        "$mod, Quotedbl, workspace, 3"
        "$mod, Apostrophe, workspace, 4"
        "$mod, Parenleft, workspace, 5"
        "$mod, Minus, workspace, 6"
        "$mod, Egrave, workspace, 7"
        "$mod, Underscore, workspace, 8"
        "$mod, Ccedilla, workspace, 9"
        "$mod, Agrave, workspace, 10"

        "$mod SHIFT, Ampersand, movetoworkspace, 1"
        "$mod SHIFT, Eacute, movetoworkspace, 2"
        "$mod SHIFT, Quotedbl, movetoworkspace, 3"
        "$mod SHIFT, Apostrophe, movetoworkspace, 4"
        "$mod SHIFT, Parenleft, movetoworkspace, 5"
        "$mod SHIFT, Minus, movetoworkspace, 6"
        "$mod SHIFT, Egrave, movetoworkspace, 7"
        "$mod SHIFT, Underscore, movetoworkspace, 8"
        "$mod SHIFT, Ccedilla, movetoworkspace, 9"
        "$mod SHIFT, Agrave, movetoworkspace, 10"

        ''$mod , print, exec, grimblast save area - | satty -f -''
        ''$mod SHIFT, print, exec, grimblast save active screen - | satty -f -''
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
      ];

      input = {
        kb_layout = "fr";
      };

      windowrulev2 = [
        "float, class:^(xdg-desktop-portal)"
        "idleinhibit, class:(steam_app)"
        "float, class:^(satty)$"
        "float, title:^(Extension: (Bitwarden - Free Password Manager) - Bitwarden — Mozilla Firefox)$"
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
        after_sleep_cmd = "${
          inputs.hyprland.packages.${pkgs.system}.hyprland
        }/bin/hyprctl dispatch dpms on";
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
          on-timeout = "${inputs.hyprland.packages.${pkgs.system}.hyprland}/bin/hyprctl dispatch dpms off";
          on-resume = "${inputs.hyprland.packages.${pkgs.system}.hyprland}/bin/hyprctl dispatch dpms on";
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
      cursor = {
        no_hardware_cursors = true;
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
    inputs.ags.packages.${pkgs.system}.ags
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

    # screenshots
    grimblast
    satty

    nvidia-vaapi-driver

    opentabletdriver
    xournalpp

    osu-lazer-bin

    qt5ct

  ];
}
