let version = "1.100.13";
in
final: prev: {
  polar-bookshelf = prev.polar-bookshelf.overrideAttrs (o: {
    inherit version;
    src = prev.fetchurl {
      url = "https://github.com/burtonator/polar-bookshelf/releases/download/v${version}/polar-bookshelf-${version}-amd64.deb";
      sha256 = "0i60np4akhvzqpspg5k2mz8q4ccmz19j43x1sisbdw7iml1a1rsd";
    };
  });
}
