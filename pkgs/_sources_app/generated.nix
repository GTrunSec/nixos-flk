# This file was generated by nvfetcher, please do not modify it manually.
{
  fetchgit,
  fetchurl,
  fetchFromGitHub,
}: {
  logseq = {
    pname = "logseq";
    version = "0.6.3";
    src = fetchurl {
      url = "https://github.com/logseq/logseq/releases/download/0.6.3/logseq-linux-x64-0.6.3.AppImage";
      sha256 = "sha256-o3tBHk7bauNczz6lPS3lV0mpYEaBa0lh/mAJKJM2eWU=";
    };
  };
  logseq-darwin = {
    pname = "logseq-darwin";
    version = "0.6.3";
    src = fetchurl {
      url = "https://github.com/logseq/logseq/releases/download/0.6.3/logseq-darwin-x64-0.6.3.dmg";
      sha256 = "sha256-zYa+AhAnN1DHeVjy4ku/BWc1/0dIryeAgY+lOM3yJAo=";
    };
  };
}
