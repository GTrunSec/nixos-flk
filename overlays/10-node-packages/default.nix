self: super:

let packages = super.callPackage ./plugins.nix { };
in {
  nodePackages = super.nodePackages // packages // {
    # https://github.com/NixOS/nixpkgs/issues/60057#issuecomment-505781308
    mermaid-cli = packages."@mermaid-js/mermaid-cli".overrideAttrs (oldAttrs: {
      nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ])
        ++ [ super.makeWrapper super.which ];

      PUPPETEER_SKIP_CHROMIUM_DOWNLOAD = 1;

      nixpkgsChromePuppeteerConfig = super.writeText "puppeteerConfig.json" ''
        { "executablePath": "${super.chromium}/bin/chromium" }
      '';

      postInstall = (oldAttrs.postInstall or "") + ''
        wrapProgram $out/bin/mmdc --add-flags "-p $nixpkgsChromePuppeteerConfig"
      '';
    });
  };
}
