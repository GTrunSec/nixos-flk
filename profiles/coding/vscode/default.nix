{
  pkgs,
  ...
}:
let
  customVscode = (import ./extensions.nix { inherit pkgs; });
in
{
  environment.systemPackages = with pkgs; [
    customVscode
  ];
}
