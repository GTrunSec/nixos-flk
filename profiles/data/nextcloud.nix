{ config, lib, pkgs, ... }:
{
  imports = [ ./nextcloud_db.nix ];

  networking.firewall = {
    allowedTCPPorts = [ 80 ];
    allowedUDPPorts = [ 80 ];
  };

  environment.systemPackages = with pkgs; [
    nextcloud-client
  ];

  environment.etc."nextcloud/nextcloud-admin" = {
    source = config.sops.secrets.nextcloud-admin.path;
    mode = "0644";
  };

  sops.secrets.nextcloud-admin = {
    owner = "nextcloud";
    group = "nextcloud";
  };

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud22;
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

      adminpassFile = "/etc/nextcloud/nextcloud-admin";
      #adminpass = "nextcloud@admin";
      adminuser = "admin";
    };
  };
}
