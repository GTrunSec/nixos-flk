{ config, lib, pkgs, ... }:

{
  services.xserver = {
    videoDrivers = [ "nvidia" "intel" ];
  };

  hardware.nvidia.modesetting.enable = true;

  systemd.services.nvidia-control-devices = {
    wantedBy = [
      "multi-user.target"
    ];
  };

  boot.blacklistedKernelModules = [ "nouveau" ];

}
