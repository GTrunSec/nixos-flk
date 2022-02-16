{ pkgs }:
{
  #{ fetchurl, runCommand }: {
  buildAppImage =
    {
      pname,
      src,
      version,
      icon,
      categories,
    }:
    let
      image =
        src
        // {
          executable = true;
        };
    in
      pkgs.runCommand pname { } ''
        binDir="$out/bin"
        mkdir -p $binDir
        cat > ''${binDir}/${pname} <<EOF
        #!${pkgs.stdenv.shell}
        ${pkgs.appimage-run}/bin/appimage-run ${image}
        EOF
        chmod +x ''${binDir}/${pname}
        mkdir -p $out/share/applications
        cat > $out/share/applications/${pname}.desktop <<EOF
        [Desktop Entry]
        Type=Application
        Exec=$out/bin/${pname}
        Terminal=false
        Name=${pname}
        Categories=${categories};
        Icon=${icon}
        EOF
      '';
}
