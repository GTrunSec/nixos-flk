{ self, inputs, ... }:
with inputs;
[
  (final: prev:
    {
      machlib = import mach-nix {
        pkgs = prev;
        pypiData = pypi-deps-db;
      };
      lib = prev.lib.extend (lfinal: lprev: {
        our = self.lib;
      });
    })
  gomod2nix.overlay
]
