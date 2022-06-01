{
  inputs,
  self,
  ...
}:
with inputs; {
  system = "x86_64-linux";
  channelName = "nixos";
  imports = [
    (digga.lib.importExportableModules ../modules/shared)
    (digga.lib.importExportableModules ../modules/nixos)
  ];
  modules = [
    {lib.our = self.lib;}
    digga.nixosModules.bootstrapIso
    home.nixosModules.home-manager
    sops-nix.nixosModules.sops
    ragenix.nixosModules.age
    #User's custom modules
  ];
}
