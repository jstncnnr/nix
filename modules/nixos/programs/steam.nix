{ lib, config, ... }:

{
  programs.steam = lib.mkIf config.programs.steam.enable {
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
