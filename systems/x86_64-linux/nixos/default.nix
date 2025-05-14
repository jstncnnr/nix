{
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Setup some defaults
  networking.networkmanager.enable = true;
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  system.stateVersion = "24.11";

  # Defined in modules/nixos/common/boot.nix
  system.boot-loader = "systemd-boot";

  # Defined in modules/nixos/common/audio.nix
  system.audio.engine = "pipewire";

  # Defined in modules/nixos/displayManager
  system.displayManager = "gdm";

  # Defined in modules/nixos/desktopEnvironment
  system.desktopEnvironment = "gnome";

  # Setup user accounts
  users.users.justin = {
    description = "Justin";
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  # Required when user.shell = pkgs.zsh
  programs.zsh.enable = true;

  # Some additional setup defined in
  # modules/nixos/programs/1password.nix
  programs._1password.enable = true;

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

  # Remove some unused gnome packages
  environment.gnome.excludePackages = [
    pkgs.geary
    pkgs.gnome-calendar
    pkgs.gnome-contacts
    pkgs.gnome-weather
    pkgs.gnome-clocks
    pkgs.gnome-maps
  ];
}
