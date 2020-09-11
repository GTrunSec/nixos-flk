{ stdenv
, python3Packages
, python3
, fetchFromGitHub
, callPackage
}:
with python3.pkgs;

let
  orgparse = python3Packages.callPackage ../orgparse {inherit python3Packages;};
  hpi = python3Packages.callPackage ../HPI {inherit python3Packages;};

  mistletoe = python3Packages.buildPythonPackage rec {
    pname = "mistletoe";
    version = "0.7.2";
    src = python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "18z6hqfnfjqnrcgfgl5pkj9ggf9yx0yyy94azcn1qf7hqn6g3l14";
    };
    doCheck = false;
    nativeBuildInputs = with python3Packages; [  ];
    propagatedBuildInputs = with python3Packages; [  ];
  };

  hug = python3Packages.buildPythonPackage rec {
    pname = "hug";
    version = "2.6.1";
    src = python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "1jdfxfgxvz00awpjc8jwz7z59nv5j77nxkn9g4vqf65nmkiarvdh";
    };
    doCheck = false;
    nativeBuildInputs = with python3Packages; [ pytestrunner ];
    propagatedBuildInputs = with python3Packages; [ falcon requests ];
  };

  
  cachew = python3Packages.buildPythonPackage rec {
    pname = "cachew";
    version = "0.7.0";
    src = python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "01fyd7xjf1rnmm37iqa47dp7qzpl1g7cxqq64rxxzsy08lz1p1xi";
    };

    doCheck = false;
    propagatedBuildInputs = with python3Packages; [ sqlalchemy
                                                    setuptools_scm
                                                  ];
  };

  urlextract = python3Packages.buildPythonPackage rec {
    pname = "urlextract";
    version = "1.0.0";
    src = python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "1mlgiixxlidqgmm8z2dkxahr4dx5s0m9fgp65z8nj70h2f7y4z6d";
    };
    doCheck = false;

    propagatedBuildInputs = with python3Packages; [ appdirs
                                                    dnspython
                                                    uritools
                                                    idna
                                                    filelock
                                                  ];
  };

in
python3Packages.buildPythonPackage rec {
  pname = "promnesia";
  version = "0.11.20200605";

  src = fetchFromGitHub {
    owner = "karlicoss";
    repo = pname;
    rev = "1ef741c9f3ee0b193dc0e41ac9c7250fff566dbe";
    sha256 = "sha256-AdXASU3AZcVUJOGH0Nl0wmf29joC7q74knQvcsb4hgM=";
  };

  makeWrapperArgs = [ "--prefix PYTHONPATH : $PYTHONPATH" ];

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
  
  doCheck = false;

  propagatedBuildInputs = with python3Packages; [ pytest
                                                  appdirs
                                                  python_magic
                                                  hug
                                                  tzlocal
                                                  cachew
                                                  urlextract
                                                  orgparse
                                                  logzero
                                                  markdown
                                                  lxml
                                                  beautifulsoup4
                                                  hpi
                                                  mistletoe
                                                ];

}
