{ pkgs, ... }:
{
  imports = [
    ./packages.nix
    ./zsh.nix
    ./ssh.nix
    ./vscode.nix
    ./scripts.nix
    ./urxvt.nix
    ./gpg.nix
    ./git.nix
    ./theme.nix
    ./files.nix
    ./mime-apps.nix
    ./dunst.nix
    ./emacs.nix
    ./i3.nix
    ./polybar.nix
  ];

  xsession.numlock.enable = true;

  services.blueman-applet.enable = true;
  services.nextcloud-client.enable = true;

  programs.command-not-found.enable = true;
  programs.home-manager.enable = true;
  
  home.sessionVariables = {
    EDITOR = "nano";
  };

  home.stateVersion = "20.03";
}
