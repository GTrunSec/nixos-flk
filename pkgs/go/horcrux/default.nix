{ stdenv, buildGoPackage, fetchgit, fetchhg, fetchbzr, fetchsvn }:

buildGoPackage rec {
  name = "horcrux";
  versionooo = "master";
  rev = "c078763704ac87c71e702c72751eaf0973674a72";

  goPackagePath = "src/horcrux";
  src = fetchgit {
    inherit rev;
    url = "https://github.com/jesseduffield/horcrux.git";
    sha256 = "1l1inwlf252z6n9xcvqpz6qxcnx3hnwwhylnp22n0qhzf7w23jsk";
  };

  goDeps = ./deps.nix;

  # TODO: add metadata https://nixos.org/nixpkgs/manual/#sec-standard-meta-attributes
  meta = {
    description = "https://github.com/jesseduffield/horcrux.git";
  };
}
