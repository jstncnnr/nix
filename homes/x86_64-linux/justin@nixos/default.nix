{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # TODO: snowfall-lib automatically applies every home-manager module
    # to every home. How can we define shared config between homes?
    # inputs.self.homeModules.justin
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
