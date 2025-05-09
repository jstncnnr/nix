{ pkgs, config, inputs, ... }:

{
  imports = [
    inputs.self.homeModules.justin
  ];

  home.packages = [
  ];

  programs.ssh.extraConfig = ''
    IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
  '';

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  # Ghostty 1.1.3 is marked as broken for darwin
  # so we install it through homebrew
  programs.ghostty.package = null;

  home.stateVersion = "24.11";
}
