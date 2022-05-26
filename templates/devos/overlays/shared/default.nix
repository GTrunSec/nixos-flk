{
  self,
  ragenix,
  ...
}: [
  (final: prev: {
    __dontExport = true;
    lib = prev.lib.extend (lfinal: lprev: {
      our = self.lib;
    });
  })
  ragenix.overlay
  (import ../../pkgs)
]
