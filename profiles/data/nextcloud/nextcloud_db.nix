{
  config,
  lib,
  pkgs,
  ...
}: {
  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    ensureDatabases = [
      "nextcloud"
    ];
    initialScript = pkgs.writeText "backend-initScript" ''
      #CREATE DATABASE "timesketch" WITH OWNER "timesketch";
    '';
    ensureUsers = [
      {
        name = "nextcloud";
        ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
      }
    ];
  };
}
