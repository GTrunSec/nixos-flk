let version = "1.15.75";
in
final: prev: {
  brave = prev.brave.overrideAttrs (o: {
    inherit version;
    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v${version}/brave-browser_${version}_amd64.deb";
      sha256 = "sha256-z6NXS8VPT2KCF/Nh7eirp5GVu2KlGq5cGv2InvAo7Ds=";
    };
  });
}
