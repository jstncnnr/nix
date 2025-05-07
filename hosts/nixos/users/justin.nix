{ pkgs, inputs, ... }:

{
  imports = [
    inputs.self.homeModules.justin
  ];

  home.packages = [
    pkgs.brave
    pkgs.citrix_workspace
    pkgs.devenv
    pkgs.ghostty
    pkgs.neovim
    pkgs.prismlauncher
  ];

  # Enable the 1Password ssh agent
  programs.ssh.extraConfig = ''
    IdentityAgent "~/.1password/agent.sock"
  '';

  home.stateVersion = "24.11";
}
