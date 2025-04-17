{ lib, config, pkgs, ... }:

{
  options = {
    programs.ghostty.enable = lib.mkEnableOption "Ghostty Terminal Emulator";
  };

  config = {
    environment.systemPackages = []
      ++ lib.optionals config.programs.ghostty.enable [pkgs.ghostty];
  };
}
