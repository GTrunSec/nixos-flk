{ pkgs, ... }:
{
    imports = [ ./mpd.nix ./dropbox.nix ];

    environment.systemPackages = with pkgs; [
        goldendict
        #downloader
        aria2
        motrix
        #VPN
        shadowsocks-qt5
        # manager password
        gopass
        enpass
        #media
        mpv
        youtube-dl
        cmus
        mpc_cli
        #tools
        tree
        desktop-file-utils
        # TMSU lets you tags your files and then access them through a nifty virtual filesystem from any other application.
        tmsu

        gitAndTools.delta
        ##
        sshfs
        wakatime
        #
        xclip
        screenfetch
        urxvt_perls


    ];
}
