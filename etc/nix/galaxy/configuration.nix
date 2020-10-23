/*
This is my configuration file for my computer.
*/

{ config, pkgs, ... }:
let
  hostName = "galaxy";
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
    # systemd-boot EFI boot loader
    loader = {
      systemd-boot.enable = true;
    };
  };

  services.wakeonlan.interfaces = [
    {
      interface = "enp4s0";
      method = "magicpacket";
    }
  ];
}
