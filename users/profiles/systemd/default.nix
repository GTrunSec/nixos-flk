{
  config,
  lib,
  pkgs,
  ...
}: {
  config = with lib;
    mkMerge [
      (mkIf pkgs.stdenv.isLinux {
        systemd.user.startServices = true;
      })
    ];
}
