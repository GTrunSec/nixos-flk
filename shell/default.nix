{
  self,
  inputs,
  ...
}: {
  modules = with inputs; [
    bud.devshellModules.bud
  ];
  exportedModules = [
    ./devos.nix
    ./devshell.toml
    ./sops-shell.toml
  ];
}
