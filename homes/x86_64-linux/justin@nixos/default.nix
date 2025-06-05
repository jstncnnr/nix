{pkgs, ...}: {
  home.stateVersion = "25.05";
  home.packages = [
    pkgs.brave
    pkgs.citrix_workspace
    pkgs.devenv
    pkgs.jetbrains-toolbox
  ];

  programs.git = {
    enable = true;
    userName = "Justin Conner";
    userEmail = "jstncnnr@outlook.com";
  };

  programs.go = {
    enable = true;
    goPath = ".local/go";
    goBin = ".local/go/bin";
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      IdentityAgent "~/.1password/agent.sock"
    '';
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      font-family = "MesloLGS Nerd Font Mono";
      font-size = 12;
      background-opacity = 0.8;
      background-blur = 8;
      window-theme = "system";
      macos-titlebar-style = "native";
    };
  };
}
