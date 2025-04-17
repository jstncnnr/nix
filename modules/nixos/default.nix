{
  imports = [
    ./desktops
    ./programs
    ./system

    ./home-manager.nix
  ];

  config = {
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };

    nix.settings.auto-optimise-store = true;
    services.flatpak.enable = true;
  };
}
