{
  pkgs,
  inputs,
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
}
