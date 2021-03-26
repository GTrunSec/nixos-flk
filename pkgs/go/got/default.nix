{ stdenv, buildGoPackage, fetchgit, fetchhg, fetchbzr, fetchsvn }:

buildGoPackage rec {
  name = "got-${version}";
  version = "master";
  rev = "fd202dae8230ae214275a85bdb1f9c49f12c7a2d";

  goPackagePath = "github.com/melbahja/got";

  src = fetchgit {
    inherit rev;
    url = "https://github.com/melbahja/got";
    sha256 = "sha256-ZMqNTDXYGXokRWmC6eqpUX+mKFTrdoaRO9kg5Gmvwes=";
  };

  goDeps = ./deps.nix;

  meta = {
    description = "Got: Simple golang package and CLI tool to download large files faster than cURL and Wget!";
    homePage = "https://github.com/melbahja/got";
  };
}
