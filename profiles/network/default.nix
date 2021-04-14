{ config, lib, pkgs, ... }:

{
  imports = [
    ./adguardhome.nix
    ./adblocking
  ];

  environment.systemPackages = with pkgs; [
    bc
    dnsutils
  ];
}
