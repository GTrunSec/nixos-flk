{
  config,
  lib,
  pkgs,
  ...
}: {
  config = with lib;
    mkMerge [
      (mkIf pkgs.stdenv.isLinux {
        services.lorri = {
          enable = true;
        };
      })
    ];
}
