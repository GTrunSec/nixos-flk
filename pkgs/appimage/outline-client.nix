{ pkgs }: with pkgs; with (import ./build-appimage.nix { inherit pkgs; });
let
  version = "1.3.0";
in
buildAppImage {
  name = "outline-client";
  url = "https://github.com/Jigsaw-Code/outline-client/releases/download/linux-v${version}/Outline-Client.AppImage";
  sha256 = "sha256-/dMwYMCPgX63bV9FZbhiDPDBysTeq4k2XYIUWBgkVH4=";
  icon = fetchurl {
    url = https://raw.githubusercontent.com/Jigsaw-Code/outline-client/master/resources/electron/icon.png;
    sha256 = "sha256-iTZ2K9aHaLsvwcWJv31G0Pby9bEPhgk8vJMEd8y1ugU=";
  };
  categories = "VPN client";
}
