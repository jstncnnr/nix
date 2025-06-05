{ pkgs, inputs, system, ... }: {
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # This machine uses Determinate Systems Nix
  # which handles the nix lifecycle with its own daemon.
  nix.enable = false;

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [
    pkgs.devenv
  ];  

  system.defaults = {
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      AppleShowScrollBars = "Always";
      NSDocumentSaveNewDocumentsToCloud = false;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.swipescrolldirection" = false;
    };

    controlcenter = {
      BatteryShowPercentage = true;
    };

    dock = {
      persistent-apps = [
        {app = "/System/Applications/Launchpad.app";}
	{app = "/Applications/Brave Browser.app";}
	{app = "/Applications/Ghostty.app";}
	{app = "/System/Applications/System Settings.app";}
      ];

      persistent-others = [];
      show-recents = false;

      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
    };

    finder = {
      AppleShowAllExtensions = true;
      CreateDesktop = false;
      FXPreferredViewStyle = "Nlsv";
      NewWindowTarget = "Home";
    };

    screencapture = {
      target = "clipboard";
    };

    trackpad = {
      Clicking = true;
    };
  };

  system.primaryUser = "justin";
  users.users.justin = {
    description = "Justin";
    home = "/Users/justin";
    shell = pkgs.zsh;
  };

  fonts.packages = [
    inputs.self.packages.${system}.gnumicr
  ];
}
