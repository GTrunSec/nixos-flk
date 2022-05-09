{
  inputs,
  self,
  ...
}:
with inputs; {
  system = "x86_64-linux";
  channelName = "nixos";
  imports = [
    (digga.lib.importExportableModules ./modules)
  ];
  modules = [
    {lib.our = self.lib;}
    home.nixosModules.home-manager
    sops-nix.nixosModules.sops
    qnr.nixosModules.local-registry
    #User's custom modules
    photoprism2nix.nixosModules.photoprism
  ];
}
