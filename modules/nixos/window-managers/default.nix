{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.programs.hyprland.enable {
    programs.hyprland.withUWSM = lib.mkDefault true;

    environment.systemPackages = [
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
  };
}
