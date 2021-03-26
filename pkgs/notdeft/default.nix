{ srcs, stdenv, lib, fetchgit, xapian, emacs, tclap, pkg-config }:
let inherit (srcs) notdeft; in
stdenv.mkDerivation rec {
  inherit (notdeft) version;

  src = notdeft;

  name = "notdeft";
  # src = fetchgit {
  #   url = "https://github.com/hasu/notdeft";
  #   rev = "7c0125074332df9eb75b0b82cf57a4f8698ffc7a";
  #   sha256 = "sha256-pTcyKI66t0/N6wH7JmOa8ulXOQ9ipOCTL6wwVRj/G/0=";
  # };


  nativeBuildInputs = [ xapian emacs tclap pkg-config ];

  #  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cd $src/xapian
    c++ -o $out/bin/notdeft-xapian notdeft-xapian.cc -std=c++11 -Wall `pkg-config --cflags --libs tclap` `xapian-config --cxxflags --libs`
  '';

  enableParallelBuilding = true;

  meta = with lib; {
    description = "NotDeft note manager for Emacs";
    homepage = https://github.com/hasu/notdeft;
    license = licenses.bsd3;
    platforms = with platforms; all;
  };
}
