{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.programs.hyprland.enable {
    programs.hyprland.withUWSM = lib.mkDefault true;

    environment.systemPackages = [
      pkgs.adwaita-icon-theme
      pkgs.ghostty
      pkgs.hypridle
      pkgs.hyprlock
      pkgs.hyprpaper
      pkgs.hyprpolkitagent
      pkgs.hyprshot
      pkgs.nautilus
      pkgs.pavucontrol
      pkgs.playerctl
      pkgs.wofi
    ];

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    programs.dconf.profiles.user.databases = [
      {
        settings."org/gnome/desktop/interface" = {
          gtk-theme = "Adwaita";
          icon-theme = "Adwaita";
          cursor-theme = "Adwaita";
        };
      }
    ];
  };
}
