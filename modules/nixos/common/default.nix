{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./audio.nix
    ./boot.nix
  ];

  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;

  systemd.services.ensure-flathub = {
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = "flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo";
  };

  nix.extraOptions = ''
    extra-substituters = https://devenv.cachix.org
    extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
  '';
}
