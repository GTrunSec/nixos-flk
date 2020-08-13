self: super:

let packages = super.callPackage ./plugin.nix { };
in {
  nodePackages = super.nodePackages // packages // {
    kepler-gl = packages.package.overrideAttrs (oldAttrs: {
      buildInputs = with super; [ xorg.libX11 nodejs ];
    });
  };
}
