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
    coding = digga.lib.rakeLeaves ../../profiles/coding;
    networking = digga.lib.rakeLeaves ../../profiles/networking;
    searching = digga.lib.rakeLeaves ../../profiles/searching;
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
      data.syncthing

      coding.nix
      coding.go
      coding.common
      coding.library
      coding.haskell
      coding.python
      coding.rust
      coding.tex
      coding.vscode
      coding.node


      networking.common
      networking.adguardhome
      networking.adblocking


      searching.hound

      fonts
      devices

      ssh
      nsm
      virtualisation.docker
      virtualisation.libvirtd
      virtualisation.oci-containers
      # using extra registry
      #registry.nixos
    ];
  };
}
