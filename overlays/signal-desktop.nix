let version = "1.34.5";
in
final: prev: {
  signal-desktop = prev.signal-desktop.overrideAttrs (o: {
    inherit version;
    src = prev.fetchurl {
      url = "https://updates.signal.org/desktop/apt/pool/main/s/signal-desktop/signal-desktop_${version}_amd64.deb";
      sha256 = "sha256-4VHErF8VdLtnGtKXHn9gdh2KnO4uAkNycnpHN7OeFuk=";
    };
  });
}
