{ lib, config, pkgs, ... }:
let
  cfg = config.system;
in
{
  config = lib.mkIf (cfg.desktopEnvironment == "gnome") {
    services.xserver.desktopManager.gnome.enable = true;

    services.udev.packages = [
      pkgs.gnome-settings-daemon
    ];

    qt = {
      enable = true;
      platformTheme = "gnome";
      style = "adwaita";
    };
  };
}
