{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # common
    chromium
    nitrokey-app
    nextcloud-client
    spotify
    spotify-tray
    pcmanfm
    unzip
    flameshot
    pavucontrol
    lm_sensors
    bind # network stuff
    networkmanager_openvpn
    arandr
    wget
    htop
    thunderbird

    # development
    coreutils
    clang
    jetbrains.idea-ultimate
    gnumake
    ripgrep
    fd
    docker-compose
    pv
    wireshark
    nixops

    # appearance
    nitrogen

    # work
    mattermost

    # media
    vlc
    evince

    # i3
    rofi
    betterlockscreen
    playerctl
  ];
}
