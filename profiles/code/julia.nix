{ pkgs, ... }:
let
  julia = pkgs.julia_13.overrideAttrs(oldAttrs: {
   src = pkgs.fetchzip {
     url = "https://github.com/JuliaLang/julia/releases/download/v1.4.2/julia-1.4.2-full.tar.gz";
     sha256 = "14jghi9mw0wdi6y9saarf0nzary9i21jx43zznddzrq48v4nlayj";
   };
   checkTarget = "";
  });

  cudaVersion = pkgs.cudatoolkit_10_2;
  nvidiaVersion = pkgs.linuxPackages.nvidia_x11;

  extraLibs = with pkgs; [
    # IJulia.jl
    mbedtls
    zeromq4
    # ImageMagick.jl
    imagemagickBig
    # HDF5.jl
    hdf5
    # Cairo.jl
    cairo
    gettext
    pango.out
    glib.out
    # Gtk.jl
    gtk3
    gdk_pixbuf
    # GZip.jl # Required by DataFrames.jl
    gzip
    zlib
    # GR.jl # Runs even without Xrender and Xext, but cannot save files, so those are required
    xorg.libXt
    xorg.libX11
    xorg.libXrender
    xorg.libXext
    glfw
    freetype
    # Flux.jl
    cudatoolkit
    cudnn
    linuxPackages.nvidia_x11
    git gitRepo gnupg autoconf curl
    procps gnumake utillinux m4 gperf unzip
    #libGLU_combined
    xorg.libXi xorg.libXmu freeglut
    xorg.libXext xorg.libX11 xorg.libXv xorg.libXrandr zlib
    ncurses5 stdenv.cc binutils
    # Arpack.jl
    arpack
    gfortran.cc
    (pkgs.runCommand "openblas64_" {} ''
      mkdir -p "$out"/lib/
      ln -s ${openblasCompat}/lib/libopenblas.so "$out"/lib/libopenblas64_.so.0
    '')
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
    export CUDA_PATH="${pkgs.cudatoolkit}"
    export R_HOME=${pkgs.R}/lib/R
    export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath extraLibs}:${pkgs.R}/lib/R/lib
    makeWrapper ${julia}/bin/julia $out/bin/julia \
        --prefix LD_LIBRARY_PATH : "$LD_LIBRARY_PATH" \
        --prefix LD_LIBRARY_PATH ":" "${nvidiaVersion}/lib" \
        --prefix R_HOME : "$R_HOME" \
        --set JULIA_PKG_SERVER pkg.julialang.org \
        --set CUDA_PATH "${cudaVersion}"
        #--set JULIA_PKGDIR $JULIA_PKGDIR
  '';
}
