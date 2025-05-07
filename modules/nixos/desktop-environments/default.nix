{ lib, ... }:

{
  imports = [
    ./gnome.nix
  ];

  options = {
    # We only allow one desktop environment to be active at a time.
    # This is mostly due to the tight integration with their respective
    # display managers. Gnome/GDM, Plasma/SDDM, etc.
    system.desktopEnvironment = lib.mkOption {
      type = lib.types.enum [ "gnome" ];
      default = "gnome";
      description = "The desktop environment to use";
    };
  };
}
