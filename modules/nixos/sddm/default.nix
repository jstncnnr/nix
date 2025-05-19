{lib, ...}: {
  services.xserver.enable = lib.mkDefault true;
  services.displayManager.sddm = {
    enable = lib.mkDefault true;
    wayland.enable = lib.mkDefault true;
  };
}
