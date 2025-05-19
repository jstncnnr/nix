{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      main = {
        layer = "top";
        position = "top";
        modules-left = [
          "hyprland/workspaces"
        ];

        modules-center = [
          "hyprland/window"
        ];

        modules-right = [
          "tray"
          "pulseaudio#output"
          "pulseaudio#input"
          "clock"
          "custom/notifications"
          "custom/power"
        ];

        "hyprland/workspaces" = {
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "󰖟";
            "3" = "";
            "4" = "";
            "5" = "";
            "6" = "";
          };
          persistent-workspaces = {
            "*" = 6;
          };
          on-scroll-up = "hyprctl dispatch workspace e-1";
          on-scroll-down = "hyprctl dispatch workspace e+1";
        };

        "tray" = {
          icon-size = 16;
          spacing = 8;
          show-passive-items = true;
        };

        "pulseaudio#output" = {
          format = "{icon}  {volume}%";
          format-muted = "{icon}";
          format-bluetooth = "{icon}  {volume}%";
          format-bluetooth-muted = "{icon}";
          format-icons = {
            headphone = "";
            headphone-muted = "󰟎";
            hands-free = "󰋎";
            hands-free-muted = "󰋐";
            headset = "󰋎";
            headset-muted = "󰋐";
            phone = "";
            phone-muted = "󰷯";
            portable = "󰄜 ";
            portable-muted = "󰥐";
            default = ["" "" ""];
            default-muted = "";
          };

          on-click = "uwsm app -- pavucontrol";
          min-length = 4;
        };

        "pulseaudio#input" = {
          format = "{format_source}";
          format-muted = "{format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          on-click = "uwsm app -- pavucontrol";
          min-length = 4;
        };

        "clock" = {
          format = "{:%I:%M %p}";
          format-alt = "{:%m-%d-%Y}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            week-pos = "";
            on-scroll = 1;
            format = {
              months = "<span color='#5e81ac'><b>{}</b></span>";
              days = "<span color='#eceff4'><b>{}</b></span>";
              weekdays = "<span color='#eceff4'><b>{}</b></span>";
              today = "<span color='#bf616a'><b><u>{}</u></b></span>";
            };
            actions = {
              on-click-right = "mode";
              on-scroll-up = "shift_up";
              on-scroll-down = "shift_down";
            };
          };
        };

        "custom/notifications" = {
          format = "{icon}";
          tooltip = false;
          format-icons = {
            notification = "<span foreground='@base08'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='@base08'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='@base08'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='@base08'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };
      };
    };

    style = ''
      * {
        font-size: 14px;
      }

      #workspaces * {
        font-family: MesloLGS Nerd Font Mono, monospace;
        font-size: 20px;
      }

      #workspaces button {
        border-radius: 0;
        border: none;
        transition: none;
      }

      #workspaces button.empty {
        color: @base04;
      }

      #workspaces button.active {
        color: @base0A;
        background: @base03;
        border: none;
      }

      #workspaces button.urgent {
        color: @base08;
      }

      #tray,
      #pulseaudio,
      #clock,
      #custom-notifications {
        color: @base05;
        margin-right: 8px;
      }

      #custom-notifications {
        font-family: MesloLGS Nerd Font Mono, monospace;
        font-size: 20px;
      }

      #pulseaudio.muted,
      #pulseaudio.source-muted {
        color: @base08;
      }
    '';
  };

  home.packages = [
    pkgs.pavucontrol
  ];
}
