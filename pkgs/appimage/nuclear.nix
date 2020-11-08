{ pkgs }: with pkgs; with (import ./build-appimage.nix { inherit pkgs; });
  let
    version = "0.6.6";
  in
    buildAppImage {
      name   = "Nuclear";
      url    = "https://github.com/nukeop/nuclear/releases/download/v${version}/nuclear-v${version}.AppImage";
      sha256 = "sha256-UYc1e0FBjhFSUIZmEYEeRmxvF0w7cNC7yVFFepvjWcs=";
      icon   = fetchurl {
        url    = https://raw.githubusercontent.com/nukeop/nuclear/master/packages/app/resources/media/1024x1024.png;
        sha256 = "sha256-ROsh8UMDGJXW7kngGTfk7dJv8dVrl5FttaQ3k3nDFUA=";
      };
      categories = "AudioVideo";
    }
