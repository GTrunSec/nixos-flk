{ config, lib, pkgs, ... }:

{

  services.dunst = {
    enable = true;
  };

  systemd.user.startServices = true;
}
