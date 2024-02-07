{ config, pkgs, ... }: {
  programs.zsh = {
    ohMyZsh.enable = true;
    ohMyZsh.plugins = [ "git" ];
    ohMyZsh.theme = "frisk";
    interactiveShellInit = ''
      KITTY_SHELL_INTEGRATION="enabled"
      typeset -gA ZSH_HIGHLIGHT_STYLES
      ${pkgs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin
      ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=cyan,underline
      ZSH_HIGHLIGHT_STYLES[precommand]=fg=cyan,underline
      ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
    '';
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
    shellAliases = {
      vpn =
        "sudo openconnect -u vesse1u@etu --authgroup='Universite-de-Lorraine' vpn.univ-lorraine.fr";
      rnm = "sudo systemctl restart NetworkManager";
      upgrade =
        "sudo nixos-rebuild switch --flake /home/ciflire/etc/nixos#default";
      update = "sudo nix flake update /home/ciflire/etx/nixos#default";
      # wallpaper = "/home/ciflire/dotfiles/hypr/scripts/wallpaper.sh select";
      ls = "lsd -la";
      lr = "lsd -lR";
      cat = "bat";
      open = "xdg-open";
    };
  };

  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      add_newline = true;
      character = {
        success_symbol = "[   ](bold cyan)";
        error_symbol = "[   ](bold red)";
      };
      nix_shell = { disabled = false; };
      package.disabled = true;
    };
  };

}
