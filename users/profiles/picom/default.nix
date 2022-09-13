{ config, lib, pkgs, ... }:

{
  services.picom = {
    enable = true;
    backend = "glx";
    experimentalBackends = true;
    fade = true;
    fadeDelta = 5;
    vSync = true;
    shadow = true;
    shadowOpacity = "0.16";
    menuOpacity = "0.9";
    shadowExclude = [
      "class_g = 'eww-bar'"
      "name = 'Picture-in-Picture'"

      # Tabbed windows
      "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"

      # Screen sharing
      "name = 'cpt_frame_xcb_window'"
      "class_g ?= 'zoom'"
      "name = 'rect-overlay'"
    ];
  };
}
