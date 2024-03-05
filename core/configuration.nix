# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    inputs.home-manager.nixosModules.default
    ./hardware-configuration.nix
    ../modules/nixos/nvidia.nix
    # ./zsh.nix
  ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  virtualisation.docker.enable = true;
  services.udev.packages = [ pkgs.logitech-udev-rules ];

  # environment.sessionVariables.NIXOS_OZONE_WL = "1";

  networking.hostName = "nixos"; # Define your hostname.
  fonts.fontDir.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  # networking.wireless.iwd.enable = true;
  networking.wireless.enable = true;
  networking.networkmanager = { enable = true; };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internatzshionalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };
  services.hardware.openrgb.enable = true;
  services.blueman.enable = true;
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };
  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "fr";
    xkb.variant = "";
  };

  services.asusd.enable = true;

  # Configure console keymap
  console.keyMap = "fr";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot =
    true; # powers up the default Bluetooth controller on boot

  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
    enableSSHSupport = true;
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  fonts.packages = with pkgs; [ fira-code-nerdfont mononoki ];
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ciflire = {
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    isNormalUser = true;
    description = "VESSE Léo";
    extraGroups =
      [ "networkmanager" "wheel" "docker" "openrazer" "vboxusers" "input" ];
    packages = with pkgs; [
      firefox
      kate
      thunderbird
      discord-canary
      helix
      gitkraken
      vscode
      # gnupg
      spotify
      # wine
      # wine64
      # winetricks
      # wineWowPackages.stable
      (wineWowPackages.full.override {
        wineRelease = "staging";
        mingwSupport = true;
      })
      winetricks
      lsd
      openconnect
      zellij
      lazygit
      marksman
      dprint
      bat
      sqlitebrowser
      (pkgs.wrapOBS {
        plugins =
          (with pkgs.obs-studio-plugins; [ obs-pipewire-audio-capture ]);
      })
      chromium
      wl-clipboard
      zathura
      wlroots
      openssl
      mongodb-compass
      glib
      glibc
      mdbook
      qFlipper
      asusctl
      ntfs3g
      direnv
      pre-commit
      rustup
      libreoffice-qt
      pdf2svg
      unzip
      solaar
      wezterm
      gcc
      zip
      lua
      lua-language-server
      luaformatter
      vlc
      xorg.xeyes
      xwaylandvideobridge
      (lutris.override { extraLibraries = pkgs: [ pkgs.jansson ]; })
      protontricks
      openrazer-daemon
      razergenie
      spotify-tui
      nixfmt
      nixd
      nil
      p7zip
      btop
      appimage-run
      pango
      gdk-pixbuf
      kitty
      yuzu
      unrar
      polychromatic
      ltex-ls
      bottom
      polkit-kde-agent
      nodePackages_latest.prettier
      mangohud
      vscode-langservers-extracted
      nodePackages_latest.prettier
      nodejs_21
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { "ciflire" = import ../home/home.nix; };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
  ];

  programs.steam.enable = true;

  # Virtual Box
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  security.pam.services.swaylock.text = "auth include login";

  security.polkit.enable = true;

  # Enable Display Manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command =
          "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
        user = "greeter";
      };
    };
  }; # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  services.mpd.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
