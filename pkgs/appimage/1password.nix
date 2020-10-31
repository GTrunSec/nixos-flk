{ pkgs }: with pkgs; with (import ./build-appimage.nix { inherit pkgs; });
  let
    version = "latest";
  in
    buildAppImage {
      name = "1password";
      url = "https://downloads.1password.com/linux/appimage/1password-${version}.AppImage";
      sha256 = "sha256-kIBDofPGYx37KWHZJ9ARHB+/SppcA+cNLX+ED0HU0+k=";
      icon   = fetchurl {
        url    = https://i.1password.com/media/buttons-and-icons/1password-x-inline-icon.svg;
        hash = "sha256-4Wp7PXhkkhcB4JvMOgWotbyTGnv5MBanPg2vvROmaTQ=";
      };
      categories = "password manager";
    }
