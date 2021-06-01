{ pkgs }: with pkgs; with (import ./build-appimage.nix { inherit pkgs; });
let
  version = "1.6.11";
in
buildAppImage {
  inherit version;
  pname = "motrix";
  src = fetchurl {
    url = "https://github.com/agalwood/Motrix/releases/download/v${version}/Motrix-${version}.AppImage";
    sha256 = "sha256-tE2Q7NM+cQOg+vyqyfRwg05EOMQWhhggTA6S+VT+SkM=";
  };
  icon = fetchurl {
    url = https://raw.githubusercontent.com/agalwood/Motrix/master/static/512x512.png;
    sha256 = "sha256-aGBccae981kL3tpfQx4oVXlPNdLRKM6iNGqjY6yAt4Q=";
  };
  categories = "download manager";
}
