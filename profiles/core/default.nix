{ self, config, lib, pkgs, ... }:
let inherit (lib) fileContents;
in
{
  imports = [ ../cachix ./base.nix ./nix.nix ./sysctl.nix ./shell.nix ];

  boot.kernelPackages = pkgs.linuxPackages_5_15;

  environment = {

    systemPackages = with pkgs; [
      binutils
      coreutils
      curl
      direnv
      dnsutils
      dosfstools
      fd
      git
      git-town
      gotop
      gptfdisk
      iputils
      jq
      manix
      moreutils
      nix-index
      nmap
      ripgrep
      skim
      tealdeer
      usbutils
      utillinux
      whois
      cachix
      zstd
      unzip
      zip
      pciutils # lspci
      psmisc # pkill, killall, pstree, fuser
      lsd
      # remote
      rxvt_unicode.terminfo
      ncurses.dev # infocmp/tic/etc
      # Linux/OSX/FreeBSD resource monitor
      bpytop
      # password
      pwgen
      wget
      nix-output-monitor
      nix-top
      zsh
    ];
  };
}
