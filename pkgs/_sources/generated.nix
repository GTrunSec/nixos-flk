# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub }:
{
  HPI = {
    pname = "HPI";
    version = "0.3.20211031";
    src = fetchurl {
      url = "https://pypi.io/packages/source/H/HPI/HPI-0.3.20211031.tar.gz";
      sha256 = "sha256-pkLLEqdMXhVFI2vmtPO5nRciQ8SS/7T0cGZXgl6Gni8=";
    };
  };
  StevenBlack-hosts = {
    pname = "StevenBlack-hosts";
    version = "56312e0607d9057689c93825c4a2f82d657eaabf";
    src = fetchFromGitHub ({
      owner = "StevenBlack";
      repo = "hosts";
      rev = "56312e0607d9057689c93825c4a2f82d657eaabf";
      fetchSubmodules = false;
      sha256 = "sha256-XrLwEdVlFg+7g9+JnMoezHimYSKUJsFFxtkcIZj8NAY=";
    });
  };
  adguardhome = {
    pname = "adguardhome";
    version = "v0.106.3";
    src = fetchurl {
      url = "https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.106.3/AdGuardHome_linux_amd64.tar.gz";
      sha256 = "sha256-qJMymTxmoPlIhuJD6zFBWWwzz+CFx+9+MOrRiFtA4IY=";
    };
  };
  chord = {
    pname = "chord";
    version = "0.2.38";
    src = fetchurl {
      url = "https://github.com/PeterDing/chord/releases/download/v0.2.38/chord-0.2.38-linux-x86_64.AppImage";
      sha256 = "sha256-14rkxceyS0OwnOK14rICWnzLLkRB8dmqRkPq829znws=";
    };
  };
  drawio = {
    pname = "drawio";
    version = "15.8.4";
    src = fetchurl {
      url = "https://github.com/jgraph/drawio-desktop/releases/download/v15.8.4/drawio-x86_64-15.8.4.rpm";
      sha256 = "sha256-RwjHJ7Uchaa3ehtypAdaGyRiiq5CMCID5m9wQgNpJhY=";
    };
  };
  hug = {
    pname = "hug";
    version = "2.6.1";
    src = fetchurl {
      url = "https://pypi.io/packages/source/h/hug/hug-2.6.1.tar.gz";
      sha256 = "sha256-sO2s4qy2GIc3ecnObs+RZdtU/vlcIiYvVwD83Z/rrsk=";
    };
  };
  logseq = {
    pname = "logseq";
    version = "0.5.1";
    src = fetchurl {
      url = "https://github.com/logseq/logseq/releases/download/0.5.1/logseq-linux-x64-0.5.1.AppImage";
      sha256 = "sha256-/ZI9kK/9bYRJL8jOyRKpdMcy4Cbau+a28AO+kTUl+SE=";
    };
  };
  logseq-darwin = {
    pname = "logseq-darwin";
    version = "0.5.1";
    src = fetchurl {
      url = "https://github.com/logseq/logseq/releases/download/0.5.1/logseq-darwin-x64-0.5.1.dmg";
      sha256 = "sha256-V05vQ1PjOyKuh8bNogCEmQmZLsHD5Q6p+gxrCuQFWvY=";
    };
  };
  magnetw = {
    pname = "magnetw";
    version = "3.1.1";
    src = fetchurl {
      url = "https://github.com/xiandanin/magnetW/releases/download/3.1.1/magnetw-3.1.1-linux.AppImage";
      sha256 = "sha256-ie6XGdd/HQCxIaLY5gGOgOXCHDJxcnaxgaO7plA5Eh8=";
    };
  };
  motrix = {
    pname = "motrix";
    version = "1.6.11";
    src = fetchurl {
      url = "https://github.com/agalwood/Motrix/releases/download/v1.6.11/Motrix-1.6.11.AppImage";
      sha256 = "sha256-tE2Q7NM+cQOg+vyqyfRwg05EOMQWhhggTA6S+VT+SkM=";
    };
  };
  notdeft = {
    pname = "notdeft";
    version = "35917b422c8a59db6cdaa2ca665ffa90745b2378";
    src = fetchFromGitHub ({
      owner = "hasu";
      repo = "notdeft";
      rev = "35917b422c8a59db6cdaa2ca665ffa90745b2378";
      fetchSubmodules = false;
      sha256 = "sha256-7VFCtl2Luv8zvVFMsoNFRMXY9CMzn8UNp4rHcpSKN5E=";
    });
  };
  orgparse = {
    pname = "orgparse";
    version = "0.3.0";
    src = fetchurl {
      url = "https://pypi.io/packages/source/o/orgparse/orgparse-0.3.0.tar.gz";
      sha256 = "sha256-4VjRMlOphyb8IKppnSsTuRLQB0kcPHqBKUnVPN4lO5I=";
    };
  };
  polar-bookshelf = {
    pname = "polar-bookshelf";
    version = "2.0.103";
    src = fetchurl {
      url = "https://github.com/burtonator/polar-bookshelf/releases/download/v2.0.103/polar-desktop-app-2.0.103-amd64.deb";
      sha256 = "sha256-jcq0hW698bAhVM3fLQQeKAnld33XLkHsGjS3QwUpciQ=";
    };
  };
  polar-darwin = {
    pname = "polar-darwin";
    version = "2.0.103";
    src = fetchurl {
      url = "https://github.com/burtonator/polar-bookshelf/releases/download/v2.0.103/Polar-2.0.103.dmg";
      sha256 = "sha256-DCg5myqgcdOW9P7jq81QqDnfjwozlUq43gltZVjCrXI=";
    };
  };
  promnesia = {
    pname = "promnesia";
    version = "5b8fb0121e1499782a95f5de775bc61c0f95342f";
    src = fetchFromGitHub ({
      owner = "karlicoss";
      repo = "promnesia";
      rev = "5b8fb0121e1499782a95f5de775bc61c0f95342f";
      fetchSubmodules = false;
      sha256 = "sha256-AVx7zaLDBIy/3ivilZqkOjxW1OaEniL9kSEFGyfcaAM=";
    });
  };
  spaceship-prompt = {
    pname = "spaceship-prompt";
    version = "68fcf09462d01628348efa4b5baeefc78e319743";
    src = fetchFromGitHub ({
      owner = "spaceship-prompt";
      repo = "spaceship-prompt";
      rev = "68fcf09462d01628348efa4b5baeefc78e319743";
      fetchSubmodules = false;
      sha256 = "sha256-sXnL57g5e7KboLXHzXxSD0+8aKPNnTX6Q2yVft+Pr7w=";
    });
  };
}
