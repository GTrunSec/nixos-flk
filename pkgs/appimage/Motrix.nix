{
  pkgs,
  sources,
  ...
}:
with pkgs;
with (import ./build-appimage.nix {inherit pkgs;});
  buildAppImage {
    inherit (sources.motrix) pname src version;
    icon = fetchurl {
      url = https://raw.githubusercontent.com/agalwood/Motrix/master/static/512x512.png;
      sha256 = "sha256-aGBccae981kL3tpfQx4oVXlPNdLRKM6iNGqjY6yAt4Q=";
    };
    categories = "download manager";
  }
