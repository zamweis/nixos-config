{ config, pkgs, hostName ? "undefined", ... }:
{
  imports = [
    <home-manager/nixos>
  ];

  ##### Boot and Kernel #####

  boot = {
    cleanTmpDir = true;
  };

  ##### Garbage Collector #####
  nix.gc = {
    automatic = true;
    dates = "03:00";
  };

  ##### Networking #####

  networking = {
    hostName = hostName;
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [
        9000 # XDebug
      ];
      checkReversePath = false;
    };

    extraHosts = ''
      127.0.0.1 local.campusjaeger.de admin.local.campusjaeger.de arbeitgeber.local.campusjaeger.de www.local.campusjaeger.de candidates.local.campusjaeger.de api.local.campusjaeger.de employees.local.campusjaeger.de
      # 18.185.191.158 test.campusjaeger.de arbeitgeber.test.campusjaeger.de admin.test.campusjaeger.de candidates.test.campusjaeger.de www.test.campusjaeger.de api.test.campusjaeger.de feed.test.campusjaeger.de companies.test.campusjaeger.de employees.test.campusjaeger.de
    '';
  };

  ##### Timezone and Internationalisation #####

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  ##### System Packages #####

  # Allow nonfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    gparted
    pciutils

    manpages
    posix_man_pages
  ];

  ##### Services #####

  hardware.bluetooth.enable = true;
  services = {
    # SSH
    openssh = {
      enable = true;
      passwordAuthentication = false;
      challengeResponseAuthentication = false;
    };
    # Bluetooth
    blueman.enable = true;
    # Gnome Keyring
    gnome3.gnome-keyring.enable = true;
    # L2TP
    strongswan = {
      enable = true;
      secrets = [
        "ipsec.d/ipsec.nm-l2tp.secrets"
      ];
    };
    # GVFS for Samba
    gvfs.enable = true;
    # CUPS for printing
    printing.enable = true;
    # Yubikey
    pcscd.enable = true;
    
    udev = {
      packages = with pkgs; [
        # Yubikey
        yubikey-personalization
        libu2f-host
      ];
    };
  };

  programs = {
    dconf.enable = true;
    nm-applet.enable = true;
  };

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;

  ##### X11, Window Manager, XDG, etc. #####

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # Setting keyboard layout
    layout = "us";
    xkbVariant = "colemak";

    displayManager = {
      gdm.enable = true;
      defaultSession = "home-manager";
    };
    
    desktopManager = {
      session = [
        {
          name = "home-manager";
          start = ''
            ${pkgs.runtimeShell} $HOME/.hm-xsession &
            waitPID=$!
          '';
        }
      ];
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
  };
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  ##### Users & Security#####

  # Define a user account. Don't forget to set a password with ‘passwd’.
  
  users = {
    users = {
      vincentcui = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "audio" "docker" "video" "libvirtd" ];
        shell = pkgs.zsh;
        home = "/home/vincentcui";
        description = "Vincent Cui";
        openssh.authorizedKeys.keyFiles = [ ./ssh/yubi.pub ];
      };
    };
  };

  home-manager.users.vincentcui = (import ../../home/vincentcui/home-manager/home.nix {
    inherit pkgs;
  });

  security = {
    sudo = {
      enable = true;
      extraConfig = ''
        %wheel ALL=(ALL:ALL) NOPASSWD: ${pkgs.systemd}/bin/poweroff
        %wheel ALL=(ALL:ALL) NOPASSWD: ${pkgs.systemd}/bin/reboot
        %wheel ALL=(ALL:ALL) NOPASSWD: ${pkgs.systemd}/bin/systemctl suspend
      '';
    };
  };

  nix = {
    allowedUsers = [
      "@wheel"
    ];
    trustedUsers = [
      "@wheel"
    ];
  };

  ##### Misc #####

  environment.shells = [ pkgs.zsh ];

  # zsh completion
  environment.pathsToLink = [ "/share/zsh" ];

  # List of fonts
  fonts.enableDefaultFonts = true;
  fonts.fonts = with pkgs; [
    hack-font
    ubuntu_font_family
    nerdfonts
  ];

  hardware.nitrokey = {
    enable = true;
    group = "wheel";
  };

  # Man pages
  documentation = {
    enable = true;
    man.enable = true;
    dev.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system = {
    stateVersion = "20.03";
    autoUpgrade = {
      enable = true;
      allowReboot = true;
      channel = https://nixos.org/channels/nixos-unstable;
    };
  };
}
