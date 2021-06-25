final: prev:
let
  python-packages-custom = prev.machLib.mkPython rec {
    ignoreDataOutdated = true;
    requirements = ''
      mkdocs-material
      mkdocs-awesome-pages-plugin
      setuptools
    '';
  };
in
{ inherit python-packages-custom; }
