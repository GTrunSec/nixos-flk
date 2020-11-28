{ config, lib, pkgs, ... }:

{
  imports = [
    ./adguardhome.nix
  ];

  environment.systemPackages = with pkgs; [
    bc
    dnsutils
  ];
}
