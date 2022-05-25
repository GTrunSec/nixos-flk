{pkgs, ...}: {
  environment.systemPackages = with pkgs;
    [
      nodejs
      yarn

      jre
    ]
    ++ (
      with nodePackages; [
        # mermaid-cli
        mathjax
        # mathjax-node-cli
        # TOML formater
      ]
    );
}
