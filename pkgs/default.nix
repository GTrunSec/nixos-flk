final: prev:
let
  importJSON = file: builtins.fromJSON (builtins.readFile file);
  flakeLock = importJSON ../flake.lock;
  loadInput = { locked, ... }:
    assert locked.type == "github";
    builtins.fetchTarball {
      url = "https://github.com/${locked.owner}/${locked.repo}/archive/${locked.rev}.tar.gz";
      sha256 = locked.narHash;
    };

  nixpkgs-hardenedlinux = loadInput flakeLock.nodes.nixpkgs-hardenedlinux;
  zeek-nix = loadInput flakeLock.nodes.zeek-nix;
in
{
  onepassword = prev.callPackage ./appimage/1password.nix {};
  notdeft = prev.callPackage ./notdeft {};
  nuclear = prev.callPackage ./appimage/nuclear.nix {};
  ytmdesktop = prev.callPackage ./appimage/ytmdesktop.nix {};
  motrix = prev.callPackage ./appimage/Motrix.nix {};
  shadowsocks-qt5 = prev.callPackage ./appimage/shadowsocks-qt5.nix {};
  #FIXME: spicy plugin BUG
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
