{ lib, config, pkgs, ... }:

{
  options = {
    desktops.gnome.enable = lib.mkEnableOption "GNOME Desktop Environment";
  };

  config = lib.mkIf config.desktops.gnome.enable {
    services.xserver = {
      enable = true;

      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    environment.gnome.excludePackages = [
      pkgs.geary
      pkgs.gnome-calendar
      pkgs.gnome-contacts
      pkgs.gnome-weather
      pkgs.gnome-clocks
      pkgs.gnome-maps
    ];

    environment.systemPackages = [
      pkgs.gnomeExtensions.appindicator
      pkgs.gnomeExtensions.no-overview
      pkgs.gnomeExtensions.notification-banner-position
      pkgs.gnomeExtensions.sleep-through-notifications
      pkgs.gnomeExtensions.window-is-ready-remover
    ];

    services.udev.packages = [
      pkgs.gnome-settings-daemon
    ];

    xdg.portal = {
      enable = true;

      extraPortals = [
        pkgs.xdg-desktop-portal-gnome
      ];
    };
  };
}
