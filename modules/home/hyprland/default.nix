{
  imports = [
    ./general.nix
    ./keybinds.nix
  ];

  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "suppressevent maximize, class:.*"
      "nofocus, class:^$, title:^$, xwayland:1, fullscreen:0, pinned:0"
    ];

    exec-once = [
      "hyprland-dynamic-windows"
    ];
  };
}
