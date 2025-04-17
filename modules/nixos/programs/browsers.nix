{ lib, config, pkgs, ... }:

{
  options = {
    programs.brave.enable = lib.mkEnableOption "Brave Browser";
  };

  config = {
    environment.systemPackages = []
      ++ lib.optionals config.programs.brave.enable [pkgs.brave];
  };
}
