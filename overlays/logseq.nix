let version = "0.0.1";
in
final: prev: {
  logseq = prev.logseq.overrideAttrs (_: rec{
    inherit version;
    src = prev.fetchurl {
      url = "https://github.com/logseq/logseq/releases/download/${version}/logseq-linux-x64-${version}.AppImage";
      sha256 = "sha256-CciWP0ELmjX7tgUJMdHkCjjTJnZ3gwtKVX2dt41eUbY=";
    };
  });
}