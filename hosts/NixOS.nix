{
  ### root password is empty by default ###
  imports = [ ../users/nixos ../users/root ./hardware-configuration.nix
              ../profiles/graphical
              ../profiles/graphical/nvidia.nix
              ../profiles/fonts
              ../profiles/ssh
            ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.fstrim.enable = true;

  networking.networkmanager.enable = true;

  #fileSystems."/" = { device = "/dev/disk/by-label/nixos"; };
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];
}
