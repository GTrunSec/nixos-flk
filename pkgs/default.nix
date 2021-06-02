final: prev:
with prev;
{
  # AppImages
  nteract = callPackage ./appimage/nteract.nix { };
  magnetw = callPackage ./appimage/magnetw.nix { };
  motrix = callPackage ./appimage/Motrix.nix { };
  chord = callPackage ./appimage/chord.nix { };

  notdeft = callPackage ./packages/notdeft { };


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
