{
  lib,
  config,
  ...
}: let
  inherit (config.lib.stylix) colors;
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      # Stylix does not correctly let us add to the color/image,
      # so we have to force it and set the correct colors for
      # background and input-field
      background = lib.mkForce [
        {
          color = "rgb(${colors.base00})";
          path = "${config.stylix.image}";
          blur_size = 4;
          blur_passes = 3;
          noise = 0.0117;
          brightness = 0.8000;
          vibrancy = 0.2100;
          vibrancy_darkness = 0.0;
        }
      ];

      input-field = lib.mkForce [
        {
          size = "300, 50";
          outline_thickness = 0;
          dots_size = 0.2;
          dots_spacing = 0.64;
          dots_center = true;
          fade_on_empty = false;
          placeholder_text = "<i>Password...</i>";
          hide_input = false;
          position = "0, -100";
          halign = "center";
          valign = "center";
          rounding = 8;
          outer_color = "rgb(${colors.base03})";
          inner_color = "rgb(${colors.base00})";
          font_color = "rgb(${colors.base05})";
          fail_color = "rgb(${colors.base08})";
          check_color = "rgb(${colors.base0A})";
        }
      ];

      label = [
        {
          text = "$TIME12";
          font_size = 64;
          font_family = "JetBrains Mono Nerd Font 10";
          position = "0, 96";
          halign = "center";
          valign = "center";
        }
        {
          text = ''Hey <span text_transform="capitalize" size="larger">$USER</span>'';
          font_size = 20;
          font_family = "JetBrains Mono Nerd Font 10";
          position = "0, 0";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
