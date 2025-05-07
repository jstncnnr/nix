{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    inputs.self.nixosModules.common
    inputs.self.nixosModules.display-managers
    inputs.self.nixosModules.desktop-environments
    inputs.self.nixosModules.programs
  ];

  # Defined in modules/nixos/core/boot.nix
  system.boot-loader = "systemd-boot";

  # Defined in modules/nixos/core/audio.nix
  system.audio.engine = "pipewire";

  # Defined in modules/nixos/display-managers
  system.displayManager = "gdm";

  # Defined in modules/nixos/desktop-environments
  system.desktopEnvironment = "gnome";

  # Remove some default gnome apps
  environment.gnome.excludePackages = [
    pkgs.geary
    pkgs.gnome-calendar
    pkgs.gnome-contacts
    pkgs.gnome-weather
    pkgs.gnome-clocks
    pkgs.gnome-maps
  ];

  # Add some gnome extensions
  environment.systemPackages = [
    pkgs.gnomeExtensions.appindicator
    pkgs.gnomeExtensions.no-overview
    pkgs.gnomeExtensions.notification-banner-position
    pkgs.gnomeExtensions.window-is-ready-remover
  ];

  # Some extensions defined in
  # modules/nixos/programs/1password.nix
  programs._1password.enable = true;

  # Some extensions defined in
  # modules/nixos/programs/steam.nix
  programs.steam.enable = true;

  # Setup sshd
  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  # Enable printing and set the default
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

  # Setup some other defaults
  networking.networkmanager.enable = true;
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  system.stateVersion = "24.11";

  # Setup user accounts
  users.users = {
    justin = {
      description = "Justin";
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.zsh;
    };

    work = {
      description = "Work";
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.zsh;
    };
  };

  # Required if users.users.<name>.shell = pkgs.zsh
  programs.zsh.enable = true;
}
