let version = "1.32.1";
in
final: prev: {
  signal-desktop = prev.signal-desktop.overrideAttrs (o: {
    inherit version;
    src = prev.fetchurl {
      url = "https://updates.signal.org/desktop/apt/pool/main/s/signal-desktop/signal-desktop_${version}_amd64.deb";
            sha256 = "0sfzz1z57l20prj2s8hdl8ip1hrlzb5fqnccqcfd101a6mjnp9i9";
    };
  });
}
