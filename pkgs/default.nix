final: prev:
with prev; let
  sources =
    callPackage ./_sources/default/generated.nix {}
    // (callPackage ./_sources/app/generated.nix {})
    // (callPackage ./_sources/vscode/generated.nix {});
in {
  inherit sources;

  vscode-extensions = prev.vscode-extensions // (final.lib.vscodePkgsSet "vscode-extensions" sources);
  # AppImages

  magnetw = callPackage ./appimage/magnetw.nix {};
  motrix = callPackage ./appimage/Motrix.nix {};
  chord = callPackage ./appimage/chord.nix {};

  notdeft = callPackage ./packages/notdeft {};
  StevenBlack-hosts = callPackage ./packages/StevenBlack-hosts {};
  #go packages
  horcrux = callPackage ./go/horcrux {};
  govet = callPackage ./go/govet {};
  got = callPackage ./go/got {};

  #python
  promnesia = python3Packages.callPackage ./python/promnesia {
    orgparse = final.orgparse;
    hpi = final.hpi;
  };
  orgparse = pythonPackages.callPackage ./python/orgparse {};
  hpi = pythonPackages.callPackage ./python/HPI {};
  #rust
  sudo-pair = callPackage ./rust/sudo_pair {};
}
