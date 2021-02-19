{ pkgs, ... }:
let
  julia = pkgs.julia_13.overrideAttrs (oldAttrs: {
    src = pkgs.fetchzip {
      url = "https://github.com/JuliaLang/julia/releases/download/v1.4.2/julia-1.4.2-full.tar.gz";
      sha256 = "14jghi9mw0wdi6y9saarf0nzary9i21jx43zznddzrq48v4nlayj";
    };
    checkTarget = "";
  });

  extraLibs = with pkgs; [
    # IJulia.jl
    mbedtls
    zeromq4
    # ImageMagick.jl
    imagemagickBig
  ];
in
pkgs.stdenv.mkDerivation rec {
  name = "julia-env";
  version = julia.version;
  nativeBuildInputs = with pkgs; [ makeWrapper cacert git pkgconfig which ];
  buildInputs = [
    julia
    /* jupyterEnv  # my custom jupyter */
  ] ++ extraLibs;
  phases = [ "installPhase" ];
  installPhase = ''
    export R_HOME=${pkgs.R}/lib/R
    export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath extraLibs}:${pkgs.R}/lib/R/lib
    makeWrapper ${julia}/bin/julia $out/bin/julia \
        --prefix LD_LIBRARY_PATH : "$LD_LIBRARY_PATH" \
        --prefix R_HOME : "$R_HOME" \
        --set JULIA_PKG_SERVER pkg.julialang.org \
        #--set JULIA_PKGDIR $JULIA_PKGDIR
  '';
}
