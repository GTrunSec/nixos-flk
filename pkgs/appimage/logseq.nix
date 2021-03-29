{ appimageTools, fetchurl, lib, gsettings-desktop-schemas, gtk3 }:
let
  pname = "logseq";
  version = "0.0.15";
in
appimageTools.wrapType2 rec {
  name = "${pname}-${version}";
  src = fetchurl {
    name = "logseq";
    url = "https://github.com/logseq/logseq/releases/download/${version}/logseq-linux-x64-${version}.AppImage";
    sha256 = "sha256-4mnS2ikDPmIyT4P8zXssk6AVx50C24bsP4WpD5xJbD8=";
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
    description = "A privacy-first, open-source(frontend now, backend later) platform for knowledge sharing and management. Desktop app download link";
  };
}
