{ lib
, python3Packages
, fetchurl
}:
with python3Packages;
python3Packages.buildPythonPackage rec {
  pname = "HPI";
  version = "0.3.20210220";
  src = fetchPypi {
    inherit pname version;
    sha256 = "96ee36d9d217330243ed0da436a97eb553a410df36d174417e8ff338e9802e44";
  };

  propagatedBuildInputs = with python3Packages; [
    pandas
    appdirs
    more-itertools
    mypy
    decorator
    setuptools_scm
  ];

  makeWrapperArgs = [ "--prefix PYTHONPATH : $PYTHONPATH" ];


  doCheck = false;

  meta = with lib; {
    description = "Human Programming Interface 🧑👽🤖";
    homepage = "https://github.com/karlicoss/HPI";
    license = licenses.asl20;
    maintainers = with maintainers; [ gtrunsec ];
  };

}
