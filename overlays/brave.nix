let version = "1.18.77";
in
final: prev: {
  brave = prev.brave.overrideAttrs (o: {
    inherit version;
    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v${version}/brave-browser_${version}_amd64.deb";
      sha256 = "sha256-AV3bqtWaoy6AVnt8K/Qo+7hguAIsPJPZhgLSeOvJ7JY=";
    };
  });
}
