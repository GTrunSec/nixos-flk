channels: final: prev: {

  __dontExport = true; # overrides clutter up actual creations

  inherit (channels.latest)
    cachix
    dhall
    discord
    element-desktop
    manix
    nixpkgs-fmt
    brave
    signal-desktop
    tmux
    electron_13
    starship;

  haskellPackages = prev.haskellPackages.override
    (hpArgs: {
      overrides = prev.lib.composeExtensions (hpArgs.overrides or (_: _: { })) (hfinal: hprev:
        let version = prev.lib.replaceChars [ "." ] [ "" ] prev.ghc.version;
        in
        {
          # same for haskell packages, matching ghc versions
          inherit (channels.latest.haskell.packages."ghc${version}")
            haskell-language-server;
        });
    });
}
