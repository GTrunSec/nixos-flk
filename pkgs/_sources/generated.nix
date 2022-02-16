# This file was generated by nvfetcher, please do not modify it manually.
{
  fetchgit,
  fetchurl,
  fetchFromGitHub,
}:
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
    version = "b6fd01f620ad79dbee93f4fff42f1923e7c25a54";
    src = fetchFromGitHub (
      {
        owner = "StevenBlack";
        repo = "hosts";
        rev = "b6fd01f620ad79dbee93f4fff42f1923e7c25a54";
        fetchSubmodules = false;
        sha256 = "sha256-+qTmSQBsE2nGLrP3TztfRWomZwG20ynPSkZu2JLKcYs=";
      }
    );
  };
  adguardhome = {
    pname = "adguardhome";
    version = "v0.107.0";
    src = fetchurl {
      url = "https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.0/AdGuardHome_linux_amd64.tar.gz";
      sha256 = "sha256-g2DIeXwaqTTfshYyyDNHbOU57YUbuxXDKJHFqKFrqzw=";
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
    version = "16.0.2";
    src = fetchurl {
      url = "https://github.com/jgraph/drawio-desktop/releases/download/v16.0.2/drawio-x86_64-16.0.2.rpm";
      sha256 = "sha256-mAr2DqU/0MJVz6P6qUB7FGZYB06kEbxJH1OgRzUrW2Y=";
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
    version = "0.5.5";
    src = fetchurl {
      url = "https://github.com/logseq/logseq/releases/download/nightly/logseq-linux-x64-0.5.5+nightly.20211225.AppImage";
      sha256 = "sha256-nQ31JkqgzLC1b8lTcH7h/AkiuLiyIH2aQCr0gSruyfM=";
    };
  };
  logseq-darwin = {
    pname = "logseq-darwin";
    version = "0.5.5";
    src = fetchurl {
      url = "https://github.com/logseq/logseq/releases/download/nightly/logseq-darwin-x64-0.5.5+nightly.20211225.dmg";
      sha256 = "sha256-F7z6Vy2vb/Wx926Ynga6P5tyL8eASKZ2SKxK6DHnUow=";
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
    version = "1b7054dcfc3547a7cafeb621552cec01d0540478";
    src = fetchFromGitHub (
      {
        owner = "hasu";
        repo = "notdeft";
        rev = "1b7054dcfc3547a7cafeb621552cec01d0540478";
        fetchSubmodules = false;
        sha256 = "sha256-LMMLJFVpmoE/y3MqrgY2fmsehmzk6TkLsVoHmFUxiSw=";
      }
    );
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
    version = "570cce0d1717885893128b28030080ec0bc2657a";
    src = fetchFromGitHub (
      {
        owner = "karlicoss";
        repo = "promnesia";
        rev = "570cce0d1717885893128b28030080ec0bc2657a";
        fetchSubmodules = false;
        sha256 = "sha256-W6b289Z3sUdsiKITH8TQd8hsgJu5mN6nuw4rmAkTOeA=";
      }
    );
  };
  spaceship-prompt = {
    pname = "spaceship-prompt";
    version = "07d71d162f135cc7c7d58103bc3a605d9a43977a";
    src = fetchFromGitHub (
      {
        owner = "spaceship-prompt";
        repo = "spaceship-prompt";
        rev = "07d71d162f135cc7c7d58103bc3a605d9a43977a";
        fetchSubmodules = false;
        sha256 = "sha256-2ZQBN+AOZvkSbV3qlUTNOu2UULHoEz26/RnZEB6bs5Y=";
      }
    );
  };
}
