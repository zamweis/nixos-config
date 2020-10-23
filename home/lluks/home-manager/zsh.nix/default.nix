{ pkgs, ... }:

let
  relativeXDGConfigPath = ".config";
  relativeXDGDataPath = ".local/share";
  relativeXDGCachePath = ".cache";
in
{
  programs.zsh = {
    enable = true;

    autocd = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    defaultKeymap = "emacs";
    initExtraBeforeCompInit = ''
      # gpg-agent --daemon >/dev/null 2>&1

      # Functions (Complex aliases)
      function powermenu {
        MENU="$(rofi -sep "|" -dmenu -i -p 'System' -location 3 -xoffset -14 -yoffset 52 -width 10 -hide-scrollbar -line-padding 4 -padding 20 -lines 4 <<< " Lock| Logout| Reboot| Shutdown")"
        case "$MENU" in
            *Lock) i3lock-fancy ;;
            *Logout) openbox --exit;;
            *Reboot) systemctl reboot ;;
            *Shutdown) systemctl -i poweroff
        esac
      }
    '';
    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      cj-shell = "nix-shell /config/home/vincentcui/development/campusjaeger/sams.nix";
    };
    history = {
      path = "${relativeXDGDataPath}/zsh/.zsh_history";
      size = 50000;
      save = 50000;
    };

    oh-my-zsh = {
      enable = true;

      plugins = [
        "git"
      ];
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = pkgs.lib.cleanSource ./p10k-config;
        file = "p10k.zsh";
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.1.0";
          sha256 = "0snhch9hfy83d4amkyxx33izvkhbwmindy0zjjk28hih1a9l2jmx";
        };
      }
      {
        name = "nix-zsh-completions";
        file = "nix-zsh-completions.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "spwhitt";
          repo = "nix-zsh-completions";
          rev = "0.4.4";
          sha256 = "1n9whlys95k4wc57cnz3n07p7zpkv796qkmn68a50ygkx6h3afqf";
        };
      }
    ];
  };
}