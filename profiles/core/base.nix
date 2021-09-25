{ config, lib, pkgs, ... }:

{
  # environment.pathsToLink = [
  #   "/share/nix-direnv"
  # ];

  environment.systemPackages = with pkgs; [
    zsh
    zstd
    unzip
    zip
    pciutils # lspci
    psmisc # pkill, killall, pstree, fuser
    lsd
    nix-index
    # remote
    rxvt_unicode.terminfo
    ncurses.dev # infocmp/tic/etc
    # Linux/OSX/FreeBSD resource monitor
    bpytop
    # password
    pwgen
    git-crypt
    wget
    nix-output-monitor
  ];
}
