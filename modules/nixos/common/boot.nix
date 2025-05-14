{
  lib,
  config,
  ...
}: let
  cfg = config.system;
in {
  options = {
    # TODO: Add support for grub, refind, etc.
    system.boot-loader = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum ["systemd-boot"]);
      default = null;
      description = "The bootloader to use";
    };
  };

  config = {
    boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;

    boot.loader.systemd-boot = lib.mkIf (cfg.boot-loader == "systemd-boot") {
      enable = true;
      configurationLimit = 10;
    };
  };
}
