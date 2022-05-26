{
  inputs,
  self,
  ...
}:
with inputs; {
  system = "x86_64-darwin";
  channelName = "darwin-nixpkgs";
  imports = [(digga.lib.importExportableModules ../modules/shared)];
  modules = [
    {lib.our = self.lib;}
    digga.darwinModules.nixConfig
    home.darwinModules.home-manager
    ragenix.nixosModules.age
  ];
}
