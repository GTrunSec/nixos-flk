{
  pkgs,
  ...
}:
{
  virtualisation.libvirtd = {
    enable = true;
    allowedBridges = [ "all" ];
    qemu = {
      runAsRoot = false;
    };
  };
  # virtualisation = {
  #   virtualbox = {
  #     host = {
  #       enable = true;
  #       enableExtensionPack = true;
  #     };
  #   };
  #   kvmgt.enable = true;
  # };
  # users.extraUsers.gtrun.extraGroups = [ "vboxusers" ];
  users.extraUsers.gtrun.extraGroups = [ "libvirtd" ];
  networking.firewall.checkReversePath = false;
  # you'll need to add your user to 'libvirtd' group to use virt-manager
  boot.kernelModules = [ "kvm-intel" ];

  environment.systemPackages = with pkgs; [
    virt-manager
  ];
}
