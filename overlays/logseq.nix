let version = "0.0.4";
in
final: prev: {
  logseq = prev.logseq.overrideAttrs (_: rec{
    inherit version;
    src = prev.fetchurl {
      url = "https://github.com/logseq/logseq/releases/download/${version}/logseq-linux-x64-${version}.AppImage";
      sha256 = "sha256-dR2Xz2CVEB7BrgbFIXQGmfyidzWsW3YZNnw3rEJ0T7U=";
    };
  });
}
