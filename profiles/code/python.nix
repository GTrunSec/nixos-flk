{ pkgs, ... }:
let
  my-python-packages = (pkgs.python3.withPackages (ps: with ps;[
    #emacs-eaf
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

    ###
    pytest
    numpy
    #orgparse
    pytest
    scikitlearn
    #zat
    matplotlib
    sqlalchemy
    pandas
    #voila
    pygments
    #orgbabelhelper
    jupyter
    jupyterlab
    ])).override (args: { ignoreCollisions = true;});
in
{
  environment.systemPackages = with pkgs; [
    my-python-packages
    wakatime
    nodePackages.pyright
    promnesia
    orgparse
  ];
}
