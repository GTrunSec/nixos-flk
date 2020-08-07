{ pkgs, ... }: 
let
  customVscode = (import ./vscode.nix { inherit pkgs; });
in
{
  imports = [ ./texlive-math.nix
              ./go.nix
            ];
  environment.systemPackages = with pkgs; [
    customVscode
  ];
}
