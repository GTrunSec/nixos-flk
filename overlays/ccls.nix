final: prev: {
  ccls = prev.ccls.overrideAttrs (o: {
    src = prev.fetchFromGitHub{
      owner = "MaskRay";
      repo = "ccls";
      rev = "2ad71f1058cb8079d7a78d35b2dc1af4e282881d";
      sha256 = "sha256-+FiJRQNwCUP+HeT89NDdfKBzXZO805DJQS2bFJRg5Gc=";
    };
  });
}
