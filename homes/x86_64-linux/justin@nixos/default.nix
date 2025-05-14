{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.self.homeModules.justin
  ];

  home.stateVersion = "24.11";

  home.packages = [
    pkgs.brave
    pkgs.citrix_workspace
    pkgs.devenv
    pkgs.ghostty
    pkgs.neovim
    pkgs.prismlauncher
  ];

  programs.ssh.extraConfig = ''
    IdentityAgent "~/.1password/agent.sock"
  '';
}
