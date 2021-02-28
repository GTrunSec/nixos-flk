{ pkgs }: with pkgs; with (import ./build-appimage.nix { inherit pkgs; });
let
  version = "0.2.37";
in
buildAppImage {
  name = "chord";
  url = "https://github.com/PeterDing/chord/releases/download/v${version}/chord-${version}-linux-x86_64.AppImage";
  sha256 = "sha256-TX9mZCWLBT0PhCzR9UOAoq4PpOrvtIVnO3nw6JpIyko=";
  icon = fetchurl {
    url = https://camo.githubusercontent.com/3afcdd69a2055b0c2f8e2cb80bc1471da91ac251112876638fecc43fa1647734/68747470733a2f2f692e6962622e636f2f5477515267434c2f53637265656e2d53686f742d323031392d30342d30362d61742d31302d35352d31302d414d2e706e67;
    sha256 = "sha256-b2Vc0Pi0xn0p53pCR0gJIrqbdaLCm7cCGjFiKGEHRhw=";
  };
  categories = "Chord - A Modern Music Player";
}
