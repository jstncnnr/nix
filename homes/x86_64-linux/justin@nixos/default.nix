{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.self.sharedHomeModules.justin
  ];

  home.stateVersion = "24.11";

  home.packages = [
    pkgs.brave
    pkgs.citrix_workspace
    pkgs.devenv
    pkgs.ghostty
    pkgs.prismlauncher
  ];

  programs.ssh.extraConfig = ''
    IdentityAgent "~/.1password/agent.sock"
  '';
}
