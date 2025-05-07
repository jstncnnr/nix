{ lib, config, ... }:
let
  cfg = config.system.audio;
in
{
  options = {
    system.audio.engine = lib.mkOption {
      type = lib.types.enum [ "pipewire" "pulseaudio" ];
      default = "pipewire";
      description = "The audio pipeline to use";
    };
  };

  config = {
    services.pulseaudio = lib.mkIf (cfg.engine == "pulseaudio") {
      enable = true;
    };

    services.pipewire = lib.mkIf (cfg.engine == "pipewire") {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    security.rtkit.enable = (cfg.engine == "pipewire");
  };
}
