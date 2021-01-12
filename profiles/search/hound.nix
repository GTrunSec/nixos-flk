{ config, lib, pkgs, ... }:

{
  networking.firewall = {
    allowedTCPPorts = [ 9003 ];
    allowedUDPPorts = [ 9003 ];
  };

  services.hound = {
    enable = true;
    listen = "10.220.170.112:9003";
    config = ''
         {
             "max-concurrent-indexers" : 2,
             "dbpath" : "/var/lib/hound/data",
             "repos" : {
                "nixpkgs": {
                   "url" : "https://www.github.com/NixOS/nixpkgs.git"
                },
                "zeek": {
                   "url" : "https://www.github.com/zeek/zeek.git"
                }
             }
          }
    '';
  };
}
