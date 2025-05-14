{ lib, config, ... }:
let
  cfg = config.system;
in {
  options = {
    system.displayManager = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum ["gdm" "sddm" "sddm-wayland"]);
      default = null;
      description = "The display manager to use.";
    };
  };

  config = lib.mkIf (cfg.displayManager != null) {
    services.xserver.enable = lib.mkDefault true;
    services.xserver.displayManager.gdm.enable = lib.mkDefault (cfg.displayManager == "gdm");
    services.displayManager.sddm.enable = lib.mkDefault (cfg.displayManager == "sddm" || cfg.displayManager == "sddm-wayland");
    services.displayManager.sddm.wayland.enable = lib.mkDefault (cfg.displayManager == "sddm-wayland");
  };
}
