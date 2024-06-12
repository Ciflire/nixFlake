{
  pkgs,
  inputs,
  ...
}:
{
  xdg.portal = {
    enable = true;
    configPackages = [ inputs.hyprland.packages.${pkgs.system}.hyprland ];
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
    settings = {
      "$mod" = "SUPER";
      "$menu" = "wofi";
      "exec-once" = [
        "ags &"
        "/nix/store/$(ls -la /nix/store | grep 'mate-polkit' | grep '4096' | awk '{print $9}' | sed -n '$p')/libexec/polkit-mate-authentication-agent-1 & "
      ];
      source = [
        "./monitors.conf"
        "./workspaces.conf"
      ];
      env = [
        "HYPRCURSOR_THEME, rose-pine-cursor"
        "HYPRCURSOR_SIZE, 28"
      ];
      bind = [
        "$mod, Return, exec,kitty"
        "$mod, D,exec, $menu --show drun"
        "$mod, F, fullscreen,"
        "$mod, Q, killactive, "
        "$mod, N, exec, thunar"
        "$mod, W, exec, librewolf"
        "$mod, V, togglefloating, "
        "$mod, P, pseudo, # dwindle"
        "$mod, J, togglesplit, # dwindle"
        "$mod SHIFT, L, exec, loginctl lock-session"
        "$mod, S, exec, spotify"
        "$mod, T, exec, thunderbird"
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

        ''$mod , print, exec, grimblast save area - | swappy -f -''
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
    };
  };

  services.hyprpaper = {
    enable = true;
    package = inputs.hyprpaper.packages.${pkgs.system}.hyprpaper;
    settings = {
      ipc = "on";
      splash = true;
      splash_offset = 2.0;
      preload = [ "/home/ciflire/nixFlake/home/hyprland/catppuccin_triangle.png
.jpg" ];

      wallpaper = [ ",/home/ciflire/nixFlake/home/hyprland/catppuccin_triangle.png
.jpg" ];
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
        path = "screenshot";
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

  home.packages = with pkgs; [
    wlogout
    wofi
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
    notify-desktop
    blueman
    networkmanagerapplet
    nm-tray
    xfce.thunar # file manager

    mate.mate-polkit

    inputs.hyprpaper.packages.${pkgs.system}.hyprpaper
    inputs.hypridle.packages.${pkgs.system}.hypridle

    # screenshots
    grimblast
    swappy

    nvidia-vaapi-driver
  ];
}
