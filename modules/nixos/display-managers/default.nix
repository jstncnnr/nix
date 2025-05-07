{ lib, ... }:

{
  imports = [
    ./gdm.nix
  ];

  options = {
    system.displayManager = lib.mkOption {
      type = lib.types.enum [ "gdm" ];
      default = "gdm";
      description = "The display manager to use";
    };
  };
}
