# override defaults to nixpkgs/master
{
  # modules to pull from override, stable version is automatically disabled
  modules = [ ];

  # if a modules name changed in override, add the old name here
  disabledModules = [ ];

  # packages pulled from override
  packages = pkgs: final: prev: {
    inherit (pkgs)
      cachix
      dhall
      element-desktop
      manix
      nixpkgs-fmt
      signal-desktop
      starship
      nextcloud21
      brave
      discord
      logseq
      i3-gaps
      i3
      ;

    haskellPackages = prev.haskellPackages.override {
      overrides = hfinal: hprev:
        let version = prev.lib.replaceChars [ "." ] [ "" ] prev.ghc.version;
        in
        {
          # same for haskell packages, matching ghc versions
          inherit (pkgs.haskell.packages."ghc${version}")
            haskell-language-server;
        };
    };
  };
}
