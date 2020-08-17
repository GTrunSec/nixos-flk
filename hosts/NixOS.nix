{
  ### root password is empty by default ###
  imports = [ ../users/nixos ../users/root ./hardware/NixOS-hardware-configuration.nix ../users/password.nix
              ../local/input.nix
              ../profiles/graphical
              ../profiles/graphical/nvidia.nix
              ../profiles/devices
              ../profiles/ssh
              ../profiles/code
              ../profiles/virt
              ../profiles/applications
              ../profiles/nsm
              ../profiles/data
            ];

  networking.firewall = {
    # 8888 -> Jupyterlab
    allowedTCPPorts = [ 8888 ];
    allowedUDPPorts = [ 8888 ];
  };


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  ## ssd
  services.fstrim.enable = true;

  networking.networkmanager.enable = true;
  # Define your hostname.
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];
}
