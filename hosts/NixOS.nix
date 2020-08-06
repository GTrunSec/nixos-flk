{
  ### root password is empty by default ###
  imports = [ ../users/nixos ../users/root ./hardware-configuration.nix];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  #fileSystems."/" = { device = "/dev/disk/by-label/nixos"; };
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];
}
