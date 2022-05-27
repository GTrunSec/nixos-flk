{
  config,
  lib,
  pkgs,
  ...
}: {
  config = with lib;
    mkMerge [
      (mkIf pkgs.stdenv.isLinux {
        home.pointerCursor = {
          x11.enable = true;
          package = pkgs.gnome3.adwaita-icon-theme;
          name = "Adwaita";
          size = 130;
        };
      })
    ];
}
