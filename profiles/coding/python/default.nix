{pkgs, ...}: let
  my-python-packages =
    (
      pkgs.python3.withPackages (
        ps:
          with ps; [
            #emacs-eaf
            shapely
            dbus-python
            qrcode
            pyqt5
            pymupdf
            xlib
            grip
            black
            pyinotify
            pyqtwebengine
            markdown
            feedparser
            retrying
            epc
            ###
            pytest
            #orgparse
            pytest
            #voila
            pygments
            #orgbabelhelper
            jupyterlab
            pdftotext
          ]
      )
    )
    .override (args: {ignoreCollisions = true;});
in {
  environment.systemPackages = with pkgs; [
    my-python-packages
    nodePackages.pyright
    promnesia
    orgparse
  ];
}
