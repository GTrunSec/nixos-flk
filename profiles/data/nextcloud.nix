{ config, lib, pkgs, ... }:
{
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

      #adminpassFile = "nextcloud@admin";
      adminpass = "nextcloud@admin";
      adminuser = "admin";
    };
  };
}
