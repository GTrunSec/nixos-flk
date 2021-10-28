# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub }:
{
  HPI = {
    pname = "HPI";
    version = "0.3.20210220";
    src = fetchurl {
      url = "https://pypi.io/packages/source/H/HPI/HPI-0.3.20210220.tar.gz";
      sha256 = "sha256-lu422dIXMwJD7Q2kNql+tVOkEN820XRBfo/zOOmALkQ=";
    };
  };
  StevenBlack-hosts = {
    pname = "StevenBlack-hosts";
    version = "a17811938e16c6dab3396fc463fa48c48228b487";
    src = fetchFromGitHub ({
      owner = "StevenBlack";
      repo = "hosts";
      rev = "a17811938e16c6dab3396fc463fa48c48228b487";
      fetchSubmodules = false;
      sha256 = "sha256-aQ090Q0MNFZkqwIgUsfUaP3Z87+bfiRj0C2gtTKc4+Y=";
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
  logseq = {
    pname = "logseq";
    version = "0.4.5";
    src = fetchurl {
      url = "https://github.com/logseq/logseq/releases/download/0.4.5/logseq-linux-x64-0.4.5.AppImage";
      sha256 = "sha256-EMybZH3heUWeCP74KdFr6zJY1R3hePo6RssbJXrkd9g=";
    };
  };
  logseq-darwin = {
    pname = "logseq-darwin";
    version = "0.4.4";
    src = fetchurl {
      url = "https://github.com/logseq/logseq/releases/download/0.4.4/logseq-darwin-x64-0.4.4.dmg";
      sha256 = "sha256-GupkvfaaCEgQv2NX0CH5jjfEtTFdJn2nHgHya+mQpTc=";
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
    version = "0.2.4";
    src = fetchurl {
      url = "https://pypi.io/packages/source/o/orgparse/orgparse-0.2.4.tar.gz";
      sha256 = "sha256-W2wwEs9FmwIB1C9Y3QLalr7u0JE/ZAgPFQsmZmVbTXQ=";
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
    version = "bc9d9034aa7d83c12e24c60aac50c965513ef9ae";
    src = fetchFromGitHub ({
      owner = "karlicoss";
      repo = "promnesia";
      rev = "bc9d9034aa7d83c12e24c60aac50c965513ef9ae";
      fetchSubmodules = false;
      sha256 = "sha256-/zMhaswBs1FTSxlvQI+QrbsSMkxjJoZZmzQLuAKDIyU=";
    });
  };
}
