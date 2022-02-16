{
  self,
  inputs,
  ...
}:
{
  imports = [ (inputs.digga.lib.importOverlays ../overlays/nixpkgs) ];
  overlays = [
    ../pkgs/default.nix
    (
      final: prev: {
        emacsNG = inputs.emacs-ng.defaultPackage.x86_64-linux;
        beautysh = inputs.beautysh.defaultPackage.x86_64-linux;
        alejandra = inputs.alejandra.defaultPackage."${prev.stdenv.hostPlatform.system}";
        inherit
          (inputs.nixpkgs-hardenedlinux.packages."${prev.stdenv.hostPlatform.system}")
          brim
          ;
        nixUnstable = inputs.nix.defaultPackage."${prev.stdenv.hostPlatform.system}";
      }
    )
    inputs.nur.overlay
    inputs.tenvideo.overlay
    inputs.rust-overlay.overlay
    inputs.sops-nix.overlay
    inputs.devos-ext-lib.overlay.vscode
  ];
}
