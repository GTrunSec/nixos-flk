{
  inputs,
  self,
  ...
}:
with inputs; {
  system = "x86_64-darwin";
  channelName = "darwin-nixpkgs";
  imports = [
    ../nixos/modules/hm-system-defaults.nix
    ../nixos/modules/nix-path.nix
  ];
  modules = [
    {lib.our = self.lib;}
    digga.darwinModules.nixConfig
    home.darwinModules.home-manager
    agenix.nixosModules.age
  ];
}
