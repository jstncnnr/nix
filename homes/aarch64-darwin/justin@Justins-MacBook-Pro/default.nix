{
  home.stateVersion = "25.05";
  
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
      IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
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
    package = null; # Marked as broken in nixpkgs for darwin
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
