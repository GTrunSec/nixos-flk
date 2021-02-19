{ pkgs }: with pkgs; with (import ./build-appimage.nix { inherit pkgs; });
let
  version = "3.1.1";
in
buildAppImage {
  name = "magnetw";
  url = "https://github.com/xiandanin/magnetW/releases/download/${version}/magnetw-${version}-linux.AppImage";
  sha256 = "sha256-PX4CKv/iMM1dGtExXj8wujpOkBwlr7vSngLfyXY2MLM=";
  icon = fetchurl {
    url = https://raw.githubusercontent.com/xiandanin/magnetW/master/build/icons/icon.ico;
    sha256 = "sha256-2HVPmnPbBnYKpNFh8Ri2CVy3bjI9H5bjrjUjZynW/Dc=";
  };
  categories = "download manager";
}
