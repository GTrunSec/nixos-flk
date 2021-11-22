{ config, lib, pkgs, ... }:
let
  DirNames = builtins.attrNames (builtins.readDir ./hosts);
  machine = ({ } // (
    builtins.listToAttrs
      (map
        (pkgDir: {
          value = lib.importTOML (./hosts + "/${pkgDir}");
          name = lib.removeSuffix ".toml" pkgDir;
        })
        DirNames)
  ))."${config.networking.hostName}";
in
{
  options = with lib;
    {
      machine = mkOption {
        default = machine;
        description = "hosts resource info";
      };
    };
}
