{ stdenv
, python3Packages
, fetchurl 
}:
python3Packages.buildPythonPackage rec {

  pname = "HPI";
  version = "0.2.20200820";

  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "0r6dfsyz6ix1pbf4gr5inn5srwaz37cbw79705sz936kigg9fay5";
  };  

  propagatedBuildInputs = with python3Packages; [ pandas
                                                  appdirs
                                                  more-itertools
                                                  mypy
                                                ];

  makeWrapperArgs = [ "--prefix PYTHONPATH : $PYTHONPATH" ];


  doCheck = false;
  
  meta = with stdenv.lib; {
    description = "Human Programming Interface 🧑👽🤖";
    homepage = "https://github.com/karlicoss/HPI";
    license = licenses.asl20;
    maintainers = with maintainers; [ gtrunsec ];
  };

}
