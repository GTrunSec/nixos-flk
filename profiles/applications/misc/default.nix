{ pkgs, ... }:
{
    imports = [ ./mpd.nix ./dropbox.nix ];

    environment.systemPackages = with pkgs; [
        goldendict
        #downloader
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
        mpv
        youtube-dl
        cmus
        mpc_cli
        nuclear
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
