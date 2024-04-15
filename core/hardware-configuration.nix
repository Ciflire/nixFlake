# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "nvme" "xhci_pci" "usbhid" "usb_storage" "sd_mod" ];
  # boot.blacklistedKernelModules =
  #   [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  boot.initrd.kernelModules = 
    [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  # boot.initrd.kernelModules = [ "nouveau" ];
  boot.blacklistedKernelModules = [ "nouveau" ];
  boot.kernelModules = [ "kvm-amd" "plfxlc" ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "splash"
    "nvidia-drm.modeset=1"
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/5827e49a-bc2e-4271-8b2c-c1d558c0dc63";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/BB02-23F3";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/24edec28-9a71-4e85-8a1e-eecf270c392f"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.flipperzero.enable = true;
  hardware.xpadneo.enable = true;
  hardware.openrazer.enable = true;
}
