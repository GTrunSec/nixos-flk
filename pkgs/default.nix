final: prev: {
  nuclear = prev.callPackage ./appimage/nuclear.nix {};
  motrix = prev.callPackage ./appimage/Motrix.nix {};
}
