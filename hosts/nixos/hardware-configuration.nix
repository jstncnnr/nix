{
  lib,
  config,
  modulesPath,
  inputs,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    inputs.disko.nixosModules.disko
    ./disko-configuration.nix
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];

  boot.initrd.kernelModules = [
  ];

  boot.kernelModules = [
    "kvm-amd"
  ];

  boot.extraModulePackages = [
  ];

  swapDevices = [
  ];

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [
      "/"
      "/home"
    ];
  };

  networking.useDHCP = lib.mkDefault true;
  hardware.bluetooth.enable = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
