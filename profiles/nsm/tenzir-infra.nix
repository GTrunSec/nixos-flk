{ config, lib, pkgs, ... }:

{
  services.threatbus-vast = {
    enable = true;
    extraConfig = builtins.readFile ./config.vast.example.yaml;
  };

  services.threatbus = {
    enable = true;
    extraConfig = builtins.readFile ./config.example.yaml;
  };


  services.vast = {
    enable = true;
    broker = true;
    extraConfig = {
      log-file = "/var/lib/vast/server.log";
    };
  };

}
