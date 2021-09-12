{ self, inputs, ... }:
with inputs;
with inputs.nixos;

rec {
  profiles = digga.lib.rakeLeaves ../../profiles // {
    users = digga.lib.rakeLeaves ../../users;
    virtualisation = digga.lib.rakeLeaves ../../profiles/virtualisation;
    registry = digga.lib.rakeLeaves ../../profiles/registry;
    application = digga.lib.rakeLeaves ../../profiles/application;
  };
  suites = with profiles; rec {
    base = [ core users.gtrun users.root ];
    graphics = base ++ [
      code
      graphical
      application.base
      application.chat
      application.misc
      data
      fonts
      devices
      network
      search
      ssh
      nsm
      virtualisation.docker
      virtualisation.libvirtd
      virtualisation.oci-containers
      registry.nixos
    ];
  };
}
