{ config, lib, pkgs, gruvbox, ... }: {

  gtk.enable = true;

  gtk.cursorTheme.package = pkgs.bibata-cursors;
  gtk.cursorTheme.name = "Bibata-Modern-Ice";

  gtk.theme.package = pkgs.adw-gtk3;
  gtk.theme.name = "adw-gtk3";

  gtk.iconTheme.package = gruvbox;
  gtk.iconTheme.name = "GruvboxPlus";

  qt.enable = true;

  # platform theme "gtk" or "gnome"
  qt.platformTheme = "gtk";

  # name of the qt theme
  qt.style.name = "adwaita-dark";

  # detected automatically:
  # adwaita, adwaita-dark, adwaita-highcontrast,
  # adwaita-highcontrastinverse, breeze,
  # bb10bright, bb10dark, cde, cleanlooks,
  # gtk2, motif, plastique

  # package to use
  qt.style.package = pkgs.adwaita-qt;
}
