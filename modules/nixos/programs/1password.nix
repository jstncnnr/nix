{ lib, pkgs, usernames, ... }:

{
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = usernames;
  };

  systemd.user.services."1password" = {
    enable = true;
    description = "1Password daemon";

    after = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    
    serviceConfig = {
      ExecStart = "${pkgs._1password-gui}/bin/1password --silent";
      RemainAfterExit = true;
    };
  };
}
