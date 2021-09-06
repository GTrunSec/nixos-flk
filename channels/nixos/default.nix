{ self, inputs, ... }:
with inputs;
with inputs.nixos;
{
  imports = [ (digga.lib.importOverlays ../../overlays/nixos) ];
  overlays = [
    ../../pkgs/default.nix
    (final: prev: {
      emacsNg = emacs-ng.defaultPackage.x86_64-linux;
      beautysh = beautysh.defaultPackage."${final.system}";
      nvfetcher-bin = nvfetcher.defaultPackage.x86_64-linux;
    })
    nur.overlay
    digga.overlays.patchedNix
    agenix.overlay
    tenvideo.overlay
    rust-overlay.overlay
    sops-nix.overlay
    nixpkgs-hardenedlinux.overlay
  ];
}
