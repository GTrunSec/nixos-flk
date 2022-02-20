{
  config,
  lib,
  pkgs,
  ...
}: let
  config = builtins.readFile ./config-hound.json;
in {
  networking.firewall = {
    allowedTCPPorts = [9003];
    allowedUDPPorts = [9003];
  };

  services.hound = {
    enable = true;
    listen = "10.220.170.112:9003";
    inherit config;
  };
}
