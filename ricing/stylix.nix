{
  pkgs,
  config,
  lib,
  ...
}:
{
  stylix = {
    enable = true;
    image = /home/ciflire/nixFlake/home/hyprland/arog.jpg;
    autoEnable = true;
    polarity = "dark";
    cursor = {
      name = "BreezeX-RosePine-Linux";
      package = pkgs.rose-pine-cursor;
      size = 28;
    };
  };
}
