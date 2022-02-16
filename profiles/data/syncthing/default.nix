{
  config,
  lib,
  pkgs,
  ...
}:
{
  networking.firewall = {
    allowedTCPPorts = [ 8384 ];
    allowedUDPPorts = [ 8384 ];
  };

  environment.systemPackages = with pkgs; [
    syncthing-gtk
  ];

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    guiAddress = "${config.machine.common.ip}:${config.machine.services.syncthing.port}";
  };
}
