{ config, lib, pkgs, ... }:
{
  config = with lib; mkMerge [
    (mkIf pkgs.stdenv.isLinux {
      xsession.pointerCursor = {
        package = pkgs.gnome3.defaultIconTheme;
        name = "Adwaita";
        size = 130;
      };
    })
  ];
}
