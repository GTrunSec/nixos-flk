final: prev: {
  dropbox = prev.dropbox.overrideAttrs (o: rec{
    runScript = (o.runScript or "") + ''
      export BROWSER=brave
    '';
  });
}
