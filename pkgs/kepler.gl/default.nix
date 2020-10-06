final: prev:

let packages = prev.callPackage ./plugin.nix { };
in {
  nodePackages = prev.nodePackages // packages // {
    kepler-gl = packages.package.overrideAttrs (oldAttrs: {
      buildInputs = with prev; [ xorg.libX11 nodejs ];
    });
  };
}
