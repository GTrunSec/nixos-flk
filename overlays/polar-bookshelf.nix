let version = "2.0.42";
in
final: prev: {
  polar-bookshelf = prev.polar-bookshelf.overrideAttrs (o: rec{
    inherit version;
    src = prev.fetchurl {
      url = "https://github.com/burtonator/polar-bookshelf/releases/download/v${version}/polar-desktop-app-${version}-amd64.deb";
      sha256 = "sha256-JyO71wyE6b0iHAYs/6/WbG+OdUVUUPpJla+ZUzg0Gng=";
    };

    installPhase = ''
    mkdir -p $out/share/polar-bookshelf
    mkdir -p $out/bin
    mkdir -p $out/lib

    mv opt/Polar/* $out/share/polar-bookshelf
    mv $out/share/polar-bookshelf/*.so $out/lib

    mv usr/share/* $out/share/

    ln -s $out/share/polar-bookshelf/polar-desktop-app.bin $out/bin/polar-desktop-app

    substituteInPlace $out/share/applications/polar-desktop-app.desktop \
      --replace "/opt/Polar/polar-desktop-app" "$out/bin/polar-desktop-app"
    '';
  });
}
