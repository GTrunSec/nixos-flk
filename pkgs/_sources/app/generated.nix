# This file was generated by nvfetcher, please do not modify it manually.
{
  fetchgit,
  fetchurl,
  fetchFromGitHub,
}: {
  logseq = {
    pname = "logseq";
    version = "0.7.0";
    src = fetchurl {
      url = "https://github.com/logseq/logseq/releases/download/nightly/logseq-linux-x64-0.7.0+nightly.20220525.AppImage";
      sha256 = "sha256-ga3zsFH0zoXzBLpdxMXpUipGkAK9AaNUPeUJX0folnE=";
    };
  };
  logseq-darwin = {
    pname = "logseq-darwin";
    version = "0.7.0";
    src = fetchurl {
      url = "https://github.com/logseq/logseq/releases/download/0.7.0/logseq-darwin-x64-0.7.0.dmg";
      sha256 = "sha256-qKm2mm6569R/xeDW1doPtwCJbj7v1POCmkIOHeXcIR4=";
    };
  };
}
