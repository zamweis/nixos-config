/*
This is my configuration file for my laptop (Lenovo E490)
*/

{ config, pkgs, ... }:
let
  hostName = "nebula";
in
{
  imports =
    [ # Include the results of the hardware scan.
      (import ../configuration.nix {
        inherit config pkgs hostName;
      })
      ./hardware-configuration.nix
    ];

  boot = {
    loader.grub = {
      enable = true;
      version = 2;
      device = "nodev";
      efiSupport = true;
      enableCryptodisk = true;
    };
    loader.efi.efiSysMountPoint = "/boot/efi";
    initrd.luks.devices = {
      root = {
        device = "/dev/disk/by-uuid/ccd494a6-43f1-427a-ada0-7b7f7b612b88";
        preLVM = true;
        keyFile = "/crypt_keyfile.bin";
        allowDiscards = true;
      };
    };
    resumeDevice = "/dev/disk/by-label/swap";
    initrd.prepend = [
      "${/boot/initrd.key.gz}"
    ];
  };

  services.xserver.dpi = 90;

  programs.light.enable = true;
}
