let version = "1.12.108";
in
final: prev: {
  brave = prev.brave.overrideAttrs (o: {
    inherit version;
    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v${version}/brave-browser_${version}_amd64.deb";
      sha256 = "sha256-4SFNjYfDEwbIQAW7QMygpFQzjoJS6033LyOUfUj6osg=";
    };
  });
}
