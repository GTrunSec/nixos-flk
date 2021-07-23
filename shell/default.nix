{ self, inputs, ... }:
{
  externalModules = with inputs; [
    bud.devshellModules.bud
  ];
  modules = [
    ./devos.nix
    ./devshell.toml
    ./sops-shell.toml
  ];
}

