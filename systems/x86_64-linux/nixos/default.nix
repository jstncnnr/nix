{
  pkgs,
  lib,
  inputs,
  config,
  system,
  ...
}: {
  imports = [
    inputs.determinate.nixosModules.default

    ./hardware-configuration.nix
  ];

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  system.stateVersion = "25.05";
  networking.networkmanager.enable = true;

  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  users.users.justin = {
    description = "Justin Conner";
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  # 1Password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = lib.mapAttrsToList (name: _: name) config.users.users;
  };

  systemd.user.services."1password" = {
    enable = true;
    description = "1Password auto start";

    serviceConfig = {
      ExecStart = "${pkgs._1password-gui}/bin/1password --silent";
      RemainAfterExit = true;
    };

    after = ["graphical-session.target"];
    wantedBy = ["graphical-session.target"];
  };

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # Enable printing and set a default
  services.printing.enable = true;
  hardware.printers.ensurePrinters = [
    {
      name = "Check-Printer";
      location = "Office";
      description = "HP LaserJet M406";
      deviceUri = "ipp://192.168.1.65:631/ipp";
      model = "everywhere";
    }
  ];
  hardware.printers.ensureDefaultPrinter = "Check-Printer";

  # Fonts
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    inputs.self.packages.${system}.gnumicr
  ];
}
