{ lib, config, modulesPath, ... }:

{
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

  boot.initrd.kernelModules = [];

  boot.kernelModules = [
    "kvm-amd"
  ];

  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/d3915b2c-d790-470d-a909-2ccbd51902a5";
    fsType = "btrfs";
    options = [
      "compress=zstd"
      "subvol=@root"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/c87fad23-710a-4098-bbe4-2b3e2b8a8ab8";
    fsType = "btrfs";
    options = [
      "compress=zstd"
      "subvol=@home"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/d3915b2c-d790-470d-a909-2ccbd51902a5";
    fsType = "btrfs";
    options = [
      "compress=zstd"
      "subvol=@nix"
      "noatime"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/12CE-A600";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [];

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
