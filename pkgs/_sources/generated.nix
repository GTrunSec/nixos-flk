# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl }:
{
  HPI = {
    pname = "HPI";
    version = "0.3.20210220";
    src = fetchurl {
      sha256 = "0i1fh3lkiwwggr0p9l9nvw8a8lxmgslkd90dxm1h4cqpsbckdvln";
      url = "https://pypi.io/packages/source/H/HPI/HPI-0.3.20210220.tar.gz";
    };

  };
  StevenBlack-hosts = {
    pname = "StevenBlack-hosts";
    version = "e1b208b9baeda1e4b8f480d1213029601bd4ccff";
    src = fetchgit {
      url = "https://github.com/StevenBlack/hosts";
      rev = "e1b208b9baeda1e4b8f480d1213029601bd4ccff";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "08hvm5dbrfi1dqyjgxqaazi5bjxhg6c4gc148acjxbbn389r5naa";
    };
  };
  adguardhome = {
    pname = "adguardhome";
    version = "v0.106.3";
    src = fetchurl {
      sha256 = "11p081dqilga61zfziw5w37k6v2r84qynhz2hr4gk8367jck54x8";
      url = "https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.106.3/AdGuardHome_linux_amd64.tar.gz";
    };

  };
  chord = {
    pname = "chord";
    version = "0.2.38";
    src = fetchurl {
      sha256 = "02wzfdpz7sj38smdkwa18hpcnz2s0arf5dg2kjq46jxjqz2y92np";
      url = "https://github.com/PeterDing/chord/releases/download/v0.2.38/chord-0.2.38-linux-x86_64.AppImage";
    };

  };
  logseq = {
    pname = "logseq";
    version = "0.2.10";
    src = fetchurl {
      sha256 = "01zrdx12pvr07v8f24l2kqln5dajvjnl4rqy5f3gywn3l74lx1fm";
      url = "https://github.com/logseq/logseq/releases/download/0.2.10/logseq-linux-x64-0.2.10.AppImage";
    };
  };
  magnetw = {
    pname = "magnetw";
    version = "3.1.1";
    src = fetchurl {
      sha256 = "07qj758adfx3h6qpcwki68fc5rc0iq0ydn5246qh07bzswcrgvl9";
      url = "https://github.com/xiandanin/magnetW/releases/download/3.1.1/magnetw-3.1.1-linux.AppImage";
    };

  };
  motrix = {
    pname = "motrix";
    version = "1.6.11";
    src = fetchurl {
      sha256 = "0hsazragk4hf9hh1i1hnqhw48kl3f3sckapwzah06w9ysgn90kdl";
      url = "https://github.com/agalwood/Motrix/releases/download/v1.6.11/Motrix-1.6.11.AppImage";
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
      sha256 = "0x2dbdjnc9hb2l7hhr1zj78fxglnv81dsn1gsh0h56s5rw930v2v";
      url = "https://pypi.io/packages/source/o/orgparse/orgparse-0.2.4.tar.gz";
    };

  };
  polar-bookshelf = {
    pname = "polar-bookshelf";
    version = "2.0.103";
    src = fetchurl {
      sha256 = "093j542l7drl3bn42bnpgmvya2983q22vpydahhv1wdxds2v9jld";
      url = "https://github.com/burtonator/polar-bookshelf/releases/download/v2.0.103/polar-desktop-app-2.0.103-amd64.deb";
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
