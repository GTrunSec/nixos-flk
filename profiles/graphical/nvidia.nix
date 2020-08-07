{ config, lib, pkgs, ... }:

{
  services.xserver = {
    videoDrivers = [ "nvidia" "intel"];
  };


  systemd.services.nvidia-control-devices = {
    wantedBy = [
      "multi-user.target"
    ];
  };

  boot.blacklistedKernelModules = [ "nouveau" ];

}
