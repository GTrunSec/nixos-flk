{ config, ... }:

{
  networking.firewall = {
    allowedTCPPorts = [ 2344 ];
    allowedUDPPorts = [ 2344 ];
  };

  services.photoprism = {
    enable = true;
    port = "2344";
    http_host = "10.220.170.112";
  };
}
