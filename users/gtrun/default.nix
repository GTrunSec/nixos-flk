{ config, lib, pkgs, ... }:
{
  home-manager.users.gtrun = { suites, ... }: {
    imports = suites.base;
    home.enableNixpkgsReleaseCheck = false;
  };

  networking.firewall = {
    allowedTCPPorts = [ 8888 8889 ];
    allowedUDPPorts = [ 8888 8889 ];
  };

  users.users.gtrun = {
    home = "/home/gtrun";
    password = "nixos";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
      "pulse"
      "sound"
      "libvirtd"
      "video"
      "docker"
    ]; # Enable ‘sudo’ for the user.
    shell = "/run/current-system/sw/bin/zsh";
    uid = 1000;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDI2uDp51HMggnfz4Zn5ky4gb/XVdQiJR7pZyb/LcCLx macOSdeMBP.attlocal.net-gtrun-14-05-2021"
    ];
  };
  services.lorri.enable = true;
}
