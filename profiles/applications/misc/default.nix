{ pkgs, ... }:
{
  imports = [ ./mpd.nix ./dropbox.nix ./photoprism.nix ];

  environment.systemPackages = with pkgs; [
    goldendict
    flameshot
    du-dust
    #downloader
    magnetw
    got
    aria2
    motrix
    #VPN
    outline-client
    shadowsocks-libev
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
    chord
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
