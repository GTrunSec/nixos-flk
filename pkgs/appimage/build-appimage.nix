{ pkgs }:
{
#{ fetchurl, runCommand }: {
  buildAppImage = { name, url, sha256, icon, categories }:
  let
    image = pkgs.fetchurl {
      inherit url sha256;
      executable = true;
    };
  in
    pkgs.runCommand name {} ''
      binDir="$out/bin"
      mkdir -p $binDir
      cat > ''${binDir}/${name} <<EOF
      #!${pkgs.stdenv.shell}
      ${pkgs.appimage-run}/bin/appimage-run ${image}
      EOF
      chmod +x ''${binDir}/${name}
      mkdir -p $out/share/applications
      cat > $out/share/applications/${name}.desktop <<EOF
      [Desktop Entry]
      Type=Application
      Exec=$out/bin/${name}
      Terminal=false
      Name=${name}
      Categories=${categories};
      Icon=${icon}
      EOF
    '';
}
