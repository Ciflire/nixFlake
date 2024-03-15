{ pkgs, lib, inputs, ... }: {

  home.packages = with pkgs; [
    swaylock
    wlogout
    rofi-wayland
    rofi-bluetooth
    inputs.hyprland-plugins.packages.${pkgs.system}.grimblast
    swaynotificationcenter
    waybar
    jq
    brightnessctl
    killall
    inotify-tools
    polkit_gnome
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    hyprpicker
    cliphist
    nwg-displays
    wlr-randr
    hyprlock
    notify-desktop
    blueman
    networkmanagerapplet
    nm-tray
    pavucontrol
    xfce.thunar
    hypridle
  ];

  # programs.swaylock = { enable = true; };

  # programs.hyprlock.enable = true;

  # wayland.windowManager.hyprland = {
  #   enable = true;

  #   plugins = [ ];

  # };

  # home.file.".config/hypr".source = ./hyrp;

  home.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    # GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = 1;
  };
}
