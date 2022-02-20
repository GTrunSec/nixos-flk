{
  lib,
  fetchurl,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "sudo-pair";
  version = "master";
  src = fetchurl {
    url = "https://github.com/square/sudo_pair/archive/5b572ff19468c807148c77f7d9e052acbd7569d1.tar.gz";
    sha256 = "sha256-of51E6SZtalsoZ8yeNul/L8gNyHmI0ZM88Q0WttzUe8=";
  };

  cargoPatches = [
    ./add-Cargo.lock.patch
  ];

  cargoSha256 = "sha256-tw0biqDMElEeYH9u+w63QtP4T+27Iqt6xhRJj7U+5ms=";

  meta = with lib; {
    homepage = "https://github.com/square/sudo_pair/";
    description = "Plugin for sudo that requires another human to approve and monitor privileged sudo sessions";
    license = licenses.gpl3;
    maintainers = [maintainers.gtrunsec];
    platforms = platforms.linux;
  };
}
