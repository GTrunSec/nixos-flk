{ lib
, python3Packages
, fetchurl
}:
python3Packages.buildPythonPackage rec {

  pname = "orgparse";
  version = "0.2.3";

  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "sha256-CfQgDzKGpIvl9UjdfneHBrw+FOB4ZhGBMogIv+7YyWU=";
  };

  propagatedBuildInputs = with python3Packages; [
    setuptools_scm
  ];

  doCheck = false;

  meta = with lib; {
    description = "Python module for reading Emacs org-mode files";
    homepage = "https://github.com/karlicoss/orgparse";
    license = licenses.asl20;
    maintainers = with maintainers; [ gtrunsec ];
  };

}
