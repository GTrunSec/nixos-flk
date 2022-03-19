{
  self,
  inputs,
  ...
}: {
  modules = with inputs; [];
  exportedModules = [
    inputs.cells-lab.x86_64-linux.update.devshellProfiles.default
    ./devos.nix
    ./devshell.toml
    ./sops-shell.toml
  ];
}
