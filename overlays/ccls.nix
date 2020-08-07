final: prev: {
  ccls = prev.ccls.overrideAttrs (o: {
    src = prev.fetchFromGitHub{
      owner = "MaskRay";
      repo = "ccls";
      rev = "bd609e89a29c508c8c763db2ecfad50e207391b3";
      sha256 = "18ik5rzzbwn43dd0ri518i5vzsa5ix81fpcv7gd1s6zdv3nf9bl0";
    };
  });
}
