{ pkgs, ... }:

let
  mkScript = name: script: pkgs.writeScriptBin name
  ''
    #!${pkgs.runtimeShell}
    ${script}
  '';
  mkAlias = name: cli: mkScript name "exec ${cli}";
in
{
  home.packages = with pkgs; [
    ##### Screenshots #####
    (mkScript "screenshot"
      ''
      if [[ ! -d "''${HOME}/Pictures/Screenshots" ]]; then
        mkdir -p "''${HOME}/Pictures/Screenshots"
      fi
      flameshot full -p "''${HOME}/Pictures/Screenshots"
      '')

    (mkAlias "screenshot-gui"
      "flameshot gui")

    ##### Monitor Setup #####
    (mkAlias "monitor-extend-left"
      "xrandr --output HDMI-0 --primary --mode 2560x1080 --pos 1080x460 --rotate normal --output DVI-I-1 --mode 1920x1080 --pos 0x0 --rotate left")
    
    (mkAlias "monitor-main-only"
      "xrandr --output DVI-I-0 --off --output DVI-I-1 --off --output DVI-I-2 --off --output HDMI-0 --primary --mode 2560x1080 --pos 0x0 --rotate normal --output DVI-I-3 --off")
  ];
}