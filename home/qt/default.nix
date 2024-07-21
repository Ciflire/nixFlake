{ lib, pkgs, ... }:
{
  qt = {
    enable = true;
    platformTheme.name = lib.mkForce "qtct";
  };

  home.packages = with pkgs; [ catppuccin-qt5ct ];
}
