{ pkgs, ... }:
{
        environment.systemPackages = with pkgs; [
                nodePackages.mermaid-cli
                nodePackages.create-react-app
                nodePackages.javascript-typescript-langserver
                nodejs
                yarn
        ];

}
