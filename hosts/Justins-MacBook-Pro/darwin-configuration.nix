{ inputs, pkgs, ... }:

{
  imports = [

  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 1w";
  };

  system.patches = [
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

  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  system.defaults.NSGlobalDomain.AppleShowScrollBars = "Always";
  system.defaults.NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
  system.defaults.NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;

  system.defaults.controlcenter.BatteryShowPercentage = true;

  system.defaults.dock.persistent-apps = [
    { app = "/System/Applications/Launchpad.app"; }
    { app = "/Applications/Brave Browser.app"; }
    { app = "/Applications/Ghostty.app"; }
    { app = "/System/Applications/System Settings.app"; }
  ];

  system.defaults.dock.persistent-others = [];
  system.defaults.dock.show-recents = false;

  system.defaults.dock.wvous-bl-corner = 1;
  system.defaults.dock.wvous-br-corner = 1;
  system.defaults.dock.wvous-tl-corner = 1;
  system.defaults.dock.wvous-tr-corner = 1;

  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.CreateDesktop = false;
  system.defaults.finder.FXPreferredViewStyle = "Nlsv";
  system.defaults.finder.NewWindowTarget = "Home";
  
  system.defaults.screencapture.target = "clipboard";

  system.defaults.trackpad.Clicking = true;

  users.users.justin = {
    description = "Justin";
    home = "/Users/justin";
    shell = pkgs.zsh;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
