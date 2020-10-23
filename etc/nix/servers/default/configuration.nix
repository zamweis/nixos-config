{ config, pkgs, useDHCP ? true, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # boot loader
  boot.loader.systemd-boot.enable = true;

  networking.interfaces.ens18.useDHCP = useDHCP;
  networking = {
    networkmanager = {
      enable = true;
      insertNameservers = [ "10.0.0.2" "1.1.1.1" ];
    };
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "colemak";
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    git
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    vincentcui = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keyFiles = [ ../../ssh/yubi.pub ];
    };
  };

  system.stateVersion = "20.03";
}

