{
  self,
  inputs,
  ...
}: {
  modules = with inputs; [];
  exportedModules = [
    ./devos.nix
    ./devshell.toml
    ./sops-shell.toml
  ];
}
