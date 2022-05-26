{
  self,
  ...
}:
[
  (final: prev: {
    __dontExport = true;
    lib = prev.lib.extend (
      lfinal: lprev: {
        our = self.lib;
        installApp = import ../../lib/installApp.nix prev;
      }
    );
    nix = final.nixUnstable;
  })
]
