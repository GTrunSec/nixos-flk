{ pkgs, ... }: 
let
  customVscode = (import ./vscode.nix { inherit pkgs; });
  customJulia = (import ./julia.nix {inherit pkgs;});

in
{
  imports = [ ./texlive-math.nix
              ./go.nix
              ./lib-dep.nix
              ./c++.nix
            ];
  environment.systemPackages = with pkgs; [
    customVscode
    customJulia
  ];
}
