{
  pkgs,
  lib,
  budUtils,
  ...
}:
{
  bud.cmds = with pkgs; {
    vscode-ext-prefetch = {
      writer = budUtils.writeBashWithPaths [ curl jq ];
      synopsis = "vscode-ext-prefetch |(publisher/name)";
      help = "Prefetch meta for vscode extensions";
      script = ./vscode-ext-prefetch.bash;
    };
  };
}
