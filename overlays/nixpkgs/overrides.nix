channels: final: prev: {
  __dontExport = true;
  # overrides clutter up actual creations
  inherit
    (channels.latest)
    cachix
    rnix-lsp
    dhall
    discord
    #element-desktop
    
    _1password-gui
    _1password
    manix
    nix-direnv
    nixUnstable
    direnv
    tree-sitter
    starship
    treefmt
    ;

  inherit
    (channels.unstable)
    brave
    signal-desktop
    tdesktop
    onlyoffice-bin
    i3-gaps
    tmux
    julia_17-bin
    texmacs
    podman
    ;

  nixos-rebuild = prev.nixos-rebuild.override {
    nix = channels.latest.nixUnstable;
  };

  haskellPackages =
    prev.haskellPackages.override
    (
      old: {
        overrides = prev.lib.composeExtensions (old.overrides or (_: _: {})) (hfinal: hprev: let
          version = prev.lib.replaceChars ["."] [""] prev.ghc.version;
        in {
          # same for haskell packages, matching ghc versions
          inherit
            (channels.latest.haskell.packages."ghc${version}")
            ;
        });
      }
    );
}