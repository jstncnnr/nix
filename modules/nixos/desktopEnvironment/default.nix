{ lib, config, pkgs, ... }:
let
  cfg = config.system;
in {
  options = {
    # We only allow one desktop environment to be active at a time.
    # This is mostly due to the tight integration with Gnome/GDM. 
    system.desktopEnvironment = lib.mkOption {
      # TODO: Add support for plasma, xfce, cinnamon, etc.
      type = lib.types.nullOr (lib.types.enum ["gnome"]);
      default = null;
      description = "The desktop environment to use.";
    };
  };

  config = lib.mkIf (cfg.desktopEnvironment != null) {
    # Is there any global config we can set no matter the DE?
  } // lib.mkIf (cfg.desktopEnvironment == "gnome") {
    services.xserver.desktopManager.gnome.enable = true;
    services.udev.packages = [
      pkgs.gnome-settings-daemon
    ];
  };
}
