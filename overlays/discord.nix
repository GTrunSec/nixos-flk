let version = "0.0.12";
in
final: prev: {
  discord = prev.discord.overrideAttrs (o: {
    inherit version;
    src = prev.fetchurl {
      url = "https://dl.discordapp.net/apps/linux/${version}/discord-${version}.tar.gz";
      sha256 = "sha256-aPLNPDl7XFSxWwjw2HPhTladoCSxLC5WWF+hyxDbP2M=";
    };
  });
}
