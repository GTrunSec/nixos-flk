{ config, lib, pkgs, ... }:
{
  networking.firewall = {
    allowedTCPPorts = [ 9005 9000 ];
    allowedUDPPorts = [ 9005 9000 ];
  };

  services.miniflux = {
    enable = true;
    #adminCredentialsFile = ../../secrets/miniflux-admin-credentials;
    config.LISTEN_ADDR = "10.220.170.112:9005";
  };
}
