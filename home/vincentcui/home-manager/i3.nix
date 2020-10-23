{ pkgs, ... }:

let
  hostName = (import <nixpkgs/nixos> {}).config.networking.hostName;

  mod = "Mod4";

  up = "i";
  down = "e";
  left = "n";
  right = "o";

  systemMode = "(l)ock, (e)xit, switch_(u)ser, (s)uspend, (h)ibernate, (r)eboot, (Shift+s)hutdown";

  customAutostart = if hostName == "galaxy" then
      "exec --no-startup-id monitor-extend-left"
    else if hostName == "nebula" then
      ""
    else
      "";
in
{    
  xsession = {
    enable = true;
    scriptPath = ".hm-xsession";

    windowManager.i3 = {
      enable = true;
      config = {
        modifier = mod;

        fonts = ["Ubuntu 12"];

        colors = {
          background = "#ffffff";
          focused = {
            border = "#4c7899";
            background = "#285577";
            text = "#ffffff";
            indicator = "#2e9ef4";
            childBorder = "#285577";
          };
          focusedInactive = {
            border = "#333333";
            background = "#5f676a";
            text = "#ffffff";
            indicator = "#484e50";
            childBorder = "#5f676a";
          };
          unfocused = {
            border = "#333333";
            background = "#222222";
            text = "#888888";
            indicator = "#292d2e";
            childBorder = "#222222";
          };
          urgent = {
            border = "#2f343a";
            background = "#900000";
            text = "#ffffff";
            indicator = "#900000";
            childBorder = "#900000";
          };
          placeholder = {
            border = "#000000";
            background = "#0c0c0c";
            text = "#ffffff";
            indicator = "#000000";
            childBorder = "#0c0c0c";
          };
        };

        keybindings = {
          # System
          ## restart i3
          "${mod}+Shift+r" = "restart";
          ## kill
          "${mod}+Shift+q" = "kill";
          ## system menu
          "${mod}+0" = ''mode"${systemMode}"'';

          # Windows
          ## toggle tiling/floating
          "${mod}+Shift+space" = "floating toggle";
          ## change focus
          "${mod}+${up}" = "focus up";
          "${mod}+${down}" = "focus down";
          "${mod}+${left}" = "focus left";
          "${mod}+${right}" = "focus right";
          ## move focused window
          "${mod}+Shift+${up}" = "move up";
          "${mod}+Shift+${down}" = "move down";
          "${mod}+Shift+${left}" = "move left";
          "${mod}+Shift+${right}" = "move right";
          ## resize
          "${mod}+r" = ''mode "resize"'';
          ## orientation
          "${mod}+h" = "split h";
          "${mod}+v" = "split v";
          "${mod}+q" = "split toggle";
          ## fullscreen
          "${mod}+f" = "fullscreen toggle";
          ## stacking and tabbing
          "${mod}+s" = "layout stacking";
          "${mod}+t" = "layout tabbed";
          "${mod}+semicolon" = "layout toggle split";
          ## change focus between floating and tiling window
          "${mod}+space" = "focus mode_toggle";
          ## focus parent container
          "${mod}+a" = "focus parent";

          # Workspaces
          ## next/previous workspace
          "Mod1+Tab" = "workspace next";
          "Mod1+Shift+Tab" = "workspace prev";
          "${mod}+Tab" = "workspace back_and_forth";
          ## switch to workspace
          "${mod}+1" = "workspace 1";
          "${mod}+2" = "workspace 2";
          "${mod}+3" = "workspace 3";
          "${mod}+4" = "workspace 4";
          "${mod}+5" = "workspace 5";
          "${mod}+6" = "workspace 6";
          "${mod}+7" = "workspace 7";
          "${mod}+8" = "workspace 8";
          "${mod}+9" = "workspace 9";
          ## move focused container to workspace
          "${mod}+Shift+1" = "move container to workspace 1; workspace 1";
          "${mod}+Shift+2" = "move container to workspace 2; workspace 2";
          "${mod}+Shift+3" = "move container to workspace 3; workspace 3";
          "${mod}+Shift+4" = "move container to workspace 4; workspace 4";
          "${mod}+Shift+5" = "move container to workspace 5; workspace 5";
          "${mod}+Shift+6" = "move container to workspace 6; workspace 6";
          "${mod}+Shift+7" = "move container to workspace 7; workspace 7";
          "${mod}+Shift+8" = "move container to workspace 8; workspace 8";
          "${mod}+Shift+9" = "move container to workspace 9; workspace 9";
          ## move focused container
          "${mod}+control+1" = "move container to workspace 1";
          "${mod}+control+2" = "move container to workspace 2";
          "${mod}+control+3" = "move container to workspace 3";
          "${mod}+control+4" = "move container to workspace 4";
          "${mod}+control+5" = "move container to workspace 5";
          "${mod}+control+6" = "move container to workspace 6";
          "${mod}+control+7" = "move container to workspace 7";
          "${mod}+control+8" = "move container to workspace 8";
          "${mod}+control+9" = "move container to workspace 9";
          ## switch two displays
          "${mod}+control+${up}" = "exec --no-startup-id i3-msg move workspace to output up";
          "${mod}+control+${down}" = "exec --no-startup-id i3-msg move workspace to output down";
          "${mod}+control+${left}" = "exec --no-startup-id i3-msg move workspace to output left";
          "${mod}+control+${right}" = "exec --no-startup-id i3-msg move workspace to output right";

          # Applications
          ## rofi
          "${mod}+w" = "exec --no-startup-id ${pkgs.rofi}/bin/rofi run -show drun -line-padding 4 -columns 2 -width 40 -padding 30 -hide-scrollbar -show-icons -drun-icon-theme";
          ## urxvt
          "${mod}+Return" = "exec --no-startup-id ${pkgs.rxvt_unicode}/bin/urxvt";
          ## spotify
          "${mod}+F1" = "exec --no-startup-id ${pkgs.spotify}/bin/spotify";
          ## chromium
          "${mod}+F2" = "exec --no-startup-id ${pkgs.chromium}/bin/chromium";
          ## pcmanfm
          "${mod}+F3" = "exec --no-startup-id ${pkgs.pcmanfm}/bin/pcmanfm";
          ## pavucontrol
          "${mod}+Shift+m" = "exec --no-startup-id ${pkgs.pavucontrol}/bin/pavucontrol";

          # Screenshots
          ## Without GUI
          "Print" = "exec --no-startup-id screenshot";
          ## With GUI
          "Shift+Print" = "exec --no-startup-id screenshot-gui";

          # Audio Settings
          "XF86AudioRaiseVolume" = ''exec --no-startup-id "amixer sset Master '5%+'"'';
          "XF86AudioLowerVolume" = ''exec --no-startup-id "amixer sset Master '5%-'"'';
          "XF86AudioMute" = ''exec --no-startup-id "amixer set Master toggle"'';
          "XF86AudioPlay" = ''exec --no-startup-id playerctl play-pause'';
          "XF86AudioNext" = ''exec --no-startup-id playerctl next'';
          "XF86AudioPrev" = ''exec --no-startup-id playerctl previous'';
          "XF86AudioStop" = ''exec --no-startup-id playerctl stop'';

          # Brightness Settings
          "XF86MonBrightnessUp" = "exec --no-startup-id light -A 10";
          "XF86MonBrightnessDown" = "exec --no-startup-id light -U 10";
        };

        modes = {
          resize = {
            # resize
            "${up}" = "resize shrink height 10px or 10 ppt";
            "${down}" = "resize grow height 10 px or 10 ppt";
            "${left}" = "resize shrink width 10 px or 10 ppt";
            "${right}" = "resize grow width 10 px or 10 ppt";
            # back
            "Return" = ''mode "default"'';
            "Escape" = ''mode "default"'';
          };
          "${systemMode}" = {
            "l" = ''exec --no-startup-id betterlockscreen --lock, mode "default"'';
            "s" = ''exec --no-startup-id betterlockscreen --suspend, mode "default"'';
            "e" = ''exec --no-startup-id i3-msg exit, mode "default"'';
            "r" = ''exec --no-startup-id reboot, mode "default"'';
            "h" = ''exec --no-startup-id systemctl hibernate'';
            "Shift+s" = ''exec --no-startup-id poweroff, mode "default"'';
            # TODO hibernate
            # back
            "Return" = ''mode "default"'';
            "Escape" = ''mode "default"'';
          };
        };

        gaps = {
          inner = 8;
          outer = 3;
          top = 39;
        };

        bars = [];
      };

      extraConfig = ''
        default_orientation horizontal
        workspace 1 output eDP-1 HDMI-0
        workspace 2 output eDP-1 HDMI-0
        workspace 3 output eDP-1 HDMI-0
        workspace 4 output eDP-1 HDMI-0
        workspace 5 output eDP-1 HDMI-0
        workspace 6 output DVI-I-1 HDMI-1
        workspace 7 output DVI-I-1 HDMI-1
        workspace 8 output DVI-I-1 HDMI-1
        workspace 9 output DVI-I-1 HDMI-1
        popup_during_fullscreen smart

        exec_always --no-startup-id nitrogen --restore
        exec_always --no-startup-id systemctl --user restart polybar
        exec --no-startup-id betterlockscreen -u /config/home/vincentcui/wallpaper/running-simple.jpg
      '' + customAutostart;
    };
  };
}
