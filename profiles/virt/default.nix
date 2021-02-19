{ pkgs, ... }: {
  # virtualisation.libvirtd = {
  #   enable = true;
  #   qemuRunAsRoot = false;
  # };
  virtualisation = {
    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
      };
    };
    kvmgt.enable = true;
  };
  #virtualisation.vmware.host.enable = true;
  users.extraUsers.myuser.extraGroups = [ "vboxusers" ];
  # you'll need to add your user to 'libvirtd' group to use virt-manager
  boot.kernelModules = [ "kvm-intel" ];


  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  environment.systemPackages = with pkgs; [
    virt-manager
    docker_compose
  ];

}
