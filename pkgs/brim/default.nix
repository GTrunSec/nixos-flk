{ stdenv, lib, makeWrapper, fetchurl
, dpkg, wrapGAppsHook, autoPatchelfHook
, gtk3, cairo, gnome2, atk, gdk-pixbuf, glib
, at-spi2-atk, dbus, dconf, libX11, libxcb, libXi
, libXcursor, libXdamage, libXrandr, libXcomposite
, libXext, libXfixes, libXrender, libXtst, libXScrnSaver
, nss, nspr, alsaLib, cups, fontconfig, expat
, libudev0-shim, glibc, curl, openssl, libnghttp2, gnome3 }:

stdenv.mkDerivation rec {

  pname = "brim";
  version = "0.18.0";

  # fetching a .deb because there's no easy way to package this Electron app
  src = fetchurl {
    url = "https://github.com/brimsec/brim/releases/download/v${version}/brim_amd64.deb";
    hash = "sha256-AmAoN2bieqgP0Ksce8r3P6hbu0j6IzX+E8aGeGGARFw=";
  };


  buildInputs = [
    gnome3.gsettings_desktop_schemas
    glib
    gtk3
    cairo
    gnome2.pango
    atk
    gdk-pixbuf
    at-spi2-atk
    dbus
    dconf
    libX11
    libxcb
    libXi
    libXcursor
    libXdamage
    libXrandr
    libXcomposite
    libXext
    libXfixes
    libXrender
    libXtst
    libXScrnSaver
    nss
    nspr
    alsaLib
    cups
    fontconfig
    expat
  ];

  nativeBuildInputs = [
    wrapGAppsHook
    autoPatchelfHook
    makeWrapper
    dpkg
  ];

  runtimeLibs = lib.makeLibraryPath [ libudev0-shim glibc curl openssl libnghttp2 ];

  unpackPhase = "dpkg-deb --fsys-tarfile $src | tar -x --no-same-permissions --no-same-owner";

  installPhase = ''
    mkdir -p $out/share/brim
    mkdir -p $out/bin
    mkdir -p $out/lib

    mv usr/lib/brim/* $out/share/brim
    mv $out/share/brim/*.so $out/lib/
    mv usr/share/* $out/share/
    ln -s $out/share/brim/Brim $out/bin/brim

    substituteInPlace $out/share/applications/brim.desktop  \
      --replace "brim %U" "$out/bin/brim $U"

   sed -i "1i##! test dpd" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/frameworks/dpd/__load__.zeek
   sed -i "1i##! test x509" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/files/x509/__load__.zeek
   sed -i "1i##! test files-extract" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/files/extract/__load__.zeek
   sed -i "1i##! test files-hash" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/files/hash/__load__.zeek
   sed -i "1i##! test files-pe" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/files/pe/__load__.zeek
   sed -i "1i##! test analyzer" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/frameworks/analyzer/__load__.zeek
   sed -i "1i##! test cluster" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/frameworks/cluster/__load__.zeek
   sed -i "1i##! test config" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/frameworks/config/__load__.zeek
   sed -i "1i##! test contro" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/frameworks/control/__load__.zeek
   sed -i "1i##! test files" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/frameworks/files/__load__.zeek
   sed -i "1i##! test files-magic" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/frameworks/files/magic/__load__.zeek
   sed -i "1i##! test input" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/frameworks/input/__load__.zeek
   sed -i "1i##! test intel" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/frameworks/intel/__load__.zeek
   sed -i "1i##! test logging" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/frameworks/logging/__load__.zeek
   sed -i "1i##! test logging-postprocessors" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/frameworks/logging/postprocessors/__load__.zeek
   sed -i "1i##! test netcontrol" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/frameworks/netcontrol/__load__.zeek
   sed -i "1i##! test netcontrol-plugins" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/frameworks/netcontrol/plugins/__load__.zeek
   sed -i "1i##! test notice" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/frameworks/notice/__load__.zeek
   sed -i "1i##! test openflow" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/frameworks/openflow/__load__.zeek
   sed -i "1i##! test openflow-plugins" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/frameworks/openflow/plugins/__load__.zeek
   sed -i "1i##! test packet-filter" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/frameworks/packet-filter/__load__.zeek
   sed -i "1i##! test reporter" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/frameworks/reporter/__load__.zeek
   sed -i "1i##! test signatures" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/frameworks/signatures/__load__.zeek
   sed -i "1i##! test software" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/frameworks/software/__load__.zeek
   sed -i "1i##! test sumstats" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/frameworks/sumstats/__load__.zeek
   sed -i "1i##! test sumstats-plugins" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/frameworks/sumstats/plugins/__load__.zeek
   sed -i "1i##! test conn" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/conn/__load__.zeek
   sed -i "1i##! test dce-rpc" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/dce-rpc/__load__.zeek
   sed -i "1i##! test dhcp" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/dhcp/__load__.zeek
   sed -i "1i##! test dnp3" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/dnp3/__load__.zeek
   sed -i "1i##! test dns" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/dns/__load__.zeek
   sed -i "1i##! test ftp" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/ftp/__load__.zeek
   sed -i "1i##! test http" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/http/__load__.zeek
   sed -i "1i##! test http" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/tunnels/__load__.zeek
   sed -i "1i##! test imap" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/imap/__load__.zeek
   sed -i "1i##! test irc" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/irc/__load__.zeek
   sed -i "1i##! test krb" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/krb/__load__.zeek
   sed -i "1i##! test modbus" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/modbus/__load__.zeek
   sed -i "1i##! test mqtt" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/mqtt/__load__.zeek
   sed -i "1i##! test mysql" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/mysql/__load__.zeek
   sed -i "1i##! test ntlm" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/ntlm/__load__.zeek
   sed -i "1i##! test ntp" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/ntp/__load__.zeek
   sed -i "1i##! test pop3" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/pop3/__load__.zeek
   sed -i "1i##! test radius" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/radius/__load__.zeek
   sed -i "1i##! test rdp" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/rdp/__load__.zeek
   sed -i "1i##! test rfb" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/rfb/__load__.zeek
   sed -i "1i##! test sip" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/sip/__load__.zeek
   sed -i "1i##! test smb" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/smb/__load__.zeek
   sed -i "1i##! test smtp" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/smtp/__load__.zeek
   sed -i "1i##! test snmp" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/snmp/__load__.zeek
   sed -i "1i##! test socks" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/socks/__load__.zeek
   sed -i "1i##! test ssh" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/ssh/__load__.zeek
   sed -i "1i##! test ssl" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/ssl/__load__.zeek
   sed -i "1i##! test syslog" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/syslog/__load__.zeek
   sed -i "1i##! test xmpp" $out/share/brim/resources/app/zdeps/zeek/share/zeek/base/protocols/xmpp/__load__.zeek
   sed -i "1i##! test unified2" $out/share/brim/resources/app/zdeps/zeek/share/zeek/policy/files/unified2/__load__.zeek
   sed -i "1i##! test intel-seen" $out/share/brim/resources/app/zdeps/zeek/share/zeek/policy/frameworks/intel/seen/__load__.zeek
   sed -i "1i##! test notice" $out/share/brim/resources/app/zdeps/zeek/share/zeek/policy/frameworks/notice/__load__.zeek
   sed -i "1i##! test barnyard2" $out/share/brim/resources/app/zdeps/zeek/share/zeek/policy/integration/barnyard2/__load__.zeek
   sed -i "1i##! test collective-intel" $out/share/brim/resources/app/zdeps/zeek/share/zeek/policy/integration/collective-intel/__load__.zeek
   sed -i "1i##! test detect-traceroute" $out/share/brim/resources/app/zdeps/zeek/share/zeek/policy/misc/detect-traceroute/__load__.zeek
    '';

  preFixup = ''
    gappsWrapperArgs+=(--prefix LD_LIBRARY_PATH : "${runtimeLibs}" )
  '';

  meta = {
    homepage = "https://github.com/brimsec/brim";
    description = "Desktop application to efficiently search large packet captures and Zeek logs.";
    license = "BSD-3-Clause";
    platforms = stdenv.lib.platforms.linux;
    maintainers = [ stdenv.lib.maintainers.gtrunsec ];
  };

}
