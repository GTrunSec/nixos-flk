{
  pkgs,
  python3,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # emacs python
    #emacs eaf
    qt5.qtbase
    wmctrl
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

  # Configure aspell system wide
  environment.etc."aspell.conf".text = ''
    master en_US
    extra-dicts en-computers.rws
    add-extra-dicts en_US-science.rws
  '';
}
