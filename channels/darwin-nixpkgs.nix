{
  self,
  inputs,
  ...
}: {
  imports = [(inputs.digga.lib.importOverlays ../overlays/nixos)];
  overlays = [
    ../pkgs/default.nix
    (
      final: prev: {
        __dontExport = true;

        lib = prev.lib.extend (
          lfinal: lprev: {
            installApp = import ../../lib/installApp.nix prev;
          }
        );

        inherit
          (inputs.darwin-emacs.packages.${prev.system})
          emacs
          ;
      }
    )
  ];
}
