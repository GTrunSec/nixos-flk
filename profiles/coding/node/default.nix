{
  pkgs,
  ...
}:
{
  environment.systemPackages =
    with pkgs;
    [
      nodejs
      yarn

      jre
    ]
    ++ (
      with nodePackages; [
        mermaid-cli
        create-react-app
        mathjax
        mathjax-node-cli
        typescript
        # TOML formater
        (
          pkgs.writeShellScriptBin "prettier" ''
            ${prettier}/bin/prettier \
            --plugin-search-dir "${prettier-plugin-toml}/lib" \
            "$@"
          ''
        )
      ]
    );
}
