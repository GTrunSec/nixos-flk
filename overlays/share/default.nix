{ self, inputs, ... }:
with inputs;
[
  (final: prev:
    {
      __dontExport = true;
      machlib = import mach-nix {
        pkgs = prev;
        pypiData = pypi-deps-db;
      };
      lib = prev.lib.extend (lfinal: lprev: {
        our = self.lib;
        installApp = import ../../lib/installApp.nix prev;
      });
    })
  gomod2nix.overlay
]
