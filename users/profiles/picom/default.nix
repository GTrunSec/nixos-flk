{
  config,
  lib,
  pkgs,
  ...
}: {
  services.picom = {
    enable = true;
    backend = "glx";
    package = pkgs.picom.overrideAttrs (o: {
      inherit (pkgs.sources.picom) src pname version;
    });
    fade = true;
    fadeDelta = 5;
    vSync = true;
    shadow = true;
    shadowOpacity = 0.16;
    menuOpacity = 0.9;
    opacityRules = [
      "95:class_g *?= 'brave'"
      "80:class_g *?= 'emacs' && focused"
      "75:class_g *?= 'emacs' && !focused"
    ];
    # extraOptions = ''
    #   corner-radius = 10;
    #   # blur-method = "dual_kawase";
    #   blur-strength = "10";
    #   xinerama-shadow-crop = true;
    # '';
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
