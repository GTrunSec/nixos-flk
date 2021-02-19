{ pkgs, ... }:
{
  imports = [ ./mpd.nix ./dropbox.nix ./photoprism.nix ];

  environment.systemPackages = with pkgs; [
    goldendict
    flameshot
    #downloader
    magnetw
    got
    aria2
    motrix
    #VPN
    shadowsocks-qt5
    # manager password
    gopass
    enpass
    onepassword
    #media
    vlc
    #plex-media-player
    youtube-dl
    cmus
    mpc_cli
    #image
    pqiv
    digikam
    phototonic
    photoqt
    #tools
    tree
    desktop-file-utils
    # TMSU lets you tags your files and then access them through a nifty virtual filesystem from any other application.
    tmsu
    nuclear
    ytmdesktop
    gitAndTools.delta
    ##
    sshfs
    wakatime
    #
    xclip
    screenfetch
    urxvt_perls
    #disk
    duf
    #office
    onlyoffice-desktopeditors
    #video
    tenvideo
  ];
}
