{
  self,
  inputs,
  ...
}: {
  imports = [(inputs.digga.lib.importOverlays ../overlays/nixpkgs)];
  overlays = [
    ../pkgs/default.nix
    (
      final: prev: {
        inherit
          (inputs.emacs-ng.packages.x86_64-linux)
          emacsng
          ;
        alejandra = inputs.alejandra.defaultPackage."${prev.stdenv.hostPlatform.system}";
        inherit
          (inputs.nixpkgs-hardenedlinux.packages."${prev.stdenv.hostPlatform.system}")
          brim
          zeekscript
          ;
        # nixUnstable = inputs.nix.defaultPackage."${prev.stdenv.hostPlatform.system}";
      }
    )
    inputs.nur.overlay
    inputs.tenvideo.overlay
    inputs.rust-overlay.overlay
    inputs.sops-nix.overlay
    inputs.devos-ext-lib.overlay.vscode
    inputs.deploy.overlay
    inputs.gomod2nix.overlay
  ];
}
