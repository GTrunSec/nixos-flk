{ config, lib, pkgs, ... }:

{
  imports = [ ];

  nix = {

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };


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
    #remote
    rxvt_unicode.terminfo
    ncurses.dev # infocmp/tic/etc

    #password
    pwgen
    git-crypt
    wget
    nix-output-monitor
  ];
}
