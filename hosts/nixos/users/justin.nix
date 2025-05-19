{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.self.homeModules.justin

    inputs.self.homeModules.hyprland
    inputs.self.homeModules.waybar
    inputs.self.homeModules.hypridle
    inputs.self.homeModules.hyprlock
  ];

  home.stateVersion = "24.11";
  home.packages = [
    pkgs.brave
    pkgs.citrix_workspace
    pkgs.devenv
    pkgs.ghostty
    pkgs.prismlauncher
  ];

  programs.ssh.extraConfig = ''
    IdentityAgent "~/.1password/agent.sock"
  '';

  # Hyprland config
  programs.wofi.enable = true;
  services = {
    swaync.enable = true;
    hyprpolkitagent.enable = true;
    cliphist.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      monitor = [
        "desc:Microstep MPG341CX OLED, 3440x1440@165, 0x0, 1, vrr, 2"
      ];

      bind = [
        "SUPER, Return, exec, uwsm app -- ghostty"
        "SUPER, Space, exec, uwsm app -- $(wofi --show drun --define=drun-print_desktop_file=true)"
        "SUPER, E, exec, uwsm app -- nautilus"
        "SUPER, B, exec, uwsm app -- brave"
        ", PRINT, exec, hyprshot -m region --clipboard-only"

        "SUPER, S, togglespecialworkspace, magic"
        "SUPER SHIFT, S, movetoworkspacesilent, special:magic"

        "SUPER SHIFT, Q, exec, hyprlock"
      ];
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
  };

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
}
