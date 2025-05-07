{ lib, config, ... }:
let
  cfg = config.system;
in
{
  options = {
    # TODO: Add support for grub, refind, etc.
    system.boot-loader = lib.mkOption {
      type = lib.types.enum [ "systemd-boot" ];
      default = "systemd-boot";
      description = "The bootloader to use";
    };
  };

  config = {
    boot.loader.efi.canTouchEfiVariables = true;

    boot.loader.systemd-boot = lib.mkIf (cfg.boot-loader == "systemd-boot") {
      enable = true;
      configurationLimit = 10;
    };
  };
}
