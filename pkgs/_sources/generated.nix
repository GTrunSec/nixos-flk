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
    version = "71def412efc8225bb8aa01c9ba867607bd5b347c";
    src = fetchFromGitHub ({
      owner = "StevenBlack";
      repo = "hosts";
      rev = "71def412efc8225bb8aa01c9ba867607bd5b347c";
      fetchSubmodules = false;
      sha256 = "sha256-y0GpSlUBJb7qbXdLm7m5dSGk4gKYw25MWoSg4RS/m90=";
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
    version = "15.8.7";
    src = fetchurl {
      url = "https://github.com/jgraph/drawio-desktop/releases/download/v15.8.7/drawio-x86_64-15.8.7.rpm";
      sha256 = "sha256-Uy+ZJrSwVcu3Qad41X30LGXFr4LQqIKehzJOteggJeM=";
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
    version = "0.5.2";
    src = fetchurl {
      url = "https://github.com/logseq/logseq/releases/download/0.5.2/logseq-linux-x64-0.5.2.AppImage";
      sha256 = "sha256-IP3Yh+/iWZ5XbMGNs5NKJQcp9DyRWCWKGJuTvuegHUU=";
    };
  };
  logseq-darwin = {
    pname = "logseq-darwin";
    version = "0.5.2";
    src = fetchurl {
      url = "https://github.com/logseq/logseq/releases/download/0.5.2/logseq-darwin-x64-0.5.2.dmg";
      sha256 = "sha256-95OhciWFo2U/SWpn9JqbCG4CYsxtS7dOqajQMxOOt4E=";
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
    src = fetchFromGitHub ({
      owner = "hasu";
      repo = "notdeft";
      rev = "1b7054dcfc3547a7cafeb621552cec01d0540478";
      fetchSubmodules = false;
      sha256 = "sha256-LMMLJFVpmoE/y3MqrgY2fmsehmzk6TkLsVoHmFUxiSw=";
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
    version = "4807ebfe7bac92d6c0a7dad9b1569fa0a63bb4d3";
    src = fetchFromGitHub ({
      owner = "karlicoss";
      repo = "promnesia";
      rev = "4807ebfe7bac92d6c0a7dad9b1569fa0a63bb4d3";
      fetchSubmodules = false;
      sha256 = "sha256-91Zp0WI6C/7wSjkgQYMACj/GhGDBAzj4dFKMUxiuuaU=";
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
