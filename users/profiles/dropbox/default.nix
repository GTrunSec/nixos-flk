{
  config,
  lib,
  pkgs,
  ...
}: {
  config = with lib;
    mkMerge [
      (mkIf pkgs.stdenv.isLinux {
        services.dropbox = {
          enable = true;
        };
      })
    ];
}
