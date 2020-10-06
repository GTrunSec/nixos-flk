final: prev:

let packages = prev.callPackage ./plugins.nix { };
in {
  nodePackages = prev.nodePackages // packages // {
    # https://github.com/NixOS/nixpkgs/issues/60057#issuecomment-505781308
    mermaid-cli = packages."@mermaid-js/mermaid-cli".overrideAttrs (oldAttrs: {
      nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ])
        ++ [ prev.makeWrapper prev.which ];

      PUPPETEER_SKIP_CHROMIUM_DOWNLOAD = 1;

      nixpkgsChromePuppeteerConfig = prev.writeText "puppeteerConfig.json" ''
        { "executablePath": "${prev.chromium}/bin/chromium" }
      '';

      postInstall = (oldAttrs.postInstall or "") + ''
        wrapProgram $out/bin/mmdc --add-flags "-p $nixpkgsChromePuppeteerConfig"
      '';
    });
  };
}
