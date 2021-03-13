let version = "0.105.2";
in
final: prev: {
  adguardhome = prev.adguardhome.overrideAttrs (o: {
    inherit version;
    pname = "adguardhome";
    src = prev.fetchurl {
      url = "https://github.com/AdguardTeam/AdGuardHome/releases/download/v${version}/AdGuardHome_linux_amd64.tar.gz";
      sha256 = "sha256-i4m54tFIPzgwrbS1Fm20fHM9EPsojFcAPF63+JnH6r4=";
    };
  });
}
