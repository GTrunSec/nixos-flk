channels: final: prev: {
  __dontExport = true;
  # overrides clutter up actual creations

  inherit
    (channels.latest)
    cachix
    dhall
    discord
    #element-desktop
    _1password-gui
    _1password
    tdesktop
    manix
    zsh
    nixpkgs-fmt
    brave
    signal-desktop
    tmux
    i3-gaps
    onlyoffice-bin
    julia_17-bin
    texmacs
    nix-direnv
    direnv
    tree-sitter
    starship
    ;

  nixos-rebuild = prev.nixos-rebuild.override {
    nix = channels.latest.nixUnstable;
  };

  haskellPackages = prev.haskellPackages.override
  (
    old: {
      overrides = prev.lib.composeExtensions (old.overrides or (_: _: { })) (hfinal: hprev: let
        version = prev.lib.replaceChars [ "." ] [ "" ] prev.ghc.version;
      in
        {
          # same for haskell packages, matching ghc versions
          inherit
            (channels.latest.haskell.packages."ghc${version}")
            ;
        });
    }
  );
}
