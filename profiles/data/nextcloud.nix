{ config, lib, pkgs, ... }:
let
    password = (builtins.fromJSON (builtins.readFile ../../secrets/password.json)).user.gtrun.server.nextcloud;
in
{
  environment.etc."nextcloud/nextcloud-db-pass" = {
      text = password;
      user = "nextcloud";
      group = "nextcloud";
  };
  environment.etc."nextcloud/nextcloud-admin-pass" = {
      text = password;
      user = "nextcloud";
      group = "nextcloud";
  };

  services.nextcloud = {
    enable = true;
    # Auto-update Nextcloud Apps
    autoUpdateApps.enable = true;
    # Set what time makes sense for you
    autoUpdateApps.startAt = "05:00:00";

    hostName = "10.220.170.112";
    config = {
      dbtype = "pgsql";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql"; # nextcloud will add /.s.PGSQL.5432 by itself
      dbname = "nextcloud";
      dbpassFile = "/etc/nextcloud/nextcloud-db-pass";

      adminpassFile = "/etc/nextcloud/nextcloud-admin-pass";
      adminuser = "admin";
    };
  };
}
