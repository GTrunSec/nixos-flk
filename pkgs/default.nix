final: prev:
let
  nixpkgs-hardenedlinux = prev.fetchgit {
    url = "https://github.com/hardenedlinux/nixpkgs-hardenedlinux";
    rev = "826b291257c7fdd9bb9460ef844396c8ed927955";
    sha256 = "sha256-VebFgB49NoA6C+lm2DfLGd0gCDLVNqNPCWJ0JgDT1rU=";
  };
in
{
  onepassword = prev.callPackage ./appimage/1password.nix {};
  nuclear = prev.callPackage ./appimage/nuclear.nix {};
  motrix = prev.callPackage ./appimage/Motrix.nix {};
  shadowsocks-qt5 = prev.callPackage ./appimage/shadowsocks-qt5.nix {};
  #FIXME: spicy plugin BUG
  hardenedlinux-zeek = prev.callPackage "${nixpkgs-hardenedlinux}/pkgs/zeek" { KafkaPlugin = true; PostgresqlPlugin = true; Http2Plugin = true;};
  btest = prev.callPackage "${nixpkgs-hardenedlinux}/pkgs/python/btest" { python3Packages = prev.python37Packages; };

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
