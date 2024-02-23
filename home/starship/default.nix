{ ... }: {
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
