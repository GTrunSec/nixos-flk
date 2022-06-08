{pkgs, ...}: {
  imports = [./mpd.nix ./photoprism.nix ./image.nix];

  environment.systemPackages = with pkgs; [
    goldendict
    flameshot
    du-dust
    # graph
    drawio
    #downloader
    magnetw
    got
    aria2
    motrix
    #VPN
    shadowsocks-libev
    # manager password
    gopass
    _1password-gui
    _1password
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
    #ytmdesktop
    gitAndTools.delta
    ##
    sshfs
    zotero
    # export permission issue
    (
      pkgs.writeShellScriptBin "logseq-run" ''
         export XDG_DATA_DIRS=${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:$XDG_DATA_DIRS
        ${pkgs.appimage-run}/bin/appimage-run ${pkgs.sources.logseq.src}
      ''
    )
    xclip
    screenfetch
    urxvt_perls
    #disk
    duf
    #office
    #video
    tenvideo
    zoom-us
    jitsi-meet-electron
    #git workflow manager
    gst
    ghq
    peco

    # pdf reader
    okular
    onlyoffice-bin
  ];
}
