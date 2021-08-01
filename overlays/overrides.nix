channels: final: prev: {

  __dontExport = true; # overrides clutter up actual creations

  inherit (channels.latest)
    cachix
    dhall
    discord
    #element-desktop
    manix
    nixpkgs-fmt
    brave
    signal-desktop
    tmux
    electron_13
    i3-gaps
    starship;

  haskellPackages = prev.haskellPackages.override
    (old: {
      overrides = prev.lib.composeExtensions (old.overrides or (_: _: { })) (hfinal: hprev:
        let version = prev.lib.replaceChars [ "." ] [ "" ] prev.ghc.version;
        in
        {
          # same for haskell packages, matching ghc versions
          inherit (channels.latest.haskell.packages."ghc${version}")
            haskell-language-server;
        });
    });
}
