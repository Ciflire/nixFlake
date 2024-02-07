{ config, lib, ... }: {
  programs.zsh = {
    enable = true;
    autocd = true;
    oh-my-zsh = { enable = true; };
    plugins = [ "zsh-autosuggestions" ];
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
