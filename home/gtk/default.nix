# this is home manager module
# gtk.nix
{ pkgs, ... }:
{

  gtk = {
    iconTheme = {
      name = "kora";
      package = pkgs.kora-icon-theme;
    };
  };
}
