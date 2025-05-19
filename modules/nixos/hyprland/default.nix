{lib, ...}: {
  programs.hyprland.enable = lib.mkDefault true;
  programs.hyprland.withUWSM = lib.mkDefault true;
}
