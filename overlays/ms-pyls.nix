self: super: {

  ms-pyls = super.stdenv.mkDerivation rec {
    name = "ms-pyls-${version}";
    version = "0.2";

    # Impossible to build anything offline with dotnet
    src = super.fetchurl {
      url = "https://github.com/GTrunSec/python-language-server/releases/download/donet-build/python-language-server-1-17.tar.gz";
      sha256 = "1hiw0hz7bv0w7pcrpb17gv8zwd6p0nzvjxd9mkqn7fnv5rymqjlj";
    };


    buildInputs = with super; [ unzip makeWrapper ];

    propagatedBuildInputs = with super; [ dotnet-sdk sqlite ];

    preferLocalBuild = true;

    installPhase = ''
      install -dm 755 "$out/opt/ms-pyls"
      cp -r * "$out/opt/ms-pyls"
      makeWrapper "${super.dotnet-sdk}/bin/dotnet" $out/bin/mspyls \
          --prefix LD_LIBRARY_PATH : "${super.stdenv.lib.makeLibraryPath [ super.icu super.openssl ]}" \
          --add-flags "$out/opt/ms-pyls/Microsoft.Python.LanguageServer.dll"
    '';

    meta = with super.stdenv.lib; {
      description = "Microsoft Language Server for Python";
      homepage = "https://github.com/Microsoft/python-language-server";
      platforms = platforms.all;
      license = "Apache-2.0";
    };
  };

}
