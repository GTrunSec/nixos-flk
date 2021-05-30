{ config, lib, pkgs, ... }:

{
  imports = [
    ./adguardhome.nix
    #./adblocking
  ];


  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    bc
    dnsutils
  ];
}
