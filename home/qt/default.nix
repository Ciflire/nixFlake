{ pkgs, ... }:
{
  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };

  home.packages = with pkgs; [ catppuccin-qt5ct ];
}
