{
  config,
  lib,
  pkgs,
  ...
}:
{
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    bc
    dnsutils
  ];
}
