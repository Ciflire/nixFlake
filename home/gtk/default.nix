# home.nix
{ pkgs, ... }: {
  gtk = {
    enable = true;
    # theme = {
    #   name = "Catppuccin-Macchiato-Compact-Pink-Dark";
    #   package = pkgs.catppuccin-gtk.override {
    #     accents = [ "pink" ];
    #     size = "compact";
    #     tweaks = [ "rimless" "black" ];
    #     variant = "macchiato";
    #   };
    # };
    gtk3.extraConfig.gtk-decoration-layout = "menu:";
    cursorTheme.name = "Qogir";
    iconTheme.name = "Qogir";
  };
}
