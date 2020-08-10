{ pkgs }: with pkgs; with (import ./build-appimage.nix { inherit pkgs; });
buildAppImage {
  name   = "Nuclear";
  url    = https://github.com/nukeop/nuclear/releases/download/v0.6.3/nuclear-fca030.AppImage;
  sha256 = "sha256-SKPbLmO8CmJrbYtex66cY4rVXJQCgTrwu9F9FkDN17I=";
  icon   = fetchurl {
    url    = https://raw.githubusercontent.com/nukeop/nuclear/master/packages/app/resources/media/1024x1024.png;
    sha256 = "sha256-ROsh8UMDGJXW7kngGTfk7dJv8dVrl5FttaQ3k3nDFUA=";
  }; 
  categories = "AudioVideo";
}
