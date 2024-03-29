# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub }:
{
  kitty-darwin = {
    pname = "kitty-darwin";
    version = "0.26.3";
    src = fetchurl {
      url = "https://github.com/kovidgoyal/kitty/releases/download/v0.26.3/kitty-0.26.3.dmg";
      sha256 = "sha256-slgdXB8I1cZxjcSFDM/DA1RYjdkPeoG8RsVDacxyXVA=";
    };
  };
  logseq = {
    pname = "logseq";
    version = "0.8.8";
    src = fetchurl {
      url = "https://github.com/logseq/logseq/releases/download/0.8.8/logseq-linux-x64-0.8.8.AppImage";
      sha256 = "sha256-0RVGTANlnzULusQPZ14+a6G5mK1ezDC9VfWWdNqNcs4=";
    };
  };
  logseq-darwin = {
    pname = "logseq-darwin";
    version = "0.8.8";
    src = fetchurl {
      url = "https://github.com/logseq/logseq/releases/download/0.8.8/logseq-darwin-x64-0.8.8.dmg";
      sha256 = "sha256-kOno88J92QTh8t6p7SWCwW6QR5V7ki+gSyAeRqj9zbg=";
    };
  };
}
