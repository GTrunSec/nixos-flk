let version = "fa6ea259c4dda6cbc2322cc46100ae4f484b9d07";
in
final: prev: {
  i3-gaps = prev.i3-gaps.overrideAttrs (o: rec{
    inherit version;
    src = prev.fetchgit {
      url = "https://github.com/Airblader/i3";
      rev = version;
      sha256 = "sha256-njv63S1t7RuGepBEP2nB3qBcbcKU1od6tZr0RZRMm9s=";
    };
  });
}
