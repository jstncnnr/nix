{ pkgs, ... }:

{
  home.packages = [
    pkgs.gh
    pkgs.jetbrains-toolbox
  ];

  programs.git = {
    enable = true;
    userName = "Justin Conner";
    userEmail = "jstncnnr@outlook.com";
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      IdentityAgent ~/.1password/agent.sock
    '';
  };
}
