{
  lib,
  config,
  ...
}: let
  cfg = config.system.audio;
in {
  options = {
    system.audio.engine = lib.mkOption {
      type = lib.types.enum ["pipewire" "pulseaudio"];
      default = "pipewire";
      description = "The audio pipeline to use";
    };
  };

  config = {
    services.pulseaudio = lib.mkIf (cfg.engine == "pulseaudio") {
      enable = lib.mkDefault true;
    };

    services.pipewire = lib.mkIf (cfg.engine == "pipewire") {
      enable = lib.mkDefault true;
      alsa.enable = lib.mkDefault true;
      alsa.support32Bit = lib.mkDefault true;
      pulse.enable = lib.mkDefault true;
      jack.enable = lib.mkDefault true;
    };

    security.rtkit.enable = lib.mkDefault (cfg.engine == "pipewire");
  };
}
