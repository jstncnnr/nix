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

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/9f43b781-a168-47a4-b9af-d8b41f7832f7";
    fsType = "btrfs";
    options = [
      "compress=zstd"
      "subvol=@root"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/4784c9ce-4984-498b-aaa2-31ef799ce9b2";
    fsType = "btrfs";
    options = [
      "compress=zstd"
      "subvol=@home"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/9f43b781-a168-47a4-b9af-d8b41f7832f7";
    fsType = "btrfs";
    options = [
      "compress=zstd"
      "subvol=@nix"
      "noatime"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2CEE-0896";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

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
