# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub }:
{
  logseq = {
    pname = "logseq";
    version = "0.6.5";
    src = fetchurl {
      url = "https://github.com/logseq/logseq/releases/download/nightly/logseq-linux-x64-0.6.5+nightly.20220415.AppImage";
      sha256 = "sha256-AWj06sQM6mX0iHhdfK8p7xuksHbsHapPt9wvBoIzyIU=";
    };
  };
  logseq-darwin = {
    pname = "logseq-darwin";
    version = "0.6.5";
    src = fetchurl {
      url = "https://github.com/logseq/logseq/releases/download/0.6.5/logseq-darwin-x64-0.6.5.dmg";
      sha256 = "sha256-Mic8R50Fp2OmfpEhulSKrzmNqKFauYEWooGyltAsfxc=";
    };
  };
}
