{ pkgs, python3, ... }:
let
    emacs-eaf-python-packages = python-packages: with python-packages; [
        shapely
        dbus-python
        qrcode
        pyqt5
        pymupdf
        xlib
        grip
        pyinotify
        pyqtwebengine
        markdown
        feedparser
        ##
    ];
    python-with-emacs-packages = pkgs.python37.withPackages emacs-eaf-python-packages;
in
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
