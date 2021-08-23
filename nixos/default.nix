{ self, inputs, ... }:
with inputs;
with inputs.nixos;
{
  hostDefaults = {
    system = "x86_64-linux";
    channelName = "nixos";
    imports = [ (digga.lib.importModules ./modules) ];
    externalModules = [
      { _module.args.ourLib = self.lib; }
      digga.nixosModules.nixConfig
      ci-agent.nixosModules.agent-profile
      home.nixosModules.home-manager
      agenix.nixosModules.age
      bud.nixosModules.bud
      sops-nix.nixosModules.sops
      qnr.nixosModules.local-registry
      #User's custom modules
      photoprism2nix.nixosModules.photoprism
    ];
  };

  imports = [ (digga.lib.importHosts ../hosts) ];

  hosts = {
    /* set host specific properties here */
    NixOS = {
      tests = [
        {
          name = "Test";
          machine = { ... }: { };
          testScript = ''
            start_all()
          '';
        }
      ];
    };
  };
  importables = import ./suites { inherit self inputs; };
}
