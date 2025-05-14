{ lib, config, ... }:
let
  cfg = config.programs.steam;
in {
  config = lib.mkIf cfg.enable {
    programs.steam = {
      remotePlay.openFirewall = lib.mkDefault true;
      dedicatedServer.openFirewall = lib.mkDefault true;
      localNetworkGameTransfers.openFirewall = lib.mkDefault true;
    };
  };
}
