/*
This is my configuration file for my laptop (Lenovo E490)
*/

{ config, pkgs, ... }:
let
  hostName = "t550";
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
    };
    loader.efi.efiSysMountPoint = "/boot/efi";
    resumeDevice = "/dev/disk/by-label/swap";
  };

  services.xserver.dpi = 90;

  programs.light.enable = true;
}
