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
  users.extraUsers.myuser.extraGroups = ["vboxusers"];
  # you'll need to add your user to 'libvirtd' group to use virt-manager
  environment.systemPackages = with pkgs; [ virt-manager vault asdasdasd ];

  }
