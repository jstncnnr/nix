{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.self.homeModules.nvf
  ];

  fonts.fontconfig.enable = true;
  home.packages = [
    pkgs.nerd-fonts.meslo-lg
  ];

  programs = {
    git = {
      enable = true;
      userName = "Justin Conner";
      userEmail = "jstncnnr@outlook.com";
    };

    ssh.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;

      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    ghostty = {
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

    direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    go = {
      enable = true;
      goPath = ".local/go";
      goBin = ".local/go/bin";
    };
  };
}
