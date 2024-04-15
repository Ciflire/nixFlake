{
  pkgs,
  lib,
  inputs,
  ...
}:
{

  home.packages = with pkgs; [
    wlogout
    rofi-wayland
    rofi-bluetooth
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

    # idle tool
    inputs.hypridle.packages.${pkgs.system}.hypridle
    inputs.hyprlock.packages.${pkgs.system}.hyprlock

    # screenshots
    grimblast
    swappy
  ];
}
