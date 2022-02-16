{
  sources,
  stdenv,
  lib,
  fetchgit,
  xapian,
  emacs,
  tclap,
  pkg-config,
}:
stdenv.mkDerivation rec {
  inherit (sources.notdeft) pname src version;

  nativeBuildInputs = [ xapian emacs tclap pkg-config ];

  phases = [ "installPhase" ];

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
