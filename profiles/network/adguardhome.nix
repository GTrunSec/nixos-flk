{ config, lib, pkgs, ... }:

{
  services.adguardhome = {
    enable = true;
  };
  environment.systemPackages = with pkgs; [
    adguardhome
  ];
}
