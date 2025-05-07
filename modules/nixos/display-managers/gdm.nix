{ lib, config, ... }:
let
  cfg = config.system;
in
{
  config = lib.mkIf (cfg.displayManager == "gdm") {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
  };
}
