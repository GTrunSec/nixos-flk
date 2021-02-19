{ pkgs }: with pkgs; with (import ./build-appimage.nix { inherit pkgs; });
let
  version = "1.5.15";
in
buildAppImage {
  name = "motrix";
  url = "https://github.com/agalwood/Motrix/releases/download/v${version}/Motrix-${version}.AppImage";
  sha256 = "sha256-/M/x+EFxz+9o/z5gLCoL4UZFnKBdMMT9bZ4ffZF1SyI=";
  icon = fetchurl {
    url = https://raw.githubusercontent.com/agalwood/Motrix/master/static/512x512.png;
    sha256 = "sha256-aGBccae981kL3tpfQx4oVXlPNdLRKM6iNGqjY6yAt4Q=";
  };
  categories = "download manager";
}
