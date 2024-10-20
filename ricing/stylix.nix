{
  pkgs,
  config,
  lib,
  ...
}:
{
  stylix = {
    enable = true;
    base16Scheme = ./base16schemes/macchiato.yaml;
    image = ../home/hyprland/wallpapers/landscapes/forrest.png;
    autoEnable = true;
    polarity = "dark";
    cursor = {
      name = "BreezeX-RosePine-Linux";
      package = pkgs.rose-pine-cursor;
      size = 28;
    };
  };
}
