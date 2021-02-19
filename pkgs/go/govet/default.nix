{ stdenv, buildGoPackage, fetchgit, fetchhg, fetchbzr, fetchsvn }:

buildGoPackage rec {
  name = "govet-unstable-${version}";
  version = "2017-10-12";
  rev = "4a96d43e39d340b63daa8bc5576985aa599885f6";

  goPackagePath = "github.com/dnephin/govet";

  src = fetchgit {
    inherit rev;
    url = "https://github.com/dnephin/govet";
    sha256 = "1zjx7zrbzpcw8fl5bzhq2a2qfllwcsjsb8kxmprh9ww8pm4rxngj";
  };

  # goDeps = ./deps.nix;

  meta = {
    description = "Go VET";
    homePage = "https://github.com/dnephin/govet";
  };
}
