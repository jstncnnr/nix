{
  lib,
  config,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
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

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/f30ef7de-d931-4caa-bff2-9af035acdac3";
    fsType = "btrfs";
    options = ["subvol=@" "compress=zstd"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/f30ef7de-d931-4caa-bff2-9af035acdac3";
    fsType = "btrfs";
    options = ["subvol=@home" "compress=zstd"];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/f30ef7de-d931-4caa-bff2-9af035acdac3";
    fsType = "btrfs";
    options = ["subvol=@nix" "compress=zstd" "noatime"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/11B2-23E9";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

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
