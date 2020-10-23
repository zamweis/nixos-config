{ pkgs, ... }:
let
  xcursor = {
    theme = "breeze_cursors";
    size = 16;
  };
in
{
  home.packages = with pkgs; [
    lxappearance
    font-manager

    # icon themes
    papirus-icon-theme

    # gkt themes
    qogir-theme
    arc-theme
    breeze-gtk
  ];

  # Cursor Icon Theme
  home.file.".icons/default/index.theme".text = ''
    [Icon Theme]
    Name=Default
    Comment=Default Cursor Theme
    Inherits=${xcursor.theme}
  '';

  gtk = {
    enable = true;
    font.name = "Ubuntu 12";
    theme = {
      name = "Qogir-ubuntu-win-dark";
    };
    iconTheme = {
      name = "Papirus";
    };

    gtk2.extraConfig = ''
      gtk-cursor-theme-name="${xcursor.theme}"
      gtk-cursor-theme-size=${toString xcursor.size}
    '';

    gtk3.extraConfig = {
      "gtk-cursor-theme-name" = xcursor.theme;
      "gtk-cursor-theme-size" = xcursor.size;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  xresources.properties = {
    "*.foreground" = "#c5c8c6";
    "*.cursorColor" = "#c5c8c6";
    # black
    "*.color0" = "#1d1f21";
    "*.color8" = "#969896";
    # red
    "*.color1" = "#cc342b";
    "*.color9" = "#cc342b";
    # green
    "*.color2" = "#198844";
    "*.color10" = "#198844";
    # yellow
    "*.color3" = "#fba922";
    "*.color11" = "#fba922";
    # blue
    "*.color4" = "#3971ed";
    "*.color12" = "#3971ed";
    # magenta
    "*.color5" = "#a36ac7";
    "*.color13" = "#a36ac7";
    # cyan
    "*.color6" = "#3971ed";
    "*.color14" = "#3971ed";
    # white
    "*.color7" = "#c5c8c6";
    "*.color15" = "#ffffff";

    # Cursor size
    "Xcursor.theme" = xcursor.theme;
    "Xcursor.size" = 16;
  };
}
