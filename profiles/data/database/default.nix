{ config, lib, pkgs, ... }:

{
  services.mysql = {
    enable = true;
    package = pkgs.mysql;
  };
  environment.systemPackages = with pkgs; [
    mysql-client
  ];
}
