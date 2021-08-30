# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl }:
{
  HPI = {
    pname = "HPI";
    version = "0.3.20210220";
    src = fetchurl {
      url = "https://pypi.io/packages/source/H/HPI/HPI-0.3.20210220.tar.gz";
      sha256 = "0i1fh3lkiwwggr0p9l9nvw8a8lxmgslkd90dxm1h4cqpsbckdvln";
    };
  };
  StevenBlack-hosts = {
    pname = "StevenBlack-hosts";
    version = "6f75f8cfe9569aff68e45edaa5d860dfdaea0e5a";
    src = fetchgit {
      url = "https://github.com/StevenBlack/hosts";
      rev = "6f75f8cfe9569aff68e45edaa5d860dfdaea0e5a";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "0f77hlgnfi3z03k7310zwfp00n0kslzrma5ka7rs3xpyqzr42rdh";
    };
  };
  adguardhome = {
    pname = "adguardhome";
    version = "v0.106.3";
    src = fetchurl {
      url = "https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.106.3/AdGuardHome_linux_amd64.tar.gz";
      sha256 = "11p081dqilga61zfziw5w37k6v2r84qynhz2hr4gk8367jck54x8";
    };
  };
  chord = {
    pname = "chord";
    version = "0.2.38";
    src = fetchurl {
      url = "https://github.com/PeterDing/chord/releases/download/v0.2.38/chord-0.2.38-linux-x86_64.AppImage";
      sha256 = "02wzfdpz7sj38smdkwa18hpcnz2s0arf5dg2kjq46jxjqz2y92np";
    };
  };
  logseq = {
    pname = "logseq";
    version = "0.3.6";
    src = fetchurl {
      url = "https://github.com/logseq/logseq/releases/download/0.3.6/logseq-linux-x64-0.3.6.AppImage";
      sha256 = "0zm6hd2a8lj4f83yzs3mcwm4qrx8hvc680n9rmzgbpijsc4im475";
    };
  };
  logseq-darwin = {
    pname = "logseq-darwin";
    version = "0.3.6";
    src = fetchurl {
      url = "https://github.com/logseq/logseq/releases/download/0.3.6/logseq-darwin-x64-0.3.6.dmg";
      sha256 = "1v9z0100cdbrw7jpfj9xlf2xyvn8699hbd9jjid722fq6yqjag99";
    };
  };
  magnetw = {
    pname = "magnetw";
    version = "3.1.1";
    src = fetchurl {
      url = "https://github.com/xiandanin/magnetW/releases/download/3.1.1/magnetw-3.1.1-linux.AppImage";
      sha256 = "07qj758adfx3h6qpcwki68fc5rc0iq0ydn5246qh07bzswcrgvl9";
    };
  };
  motrix = {
    pname = "motrix";
    version = "1.6.11";
    src = fetchurl {
      url = "https://github.com/agalwood/Motrix/releases/download/v1.6.11/Motrix-1.6.11.AppImage";
      sha256 = "0hsazragk4hf9hh1i1hnqhw48kl3f3sckapwzah06w9ysgn90kdl";
    };
  };
  notdeft = {
    pname = "notdeft";
    version = "9740eceae6929c62da81f9e19646412d01e88def";
    src = fetchgit {
      url = "https://github.com/hasu/notdeft";
      rev = "9740eceae6929c62da81f9e19646412d01e88def";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "064pcb57vg1hpkhg2k13bm9svl0ck0mmgf33q6v12za7vpc4bmkf";
    };
  };
  orgparse = {
    pname = "orgparse";
    version = "0.2.4";
    src = fetchurl {
      url = "https://pypi.io/packages/source/o/orgparse/orgparse-0.2.4.tar.gz";
      sha256 = "0x2dbdjnc9hb2l7hhr1zj78fxglnv81dsn1gsh0h56s5rw930v2v";
    };
  };
  polar-bookshelf = {
    pname = "polar-bookshelf";
    version = "2.0.103";
    src = fetchurl {
      url = "https://github.com/burtonator/polar-bookshelf/releases/download/v2.0.103/polar-desktop-app-2.0.103-amd64.deb";
      sha256 = "093j542l7drl3bn42bnpgmvya2983q22vpydahhv1wdxds2v9jld";
    };
  };
  promnesia = {
    pname = "promnesia";
    version = "03f46b7e0740790ef091e6f48d0ac2e6bf05bcb7";
    src = fetchgit {
      url = "https://github.com/karlicoss/promnesia";
      rev = "03f46b7e0740790ef091e6f48d0ac2e6bf05bcb7";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "1v36s0kd0375zv70gpqqdk0ngx4m98jjcwa3kpgbsbmmpvqvch95";
    };
  };
}
