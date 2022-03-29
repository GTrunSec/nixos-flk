{
  self,
  inputs,
  ...
}:
with inputs; {
  hostDefaults = {
    system = "x86_64-linux";
    channelName = "nixpkgs";
    imports = [
      (digga.lib.importExportableModules ./modules)
    ];
    modules = [
      {_module.args.ourLib = self.lib;}
      home.nixosModules.home-manager
      sops-nix.nixosModules.sops
      qnr.nixosModules.local-registry
      #User's custom modules
      photoprism2nix.nixosModules.photoprism
    ];
  };

  imports = let
    filtered = inputs.nix-filter.lib.filter {
      root = ../hosts;
      exclude = [
        ../hosts/MacBook
      ];
    };
  in [(digga.lib.importHosts filtered)];

  hosts = {
    NixOS = {
      modules = [
        # { disabledModules = [ "services/misc/geoip-updater.nix" ]; }
        # (import (inputs.latest + "/nixos/modules/services/misc/geoipupdate.nix"))
      ];
      tests = [
        {
          name = "Test";
          machine = {...}: {};
          testScript = ''
            start_all()
          '';
        }
      ];
    };
  };
  importables = import ./suites.nix {inherit self inputs;};
}
