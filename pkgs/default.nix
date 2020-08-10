final: prev: {
  nuclear = prev.callPackage ./appimage/nuclear.nix {};
  motrix = prev.callPackage ./appimage/Motrix.nix {};
  shadowsocks-qt5 = prev.callPackage ./appimage/shadowsocks-qt5.nix {};
}
