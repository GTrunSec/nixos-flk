# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub }:
{
  HPI = {
    pname = "HPI";
    version = "0.3.20220607";
    src = fetchurl {
      url = "https://pypi.io/packages/source/H/HPI/HPI-0.3.20220607.tar.gz";
      sha256 = "sha256-GME0Z+TH/6U+smFkuk1sT8UBzlySv5/yGhb42Kiaj8w=";
    };
  };
  StevenBlack-hosts = {
    pname = "StevenBlack-hosts";
    version = "1a293025de415dd8127557bdd0bb3fb7f9ad0cce";
    src = fetchFromGitHub ({
      owner = "StevenBlack";
      repo = "hosts";
      rev = "1a293025de415dd8127557bdd0bb3fb7f9ad0cce";
      fetchSubmodules = false;
      sha256 = "sha256-UmrjsvO8nSxQTnbW+OhXamgZ7TPUjK8xqeQE3gm9VwU=";
    });
  };
  adguardhome = {
    pname = "adguardhome";
    version = "v0.107.7";
    src = fetchurl {
      url = "https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.7/AdGuardHome_linux_amd64.tar.gz";
      sha256 = "sha256-cbTlVBlGdFgEz2b6pb0SJ7yUf4wFXnZwLCkmvX75FzU=";
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
    version = "19.0.3";
    src = fetchurl {
      url = "https://github.com/jgraph/drawio-desktop/releases/download/v19.0.3/drawio-x86_64-19.0.3.rpm";
      sha256 = "sha256-vkVtOWoZ3LiIGtS/8xUZcwauBcyl5HMyoeWtVylIYU4=";
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
    version = "0.3.1";
    src = fetchurl {
      url = "https://pypi.io/packages/source/o/orgparse/orgparse-0.3.1.tar.gz";
      sha256 = "sha256-hg5vu5pnt0K6p5LmD4zBhSLpeJwGXSaCHAIoXV/BBK8=";
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
    version = "346b2e08e04604adffb17ae51244cd1b1ec9015f";
    src = fetchFromGitHub ({
      owner = "karlicoss";
      repo = "promnesia";
      rev = "346b2e08e04604adffb17ae51244cd1b1ec9015f";
      fetchSubmodules = false;
      sha256 = "sha256-GcLPJZQaHqPUGvcZMNlofwqTizh5/PywA4vY9N3Ih7s=";
    });
  };
  spaceship-prompt = {
    pname = "spaceship-prompt";
    version = "b3be570a8166d824c4b1e84f1fb3a21444338ff9";
    src = fetchFromGitHub ({
      owner = "spaceship-prompt";
      repo = "spaceship-prompt";
      rev = "b3be570a8166d824c4b1e84f1fb3a21444338ff9";
      fetchSubmodules = false;
      sha256 = "sha256-WzECATaDst4xO4vCaYP+DL8t+9gm2sor1Q8OCzKHmKE=";
    });
  };
}
