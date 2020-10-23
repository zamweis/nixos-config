{ pkgs, ... }:
{
  services.dunst = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };
    settings = {
      global = {
        markup = "full";
        plain_text = "no";
        format = "<b>%s</b>\n%b\n%p";
        sort = "yes";
        indicate_hidden = "yes";
        alignment = "center";
        geometry = "300x25-11+38";
        bounce_freq = 0;
        show_age_threshold = 60;
        word_wrap = "yes";
        ignore_newline = "no";
        shrink = false;
        transparency = 10;
        idle_threshold = 0;
        monitor = 0;
        follow = "mouse";
        sticky_history = "yes";
        history_length = 20;
        show_indicators = "yes";
        line_height = 8;
        notification_height = 30;
        separator_height = 2;
        padding = 20;
        horizontal_padding = 20;
        separator_color = "auto";
        font = "Ubuntu 12";
        frame_width = 1;
        frame_color = "#6b7a85";
        icon_position = "left";
      };

      shortcuts = {
        close = "ctrl+space";
        close_all = "ctrl+shift+space";
        history = "ctrl+grave";
        context = "ctrl+shift+period";
      };

      urgency_low = {
        # IMPORTANT: colors have to be defined in quotation marks.
        # Otherwise the "#" and following would be interpreted as a comment.
        background = "#23262f";
        foreground = "#ffffff";
        timeout = 10;
      };

      urgency_normal = {
        background = "#23262f";
        foreground = "#ffffff";
        timeout = 10;
      };

      urgency_critical = {
        background = "#23262f";
        foreground = "#ffffff";
        frame_color = "#c5241a";
        timeout = 0;
      };
    };
  };
}