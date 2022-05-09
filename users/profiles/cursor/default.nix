{
  config,
  lib,
  pkgs,
  ...
}: {
  config = with lib;
    mkMerge [
      (
        mkIf pkgs.stdenv.isLinux {
          home.pointerCursor = {
            x11.enable = true;
            package = pkgs.gnome3.defaultIconTheme;
            name = "Adwaita";
            size = 130;
          };
        }
      )
    ];
}
