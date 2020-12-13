{ appimageTools, fetchurl, lib, gsettings-desktop-schemas, gtk3 }:

let
  pname = "nteract";
  version = "0.27.0";
in appimageTools.wrapType2 rec {
    name = "${pname}-${version}";
    src = fetchurl {
    name   = "nteract";
    url    = "https://github.com/nteract/nteract/releases/download/v${version}/nteract-${version}.AppImage";
    sha256 = "sha256-toH1sBUtjwSOCYza3GPQ9DqmH45fyxAHoDmlVQf+mow=";
    };

  profile = ''
    export LC_ALL=C.UTF-8
    export XDG_DATA_DIRS=${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:$XDG_DATA_DIRS
  '';

  multiPkgs = null; # no 32bit needed
    extraPkgs = p: (appimageTools.defaultFhsEnvArgs.multiPkgs p) ++ [
    p.gtk3
  ];

  extraInstallCommands = "mv $out/bin/{${name},${pname}}";

  meta = with lib; {
    description = "The interactive computing suite for you";
  };
}
