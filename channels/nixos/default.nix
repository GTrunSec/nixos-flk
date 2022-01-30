{ self, inputs, ... }:
with inputs;
with inputs.nixos;
{
  imports = [ (digga.lib.importOverlays ../../overlays/nixos) ];
  overlays = [
    ../../pkgs/default.nix
    (final: prev: {
      emacsNG = emacs-ng.defaultPackage.x86_64-linux;
      beautysh = beautysh.packages.x86_64-linux."beautysh-python3.8";
      nvfetcher-bin = nvfetcher.defaultPackage.x86_64-linux;
      alejandra = alejandra.defaultPackage."${prev.stdenv.hostPlatform.system}";
    })
    nur.overlay
    tenvideo.overlay
    rust-overlay.overlay
    sops-nix.overlay
    nixpkgs-hardenedlinux.overlay
    devos-ext-lib.overlay.vscode
  ];
}
