{ pkgs, ... }:
{
  programs.urxvt = {
      enable = true;
      package = pkgs.rxvt_unicode;
      fonts = [
          "xft:Hack Nerd Font Mono:size=12"
      ];
      keybindings = {
          "Shift-Control-C" = "eval:selection_to_clipboard";
          "Shift-Control-V" = "eval:paste_clipboard";
      };
      iso14755 = false;
      scroll = {
        bar.enable = false;
        lines = 50000;
        keepPosition = true;
        scrollOnKeystroke = true;
        scrollOnOutput = false;
      };
      transparent = false;
      shading = 30;
      extraConfig = {
        "depth" = "32";
        "background" = "#1d1f21";
        "underlineColor" = "#4682B4";
        "hightlightColor" = "#4682B4";
        "internalBorder" = 10;
        "externalBorder" = 0;
        "termName" = "xterm-256color";
      };
  };
}