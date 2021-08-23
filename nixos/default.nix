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

  importables = rec {
    profiles = digga.lib.rakeLeaves ../profiles // {
      users = digga.lib.rakeLeaves ../users;
      virtualisation = digga.lib.rakeLeaves ../profiles/virtualisation;
      registry = digga.lib.rakeLeaves ../profiles/registry;
    };
    suites = with profiles; rec {
      base = [ core users.gtrun users.root ];
      graphics = base ++ [
        core-custom
        graphical
        code
        application
        data
        fonts
        devices
        network
        search
        ssh
        nsm
        virtualisation.docker
        virtualisation.libvirtd
        registry.nixos
      ];
    };
  };
}
