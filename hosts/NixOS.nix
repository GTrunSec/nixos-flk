{
  ### root password is empty by default ###
  imports = [ ../users/nixos ../users/root ./hardware/NixOS-hardware-configuration.nix
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
              ../profiles/network
              ../profiles/search
            ];

  networking.firewall = {
    # 8888 -> Jupyterlab 8889 -> JuliaPluto
    allowedTCPPorts = [ 8888 8889 53 4822 ];
    allowedUDPPorts = [ 8888 8889 53 4822 ];
  };

  networking.nameservers = [ "10.220.170.112" ]; #adguardhome

  networking.networkmanager = {
    enable = true;
    dns = "none";
  };

  environment.etc = {
    "resolv.conf".text = "nameserver 10.220.170.112";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  ## ssd
  services.fstrim.enable = true;

  # Define your hostname.
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

}
