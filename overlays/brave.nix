let version = "1.15.115";
in
final: prev: {
  brave = prev.brave.overrideAttrs (o: {
    inherit version;
    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v${version}/brave-browser_${version}_amd64.deb";
      sha256 = "04zyv5amqxax1z0da4bcgxwsq596zfs416nshg6ffg4ci9nfbiab";
    };
  });
}
