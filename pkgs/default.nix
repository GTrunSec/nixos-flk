final: prev:
let
  nixpkgs-hardenedlinux = prev.fetchgit {
    url = "https://github.com/hardenedlinux/nixpkgs-hardenedlinux";
    rev = "fff5112a388585b6082369fab0b7730b5e5570e8";
    sha256 = "sha256-T2t0rQJrYSKZB/YLu1cSYsul2QulOL0ay2oBtJWnBg8=";
  };
in
{
  nuclear = prev.callPackage ./appimage/nuclear.nix {};
  motrix = prev.callPackage ./appimage/Motrix.nix {};
  shadowsocks-qt5 = prev.callPackage ./appimage/shadowsocks-qt5.nix {};
  zeek = prev.callPackage "${nixpkgs-hardenedlinux}/pkgs/zeek" { KafkaPlugin = true; PostgresqlPlugin = true; Http2Plugin = true; SpicyPlugin = true;};

  #go packages
  horcrux = prev.callPackage ./go/horcrux {};
  govet = prev.callPackage ./go/govet {};
  got = prev.callPackage ./go/got {};
}
