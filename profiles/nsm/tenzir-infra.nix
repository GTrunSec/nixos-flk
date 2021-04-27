{ config, lib, pkgs, ... }:

{
  services.threatbus-vast = {
    enable = true;
    settings = builtins.readFile ./config.vast.example.yaml;
  };

  services.threatbus = {
    enable = true;
    settings = builtins.readFile ./config.example.yaml;
  };


  services.vast = {
    enable = true;
    settings = {
      log-file = "/var/lib/vast/server.log";
    };
  };

}
