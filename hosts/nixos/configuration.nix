{
  lib,
  config,
  inputs,
  pkgs,
  perSystem,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    inputs.stylix.nixosModules.stylix

    inputs.self.nixosModules.core
    inputs.self.nixosModules.sddm
    inputs.self.nixosModules.hyprland
  ];

  # Set some defaults
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  system.stateVersion = "24.11";
  networking.networkmanager.enable = true;

  # Setup user accounts
  sops.secrets."users/justin/password".neededForUsers = true;
  users.users.justin = {
    description = "Justin";
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
    hashedPasswordFile = config.sops.secrets."users/justin/password".path;
  };

  # Required when user.shell = pkgs.zsh
  programs.zsh.enable = true;

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

  # Setup sshd
  services.openssh.enable = true;
  services.openssh.openFirewall = true;

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

  #Stylix
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    image = ../../share/wallpaper.png;
  };

  # Fonts
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono

    perSystem.self.gnumicr
  ];
}
