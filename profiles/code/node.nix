{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nodePackages.mermaid-cli
    nodePackages.create-react-app
    nodePackages.mathjax
    nodePackages.mathjax-node-cli
    nodePackages.prettier
    nodePackages.javascript-typescript-langserver
    nodejs
    yarn
    nodePackages.typescript
    jre
  ];

}
