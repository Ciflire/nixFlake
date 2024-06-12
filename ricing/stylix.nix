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
    image = /home/ciflire/nixFlake/home/hyprland/catppuccin_triangle.png;
    autoEnable = true;
    polarity = "dark";
    cursor = {
      name = "BreezeX-RosePine-Linux";
      package = pkgs.rose-pine-cursor;
      size = 28;
    };
  };
}
