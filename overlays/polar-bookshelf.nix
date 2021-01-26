let version = "2.0.103";
in
final: prev: {
  polar-bookshelf = prev.polar-bookshelf.overrideAttrs (o: rec{
    inherit version;
    src = prev.fetchurl {
      url = "https://github.com/burtonator/polar-bookshelf/releases/download/v${version}/polar-desktop-app-${version}-amd64.deb";
      sha256 = "sha256-jcq0hW698bAhVM3fLQQeKAnld33XLkHsGjS3QwUpciQ=";
    };
  });
}
