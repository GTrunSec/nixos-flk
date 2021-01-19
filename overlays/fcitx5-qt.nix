final: prev: {
  fcitx5-qt = prev.libsForQt5.fcitx5-qt.overrideAttrs (o: {
    preConfigure = ''
    substituteInPlace qt5/platforminputcontext/CMakeLists.txt \
    --replace \$"{CMAKE_INSTALL_QT5PLUGINDIR}" $out/${prev.qt5.qtbase.qtPluginPrefix}
    '';
  });
  fcitx5-chinese-addons = prev.fcitx5-chinese-addons.override { fcitx5-qt = final.fcitx5-qt; };
  fcitx5-with-addons = prev.fcitx5-with-addons.override { fcitx5-qt = final.fcitx5-qt; };
}
