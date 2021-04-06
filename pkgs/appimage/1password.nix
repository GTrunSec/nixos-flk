{ pkgs }: with pkgs; with (import ./build-appimage.nix { inherit pkgs; });
let
  version = "latest";
in
buildAppImage {
  name = "1password";
  url = "https://downloads.1password.com/linux/appimage/1password-${version}.AppImage";
  sha256 = "sha256-YSzLSuH5bne2XvX3OOtU1vy2kUqi9jE1fpEWJIHwiYo=";
  icon = fetchurl {
    url = https://i.1password.com/media/buttons-and-icons/1password-x-inline-icon.svg;
    hash = "sha256-4Wp7PXhkkhcB4JvMOgWotbyTGnv5MBanPg2vvROmaTQ=";
  };
  categories = "password manager";
}
