{
  lib,
  osConfig,
  ...
}: {
  dconf.settings = lib.mkIf (osConfig.system.desktopEnvironment == "gnome") {
    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      clock-show-weekday = true;
      color-scheme = "default";
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };

    "org/gnome/desktop/wm/keybindings" = {
      move-to-workspace-1 = ["<Super><Shift>1"];
      move-to-workspace-2 = ["<Super><Shift>2"];
      move-to-workspace-3 = ["<Super><Shift>3"];
      move-to-workspace-4 = ["<Super><Shift>4"];
      move-to-workspace-5 = ["<Super><Shift>5"];
      move-to-workspace-6 = ["<Super><Shift>6"];

      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-workspace-5 = ["<Super>5"];
      switch-to-workspace-6 = ["<Super>6"];
    };

    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 6;
    };

    "org/gnome/mutter" = {
      edge-tiling = true;
    };

    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "interactive";
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/shell" = {
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "blur-my-shell@aunetx"
        "just-perfection-desktop@just-perfection"
        "no-overview@fthx"
        "space-bar@luchrioh"
      ];
    };

    "org/gnome/shell/extensions/just-perfection" = {
      animation = 2;
      startup-status = 0;
    };

    "org/gnome/shell/extensions/space-bar/behavior" = {
      enable-custom-label = false;
      indicator-style = "workspaces-bar";
      smart-workspace-names = false;
    };

    "org/gnome/shell/extensions/space-bar/shortcuts" = {
      enable-move-to-workspace-shortcuts = true;
    };
  };
}
