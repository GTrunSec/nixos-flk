{ pkgs }: with pkgs; with (import ./build-appimage.nix { inherit pkgs; });
  let
    version = "1.13.0";
  in
buildAppImage {
    name = "ytmdesktop";
    url    = "https://github.com/ytmdesktop/ytmdesktop/releases/download/v${version}/YouTube-Music-Desktop-App-${version}.AppImage";
    sha256 = "sha256-MSO41ty/bSTuw4foim6Qm22VKormKVccOvV/kAHnFxQ=";
    icon   = fetchurl {
      url    = https://raw.githubusercontent.com/ytmdesktop/ytmdesktop/master/src/assets/favicon.256x256.png;
      sha256 = "sha256-ma4lFjDENIintbp3D0P84IWTMRt4VcsvSFaCLlouaEI=";
    };
    categories = "A Desktop App for YouTube Music";

}
