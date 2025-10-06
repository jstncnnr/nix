{
  lib,
  pkgs,
  ...
}: {
  imports = [
  ];

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
  };

  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;

  systemd.services.ensure-flathub = {
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = "flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo";
  };

  security.rtkit.enable = lib.mkDefault true;
  services.pipewire = {
    enable = lib.mkDefault true;
    alsa.enable = lib.mkDefault true;
    alsa.support32Bit = lib.mkDefault true;
    pulse.enable = lib.mkDefault true;
    jack.enable = lib.mkDefault true;
  };

  boot.loader = {
    efi.canTouchEfiVariables = lib.mkDefault true;
    systemd-boot = {
      enable = lib.mkDefault true;
      configurationLimit = lib.mkDefault 10;
    };
  };
}
