{ pkgs, ... }:
{
        imports = [ ./mpd.nix ./dropbox.nix ./photoprism.nix ];

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
        ];
}
