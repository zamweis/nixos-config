{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # common
    chromium
    keepassxc
    nitrokey-app
    nextcloud-client
    spotify
    pcmanfm
    xl2tpd
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
    kubectl
    kubernetes-helm
    jetbrains.phpstorm
    # (texlive.combine {
    #   inherit (pkgs.texlive)
    #     scheme-full latexmk;
    # })
    gnumake
    ripgrep
    fd
    docker-compose
    pv
    wireshark
    postman
    nixops

    # appearance
    nitrogen

    # work
    slack

    # media
    vlc
    evince

    # i3
    rofi
    betterlockscreen
    playerctl
  ];
}
