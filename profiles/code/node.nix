{ pkgs, ... }:
{
        environment.systemPackages = with pkgs; [
                nodePackages.mermaid-cli
                nodePackages.javascript-typescript-langserver
                nodejs
        ];

}
