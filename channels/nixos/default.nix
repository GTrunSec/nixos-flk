{ self, inputs, ... }:
with inputs;
with inputs.nixos;
{
  imports = [ (digga.lib.importOverlays ../../overlays/nixos) ];
  overlays = [
    ../../pkgs/default.nix
    (final: prev: {
      emacsNg = emacs-ng.defaultPackage.x86_64-linux;
      beautysh = beautysh.packages.x86_64-linux."beautysh-python3.8";
      nvfetcher-bin = nvfetcher.defaultPackage.x86_64-linux;
      nix = prev.nixUnstable;
    })
    nur.overlay
    tenvideo.overlay
    rust-overlay.overlay
    sops-nix.overlay
    nixpkgs-hardenedlinux.overlay
  ];
}
