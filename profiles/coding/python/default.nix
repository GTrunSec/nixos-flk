{pkgs, ...}: let
  wenls = pkgs.fetchFromGitHub {
    owner = "metaescape";
    repo = "Wen";
    rev = "25a815217d5234e9e28c18e740e1aa5e74690208";
    sha256 = "sha256-2kFiaPZnc5Y7jaCJTG50bgFWhs6mejKqeumqwg44XP8=";
  };
  my-python-packages =
    (
      pkgs.python3Override.withPackages (
        ps:
          with ps; [
            #emacs-eaf
            shapely
            dbus-python
            qrcode
            pymupdf
            xlib
            grip
            black
            pyinotify
            pyqt5
            pyqtwebengine
            pyqt6
            pyqt6-webengine
            markdown
            feedparser
            retrying
            epc
            orjson
            ###
            pytest
            #orgparse
            pytest
            #voila
            pygments
            # orgbabelhelper
            # jupyterlab
            pdftotext
            pypinyin
            pygls
          ]
      )
    )
    .override (args: {ignoreCollisions = true;});
in {
  environment.variables = {
     QT_QPA_PLATFORM_PLUGIN_PATH = "${pkgs.qt6.qtbase.outPath}/lib/qt-${pkgs.qt6.qtbase.version}/plugins";
   };

  environment.systemPackages = with pkgs; [
    my-python-packages
    nodePackages.pyright
    promnesia
    orgparse
    (
      pkgs.writeShellScriptBin "wenls" ''
        ${my-python-packages}/bin/python3 ${wenls}/server.py
      ''
    )
  ];
}
