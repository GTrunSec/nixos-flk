{
  config,
  lib,
  pkgs,
  ...
}: {
  networking.firewall = {
    allowedTCPPorts = [9002];
    allowedUDPPorts = [9002];
  };

  services.adguardhome = {
    enable = true;
    host = "10.220.170.112";
    port = 9002;
  };

  environment.systemPackages = with pkgs; [
    adguardhome
  ];
}
