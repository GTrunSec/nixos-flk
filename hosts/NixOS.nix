{ suites, ... }:
{
  ### root password is empty by default ###
  imports = suites.graphics ++ [
    ./hardware/NixOS-hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
}
