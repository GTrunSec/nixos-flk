{ pkgs, python3, ... }:
{
    environment.systemPackages = with pkgs; [
        # emacs python
        #emacs eaf
        qt5.qtbase
        lxqt.qtermwidget
        libvterm
        libtool
        scrot
        # TCLAP - Templatized Command Line Argument Parser
        tclap
        autojump
        hunspell
        #search eng
        xapian
        ncat
        ag
    ];
}
