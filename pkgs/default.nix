final: prev:
let
  nixpkgs-hardenedlinux = prev.fetchgit {
    url = "https://github.com/hardenedlinux/nixpkgs-hardenedlinux";
    rev = "60ab7b44f6c7b9ae73e273c91c2efb452638074b";
    sha256 = "sha256-WX62HwvRRbAkXxDVl9qTrSsrI0q+e4Ze1ycYnDQ+Of0=";
  };
in
{
  nuclear = prev.callPackage ./appimage/nuclear.nix {};
  motrix = prev.callPackage ./appimage/Motrix.nix {};
  shadowsocks-qt5 = prev.callPackage ./appimage/shadowsocks-qt5.nix {};
  #FIXME: spicy plugin BUG
  hardenedlinux-zeek = prev.callPackage "${nixpkgs-hardenedlinux}/pkgs/zeek" { KafkaPlugin = true; PostgresqlPlugin = true; Http2Plugin = true;};

  #go packages
  horcrux = prev.callPackage ./go/horcrux {};
  govet = prev.callPackage ./go/govet {};
  got = prev.callPackage ./go/got {};

  #python
  promnesia =  prev.callPackage ./python/promnesia {python3Packages = prev.python37Packages;};
  orgparse=  prev.callPackage ./python/orgparse {python3Packages = prev.python37Packages;};
  hpi =  prev.callPackage ./python/HPI {python3Packages = prev.python37Packages;};
  #rust
  sudo-pair = prev.callPackage ./rust/sudo_pair {};
}
