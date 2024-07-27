# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  inputs,
  types,
  lib,
  ...
}:

{
  imports = [
    inputs.home-manager.nixosModules.default
    ../ricing/stylix.nix
    ./hardware-configuration.nix
    ../modules/nixos/nvidia.nix
  ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.timeout = 20;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings = {
    substituters = [ "https://walker.cachix.org" ];
    trusted-public-keys = [ "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM=" ];
  };

  # Environment variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_DRM_DEVICES = "$HOME/.config/hypr/amdgpu:$HOME/.config/hypr/nvidia";
    MOZ_ENABLE_WAYLAND = "1";
    SDL_VIDEODRIVER = "wayland,x11";
  };

  # Hostname
  networking.hostName = "g713";
  # Enable .local/share/fonts
  fonts.fontDir.enable = true;

  # Enable networking
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # System language
  i18n.defaultLocale = "en_GB.UTF-8";
  # Other locale setup
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

  # Blueman applet
  services.blueman.enable = true;
  services.xserver.wacom.enable = true;
  # Enable the X11 windowing system.
  # Enable the KDE Plasma Desktop Environment.

  services.asusd.enable = true;
  services.asusd.enableUserService = true;

  # Configure console keymap
  console.keyMap = "fr";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ciflire = {
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    isNormalUser = true;
    description = "VESSE Léo";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "openrazer"
      "vboxusers"
      "input"
      "libvirtd"
      "video"
      "gamemode"
    ];
    packages = with pkgs; [
      (callPackage ../packages/hyneview.nix { })

      # Archive managers
      zip
      p7zip
      unzip
      unrar

      thunderbird # Mail

      # version control manager
      gitkraken
      lazygit

      # Terminal tools
      lsd
      bat
      btop
      yazi
      fzf
      atuin
      tldr

      # Minecraft
      prismlauncher
      zulu8

      # Proton/Wine helpers
      (wineWowPackages.full.override {
        wineRelease = "staging";
        mingwSupport = true;
      })
      winetricks
      protonup-qt
      protontricks

      spotify
      openconnect
      (pkgs.wrapOBS {
        plugins = (
          with pkgs.obs-studio-plugins;
          [
            wlrobs
            obs-tuna
            input-overlay
            obs-pipewire-audio-capture
          ]
        );
      })
      wl-clipboard
      zathura
      mongodb-compass
      qFlipper
      direnv
      pre-commit
      libreoffice-qt
      vlc
      (lutris.override { extraLibraries = pkgs: [ pkgs.jansson ]; })
      polychromatic
      mangohud
      libsForQt5.networkmanager-qt
      vesktop
      arrpc
      heroic
      ryujinx
      nixfmt-rfc-style
      nil
      pulsemixer
      pwvucontrol
      element-desktop
      fastfetch
      qpwgraph
      qemu
      inputs.steam-tui.packages.${pkgs.system}.steam-tui
      librewolf
      appimage-run
    ];
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    users = {
      "ciflire" = import ../home/home.nix;
    };
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
  # virtualisation.virtualbox.host.enable = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  programs.sway.enable = true;
  security.pam.services.swaylock.text = "auth include login";

  security.polkit.enable = true;

  # Enable Display Manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
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

  # You need those lines for power management and tray icons
  services.upower.enable = true;
  services.gvfs.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };
  programs.virt-manager.enable = true;

  hardware.opentabletdriver.enable = true;

  services.cpupower-gui.enable = true;
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
