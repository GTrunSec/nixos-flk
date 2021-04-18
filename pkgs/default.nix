final: prev:
with prev;
{
  # AppImages
  nteract = callPackage ./appimage/nteract.nix { };
  magnetw = callPackage ./appimage/magnetw.nix { };
  onepassword = callPackage ./appimage/1password.nix { };
  nuclear = callPackage ./appimage/nuclear.nix { };
  ytmdesktop = callPackage ./appimage/ytmdesktop.nix { };
  motrix = callPackage ./appimage/Motrix.nix { };
  outline-client = callPackage ./appimage/outline-client.nix { };


  notdeft = callPackage ./notdeft { };
  chord = callPackage ./appimage/chord.nix { };

  #go packages
  horcrux = callPackage ./go/horcrux { };
  govet = callPackage ./go/govet { };
  got = callPackage ./go/got { };

  #python
  promnesia = callPackage ./python/promnesia { };
  orgparse = callPackage ./python/orgparse { };
  hpi = callPackage ./python/HPI { };
  #rust
  sudo-pair = callPackage ./rust/sudo_pair { };

  # bluez
  firmwareLinuxNonfree = callPackage ./misc/firmware-linux-nonfree.nix { };
}
