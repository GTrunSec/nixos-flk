{ pkgs }: with pkgs; with (import ./build-appimage.nix { inherit pkgs; });
buildAppImage {
  inherit (sources.magnetw) pname version src;
  icon = fetchurl {
    url = https://raw.githubusercontent.com/xiandanin/magnetW/master/build/icons/icon.ico;
    sha256 = "sha256-2HVPmnPbBnYKpNFh8Ri2CVy3bjI9H5bjrjUjZynW/Dc=";
  };
  categories = "download manager";
}
