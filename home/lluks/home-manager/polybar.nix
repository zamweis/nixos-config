{ pkgs, ... }:
let
  hostName = (import <nixpkgs/nixos> {}).config.networking.hostName;

  mainMonitor = if hostName == "luminus" then
    "HDMI-0"
  else if hostName == "t550" then
    "eDP-1"
  else
    "UNDEFINED";

  color = {
    bg = "#252525"; 
    fg = "#f5f5f5";
    ac = "#546e7a";
    mf = "#f5f5f5";
    bi = "#546e7a";
    be = "#546e7a";
    bf = "#43a047";
    bn = "#43a047";
    bm = "#fdd835";
    bd = "#e53935";
    trans = "#00000000";
    white = "#FFFFFF";
    black = "#000000";
    mainBlue = "#4DB6AC";
    mainRed = "#B64F4D";
    mainGreen = "#4DB667";
    mainPurple = "#4D86B6";
    mainDarkBlue = "#546E7A";
  };
in
{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override { i3GapsSupport = true; pulseSupport = true;};
    config = {
      "bar/bar" = {
        monitor = "\${env:MONITOR}";
        monitor-strict = false;
        override-redirect = true;
        bottom = false;
        fixed-center = true;

        width = "100%:-18";
        height = "25";

        offset-x = 11;
        offset-y = 11;

        background = "${color.bg}";
        foreground = "${color.fg}";

        radius-top = "0.0";
        radius-bottom = "0.0";

        overline-size = 2;
        overline-color = "${color.ac}";

        border-bottom-size = 2;
        border-color = "${color.ac}";

        padding-left = 0;
        padding-right = 0;

        module-margin-left = 2;
        module-margin-right = 2;

        font-0 = "UbuntuCondensed:size=10;2";
        font-1 = "icomoon\\-feather:size=10;2";
        font-2 = "Iosevka:size=10;2";

        dim-value = "1.0";
        locale = "en_US.UTF-8";

        tray-detached = false;
        tray-maxsize = 16;
        tray-background = "${color.bg}";
        tray-offset-x = 0;
        tray-offset-y = 0;
        tray-padding = 0;
        tray-scale = "1.0";

        wm-restack = "i3";
        enable-ipc = true;
      };
      "bar/galaxy" = {
        "inherit" = "bar/bar";

        modules-left = "launcher i3 cpu_bar memory_bar temperature";
        modules-right = "pulseaudio wired-network date sysmenu";

        tray-position = "center";
      };
      "bar/t550" = {
        "inherit" = "bar/bar";

        modules-left = "launcher i3 cpu_bar memory_bar temperature";
        modules-right = "backlight battery pulseaudio wireless-network date sysmenu";

        tray-position = "center";
      };
      "bar/secondary" = {
        "inherit" = "bar/bar";

        modules-left = "launcher i3";
        modules-right = "date sysmenu";
        
        tray-position = "none";
      };
      "module/date" = {
        type = "internal/date";

        # Seconds to sleep between updates
        interval = "1.0";

        # See "http://en.cppreference.com/w/cpp/io/manip/put_time" for details on how to format the date string
        # NOTE: if you want to use syntax tags here you need to use %%{...}
        ##date = %d-%m-%Y%

        # Optional time format
        time = " %I:%M %p %d-%m-%Y%";

        # Available tags:
        #   <label> (default)
        format = "<label>";

        # Available tokens:
        #   %date%
        #   %time%
        # Default: %date%
        label = "%time%";
      };
      "module/wired-network" = {
        type = "internal/network";
        interface = "enp0s25";

        # Seconds to sleep between updates
        # Default: 1
        interval = "1.0";

        # Test connectivity every Nth update
        # A value of 0 disables the feature
        # NOTE: Experimental (needs more testing)
        # Default: 0
        #ping-interval = 3

        # @deprecated: Define min width using token specifiers (%downspeed:min% and %upspeed:min%)
        # Minimum output width of upload/download rate
        # Default: 3
        ##udspeed-minwidth = 5

        # Accumulate values from all interfaces
        # when querying for up/downspeed rate
        # Default: false
        accumulate-stats = true;

        # Consider an `UNKNOWN` interface state as up.
        # Some devices have an unknown state, even when they're running
        # Default: false
        unknown-as-up = true;

        # Available tags:
        #   <label-connected> (default)
        #   <ramp-signal>
        format-connected = "<ramp-signal> <label-connected>";

        # Available tags:
        #   <label-disconnected> (default)
        format-disconnected = "<label-disconnected>";

        # Available tags:
        #   <label-connected> (default)
        #   <label-packetloss>
        #   <animation-packetloss>
        ##format-packetloss = <animation-packetloss> <label-connected>

        # Available tokens:
        #   %ifname%    [wireless+wired]
        #   %local_ip%  [wireless+wired]
        #   %local_ip6% [wireless+wired]
        #   %essid%     [wireless]
        #   %signal%    [wireless]
        #   %upspeed%   [wireless+wired]
        #   %downspeed% [wireless+wired]
        #   %linkspeed% [wired]
        # Default: %ifname% %local_ip%
        label-connected = "%local_ip% %downspeed:8%  %upspeed:8%";
        ##label-connected-foreground = #eefafafa

        # Available tokens:
        #   %ifname%    [wireless+wired]
        # Default: (none)
        label-disconnected = '' "Not Connected"'';
        ##label-disconnected-foreground = #66ffffff

        # Available tokens:
        #   %ifname%    [wireless+wired]
        #   %local_ip%  [wireless+wired]
        #   %local_ip6% [wireless+wired]
        #   %essid%     [wireless]
        #   %signal%    [wireless]
        #   %upspeed%   [wireless+wired]
        #   %downspeed% [wireless+wired]
        #   %linkspeed% [wired]
        # Default: (none)
        #label-packetloss = %essid%
        #label-packetloss-foreground = #eefafafa

        # Only applies if <ramp-signal> is used
        ramp-signal-0 = "";

        # Only applies if <animation-packetloss> is used
        ##animation-packetloss-0 = ⚠
        ##animation-packetloss-0-foreground = #ffa64c
        ##animation-packetloss-1 = ⚠
        ##animation-packetloss-1-foreground = #000000
        # Framerate in milliseconds
        ##animation-packetloss-framerate = 500
      };
      "module/wireless-network" = {
        type = "internal/network";
        interface = "wlp3s0";

        # Seconds to sleep between updates
        # Default: 1
        interval = "1.0";

        # Test connectivity every Nth update
        # A value of 0 disables the feature
        # NOTE: Experimental (needs more testing)
        # Default: 0
        #ping-interval = 3

        # @deprecated: Define min width using token specifiers (%downspeed:min% and %upspeed:min%)
        # Minimum output width of upload/download rate
        # Default: 3
        ##udspeed-minwidth = 5

        # Accumulate values from all interfaces
        # when querying for up/downspeed rate
        # Default: false
        accumulate-stats = true;

        # Consider an `UNKNOWN` interface state as up.
        # Some devices have an unknown state, even when they're running
        # Default: false
        unknown-as-up = true;

        # Available tags:
        #   <label-connected> (default)
        #   <ramp-signal>
        format-connected = "<ramp-signal> <label-connected>";

        # Available tags:
        #   <label-disconnected> (default)
        format-disconnected = "<label-disconnected>";

        # Available tags:
        #   <label-connected> (default)
        #   <label-packetloss>
        #   <animation-packetloss>
        ##format-packetloss = <animation-packetloss> <label-connected>

        # Available tokens:
        #   %ifname%    [wireless+wired]
        #   %local_ip%  [wireless+wired]
        #   %local_ip6% [wireless+wired]
        #   %essid%     [wireless]
        #   %signal%    [wireless]
        #   %upspeed%   [wireless+wired]
        #   %downspeed% [wireless+wired]
        #   %linkspeed% [wired]
        # Default: %ifname% %local_ip%
        label-connected = "%essid% %downspeed:8%  %upspeed:8%";
        ##label-connected-foreground = #eefafafa

        # Available tokens:
        #   %ifname%    [wireless+wired]
        # Default: (none)
        label-disconnected = '' "Not Connected"'';
        ##label-disconnected-foreground = #66ffffff

        # Available tokens:
        #   %ifname%    [wireless+wired]
        #   %local_ip%  [wireless+wired]
        #   %local_ip6% [wireless+wired]
        #   %essid%     [wireless]
        #   %signal%    [wireless]
        #   %upspeed%   [wireless+wired]
        #   %downspeed% [wireless+wired]
        #   %linkspeed% [wired]
        # Default: (none)
        #label-packetloss = %essid%
        #label-packetloss-foreground = #eefafafa

        # Only applies if <ramp-signal> is used
        ramp-signal-0 = "";
        ramp-signal-1 = "";
        ramp-signal-2 = "";
        ramp-signal-3 = "";
        ramp-signal-4 = "";

        # Only applies if <animation-packetloss> is used
        ##animation-packetloss-0 = ⚠
        ##animation-packetloss-0-foreground = #ffa64c
        ##animation-packetloss-1 = ⚠
        ##animation-packetloss-1-foreground = #000000
        # Framerate in milliseconds
        ##animation-packetloss-framerate = 500
      };
      "global/wm" = {
        margin-bottom = 0;
        marin-top = 0;
      };
      "module/cpu_bar" = {
        type = "internal/cpu";

        interval = "0.5";

        # Available tags:
        #   <label> (default)
        #   <bar-load>
        #   <ramp-load>
        #   <ramp-coreload>
        ##format = <label> <ramp-coreload>
        format = "<bar-load> <label>";
        format-prefix = " ";

        # Available tokens:
        #   %percentage% (default) - total cpu load averaged over all cores
        #   %percentage-sum% - Cumulative load on all cores
        #   %percentage-cores% - load percentage for each core
        #   %percentage-core[1-9]% - load percentage for specific core
        label = "%percentage%%";

        # Only applies if <bar-load> is used
        bar-load-width = 10;
        bar-load-gradient = false;

        bar-load-indicator = "";
        bar-load-indicator-foreground = "${color.bi}";
        bar-load-indicator-font = 2;

        bar-load-fill = "━";
        bar-load-foreground-0 = "${color.bn}";
        bar-load-foreground-1 = "${color.bn}";
        bar-load-foreground-2 = "${color.bn}";
        bar-load-foreground-3 = "${color.bm}";
        bar-load-foreground-4 = "${color.bm}";
        bar-load-foreground-5 = "${color.bm}";
        bar-load-foreground-6 = "${color.bd}";
        bar-load-foreground-7 = "${color.bd}";
        bar-load-foreground-8 = "${color.bd}";
        bar-load-fill-font = 2;

        bar-load-empty = "┉";
        bar-load-empty-foreground = "${color.be}";
        bar-load-empty-font = 2;
      };
      "module/memory_bar" = {
        type = "internal/memory";

        # Seconds to sleep between updates
        # Default: 1
        interval = 2;

        # Available tags:
        #   <label> (default)
        #   <bar-used>
        #   <bar-free>
        #   <ramp-used>
        #   <ramp-free>
        #   <bar-swap-used>
        #   <bar-swap-free>
        #   <ramp-swap-used>
        #   <ramp-swap-free>
        format = "<bar-used> <label>";
        format-prefix = " ";

        # Available tokens:
        #   %percentage_used% (default)
        #   %percentage_free%
        #   %gb_used%
        #   %gb_free%
        #   %gb_total%
        #   %mb_used%
        #   %mb_free%
        #   %mb_total%
        #   %percentage_swap_used%
        #   %percentage_swap_free%
        #   %mb_swap_total%
        #   %mb_swap_free%
        #   %mb_swap_used%
        #   %gb_swap_total%
        #   %gb_swap_free%
        #   %gb_swap_used%
        label = "%mb_used%";

        # Only applies if <bar-used> is used
        bar-used-width = 10;
        bar-used-gradient = false;

        bar-used-indicator = "";
        bar-used-indicator-foreground = "${color.bi}";
        bar-used-indicator-font = 2;

        bar-used-fill = "━";
        bar-used-foreground-0 = "${color.bn}";
        bar-used-foreground-1 = "${color.bn}";
        bar-used-foreground-2 = "${color.bn}";
        bar-used-foreground-3 = "${color.bm}";
        bar-used-foreground-4 = "${color.bm}";
        bar-used-foreground-5 = "${color.bm}";
        bar-used-foreground-6 = "${color.bd}";
        bar-used-foreground-7 = "${color.bd}";
        bar-used-foreground-8 = "${color.bd}";
        bar-used-fill-font = 2;

        bar-used-empty = "┉";
        bar-used-empty-foreground = "${color.be}";
        bar-used-empty-font = 2;
      };
      "module/temperature" = {
        type = "internal/temperature";

        # Seconds to sleep between updates
        # Default: 1
        interval = "0.5";

        # Thermal zone to use
        # To list all the zone types, run
        # $ for i in /sys/class/thermal/thermal_zone*; do echo "$i: $(<$i/type)"; done
        # Default: 0
        thermal-zone = 0;

        # Full path of temperature sysfs path
        # Use `sensors` to find preferred temperature source, then run
        # $ for i in /sys/class/hwmon/hwmon*/temp*_input; do echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $(readlink -f $i)"; done
        # to find path to desired file
        # Default reverts to thermal zone setting
        hwmon-path = if hostName == "galaxy" then
          "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon1/temp1_input"
        else if hostName == "t550" then
          "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp1_input"
        else "";

        # Threshold temperature to display warning label (in degrees celsius)
        # Default: 80
        warn-temperature = 60;

        # Whether or not to show units next to the temperature tokens (°C, °F)
        # Default: true
        units = true;

        # Available tags:
        #   <label> (default)
        #   <ramp>
        format = "<ramp> <label>";

        # Available tags:
        #   <label-warn> (default)
        #   <ramp>
        format-warn = "<ramp> <label-warn>";

        # Available tokens:
        #   %temperature% (deprecated)
        #   %temperature-c%   (default, temperature in °C)
        #   %temperature-f%   (temperature in °F)
        label = "%temperature-c%";

        # Available tokens:
        #   %temperature% (deprecated)
        #   %temperature-c%   (default, temperature in °C)
        #   %temperature-f%   (temperature in °F)
        label-warn = "%temperature-c%";
        label-warn-foreground = "#f00";

        # Requires the <ramp> tag
        # The icon selection will range from 0 to `warn-temperature`
        # with the current temperature as index.
        ramp-0 = "";
        ramp-1 = "";
        ramp-2 = "";
        ramp-3 = "";
        ramp-4 = "";
        ##ramp-foreground = #55
      };
      "module/pulseaudio" = {
        type = "internal/pulseaudio";

        # Sink to be used, if it exists (find using `pacmd list-sinks`, name field)
        # If not, uses default sink
        sink = "default";

        # Use PA_VOLUME_UI_MAX (~153%) if true, or PA_VOLUME_NORM (100%) if false
        # Default: true
        use-ui-max = true;

        # Interval for volume increase/decrease (in percent points)
        # Default: 5
        interval = 5;

        # Available tags:
        #   <label-volume> (default)
        #   <ramp-volume>
        #   <bar-volume>
        format-volume = "<ramp-volume> <label-volume>";

        # Available tags:
        #   <label-muted> (default)
        #   <ramp-volume>
        #   <bar-volume>
        #format-muted = <label-muted>

        # Available tokens:
        #   %percentage% (default)
        #label-volume = %percentage%%

        # Available tokens:
        #   %percentage% (default)
        label-muted = " Muted";
        label-muted-foreground = "#666";

        # Only applies if <ramp-volume> is used
        ramp-volume-0 = "";
        ramp-volume-1 = "";
        ramp-volume-2 = "";
        ramp-volume-3 = "";
        ramp-volume-4 = "";
      };
      "module/launcher" = {
        type = "custom/text";
        content = "";

        content-background = "${color.ac}";
        content-foreground = "${color.mf}";
        content-padding = 3;

        click-left = "rofi -modi run,drun -show drun -location 1 -xoffset 14 -yoffset 52 -line-padding 4 -columns 1 -width 20 -lines 10 -padding 25 -hide-scrollbar -show-icons -drun-icon-theme";
      };
      "module/sysmenu" = {
        type = "custom/text";
        content = "";

        content-background = "${color.ac}";
        content-foreground = "${color.mf}";
        content-padding = 3;

        click-left = "powermenu";
      };
      "module/i3" = {
        type = "internal/i3";

        # Only show workspaces defined on the same output as the bar
        # 
        # Useful if you want to show monitor specific workspaces
        # on different bars
        #   
        # Default: false
        pin-workspaces = true;

        # This will split the workspace name on ':'
        # Default: false
        ##strip-wsnumbers = true

        # Sort the workspaces by index instead of the default
        # sorting that groups the workspaces by output
        # Default: false
        ##index-sort = true

        # Create click handler used to focus workspace
        # Default: true
        ##enable-click = false

        # Create scroll handlers used to cycle workspaces
        # Default: true
        ##enable-scroll = false

        # Wrap around when reaching the first/last workspace
        # Default: true
        ##wrapping-scroll = false

        # Set the scroll cycle direction
        # Default: true
        ##reverse-scroll = false

        # Use fuzzy (partial) matching on labels when assigning
        # icons to workspaces
        # Example: code#♚ will apply the icon to all workspaces
        # containing 'code' in the label
        # Default: false
        ##fuzzy-match = true

        # ws-icon-[0-9]+ = label;icon
        # NOTE: The label needs to match the name of the i3 workspace
        ##ws-icon-0 = 1;♚
        ##ws-icon-1 = 2;♛
        ##ws-icon-2 = 3;♜
        ##ws-icon-3 = 4;♝
        ##ws-icon-4 = 5;♞
        ##ws-icon-default = ♟
        # NOTE: You cannot skip icons, e.g. to get a ws-icon-6
        #; you must also define a ws-icon-5.

        # Available tags:
        #   <label-state> (default) - gets replaced with <label-(focused|unfocused|visible|urgent)>
        #   <label-mode> (default)
        # format = <label-state> <label-mode>

        # Available tokens:
        #   %mode%
        # Default: %mode%
        # label-mode = %mode%
        # label-mode-padding = 2
        # label-mode-background = #e60053

        # Available tokens:
        #   %name%
        #   %icon%
        #   %index%
        #   %output%
        # Default: %icon%  %name%
        label-focused = "%index%";
        label-focused-foreground = "#ffffff";
        label-focused-background = "#3f3f3f";
        label-focused-underline = "#fba922";
        label-focused-padding = 4;

        # Available tokens:
        #   %name%
        #   %icon%
        #   %index%
        #   %output%
        # Default: %icon%  %name%
        label-unfocused = "%index%";
        label-unfocused-padding = 4;

        # Available tokens:
        #   %name%
        #   %icon%
        #   %index%
        #   %output%
        # Default: %icon%  %name%
        label-visible = "%index%";
        label-visible-underline = "#555555";
        label-visible-padding = 4;

        # Available tokens:
        #   %name%
        #   %icon%
        #   %index%
        #   %output%
        # Default: %icon%  %name%
        label-urgent = "%index%";
        label-urgent-foreground = "#000000";
        label-urgent-background = "#bd2c40";
        label-urgent-padding = 4;

        # Separator in between workspaces
        label-separator = "|";
        label-separator-padding = 2;
        label-separator-foreground = "#ffb52a";
      };
      "module/battery" = {
        type = "internal/battery";

        # This is useful in case the battery never reports 100% charge
        full-at = 99;

        # Use the following command to list batteries and adapters:
        # $ ls -1 /sys/class/power_supply/
        battery = "BAT0";
        adapter = "AC";

        # If an inotify event haven't been reported in this many
        # seconds, manually poll for new values.
        #
        # Needed as a fallback for systems that don't report events
        # on sysfs/procfs.
        #
        # Disable polling by setting the interval to 0.
        #
        # Default: 5
        poll-interval = 2;

        # see "man date" for details on how to format the time string
        # NOTE: if you want to use syntax tags here you need to use %%{...}
        # Default: %H:%M:%S
        time-format = "%H:%M";

        # Available tags:
        #   <label-charging> (default)
        #   <bar-capacity>
        #   <ramp-capacity>
        #   <animation-charging>
        format-charging = "<animation-charging> <label-charging>";
        # Available tags:
        #   <label-discharging> (default)
        #   <bar-capacity>
        #   <ramp-capacity>
        #   <animation-discharging>
        format-discharging = "<ramp-capacity> <label-discharging>";

        # Available tags:
        #   <label-full> (default)
        #   <bar-capacity>
        #   <ramp-capacity>
        #format-full = <ramp-capacity> <label-full>

        # Available tokens:
        #   %percentage% (default)
        #   %time%
        #   %consumption% (shows current charge rate in watts)

        label-charging = "%percentage%%";

        # Available tokens:
        #   %percentage% (default)
        #   %time%
        #   %consumption% (shows current discharge rate in watts)
        label-discharging = "%percentage%%";

        # Available tokens:
        #   %percentage% (default)
        label-full = "Fully Charged";

        # Only applies if <ramp-capacity> is used
        ramp-capacity-0 = "";
        ramp-capacity-1 = "";
        ramp-capacity-2 = "";
        ramp-capacity-3 = "";
        ramp-capacity-4 = "";
        ramp-capacity-5 = "";
        ramp-capacity-6 = "";
        ramp-capacity-7 = "";
        ramp-capacity-8 = "";
        ramp-capacity-9 = "";

        # Only applies if <bar-capacity> is used
        #bar-capacity-width = 10

        # Only applies if <animation-charging> is used
        animation-charging-0 = "";
        animation-charging-1 = "";
        animation-charging-2 = "";
        animation-charging-3 = "";
        animation-charging-4 = "";
        animation-charging-5 = "";
        animation-charging-6 = "";
        animation-charging-7 = "";
        animation-charging-8 = "";

        # Framerate in milliseconds
        animation-charging-framerate = 750;

        # Only applies if <animation-discharging> is used
        #;animation-discharging-0 = 
        #;animation-discharging-1 = 
        #;animation-discharging-2 = 
        #;animation-discharging-3 = 
        #;animation-discharging-4 = 
        #;animation-discharging-5 = 
        #;animation-discharging-6 = 
        #;animation-discharging-7 = 
        #;animation-discharging-8 = 

        # Framerate in milliseconds
        #animation-discharging-framerate = 500

        #; Other Icons
        #					
        #
        #	
        #
        #
      };
      "module/backlight" = {
        type = "internal/backlight";

        # Use the following command to list available cards:
        # $ ls -1 /sys/class/backlight/
        card = "intel_backlight";

        # Available tags:
        #   <label> (default)
        #   <ramp>
        #   <bar>#
        format = "<ramp> <label>";

        # Available tokens:
        #   %percentage% (default)
        label = "%percentage%%";

        # Only applies if <ramp> is used

        ramp-0 = "";
        ramp-1 = "";
        ramp-2 = "";
        ramp-3 = "";
        ramp-4 = "";

        #; Other Icons
        #

        # Only applies if <bar> is used
        # bar-width = 10
        # bar-indicator = |
        # bar-fill = ─
        # bar-empty = ─
      };
      "settings" = {
        throttle-output = 5;
        throttle-output-for = 10;
        throttle-input-for = 30;
        
        screenchange-reload = true;

        compositing-background = "source";
        compositing-foreground = "over";
        compositing-overline = "over";
        compositing-underline = "over";
        compositing-border = "over";

        pseudo-transparency = false;
      };
    };
    script = ''
      echo "Main Monitor: ${mainMonitor}"
      MONITOR=${mainMonitor} polybar -c ''${HOME}/.config/polybar/config ${hostName} &

      # Launch bar1 and bar2
      for m in $(${pkgs.xorg.xrandr}/bin/xrandr --query | ${pkgs.gnugrep}/bin/grep " connected" | ${pkgs.coreutils}/bin/cut -d" " -f1 | ${pkgs.gnugrep}/bin/grep -v ${mainMonitor}); do
        MONITOR=$m polybar -c ''${HOME}/.config/polybar/config secondary &
      done
    '';
  };
}
