let version = "0.0.11";
in
final: prev: {
  discord = prev.discord.overrideAttrs (o: {
    inherit version;
    src = prev.fetchurl {
      url = "https://dl.discordapp.net/apps/linux/${version}/discord-${version}.tar.gz";
      sha256 = "sha256-pHR2HXLuP7f90xrvxEH8WqlTovXcvoww8U++EF/kWOk=";
    };
  });
}
