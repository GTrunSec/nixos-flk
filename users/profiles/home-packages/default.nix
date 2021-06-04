{ config, lib, pkgs, ... }:
let
  clean-nix-store = pkgs.writeScriptBin "clean-nix-store" (import ../bin-scripts/clean-nix-store.nix {
    home-manager = pkgs.home-manager;
  });

  lsyncd-rsync = pkgs.writeScriptBin "lsyncd-rsync" (import ../bin-scripts/lsyncd-rsync.nix { });

  LS_COLORS = pkgs.fetchgit {
    url = "https://github.com/trapd00r/LS_COLORS";
    rev = "6fb72eecdcb533637f5a04ac635aa666b736cf50";
    sha256 = "0czqgizxq7ckmqw9xbjik7i1dfwgc1ci8fvp1fsddb35qrqi857a";
  };

  ls-colors = pkgs.runCommand "ls-colors" { } ''
    mkdir -p $out/bin $out/share
    ln -s ${pkgs.coreutils}/bin/ls $out/bin/ls
    ln -s ${pkgs.coreutils}/bin/dircolors $out/bin/dircolors
    cp ${LS_COLORS}/LS_COLORS $out/share/LS_COLORS
  '';

  clj2nix = pkgs.callPackage
    (pkgs.fetchFromGitHub {
      owner = "hlolli";
      repo = "clj2nix";
      rev = "89d1cda232175b588c7774e638c9ebfaaedea0e3";
      sha256 = "sha256-IOJOxcox3/ArMpRU4oZd2PgIX6OiW+TTr4z6JvyIXPY=";
    })
    { };
in
{
  config = with lib; mkMerge [
    ##public pkgs
    (mkIf (pkgs.stdenv.isLinux || pkgs.stdenv.isDarwin) {
      home.packages = with pkgs;[
        clean-nix-store
        ls-colors
      ] ++ [
        nodePackages.node2nix
        yarn2nix
      ] ++ [
        #misc
        poetry
        fdupes
        asciinema
        bat
        nixpkgs-review
        notdeft
        poppler_utils
        dnsperf
        pet
        php
      ] ++ [
        (hunspellWithDicts [
          hunspellDicts.en-us
        ])
        aspell
        aspellDicts.en
        aspellDicts.en-computers
        aspellDicts.en-science
        opencc
      ];
    })

    (mkIf pkgs.stdenv.isLinux {
      home.packages = with pkgs;[
        dive
        clojure
        lsyncd
        compton
        lsyncd-rsync
        #clj2nix
        ffmpegthumbnailer
        python-language-server
      ];
    })
  ];
}
