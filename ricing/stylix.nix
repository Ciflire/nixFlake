{
  pkgs,
  config,
  lib,
  ...
}:
{
  stylix = {
    image = ../arog.jpg;
    polarity = "dark";
    cursor = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
      size = 16;
    };
  };
}
