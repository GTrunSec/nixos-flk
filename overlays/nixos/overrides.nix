channels: final: prev: {
  __dontExport = true;
  # overrides clutter up actual creations
  inherit
    (channels.nixos-latest)
    cachix
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
    appimage-run
    zoom-us
    qt6
    ;

  inherit
    (channels.nixos-unstable)
    brave
    rnix-lsp
    signal-desktop
    tdesktop
    alacritty
    onlyoffice-bin
    i3-gaps
    tmux
    julia_18-bin
    texmacs
    podman
    ;

  nixos-rebuild = prev.nixos-rebuild.override {
    nix = channels.nixos-latest.nixUnstable;
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
            (channels.nixos-unstable.haskell.packages."ghc${version}")
            ;
        });
      }
    );

  # python3 =
  #   prev.python3.override
  #   (
  #     old: {
  #       packageOverrides = prev.lib.composeExtensions (old.packageOverrides or (_: _: {})) (selfPythonPackages: pythonPackages: let
  #       in {
  #         pyqt6 = channels.nixos-unstable.python39Packages.pyqt6;
  #         pyqt6-webengine = channels.nixos-unstable.python39Packages.pyqt6-webengine;
  #       });
  #     }
  #   );
  python3Override = channels.nixos-unstable.python3;
}
