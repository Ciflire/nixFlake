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
    image = /home/ciflire/nixFlake/home/hyprland/wallpapers/landscapes/forest.png;
    autoEnable = true;
    polarity = "dark";
    cursor = {
      name = "BreezeX-RosePine-Linux";
      package = pkgs.rose-pine-cursor;
      size = 28;
    };
  };
}
