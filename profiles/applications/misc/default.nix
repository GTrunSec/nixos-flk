{ pkgs, ... }: {
    imports = [ ./mpd.nix ];
    environment.systemPackages = with pkgs; [
        goldendict
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

        #browwser
        brave

        #book
        polar-bookshelf
        #git manager  UI
        gitkraken
        gitAndTools.delta
    ];
}
