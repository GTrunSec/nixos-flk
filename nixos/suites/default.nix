{ self, inputs, ... }:
with inputs;
with inputs.nixos;

rec {
  profiles = digga.lib.rakeLeaves ../../profiles // {
    users = digga.lib.rakeLeaves ../../users;
    virtualisation = digga.lib.rakeLeaves ../../profiles/virtualisation;
    registry = digga.lib.rakeLeaves ../../profiles/registry;
    application = digga.lib.rakeLeaves ../../profiles/application;
    data = digga.lib.rakeLeaves ../../profiles/data;
    code = digga.lib.rakeLeaves ../../profiles/code;
    network = digga.lib.rakeLeaves ../../profiles/network;
    search = digga.lib.rakeLeaves ../../profiles/search;
    graphical = digga.lib.rakeLeaves ../../profiles/graphical;
  };
  suites = with profiles; rec {
    base = [ core users.gtrun users.root ];
    nixos = base ++ [
      graphical.nvidia
      graphical.i3
      graphical.xserver
      graphical.xdg


      application.base
      application.chat
      application.misc

      data.promnesia
      data.nextcloud
      data.miniflux

      code.nix
      code.go
      code.common
      code.library
      code.haskell
      code.python
      code.rust
      code.tex
      code.vscode
      code.node


      network.common
      network.adguardhome
      network.adblocking


      search.hound


      fonts
      devices

      ssh
      nsm
      virtualisation.docker
      virtualisation.libvirtd
      virtualisation.oci-containers
      registry.nixos
    ];
  };
}
