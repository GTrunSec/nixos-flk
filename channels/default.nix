{ self, inputs, ... }:
with inputs;
with inputs.nixos;
{
  nixos = {
    imports = [ (digga.lib.importOverlays ../overlays/nixos) ];
    overlays = [
      ../pkgs/default.nix
      (final: prev: {
        emacsNg = emacs-ng.defaultPackage.x86_64-linux;
        beautysh = beautysh.defaultPackage."${final.system}";
      })
      nur.overlay
      digga.overlays.patchedNix
      agenix.overlay
      nvfetcher.overlay
      tenvideo.overlay
      rust-overlay.overlay
      sops-nix.overlay
      nixpkgs-hardenedliux.overlay
    ];
  };
  latest = { };
}
