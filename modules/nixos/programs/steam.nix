{ lib, config, ... }:
let
  cfg = config.programs.steam;
in
{
  config = lib.mkIf cfg.enable {
    programs.steam = {
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
