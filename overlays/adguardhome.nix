let version = "0.104.3";
in
final: prev: {
  adguardhome = prev.adguardhome.overrideAttrs (o: {
    inherit version;
    pname = "adguardhome";
    src = prev.fetchurl {
      url = "https://github.com/AdguardTeam/AdGuardHome/releases/download/v${version}/AdGuardHome_linux_amd64.tar.gz";
      sha256 = "sha256-dq4DQ39kD/rMD7AB99piW7VyTlYF9zSY9C+qbUMDxlw=";
    };
  });
}
