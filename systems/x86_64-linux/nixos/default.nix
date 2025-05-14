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

  # Setup user accounts
  users.users.justin = {
    description = "Justin";
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

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

  # Setup gdm
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  # Setup gnome
  services.xserver.desktopManager.gnome.enable = true;

  services.udev.packages = [
    pkgs.gnome-settings-daemon
  ];

  environment.gnome.excludePackages = [
    pkgs.geary
    pkgs.gnome-calendar
    pkgs.gnome-contacts
    pkgs.gnome-weather
    pkgs.gnome-clocks
    pkgs.gnome-maps
  ];
}
