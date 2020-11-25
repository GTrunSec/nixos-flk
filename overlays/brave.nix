let version = "1.16.76";
in
final: prev: {
  brave = prev.brave.overrideAttrs (o: {
    inherit version;
    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v${version}/brave-browser_${version}_amd64.deb";
      sha256 = "sha256-K16wXOVVpIZjBSFNUkVUuDYQ+rU1K48EmXHkSh2Pb9k=";
    };
  });
}
