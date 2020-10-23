# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  hardware.cpu.amd.updateMicrocode = true;

  ##### Network #####

  networking = {
    interfaces = {
      enp4s0.useDHCP = true;
    };
  };

  ##### Kernel #####

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  ##### Hardware #####

  hardware.pulseaudio = {
    enable = true;
    systemWide = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  ##### Filesystem #####

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  fileSystems."/data" =
    { device = "/dev/disk/by-label/data";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  fileSystems."/storage" =
    { device = "/dev/disk/by-label/storage";
      fsType = "ext4";
    };

  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];

  nix.maxJobs = lib.mkDefault 16;
}
