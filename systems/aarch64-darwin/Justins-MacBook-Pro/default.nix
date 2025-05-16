{ pkgs, ... }: {
  imports = [
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

   nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    optimise.automatic = true;
    gc = {
      automatic = true;
      options = "--delete-older-than 1w";
    };
  };

  system = {
    patches = [
      (pkgs.writeText "etc-synthetic.conf.patch" ''
        --- a/etc/synthetic.conf
        +++ b/etc/synthetic.conf
        @@ -1,2 +1,4 @@
         nix
         run	private/var/run
        +M3	Users/justin/M3
        +M3 Scans	Users/justin/M3 Scans
      '')
    ];

    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        AppleShowScrollBars = "Always";
        NSDocumentSaveNewDocumentsToCloud = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.swipescrolldirection" = false;
      };

      controlcenter.BatteryShowPercentage = true;

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

      screencapture.target = "clipboard";

      trackpad.Clicking = true;
    };

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 6;
  };

  environment.systemPackages = [
    pkgs.neovim
  ];

  homebrew = {
    enable = true;

    brews = [
      "oh-my-posh"
      "podman"
    ];

    casks = [
      "1password"
      "brave-browser"
      "discord"
      "ghostty"
      "jetbrains-toolbox"
      "podman-desktop"
      "zoom"
    ];

    masApps = {
      Magnet = 441258766;
    };
  };

  users.users.justin = {
    description = "Justin";
    home = "/Users/justin";
    shell = pkgs.zsh;
  };
}
