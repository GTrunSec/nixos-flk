let version = "1.38.2";
in
final: prev: {
  signal-desktop = prev.signal-desktop.overrideAttrs (o: {
    inherit version;
    src = prev.fetchurl {
      url = "https://updates.signal.org/desktop/apt/pool/main/s/signal-desktop/signal-desktop_${version}_amd64.deb";
      sha256 = "sha256-xJbxx/wGIbpWYcAHsG6MPlOzlH0QJtEwrJN4YA4YCNM=  ";
    };
  });
}
