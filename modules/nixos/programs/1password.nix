{ lib, config, pkgs, ... }:
let
  cfg = config.programs;
in
{
  config = lib.mkIf cfg._1password.enable {
    programs._1password-gui.enable = true;
    programs._1password-gui.polkitPolicyOwners = lib.mapAttrsToList (name: _: name) config.users.users;

    systemd.user.services."1password" = {
      enable = true;
      description = "1Password auto start";

      serviceConfig = {
        ExecStart = "${pkgs._1password-gui}/bin/1password --silent";
	RemainAfterExit = true;
      };

      after = [
        "graphical-session.target"
      ];

      wantedBy = [
        "graphical-session.target"
      ];
    };
  };
}
