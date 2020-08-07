{
  ### root password is empty by default ###
  imports = [ ../users/nixos ../users/root ./hardware/NixOS-hardware-configuration.nix
              ../profiles/graphical
              ../profiles/graphical/nvidia.nix
              ../profiles/ssh
              ../profiles/code
              ../profiles/applications
            ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  ## ssd
  services.fstrim.enable = true;

  networking.networkmanager.enable = true;
  # Define your hostname.
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];
}
