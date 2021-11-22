final: prev:
with prev;
let
  sources = callPackage ./_sources/generated.nix { } // (callPackage ./_sources_vscode/generated.nix { });

  mkVscodeExtension = extension:
    final.vscode-utils.mkVscodeExtension extension { };

  newPkgsSet = pkgSet:
    let
      prefix = "${pkgSet}-";

      pkgSetBuilder = {
        "vscode-extensions" = mkVscodeExtension;
      }.${pkgSet};
      pkgsInSources = final.lib.mapAttrs' (name: value: final.lib.nameValuePair (final.lib.removePrefix prefix name) (value)) (final.lib.filterAttrs (n: v: final.lib.hasPrefix prefix n) sources);
    in
    final.lib.mapAttrs (n: v: pkgSetBuilder v) pkgsInSources;

in
{
  inherit sources;

  vscode-extensions = prev.vscode-extensions // (newPkgsSet "vscode-extensions");
  # AppImages

  magnetw = callPackage ./appimage/magnetw.nix { };
  motrix = callPackage ./appimage/Motrix.nix { };
  chord = callPackage ./appimage/chord.nix { };

  notdeft = callPackage ./packages/notdeft { };
  StevenBlack-hosts = callPackage ./packages/StevenBlack-hosts { };
  logseq = callPackage ./packages/logseq { electron = final.electron_13; };

  #go packages
  horcrux = callPackage ./go/horcrux { };
  govet = callPackage ./go/govet { };
  got = callPackage ./go/got { };

  #python
  promnesia = pythonPackages.callPackage ./python/promnesia { orgparse = final.orgparse; hpi = final.hpi; };
  orgparse = pythonPackages.callPackage ./python/orgparse { };
  hpi = pythonPackages.callPackage ./python/HPI { };
  #rust
  sudo-pair = callPackage ./rust/sudo_pair { };
}
