{
  self,
  digga,
  ...
}: {
  nixos = {
    imports = [(digga.lib.importOverlays ../overlays/common)];
    overlays = [];
  };
  darwin-nixpkgs = {
    imports = [(digga.lib.importOverlays ../overlays/common)];
    overlays = [];
  };
  nixos-latest = {};
  nixos-unstable = {};
}
