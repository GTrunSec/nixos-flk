{ stdenv
, python3Packages
, fetchurl
}:
python3Packages.buildPythonPackage rec {

  pname = "orgparse";
  version = "v0.1.2";

  src = fetchurl {
    url = "https://github.com/karlicoss/orgparse/archive/${version}.tar.gz";
    sha256 = "0qng9aa8xbip99vm2d7lxls6j1msbpfdg692girlband66p3zz1y";
  };  

  propagatedBuildInputs = with python3Packages; [ setuptools
                                                ];
  doCheck = false;
  
  meta = with stdenv.lib; {
    description = "Python module for reading Emacs org-mode files";
    homepage = "https://github.com/karlicoss/orgparse";
    license = licenses.asl20;
    maintainers = with maintainers; [ gtrunsec ];
  };

}
