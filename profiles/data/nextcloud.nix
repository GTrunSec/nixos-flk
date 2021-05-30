{ config, lib, pkgs, ... }:
{
  age.secrets.nextcloud-admin = {
    owner = "nextcloud";
    file = ../../secrets/nextcloud-admin.age;
  };

  age.secrets.nextcloud-db = {
    owner = "nextcloud";
    file = ../../secrets/nextcloud-db.age;
  };

  networking.firewall = {
    allowedTCPPorts = [ 80 ];
    allowedUDPPorts = [ 80 ];
  };

  environment.systemPackages = with pkgs; [
    nextcloud-client
  ];


  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud21;
    home = "/DATABASE-4TB/nextcloud";
    # Auto-update Nextcloud Apps
    autoUpdateApps.enable = true;
    # Set what time makes sense for you
    autoUpdateApps.startAt = "05:00:00";

    hostName = "10.220.170.112";

    config = {
      dbtype = "pgsql";
      dbuser = "nextcloud";
      # nextcloud will add /.s.PGSQL.5432 by itself
      dbhost = "/run/postgresql";
      dbname = "nextcloud";
      dbpassFile = config.age.secrets.nextcloud-db.path;

      adminpassFile = config.age.secrets.nextcloud-admin.path;
      adminuser = "admin";
    };
  };
}
