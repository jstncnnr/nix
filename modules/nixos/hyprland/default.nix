{
  lib,
  pkgs,
  ...
}: let
  hyprland-dynamic-windows = pkgs.buildGoModule {
    pname = "hyprland-dynamic-windows";
    version = "1.0.1";

    src = pkgs.fetchFromGitHub {
      owner = "jstncnnr";
      repo = "hyprland-dynamic-windows";
      rev = "v1.0.1";
      sha256 = "sha256-gl6X7o61rg4eMuDURrM7Ut5aznXIL5e01lLhKwGt77Q=";
    };

    vendorHash = "sha256-7kuocfpO+m4QdvP74f8jDMnHllJdWydj4jnTjnsz2P4=";
  };
in {
  programs.hyprland.enable = lib.mkDefault true;
  programs.hyprland.withUWSM = lib.mkDefault true;

  environment.systemPackages = [
    hyprland-dynamic-windows
  ];
}
