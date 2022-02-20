{pkgs}:
with pkgs;
with (import ./build-appimage.nix {inherit pkgs;}); let
  version = "3.0.1";
in
  buildAppImage {
    pname = "shadowsocks-qt5";
    url = "https://github.com/shadowsocks/shadowsocks-qt5/releases/download/v${version}/Shadowsocks-Qt5-${version}-x86_64.AppImage";
    sha256 = "sha256-5Nhe794JwpsyOTUU6K0YWOT2dk3GuNTaAlU5UhP5O0E=";
    icon = fetchurl {
      url = https://raw.githubusercontent.com/shadowsocks/shadowsocks-qt5/master/src/icons/shadowsocks-qt5.png;
      sha256 = "sha256-xRgO0n2t3RMDgzKXUBvVEFJ94GxMtBRo/ewKZ2Dxd/o=";
    };
    categories = "VPN client";
  }
