{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ];

  environment.systemPackages = with pkgs; [
    rnix-lsp
    (
      pkgs.writeShellScriptBin "repl" ''
        export PATH=${pkgs.coreutils}/bin:${pkgs.nixUnstable}/bin:$PATH
        if [ -z "$1" ]; then
           nix repl --argstr host "$HOST" --argstr flakePath "$PRJ_ROOT" ${./repl.nix}
         else
           nix repl --argstr host "$HOST" --argstr flakePath $(readlink -f $1 | sed 's|/flake.nix||') ${./repl.nix}
         fi
      ''
    )
    nixpkgs-fmt
    alejandra
  ];
}
