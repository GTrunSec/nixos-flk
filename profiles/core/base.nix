{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
  ];
  services.earlyoom.enable = true;
}
