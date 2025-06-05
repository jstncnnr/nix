{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.services.xserver.desktopManager.gnome.enable {
    environment.systemPackages = [
      pkgs.gnomeExtensions.appindicator
      pkgs.gnomeExtensions.blur-my-shell
      pkgs.gnomeExtensions.dash-to-dock
      pkgs.gnomeExtensions.just-perfection
      pkgs.gnomeExtensions.open-bar
      pkgs.gnomeExtensions.rounded-window-corners-reborn
      pkgs.gnomeExtensions.tiling-shell
    ];
  };
}
